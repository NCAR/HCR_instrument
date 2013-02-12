/*
 * Cmigits.h
 *
 *  Created on: Jan 7, 2011
 *      Author: burghart
 */

#ifndef CMIGITS_H_
#define CMIGITS_H_

#include <map>
#include <string>
#include <stdint.h>
#include <termios.h>
#include <QMutex>
#include <QObject>
#include <QThread>
#include <QTime>
#include <QTimer>



class Cmigits : public QObject {
    Q_OBJECT
public:
    /**
     * @brief Construct a Cmigits providing access to the C-MIGITS III on 
     * the given serial port.
     * 
     * If special serial port name Cmigits::SIM_DEVICE
     * is used, existence of the C-MIGITS will be simulated.
     * @param ttyDev the name of the serial port connected to the C-MIGITS.
     */
    Cmigits(std::string ttyDev);
    virtual ~Cmigits();

    /**
     * Device name to use when creating a simulation Cmigits.
     */
    static const std::string SIM_DEVICE;
    
    /**
     * @brief Return a string describing the given operating mode number, which
     * must be in the range [1,9].
     * @param mode the operating mode number of interest
     * @return a string describing the given operating mode number
     */
    static const std::string ModeName(uint16_t mode) { return(_ModeNames[mode]); }
    
    /**
     * @brief Return a string describing the given C-MIGITS integer position 
     * figure-of-merit (FOM). The integer must be in the range [1,9].
     * @param pFOM the C-MIGITS integer position figure-of-merit
     * @return a string describing the given C-MIGITS integer position FOM
     */
    static const std::string PositionFOMString(uint16_t pFOM) { return(_PositionFOMStrings[pFOM]); }

    /**
     * @brief Return a string describing the given C-MIGITS integer velocity 
     * figure-of-merit (FOM). The integer must be in the range [1,9].
     * @param vFOM the C-MIGITS integer velocity figure-of-merit
     * @return a string describing the given C-MIGITS integer velocity FOM
     */
    static const std::string VelocityFOMString(uint16_t vFOM) { return(_VelocityFOMStrings[vFOM]); }

    /**
     * @brief Return a string describing the given C-MIGITS integer heading 
     * figure-of-merit (FOM). The integer must be in the range [1,9].
     * @param pFOM the C-MIGITS integer heading figure-of-merit
     * @return a string describing the given C-MIGITS integer heading FOM
     */
    static const std::string HeadingFOMString(uint16_t hFOM) { return(_HeadingFOMStrings[hFOM]); }

    /**
     * @brief Return a string describing the given C-MIGITS integer time 
     * figure-of-merit (FOM). The integer must be in the range [1,9].
     * @param tFOM the C-MIGITS integer time figure-of-merit
     * @return a string describing the given C-MIGITS integer time FOM
     */
    static const std::string TimeFOMString(uint16_t tFOM) { return(_TimeFOMStrings[tFOM]); }

    /**
     * @brief Initialize the C-MIGITS using information obtained from the broadcast IWG1 packets
     * on the aircraft, if possible.
     * @return true iff good IWG1 data were obtained and the initialization process has been
     * started
     */
    bool initializeUsingIwg1();

signals:
    /// @brief Signal emitted when GPS availability changes
    /// @param newValue boolean telling the new state of GPS availability
    void gpsAvailableChanged(bool newValue);
    /// @brief Signal emitted when INS availability changes
    /// @param newValue boolean telling the new state of INS availability
    void insAvailableChanged(bool newValue);
    /// @brief Signal emitted when new 3500 message (System Status) data are
    /// available.
    /// @param dataTime data date/time, msecs since 1970-01-01 00:00:00 UTC
    /// @param currentMode current operating mode
    /// @param insAvailable true iff INS measurements are available
    /// @param gpsAvailable true iff GPS time is valid and at least 4 satellites
    /// are being used
    /// @param doingCoarseAlignment true iff C-MIGITS is in "Coarse Alignment"
    /// submode
    /// @param nSats number of satellites currently tracked
    /// @param positionFOM position figure-of-merit value
    /// @param velocityFOM velocity figure-of-merit value
    /// @param headingFOM heading figure-of-merit value
    /// @param timeFOM time figure-of-merit value
    /// @param expectedHPosError expected error in horizontal position, m
    /// @param expectedVPosError expected error in vertical position, m
    /// @param expectedVelocityError expected error in velocity, m/s
    void new3500Data(uint64_t dataTime, uint16_t currentMode,
            bool insAvailable, bool gpsAvailable, bool doingCoarseAlignment,
            uint16_t nSats, uint16_t positionFOM, uint16_t velocityFOM, 
            uint16_t headingFOM, uint16_t timeFOM, float expectedHPosError, 
            float expectedVPosError, float expectedVelocityError);

