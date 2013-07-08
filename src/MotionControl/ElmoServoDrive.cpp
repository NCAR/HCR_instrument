/*
 * ElmoServoDrive.cpp
 *
 *  Created on: Jun 26, 2013
 *      Author: burghart
 */
#include "ElmoServoDrive.h"

#include <sstream>
#include <string>
#include <cerrno>
#include <cstdlib>
#include <stdint.h>
#include <logx/Logging.h>

LOGGING("ElmoServoDrive")

ElmoServoDrive::ElmoServoDrive(const std::string ttyDev, const std::string driveName) :
    _ttyDev(ttyDev),
    _driveName(driveName),
    _fd(-1),
    _readNotifier(0),
    _driveResponding(false),
    _waitingForSyncReply(false),
    _replyTimer(),
    _rawReplyLen(0) {
    DLOG << "Instantiating ElmoServoDrive '" << _driveName << "' on device " <<
    		_ttyDev;
    _openTty();

    // Use our notifier to call _readReply() whenever the servo drive sends
    // a reply.
    _readNotifier = new QSocketNotifier(_fd, QSocketNotifier::Read);
    connect(_readNotifier, SIGNAL(activated(int)), this, SLOT(_readReply()));

    // If replies from the servo drive do not arrive within a specified
    // interval, call _replyTimedOut().
    _replyTimer.setInterval(250);	// allow 250 ms for replies
    _replyTimer.setSingleShot(true);
    connect(& _replyTimer, SIGNAL(timeout()), this, SLOT(_replyTimedOut()));

    // Send a null command just to get a reply from the drive.
    _execElmoCmd("");
    ILOG << "Waiting for first response from " << _driveName << " drive";
}

ElmoServoDrive::~ElmoServoDrive() {
	delete(_readNotifier);
    // Turn on echo again. Elmo's Composer software requires echo on in order
    // to function, so we try to leave the servo drive in a state to talk to
    // Composer.
    _execElmoCmd("EO=1");
}

void
ElmoServoDrive::_openTty() {
    DLOG << "Opening " << _ttyDev;
    if ((_fd = open(_ttyDev.c_str(), O_RDWR)) == -1) {
        ELOG << _driveName << " drive: error opening " << _ttyDev << ": " <<
                strerror(errno);
        exit(1);
    }

    // Make the port 8 data bits, 1 stop bit, no parity, "raw"
    struct termios ios;
    if (tcgetattr(_fd, &ios) == -1) {
        ELOG << _driveName << " drive: error getting " << _ttyDev <<
                " attributes: " << strerror(errno);
        exit(1);
    }
    cfmakeraw(&ios);

    // No parity
    ios.c_cflag &= ~PARENB;  // enable parity

    // Set a 0.2 second timeout for reads
    ios.c_cc[VMIN] = 0;
    ios.c_cc[VTIME] = 2;    // 0.2 seconds

    if (tcsetattr(_fd, TCSAFLUSH, &ios) == -1) {
        ELOG << _driveName  << " drive: error setting " << _ttyDev <<
                " attributes: " << strerror(errno);
        exit(1);
    }

    // Start at 19200 baud
    _setBaud(B19200);

    DLOG << "Done configuring " << _ttyDev;
}

void
ElmoServoDrive::moveTo(float angle) {
	// Don't bother if the drive is not responding
	if (! _driveResponding) {
		return;
	}

	// Convert angle to drive counts
    int counts = int(COUNTS_PER_DEGREE * angle);

    // Generate a command to move to the given absolute position
    std::ostringstream cmdstream;
    cmdstream << "PA=" << counts;
    _execElmoCmd(cmdstream.str());
    _execElmoCmd("BG");
    // XXX the rest is debugging for reply sync
    int index = rand() % 3;
    switch (index) {
    case 0:
        _execElmoCmd("PX");
        break;
    case 1:
        _execElmoCmd("MO");
        break;
    case 2:
        _execElmoCmd("EO");
        break;
    }
}

