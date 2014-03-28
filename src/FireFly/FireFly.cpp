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
#include <boost/algorithm/string/trim.hpp>
#include <logx/Logging.h>

LOGGING("FireFly")

// The prompt string returned from the FireFly
const char * FireFly::_FIREFLY_PROMPT = "scpi > ";

// The reply returned on command error
const char * FireFly::_FIREFLY_CMD_ERR_REPLY = "Command Error\r\n";

// Command to get sync info
const char * FireFly::_SYNC_INFO_CMD = "SYNC?";

FireFly::FireFly(std::string ttyDev) :
        _ttyDev(ttyDev),
        _fd(-1),
        _deviceResponding(false),
        _lastCommandSent(),
        _commandQueue(),
        _rawReplyLen(0),
        _latestStatus() {
    ILOG << "FireFly on device " << _ttyDev;
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
    statusQueryTimer.setInterval(2000);  // 1/2 Hz
    connect(&statusQueryTimer, SIGNAL(timeout()), this, SLOT(_queueStatusQuery()));
    statusQueryTimer.start();

    // Create a timer used to make sure replies from the FireFly arrive
    // in a reasonable time. The timer is started when we send a command, and
    // stopped when a complete reply is received. If not stopped before it
    // expires, a call to _replyTimedOut() is initiated.
    _replyTimeoutTimer = new QTimer();
    _replyTimeoutTimer->setInterval(1000);   // allow up to 1 s for a reply
    _replyTimeoutTimer->setSingleShot(true);
    connect(_replyTimeoutTimer, SIGNAL(timeout()), this, SLOT(_replyTimedOut()));

    // Create a QSocketNotifier which watches our tty's file descriptor and
    // lets us know when something is available to read.
    _readReadyNotifier = new QSocketNotifier(_fd, QSocketNotifier::Read);
    connect(_readReadyNotifier, SIGNAL(activated(int)), this, SLOT(_doRead()));
    _readReadyNotifier->setEnabled(false);
    ILOG << "readReadyNotifier is " <<
            (_readReadyNotifier->isEnabled() ? "enabled" : "disabled");

    _queueCommand("");
    _queueCommand(_SYNC_INFO_CMD);

    exec();
}

void
FireFly::_doRead() {
    ILOG << "_doRead";

    _readReadyNotifier->setEnabled(false);
    ILOG << "readReadyNotifier is " <<
            (_readReadyNotifier->isEnabled() ? "enabled" : "disabled");

    bool gotReply = false;

    // If the device had not been responding, note that it is responding now
    if (! _deviceResponding) {
        _deviceResponding = true;
        ILOG << "FireFly-IIA is now responding";
    }

    // Read what's available on the serial port
    int maxRead = _REPLY_BUFFER_SIZE - _rawReplyLen;
    int nread = read(_fd, _rawReply + _rawReplyLen, maxRead);

    // Check for read error
    if (nread < 0) {
        ELOG << "Read error: " << strerror(errno);
        _readReadyNotifier->setEnabled(true);
        ILOG << "readReadyNotifier is " <<
                (_readReadyNotifier->isEnabled() ? "enabled" : "disabled");

        return;
    }
    _rawReplyLen += nread;

    // If we completely filled our reply buffer, it's a problem since there's
    // probably some unread reply bytes! Do our best to deal with it.
    if (_rawReplyLen == _REPLY_BUFFER_SIZE) {
        ELOG << "BUG: reply buffer overflow for FireFly; " << _rawReplyLen <<
                " reply bytes will be dropped. Increase _REPLY_BUFFER_SIZE!";
        throw(new std::exception());
    }

    _rawReply[_rawReplyLen] = '\0';
    DLOG << "appended '" << _rawReply + _rawReplyLen - nread << "'";

    // See if there's been a command error reported
    bool cmdError = (strstr(_rawReply, _FIREFLY_CMD_ERR_REPLY) != NULL);
    if (cmdError) {
        WLOG << "FireFly reported an error for command '" << _lastCommandSent
                << "'";
        // Empty the reply buffer
        _rawReplyLen = 0;
    }

    // Look for the FireFly prompt within the raw reply. If we find it,
    // everything up to the prompt is the complete reply.
    char * prompt = strstr(_rawReply, _FIREFLY_PROMPT);
    if (prompt) {
        gotReply = true;
        // Replace the first byte of the prompt with a NULL character, and
        // pass the resulting null-terminated reply string to our reply parser.
        int promptIndex = prompt - _rawReply;
        _rawReply[promptIndex] = '\0';
        _handleReply(_rawReply);

        // Now move bytes (if any) remaining after the prompt to the beginning
        // of the _rawReply buffer.
        int afterPromptIndex = promptIndex + strlen(_FIREFLY_PROMPT);
        _rawReplyLen -= afterPromptIndex;
        if (_rawReplyLen) {
            memmove(_rawReply, _rawReply + afterPromptIndex, _rawReplyLen);
            _rawReply[_rawReplyLen] = '\0';
            WLOG << _rawReplyLen << " extra bytes retained after reply: '" <<
                    _rawReply << "'";
        }
    }

    if (gotReply) {
        _replyTimeoutTimer->stop();
    } else {
        _readReadyNotifier->setEnabled(true);
        ILOG << "readReadyNotifier is " <<
                (_readReadyNotifier->isEnabled() ? "enabled" : "disabled");
    }

    // After we get a reply to a command, we can send the next one.
    if (! _readReadyNotifier->isEnabled()) {
        _sendNextCommand();
    }

    return;
}

