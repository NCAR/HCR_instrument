#!/bin/env Python

### @package StatusCollector
#   Copy log files and obtain status information from a Spectracom SecureSync
#   time/frequency server on a periodic basis.

from datetime import datetime
import logging
import os
import re
from subprocess import Popen, PIPE
import threading
import time
import traceback

logger = logging.getLogger(__name__)

class SpectracomStatus(dict):
    '''Simple class holding a dictionary of status values for a Spectracom
       SecureSync time/frequency server
    '''
    
    ALLOWED_KEYS = ['StatusTime', 'HostName', 'HostResponding', 'Reference', 
                    'NTPStratum', 'NTPSync', 'OscType', 'OscState', 'TFOM', 
                    'MaxTFOM', 'AlarmStatusTime', 'MajorAlarm', 'MinorAlarm', 
                    'AlarmList', 'FreqErrTime', 'FreqErr']
    
    def __init__(self, hostName):
        # StatusTime: datetime for the status information
        self['StatusTime'] = datetime.utcnow()
        # HostName: host name or IP address string for the Spectracom
        self['HostName'] = hostName
        # HostResponding: true iff the Spectracom is responding
        self['HostResponding'] = False
        # Reference: string describing current time and NTP reference sources
        self['Reference'] = 'Unknown'
        # NTPStratum: current NTP stratum
        self['NTPStratum'] = 999
        # NTPSync: true iff NTP is currently sync'ed
        self['NTPSync'] = False
        # OscType: type of oscillator installed in the Spectracom
        self['OscType'] = 'Unknown'
        # OscState: string describing the current oscillator state
        self['OscState'] = 'Unknown'
        # TFOM: current time figure-of-merit
        self['TFOM'] = 999
        # MaxTFOM: maximum TFOM where 1 PPS will be emitted
        self['MaxTFOM'] = 999
        # AlarmStatusTime: datetime of the latest alarm status report
        self['AlarmStatusTime'] = datetime(1970, 1, 1)
        # MajorAlarm: true iff a major alarm is active
        self['MajorAlarm'] = False
        # MinorAlarm: true iff a minor alarm is active
        self['MinorAlarm'] = False
        # AlarmList: list of strings naming currently active alarms
        self['AlarmList'] = []
        # FreqErrTime: datetime of the latest frequency error report
        self['FreqErrTime'] = datetime(1970, 1, 1)
        # FreqErr: latest frequency error
        self['FreqErr'] = 999.e9
        
        # Verify that all valid keys have been initialized
        for k in self.ALLOWED_KEYS:
            if not self.has_key(k):
                raise RuntimeError, 'Value for key %s was not initialized' % (key)
        
    def __setitem__(self, key, value):
        if not key in self.ALLOWED_KEYS:
            raise ValueError, 'Bad key "%s" for SpectracomStatus' % (key)
        return dict.__setitem__(self, key, value)
    
    def __getitem__(self, key):
        if not key in self.ALLOWED_KEYS:
            raise ValueError, 'Bad key "%s" for SpectracomStatus' % (key)
        return dict.__getitem__(self, key)


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
                
    def __rsyncLogFiles(self):
        rsyncStartTime = time.time()
        
        # Build the rsync command to copy the current contents of the 
        # Spectracom's log directory into our local destination directory. 
        # Key-based authentication is assumed, so we have rsync use ssh in 
        # BatchMode to force immediate failure if it tries to prompt for a 
        # password.
        rsyncCmd = ['rsync', '-a', '-e', 'ssh -o "BatchMode yes"',
                    'spadmin@%s:log/' % (self.hostName),
                    self.logDest + '/']
            
        # Execute rsync in a subprocess
        try:
            logger.debug("Executing %s", rsyncCmd)
            p = Popen(rsyncCmd, stdout=PIPE, stderr=PIPE, close_fds=True)
            retcode = p.wait()
            
            if retcode != 0:
                # Log the rsync command's error
                logger.error(p.stderr.read())
                logger.error("Error %d executing command %s", retcode, rsyncCmd)
        except OSError as e:
            logger.error('Got error: %s' % (e))
            logger.error('when trying to execute %s', rsyncCmd)
    
    def __collectStatus(self):
        newStatus = SpectracomStatus(self.hostName)
        
        # Execute the 'status' command on the Spectracom and parse its
        # output
        cmd = ['ssh', 'spadmin@%s' % (self.hostName), 'status']
        p = Popen(cmd, stdout=PIPE, stderr=PIPE, close_fds=True)
        retcode = p.wait()
        if retcode == 0:
            newStatus['HostResponding'] = True
            # Parse the 'status' output, which looks like:
            #    REF: T=gps0 P=gps0
            #    NTP:Strat=1 SYNC=Y
            #    OSC:OCXO (Trk/Lock)
            #    TFOM=2 MaxTFOM=5
            lines = p.stdout.readlines()
            
            # parse the REF line
            m = re.match('REF:(.*)', lines[0])
            if m:
                newStatus['Reference'] = m.group(1)
            else:
                logger.error('Bad REF line in Spectracom status: %s', lines[0])
            
            # parse the NTP line
            m = re.match('NTP:Strat=([0-9]+) Sync=([NY])', lines[1])
            if m:
                newStatus['NTPStratum'] = int(m.group(1))
                newStatus['NTPSync'] = (m.group(2) == 'Y')
            else:
                logger.error('Bad NTP line in Spectracom status: %s', lines[1])
                
            # parse the OSC line
            m = re.match('OSC:(.*)\s+\(([^\)]*)\)', lines[2])
            if m:
                newStatus['OscType'] = m.group(1).strip()
                newStatus['OscState'] = m.group(2).strip()
            else:
                logger.error('Bad OSC line in Spectracom status: %s', lines[2])
                
            # parse the TFOM line
            m = re.match('TFOM=([0-9]*)\s+MaxTFOM=([0-9]*)', lines[3])
            if m:
                newStatus['TFOM'] = int(m.group(1))
                newStatus['MaxTFOM'] = int(m.group(2))
            else:
                logger.error('Bad TFOM line in Spectracom status: %s', lines[3])
        else:
            # Log the error executing the 'status' command
            logger.error(p.stderr.read())
            logger.error("Error executing 'status' on the Spectracom")

        # Get the current alarm state from alarms.log

        # Collect all lines from alarms.log.1 (if it exists) and alarms.log.
        # We get both files in case the latest alarm block spans the two files.
        path = os.path.join(self.logDest, 'alarms.log.1')
        lines = []
        if os.path.exists(path):
            lines += open(path, 'r').readlines()
            
        path = os.path.join(self.logDest, 'alarms.log')
        if not os.path.exists(path):
            # Generate a fake major alarm to note there is no alarms.log file
            newStatus['MajorAlarm'] = True
            newStatus['AlarmList'].append('No alarms.log file')
        else:
            lines += open(path, 'r').readlines()
            
            # Get the year from the last modification time of alarms.log.
            # We need it below because the entry timetags in the log file do not
            # include the year...
            logfileYear = datetime.fromtimestamp(os.path.getmtime(path)).year
            
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
                    # Get the alarm status time from the STATUS CHANGE line
                    if re.match('.*\[system\] STATUS CHANGE:', line):
                        m = re.match('[^\s]*\s+[^\s]*\s+[^\s]*', line)
                        # parse the (yearless) date/time, then set the year
                        # to the year of the logfile (which we obtained above)
                        alarmDatetime = datetime.strptime(m.group(0), 
                                                          '%b %d %H:%M:%S')
                        alarmDatetime = alarmDatetime.replace(year=logfileYear)
                        newStatus['AlarmStatusTime'] = alarmDatetime
                    # Parse ACTIVE ALARMS, which can be: 'NONE', 'MAJOR', 
                    # 'MINOR', or 'MAJOR MINOR'
                    elif re.match('.*\[system\] ACTIVE ALARMS:', line):
                        newStatus['MajorAlarm'] = re.match('.*MAJOR', line) is not None
                        newStatus['MinorAlarm'] = re.match('.*MINOR', line) is not None
                    # Anything else is the name of an alarm condition, which
                    # we add to the list
                    else:
                        m = re.match('.*\[system\] (.*)', line)
                        newStatus['AlarmList'].append(m.group(1))
            else:
                # Generate a fake major alarm to note that no alarm block was found
                newStatus['MajorAlarm'] = True
                newStatus['AlarmList'] += 'No alarm block found'
                
        # Get the latest frequency error from osc.log
        path = os.path.join(self.logDest, 'osc.log')
        if not os.path.exists(path):
            # Generate a fake major alarm to note there is no osc.log file
            newStatus['MajorAlarm'] = True
            newStatus['AlarmList'].append('No osc.log file')
        else:
            lines += open(path, 'r').readlines()
            # Find the latest line like:
            #    Jun  5 22:06:20 Spectracom Spectracom: [system] 2015 156 22:06:20 000 XO1: Frequency error recalculated: 00.000974 (9.745x10^-12)
            # and parse out the frequency error
            m = None
            for line in reversed(lines):
                # Look for a line contaning 'Frequency error recalculated' and
                # pull out the date/time and the frequency error
                m = re.match('.*\[system\] ([^X]*).*Frequency error recalculated:[^\(]*\(([^\)]*)\)', line)
                if m:
                    freqErrTime = datetime.strptime(m.group(1).strip(), '%Y %j %H:%M:%S %f')
                    # Only store the frequency error if its time is less than
                    # twenty minutes old
                    age = datetime.utcnow() - freqErrTime
                    if age.total_seconds() < 20 * 60:
                        newStatus['FreqErrTime'] = freqErrTime
                        # Get the frequency error string, changing AAAx10^BBB
                        # to AAAeBBB before converting to float.
                        freqErrString = m.group(2).replace('x10^', 'e')
                        newStatus['FreqErr'] = float(freqErrString)
                    break
                
                
        # Log and save the collected status
        logger.info("=====")
        logger.info("New status at %s:", str(newStatus['StatusTime']))
        for key in newStatus.keys():
            logger.info('    %s: %s', key, newStatus[key])
        
        self.__setLatestStatus(newStatus)
                