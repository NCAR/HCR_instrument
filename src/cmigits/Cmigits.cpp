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

#include <logx/Logging.h>

LOGGING("Cmigits")

// device name to use for simulated C-MIGITS
const std::string Cmigits::SIM_DEVICE = "SimulatedCmigits";

Cmigits::Cmigits(std::string ttyDev) :
                QObject(),
                _simulate(ttyDev == SIM_DEVICE),
                _ttyDev(ttyDev),
                _fd(-1),
                _initPhase(INIT_PreInit),
                _initCompleteTime(),
                _nRawBytes(0),
                _nSkippedForSync(0),
                _myThread(),
                _mutex(QMutex::Recursive),
                _awaitingHandshake(-1),
                _rejectRetryCount(0),
                _handshakeTimer(0),
                _utcToGpsCorrection(-1),
                _gpsValid(false),
                _insValid(false),
                _nSatsTracked(0),
                _hPosError(9.9e9),
                _vPosError(9.9e9),
                _velocityError(9.9e9) {
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

    // Start reading as soon as our thread is started
    connect(&_myThread, SIGNAL(started()), this, SLOT(_doRead()), Qt::QueuedConnection);
    // Make sure we queue a new read after each completed read.
    connect(this, SIGNAL(_readDone()), this, SLOT(_doRead()), Qt::QueuedConnection);

    _myThread.start();
}

Cmigits::~Cmigits() {
    disconnect(this, SIGNAL(_readDone()), this, SLOT(_doRead()));
    _myThread.quit();
    if (! _myThread.wait(1000)) {
        ELOG << __PRETTY_FUNCTION__ << ": wait for _myThread termination timed out!";
    }
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
        emit(_readDone());
        return;
    } 
    /*
     * Read what's available on the serial port
     */
    int result = read(_fd, _rawData + _nRawBytes, _CMIGITS_MAX_MSG_LEN_BYTES - _nRawBytes);
    if (result < 0) {
        ELOG << __PRETTY_FUNCTION__ << ": read error: " << strerror(errno);
        emit(_readDone());
        return;
    }
    _nRawBytes += result;
    /*
     * Process what we can from the data read so far.
     */
    _processRawData();

    emit(_readDone());
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
        // speed. Try a new speed if necessary.
        if (_nSkippedForSync >= _CMIGITS_MAX_MSG_LEN_BYTES) {
            speed_t nextBaud = _NextBaud(_currentBaud);
            ELOG << "No sync word found. Changing speed from " <<
                    _BaudToText(_currentBaud) << " to " << _BaudToText(nextBaud);
            _nSkippedForSync = 0;
            _setBaud(nextBaud);
        }
    }
    if (_nSkippedForSync > 0) {
        ELOG << "C-MIGITS data resynchronized after " << _nSkippedForSync << " bytes";
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
    DLOG << "Got reply message for " << msgWords[1] << ": " <<
            ((flags & (1 << 7)) ? "INVALID " : "") <<
            (handshake ? handshakeMsg : "") <<
            (nak ? "NAK " : "") <<
            (ack ? "ACK " : "") <<
            ((flags & (1 << 12)) ? "(ACK request)" : "");

    // Deal with more initialization after phases which are waiting for response
    // to a messages.
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
        _initialize();
    }

    // Second response to a command is a handshake reply telling whether the
    // command was accepted or rejected.
    if (handshake) {
        if (_handshakeTimer) {
            _handshakeTimer->stop();
        }
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
                _initialize();
            } else {
                ELOG << msgId << " command rejected " << _rejectRetryCount <<
                        "times, aborting!";
                abort();
            }
        } else {
            DLOG << msgId << " command accepted";
            _rejectRetryCount = 0;
            // Command was accepted. Move to the next initialization step.
            _initPhase = InitPhase(static_cast<int>(_initPhase) + 1);
            _initialize();
        }
    }
}

void
Cmigits::_noHandshakeRcvd() {
    WLOG << "No handshake received for " << _awaitingHandshake <<
            " command. Trying again.";
    _awaitingHandshake = -1;
    _initialize();
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

    // current mode
    _currentMode = msgWords[9];

    // If the C-MIGITS is ever in Initialization mode more than 5 seconds after
    // we think we completed initialization, force the initialization process
    // to start again.
    if (_currentMode == 2 && _initPhase == INIT_Complete &&
            _initCompleteTime.msecsTo(QDateTime::currentDateTime()) > 5000) {
        ELOG << "C-MIGITS has returned to Initialization mode. Beginning re-initialization.";
        _initPhase = INIT_PreInit;
    }

    // system status validity
    uint16_t systemStatusValidity = msgWords[10];

    // "GPS Measurements Available" is bit 0 of system status validity
    bool gpsValid = systemStatusValidity & (1 << 0);
    // Emit a signal when GPS validity changes
    if (gpsValid != _gpsValid) {
        emit(gpsValidChanged(gpsValid));
    }
    _gpsValid = gpsValid;

    // "INS Measurements Available" is bit 1 of system status validity
    bool insValid = systemStatusValidity & (1 << 1);
    // Emit a signal when INS validity changes
    if (insValid != _insValid) {
        emit(insValidChanged(insValid));
    }
    _insValid = insValid;

    _nSatsTracked = msgWords[11];

    ILOG << "3500 time: " << utcSecondOfDay << ", mode: " << _currentMode <<
            ", GPS: " << (_gpsValid ? "valid" : "not valid") <<
            " (tracking " << _nSatsTracked << " sats), " <<
            "INS: " << (_insValid ? "valid" : "not valid");
}

