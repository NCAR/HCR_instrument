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
 * FireFly.cpp
 *
 *  Created on: Mar 26, 2014
 *      Author: burghart
 */

#include "FireFly.h"

#include <cerrno>
#include <cstdlib>
#include <termios.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <QMetaType>
#include <boost/algorithm/string/trim.hpp>
#include <boost/algorithm/string/split.hpp>
#include <logx/Logging.h>

LOGGING("FireFly")

// The prompt string returned from the FireFly
const std::string FireFly::_FIREFLY_PROMPT("scpi > ");

// The reply returned on command error
const std::string FireFly::_FIREFLY_CMD_ERR_REPLY("Command Error\r\n");

// Command to get sync info
const std::string FireFly::_SYNC_INFO_CMD("SYNC?");

FireFly::FireFly(std::string ttyDev) :
        _ttyDev(ttyDev),
        _fd(-1),
        _deviceResponding(false),
        _lastCommandSent(),
        _awaitingReply(false),
        _commandQueue(),
        _replyTimeoutTimer(NULL),
        _status(),
        _rawReplyLen(0) {
    ILOG << "FireFly on device " << _ttyDev;
    // Open the serial port
    _openTty();

    // We send std::string in signals, so register it as a QMetaType
    qRegisterMetaType<std::string>("std::string");

    // Upon thread start, call _tryRead()
    connect(this, SIGNAL(started()), this, SLOT(_tryRead()));

    // Start our thread
    start();
}

FireFly::~FireFly() {
    quit();
    if (! wait(1000)) {
        WLOG << "FireFly thread did not quit in 1 second. Exiting anyway.";
    }
}

void
FireFly::run() {
    // Set up a timer to queue up status query commands on a regular basis.
    QTimer * statusQueryTimer = new QTimer();
    statusQueryTimer->setInterval(2000);  // 1/2 Hz
    connect(statusQueryTimer, SIGNAL(timeout()), this, SLOT(_queueStatusQuery()));
    statusQueryTimer->start();

    // Create a timer used to make sure replies from the FireFly arrive
    // in a reasonable time. The timer is started when we send a command, and
    // stopped when a complete reply is received. If not stopped before it
    // expires, a call to _replyTimedOut() is initiated.
    _replyTimeoutTimer = new QTimer();
    _replyTimeoutTimer->setInterval(250);   // allow up to 250 ms for a reply
    _replyTimeoutTimer->setSingleShot(true);
    connect(_replyTimeoutTimer, SIGNAL(timeout()), this, SLOT(_replyTimedOut()));

    // Create a timer which will mark the device as unresponsive if we get no
    // replies at all for a while. The timer is restarted whenever a response
    // is received from the device.
    _deviceRespondingTimer = new QTimer();
    _deviceRespondingTimer->setInterval(10000);     // 10 s
    connect(_deviceRespondingTimer, SIGNAL(timeout()),
            this, SLOT(_deviceNotResponding()));
    _deviceRespondingTimer->start();

    // Queue our first sync status request immediately
    _queueCommand(_SYNC_INFO_CMD);

    // Set up a single shot timer to make the first call to _tryRead().
    QTimer::singleShot(0, this, SLOT(_tryRead()));

    // Start the event loop, which generally runs until our destructor is
    // called.
    exec();

	delete(_deviceRespondingTimer);
    delete(_replyTimeoutTimer);
    delete(statusQueryTimer);
}

void
FireFly::_tryRead()
{
    uint16_t timeoutMsecs = 100;    // Wait up to 0.1 second for available input

    // select for read on _fd file descriptor
    fd_set readFds;
    FD_ZERO(&readFds);
    FD_SET(_fd, &readFds);

    // Looping only occurs here if we get an EINTR error from select, in which
    // case we come back and try again.
    while (true) {
        /*
         * set timeval structure
         */
        struct timeval timeout;
        timeout.tv_sec = timeoutMsecs / 1000;
        timeout.tv_usec = (timeoutMsecs % 1000) * 1000;

        int nready = select(_fd + 1, &readFds, NULL, NULL, &timeout);
        if (nready == 1) {
            // Something's available. Go read it.
            _doRead();
            break;
        } else if (nready == 0) {
            break;  // select() timed out
        } else {
            if (errno == EINTR) // system call was interrupted
                continue;   // go back and try again

            ELOG << "select error: " << strerror(errno);

            break;
        }
    }

    // Set a zero-interval single shot timer to call back here after any
    // pending event processing occurs.
    QTimer::singleShot(0, this, SLOT(_tryRead()));

    return;
}

