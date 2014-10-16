/*
 * Cmigits.cpp
 *
 *  Created on: Oct 12, 2012
 *      Author: burghart
 */

#include "Cmigits.h"

#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <cstring>
#include <cerrno>
#include <cmath>    // for fmod() and isnan()
#include <ctime>
#include <unistd.h>
#include <stdint.h>
#include <fcntl.h>
#include <arpa/inet.h>
#include <QMutexLocker>
#include <QStringList>
#include <QUdpSocket>
#include <boost/numeric/ublas/matrix.hpp>

using boost::numeric::ublas::matrix;
using boost::numeric::ublas::identity_matrix;
using boost::numeric::ublas::matrix_expression;

#include <logx/Logging.h>

LOGGING("Cmigits")

inline double degToRad(double deg) { return((deg / 180.0) * M_PI); }

class RotationMatrix {
public:
    /// Instantiate an identity RotationMatrix.
    RotationMatrix() :
    _matrix(3, 3) {
        _matrix = identity_matrix<double>(3, 3);
    }
    ~RotationMatrix() {}
    /// Rotate about the x axis by angle degrees. The angle is counterclockwise
    /// as viewed from a point on the positive x axis looking at the origin.
    /// @param angle rotation angle in degrees
    /// @return a reference to this matrix (after the rotation)
    RotationMatrix & rotateAboutX(double angle) {
        double angleRadians = (angle / 180.0) * M_PI;
        double cosAng = cos(angleRadians);
        double sinAng = sin(angleRadians);
        matrix<double> rot(3, 3);
        rot(0, 0) = 1.0;
        rot(0, 1) = 0.0;
        rot(0, 2) = 0.0;

        rot(1, 0) = 0.0;
        rot(1, 1) = cosAng;
        rot(1, 2) = -sinAng;

        rot(2, 0) = 0.0;
        rot(2, 1) = sinAng;
        rot(2, 2) = cosAng;

        matrix<double> newMatrix(boost::numeric::ublas::prod(_matrix, rot));
        _matrix = newMatrix;
        return(*this);
    }
    /// Rotate about the y axis by angle degrees. The angle is counterclockwise
    /// as viewed from a point on the positive y axis looking at the origin.
    /// @param angle rotation angle in degrees
    /// @return a reference to this matrix (after the rotation)
    RotationMatrix & rotateAboutY(double angle) {
        double angleRadians = (angle / 180.0) * M_PI;
        double cosAng = cos(angleRadians);
        double sinAng = sin(angleRadians);
        matrix<double> rot(3, 3);
        rot(0, 0) = cosAng;
        rot(0, 1) = 0.0;
        rot(0, 2) = sinAng;

        rot(1, 0) = 0.0;
        rot(1, 1) = 1.0;
        rot(1, 2) = 0.0;

        rot(2, 0) = -sinAng;
        rot(2, 1) = 0.0;
        rot(2, 2) = cosAng;

        matrix<double> newMatrix(boost::numeric::ublas::prod(_matrix, rot));
        _matrix = newMatrix;
        return(*this);
    }
    /// Rotate about the z axis by angle degrees. The angle is counterclockwise
    /// as viewed from a point on the positive z axis looking at the origin.
    /// @param angle rotation angle in degrees
    /// @return a reference to this matrix (after the rotation)
    RotationMatrix & rotateAboutZ(double angle) {
        double angleRadians = (angle / 180.0) * M_PI;
        double cosAng = cos(angleRadians);
        double sinAng = sin(angleRadians);
        matrix<double> rot(3, 3);
        rot(0, 0) = cosAng;
        rot(0, 1) = -sinAng;
        rot(0, 2) = 0.0;

        rot(1, 0) = sinAng;
        rot(1, 1) = cosAng;
        rot(1, 2) = 0.0;

        rot(2, 0) = 0.0;
        rot(2, 1) = 0.0;
        rot(2, 2) = 1.0;

        matrix<double> newMatrix(boost::numeric::ublas::prod(_matrix, rot));
        _matrix = newMatrix;
        return(*this);
    }
    /// Return the matrix element specified by row and column.
    /// @param row the row number (0-2)
    /// @param column the column number (0-2)
    /// @return the matrix element specified by row and column
    double element(uint16_t row, uint16_t column) {
        assert(row <= 2);
        assert(column <= 2);
        return(_matrix(row, column));
    }
private:
    // row-major rotation matrix
    matrix<double> _matrix;
};

// device name to use for simulated C-MIGITS
const std::string Cmigits::SIM_DEVICE = "SimulatedCmigits";

// Operating mode names, indexed by operating mode value
const std::string Cmigits::_ModeNames[]  = {
        "(Mode 0, Not Used)",
        "Test",
        "Initialization",
        "(Mode 3, Not Used)",
        "Fine Alignment",
        "Air Alignment",
        "Transfer Alignment",
        "Air Navigation",
        "Land Navigation",
        "GPS Only"
};

// Position figure-of-merit strings, indexed by position figure-of-merit integer value
const std::string Cmigits::_PositionFOMStrings[] = {
        "(Invalid)",
        "< 25 m",
        "< 50 m",
        "< 75 m",
        "< 100 m",
        "< 200 m",
        "< 500 m",
        "< 1000 m",
        "< 5000 m",
        ">= 5000 m"
};

// Velocity figure-of-merit strings, indexed by velocity figure-of-merit integer value
const std::string Cmigits::_VelocityFOMStrings[] = {
        "(Invalid)",
        "< 0.2 m/s",
        "< 1 m/s",
        "< 5 m/s",
        "< 25 m/s",
        "< 50 m/s",
        "< 80 m/s",
        "< 150 m/s",
        "< 300 m/s",
        ">= 300 m/s"
};

// Heading figure-of-merit strings, indexed by heading figure-of-merit integer value
const std::string Cmigits::_HeadingFOMStrings[] = {
        "(Invalid)",
        "< 0.5 mrad",
        "< 1 mrad",
        "< 1.73 mrad",
        "< 5 mrad",
        "< 8.66 mrad",
        "< 10 mrad",
        "< 17.3 mrad",
        "< 86.6 mrad",
        ">= 86.6 mrad"
};

// Time figure-of-merit strings, indexed by time figure-of-merit integer value
const std::string Cmigits::_TimeFOMStrings[] = {
        "(Invalid)",
        "< 0.001 µs",
        "< 0.01 µs",
        "< 0.1 µs",
        "< 1 µs",
        "< 10 µs",
        "< 100 µs",
        "< 1000 µs",
        "< 10000 µs",
        ">= 10000 µs"
};

