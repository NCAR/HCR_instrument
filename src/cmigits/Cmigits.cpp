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
#include <unistd.h>
#include <stdint.h>
#include <termios.h>
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
        _nRawBytes(0),
        _nSkippedForSync(0),
        _myThread(),
        _mutex(QMutex::Recursive),
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

    // Make the port 38400 8/1 odd parity, "raw"
    struct termios ios;
    if (tcgetattr(_fd, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error getting " << _ttyDev << 
                " attributes: " << strerror(errno);
        exit(1);
    }
    cfmakeraw(&ios);
    cfsetspeed(&ios, B38400);
    
    // Even parity
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
    DLOG << "Done configuring " << _ttyDev;
}

void 
Cmigits::_doRead()
{
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

    // Total message length in bytes is: header length + 
    // (2 * number of data words) + 2.  The final two bytes are for the data 
    // checksum word
    uint16_t nMsgBytes = _CMIGITS_HDR_LEN_BYTES + 2 * nMsgDataWords + 2;
    uint16_t nMsgWords = nMsgBytes / 2;

    // If we don't have a complete message yet, return now
    if (_nRawBytes < nMsgBytes) {
        return;
    }
    
    uint16_t * dataWords = words + (_CMIGITS_HDR_LEN_BYTES / 2);
    if (_CmigitsChecksum(dataWords, nMsgDataWords) == dataWords[nMsgDataWords]) {
        _processCmigitsMessage(words, nMsgWords);
    } else {
        ELOG << "Bad data checksum in " << msgId << " message!";
    }
    
    // Move any data after the current message to the head of _rawData
    memmove(_rawData, _rawData + nMsgBytes, _nRawBytes - nMsgBytes);
    _nRawBytes -= nMsgBytes;
}


uint16_t
Cmigits::_CmigitsChecksum(uint16_t * words, int nwords) {
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
    case 3623:  // 3623: 
        _process3623Message(msgWords, nMsgWords);
        break;
    default:
        ELOG << "Ignoring unhandled message type " << msgId;
        break;
    }
    return;
}

void
Cmigits::_process3500Message(const uint16_t * msgWords, uint16_t nMsgWords) {
    QMutexLocker locker(&_mutex);
    
    // 3500 message should be exactly 22 words long
    if (nMsgWords != 22) {
        ELOG << "Type 3500 message has " << nMsgWords << " words; expecting 22!";
        return;
    }

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

    DLOG << "GPS: " << (_gpsValid ? "valid" : "not valid") << " (tracking " <<
            _nSatsTracked << " satellites), " <<
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

    float lat = 180.0 * _UnpackFloat32(msgWords + 9, 0);
    float lon = 180.0 * _UnpackFloat32(msgWords + 11, 0);
    float alt = _UnpackFloat32(msgWords + 13, 15);

    ILOG << "lat: " << lat << ", lon: " << lon << ", alt: " << alt;
}

void
Cmigits::_process3623Message(const uint16_t * msgWords, uint16_t nMsgWords) {
    QMutexLocker locker(&_mutex);
    
    // 3623 message should be exactly 123 words long
    if (nMsgWords != 123) {
        ELOG << "Type 3623 message has " << nMsgWords << " words; expecting 123!";
        return;
    }

    uint32_t hPosErrorCm = *(reinterpret_cast<const uint32_t *>(msgWords + 33));
    _hPosError = 0.01 * hPosErrorCm;
    uint32_t vPosErrorCm = *(reinterpret_cast<const uint32_t *>(msgWords + 35));
    _vPosError = 0.01 * vPosErrorCm;
    uint32_t tErrorCm = *(reinterpret_cast<const uint32_t *>(msgWords + 37));
    _velocityError = 0.01 * msgWords[39];
    ELOG << "expected errors - hPos: " << _hPosError << " m, vPos: " <<
            _vPosError << " m, t: " << 0.01 * tErrorCm << 
            " m, _velocityError: " << _velocityError << " m/s";
    ELOG << "Tracking " << msgWords[15] << " satellites";
}

float
Cmigits::_UnpackFloat32(const uint16_t * words, uint16_t binaryScaling) {
    int32_t packedVal;
    memcpy(&packedVal, words, 4);
    float fraction = float(packedVal) / 0x80000000UL;
    float floatVal = (1 << binaryScaling) * fraction;
    return(floatVal);
}