    /// @brief Signal emitted when new 3501 message (Navigation Solution) data are
    /// available
    /// @param dataTime data date/time, msecs since 1970-01-01 00:00:00 UTC
    /// @param latitude latitude, deg
    /// @param longitude longitude, deg
    /// @param altitude altitude, m above MSL
    /// @param velNorth north component of velocity, m/s
    /// @param velEast east component of velocity, m/s
    /// @param velUp upward component of velocity, m/s
    void new3501Data(uint64_t dataTime, float latitude, float longitude,
            float altitude, float velNorth, float velEast, float velUp);

    /// @brief Signal emitted when new 3512 message (Flight Control) data are
    /// available
    /// @param dataTime data date/time, msecs since 1970-01-01 00:00:00 UTC
    /// @param pitch pitch, deg
    /// @param roll roll, deg
    /// @param heading heading, deg clockwise from true north
    void new3512Data(uint64_t dataTime, float pitch, float roll, float heading);

private slots:
    /**
     * This slot performs initialization that must happen after the work thread
     * has started.
     */
    void _threadStartInitialize();
    /**
     * Read from the serial line until we get a complete message or we time out.
     * Emit a _readDone() signal when finished.
     */
    void _doRead();
    /**
     * @brief This slot is called when we have waited too long to receive an
     * accept/reject reply to a message we sent. The message will be sent
     * again.
     */
    void _noHandshakeRcvd();
    /**
     * @brief This slot is called when the latest GPS data are considered too
     * old to yield a good navigation solution.
     */
    void _gpsTimedOut();
private:
    /**
     * C-MIGITS III message sync word
     */
    static const uint16_t _MESSAGE_SYNC_WORD = 0x81ff;

    /// @brief Open and configure our tty connection to the C-MIGITS
    void _openTty();

    /// @brief Process data in the _rawData array
    void _processRawData();

    /// @brief Process a C-MIGITS message. The message header checksum and
    /// data checksum should already be verified.
    /// @param msgWords pointer to the words of the message
    /// @param nMsgWords number of 16-bit words in msgWords
    void _processCmigitsMessage(const uint16_t * msgWords, 
            uint16_t nMsgWords);
    /// @brief Process a C-MIGITS response message (Message Acknowledgment/
    /// Acceptance).
    /// @param msgWords pointer to the words of the response message.
    /// The msgWords parameter must point to at least 5 words of valid data.
    void _processResponseMessage(const uint16_t * msgWords);

    /// @brief Process a C-MIGITS 3500 message (System Status).
    /// @param msgWords pointer to the words of the 3500 message
    /// @param nMsgWords the number of words in the 3500 message
    void _process3500Message(const uint16_t * msgWords, uint16_t nMsgWords);

    /// @brief Process a C-MIGITS 3501 message (Navigation Solution).
    /// @param msgWords pointer to the words of the 3501 message
    /// @param nMsgWords the number of words in the 3501 message
    void _process3501Message(const uint16_t * msgWords, uint16_t nMsgWords);

    /// @brief Process a C-MIGITS 3512 message (Flight Control).
    /// @param msgWords pointer to the words of the 3512 message
    /// @param nMsgWords the number of words in the 3512 message
    void _process3512Message(const uint16_t * msgWords, uint16_t nMsgWords);

