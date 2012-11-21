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
#include <ctime>
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
        _initialized(false),
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
    // Header-only messages get separate processing. Other messages are
    // processed based on message ID.
    bool headerOnly = (nMsgWords == _CMIGITS_HDR_LEN_WORDS);
    if (headerOnly) {
    	_processHeaderOnlyMessage(msgWords);
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
Cmigits::_processHeaderOnlyMessage(const uint16_t * msgWords) {
	uint16_t msgId = msgWords[1];
	uint16_t flags = msgWords[3];
	bool nak = flags & (1 << 10);
	bool ack = flags & (1 << 11);
	ELOG << "Got reply message for " << msgWords[1] << ": " <<
			((flags & (1 << 7)) ? "INVALID " : "") <<
			((flags & (1 << 8)) ? "REJECTED " : "") <<
			((flags & (1 << 9)) ? "HANDSHAKE " : "") <<
			(nak ? "NAK " : "") <<
			(ack ? "ACK " : "") <<
			((flags & (1 << 12)) ? "(ACK request)" : "");
	// If we get an ACK for a 3510 (Control and Initialization) message,
	// consider the C-MIGITS to be initialized.
	if (msgId == 3510 && ack) {
		_initialized = true;
	}
}

void
Cmigits::_process3500Message(const uint16_t * msgWords, uint16_t nMsgWords) {
    QMutexLocker locker(&_mutex);
    
    // 3500 message should be exactly 22 words long
    if (nMsgWords != 22) {
        ELOG << "Type 3500 message has " << nMsgWords << " words; expecting 22!";
        return;
    }

    // current mode
    _currentMode = msgWords[9];
    ELOG << "mode " << _currentMode;

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

    DLOG << "GPS: " << (_gpsValid ? "valid" : "not valid") << " (tracking " <<
            _nSatsTracked << " satellites), " <<
            "INS: " << (_insValid ? "valid" : "not valid");
}

/// @TODO Get rid of this! XXX
static int __Count3501 = 0;

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
    float pitch = 180.0 * _UnpackFloat32(msgWords + 21, 0);
    float roll = 180.0 * _UnpackFloat32(msgWords + 23, 0);
    float heading = 180.0 * _UnpackFloat32(msgWords + 25, 0);

    __Count3501++;
    if (! (__Count3501 % 10)) {
    	ILOG << "lat: " << lat << ", lon: " << lon << ", alt: " << alt <<
    			", pitch: " << pitch << ", roll: " << roll << ", heading: " << heading;
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

//    uint32_t hPosErrorCm = *(reinterpret_cast<const uint32_t *>(msgWords + 33));
//    _hPosError = 0.01 * hPosErrorCm;
//    uint32_t vPosErrorCm = *(reinterpret_cast<const uint32_t *>(msgWords + 35));
//    _vPosError = 0.01 * vPosErrorCm;
//    uint32_t tErrorCm = *(reinterpret_cast<const uint32_t *>(msgWords + 37));
//    _velocityError = 0.01 * msgWords[39];
//    ELOG << "expected errors - hPos: " << _hPosError << " m, vPos: " <<
//            _vPosError << " m, t: " << 0.01 * tErrorCm <<
//            " m, _velocityError: " << _velocityError << " m/s";
    float lat = 180.0 * _UnpackFloat32(msgWords + 21, 0);
    float lon = 180.0 * _UnpackFloat32(msgWords + 23, 0);
    float alt = _UnpackFloat32(msgWords + 25, 15);
    ILOG << "GPS lat: " << lat << ", lon: " << lon << ", alt: " << alt <<
    		" (" << msgWords[15] << " satellites)";
    // We can initialize any time after we get the first 3623 message.
    // (See "Commanded Initialization" in the C-MIGITS manual)
    if (! _initialized) {
    	_initialize();
    }
}

float
Cmigits::_UnpackFloat32(const uint16_t * words, uint16_t binaryScaling) {
    int32_t packedVal;
    memcpy(&packedVal, words, 4);
    float fraction = float(packedVal) / 0x80000000UL;
    float floatVal = (1 << binaryScaling) * fraction;
    return(floatVal);
}


void
Cmigits::_PackFloat32(void * dest, float value, uint16_t binaryScaling) {
	float fraction = value / (1 << binaryScaling);
	int32_t packedVal = int32_t(fraction * 0x80000000UL);
	memcpy(dest, &packedVal, 4);
}

void
Cmigits::_initialize() {
	ILOG << "Sending initialization message to C-MIGITS on " << _ttyDev;
    // Build a 3511 message to set the orientation of the C-MIGITS w.r.t.
    // the radar.

	// Create an empty 3511 (Configuration Control) message
	const uint16_t N3511DataWords = 22;
	uint16_t msg3511[_CMIGITS_HDR_LEN_WORDS + N3511DataWords + 1];
	memset(msg3511, 0, sizeof(msg3511));

	// Build the message header
	msg3511[0] = _MESSAGE_SYNC_WORD;
	msg3511[1] = 3511;			// Configuration Control Message
	msg3511[2] = N3511DataWords;	// data word count
	msg3511[3] = 0;				// flags
	msg3511[3] |= (1 << 12);	// flag: ACK request
	msg3511[3] |= (1 << 15);	// flag: ready
	msg3511[4] = _CmigitsChecksum(msg3511, 4);

	// set data validity bits
	msg3511[5] = 0;
	msg3511[5] |= (1 << 0);		// set sensor-to-body transformation

	// Set the sensor-to-body transformation matrix
	// XXX This is a fixed 180 degree roll for now... @TODO fix this!
	_PackFloat32(&msg3511[6], 1.0, 1);	// [0,0] = 1
	_PackFloat32(&msg3511[8], 0.0, 1);	// [0,1] = 0
	_PackFloat32(&msg3511[10], 0.0, 1);	// [0,2] = 0
	_PackFloat32(&msg3511[12], 0.0, 1);	// [1,0] = 0
	_PackFloat32(&msg3511[14], -1.0, 1);// [1,1] = -1
	_PackFloat32(&msg3511[16], 0.0, 1);	// [1,2] = 0
	_PackFloat32(&msg3511[18], 0.0, 1);	// [2,0] = 0
	_PackFloat32(&msg3511[20], 0.0, 1);	// [2,1] = 0
	_PackFloat32(&msg3511[22], -1.0, 1);// [2,2] = -1

	// Finish with the data checksum
	msg3511[27] = _CmigitsChecksum(msg3511 + _CMIGITS_HDR_LEN_WORDS, N3511DataWords);

	// Send the 3511 message
    int result = write(_fd, msg3511, sizeof(msg3511));
    if (result < 0) {
        ELOG << __PRETTY_FUNCTION__ << ": write error: " << strerror(errno);
    } else if (result != sizeof(msg3511)) {
    	ELOG << __PRETTY_FUNCTION__ << ": wrote " << result <<
    			" bytes instead of " << sizeof(msg3511);
    } else {
    	ELOG << __PRETTY_FUNCTION__ << ": sent " << sizeof(msg3511) << "-byte 3511 message";
    }

	// Create an empty 3510 (Control and Initialization) message
	const uint16_t N3510DataWords = 21;
	uint16_t msg3510[_CMIGITS_HDR_LEN_WORDS + N3510DataWords + 1];
	memset(msg3510, 0, sizeof(msg3510));

	// Build the message header
	msg3510[0] = _MESSAGE_SYNC_WORD;
	msg3510[1] = 3510;			// Control and Initialization Message
	msg3510[2] = N3510DataWords;	// data word count
	msg3510[3] = 0;				// flags
	msg3510[3] |= (1 << 12);	// flag: ACK request
	msg3510[3] |= (1 << 15);	// flag: ready
	msg3510[4] = _CmigitsChecksum(msg3510, 4);

	// Build the 3510 message to enable automatic mode sequencing

	// set data validity bits
	msg3510[5] = 0;			// data validity bits
//	msg3510[5] |= 1 << 0;	// set mode
	msg3510[5] |= 1 << 1;	// set lat/lon/alt
	msg3510[5] |= 1 << 2;	// set horizontal velocity
	msg3510[5] |= 1 << 3;	// set date/time data
	msg3510[5] |= 1 << 4;	// set true heading
//	msg3510[5] |= 1 << 5;	// set auto align/nav sequence data

//	msg3510[6] = 0;			// mode: 0 -> automatic mode sequencing

	msg3510[7] = 0;			// lat deg
	msg3510[8] = 0;			// lat min
	msg3510[9] = 0;			// lat sec

	msg3510[10] = 0;		// lon deg
	msg3510[11] = 0;		// lon min
	msg3510[12] = 0;		// lon sec

	msg3510[13] = 0;		// alt m (high order word)
	msg3510[14] = 0;		// alt m (low order word)

	msg3510[15] = 0;		// ground speed m/s
	msg3510[16] = 0;		// ground track deg

	time_t now = time(0);
	struct tm  * now_tm = gmtime(&now);
	msg3510[17] = now_tm->tm_year - 1900;
	msg3510[18] = now_tm->tm_yday;
	msg3510[19] = now_tm->tm_hour;
	msg3510[20] = now_tm->tm_min;
	msg3510[21] = now_tm->tm_sec;

	msg3510[22] = 3000;		// heading is 30.0 (0.01 degree units)

//	msg3510[23] = 0;		// auto align/nav sequence bits
//	msg3510[23] |= 4 << 0;	// alignment mode: fine alignment (static initialization)
//	msg3510[23] |= 7 << 3;	// nav mode: flight navigation
//	msg3510[23] |= 1 << 8;	// initialize from GPS when GPS has position

	// Finish with the data checksum
	msg3510[26] = _CmigitsChecksum(msg3510 + _CMIGITS_HDR_LEN_WORDS, N3510DataWords);

	// Send the 3510 message
    result = write(_fd, msg3510, sizeof(msg3510));
    if (result < 0) {
        ELOG << __PRETTY_FUNCTION__ << ": write error: " << strerror(errno);
    } else if (result != sizeof(msg3510)) {
    	ELOG << __PRETTY_FUNCTION__ << ": wrote " << result <<
    			" bytes instead of " << sizeof(msg3510);
    } else {
    	ELOG << __PRETTY_FUNCTION__ << ": sent " << sizeof(msg3510) << "-byte 3510 message";
    }

    // Note that initialization is not considered complete until we receive
    // the ACK from the C-MIGITS for the message just sent. The _initialized
    // member will be set by _processHeaderOnlyMessage() when it receives
    // a valid ACK for the 3510 message just sent.
    return;
}
