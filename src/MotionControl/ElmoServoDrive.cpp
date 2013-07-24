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
#include <cmath>
#include <cstdlib>
#include <stdint.h>
#include <unistd.h>
#include <logx/Logging.h>

LOGGING("ElmoServoDrive")

ElmoServoDrive::ElmoServoDrive(const std::string ttyDev, const std::string driveName) :
    _ttyDev(ttyDev),
    _driveName(driveName),
    _fd(-1),
    _readNotifier(0),
    _driveResponding(false),
    _waitingForSync(false),
    _replyTimer(),
    _statusTimer(),
    _syncWaitTimer(),
    _syncReplyReceived(false),
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

    // Collect status information at 5 Hz rate
    _statusTimer.setInterval(200);	// 200 ms -> 5 Hz
    connect(& _statusTimer, SIGNAL(timeout()), this, SLOT(_collectStatus()));
    _statusTimer.start();

    // Assume that all replies to issued commands will arrive within 250 ms
    // when we're trying to sync commands and replies.
    _syncWaitTimer.setInterval(250);	// allow 250 ms for replies
    _syncWaitTimer.setSingleShot(true);
    connect(& _syncWaitTimer, SIGNAL(timeout()), this, SLOT(_syncWaitExpired()));

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

	// Normalize the angle into range 0-360
	angle = fmodf(angle, 360.0);
	if (angle < 0) {
		angle += 360.0;
	}

	// Convert angle to drive counts
    uint32_t counts = int(COUNTS_PER_DEGREE * angle);

    // Correct the occasional outlier due to floating point rounding which
    // yields COUNTS_PER_CIRCLE counts rather than zero.
    if (counts == COUNTS_PER_CIRCLE)
    	counts = 0;

    // Generate a command to move to the given absolute position
    std::ostringstream cmdstream;
    cmdstream << "PA=" << counts;
    _execElmoCmd(cmdstream.str());
    _execElmoCmd("BG");
}

void
ElmoServoDrive::setPVT(int p, int v, int t, int n) {
	// Don't bother if the drive is not responding
	if (! _driveResponding) {
		return;
	}

	std::ostringstream cmdstream;
	// Set position
	cmdstream << "QP[" << n << "]=" << p;
	_execElmoCmd(cmdstream.str());
	// Set velocity
	cmdstream.str("");
	cmdstream << "QV[" << n << "]=" << v;
	_execElmoCmd(cmdstream.str());
	// Set time
	cmdstream.str("");
	cmdstream << "QT[" << n << "]=" << t;
	_execElmoCmd(cmdstream.str());
}

void
ElmoServoDrive::scan(int n) {
	// Don't bother if the drive is not responding
	if (! _driveResponding) {
		return;
	}

	// Set PVT motion parameters
	_execElmoCmd("MP[1]=1");

	std::ostringstream cmdstream;
	cmdstream << "MP[2]=" << n;
	_execElmoCmd(cmdstream.str());

	_execElmoCmd("MP[3]=1");
	_execElmoCmd("PV=1");
	_execElmoCmd("BG");
}