void
Cmigits::_process3501Message(const uint16_t * msgWords, uint16_t nMsgWords) {
    QMutexLocker locker(&_mutex);

    // 3501 message should be exactly 28 words long
    if (nMsgWords != 28) {
        ELOG << "Type 3501 message has " << nMsgWords << " words; expecting 28!";
        return;
    }

    double utcSecondOfDay = _unpackTimeTag(msgWords + 5);
    float lat = 180.0 * _UnpackFloat32(msgWords + 9, 0);
    float lon = 180.0 * _UnpackFloat32(msgWords + 11, 0);
    float alt = _UnpackFloat32(msgWords + 13, 15);
    float pitch = 180.0 * _UnpackFloat32(msgWords + 21, 0);
    float roll = 180.0 * _UnpackFloat32(msgWords + 23, 0);
    float heading = 180.0 * _UnpackFloat32(msgWords + 25, 0);

    uint16_t decisecond = round(10 * fmod(utcSecondOfDay, 1.0));
    decisecond %= 10;
    if (decisecond == 0) {
         ILOG << "3501 time: " <<
                 std::setprecision(10) << utcSecondOfDay << std::setprecision(6) <<
                 ", lat: " << lat << ", lon: " << lon << ", alt: " << alt <<
                 ", pitch: " << pitch << ", roll: " << roll << ", heading: " << heading;
    }
}

void
Cmigits::_process3512Message(const uint16_t * msgWords, uint16_t nMsgWords) {
    QMutexLocker locker(&_mutex);

    // 3512 message length is variable, but we configure it to contain only
    // attitude data (6 words), giving a total message length of 16 words.
    if (nMsgWords != 16) {
        ELOG << "Type 3512 message has " << nMsgWords << " words; expecting 21!";
        return;
    }

    double utcSecondOfDay = _unpackTimeTag(msgWords + 5);


    float pitch = 180.0 * _UnpackFloat32(msgWords + 9, 0);
    float roll = 180.0 * _UnpackFloat32(msgWords + 11, 0);
    float heading = 180.0 * _UnpackFloat32(msgWords + 13, 0);

    int centisecond = round(fmod(utcSecondOfDay, 1.0) * 100);
    centisecond %= 100;
    if (centisecond == 0) {
        ILOG << "3512 time: " <<
                std::setprecision(10) << utcSecondOfDay << std::setprecision(6) <<
                ", pitch: " << pitch <<
                ", roll: " << roll << ", heading: " << heading;
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
    // Calculate current leap seconds offset between UTC and GPS.
    //
    // We must be careful to round here, since the floating precision of
    // gpsSecondOfWeek and utcSecondOfDay differ. We know the leap second
    // difference will actually be an integer, so round to make sure we get
    // the right value, rather than truncating 15.999999999 to 15!
    _utcToGpsCorrection = round(gpsSecondOfDay - utcSecondOfDay);

    float lat = 180.0 * _UnpackFloat32(msgWords + 21, 0);
    float lon = 180.0 * _UnpackFloat32(msgWords + 23, 0);
    float alt = _UnpackFloat32(msgWords + 25, 15);
    ILOG << "GPS time: " << gpsSecondOfWeek <<
            ", UTC time: " << utcSecondOfDay <<
            ", UTC to GPS: " << _utcToGpsCorrection <<
            ", GPS lat: " << lat << ", lon: " << lon << ", alt: " << alt <<
            " (" << msgWords[15] << " satellites)";
    // We can initialize any time after we get the first 3623 message.
    // (See "Commanded Initialization" in the C-MIGITS manual)
    if (_initPhase == INIT_PreInit) {
        _initPhase = INIT_EnableInitMode;
        _initialize();
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
    // Data in bytes is packed in order 43218765, where byte 1 is the
    // most significant and byte 8 is the least significant. Copy the data into
    // packedVal in little-endian order.
    uint16_t* pPtr = reinterpret_cast<uint16_t *>(&packedVal);
    memcpy(pPtr, words + 2, 4);
    memcpy(pPtr + 2, words, 4);
    // Apply the binary scaling factor to the packed value
    double val = double(packedVal) / (1ULL << (63 - binaryScaling));
    return(val);
}


// @TODO get rid of this!
static double __LastTimeTag = 0.0;

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

    double timeDiff = utcSecondOfDay - __LastTimeTag;
    if (timeDiff < -43200) {
        timeDiff += 86400;
    }
    if (timeDiff < 0) {
        ILOG << "Time tag went backward by " << timeDiff << " from " <<
                __LastTimeTag << " to " << utcSecondOfDay;

    }
    __LastTimeTag = utcSecondOfDay;

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
        // If we have no handshake timer, create it now.
        if (! _handshakeTimer) {
            _handshakeTimer = new QTimer();
            _handshakeTimer->setSingleShot(true);
            // If the timer times out, call _noHandshakeRcvd()
            connect(_handshakeTimer, SIGNAL(timeout()), this, SLOT(_noHandshakeRcvd()));
        }
        // Set up a timer so that if we don't get a handshake message in reply
        // to our command, we can send the command again. Wait up to 1 second
        // for the reply.
        _awaitingHandshake = msgId;
        _handshakeTimer->start(1000);
    }
}