Cmigits::Cmigits(std::string ttyDev, bool useShm) :
                QObject(),
                _simulate(ttyDev == SIM_DEVICE),
                _ttyDev(ttyDev),
                _fd(-1),
                _onRightWing(true),
                _useAirNavigation(true),
                _configPhase(CONFIG_PreInit),
                _configCompleteTime(),
                _nRawBytes(0),
                _nSkippedForSync(0),
                _myThread(),
                _mutex(QMutex::Recursive),
                _awaitingHandshake(-1),
                _rejectRetryCount(0),
                _dataReadyNotifier(0),
                _handshakeTimer(0),
                _gpsTimeoutTimer(0),
                _gpsDataTooOld(true),
                _utcToGpsCorrection(-1),
                _insAvailable(false),
                _gpsAvailable(false),
                _shm(NULL) {
    // Open CmigitsSharedMemory with write access if we're told to use it
    if (useShm) {
        _shm = new CmigitsSharedMemory(true);
    }
    // Much of the implementation for this class assumes local byte ordering is 
    // little-endian. Verify this.
    uint16_t word = 0x0102;
    char * c = reinterpret_cast<char*>(&word);
    if (c[0] != 0x02) {
        ELOG << "BUG: Implementation of class Cmigits only works on " <<
                "little-endian machines, and this machine isn't!";
        abort();
    }

    DLOG << "Instantiating Cmigits on device " << ttyDev;

    // Open the serial port
    if (! _simulate) {
        _openTty();
    }

    // Move affinity to our private thread, so all 'real' work gets done there
    moveToThread(&_myThread);

    // Perform the rest of our initialization from inside our work thread
    connect(&_myThread, SIGNAL(started()), this, SLOT(_threadStartInitialize()));

    _myThread.start();
}

Cmigits::~Cmigits() {
    _myThread.quit();
    if (! _myThread.wait(1000)) {
        ELOG << __PRETTY_FUNCTION__ << ": wait for _myThread termination timed out!";
    }
    delete(_shm);
    delete(_gpsTimeoutTimer);
    delete(_handshakeTimer);
    delete(_dataReadyNotifier);
}

void
Cmigits::_threadStartInitialize() {
    // Create a QSocketNotifier to let us know when data come in from the
    // C-MIGITS. This notifier and the _doRead() slot are how the work of
    // reading data from the C-MIGITS gets done.
    _dataReadyNotifier = new QSocketNotifier(_fd, QSocketNotifier::Read, this);
    connect(_dataReadyNotifier, SIGNAL(activated(int)), this, SLOT(_doRead()));
    _dataReadyNotifier->setEnabled(true);
    ILOG << "DATA READY NOTIFIER CREATED";

    // Create a single-shot timer to limit the time we wait for a handshake 
    // message from the C-MIGITS. The timer is started after we send a
    // message requiring a handshake.
    _handshakeTimer = new QTimer(this);
    _handshakeTimer->setSingleShot(true);
    _handshakeTimer->setInterval(200);  // 200 msec
    // If the timer times out, call _noHandshakeRcvd()
    connect(_handshakeTimer, SIGNAL(timeout()), this, SLOT(_noHandshakeRcvd()));
    ILOG << "HANDSHAKE TIMER CREATED";

    // Build _gpsTimeoutTimer which is used to signal when our most recent GPS
    // data are older than _GPS_TIMEOUT_SECS. Set the timer's thread affinity
    // to _myThread.
    _gpsTimeoutTimer = new QTimer();
    _gpsTimeoutTimer->setInterval(1000 * _GPS_TIMEOUT_SECS);
    _gpsTimeoutTimer->setSingleShot(true);
    // When this timer times out, call _gpsTimedOut()
    connect(_gpsTimeoutTimer, SIGNAL(timeout()), this, SLOT(_gpsTimedOut()));
    ILOG << "GPS TIMER CREATED";
}