    /// @brief Process a C-MIGITS 3623 message (Jupiter GPS Timemark).
    /// @param msgWords pointer to the words of the 3623 message
    /// @param nMsgWords the number of words in the 3623 message
    void _process3623Message(const uint16_t * msgWords, uint16_t nMsgWords);

    /// @brief Send a message with the given message id, and containing the
    /// given data.
    /// @param msgId the C-MIGITS message id for the message
    /// @param dataWords a pointer to the data portion of the message.
    /// @param nDataWords the number of 16-bit words contained in dataWords
    /// @param setDisconnectBit if true, the 'disconnect' bit will be set in
    ///     the message header flags (default = false)
    /// @param setConnectBit if true, the 'connect' bit will be set in the
    ///     message header flags (default = false)
    void _sendMessage(uint16_t msgId, const uint16_t * dataWords,
            uint16_t nWords, bool setDisconnectBit = false,
            bool setConnectBit = false);

    /// @brief Tell the C-MIGITS to "connect" (start sending) the specified
    /// message id.
    /// @param msgId the message id which should be connected
    void _sendConnectForMsg(uint16_t msgId);

    /// @brief Tell the C-MIGITS to "disconnect" (stop sending) the specified
    /// message id. If message id is 0, this tells the C-MIGITS to revert to
    /// sending only the default messages.
    /// @param msgId the message id which should be disconnected
    void _sendDisconnectForMsg(uint16_t msgId);

    /**
     * @brief Do actions for the current configuration phase.
     */
    void _doCurrentConfigPhase();

    /// @brief Set serial line speed to the given value, in hopes we will
    /// find the right speed to talk to the C-MIGITS.
    /// @param baudValue the speed_t desired baud rate value from termios.h:
    //  B9600, B19200, B38400, B57600, or B115200.
    void _setBaud(speed_t baudValue);

    /// @brief Return true iff current navigation data is considered good.
    /// This is the case if 1) current mode of the C-MIGITS is either "ground
    /// navigation" or "air navigation", 2) last good GPS data are younger than
    /// _GPS_TIMOUT_SECS seconds old.
    bool _navDataOk();

    /// @brief Return the next legal baud value for the C-MIGITS after the
    /// given value. The returned value is a speed_t from termios.h: B9600,
    /// B19200, B38400, B57600, or B115200.
    ///
    /// The speed returned will be the next one higher than the one given unless
    /// the given value is unknown or is B115200, in which case B9600 will
    /// be returned.
    /// @param baudValue the speed_t value from which to increment. This should
    /// be a value from termios.h: B9600, B19200, B38400, B57600, or B115200.
    static speed_t _NextBaud(speed_t baudValue);

    /// @brief Return a text representation for a speed_t value from termios.h.
    /// E.g., the string "B9600" will be returned for speed_t value B9600.
    /// @param baudValue a speed_t value from termios.h: B9600, B19200, B38400,
    /// B57600, or B115200.
    /// @return a text representation for the given speed_t value.
    static std::string _BaudToText(speed_t baudValue);

    /// @brief Calculate the C-MIGITS checksum for a given series of words
    /// @param words pointer to the array of words to be checksummed
    /// @param nwords number of words to include in the checksum
    static uint16_t _CmigitsChecksum(const uint16_t * words, uint16_t nwords);

    /// @brief Unpack a C-MIGITS 32-bit binary-scaled floating point value.
    ///
    /// The packed value is 32 bits, stored in byte order 4321, where byte
    /// 1 is the most significant, and byte 4 is the lease significant. The
    /// packed value has sign in the most significant bit, and the remaining
    /// bits are a scaled value representing 31 bits to the right of a binary
    /// point. The final value is calculated by multiplying this scaled value by
    /// 2^binaryScaling.
    /// @param words pointer to the 32-bit data
    /// @param binaryScaling the binary scaling to be used in unpacking
    static float _UnpackFloat32(const uint16_t * words, uint16_t binaryScaling);