void
FireFly::_doRead() {
    // Read what's available on the serial port and append it to our _rawReply
    // buffer.
    int maxRead = _REPLY_BUFFER_SIZE - _rawReplyLen;
    int nread = read(_fd, _rawReply + _rawReplyLen, maxRead);

    // Check for read error
    if (nread < 0) {
        ELOG << "Read error: " << strerror(errno);
        return;
    }
    _rawReplyLen += nread;

    // Mark the device as responsive, and reset the _deviceRespondingTimer
    _deviceResponding = true;
    _deviceRespondingTimer->start();

    // If we completely filled our reply buffer, there's a problem.
    if (_rawReplyLen == _REPLY_BUFFER_SIZE) {
        ELOG << "BUG: reply buffer overflow for FireFly; " <<
                " Increase _REPLY_BUFFER_SIZE!";
        throw(new std::exception());
    }

    _rawReply[_rawReplyLen] = '\0';
    DLOG << "appended " << nread << ": '" << _rawReply + _rawReplyLen - nread <<
            "'";

    // If there are NULL characters in the reply (can happen when the unit
    // is first powered up), only keep everything after the last NULL read.
    int nChopped = 0;
    while (strlen(_rawReply) < _rawReplyLen) {
        int nRemove = strlen(_rawReply) + 1;
        _rawReplyLen -= nRemove;
        memmove(_rawReply, _rawReply + nRemove, _rawReplyLen);
        nChopped += nRemove;
    }
    if (nChopped) {
        DLOG << "Chopped " << nChopped << " bytes for nulls, leaving " <<
                _rawReplyLen;
    }

    // See if there's been a command error reported
    char * cmdErrorPtr = strstr(_rawReply, _FIREFLY_CMD_ERR_REPLY.c_str());
    bool cmdError = (cmdErrorPtr != NULL);
    if (cmdError) {
        // "Command error" counts as a reply, so call the handler.
        _handleReply(true, "");
        // Move anything after the "Command Error" message to the head of our
        // _rawReply buffer.
        int afterErrorIndex = (cmdErrorPtr - _rawReply) +
                _FIREFLY_CMD_ERR_REPLY.length();
        _rawReplyLen -= afterErrorIndex;
        if (_rawReplyLen) {
            memmove(_rawReply, _rawReply + afterErrorIndex, _rawReplyLen);
            _rawReply[_rawReplyLen] = '\0';
            WLOG << _rawReplyLen <<
                    " extra bytes retained after command error report";
        }
        return;
    }

    // Look for the FireFly prompt within the raw reply. If we find it,
    // everything up to the prompt is the complete reply to our last command.
    char * prompt = strstr(_rawReply, _FIREFLY_PROMPT.c_str());
    if (prompt) {
        // Replace the first byte of the prompt with a NULL character, and
        // pass the resulting null-terminated reply string to our reply parser.
        int promptIndex = prompt - _rawReply;
        _rawReply[promptIndex] = '\0';
        _handleReply(false, std::string(_rawReply));

        // Now move bytes (if any) remaining after the prompt to the beginning
        // of the _rawReply buffer.
        int afterPromptIndex = promptIndex + _FIREFLY_PROMPT.length();
        _rawReplyLen -= afterPromptIndex;
        if (_rawReplyLen) {
            memmove(_rawReply, _rawReply + afterPromptIndex, _rawReplyLen);
            _rawReply[_rawReplyLen] = '\0';
            WLOG << _rawReplyLen << " extra bytes retained after reply: '" <<
                    _rawReply << "'";
        }
    }

    return;
}

void
FireFly::_handleReply(bool cmdError, std::string reply) {
    if (! _awaitingReply) {
        WLOG << "Dropping unexpected reply (could have arrived after timeout)";
    } else if (cmdError){
        // Just note a command error
        ELOG << "FireFly reported 'Command Error' for command: '" <<
                _lastCommandSent << "'";
    } else {
        // Remove trailing whitespace from the reply, then split it into lines
        // at any combination of '\r' and/or '\n'.
        boost::trim_right(reply);
        std::vector<std::string> replyLines;
        boost::split(replyLines, reply, boost::is_any_of("\r\n"),
                boost::token_compress_on);

        // The first line should match _lastCommandSent, or we're out of sync...
        // If we lose sync (e.g., if FireFly power is cycled while we're
        // running), we'll usually be back in sync for commands after this.
        if (_lastCommandSent != replyLines[0]) {
            WLOG << "Got reply for '" << replyLines[0] << "' " <<
                    "when expecting a reply for '" << _lastCommandSent << "'" <<
                    "; dropping reply";
            return;
        }

        // Remove the command echo from the reply.
        replyLines.erase(replyLines.begin());

        // Handle reply based on the last command sent
        if (_lastCommandSent == _SYNC_INFO_CMD) {
            _parseSyncInfoReply(replyLines);
        } else if (_lastCommandSent.length() == 0) {
            if (reply.length() > 0) {
                WLOG << "Dropping unexpected reply to empty command: '" <<
                        reply << "'";
            }
        } else {
            ELOG << "Don't know how to parse the reply to '" <<
                    _lastCommandSent << "' command!";
        }
    }

    // We got a reply, so stop _replyTimeoutTimer and note that we are no longer
    // awaiting a reply.
    _replyTimeoutTimer->stop();
    _awaitingReply = false;

    // Finally, send the next queued command.
    _sendNextCommand();
}