bool
ElmoServoDrive::_execElmoCmd(const std::string cmd, bool emptyReplyExpected) {
	// TODO: verify that we got a single command, with no terminator characters
	// (or exactly one terminator at the end of the command)

	// Don't send commands while we're waiting to establish command/reply
	// synchronization.
	if (_waitingForSync) {
		DLOG << "Dropping command '" << cmd << "', waiting for sync";
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
    CmdQueueEntry entry(cmd, emptyReplyExpected);
   	_unackedCmds.push(entry);

    DLOG << "Sent command '" << cmd << "' to " << _driveName << " drive (" <<
    		_unackedCmds.size() << " unacked)";
    return(true);
}

void
ElmoServoDrive::_readReply() {
	/*
	 * Drop reply after we read it if this is the first response from the
	 * drive, or if we're waiting for a reply to establish command/reply
	 * synchronization.
	 */
	bool dropReply = _waitingForSync || ! _driveResponding;

	/*
	 * Stop the reply timer and note that the drive is now responding.
	 */
	_replyTimer.stop();
	if (! _driveResponding) {
		ILOG << _driveName << " drive is now responding";
		_startCommandReplySync();
	} else if (_waitingForSync) {
		_syncReplyReceived = true;
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
		// Reset and start over...
		_startCommandReplySync();
		return;
	}

	// If requested, just drop the reply and return.
	if (dropReply) {
		_rawReply[_rawReplyLen] = '\0';
		DLOG << _driveName << " dropping reply '" << _rawReply << "'";
		_rawReplyLen = 0;
		return;
	}

	_rawReply[_rawReplyLen] = '\0';
	DLOG << _driveName << " raw reply '" << _rawReply << "', with " <<
			_unackedCmds.size() << " unacked";

	// Pointer to the last found terminator character ";"
	uint8_t * term = 0;

	// Parse replies in order by finding their semicolon terminators, removing
	// the associated commands from our unacknowledged queue.
	int startNdx = 0;
	while (startNdx < _rawReplyLen) {
		// Find the next semicolon terminator at or after startNdx
		term = static_cast<uint8_t *>(memchr(_rawReply + startNdx, ';', _rawReplyLen - startNdx));

		if (! term)
			break;

		// Get the next unacknowledged command
		std::string cmd = _unackedCmds.front().cmdText;
		bool emptyReplyExpected = _unackedCmds.front().emptyReplyExpected;

		int replySize = term - (_rawReply + startNdx);
		if (replySize == 0) {
			if (emptyReplyExpected) {
				// Empty reply indicates success
				DLOG << _driveName << " command '" << cmd << "' succeeded";
			} else {
				ELOG << _driveName << ": No value included in reply to '" <<
						cmd << "' command. Resynchronizing commands a replies.";
				// Reset and start over...
				this->_startCommandReplySync();
				return;
			}
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
				if (! emptyReplyExpected) {
					DLOG << _driveName << " command '" << cmd << "' replied '" <<
							cmdReply << "'";
				} else {
					ELOG << _driveName << " command '" << cmd << "' " <<
							"gave unexpected reply '" << cmdReply << "'. " <<
							"Resynchronizing commands and replies.";
					_startCommandReplySync();
					return;
				}

				QString qCmdReply(reinterpret_cast<char*>(cmdReply));
				bool ok;

				// Look for replies to status requests we've made, and stash
				// the returned values.

				// Save reply from SR "status register" command
				if (! cmd.compare("SR")) {
					StatusReg statusRegister = qCmdReply.toInt(&ok);
					if (ok) {
						_driveStatusRegister = statusRegister;
					} else {
						WLOG << _driveName << ": bad SR reply '" <<
								cmdReply << "'";
					}
				}

				// Save reply from TI[1] "temperature indicator 1" command
				if (! cmd.compare("TI[1]")) {
					uint32_t temp = qCmdReply.toInt(&ok);
					if (ok) {
						_driveTemperature = temp;	// drive temperature, deg C
					} else {
						WLOG << _driveName << ": bad TI[1] reply '" <<
								cmdReply << "'";
					}
				}

				// Save reply from TM "system time" command
				if (! cmd.compare("TM")) {
					// System time is actually a 32-bit unsigned count, but
					// the reply sends it as a signed value. We'll convert
					// to unsigned as long as the value parses as an int.
					int32_t time = qCmdReply.toInt(&ok);
					if (ok) {
						// Reinterpret the returned value as an *unsigned*
						// 32-bit int.
						_driveSystemTime = *(reinterpret_cast<uint32_t*>(&time));
					} else {
						WLOG << _driveName << ": bad TM reply '" <<
								cmdReply << "'";
					}
				}
			}
			delete(cmdReply);
		}
		// Remove the front command from our unacknowledged queue; it's now
		// acknowledged.
		_unackedCmds.pop();

		// Move past the reply we just parsed
		startNdx += replySize + 1;
	}

	// If the buffer did not end with a terminator, save the remainder for next
	// time around.
	if (term) {
		// We parsed it all
		_rawReplyLen = 0;
	} else {
		// Shift the stuff we didn't parse to the beginning of _rawReply.
		int nkeep = _rawReplyLen - startNdx;
		memmove(_rawReply, _rawReply + startNdx, nkeep);
		_rawReplyLen = nkeep;
		_rawReply[_rawReplyLen] = 0;
		DLOG << _driveName << ": " << nkeep << " unparsed reply bytes. " <<
				"Remainder is '" <<	_rawReply << "'";
	}

	return;
}

void
ElmoServoDrive::_startCommandReplySync() {
	// Make sure echo is disabled, since we require echo off when sync'ing
	// replies with our queue of unacknowledged commands.
	_execElmoCmd("EO=0");

	// No more commands will be sent while _waitingForReplySync is true.
	// Wait long enough for all pending replies to be received, then
	// command/reply synchronization should be established.
	_rawReplyLen = 0;
	_driveResponding = true;
	_waitingForSync = true;
	_syncReplyReceived = false;
	_syncWaitTimer.start();
}

void
ElmoServoDrive::_syncWaitExpired() {
	// Empty the list of unacknowledged commands
	while (! _unackedCmds.empty()) {
		_unackedCmds.pop();
	}
	// We're done waiting for sync reply. Let commands go to the drive again.
	_waitingForSync = false;

	// If we got no replies while we were waiting, treat it as a reply timeout.
	// Otherwise, command/reply synchronization has been achieved!
	if (! _syncReplyReceived) {
		_replyTimedOut();
	} else {
		ILOG << _driveName << " commands and replies are now synced";
	}
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
	// Ignore reply timeouts while we're waiting for synchronization
	if (_waitingForSync) {
		ILOG << _driveName <<
			" ignoring reply timeout while waiting for synchronization";
		return;
	}

	// If the drive had been responding, note that it is no longer responding.
	if (_driveResponding) {
		ELOG << _driveName << " servo drive is no longer responding";
	}

	_driveResponding = false;
	_resetStatus();

	// Send a null command to try again for a response
	_execElmoCmd("");
}

void
ElmoServoDrive::_collectStatus() {
	// Send commands to the drive to get back status values we want. The
	// status values will be parsed out and saved in _readReply when the
	// replies come back.
	_execElmoCmd("SR", false);		// status register
	_execElmoCmd("TI[1]", false);	// "temperature indicator 1", drive temperature
	_execElmoCmd("TM", false);		// system time
}

void
ElmoServoDrive::_resetStatus() {
	_driveTemperature = 0;
	_driveStatusRegister = 0;
}
