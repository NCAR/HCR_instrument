/*
 * FireFly.cpp
 *
 *  Created on: Mar 26, 2014
 *      Author: burghart
 */

#include "FireFly.h"

#include <cerrno>
#include <termios.h>
#include <fcntl.h>
#include <QTimer>

#include <logx/Logging.h>

LOGGING("FireFly")

FireFly::FireFly(std::string ttyDev) :
        _ttyDev(ttyDev),
        _fd(-1) {
    ILOG << "FireFly on device " << ttyDev;
    // Open the serial port
    _openTty();
}

FireFly::~FireFly() {
    quit();
    if (! wait(1000)) {
        WLOG << "FireFly thread did not quit in the destructor. Exiting anyway.";
    }
}

void
FireFly::run() {
    // Create a timer and use it to generate _queryForStatus() calls on a
    // regular basis.
    QTimer statusQueryTimer;
    statusQueryTimer.setInterval(1000);  // 1 Hz
    connect(&statusQueryTimer, SIGNAL(timeout()), this, SLOT(_queryForStatus()));

    statusQueryTimer.start();
    exec();
}

void
FireFly::_queryForStatus() {
//	// Buffer for reply from the transmitter, which will be parsed to build the
//    // FireFlyStatus.
//	static const int REPLYSIZE = 20;
//	uint8_t reply[REPLYSIZE];
//
//	// Max number of times to attempt to get good status from the transmitter
//    unsigned int MAX_ATTEMPTS = 2;
//
//    unsigned int attempt = 0;
//    unsigned int nReplies = 0;
//
//	// Loop until we either get a usable status reply or we hit our maximum
//	// number of attempts.
//    for (attempt = 0; attempt < MAX_ATTEMPTS; attempt++) {
//    	// Get rid of any unread input
//    	tcflush(_fd, TCIFLUSH);
//
//    	// Wait up to 350 ms for reply to arrive
//    	if (_readSelect(350) < 0) {
//    		DLOG << "Error or timeout waiting for status reply";
//    		// Try again
//    		continue;
//    	}
//
//    	if (attempt > 0 && nReplies == 0) {
//    		DLOG << "Got a status reply after " << attempt + 1 <<
//    				" attempts";
//    	}
//
//    	// Read the 20-byte status reply
//    	DLOG << "Reading status reply";
//    	int nBytesRead = 0;
//    	int nReads = 0;
//    	while (nBytesRead < REPLYSIZE && nReads < 5) {
//    		int result = read(_fd, reply + nBytesRead, REPLYSIZE - nBytesRead);
//    		nReads++;
//    		if (result == 0) {
//    			// wait 5 ms for more data
//    			ILOG << "Sleeping for more status data...";
//    			usleep(5000);
//    		} else if (result < 0) {
//    			ELOG << "Status reply read error: " << strerror(errno);
//    			_setLatestStatus(FireFlyStatus());   // empty/bad status
//    			return;
//    		} else {
//    			nBytesRead += result;
//    		}
//    	}
//    	if (nBytesRead == REPLYSIZE) {
//    		// We got a reply
//    		nReplies++;
//    	} else {
//    		// Incomplete reply, so try again
//    		WLOG << "Incomplete reply";
//    		continue;
//    	}
//
//    	// Byte 17 is non-zero if the transmitter received a bad communication.
//    	// If this byte indicates an error, the rest of the returned status can't
//    	// be trusted, so go back and try again.
//    	try {
//    	    // parse the string into an FireFlyStatus object, and set that as our
//    	    // latest status
//    	    _setLatestStatus(FireFlyStatus(reply));
//    	    return;
//    	} catch(FireFlyStatus::ConstructError & e) {
//            // Report the error.
//    	    ELOG << e.what();
//    	    // Go back and try again.
//    	    continue;
//    	}
//    }
//
//    // If we used up our tries, we just return an empty status
//    if (nReplies == 0) {
//        WLOG << "No status reply in " << MAX_ATTEMPTS <<
//                " tries; Is the transmitter CMU turned on?";
//    } else {
//        WLOG << "Only 'bad communication' replies in " << MAX_ATTEMPTS <<
//                " attempts to get status";
//    }
//    _setLatestStatus(FireFlyStatus());
//    return;
}

void
FireFly::_openTty() {
    DLOG << "Opening " << _ttyDev;
    if ((_fd = open(_ttyDev.c_str(), O_RDWR)) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error opening " << _ttyDev << ": " <<
                strerror(errno);
        exit(1);
    }

    // Make the port 19200 8E1, "raw"
    struct termios ios;
    if (tcgetattr(_fd, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error getting " << _ttyDev << 
                " attributes: " << strerror(errno);
        exit(1);
    }
    cfmakeraw(&ios);
    cfsetspeed(&ios, B19200);
    
    // Even parity
    ios.c_cflag |= PARENB;  // enable parity
    ios.c_cflag &= ~PARODD; // use even parity

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

int 
FireFly::_readSelect(unsigned int waitMsecs)
{
    /*
     * check only on _fd file descriptor
     */
    fd_set readFds;
    FD_ZERO(&readFds);
    FD_SET(_fd, &readFds);

    while (true) {
        /*
         * set timeval structure
         */
        struct timeval wait;
        wait.tv_sec = waitMsecs / 1000;
        wait.tv_usec = (waitMsecs % 1000) * 1000;

        int nready = select(_fd + 1, &readFds, NULL, NULL, &wait);
        if (nready == 1) {
            return 0;
        } else if (nready == 0) {
            return -1;      // timeout
        } else {
            if (errno == EINTR) /* system call was interrupted */
                continue;

            ELOG << __PRETTY_FUNCTION__ << ": select error: " <<
                    strerror(errno);
            return -2; // select failed
        } 
    }
    // Oops, shouldn't get here!
    return -3;
}

void
FireFly::_setLatestStatus(const FireFlyStatus & status) {
    QMutexLocker locker(& _mutex);
    _latestStatus = status;
}