void
Cmigits::_openTty() {
    DLOG << "Opening " << _ttyDev;
    if ((_fd = open(_ttyDev.c_str(), O_RDWR)) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error opening " << _ttyDev << ": " <<
                strerror(errno);
        exit(1);
    }

    // Make the port 8 data bits, 1 stop bit, odd parity, "raw"
    struct termios ios;
    if (tcgetattr(_fd, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error getting " << _ttyDev << 
                " attributes: " << strerror(errno);
        exit(1);
    }
    cfmakeraw(&ios);

    // Odd parity
    ios.c_cflag |= PARENB;  // enable parity
    ios.c_cflag |= PARODD;  // use odd parity

    // Set a 0.2 second timeout for reads
    ios.c_cc[VMIN] = 0;
    ios.c_cc[VTIME] = 2;    // 0.2 seconds

    if (tcsetattr(_fd, TCSAFLUSH, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error setting " << _ttyDev << 
                " attributes: " << strerror(errno);
        exit(1);
    }

    // Start at 38400 baud
    _setBaud(B38400);

    DLOG << "Done configuring " << _ttyDev;
}

void
Cmigits::_setBaud(speed_t baudValue) {
    if (baudValue != B9600 && baudValue != B19200 && baudValue != B38400 &&
            baudValue != B57600 && baudValue != B115200) {
        ELOG << __PRETTY_FUNCTION__ << ": bad baud value 0" << std::oct <<
                baudValue << std::dec << " (octal), using B9600";
        baudValue = B9600;
    }
    // Get current settings, change the port speed, and send the new settings.
    struct termios ios;
    if (tcgetattr(_fd, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error getting " << _ttyDev <<
                " attributes: " << strerror(errno);
        exit(1);
    }

    // Change speed if the current speed is not the same as the requested one
    if (cfgetispeed(&ios) == baudValue && cfgetospeed(&ios) == baudValue) {
        DLOG << __PRETTY_FUNCTION__ << ": requested baud rate matches current";
    } else {
        ILOG << "Changing speed on " << _ttyDev << " to " << _BaudToText(baudValue);
        cfsetspeed(&ios, baudValue);

        // Send new I/O settings
        if (tcsetattr(_fd, TCSAFLUSH, &ios) == -1) {
            ELOG << __PRETTY_FUNCTION__ << ": error setting " << _ttyDev <<
                    " attributes: " << strerror(errno);
            exit(1);
        }
    }
    _currentBaud = baudValue;
}

bool
Cmigits::_navDataOk() {
    // Current mode must be "Air Navigation" or "Land Navigation", INS data must
    // be good, and last good GPS fix must be somewhat recent.
    bool modeOk = (_currentMode == 7) || (_currentMode == 8);
    return(modeOk && _insAvailable && ! _gpsDataTooOld);
}

speed_t
Cmigits::_NextBaud(speed_t baudValue) {
    switch (baudValue) {
    case B9600:
        return B19200;
        break;
    case B19200:
        return B38400;
        break;
    case B38400:
        return B57600;
        break;
    case B57600:
        return B115200;
        break;
    case B115200:
        return B9600;
        break;
    default:
        ELOG << __PRETTY_FUNCTION__ << ": unknown current baud value: " <<
            baudValue;
        break;
    }
    // last resort
    return B9600;
}

std::string
Cmigits::_BaudToText(speed_t baudValue) {
    std::string speedTxt("unknown");
    switch (baudValue) {
    case B9600:
        speedTxt = "B9600";
        break;
    case B19200:
        speedTxt = "B19200";
        break;
    case B38400:
        speedTxt = "B38400";
        break;
    case B57600:
        speedTxt = "B57600";
        break;
    case B115200:
        speedTxt = "B115200";
        break;
    }
    return(speedTxt);
}

QDateTime
Cmigits::_SecondOfDayToNearestDateTime(double secondOfDay) {
    static const int SecondsPerDay = 86400;
    static const int SecondsPerHalfDay = SecondsPerDay / 2;
    time_t now = time(0);
    int sysSecondOfDay = now % SecondsPerDay;
    time_t startOfDay = now - sysSecondOfDay;

    // Be very careful around midnight UTC, since our system clock may be 
    // slightly ahead of or slightly behind the times from the C-MIGITS, and
    // hence on a different day. Use the closest day based on the difference
    // in second-of-day.
    double diff = secondOfDay - sysSecondOfDay;
    if (diff > SecondsPerHalfDay) {
        startOfDay -= SecondsPerDay;    // given time is in day previous to system time
    } else if (diff < -SecondsPerHalfDay) {
        startOfDay += SecondsPerDay;    // given time is in day after system time
    }

    // Convert milliseconds since the epoch into a QDateTime
    int millisecondOfDay = int(1000 * secondOfDay);
    qint64 msecsSinceEpoch = qint64(startOfDay) * 1000 + millisecondOfDay;
    QDateTime dateTime(QDateTime::fromTime_t(0).toUTC().addMSecs(msecsSinceEpoch));
    return(dateTime);
}

void 
Cmigits::_doRead() {
    QMutexLocker locker(&_mutex);
    /*
     * Read what's available on the serial port
     */
    int result = read(_fd, _rawData + _nRawBytes, _CMIGITS_MAX_MSG_LEN_BYTES - _nRawBytes);
    if (result < 0) {
        ELOG << __PRETTY_FUNCTION__ << ": read error: " << strerror(errno);
        return;
    }
    _nRawBytes += result;
    /*
     * Process what we can from the data read so far.
     */
    _processRawData();
    return;
}

void
Cmigits::_processRawData() {
    QMutexLocker locker(&_mutex);

    // Look for a message sync word. Generally, it will be at the front
    // of _rawData.
    uint16_t * words = 0;
    while (true) {
        // If we don't have enough bytes for a C-MIGITS header, just
        // return now.
        if (_nRawBytes < _CMIGITS_HDR_LEN_BYTES)
            return;

        // Incoming _rawData is little-endian, so this cast only works properly
        // on little-endian machines! Hence the test above...
        words = reinterpret_cast<uint16_t *>(_rawData);

        // If _rawData starts with the message sync word, we're now in sync
        if (words[0] == _MESSAGE_SYNC_WORD)
            break;

        // Shift data down a byte and try again. Not very efficient, but we
        // shouldn't have to do this often.
        memmove(_rawData, _rawData + 1, _nRawBytes - 1);
        _nRawBytes--;
        _nSkippedForSync++;
        // If we're hunting too long for sync, we're probably at the wrong
        // speed on the serial port. Try a new speed if necessary.
        if (_nSkippedForSync >= _CMIGITS_MAX_MSG_LEN_BYTES) {
            speed_t nextBaud = _NextBaud(_currentBaud);
            ELOG << "No sync word found. Changing speed from " <<
                    _BaudToText(_currentBaud) << " to " << _BaudToText(nextBaud);
            _nSkippedForSync = 0;
            _setBaud(nextBaud);
        }
    }
    if (_nSkippedForSync > 0) {
        ILOG << "C-MIGITS data resynchronized after " << _nSkippedForSync << " bytes";
        _nSkippedForSync = 0;
    }

    // Verify header checksum
    if (_CmigitsChecksum(words, 4) != words[4]) {
        ELOG << "Header checksum error; dropping this header!";
        memmove(_rawData, _rawData + _CMIGITS_HDR_LEN_BYTES, 
                _nRawBytes - _CMIGITS_HDR_LEN_BYTES);
        _nRawBytes -= _CMIGITS_HDR_LEN_BYTES;
        return;
    }

    uint16_t msgId = words[1];
    uint16_t nMsgDataWords = words[2];
    bool headerOnly = (nMsgDataWords == 0);

    // Total message length in bytes is: header length + 
    // (2 * number of data words) + number of data checksum bytes.
    // For a header-only message, there is no data checksum, otherwise the data
    // checksum is two bytes long.
    uint16_t dataChecksumLenBytes = headerOnly ? 0 : 2;
    uint16_t nMsgBytes = _CMIGITS_HDR_LEN_BYTES + 2 * nMsgDataWords + dataChecksumLenBytes;
    uint16_t nMsgWords = nMsgBytes / 2;

    // If we don't have a complete message yet, return now
    if (_nRawBytes < nMsgBytes) {
        return;
    }

    // Verify the data checksum if this is not a header-only message
    bool dataChecksumOk = true;
    if (! headerOnly) {
        uint16_t * dataWords = words + _CMIGITS_HDR_LEN_WORDS;
        uint16_t dataChecksum = _CmigitsChecksum(dataWords, nMsgDataWords);
        dataChecksumOk = (dataChecksum == dataWords[nMsgDataWords]);
    }

    // If the checksum is valid, process the message
    if (dataChecksumOk) {
        _processCmigitsMessage(words, nMsgWords);
    } else {
        ELOG << "Bad data checksum in " << msgId <<
                (headerOnly ? "(header-only)" : "") << " message!";
    }

    // Move any data after the current message to the head of _rawData
    memmove(_rawData, _rawData + nMsgBytes, _nRawBytes - nMsgBytes);
    _nRawBytes -= nMsgBytes;
}


uint16_t
Cmigits::_CmigitsChecksum(const uint16_t * words, uint16_t nwords) {
    int16_t checksum = 0;
    for (int w = 0; w < nwords; w++) {
        checksum -= words[w];
    }
    uint16_t uChecksum = *(reinterpret_cast<uint16_t *>(&checksum));
    return(uChecksum);
}

void
Cmigits::_processCmigitsMessage(const uint16_t * msgWords, uint16_t nMsgWords) {
    // Message ID is in word 1 of the message
    uint16_t msgId = msgWords[1];
    // Response (header-only) messages get separate processing. Other messages
    // are processed based on message ID.
    bool msgIsResponse = (nMsgWords == _CMIGITS_HDR_LEN_WORDS);
    if (msgIsResponse) {
        _processResponseMessage(msgWords);
    } else {
        switch (msgId) {
        case 3500:  // 3500: system status
            _process3500Message(msgWords, nMsgWords);
            break;
        case 3501:  // 3501: navigation solution
            _process3501Message(msgWords, nMsgWords);
            break;
        case 3503:  // 3503: built-in-test results
            ILOG << "Got 3503 message with " << nMsgWords << " words";
            break;
        case 3512:  // 3512: flight control
            _process3512Message(msgWords, nMsgWords);
            break;
        case 3623:  // 3623:
            _process3623Message(msgWords, nMsgWords);
            break;
        default:
            ELOG << "Ignoring unhandled message type " << msgId;
            break;
        }
    }
    return;
}

void
Cmigits::_processResponseMessage(const uint16_t * msgWords) {
    uint16_t msgId = msgWords[1];
    uint16_t flags = msgWords[3];
    bool handshake = flags & (1 << 9);
    bool reject = flags & (1 << 8);
    bool nak = flags & (1 << 10);
    bool ack = flags & (1 << 11);
    std::string handshakeMsg = std::string("HANDSHAKE");
    handshakeMsg += reject ? "(cmd rejected) " : "(cmd accepted) ";
    ILOG << "Got reply message for " << msgWords[1] << ": " <<
            ((flags & (1 << 7)) ? "INVALID " : "") <<
            (handshake ? handshakeMsg : "") <<
            (nak ? "NAK " : "") <<
            (ack ? "ACK " : "") <<
            ((flags & (1 << 12)) ? "(ACK request)" : "");

    // Deal with more configuration after phases which are waiting for response
    // to a message.
    if (msgId != _awaitingHandshake) {
        if (_awaitingHandshake < 0) {
            WLOG << "Got unexpected header-only id " << msgId;
        } else {
            WLOG << "Got header-only id " << msgId << " when expecting " <<
                    _awaitingHandshake;
        }
        return;
    }

    // First response to a command is ACK or NAK. If we got a NAK, we can
    // just try the same command again.
    if (nak) {
        // On NAK of a command, we should not expect the handshake reply.
        _handshakeTimer->stop();
        _awaitingHandshake = -1;
        // Try again
        ILOG << "Re-doing configuration phase " << _configPhase <<
                " after NAK of " << msgId << " command";
        _doCurrentConfigPhase();
    }

    // Second response to a command is a handshake reply telling whether the
    // command was accepted or rejected.
    if (handshake) {
        _handshakeTimer->stop();
        _awaitingHandshake = -1;
        if (reject) {
            // Sometimes a command is rejected because the C-MIGITS is
            // busy reconfiguring from a previous command. Sleep briefly and try
            // the rejected command again (up to 3 times).
            ILOG << msgId << " command rejected in config phase " << _configPhase;
            if (_rejectRetryCount < 3) {
                ILOG << "Sleeping briefly, then retrying config phase " << _configPhase;
                // Sleep for 0.8 seconds. This time was determined empirically
                // for the most common reject case, but feel free to adjust it
                // if it's not long enough.
                usleep(800000);
                _rejectRetryCount++;
                _doCurrentConfigPhase();
            } else {
                ELOG << msgId << " command rejected " << _rejectRetryCount <<
                        "times, aborting!";
                abort();
            }
        } else {
            ILOG << msgId << " command accepted";
            _rejectRetryCount = 0;
            // Command was accepted. Move to the next configuration step.
            _configPhase = ConfigPhase(static_cast<int>(_configPhase) + 1);
            _doCurrentConfigPhase();
        }
    }
}

void
Cmigits::_noHandshakeRcvd() {
    WLOG << "No handshake received for " << _awaitingHandshake <<
            " command. Trying again.";
    _awaitingHandshake = -1;
    _doCurrentConfigPhase();
}

void
Cmigits::_process3500Message(const uint16_t * msgWords, uint16_t nMsgWords) {
    QMutexLocker locker(&_mutex);

    // 3500 message should be exactly 22 words long
    if (nMsgWords != 22) {
        ELOG << "Type 3500 message has " << nMsgWords << " words; expecting 22!";
        return;
    }

    double utcSecondOfDay = _unpackTimeTag(msgWords + 5);
    QDateTime msgTime = _SecondOfDayToNearestDateTime(utcSecondOfDay);

    // current mode
    _currentMode = msgWords[9];

    // If the C-MIGITS is ever in Initialization mode more than 5 seconds after
    // we think we completed configuration, force the configuration process
    // to start again.
    if (_currentMode == 2 && _configPhase == CONFIG_Complete &&
            _configCompleteTime.secsTo(QDateTime::currentDateTime().toUTC()) > 5) {
        ELOG << "C-MIGITS has returned to Initialization mode. Beginning re-configuration.";
        _configPhase = CONFIG_PreInit;
    }

    // system status validity
    uint16_t systemStatusValidity = msgWords[10];

    // "GPS Measurements Available" is bit 0 of system status validity
    bool gpsAvailable = systemStatusValidity & (1 << 0);
    // Act when GPS validity changes
    if (gpsAvailable != _gpsAvailable) {
        _gpsAvailable = gpsAvailable;
        ILOG << "GPS is now " << (_gpsAvailable ? "" : "not ") << "available";
        // Emit a signal when GPS validity changes
        emit(gpsAvailableChanged(_gpsAvailable));
    }

    // If GPS is valid, set the "too old" flag to false, and start (or restart)
    // the GPS data timeout timer.
    if (_gpsAvailable) {
        _gpsDataTooOld = false;
        _gpsTimeoutTimer->start();
    }

    // "INS Measurements Available" is bit 1 of system status validity
    bool insAvailable = systemStatusValidity & (1 << 1);
    // Emit a signal when INS validity changes
    if (insAvailable != _insAvailable) {
        _insAvailable = insAvailable;
        ILOG << "INS is now " << (_insAvailable ? "" : "not ") << "available";
        emit(insAvailableChanged(_insAvailable));
    }

    // Built-in-test failure is indicated in bit 5 of system status validity
    bool bitFailure = systemStatusValidity & (1 << 5);
    if (bitFailure) {
        // Consider this fatal for now
        ELOG << "C-MIGITS built-in test failed!";
        abort();
    }
    
    // "Coarse Alignment" submode is indicated by bit 8 of system status validity
    bool doingCoarseAlignment = systemStatusValidity & (1 << 8);

    // Number of satellites tracked
    uint16_t nSats = msgWords[11];

    // Figure-of-merit (FOM) information. Each figure-of-merit is a 4-bit
    // integer value unpacked from the FOM information word, and each integer
    // value signifies an explicit range for the associated figure-of-merit.
    // See the C-MIGITS documentation for message 3500 for details.
    uint16_t fomInfo = msgWords[14];
    uint16_t positionFOM = (fomInfo >> 0) & 0x0f;
    uint16_t velocityFOM = (fomInfo >> 4) & 0x0f;
    uint16_t headingFOM = (fomInfo >> 8) & 0x0f;
    uint16_t timeFOM = (fomInfo >> 12) & 0x0f;

    // Expected errors
    double hPosError = _UnpackFloat32(msgWords + 15, 15);     // m
    double vPosError = _UnpackFloat32(msgWords + 17, 15);     // m
    double velocityError = _UnpackFloat32(msgWords + 19, 10); // m/s

    // Log status every 5 seconds
    int second = int(round(utcSecondOfDay));
    if ((second % 5) == 0) {
        ILOG << "3500 time: " << msgTime.toString("hh:mm:ss.zzz").toStdString() <<
                ", mode: " << ModeName(_currentMode) <<
                ", GPS: " << _gpsAvailable <<
                ", INS: " << _insAvailable <<
                ", sats tracked: " << nSats;
//        ILOG << "3500 position FOM: " << PositionFOMString(positionFOM) <<
//                ", velocity FOM: " << VelocityFOMString(velocityFOM) <<
//                ", heading FOM: " << HeadingFOMString(headingFOM) <<
//                ", time FOM: " << TimeFOMString(timeFOM);
//        ILOG << "3500 expected errors - h pos: " << hPosError << " m"
//                ", v pos: " << vPosError << " m"
//                ", velocity: " << velocityError << " m/s";
    }

    // Write to shared memory if we have access
    if (_shm) {
        uint64_t msecsSinceEpoch = 1000LL * msgTime.toTime_t() + 
            msgTime.time().msec();
       _shm->storeLatest3500Data(msecsSinceEpoch, _currentMode,
            insAvailable, gpsAvailable, doingCoarseAlignment, nSats,
            positionFOM, velocityFOM, headingFOM, timeFOM,
            hPosError, vPosError, velocityError);
    }
}

void
Cmigits::_gpsTimedOut() {
    if (! _gpsDataTooOld) {
        ILOG << "GPS data are now too old!";
    }
    _gpsDataTooOld = true;
}

void
Cmigits::_process3501Message(const uint16_t * msgWords, uint16_t nMsgWords) {
    QMutexLocker locker(&_mutex);

    if (! _navDataOk())
        return;

    // 3501 message should be exactly 28 words long
    if (nMsgWords != 28) {
        ELOG << "Type 3501 message has " << nMsgWords << " words; expecting 28!";
        return;
    }

    // Unpack time
    double utcSecondOfDay = _unpackTimeTag(msgWords + 5);
    QDateTime msgTime = _SecondOfDayToNearestDateTime(utcSecondOfDay);

    // Unpack latitude, longitude, altitude
    double latitude = 180.0 * _UnpackFloat32(msgWords + 9, 0);
    double longitude = 180.0 * _UnpackFloat32(msgWords + 11, 0);
    double altitude = _UnpackFloat32(msgWords + 13, 15);

// Ignore velocity, since we get it at 100 Hz via 3512 messages
//    // Unpack velocity components
//    double velocityNorth = _UnpackFloat32(msgWords + 15, 10);
//    double velocityEast = _UnpackFloat32(msgWords + 17, 10);
//    double velocityUp = _UnpackFloat32(msgWords + 19, 10);

// Ignore attitude, since we get it at 100 Hz via 3512 messages
//    // Unpack attitude components
//    double pitch = 180.0 * _UnpackFloat32(msgWords + 21, 0);
//    double roll = 180.0 * _UnpackFloat32(msgWords + 23, 0);
//    double heading = 180.0 * _UnpackFloat32(msgWords + 25, 0);

    // Log position every 5 seconds
    int decisecond = int(round(10 * utcSecondOfDay));
    if ((decisecond % 50) == 0) {
        ILOG << "3501 time: " << 
                msgTime.toString("hh:mm:ss.zzz").toStdString() <<
                ", lat: " << latitude << ", lon: " << longitude <<
                ", alt: " << altitude;
    }

    // Write to shared memory if we have access
    if (_shm) {
        uint64_t msecsSinceEpoch = 1000LL * msgTime.toTime_t() + 
            msgTime.time().msec();
        _shm->storeLatest3501Data(msecsSinceEpoch, latitude, longitude,
            altitude);
    }
}

void
Cmigits::_process3512Message(const uint16_t * msgWords, uint16_t nMsgWords) {
    QMutexLocker locker(&_mutex);

    if (! _navDataOk())
        return;

    // 3512 message length is variable, but we configured it to contain only
    // attitude data (6 words) and velocity data (6 words), giving a total
    // message length of 22 words.
    if (nMsgWords != 22) {
        ELOG << "Type 3512 message has " << nMsgWords << " words; expecting 22!";
        return;
    }

    double utcSecondOfDay = _unpackTimeTag(msgWords + 5);
    QDateTime msgTime = _SecondOfDayToNearestDateTime(utcSecondOfDay);

    // Unpack attitude components
    double pitch = 180.0 * _UnpackFloat32(msgWords + 9, 0);
    double roll = 180.0 * _UnpackFloat32(msgWords + 11, 0);
    double heading = 180.0 * _UnpackFloat32(msgWords + 13, 0);

    // Unpack velocity components
    double velNorth = _UnpackFloat32(msgWords + 15, 10);
    double velEast = _UnpackFloat32(msgWords + 17, 10);
    double velUp = _UnpackFloat32(msgWords + 19, 10);

    // Log attitude and velocity every 5 seconds
    int centisecond = int(round(utcSecondOfDay * 100));
    if ((centisecond % 500) == 0) {
        ILOG << "3512 time: " << 
                msgTime.toString("hh:mm:ss.zzz").toStdString() <<
                ", pitch: " << pitch << ", roll: " << roll <<
                ", heading: " << heading << ", vel north: " << velNorth <<
                ", vel east: " << velEast << ", vel up: " << velUp;
    }

    // Write to shared memory if we have access
    if (_shm) {
        uint64_t msecsSinceEpoch = 1000LL * msgTime.toTime_t() + 
            msgTime.time().msec();
        _shm->storeLatest3512Data(msecsSinceEpoch, pitch, roll, heading,
            velNorth, velEast, velUp);
    }
}

void
Cmigits::_process3623Message(const uint16_t * msgWords, uint16_t nMsgWords) {
    QMutexLocker locker(&_mutex);

    // 3623 message should be exactly 123 words long
    if (nMsgWords != 123) {
        ELOG << "Type 3623 message has " << nMsgWords << " words; expecting 123!";
        return;
    }

    // Unpack both raw GPS time of week and UTC time of day in order to
    // calculate _utcToGpsCorrection, which is used by _UnpackTimeTag()
    double gpsSecondOfWeek = _UnpackFloat64(msgWords + 5, 20);
    double utcSecondOfDay = _UnpackFloat64(msgWords + 9, 17);
    // Calculate GPS second-of-day, dealing with day roll-over. We assume that
    // GPS time is always *ahead* of UTC time, which will be true unless they
    // start applying negative leap seconds...
    double gpsSecondOfDay = fmod(gpsSecondOfWeek, 86400);
    if (gpsSecondOfDay < utcSecondOfDay) {
        gpsSecondOfDay += 86400;
    }
    QDateTime msgTime = _SecondOfDayToNearestDateTime(gpsSecondOfDay);

    // Calculate current leap seconds offset between UTC and GPS.
    //
    // We must be careful to round here, since the floating precision of
    // gpsSecondOfWeek and utcSecondOfDay differ. We know the leap second
    // difference will actually be an integer, so round to make sure we get
    // the right value, rather than truncating 15.999999999 to 15!
    _utcToGpsCorrection = int16_t(round(gpsSecondOfDay - utcSecondOfDay));

    double lat = 180.0 * _UnpackFloat32(msgWords + 21, 0);
    double lon = 180.0 * _UnpackFloat32(msgWords + 23, 0);
    double alt = _UnpackFloat32(msgWords + 25, 15);
    DLOG << "3623 lat: " << lat << ", lon: " << lon << ", alt: " << alt <<
            " (" << msgWords[15] << " satellites)";
    // We can start configuration any time after we get the first 3623 message.
    // (See "Commanded Initialization" in the C-MIGITS manual)
    if (_configPhase == CONFIG_PreInit) {
        _configPhase = CONFIG_GoToInitMode;
        _doCurrentConfigPhase();
    }
}

double
Cmigits::_UnpackFloat32(const uint16_t * words, uint16_t binaryScaling) {
    // Get the 32-bit packed value as int32_t
    int32_t packedVal;
    memcpy(&packedVal, words, 4);
    // Apply the binary scaling factor to the packed value
    double val = double(packedVal) / (1UL << (31 - binaryScaling));
    return(val);
}


double
Cmigits::_UnpackFloat64(const uint16_t * words, uint16_t binaryScaling) {
    // int64_t to hold the 64-bit packed value
    int64_t packedVal;
    char * pvPtr = reinterpret_cast<char *>(&packedVal);
    // Data is packed in word order 2143, where word 1 is the most significant 
    // and word 4 is the least significant. Copy the 4 words into packedVal in 
    // little-endian order.
    memcpy(pvPtr, words + 2, 4);
    memcpy(pvPtr + 4, words, 4);
    // Apply the binary scaling factor to the packed value
    double val = double(packedVal) / (1ULL << (63 - binaryScaling));
    return(val);
}

double
Cmigits::_unpackTimeTag(const uint16_t * words) {
    // Return -1 if we don't yet have the UTC to GPS correction value
    if (_utcToGpsCorrection < 0) {
        return -1;
    }
    // Time tag is GPS second of week
    double gpsSecondOfWeek = _UnpackFloat64(words, 20);
    // Convert to GPS second of day, then apply leap seconds correction to
    // get UTC time of day
    double utcSecondOfDay = fmod(gpsSecondOfWeek, 86400) - _utcToGpsCorrection;
    // Correct when we're near the day boundary
    if (utcSecondOfDay < 0) {
        utcSecondOfDay += 86400;
    }

    return(utcSecondOfDay);
}

void
Cmigits::_PackFloat32(void * dest, double value, uint16_t binaryScaling) {
    double fraction = value / (1 << binaryScaling);
    int32_t packedVal = int32_t(fraction * 0x80000000UL);
    memcpy(dest, &packedVal, 4);
}

void
Cmigits::_sendMessage(uint16_t msgId, const uint16_t * dataWords,
        uint16_t nDataWords, bool setDisconnectBit, bool setConnectBit) {
    // Don't send a message if we're waiting for a handshake for a previous
    // message.
    if (_awaitingHandshake >= 0) {
        ELOG << "Awaiting handshake for previous " << _awaitingHandshake <<
                " msg; cannot send " << msgId << " msg.";
        abort();
    }

    // buffer for message contents
    uint16_t msg[_CMIGITS_MAX_MSG_LEN_WORDS];
    memset(msg, 0, sizeof(msg));

    // total message length
    uint16_t msgLenWords = 0;

    // Set up the message header, with request for acknowledgment and
    // handshake. Add connect or disconnect bits that were passed in.
    msg[0] = _MESSAGE_SYNC_WORD;

    msg[1] = msgId;

    msg[2] = dataWords ? nDataWords : 0;    // data word count

    if (setDisconnectBit) {
        msg[3] |= (1 << 5); // flag: disconnect
    }
    if (setConnectBit) {
        msg[3] |= (1 << 6); // flag: connect
    }
    msg[3] |= (1 << 9);     // flag: handshake request
    msg[3] |= (1 << 12);    // flag: ACK request
    msg[3] |= (1 << 15);    // flag: ready

    msg[4] = _CmigitsChecksum(msg, 4);

    msgLenWords = _CMIGITS_HDR_LEN_WORDS;

    // Copy in the data
    memcpy(msg + msgLenWords, dataWords, 2 * nDataWords);
    msgLenWords += nDataWords;

    msg[msgLenWords] = _CmigitsChecksum(dataWords, nDataWords);
    msgLenWords += 1;

    // Send the message
    uint16_t msgLenBytes = 2 * msgLenWords;
    int result = write(_fd, msg, msgLenBytes);
    if (result < 0) {
        ELOG << __PRETTY_FUNCTION__ << ": error writing " <<
                msgId << " message: " << strerror(errno);
    } else if (result != msgLenBytes) {
        ELOG << __PRETTY_FUNCTION__ << ": wrote " << result <<
                " bytes instead of " << msgLenBytes << " for " <<
                msgId << "message";
    } else {
        DLOG << "Sent " << msgLenBytes << "-byte " << msgId << " message";
        // Start the handshake timer so that we will send the message again if
        // no handshake reply is received within a reasonable time.
        _awaitingHandshake = msgId;
        _handshakeTimer->start();
    }
}

void
Cmigits::_sendDisconnectForMsg(uint16_t msgId) {
    ILOG << "Sending disconnect request for message type " << msgId;
    _sendMessage(msgId, 0, 0, true, false);
}

void
Cmigits::_sendConnectForMsg(uint16_t msgId) {
    ILOG << "Sending connect request for message type " << msgId;
    _sendMessage(msgId, 0, 0, false, true);
}

void
Cmigits::_doCurrentConfigPhase() {
    // Buffer for message data, initialized to zeros. We keep a pointer to the
    // data both as uint16_t and int16_t.
    uint16_t udata[_CMIGITS_MAX_MSG_LEN_WORDS];
    int16_t * sdata = reinterpret_cast<int16_t *>(udata);
    memset(udata, 0, sizeof(udata));

    // Current time
    time_t now = time(0);
    struct tm  * now_tm = gmtime(&now);

    // Process the next configuration phase
    ILOG << "Doing configuration phase " << _configPhase << " of " << CONFIG_Complete;

    // Handle the current configuration phase
    switch (_configPhase) {
    case CONFIG_PreInit:
        // Shouldn't happen!
        ELOG << "BUG: entered " << __PRETTY_FUNCTION__ <<
                " while in CONFIG_PreInit state!";
        abort();
        break;
    case CONFIG_GoToInitMode:
        // Create and send a 3510 (Control and Initialization) message to put
        // the C-MIGITS into Initialization mode

        // set data validity bits
        udata[0] |= 1 << 0; // set mode
        // set the mode to 2 -> initialization mode
        udata[1] = 2;       // mode: 2 -> initialization mode

        _sendMessage(3510, udata, 21);
        break;
    case CONFIG_EnableDefaultMsgs:
        // Disconnect for message type 0 causes the C-MIGITS to revert to
        // sending only the default messages.
        _sendDisconnectForMsg(0);
        break;
    case CONFIG_SetRates:
        // Build and send a 3504 message to:
        //      1) set serial communication rate to 115200 bps
        //      2) request that the C-MIGITS generate 3512 (Flight Control)
        //         messages containing aircraft attitude at 100 Hz rate
        //      3) include attitude and velocity data in 3512 messages

        // set data validity bits
        udata[0] |= (1 << 0);		// set host vehicle transmit baud rate
        udata[0] |= (1 << 1);		// set host vehicle receive baud rate
        udata[0] |= (1 << 5);       // set Message 3501 transmit rate
        udata[0] |= (1 << 7);		// set Message 3512 transmit rate
        udata[0] |= (1 << 8);		// set Message 3512 contents

        // set host vehicle baud rates
        udata[1] |= (1 << 0);		// transmit baud rate 1 -> 115200 bps
        udata[1] |= (1 << 8);		// receive baud rate 1 -> 115200 bps

        // set Message Control word
        udata[4] |= (2 << 0);       // Message 3501 transmit rate 2 -> 10 Hz
        udata[4] |= (3 << 4);       // Message 3512 transmit rate 3 -> 100 Hz
        udata[4] |= (1 << 8);       // send attitude in Message 3512
        udata[4] |= (1 << 9);       // send velocity in Message 3512

        // Send the 3504 message
        _sendMessage(3504, udata, 5);
        break;
    case CONFIG_SensorConfig:
        // Build a 3511 message to set the orientation of the C-MIGITS

        // set data validity bits
        udata[0] |= (1 << 0);		// set sensor-to-body transformation

        // Set the sensor-to-body transformation matrix.
        {
            RotationMatrix rotMatrix;
            // The default orientation for the C-MIGITS has the sensor x axis
            // pointing out the nose of the aircraft, the y axis pointing out
            // the right wing, and the z axis pointing down. For any other
            // orientation of the C-MIGITS, a rotation matrix from the default
            // orientation must be provided in order for attitude information
            // (pitch, roll, heading) to be correct.
            //
            // For HCR ground operation or installation on the right wing, the
            // C-MIGITS is physically oriented with the labels on the
            // unit facing zenith and the connectors facing forward. Starting
            // from its default orientation described above, a 180 degree
            // rotation about the sensor x axis followed by a 90 degree
            // rotation about the sensor y axis puts the C-MIGITS in the
            // HCR right-wing orientation.
            rotMatrix.rotateAboutX(180.0);
            rotMatrix.rotateAboutY(90.0);

            // When installed on the left wing, the C-MIGITS is rolled 180
            // degrees from the right wing installation.  This means an
            // additional 180 degree rotation about the sensor z axis.
            if (_onRightWing) {
                ILOG << "RIGHT WING/GROUND configuration";
            } else {
                // Pod is rolled 180 degrees
                rotMatrix.rotateAboutZ(180.0);
                ILOG << "LEFT WING configuration";
            }
            _PackFloat32(&udata[1], rotMatrix.element(0, 0), 1);
            _PackFloat32(&udata[3], rotMatrix.element(0, 1), 1);
            _PackFloat32(&udata[5], rotMatrix.element(0, 2), 1);
            _PackFloat32(&udata[7], rotMatrix.element(1, 0), 1);
            _PackFloat32(&udata[9], rotMatrix.element(1, 1), 1);
            _PackFloat32(&udata[11], rotMatrix.element(1, 2), 1);
            _PackFloat32(&udata[13], rotMatrix.element(2, 0), 1);
            _PackFloat32(&udata[15], rotMatrix.element(2, 1), 1);
            _PackFloat32(&udata[17], rotMatrix.element(2, 2), 1);
        }
        // Send the 3511 message
        _sendMessage(3511, udata, 22);
        break;
    case CONFIG_Enable3512Msgs:
        // Tell the C-MIGITS to start sending 3512 (Flight Control) messages
        _sendConnectForMsg(3512);
        break;
    case CONFIG_StartAutoNav:
    {
        // Set data validity bits
        udata[0] |= 1 << 0;	// set mode
        udata[0] |= 1 << 1;	// set lat/lon/alt
        udata[0] |= 1 << 2;	// set horizontal velocity
        udata[0] |= 1 << 3;	// set date/time data
        udata[0] |= 1 << 4;	// set true heading
        udata[0] |= 1 << 5;	// set auto align/nav sequence data
        udata[0] |= 1 << 6;	// setting auto GPS state

        // Follow automatic mode sequencing, defined by the alignment/navigation
        // word below.
        udata[1] = 0;        // mode: 0 -> automatic mode sequencing

        // Try to get lat, lon, heading, and true airspeed from the IWG1
        // data stream, since knowing current position allows the C-MIGITS
        // GPS to find itself more quickly.
        //
        // If we do not get an IWG1 packet in a short time, just use zeros.
        double iwg1Lat(0.0);    // deg
        double iwg1Lon(0.0);    // deg
        double iwg1Alt(0.0);    // m MSL
        double iwg1Tas(0.0) ;   // true airspeed, m/s
        double iwg1Heading(0.0);// deg clockwise from true north

        bool forceInit = false;
        if (! _getIwg1Info(&iwg1Lat, &iwg1Lon, &iwg1Alt, &iwg1Tas, &iwg1Heading)) {
            WLOG << "No good IWG1 packet obtained.";
            if (forceInit) {
                WLOG << "Initializing using zeros for all IWG1 values";
            } else {
                WLOG << "Returning to CONFIG_PreInit phase";
                _configPhase = CONFIG_PreInit;
                break;
            }
        }
        ILOG << "Configuring C-MIGITS using IWG1 lat: " << iwg1Lat <<
                ", lon: " << iwg1Lon << ", alt: " << iwg1Alt <<
                ", tas: " << iwg1Tas << ", heading: " << iwg1Heading;

        // Position and velocity *have* to be initialized some time after power 
        // up, even if we tell the C-MIGITS to use Auto GPS Initialization.
        // (See "How do I initialize the unit?" in the Frequently Asked 
        // Questions chapter of the C-MIGITS manual.)
        sdata[2] = int16_t(iwg1Lat);                             // lat deg
        sdata[3] = int16_t(fmod(iwg1Lat, 1.0) * 60);             // lat min
        sdata[4] = int16_t(fmod(iwg1Lat, 1.0 / 60.0) * 3600);    // lat sec

        sdata[5] = int16_t(iwg1Lon);                             // lon deg
        sdata[6] = int16_t(fmod(iwg1Lon, 1.0) * 60);             // lon min
        sdata[7] = int16_t(fmod(iwg1Lon, 1.0 / 60.0) * 3600);    // lon sec

        // cast altitude to a 32-bit little-endian integer and copy it
        // into the appropriate data words.
        int32_t intalt(iwg1Alt);
        memcpy(udata + 8, &intalt, 4);

        sdata[10] = 0;   // ground speed m/s
        sdata[11] = 0;   // ground track deg

        // Provide the current time
        udata[12] = now_tm->tm_year - 1900;
        udata[13] = now_tm->tm_yday;
        udata[14] = now_tm->tm_hour;
        udata[15] = now_tm->tm_min;
        udata[16] = now_tm->tm_sec;

        // normalize heading to interval [-180.0, 180.0]
        double heading = iwg1Heading;   // @TODO use user-provided heading for ground ops
        heading = fmod(heading, 360.0);
        if (heading < -180.0) {
            heading += 360.0;
        } else if (heading > 180.0) {
            heading -= 360.0;
        }
        // Convert heading to 16-bit signed integer, in hundredths of a degree.
        // (Value will be in the interval [-18000, 18000])
        sdata[17] = int16_t(rintf(heading * 100));
 
        // Set up alignment/navigation sequence to be used
        // Assume stationary (Fine Alignment) initialization if we're moving
        // less than 2 m/s, otherwise use moving initialization (Air Alignment).
        // NOTE: if the true airspeed is NaN, we assume we're stationary.
        if (isnan(iwg1Tas)) {
            iwg1Tas = 0.0;
            ILOG << "IWG1 true airspeed is NaN, setting to zero!";
        }
        bool stationary = (iwg1Tas < 2.0);
        if (stationary) {
            if (isnan(heading)) {
                WLOG << "Got NaN for IWG1 heading; must have real heading " <<
                    "for stationary initialization";
                WLOG << "Going back to CONFIG_PreInit phase.";
                _configPhase = CONFIG_PreInit;
                break;
            }
            udata[18] |= 4 << 0;    // alignment mode: 4 - fine alignment
        } else {
            udata[18] |= 5 << 0;    // alignment mode: 5 - air alignment
        }

        if (_useAirNavigation) {
            ILOG << "AIR NAVIGATION configuration";
            udata[18] |= 7 << 4;	// auto sequence nav mode: 7 - air navigation
        } else {
            ILOG << "LAND NAVIGATION configuration";
            udata[18] |= 8 << 4; // auto sequence nav mode: 8 - land navigation
        }
        udata[18] |= 1 << 8;	// initialize from GPS when GPS has position

        // Send the 3510 message
        _sendMessage(3510, udata, 21);
        break;
    }
    case CONFIG_Complete:
        ILOG << "C-MIGITS configuration is complete!";
        _configCompleteTime = QDateTime::currentDateTime().toUTC();
        break;
    default:
        ELOG << __PRETTY_FUNCTION__ << ": Unknown configuration phase: " << _configPhase;
        abort();
        break;
    }
}

bool
Cmigits::_getIwg1Info(double * lat, double * lon, double * alt,
        double * tas, double * heading) {
    static const unsigned int Iwg1Port = 7071;
    static const char Iwg1Group[] = "239.0.0.10";
    // Open a UDP socket on the IWG1 port (7071)
    QUdpSocket socket;
    socket.bind(Iwg1Port, QUdpSocket::ShareAddress);

    // Before Qt 4.8, we need to do the work below to join a multicast group
    // With Qt 4.8, all of this will become:
    //     socket.joinMulticastGroup(QHostAddress(Iwg1Group));
    int socketFd = socket.socketDescriptor();
    ip_mreq mreq;
    memset(&mreq, 0, sizeof(ip_mreq));
    mreq.imr_multiaddr.s_addr = inet_addr(Iwg1Group); // multicast group
    mreq.imr_interface.s_addr = htons(INADDR_ANY);
    if (setsockopt(socketFd, IPPROTO_IP, IP_ADD_MEMBERSHIP, (char *)&mreq,
            sizeof(mreq)) < 0) {
        ELOG << __PRETTY_FUNCTION__ << ": error joining multicast group" <<
                Iwg1Group;
        return(false);
    }

    // Wait up to two seconds for an IWG1 packet to arrive. Return false if
    // no packet arrives.
    if (! socket.waitForReadyRead(2000)) {
        ELOG << "Timeout waiting for IWG1 packet";
        return(false);
    }

    // Read the pending packet
    int pktLen = socket.pendingDatagramSize();
    QByteArray datagram(pktLen, 0);
    if (socket.readDatagram(datagram.data(), pktLen) < 0) {
        ELOG << __PRETTY_FUNCTION__ << ": readDatagram error";
        return(false);
    }

    // Unpack the pieces we want from the packet
    ILOG << "Got IWG1 datagram: " << datagram.data();
    QStringList tokens = QString(datagram).split(",");
    if (tokens[0] != "IWG1" || tokens.size() < 14) {
        WLOG << "Bad IWG1 packet: '" << QString(datagram).toStdString() << "'";
        return(false);
    }

    bool ok;
    double latVal, lonVal, altVal, tasVal, headingVal;

    latVal = tokens[2].toDouble(&ok);
    if (! ok) {
        WLOG << "Bad lat '" << tokens[2].toStdString() << "' in IWG1 packet!";
        return(false);
    }

    lonVal = tokens[3].toDouble(&ok);
    if (! ok) {
        WLOG << "Bad lon '" << tokens[3].toStdString() << "' in IWG1 packet!";
        return(false);
    }

    altVal = tokens[4].toDouble(&ok);
    if (! ok) {
        WLOG << "Bad alt '" << tokens[4].toStdString() << "' in IWG1 packet!";
        return(false);
    }

    tasVal = tokens[9].toDouble(&ok);
    if (! ok) {
        WLOG << "Bad true airspeed '" << tokens[9].toStdString() << "' in IWG1 packet!";
        return(false);
    }

    headingVal = tokens[13].toDouble();
    if (! ok) {
        WLOG << "Bad heading '" << tokens[13].toStdString() << "' in IWG1 packet!";
        return(false);
    }

    // OK, we have good values. Copy them to the return arguments.
    *lat = latVal;
    *lon = lonVal;
    *alt = altVal;
    *tas = tasVal;
    *heading = headingVal;
    return(true);
}

bool Cmigits::initializeUsingIwg1() {
    _configPhase = CONFIG_PreInit;
    return(true);
}