void
FireFly::_handleReply(std::string reply) {
    // Remove trailing whitespace from the reply
    boost::trim_right(reply);

    // Handle reply based on the last command sent
    if (_lastCommandSent == _SYNC_INFO_CMD) {
        _parseSyncInfoReply(reply);
    } else if (_lastCommandSent.length() == 0) {
        if (reply.length() > 0) {
            WLOG << "Dropping unexpected reply to empty command: '" <<
                    reply << "'";
        }
    } else {
        ELOG << "Don't know how to parse the reply to '" << _lastCommandSent <<
                "' command!";
    }
}

void
FireFly::_parseSyncInfoReply(std::string reply) {
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
    //
    //    scpi >
    ILOG << "Parsing SYNC? reply";
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
FireFly::_queueCommand(const std::string & cmd) {
    // Queue this command
    ILOG << "Queuing command '" << cmd << "'";
    _commandQueue.push(cmd);

    // If we're not waiting for a reply from a previous command, send the
    // next one from the queue
    if (! _readReadyNotifier->isEnabled()) {
        _sendNextCommand();
    }
}

void
FireFly::_sendNextCommand() {
    ILOG << "_sendNextCommand";
    // If the queue is empty, just return
    if (_commandQueue.empty()) {
        return;
    }
    // No sending a command while we're awaiting a reply from a previous one
    if (_readReadyNotifier->isEnabled()) {
        WLOG << "Attempt to _sendNextCommand() while waiting for a reply.";
        return;
    }
    // Pop the command from the head of the queue
    std::string cmd = _commandQueue.front();
    _commandQueue.pop();
    ILOG << "Sending command '" << cmd << "'";

    // Append a "\r\n" terminator and send the command
    std::string cmdWithTerm = std::string(cmd) + "\r\n";
    if (write(_fd, cmdWithTerm.c_str(), cmdWithTerm.length()) < 0) {
        ELOG << "Error writing '" << cmd << "' to " << _ttyDev;
        return;
    }

    // The command is off, so we're waiting for a reply
    _lastCommandSent = cmd;
    _readReadyNotifier->setEnabled(true);
    ILOG << "readReadyNotifier is " <<
            (_readReadyNotifier->isEnabled() ? "enabled" : "disabled");
    _replyTimeoutTimer->start();
}

void
FireFly::_openTty() {
    DLOG << "Opening " << _ttyDev;
    if ((_fd = open(_ttyDev.c_str(), O_RDWR)) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error opening " << _ttyDev << ": " <<
                strerror(errno);
        exit(1);
    }

    // Make the port 115200 8N1, "raw"
    struct termios ios;
    if (tcgetattr(_fd, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error getting " << _ttyDev << 
                " attributes: " << strerror(errno);
        exit(1);
    }
    cfmakeraw(&ios);
    cfsetspeed(&ios, B115200);
    
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
FireFly::_setLatestStatus(const FireFlyStatus & status) {
    QMutexLocker locker(& _mutex);
    _latestStatus = status;
}

void
FireFly::_replyTimedOut() {
    WLOG << "Timeout waiting for reply to command '" << _lastCommandSent << "'";
    _readReadyNotifier->setEnabled(false);
    ILOG << "readReadyNotifier is " <<
            (_readReadyNotifier->isEnabled() ? "enabled" : "disabled");
    _sendNextCommand();
}

void
FireFly::_queueStatusQuery() {
    _queueCommand(_SYNC_INFO_CMD);
}
