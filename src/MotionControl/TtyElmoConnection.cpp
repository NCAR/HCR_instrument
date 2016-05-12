// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2016                                         
// ** University Corporation for Atmospheric Research (UCAR)                 
// ** National Center for Atmospheric Research (NCAR)                        
// ** Boulder, Colorado, USA                                                 
// ** BSD licence applies - redistribution and use in source and binary      
// ** forms, with or without modification, are permitted provided that       
// ** the following conditions are met:                                      
// ** 1) If the software is modified to produce derivative works,            
// ** such modified software should be clearly marked, so as not             
// ** to confuse it with the version available from UCAR.                    
// ** 2) Redistributions of source code must retain the above copyright      
// ** notice, this list of conditions and the following disclaimer.          
// ** 3) Redistributions in binary form must reproduce the above copyright   
// ** notice, this list of conditions and the following disclaimer in the    
// ** documentation and/or other materials provided with the distribution.   
// ** 4) Neither the name of UCAR nor the names of its contributors,         
// ** if any, may be used to endorse or promote products derived from        
// ** this software without specific prior written permission.               
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS  
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED      
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.    
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
/*
 * TtyElmoConnection.cpp
 *
 *  Created on: Feb 26, 2014
 *      Author: burghart
 */

#include "TtyElmoConnection.h"
#include <cerrno>
#include <cstdlib>
#include <cstring>
#include <sstream>
#include <unistd.h>
#include <logx/Logging.h>

LOGGING("TtyElmoConnection")

TtyElmoConnection::TtyElmoConnection(std::string ttyDev, std::string driveName) : 
        _ttyDev(ttyDev),
        _driveName(driveName),
        _fd(-1),
        _readNotifier(0),
        _waitingForSync(false),
        _replyTimer(),
        _driveResponding(false),
        _gpTimer(),
        _syncReplyReceived(false),
        _rawReplyLen(0) {
    // Open the serial port to the drive
    DLOG << "Instantiating tty_ElmoConnection '" << _driveName << "' on device " <<
            _ttyDev;
    _openTty();

    // Use our notifier to call _readReply() whenever the servo drive sends
    // a reply.
    _readNotifier = new QSocketNotifier(_fd, QSocketNotifier::Read);
    connect(_readNotifier, SIGNAL(activated(int)), this, SLOT(_readReply()));

    // If replies from the servo drive do not arrive within a specified
    // interval, call _replyTimedOut().
    _replyTimer.setInterval(REPLY_TIMEOUT_MSECS);
    _replyTimer.setSingleShot(true);
    connect(& _replyTimer, SIGNAL(timeout()), this, SLOT(_replyTimedOut()));

    // Send a null command just to get a reply from the drive.
    _execElmoCmd("");
    ILOG << "Waiting for first response from " << _driveName << " drive";
}

TtyElmoConnection::~TtyElmoConnection() {
    delete(_readNotifier);
    // Stop the motor
    _execElmoCmd("MO=0");
    
    // Turn on echo again. Elmo's Composer software requires echo on in order
    // to function, so we try to leave the servo drive in a state to talk to
    // Composer.
    _execElmoCmd("EO=1");
    
    // Close the tty device
    close(_fd);
}

bool
TtyElmoConnection::_cmdIsValid(std::string cmd) {
    // Verify that the command is either two characters long or that
    // it begins with "XQ##".
    bool ok = (cmd.length() >= 2);
    ok = ok && isupper(cmd[0]) && isupper(cmd[1]);
    if (cmd.length() > 2)
        ok = ok && (cmd.compare(0, 4, "XQ##") == 0);
    
    if (! ok) {
        ELOG << "execElmoCmd() command must be exactly two upper case " <<
                "letters or start with XQ##. " <<
                "Bad command: '" << cmd << "'";
    }
    return(ok);
}

bool
TtyElmoConnection::execElmoCmd(std::string cmd, uint16_t index) {
    // Make sure the command's OK
    if (! _cmdIsValid(cmd)) {
        return(false);
    }
    
    // Build the full text command, appending "[<index>]" if index is non-zero.
    std::ostringstream os;
    os << cmd;
    if (index) {
        os << "[" << index << "]";
    }
    // No reply expected from BG or KL.
    bool replyExpected = (cmd.compare(0, 2, "BG") != 0) && 
            (cmd.compare(0, 2, "KL") != 0);
    
    return(_execElmoCmd(os.str(), replyExpected));
}

bool
TtyElmoConnection::execElmoAssignCmd(std::string cmd, uint16_t index, int value) {
    // Make sure the command's OK
    if (! _cmdIsValid(cmd)) {
        return(false);
    }
    
    // Build the full text command in a stream
    std::ostringstream os;
    os << cmd;
    // Append the index if necessary
    if (index) {
        os << "[" << index << "]";
    }
    // Append the assignment portion
    os << "=" << value;
    
    // No reply expected when assigning.
    bool replyExpected = false;
    return(_execElmoCmd(os.str(), replyExpected));
}

