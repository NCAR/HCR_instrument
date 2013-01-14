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
#include <cmath>    // for fmod()
#include <ctime>
#include <unistd.h>
#include <stdint.h>
#include <fcntl.h>
#include <QMutexLocker>
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

Cmigits::Cmigits(std::string ttyDev) :
                QObject(),
                _simulate(ttyDev == SIM_DEVICE),
                _ttyDev(ttyDev),
                _fd(-1),
                _onRightWing(true),
                _useAirNavigation(false),
                _initPhase(INIT_PreInit),
                _initCompleteTime(),
                _nRawBytes(0),
                _nSkippedForSync(0),
                _myThread(),
                _mutex(QMutex::Recursive),
                _awaitingHandshake(-1),
                _rejectRetryCount(0),
                _readTimer(),
                _handshakeTimer(),
                _gpsTimeoutTimer(),
                _gpsDataTooOld(true),
                _utcToGpsCorrection(-1),
                _insAvailable(false),
                _gpsAvailable(false) {
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
    delete(_gpsTimeoutTimer);
    delete(_handshakeTimer);
    delete(_readTimer);
    _myThread.quit();
    if (! _myThread.wait(1000)) {
        ELOG << __PRETTY_FUNCTION__ << ": wait for _myThread termination timed out!";
    }
}

void
Cmigits::_threadStartInitialize() {
    // Create a zero-interval timer to schedule a read whenever our thread
    // is not busy doing something else. This timer and the _doRead() slot
    // are how the work of reading data from the C-MIGITS gets done.
    _readTimer = new QTimer();
    _readTimer->setInterval(0);
    connect(_readTimer, SIGNAL(timeout()), this, SLOT(_doRead()));
    ILOG << "READ TIMER CREATED";
    _readTimer->start();
    ILOG << "READ TIMER STARTED";

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
     * Set up to check _fd file descriptor
     */
    fd_set readFds;
    FD_ZERO(&readFds);
    FD_SET(_fd, &readFds);

    /*
     * Set up timeval structure for select timeout
     */
    uint16_t timeoutMsecs = 100;
    struct timeval wait;
    wait.tv_sec = timeoutMsecs / 1000;
    wait.tv_usec = (timeoutMsecs % 1000) * 1000;

    /*
     * Wait up to our timeout interval for data on the serial line. Return
     * immediately on timeout or error.
     */
    int nready = select(_fd + 1, &readFds, NULL, NULL, &wait);
    if (nready <= 0) {
        if (nready == 0) {
            // timeout
            ELOG << __PRETTY_FUNCTION__ << ": select timeout";
        } else {
            if (errno == EINTR) {
                /* system call was interrupted */
                ELOG << __PRETTY_FUNCTION__ << ": select() call interrupted";
            } else {
                ELOG << __PRETTY_FUNCTION__ << ": select error: " << strerror(errno);
            }
        }
        return;
    } 
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

    // Deal with more initialization after phases which are waiting for response
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
        ILOG << "Re-doing initialization phase " << _initPhase <<
                " after NAK of " << msgId << " command";
        _doCurrentInitPhase();
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
            ILOG << msgId << " command rejected in init phase " << _initPhase;
            if (_rejectRetryCount < 3) {
                ILOG << "Sleeping briefly, then retrying init phase " << _initPhase;
                // Sleep for 0.8 seconds. This time was determined empirically
                // for the most common reject case, but feel free to adjust it
                // if it's not long enough.
                usleep(800000);
                _rejectRetryCount++;
                _doCurrentInitPhase();
            } else {
                ELOG << msgId << " command rejected " << _rejectRetryCount <<
                        "times, aborting!";
                abort();
            }
        } else {
            ILOG << msgId << " command accepted";
            _rejectRetryCount = 0;
            // Command was accepted. Move to the next initialization step.
            _initPhase = InitPhase(static_cast<int>(_initPhase) + 1);
            _doCurrentInitPhase();
        }
    }
}

