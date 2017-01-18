import time

class SpectracomStatus(dict):
    '''Simple class holding a dictionary of status values for a Spectracom
       SecureSync time/frequency server
    '''
    
    ALLOWED_KEYS = ['_statusTime', '_hostName', '_hostResponding',
                    '_timeReference', '_ppsReference', '_ntpStratum',
                    '_inSync', '_oscType', '_oscState', '_tfom', '_maxTfom',
                    '_alarmStatusTime', '_majorAlarm', '_minorAlarm', 
                    '_alarmList', '_disciplineTime', '_dacValue',
                    '_ppsPhaseErr', '_freqErr', '_oscTemp', 'class_version']
    # Class version is required to play nicely with the C++ side using
    # Boost serialization. Keep this version number in sync with that in
    # SpectracomStatus.h.
    CLASS_VERSION = 0
    
    def __init__(self, hostName):
        # _statusTime: timestamp for the status information, seconds since
        # 1970-01-01 00:00:00 UTC
        # This time MUST be floating-point for compatibility with
        # our C++ SpectracomStatus class
        self['_statusTime'] = time.time()
        # _hostName: host name or IP address string for the Spectracom
        self['_hostName'] = hostName
        # _hostResponding: true iff the Spectracom is responding
        self['_hostResponding'] = False
        # _timeReference: string describing current time reference source
        self['_timeReference'] = '----'
        # _timeReference: string describing current 1PPS reference source
        self['_ppsReference'] = '----'
        # _ntpStratum: current NTP stratum
        self['_ntpStratum'] = 99
        # _inSync: true iff Spectracom is currently sync'ed to time and 1PPS
        # references
        self['_inSync'] = False
        # _oscType: type of oscillator installed in the Spectracom
        self['_oscType'] = 'Unknown'
        # _oscState: string describing the current oscillator state
        self['_oscState'] = 'Unknown'
        # _tfom: current time figure-of-merit
        self['_tfom'] = 99
        # _maxTfom: maximum TFOM where 1 PPS will be emitted
        self['_maxTfom'] = 99
        # _alarmStatusTime: timestamp of the latest alarm status report,
        # seconds since 1970-01-01 00:00:00 UTC.
        # This time MUST be floating-point for compatibility with
        # our C++ SpectracomStatus class
        self['_alarmStatusTime'] = 0.0
        # _majorAlarm: true iff a major alarm is active
        self['_majorAlarm'] = False
        # _minorAlarm: true iff a minor alarm is active
        self['_minorAlarm'] = False
        # _alarmList: string with list of currently active alarms separated
        # by newlines
        self['_alarmList'] = ''
        # _disciplineTime: timestamp of the latest discipline report, seconds
        # since 1970-01-01 00:00:00 UTC
        # This is the time which applies to _dacValue, _ppsPhaseErr, _freqErr,
        # and _oscTemp.
        # This time MUST be floating-point for compatibility with
        # our C++ SpectracomStatus class
        self['_disciplineTime'] = 0.0
        # _dacValue: oscillator discipline DAC value
        self['_dacValue'] = 0
        # _ppsPhaseErr: 1 PPS phase error, ns
        self['_ppsPhaseErr'] = 9999999
        # _freqErr: latest frequency error
        self['_freqErr'] = 999.e9
        # _oscTemp: oscillator temperature
        self['_oscTemp'] = 0.0
        # C++ SpectracomStatus class version, needed for interoperability
        # with Boost serialization
        self['class_version'] = self.CLASS_VERSION
        
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

