#!/bin/env Python

### @package StatusCollector
#   Copy log files and obtain status information from a Spectracom SecureSync
#   time/frequency server on a periodic basis.

import calendar
from datetime import datetime
import getpass
from glob import glob
import logging
import os
import pytz
import re
from subprocess import Popen, PIPE
import threading
import time
import traceback

from SpectracomStatus import SpectracomStatus

logger = logging.getLogger(__name__)

class StatusCollector:
    ''' Copy log files and obtain status information from a Spectracom SecureSync
        time/frequency server on a periodic basis.
        @param hostName the host name of the Spectracom SecureSync device
        @param logDest the destination directory for log files rsync'ed from
        the device
        @param failureCallback function to be called with an Exception 
        argument if the StatusCollector's thread exits.
    '''
    def __init__(self, hostName, logDest, failureCallback): 
        # Host name of the Spectracom
        self.hostName = hostName
        
        # destination directory for log files
        self.logDest = logDest
        
        # function to be called if the thread exits
        self.failureCallback = failureCallback
        
        # Interval between runs of collectStatus
        self.loopIntervalSecs = 30
        
        # Start with uninitialized status and create a lock for thread-safe
        # access to the status
        self.latestStatus = SpectracomStatus(self.hostName)
        self.statusLock = threading.Lock()
        
        # Make sure the destination directory exists, creating it if necessary
        if not os.path.exists(logDest):
            try:
                os.mkdir(logDest, 0775)
            except:
                logger.error('Unable to create destination log directory %s', logDest)
                raise
            
        # Make sure we can write to the destination directory
        if not os.access(logDest, os.W_OK):
            msg = 'No write access to destination log directory %s' % (logDest)
            logger.error(msg)
            raise(msg)
        
        # Start our thread which will periodically rsync log files from the
        # Spectracom to the destination directory and generate an object with 
        # current status
        thread = threading.Thread(target=self.__statusLoop)
        thread.daemon = True
        thread.start()
        
    def getLatestStatus(self):
        self.statusLock.acquire()
        status = self.latestStatus
        self.statusLock.release()
        return status
    
    def __setLatestStatus(self, status):
        self.statusLock.acquire()
        self.latestStatus = status
        self.statusLock.release()
        
    def __statusLoop(self):
        '''This is the "main loop" for StatusCollector, which is executed in
           a separate thread. Every self.loopIntervalSecs, this function will
           rsync log files from the Spectracom to our local directory, and will
           collect current status information via commands executed on the 
           Spectracom and via information in the log files.
        '''
        try:
            while True:
                startTime = time.time()
                
                self.__rsyncLogFiles()
                self.__collectStatus()
                
                # Sleep so that loop iterations are loopIntervalSecs seconds
                # apart
                now = time.time()
                sleepTime = (startTime + self.loopIntervalSecs) - now
                if sleepTime >= 0.0:
                    time.sleep(sleepTime)
                else:
                    logger.warning(
                        'Loop took %.2f seconds longer than loop interval of %.2f s', 
                        -sleepTime, self.loopIntervalSecs)
                    logger.warning('Starting next loop immediately')
        except Exception:
            logger.error("Exception in StatusCollector...")
            logger.error(traceback.format_exc())
            # Call the failureCallback function if we were given one
            if self.failureCallback:
                self.failureCallback()

    def __onSshCmdError(self, cmd, errmsg, retcode):
        '''Log an error in executing a system ssh (or ssh-based) command
           @parm cmd a string containing the system command which generated
                 the error
           @parm retCode the return code returned by the command
        '''
        # Log the rsync command's error
        logger.error("Error %d executing command '%s'", retcode, cmd)
        logger.error("...with error msg: %s", errmsg)
        logger.error("(NOTE: Verify that user %s's public key is in the"
                    " authorized_keys file on the Spectracom)"
                    % (getpass.getuser()))
        
    def __rsyncLogFiles(self):
        '''Use 'rsync' to create/update a copy of the Spectracom's log
           directory under local directory self.logDest
        '''
        # Build the rsync command to copy the current contents of the 
        # Spectracom's log directory into our local destination directory. 
        # Key-based authentication is assumed, so we have rsync use ssh in 
        # BatchMode to force immediate failure if it tries to prompt for a 
        # password.
        rsyncCmd = ['rsync', '-a', '-e', 'ssh -o BatchMode=yes',
                    'spadmin@%s:log/' % (self.hostName),
                    self.logDest + '/']
            
        # Execute rsync in a subprocess
        try:
            logger.debug("Executing %s", rsyncCmd)
            p = Popen(rsyncCmd, stdout=PIPE, stderr=PIPE, close_fds=True)
            retcode = p.wait()
            
            if retcode != 0:
                self.__onSshCmdError(' '.join(rsyncCmd), 
                                     p.stderr.read(),
                                     retcode)

        except OSError as e:
            logger.error('Got error: %s' % (e))
            logger.error('when trying to execute %s', rsyncCmd)
    
    def __collectStatus(self):
        newStatus = SpectracomStatus(self.hostName)
        
        # Execute the 'status' command on the Spectracom and parse its
        # output.
        # Key-based authentication is assumed, so we use ssh in BatchMode to
        # force immediate failure if it tries to prompt for a password.
        cmd = ['ssh', '-o BatchMode=yes', 'spadmin@%s' % (self.hostName), 'status']
        p = Popen(cmd, stdout=PIPE, stderr=PIPE, close_fds=True)
        retcode = p.wait()
        if retcode == 0:
            newStatus['_hostResponding'] = True
            # Parse the 'status' output, which looks like:
            #    REF:T=gps0 P=gps0
            #    NTP:Strat=1 SYNC=Y
            #    OSC:OCXO (Trk/Lock)
            #    TFOM=2 MaxTFOM=5
            lines = p.stdout.readlines()

            # Log the output from the 'status' command
            logger.info("'status' command output: %s" % (''.join(lines)))
            
            # parse the REF line
            m = re.match('REF:T=([^ ]*) P=(.*)', lines[0])
            if m:
                newStatus['_timeReference'] = m.group(1)
                newStatus['_ppsReference'] = m.group(2)
            else:
                logger.error('Bad REF line in Spectracom status: %s', lines[0])
            
            # parse the NTP/sync line
            m = re.match('NTP:Strat=([0-9]+) Sync=([NY])', lines[1])
            if m:
                newStatus['_ntpStratum'] = int(m.group(1))
                newStatus['_inSync'] = (m.group(2) == 'Y')
            else:
                logger.error('Bad NTP line in Spectracom status: %s', lines[1])
                
            # parse the OSC:<type> (<state>) line
            m = re.match('OSC:(.*)\s+\(([^\)]*)\)', lines[2])
            if m:
                newStatus['_oscType'] = m.group(1).strip()
                newStatus['_oscState'] = m.group(2).strip()
            else:
                logger.error('Bad OSC line in Spectracom status: %s', lines[2])
                
            # parse the TFOM line
            m = re.match('TFOM=([0-9]*)\s+MaxTFOM=([0-9]*)', lines[3])
            if m:
                newStatus['_tfom'] = int(m.group(1))
                newStatus['_maxTfom'] = int(m.group(2))
            else:
                logger.error('Bad TFOM line in Spectracom status: %s', lines[3])
        else:
            # Log the error executing the 'status' command
            self.__onSshCmdError(' '.join(cmd), 
                                 p.stderr.read(),
                                 retcode)

            # Mark the host as unresponsive and return now
            newStatus['_hostResponding'] = False
            self.__setLatestStatus(newStatus)
            return

        # Get the current alarm state from alarms.log

        # Collect all lines from alarms.log.1 (if it exists) and alarms.log.
        # We get both files in case the latest alarm block spans the two files.
        path = os.path.join(self.logDest, 'alarms.log.1')
        lines = []
        if os.path.exists(path):
            lines += open(path, 'r').readlines()
            
        # list of alarm strings
        alarmList = []

        path = os.path.join(self.logDest, 'alarms.log')
        if not os.path.exists(path):
            # Generate a fake major alarm to note there is no alarms.log file
            newStatus['_majorAlarm'] = True
            alarmList.append('No alarms.log file')
        else:
            lines += open(path, 'r').readlines()
            
            # Get the year from the last modification time of alarms.log.
            # We need it below because the entry timetags in the log file do not
            # include the year...
            logfileYear = datetime.utcfromtimestamp(os.path.getmtime(path)).year
            
            # The alarm log file content looks something like this:
            #    [...]
            #    Jun  5 15:22:18 Spectracom Spectracom: [system] ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            #    Jun  5 15:25:00 Spectracom Spectracom: [system] Frequency Error
            #    Jun  5 15:25:00 Spectracom Spectracom: [system] 1PPS Not In specification
            #    Jun  5 15:25:00 Spectracom Spectracom: [system] ACTIVE ALARMS: MAJOR
            #    Jun  5 15:25:00 Spectracom Spectracom: [system] STATUS CHANGE:
            #    Jun  5 15:25:00 Spectracom Spectracom: [system] ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            #    Jun  5 15:25:01 Spectracom Spectracom: [system] Frequency Error
            #    Jun  5 15:25:01 Spectracom Spectracom: [system] ACTIVE ALARMS: MAJOR
            #    Jun  5 15:25:01 Spectracom Spectracom: [system] STATUS CHANGE:
            #    Jun  5 15:25:01 Spectracom Spectracom: [system] ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            #    Jun  5 15:27:05 Spectracom Spectracom: [system] ACTIVE ALARMS: NONE
            #    Jun  5 15:27:05 Spectracom Spectracom: [system] STATUS CHANGE:
            #    Jun  5 15:27:05 Spectracom Spectracom: [system] ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            #
            # Read through the lines in reverse, collecting the latest alarm
            # description block bounded by "~~~~~~~~" lines
            alarmblock = []
            for line in reversed(lines):
                if re.match('.*\[system\] ~~~~~', line):
                    if len(alarmblock):
                        break
                else:
                    alarmblock.append(line)
            
            if len(alarmblock):
                # Parse out the major/minor alarm state and the alarm names
                for line in alarmblock:
                    # Get the alarm status time from the STATUS CHANGE line.
                    # This is painful, since we want the time as a timestamp,
                    # and Python makes it *very* hard to keep local time zone
                    # from contaminating the conversion to timestamp. The 
                    # calendar.timegm() function seems to be the least evil of 
                    # all the options for the last step.
                    if re.match('.*\[system\] STATUS CHANGE:', line):
                        m = re.match('[^\s]*\s+[^\s]*\s+[^\s]*', line)
                        timeString = m.group(0)
                        # Parse the (yearless) date/time, then set the year
                        # to the year of the logfile (which we obtained above).
                        # All of this is UTC.
                        alarmDatetime = datetime.strptime(timeString, '%b %d %H:%M:%S')\
                            .replace(year=logfileYear)\
                            .replace(tzinfo=pytz.UTC)
                        # Now convert the datetime to the equivalent timestamp
                        # Status time members must explicitly be floating point
                        newStatus['_alarmStatusTime'] = \
                            float(calendar.timegm(alarmDatetime.timetuple()))
                    # Parse ACTIVE ALARMS, which can be: 'NONE', 'MAJOR', 
                    # 'MINOR', or 'MAJOR MINOR'
                    elif re.match('.*\[system\] ACTIVE ALARMS:', line):
                        newStatus['_majorAlarm'] = re.match('.*MAJOR', line) is not None
                        newStatus['_minorAlarm'] = re.match('.*MINOR', line) is not None
                    # Anything else is the name of an alarm condition, which
                    # we add to the list
                    else:
                        m = re.match('.*\[system\] (.*)', line)
                        alarmList.append(m.group(1))
            else:
                # Generate a fake major alarm to note that no alarm block was found
                newStatus['_majorAlarm'] = True
                alarmList.append('No alarm block found')
                
        # Get the latest frequency error from the latest discipline log file,
        # (discstats/discstats.<yyyymmdd>)
        pathList = sorted(glob(os.path.join(self.logDest, 'discstats', 'discstats.*')))
        if not pathList:
            # Generate a fake major alarm to note there are no discstats.* files
            newStatus['_majorAlarm'] = True
            alarmList.append('No discstats/discstats.<yyyymmdd> log files')
        else:
            # Read the last file in the list, which should be the latest.
            #
            # Lines in the file look like:
            #    16597,64349,1,0,gps0,gps0,33896,19,-5.89e-11,45.280785
            # (or for our older unit):
            #    16587,56447,1,0,gps0,gps0,31369,-11,-5.08e-10
            # where the columns are:
            #    1) integer whole days since the epoch (1970-01-01 00:00:00 UTC)
            #    2) integer second of the day
            #    3) 1 if in sync, 0 if not (?)
            #    4) ?
            #    5) string naming the current time reference (may be empty)
            #    6) string naming the current 1 PPS reference (may be empty)
            #    7) integer oscillator discipline DAC value
            #    8) integer 1 PPS phase error in nanoseconds
            #    9) floating point 10 MHz oscillator frequency error in Hz
            #   10) floating point oscillator temperature in deg C (?)
            #
            lines += open(pathList[-1], 'r').readlines()
            # We just look at the last line to get the latest report
            vals = lines[-1].split(',')
            if len(vals) == 9 or len(vals) == 10:
                # Get the time in seconds since 1970-01-01 00:00:00 UTC
                epochSeconds = int(vals[0]) * 86400 + int(vals[1])
                # Status time members must explicitly be floating point
                newStatus['_disciplineTime'] = float(epochSeconds)
                newStatus['_dacValue'] = int(vals[6])
                newStatus['_ppsPhaseErr'] = int(vals[7])
                newStatus['_freqErr'] = float(vals[8])
                if (len(vals)) == 10:
                    newStatus['_oscTemp'] = float(vals[9])
            else:
                logger.error("Bad discipline line: %s" % (lines[-1]))

        # Finally set newStatus['_alarmList'] to a single string with the
        # individual alarm strings joined by newlines
        newStatus['_alarmList'] = '\n'.join(alarmList)
                        
        # Log and save the collected status
        logger.info("=====")
        logger.info("New status at %s:", str(newStatus['_statusTime']))
        for key in newStatus.keys():
            logger.info('    %s: %s', key, newStatus[key])

        self.__setLatestStatus(newStatus)
                