void
Cmigits::_sendDisconnectForMsg(uint16_t msgId) {
    _sendMessage(msgId, 0, 0, true, false);
}

void
Cmigits::_sendConnectForMsg(uint16_t msgId) {
    _sendMessage(msgId, 0, 0, false, true);
}

void
Cmigits::_initialize() {
    // Buffer for message data, initialized to zeros
    uint16_t data[_CMIGITS_MAX_MSG_LEN_WORDS];
    memset(data, 0, sizeof(data));

    // Current time
    time_t now = time(0);
    struct tm  * now_tm = gmtime(&now);

    // Process the next initialization phase
    ILOG << "Initialization entering phase " << _initPhase;

    // Handle the current initialization phase
    switch (_initPhase) {
    case INIT_PreInit:
        // Shouldn't happen!
        ELOG << "BUG: entered " << __PRETTY_FUNCTION__ <<
                " while in INIT_PreInit state!";
        abort();
        break;
    case INIT_EnableInitMode:
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
        // Build a 3511 message to set the orientation of the C-MIGITS w.r.t.
        // the radar.

        // set data validity bits
        data[0] |= (1 << 0);		// set sensor-to-body transformation

        // Set the sensor-to-body transformation matrix
        // XXX This is a fixed 180 degree roll for now... @TODO fix this!
        _PackFloat32(&data[1], 1.0, 1);	    // [0,0] = 1
        _PackFloat32(&data[3], 0.0, 1);	    // [0,1] = 0
        _PackFloat32(&data[5], 0.0, 1);	    // [0,2] = 0
        _PackFloat32(&data[7], 0.0, 1);	    // [1,0] = 0
        _PackFloat32(&data[9], -1.0, 1);    // [1,1] = -1
        _PackFloat32(&data[11], 0.0, 1);	// [1,2] = 0
        _PackFloat32(&data[13], 0.0, 1);	// [2,0] = 0
        _PackFloat32(&data[15], 0.0, 1);	// [2,1] = 0
        _PackFloat32(&data[17], -1.0, 1);   // [2,2] = -1

        // Send the 3511 message
        _sendMessage(3511, data, 22);
        break;
    case INIT_Enable3512:
        // Tell the C-MIGITS to start sending 3512 (Flight Control) messages
        _sendConnectForMsg(3512);
        break;
    case INIT_StartAutoNav:
        // Create a 3510 (Control and Initialization) message to enable
        // automatic mode sequencing

        // set data validity bits
        data[0] |= 1 << 0;	// set mode
        data[0] |= 1 << 1;	// set lat/lon/alt
        data[0] |= 1 << 2;	// set horizontal velocity
        data[0] |= 1 << 3;	// set date/time data
        data[0] |= 1 << 4;	// set true heading
        //	data[0] |= 1 << 5;	// set auto align/nav sequence data
        data[0] |= 1 << 8;	// setting auto GPS state

        data[1] = 0;			// mode: 0 -> automatic mode sequencing

        data[2] = 0;			// lat deg
        data[3] = 0;			// lat min
        data[4] = 0;			// lat sec

        data[5] = 0;		// lon deg
        data[6] = 0;		// lon min
        data[7] = 0;		// lon sec

        data[8] = 0;		// alt m (high order word)
        data[9] = 0;		// alt m (low order word)

        data[10] = 0;		// ground speed m/s
        data[11] = 0;		// ground track deg

        data[12] = now_tm->tm_year - 1900;
        data[13] = now_tm->tm_yday;
        data[14] = now_tm->tm_hour;
        data[15] = now_tm->tm_min;
        data[16] = now_tm->tm_sec;

        data[17] = 3000;		// heading is 30.0 (0.01 degree units)

        data[18] |= 4 << 0;	// starting alignment mode: 4 - fine alignment
        data[18] |= 7 << 4;	// starting nav mode: 7 - air navigation
        data[18] |= 1 << 8;	// initialize from GPS when GPS has position

        // Send the 3510 message
        _sendMessage(3510, data, 21);
        break;
    case INIT_Complete:
        ILOG << "C-MIGITS initialization is complete!";
        _initCompleteTime = QDateTime::currentDateTimeUtc();
        break;
    default:
        ELOG << __PRETTY_FUNCTION__ << ": Unknown configuration phase: " << _initPhase;
        abort();
        break;
    }
}