bool
TtyElmoConnection::_execElmoCmd(const std::string cmd, bool emptyReplyExpected) {
    // Don't send commands while we're waiting to establish command/reply
    // synchronization.
    if (_waitingForSync) {
        DLOG << _driveName << ": dropping command '" << cmd << "', waiting for sync";
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

    DLOG << _driveName << ": sent command '" << cmd << "' (" <<
            _unackedCmds.size() << " unacked)";
    return(true);
}

void
TtyElmoConnection::_openTty() {
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
TtyElmoConnection::_readReply() {
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

        int replySize = term - (_rawReply + startNdx);
        if (replySize == 0) {
            DLOG << _driveName << " command '" << cmd << 
                    "' returned an empty reply";
            emit(replyFromExec(cmd, EmptyReply, 0, 0.0));
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
                emit(replyFromExec(cmd, ErrorReply, errorCode, 0.0));
            } else {
                // The reply should parse as either an int or a float. Do
                // the parsing and emit a signal with the value returned.
                QString qCmdReply(reinterpret_cast<char*>(cmdReply));
                bool ok;
                int iVal = qCmdReply.toInt(&ok);
                if (ok) {
                    DLOG << _driveName << " command '" << cmd << 
                            "' gave int reply " << cmdReply;
                    emit(replyFromExec(cmd, IntReply, iVal, 0.0));
                } else {
                    float fVal = qCmdReply.toFloat(&ok);
                    if (ok) {
                        DLOG << _driveName << " command '" << cmd << 
                                "' gave float reply " << cmdReply;
                        emit(replyFromExec(cmd, FloatReply, 0, fVal));
                    } else {
                        ELOG << "BUG: " << _driveName << " command '" << cmd <<
                                "' reply ('" << cmdReply << 
                                "') cannot be parsed as int or float";
                        // Report a reply error of -1
                        emit(replyFromExec(cmd, ErrorReply, -1, 0.0));
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
                "Remainder is '" <<    _rawReply << "'";
    }

    return;
}

void
TtyElmoConnection::reinitialize() {
    // Just synchronize commands with replies again
    _startCommandReplySync();
}

void
TtyElmoConnection::_startCommandReplySync() {
    // Send a command to turn off echo. We need echo off, since all we want
    // to see on the serial line is the replies from the Elmo. This command also
    // serves to elicit a response from the drive, and we will verify arrival
    // of a response.
    _execElmoCmd("EO=0");

    // Stop accepting calls to execElmoCmd() if we are currently accepting them
    if (readyToExec()) {
        emit(readyToExecChanged(false));
    }
    // No more commands will be sent while _waitingForSync is true. Wait long 
    // enough for all pending replies to be received, then our command/reply 
    // synchronization should be established.
    _rawReplyLen = 0;
    _driveResponding = true;
    _waitingForSync = true;
    _syncReplyReceived = false;

    // Assume that all replies from the drive, up to and including the reply
    // to the command issued above, will arrive within REPLY_TIMEOUT_MSECS.
    // We assume sync if we receive at least one reply before 
    // REPLY_TIMEOUT_MSECS elapses.
    _gpTimer.setInterval(REPLY_TIMEOUT_MSECS);
    _gpTimer.setSingleShot(true);
    connect(& _gpTimer, SIGNAL(timeout()), this, SLOT(_syncWaitExpired()));
    _gpTimer.start();
}

void
TtyElmoConnection::_syncWaitExpired() {
    // Disconnect the timer signal from this slot. This was a one-time deal!
    _gpTimer.stop();
    _gpTimer.disconnect(this);

    // Empty the list of unacknowledged commands
    while (! _unackedCmds.empty()) {
        _unackedCmds.pop();
    }
    // We're done waiting for sync reply. Let commands go to the drive again.
    _waitingForSync = false;

    // If we got no replies while we were waiting, treat it as a reply timeout.
    // Otherwise, command/reply synchronization has been achieved!
    if (! _syncReplyReceived) {
        ILOG << _driveName << " sync reply not received";
        _replyTimedOut();
    } else {
        ILOG << _driveName << " commands and replies are now synced";
        // We are now ready to accept execElmoCmd() calls.
        emit(readyToExecChanged(true));
    }
}

void
TtyElmoConnection::_setBaud(speed_t baudValue) {
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
TtyElmoConnection::_BaudToText(speed_t baudValue) {
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
TtyElmoConnection::_replyTimedOut() {
    // Ignore reply timeouts while we're waiting for synchronization
    if (_waitingForSync) {
        ILOG << _driveName <<
                " ignoring reply timeout while waiting for synchronization";
        return;
    }

    // If the drive had been responding, note that it is no longer responding.
    if (_driveResponding) {
        _driveResponding = false;
        ELOG << _driveName << " servo drive is no longer responding";
        // Stop accepting execElmoCmd() calls for the time being
        emit(readyToExecChanged(false));
    }

    // Send a null command to try again for a response
    _execElmoCmd("");
}