void
FireFly::_parseSyncInfoReply(const std::vector<std::string> & replyLines) {
    // Have we detected an error in FireFly-IIA configuration?
    bool configError = false;

    // Example FireFly reply to "SYNC?" command:
    //    1PPS SOURCE MODE  : GPS
    //    1PPS SOURCE STATE : GPS
    //    1PPS LOCK STATUS  : 1
    //    1PPS OUTPUT ON RESET : OFF
    //    HOLDOVER STATE: NONE
    //    LAST HOLDOVER DURATION 24,0
    //    FREQ ERROR ESTIMATE 7.59E-12
    //    TIME INTERVAL DIFFERENCE 7.465E-09
    //    HEALTH STATUS : 0x0
    if (replyLines.size() != 9) {
        WLOG << "Got " << replyLines.size() << " lines in reply to '" <<
                _SYNC_INFO_CMD << "' but expected 9. Entire reply dropped.";
        for (size_t i = 0; i < replyLines.size(); i++) {
            WLOG << "line " << i << ": " << replyLines[i];
        }
        _setBadStatus();
        return;
    }

    // Line 0 holds 1 PPS source mode, which should be 'GPS'. Complain if it's
    // not.
    char sourceMode1PPS[32];
    if (sscanf(replyLines[0].data(), "1PPS SOURCE MODE  : %s",
            sourceMode1PPS) != 1) {
        WLOG << "Bad '1 PPS source mode' line: " <<
                "'" << replyLines[0] << "'. Entire reply dropped.";
        _setBadStatus();
        return;
    }
    if (strncmp(sourceMode1PPS, "GPS", 3)) {
        WLOG << "1 PPS source mode should be 'GPS', but is " <<
                "'" << sourceMode1PPS << "'!";
        configError = true;
    }

    // Line 1 holds 1 PPS source state. Skip it.

    // Line 2 holds 1 PPS lock status (0|1)
    int iState;
    if (sscanf(replyLines[2].data(), "1PPS LOCK STATUS  : %d", &iState) != 1) {
        WLOG << "Bad '1 PPS lock status' line: " <<
                "'" << replyLines[2] << "'. Entire reply dropped.";
        _setBadStatus();
        return;
    }
    bool locked1PPS = iState;
    DLOG << "1 PPS locked: " << (locked1PPS ? "TRUE" : "FALSE");

    // Line 3 tells whether 1 PPS is output immediately after reset (before
    // GPS lock). This should be 'OFF'!
    char ppsOutputOnReset[32];
    if (sscanf(replyLines[3].data(), "1PPS OUTPUT ON RESET : %s",
            ppsOutputOnReset) != 1) {
        WLOG << "Bad '1 PPS output on reset' line: " <<
                "'" << replyLines[3] << "'. Entire reply dropped.";
        _setBadStatus();
        return;
    }
    if (strncmp(ppsOutputOnReset, "OFF", 3)) {
        WLOG << "1 PPS output on reset should be 'OFF', but is " <<
                "'" << ppsOutputOnReset << "'!";
        configError = true;
    }

    // Line 4 tells holdover state (ON|NONE), but line 5 tells us that
    // and more. Skip this one.

    // Line 5 tells holdover duration in seconds (for current holdover if the
    // unit is in holdover, otherwise for previous holdover), and whether the
    // unit is currently in holdover.
    int lastHoldoverDurationSecs;
    if (sscanf(replyLines[5].data(), "LAST HOLDOVER DURATION %d,%d",
            &lastHoldoverDurationSecs, &iState) != 2) {
        WLOG << "Bad 'holdover duration' line: " <<
                "'" << replyLines[5] << "'. Entire reply dropped.";
        _setBadStatus();
        return;
    }
    bool inHoldover = iState;
    DLOG << "Last holdover duration: " << lastHoldoverDurationSecs << " s. " <<
            "In holdover: " << (inHoldover ? "TRUE" : "FALSE");

    // Line 6 gives the frequency error estimate
    float freqErrorEstimate;
    if (sscanf(replyLines[6].data(), "FREQ ERROR ESTIMATE %f",
            &freqErrorEstimate) != 1) {
        WLOG << "Bad 'frequency error estimate' line: " <<
                "'" << replyLines[6] << "'. Entire reply dropped.";
        _setBadStatus();
        return;
    }
    DLOG << "Frequency error estimate: " << freqErrorEstimate;

    // Line 7 gives the time difference between the FireFly-IIA 1 PPS output
    // and the GPS time 1 PPS.
    float timeDiff1PPS;
    if (sscanf(replyLines[7].data(), "TIME INTERVAL DIFFERENCE %f",
            &timeDiff1PPS) != 1) {
        WLOG << "Bad '1 PPS time difference' line: " <<
                "'" << replyLines[7] << "'. Entire reply dropped.";
        _setBadStatus();
        return;
    }
    DLOG << "1 PPS time difference: " << timeDiff1PPS;

    // Line 8 gives health status. Zero is good. See FireFly-IIA documentation
    // for details of the status bits.
    int healthStatus;
    if (sscanf(replyLines[8].data(), "HEALTH STATUS : %x",
            &healthStatus) != 1) {
        WLOG << "Bad 'health status' line: " <<
                "'" << replyLines[8] << "'. Entire reply dropped.";
        _setBadStatus();
        return;
    }
    DLOG << "health status: 0x" << std::hex << healthStatus;

    DLOG << "FireFly config error: " << (configError ? "TRUE" : "FALSE");

    // Parsing was successful. Build the current status.
    _status = FireFlyStatus(_deviceResponding, locked1PPS,
            lastHoldoverDurationSecs, inHoldover, freqErrorEstimate,
            timeDiff1PPS, healthStatus, configError);
}

