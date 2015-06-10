from datetime import datetime

class SpectracomStatus(dict):
    '''Simple class holding a dictionary of status values for a Spectracom
       SecureSync time/frequency server
    '''
    
    ALLOWED_KEYS = ['_statusTime', '_hostName', '_hostResponding', '_reference', 
                    '_ntpStratum', '_inSync', '_oscType', '_oscState', '_tfom', 
                    '_maxTfom', '_alarmStatusTime', '_majorAlarm', '_minorAlarm', 
                    '_alarmList', '_freqErrTime', '_freqErr']
    
    def __init__(self, hostName):
        # _statusTime: datetime for the status information
        self['_statusTime'] = datetime.utcnow()
        # _hostName: host name or IP address string for the Spectracom
        self['_hostName'] = hostName
        # _hostResponding: true iff the Spectracom is responding
        self['_hostResponding'] = False
        # _reference: string describing current time and NTP reference sources
        self['_reference'] = 'Unknown'
        # _ntpStratum: current NTP stratum
        self['_ntpStratum'] = 999
        # _inSync: true iff Spectracom is currently sync'ed to time and 1PPS
        # references
        self['_inSync'] = False
        # _oscType: type of oscillator installed in the Spectracom
        self['_oscType'] = 'Unknown'
        # _oscState: string describing the current oscillator state
        self['_oscState'] = 'Unknown'
        # TFOM: current time figure-of-merit
        self['_tfom'] = 999
        # MaxTFOM: maximum TFOM where 1 PPS will be emitted
        self['_maxTfom'] = 999
        # Alarm_statusTime: datetime of the latest alarm status report
        self['_alarmStatusTime'] = datetime(1970, 1, 1)
        # MajorAlarm: true iff a major alarm is active
        self['_majorAlarm'] = False
        # MinorAlarm: true iff a minor alarm is active
        self['_minorAlarm'] = False
        # AlarmList: list of strings naming currently active alarms
        self['_alarmList'] = []
        # FreqErrTime: datetime of the latest frequency error report
        self['_freqErrTime'] = datetime(1970, 1, 1)
        # FreqErr: latest frequency error
        self['_freqErr'] = 999.e9
        
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