void
Cmigits::_noHandshakeRcvd() {
    WLOG << "No handshake received for " << _awaitingHandshake <<
            " command. Trying again.";
    _awaitingHandshake = -1;
    _doCurrentInitPhase();
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
    // we think we completed initialization, force the initialization process
    // to start again.
    if (_currentMode == 2 && _initPhase == INIT_Complete &&
            _initCompleteTime.secsTo(QDateTime::currentDateTime().toUTC()) > 5) {
        ELOG << "C-MIGITS has returned to Initialization mode. Beginning re-initialization.";
        _initPhase = INIT_PreInit;
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
    float hPosError = _UnpackFloat32(msgWords + 15, 15);     // m
    float vPosError = _UnpackFloat32(msgWords + 17, 15);     // m
    float velocityError = _UnpackFloat32(msgWords + 19, 10); // m/s

    DLOG << "3500 time: " << msgTime.toString().toStdString() <<
            ", mode: " << ModeName(_currentMode) <<
            ", GPS: " << _gpsAvailable <<
            ", INS: " << _insAvailable <<
            ", # satellites tracked: " << nSats;
    DLOG << "3500 position FOM: " << PositionFOMString(positionFOM) <<
            ", velocity FOM: " << VelocityFOMString(velocityFOM) <<
            ", heading FOM: " << HeadingFOMString(headingFOM) <<
            ", time FOM: " << TimeFOMString(timeFOM);
    DLOG << "3500 expected errors - h pos: " << hPosError <<
            " m, v pos: " << vPosError << " m, velocity: " << velocityError <<
            " m/s";

    uint64_t msecsSinceEpoch = 1000LL * msgTime.toTime_t() + msgTime.time().msec();
    emit new3500Data(msecsSinceEpoch, _currentMode,
            insAvailable, gpsAvailable, nSats,
            positionFOM, velocityFOM, headingFOM, timeFOM,
            hPosError, vPosError, velocityError);
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
    float latitude = 180.0 * _UnpackFloat32(msgWords + 9, 0);
    float longitude = 180.0 * _UnpackFloat32(msgWords + 11, 0);
    float altitude = _UnpackFloat32(msgWords + 13, 15);

    // Unpack velocity components
    float velocityNorth = _UnpackFloat32(msgWords + 15, 10);
    float velocityEast = _UnpackFloat32(msgWords + 17, 10);
    float velocityUp = _UnpackFloat32(msgWords + 19, 10);

// Ignore attitude, since we get it at 100 Hz via 3512 messages
//    // Unpack attitude components
//    float pitch = 180.0 * _UnpackFloat32(msgWords + 21, 0);
//    float roll = 180.0 * _UnpackFloat32(msgWords + 23, 0);
//    float heading = 180.0 * _UnpackFloat32(msgWords + 25, 0);

    uint16_t decisecond = uint16_t(round(10 * fmod(utcSecondOfDay, 1.0)));
    decisecond %= 10;
    if (decisecond == 0) {
        ILOG << "3501 time: " << msgTime.toString().toStdString() <<
                ", lat: " << latitude << ", lon: " << longitude <<
                ", alt: " << altitude << ", vel north: " << velocityNorth <<
                ", vel east: " << velocityEast << ", vel up: " << velocityUp;
    }

    uint64_t msecsSinceEpoch = 1000LL * msgTime.toTime_t() + msgTime.time().msec();
    emit new3501Data(msecsSinceEpoch, latitude, longitude,
            altitude, velocityNorth, velocityEast, velocityUp);
}

void
Cmigits::_process3512Message(const uint16_t * msgWords, uint16_t nMsgWords) {
    QMutexLocker locker(&_mutex);

    if (! _navDataOk())
        return;

    // 3512 message length is variable, but we configured it to contain only
    // attitude data (6 words), giving a total message length of 16 words.
    if (nMsgWords != 16) {
        ELOG << "Type 3512 message has " << nMsgWords << " words; expecting 16!";
        return;
    }

    double utcSecondOfDay = _unpackTimeTag(msgWords + 5);
    QDateTime msgTime = _SecondOfDayToNearestDateTime(utcSecondOfDay);


    float pitch = 180.0 * _UnpackFloat32(msgWords + 9, 0);
    float roll = 180.0 * _UnpackFloat32(msgWords + 11, 0);
    float heading = 180.0 * _UnpackFloat32(msgWords + 13, 0);

    int centisecond = int(round(fmod(utcSecondOfDay, 1.0) * 100));
    centisecond %= 100;
    if (centisecond == 0) {
        ILOG << "3512 time: " << msgTime.toString().toStdString() <<
                ", pitch: " << pitch <<
                ", roll: " << roll << ", heading: " << heading;
    }

    uint64_t msecsSinceEpoch = 1000LL * msgTime.toTime_t() + msgTime.time().msec();
    emit new3512Data(msecsSinceEpoch, pitch, roll, heading);
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

    float lat = 180.0 * _UnpackFloat32(msgWords + 21, 0);
    float lon = 180.0 * _UnpackFloat32(msgWords + 23, 0);
    float alt = _UnpackFloat32(msgWords + 25, 15);
    DLOG << "3623 lat: " << lat << ", lon: " << lon << ", alt: " << alt <<
            " (" << msgWords[15] << " satellites)";
    // We can start initialization any time after we get the first 3623 message.
    // (See "Commanded Initialization" in the C-MIGITS manual)
    if (_initPhase == INIT_PreInit) {
        _initPhase = INIT_GoToInitMode;
        _doCurrentInitPhase();
    }
}

float
Cmigits::_UnpackFloat32(const uint16_t * words, uint16_t binaryScaling) {
    // Get the 32-bit packed value as int32_t
    int32_t packedVal;
    memcpy(&packedVal, words, 4);
    // Apply the binary scaling factor to the packed value
    float val = float(packedVal) / (1UL << (31 - binaryScaling));
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
Cmigits::_PackFloat32(void * dest, float value, uint16_t binaryScaling) {
    float fraction = value / (1 << binaryScaling);
    int32_t packedVal = int32_t(fraction * 0x80000000UL);
    memcpy(dest, &packedVal, 4);
}

void
Cmigits::_sendMessage(uint16_t msgId, const uint16_t * dataWords,
        uint16_t nDataWords, bool setDisconnectBit, bool setConnectBit) {
    // Don't send a message if we're waiting for a handshake for a previous
    // message.
    if (_awaitingHandshake >= 0) {
        ELOG << "Awaiting handshake for last " << _awaitingHandshake <<
                "msg; cannot send " << msgId << " message.";
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
Cmigits::_doCurrentInitPhase() {
    // Buffer for message data, initialized to zeros
    uint16_t data[_CMIGITS_MAX_MSG_LEN_WORDS];
    memset(data, 0, sizeof(data));

    // Current time
    time_t now = time(0);
    struct tm  * now_tm = gmtime(&now);

    // Process the next initialization phase
    ILOG << "Doing initialization phase " << _initPhase << " of " << INIT_Complete;

    // Handle the current initialization phase
    switch (_initPhase) {
    case INIT_PreInit:
        // Shouldn't happen!
        ELOG << "BUG: entered " << __PRETTY_FUNCTION__ <<
                " while in INIT_PreInit state!";
        abort();
        break;
    case INIT_GoToInitMode:
        // Create and send a 3510 (Control and Initialization) message to put
        // the C-MIGITS into Initialization mode

        // set data validity bits
        data[0] |= 1 << 0;	// set mode
        // set the mode to 2 -> initialization mode
        data[1] = 2;        // mode: 2 -> initialization mode

        _sendMessage(3510, data, 21);
        break;
    case INIT_EnableDefaultMsgs:
        // Disconnect for message type 0 causes the C-MIGITS to revert to
        // sending only the default messages.
        _sendDisconnectForMsg(0);
        break;
    case INIT_SetRates:
        // Build and send a 3504 message to:
        //      1) set serial communication rate to 115200 bps
        //      2) request that the C-MIGITS generate 3512 (Flight Control)
        //         messages containing aircraft attitude at 100 Hz rate
        //      3) include only attitude data in 3512 messages

        // set data validity bits
        data[0] |= (1 << 0);		// set host vehicle transmit baud rate
        data[0] |= (1 << 1);		// set host vehicle receive baud rate
        data[0] |= (1 << 7);		// set Message 3512 transmit rate
        data[0] |= (1 << 8);		// set Message 3512 contents

        // set host vehicle baud rates
        data[1] |= (1 << 0);		// transmit baud rate 1 -> 115200 bps
        data[1] |= (1 << 8);		// receive baud rate 1 -> 115200 bps

        // set Message Control word
        data[4] |= (3 << 4);		// Message 3512 transmit rate 3 -> 100 Hz
        data[4] |= (1 << 8);		// send attitude in Message 3512

        // Send the 3504 message
        _sendMessage(3504, data, 5);
        break;
    case INIT_SensorConfig:
        // Build a 3511 message to set the orientation of the C-MIGITS

        // set data validity bits
        data[0] |= (1 << 0);		// set sensor-to-body transformation

        // Set the sensor-to-body transformation matrix.
        {
            RotationMatrix rotMatrix;
            // The default orientation for the C-MIGITS has the sensor x axis
            // pointing out the nose of the aircraft, the y axis pointing out
            // the right wing, and the z axis pointing down.
            //
            // For ground operation or installation on the right wing, the
            // C-MIGITS for HCR is physically oriented with the labels on the
            // unit facing zenith. Set up a rotation matrix for this
            // orientation so that attitude (pitch, yaw, and heading) data
            // reported by the C-MIGITS are correct.
            rotMatrix.rotateAboutX(180.0);
            rotMatrix.rotateAboutY(90.0);
            // When installed on the left wing, the whole pod is rolled 180
            // degrees from the right wing installation.  From the above
            // orientation, this is a 180 degree rotation about the sensor z
            // axis.
            if (_onRightWing) {
                ILOG << "RIGHT WING/GROUND configuration";
            } else {
                // Pod is rolled 180 degrees
                rotMatrix.rotateAboutZ(180.0);
                ILOG << "LEFT WING configuration";
            }
            _PackFloat32(&data[1], rotMatrix.element(0, 0), 1);
            _PackFloat32(&data[3], rotMatrix.element(0, 1), 1);
            _PackFloat32(&data[5], rotMatrix.element(0, 2), 1);
            _PackFloat32(&data[7], rotMatrix.element(1, 0), 1);
            _PackFloat32(&data[9], rotMatrix.element(1, 1), 1);
            _PackFloat32(&data[11], rotMatrix.element(1, 2), 1);
            _PackFloat32(&data[13], rotMatrix.element(2, 0), 1);
            _PackFloat32(&data[15], rotMatrix.element(2, 1), 1);
            _PackFloat32(&data[17], rotMatrix.element(2, 2), 1);
        }
        // Send the 3511 message
        _sendMessage(3511, data, 22);
        break;
    case INIT_Enable3512Msgs:
        // Tell the C-MIGITS to start sending 3512 (Flight Control) messages
        _sendConnectForMsg(3512);
        break;
    case INIT_StartAutoNav:
    {
        // Create a 3510 (Control and Initialization) message to enable
        // automatic mode sequencing

        // Set data validity bits
        data[0] |= 1 << 0;	// set mode
        data[0] |= 1 << 1;	// set lat/lon/alt
        data[0] |= 1 << 2;	// set horizontal velocity
        data[0] |= 1 << 3;	// set date/time data
        data[0] |= 1 << 4;	// set true heading
        data[0] |= 1 << 5;	// set auto align/nav sequence data
        data[0] |= 1 << 8;	// setting auto GPS state

        // Follow automatic mode sequencing, defined by the alignment/navigation
        // word below.
        data[1] = 0;        // mode: 0 -> automatic mode sequencing

        // Position and velocity *have* to be initialized some time after power 
        // up, even if we tell the C-MIGITS to use Auto GPS Initialization.
        // (See "How do I initialize the unit?" in the Frequently Asked 
        // Questions chapter of the C-MIGITS manual.)  We just provide a bogus 
        // location and velocity every time we initialize.
        data[2] = 0;    // lat deg
        data[3] = 0;    // lat min
        data[4] = 0;    // lat sec

        data[5] = 0;    // lon deg
        data[6] = 0;    // lon min
        data[7] = 0;    // lon sec

        data[8] = 0;    // alt m (high order word)
        data[9] = 0;    // alt m (low order word)

        data[10] = 0;   // ground speed m/s
        data[11] = 0;   // ground track deg

        // Provide the current time
        data[12] = now_tm->tm_year - 1900;
        data[13] = now_tm->tm_yday;
        data[14] = now_tm->tm_hour;
        data[15] = now_tm->tm_min;
        data[16] = now_tm->tm_sec;

        // Provide the current heading
        float heading = -20.0;
        // normalize heading to interval [-180.0, 180.0]
        heading = fmodf(heading, 360.0);
        if (heading < -180.0) {
            heading += 360.0;
        } else if (heading > 180.0) {
            heading -= 360.0;
        }
        // Convert heading to 16-bit signed integer, in hundredths of a degree.
        // (Value will be in the interval [-18000, 18000]
        int16_t iHeading = int16_t(rintf(heading * 100));
        // Copy signed integer heading into unsigned data word 17
        memcpy(data + 17, &iHeading, 2);
 
        // Set up alignment/navigation sequence to be used
        bool stationary = true;
        if (stationary) {
            data[18] |= 4 << 0;	// alignment mode: 4 - fine alignment
        } else {
            data[18] |= 5 << 0; // alignment mode: 5 - air alignment
        }

        if (_useAirNavigation) {
            ILOG << "AIR NAVIGATION configuration";
            data[18] |= 7 << 4;	// auto sequence nav mode: 7 - air navigation
        } else {
            ILOG << "LAND NAVIGATION configuration";
            data[18] |= 8 << 4; // auto sequence nav mode: 8 - land navigation
        }
        data[18] |= 1 << 8;	// initialize from GPS when GPS has position

        // Send the 3510 message
        _sendMessage(3510, data, 21);
        break;
    }
    case INIT_Complete:
        ILOG << "C-MIGITS initialization is complete!";
        _initCompleteTime = QDateTime::currentDateTime().toUTC();
        break;
    default:
        ELOG << __PRETTY_FUNCTION__ << ": Unknown configuration phase: " << _initPhase;
        abort();
        break;
    }
}