bool
ElmoServoDrive::_execElmoCmd(const std::string cmd, bool initializeReplySync) {
	// TODO: verify that we got a single command, with no terminator characters
	// (or exactly one terminator at the end of the command)

	if (initializeReplySync) {
		// Stop sending commands after we send this one, so that the reply
		// to this command can mark a known spot for synchronization. This
		// flag will be set back to false after the next reply from the drive
		// is received.
		_waitingForSyncReply = true;
	} else if (_waitingForSyncReply) {
		// Don't send commands while we're waiting for a reply to establish
		// synchronization between sent commands and received replies.
		ILOG << "Dropping command '" << cmd << "', waiting for sync reply";
		return(false);
	}
	std::string tcmd = cmd + ";"; // copy of the command with terminator appended
    int tcmdlen = tcmd.length();

    // Write the command to our file descriptor
    int result = write(_fd, tcmd.c_str(), tcmdlen);
    if (result < 0) {
        ELOG << _driveName << " drive: error on write: " << strerror(errno);
        return(false);
    } else if (result != tcmdlen) {
        ELOG << _driveName << " drive: wrote " << result <<
                " bytes instead of " << tcmdlen;
        return(false);
    }

    // Start our reply timer if it isn't already running.
    if (! _replyTimer.isActive()) {
    	_replyTimer.start();
    }

    // Add this command to our queue of commands not yet acknowledged
   	_unackedCmds.push(cmd);

    ILOG << "Sent command '" << cmd << "' to " << _driveName << " drive (" <<
    		_unackedCmds.size() << " unacked)";
    return(true);
}

