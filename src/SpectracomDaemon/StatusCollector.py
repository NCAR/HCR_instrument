#!/bin/env Python

### @package StatusCollector
#   Copy log files and obtain status information from a Spectracom SecureSync
#   time/frequency server on a periodic basis.

import os
import logging
from subprocess import Popen, PIPE
import threading
import time
import traceback

logger = logging.getLogger(__name__)

class SpectracomStatus(dict):
    ALLOWED_KEYS = ['HostName', 'HostResponding']
    def __init__(self, hostName):
        self['HostName'] = hostName
        self['HostResponding'] = False
        self['NTPStratum'] = 999
        
    def __setitem__(self, key, value):
        if not key in self.ALLOWED_KEYS:
            raise TypeError, 'Bad key "%s" for SpectracomStatus' % (key)
        return dict.__setitem__(self, key, value)


class StatusCollector:
    ### Copy log files and obtain status information from a Spectracom SecureSync
    #   time/frequency server on a periodic basis.
    #   @param hostName the host name of the Spectracom SecureSync device
    #   @param logDest the destination directory for log files rsync'ed from
    #   the device
    #   @param failureCallback function to be called with an Exception 
    #   argument if the StatusCollector's thread exits.
    def __init__(self, hostName, logDest, failureCallback): 
        # Host name of the Spectracom
        self.hostname = hostName
        
        # destination directory for log files
        self.log_dest = logDest
        
        # function to be called if the thread exits
        self.failureCallback = failureCallback
        
        # Interval between runs of collectStatus
        self.loopIntervalSecs = 30
        
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
        
    def __statusLoop(self):
        try:
            while True:
                startTime = time.time()
                logger.info('loop start at %s', startTime)
                
                self.__rsyncLogs()
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
                
    def __rsyncLogs(self):
        rsyncStartTime = time.time()
        
        # Build the rsync command to copy the current contents of the 
        # Spectracom's log directory into our local destination directory. 
        # Key-based authentication is assumed, so we have rsync use ssh in 
        # BatchMode to force immediate failure if it tries to prompt for a 
        # password.
        rsyncCmd = ['rsync', '-a', '-e', 'ssh -o "BatchMode yes"',
                    'spadmin@%s:log/' % (self.hostname),
                    self.log_dest + '/']
            
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
        newStatus = SpectracomStatus(self.hostname)
        
        # Execute the 'status' command on the Spectracom and parse its
        # output
        p = Popen(['status'], stdout=PIPE, stderr=PIPE, close_fds=True)
        retcode = p.wait()
        if retcode == 0:
            logger.info(p.stdout.read())
        else:
            logger.error(p.stderr.read())
            logger.error("Error executing 'status' on the Spectracom")
        pass
    
 