    /// @brief Unpack a C-MIGITS 64-bit binary-scaled floating point value.
    ///
    /// The packed value is 64 bits, stored in byte order 43218765, where byte
    /// 1 is the most significant, and byte 8 is the least significant. The
    /// packed value has sign in the most significant bit, and the remaining
    /// bits are a scaled value representing 63 bits to the right of a binary
    /// point. The final value is calculated by multiplying this scaled value by
    /// 2^binaryScaling.
    /// @param words pointer to the 64-bit data
    /// @param binaryScaling the binary scaling to be used in unpacking
    static double _UnpackFloat64(const uint16_t * words, uint16_t binaryScaling);

    /// @brief Unpack a C-MIGITS time tag, returning the value as UTC
    /// second-of-day. If the correction from GPS time to UTC time is not yet
    /// initialized, this method will return -1.
    /// @param words pointer to the 4-word location containing the raw time tag
    /// @return time as UTC second-of-day or -1 if correction from GPS time to
    /// UTC time is not yet determined
    double _unpackTimeTag(const uint16_t * words);

    /// @brief Get the next broadcast IWG1 packet and extract lat, lon, alt,
    /// heading, and velocity into local member variables. Return true iff
    /// IWG1 values were obtained.
    /// @param[out] lat latitude from IWG1 packet, deg
    /// @param[out] lon longitude from IWG1 packet, deg
    /// @param[out] alt altitude from IWG1 packet, m MSL
    /// @param[out] tas true airspeed from IWG1 packet, m/s
    /// @param[out] heading heading from IWG1 packet, deg clockwise from true north
    /// @return true iff IWG1 values were obtained.
    bool _getIwg1Info(double * lat, double * lon, double * alt,
            double * tas, double * heading);

    /// @brief Pack a floating point value into C-MIGITS binary-scaled 32-bit
    /// floating point representation at the given destination using the given
    /// binary scaling factor.
    /// @param dest pointer to the destination for the packed value. This must
    /// point to 4 writable bytes.
    /// @param value the floating point value to be packed
    /// @param binaryScaling the binary scaling factor to be used in packing
    static void _PackFloat32(void * dest, float value, uint16_t binaryScaling);


    /// @brief Convert second-of-day to the QDateTime nearest to now with the
    /// same second-of-day.
    /// @param secOfDay the second-of-day value to convert
    /// @return The QDateTime nearest to now with the same second-of-day. Note
    /// that the QDateTime returned will be truncated to the nearest millisecond.
    QDateTime _SecondOfDayToNearestDateTime(double secondOfDay);

    /// Configuration is a multi-stage process, driven by responses from the
    /// C-MIGITS. This type enumerates our configuration phases.
    typedef enum {
        CONFIG_PreInit,             ///< waiting for a 3623 GPS Timemark Message
        CONFIG_GoToInitMode,        ///< putting C-MIGITS into Initialize mode
        CONFIG_EnableDefaultMsgs,   ///< revert to sending default messages
        CONFIG_SetRates,            ///< setting serial line and data message rates
        CONFIG_SensorConfig,        ///< configuring sensor orientation
        CONFIG_Enable3512Msgs,      ///< enable sending of 3512 Flight Control messages
        CONFIG_StartAutoNav,        ///< starting auto-navigation sequence
        CONFIG_Complete             ///< configuration complete
    } ConfigPhase;

    /// Array of C-MIGITS operating mode names indexed by mode number.
    static const std::string _ModeNames[];

    /// Array of C-MIGITS position figure-of-merit (FOM) strings indexed by
    /// FOM integer value.
    static const std::string _PositionFOMStrings[];

    /// Array of C-MIGITS velocity figure-of-merit (FOM) strings indexed by
    /// FOM integer value.
    static const std::string _VelocityFOMStrings[];

    /// Array of C-MIGITS heading figure-of-merit (FOM) strings indexed by
    /// FOM integer value.
    static const std::string _HeadingFOMStrings[];

    /// Array of C-MIGITS time figure-of-merit (FOM) strings indexed by
    /// FOM integer value.
    static const std::string _TimeFOMStrings[];

    /// C-MIGITS header is 5 words long
    static const uint16_t _CMIGITS_HDR_LEN_WORDS = 5;
    static const uint16_t _CMIGITS_HDR_LEN_BYTES = 2 * _CMIGITS_HDR_LEN_WORDS;