void
ElmoServoDrive::_readReply() {
	bool dropReply = false;
	/*
	 * Stop the reply timer and note that the drive is responding.
	 */
	_replyTimer.stop();
	if (! _driveResponding) {
		ILOG << _driveName << " drive is now responding";
		_driveResponding = true;
		dropReply = true;	// read and drop the reply below

		// Make sure echo is disabled, since we require echo off when sync'ing
		// replies with our queue of unacknowledged commands.
		//
		// We also set the initializeReplySync flag to make the reply to this
		// command establish our command/reply synchronization.
		_execElmoCmd("EO=0", true);

		// Clear the list of unacknowledged commands
		while (! _unackedCmds.empty()) {
			_unackedCmds.pop();
		}
	} else if (_waitingForSyncReply) {
		// Clear _unackedCmds *before* we set _waitingForSyncReply to false!
		if (! _unackedCmds.empty()) {
			ILOG << _driveName << ": clearing " << _unackedCmds.size() <<
				" unacked command entries to sync commands and replies";
		}
		while (! _unackedCmds.empty()) {
			_unackedCmds.pop();
		}
		// Read and drop this reply, and all commands and replies after this
		// should be synchronized.
		_waitingForSyncReply = false;
		dropReply = true;	// read and drop the reply below
		ILOG << _driveName << " commands and replies are now synced";
	}

	/*
	 * Read what's available on the serial port
	 */
	int maxRead = _ELMO_REPLY_BUFFER_SIZE - _rawReplyLen;
	int nread = read(_fd, _rawReply + _rawReplyLen, maxRead);
	if (nread < 0) {
		ELOG << __PRETTY_FUNCTION__ << ": read error: " << strerror(errno);
		return;
	}
	_rawReplyLen += nread;

	/*
	 * If we completely filled our reply buffer, it's a problem since there's
	 * probably some unread reply bytes! Do our best to deal with it.
	 */
	if (_rawReplyLen == _ELMO_REPLY_BUFFER_SIZE) {
		ELOG << "BUG: reply buffer overflow for " << _driveName << " drive. " <<
				". Increase size of _ELMO_REPLY_BUFFER_SIZE!";
		ELOG << "Attempting to resynchronize commands and replies.";
		// Restart the reply synchronization process
		_rawReplyLen = 0;
		_driveResponding = false;
		_waitingForSyncReply = false;
		while (! _unackedCmds.empty()) {
			_unackedCmds.pop();
		}
		return;
	}

	// If requested, just drop the reply and return.
	if (dropReply) {
		_rawReply[_rawReplyLen] = '\0';
		ILOG << _driveName << " dropping reply '" << _rawReply << "'";
		_rawReplyLen = 0;
		return;
	}

	_rawReply[_rawReplyLen] = '\0';
	ILOG << _driveName << " raw reply '" << _rawReply << "', with " <<
			_unackedCmds.size() << " unacked";
	// Parse replies in order by finding their semicolon terminators, removing
	// the associated commands from our unacknowledged queue.
	int nAcked = 0;
	int startNdx = 0;
	while (startNdx < _rawReplyLen) {
		// Find the next semicolon after startNdx
		uint8_t * term = static_cast<uint8_t *>
			(memchr(_rawReply + startNdx, ';', _rawReplyLen - startNdx));
		// If there's no semicolon left in our buffer, save the remainder
		// and break out. (Do the same if we found a semicolon, but have no
		// unacknowledged commands left to match a reply to).
		if (! term || _unackedCmds.empty()) {
			int nkeep = _rawReplyLen - startNdx;
			if (_unackedCmds.empty()) {
				ELOG << _driveName << ": dropping " << nkeep << "bytes of unexpected reply";
				nkeep = 0;	// XXX testing
			}
			memmove(_rawReply, _rawReply + startNdx, nkeep);
			_rawReplyLen = nkeep;
			break;
		}

		std::string cmd = _unackedCmds.front();

		nAcked++;

		int replySize = term - (_rawReply + startNdx);
		if (replySize == 0) {
			// Empty reply indicates success
			DLOG << _driveName << " command '" << cmd << "' succeeded";
		} else {
			// Copy out the reply to the command into a null-terminated
			// uint8_t array.
			uint8_t * cmdReply = new uint8_t[replySize + 1];
			memcpy(cmdReply, _rawReply + startNdx, replySize);
			cmdReply[replySize] = 0;

			// If the last character of the reply is a '?', it indicates an
			// error, with the error code in the preceding character.
			if (cmdReply[replySize - 1] == '?') {
				uint16_t errorCode = uint16_t(cmdReply[replySize - 2]);
				ELOG << _driveName << " command '" << cmd << "' gave error " <<
						errorCode;
			} else {
				ILOG << _driveName << " command '" << cmd << "' replied '" <<
						cmdReply << "'";
			}
			delete(cmdReply);
		}
		// Remove the front command from our unacknowledged queue; it's now
		// acknowledged.
		_unackedCmds.pop();

		// Move past the reply we just parsed
		startNdx += replySize + 1;
	}

	ILOG << nAcked << " commands ack'ed";
	return;
}

void
ElmoServoDrive::_setBaud(speed_t baudValue) {
    if (baudValue != B9600 && baudValue != B19200 && baudValue != B38400 &&
            baudValue != B57600) {
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
}

std::string
ElmoServoDrive::_BaudToText(speed_t baudValue) {
    std::string speedTxt("unknown");
    switch (baudValue) {
    case B4800:
        speedTxt = "B4800";
        break;
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
    }
    return(speedTxt);
}

void
ElmoServoDrive::_replyTimedOut() {
	if (_driveResponding) {
		ELOG << _driveName << " servo drive is no longer responding";
	}

	_driveResponding = false;
	_waitingForSyncReply = false;

	if (! _unackedCmds.empty()) {
		std::ostringstream unackMsg;
		while (! _unackedCmds.empty()) {
			unackMsg << _unackedCmds.front().c_str() << ";";
			_unackedCmds.pop();
		}
		ELOG << _driveName << " commands: '" << unackMsg.str() <<
				"' were not acknowledged";
	}

	// Send a null command to try again for a response
	_execElmoCmd("");
}
