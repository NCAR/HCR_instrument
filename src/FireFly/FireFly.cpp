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
        _latestStatus(),
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
            DLOG << "select timeout";
            break;
        } else {
            if (errno == EINTR) /* system call was interrupted */
                continue;

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
    DLOG << "appended '" << _rawReply + _rawReplyLen - nread << "'";

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
        if (_lastCommandSent != replyLines[0]) {
            WLOG << "Got reply for '" << replyLines[0] << "' " <<
                    "when expecting a reply for '" << _lastCommandSent << "'" <<
                    "; dropping reply";
            throw(new std::exception());
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
    ILOG << "Parsing SYNC? reply:";
    for (size_t i = 0; i < replyLines.size(); i++) {
        ILOG << "line " << i << ": " << replyLines[i];
    }
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
    _awaitingReply = false;
    _sendNextCommand();
}

void
FireFly::_queueStatusQuery() {
    _queueCommand(_SYNC_INFO_CMD);
}

void
FireFly::_deviceNotResponding() {
    WLOG << "Device is " << (_deviceResponding ? "no longer" : "not") << " responding!";
    _deviceResponding = false;
}