    /// Maximum C-MIGITS message length: 5-word header + maximum 128 data
    /// words + 1-word data checksum = 134 words.
    static const uint16_t _CMIGITS_MAX_MSG_LEN_WORDS = 134;
    static const uint16_t _CMIGITS_MAX_MSG_LEN_BYTES = 2 * _CMIGITS_MAX_MSG_LEN_WORDS;

    /// Are we simulating?
    bool _simulate;

    /// Our serial port device name (may be SIM_DEVICE)
    std::string _ttyDev;

    /// Current baud rate for our device. This should always be one of the
    /// speed_t values from termios.h: B9600, B19200, etc.
    speed_t _currentBaud;

    /// File descriptor for the open serial port
    int _fd;

    /// Is the C-MIGITS mounted in right wing/ground configuration?
    /// (For left wing operation, the C-MIGITS is rolled 180 degrees.)
    bool _onRightWing;

    /// Do we want the C-MIGITS set up for air navigation or land?
    bool _useAirNavigation;

    /// Where are we in the configuration?
    ConfigPhase _configPhase;

    /// When did we complete our configuration commands?
    QDateTime _configCompleteTime;

    /// Data read but not yet processed
    uint8_t _rawData[_CMIGITS_MAX_MSG_LEN_BYTES];
    uint16_t _nRawBytes;

    /// How many bytes have we skipped so far looking for _MESSAGE_SYNC_WORD?
    uint32_t _nSkippedForSync;

    /// Size of current incoming message
    uint16_t _curMsgLenBytes;

    /// Message ID for current incoming message
    uint16_t _curMsgId;

    /// Number of 16-bit data words in the current incoming message
    uint16_t _curMsgDataLenWords;

    /// Thread where we'll do all the real work
    QThread _myThread;

    /// Mutex for thread safety when reading/writing members
    QMutex _mutex;

    /// @brief This member is normally -1, but will be set to a message id
    /// value while we are awaiting handshake for that message id.
    int16_t _awaitingHandshake;

    /// @brief Count of consecutive rejections of the same command.
    int16_t _rejectRetryCount;

    /// @brief Zero-interval timer used to schedule a new read whenever the
    /// work thread is not busy
    QTimer * _readTimer;
    
    /// @brief QTimer used to prevent waiting too long for message handshake
    /// reply
    QTimer * _handshakeTimer;

    /// @brief Navigation data will delivered and considered reasonable only if
    /// the most recent GPS fix is younger than this number of seconds.
    static const uint16_t _GPS_TIMEOUT_SECS = 60;

    /// @brief QTimer which expires when good GPS data have been unavailable for
    /// more than _GPS_TIMEOUT_SECS seconds.
    QTimer * _gpsTimeoutTimer;

    /// @brief This is true if the C-MIGITS has not yet reported good GPS data,
    /// or if the latest GPS data are older than _GPS_TIMEOUT_SECS seconds.
    bool _gpsDataTooOld;

    /// @brief Correction factor, in seconds, to convert UTC second of day into
    /// GPS second of day.
    ///
    /// This is the number of leap seconds that have occurred
    /// since the beginning of GPS time.
    /// <p>
    /// GPS second of day = UTC second of day + _utcToGpsCorrection
    /// <p>
    /// It is assumed that a valid correction will always be positive, i.e.,
    /// GPS time is always ahead of UTC time. A negative value is used to
    /// mark _utcToGpsCorrection as uninitialized.
    int16_t _utcToGpsCorrection;

    /// Current operating mode.
    /// 1 = Test
    /// 2 = Initialization
    /// 3 = (Unused)
    /// 4 = Fine Alignment
    /// 5 = Air Alignment
    /// 6 = Transfer Alignment
    /// 7 = Air Navigation
    /// 8 = Land Navigation
    /// 9 = GPS Only
    uint16_t _currentMode;

    /// Is the C-MIGITS getting INS sensor data?
    bool _insAvailable;

    /// Does the C-MIGITS have GPS time and at least 4 satellites?
    bool _gpsAvailable;
};

#endif /* CMIGITS_H_ */