void
FireFly::_queueCommand(const std::string & cmd) {
    // Queue this command
    DLOG << "Queuing command '" << cmd << "'";
    _commandQueue.push(cmd);

    // If we're not waiting for a reply from a previous command, send the
    // next one from the queue
    if (! _awaitingReply) {
        _sendNextCommand();
    }
}

void
FireFly::_sendNextCommand() {
    // If the queue is empty, just return
    if (_commandQueue.empty()) {
        DLOG << "_sendNextCommand() exiting with no commands queued";
        return;
    }
    // No sending a command while we're awaiting a reply from a previous one
    if (_awaitingReply) {
        WLOG << "Attempt to _sendNextCommand() while waiting for a reply.";
        return;
    }
    // Pop the command from the head of the queue
    std::string cmd = _commandQueue.front();
    _commandQueue.pop();
    DLOG << "Sending command '" << cmd << "'";

    // Append a "\r\n" terminator and send the command
    std::string cmdWithTerm = std::string(cmd) + "\r\n";
    if (write(_fd, cmdWithTerm.c_str(), cmdWithTerm.length()) < 0) {
        ELOG << "Error writing '" << cmd << "' to " << _ttyDev;
        return;
    }

    // The command is off, so we're waiting for a reply
    _lastCommandSent = cmd;
    _awaitingReply = true;
    _replyTimeoutTimer->start();
}

void
FireFly::_openTty() {
    DLOG << "Opening " << _ttyDev;
    if ((_fd = open(_ttyDev.c_str(), O_RDWR)) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error opening " << _ttyDev << ": " <<
                strerror(errno);
        ::exit(1);
    }

    // We want exclusive access to the device
    if (ioctl(_fd, TIOCEXCL)) {
        ELOG << __PRETTY_FUNCTION__ << ": error setting exclusive access to " <<
                _ttyDev << ": " << strerror(errno);
        ::exit(1);
    }

    // Make the port 115200 8N1, "raw"
    struct termios ios;
    if (tcgetattr(_fd, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error getting " << _ttyDev << 
                " attributes: " << strerror(errno);
        ::exit(1);
    }
    cfmakeraw(&ios);
    cfsetspeed(&ios, B115200);
    
    // Set a 0.2 second timeout for reads
    ios.c_cc[VMIN] = 0;
    ios.c_cc[VTIME] = 2;    // 0.2 seconds

    if (tcsetattr(_fd, TCSAFLUSH, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error setting " << _ttyDev << 
                " attributes: " << strerror(errno);
        ::exit(1);
    }
    DLOG << "Done configuring " << _ttyDev;
}

void
FireFly::_replyTimedOut() {
    WLOG << "Timeout waiting for reply to command '" << _lastCommandSent << "'";
    _awaitingReply = false;
    _sendNextCommand();
}

void
FireFly::_queueStatusQuery() {
    // Send the "SYNC?" command to get synchronization status
    _queueCommand(_SYNC_INFO_CMD);
}

void
FireFly::_deviceNotResponding() {
    WLOG << "Device is " << (_deviceResponding ? "no longer" : "not") << " responding!";
    _deviceResponding = false;
    // Set the latest status to a default bad/not-responding status
    _setBadStatus();
}
