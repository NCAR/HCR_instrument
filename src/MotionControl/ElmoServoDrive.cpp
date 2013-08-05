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
#include <unistd.h>
#include <logx/Logging.h>
#include <QCoreApplication>

LOGGING("ElmoServoDrive")

ElmoServoDrive::ElmoServoDrive(const std::string ttyDev, const std::string driveName) :
    _ttyDev(ttyDev),
    _driveName(driveName),
    _fd(-1),
    _readNotifier(0),
    _driveResponding(false),
    _driveInitialized(false),
    _driveHomed(false),
    _waitingForSync(false),
    _replyTimer(),
    _statusTimer(),
    _gpTimer(),
    _syncReplyReceived(false),
    _rawReplyLen(0) {
    // Start with bad values for drive count range and position controller
    // sample time. We query the real values from the drive after it's
    // initialized.
    _clearDriveParams();

    // Open the serial port to the drive
    DLOG << "Instantiating ElmoServoDrive '" << _driveName << "' on device " <<
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

    // Collect status information every STATUS_PERIOD_MSECS milliseconds.
    _statusTimer.setInterval(STATUS_PERIOD_MSECS);
    connect(& _statusTimer, SIGNAL(timeout()), this, SLOT(_collectStatus()));
    _statusTimer.start();

    // Send a null command just to get a reply from the drive.
    _execElmoCmd("");
    ILOG << "Waiting for first response from " << _driveName << " drive";
}

ElmoServoDrive::~ElmoServoDrive() {
    delete(_readNotifier);
    // Stop the motor
    _execElmoCmd("MO=0");
    // Turn on echo again. Elmo's Composer software requires echo on in order
    // to function, so we try to leave the servo drive in a state to talk to
    // Composer.
    _execElmoCmd("EO=1");
}

void
ElmoServoDrive::_clearDriveParams() {
    _positionMinCnt = BAD_POSITION_CNT;
    _positionMaxCnt = BAD_POSITION_CNT;
    _pcSampleTime = 0.0;
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

int
ElmoServoDrive::_angleToCounts(float angleDeg) {
    // Normalize the angle into range -360,360
    angleDeg = fmodf(angleDeg, 360.0);

    // Convert angle to drive counts
    int counts = int(countsPerDegree() * angleDeg);

    // Normalize into _posCountMin to (_posCountMax-1) range
    if (counts < _positionMinCnt) {
        counts += countsPerCircle();
    } else if (counts > (_positionMaxCnt - 1)) {
        counts -= countsPerCircle();
    }
    return(counts);
}

void
ElmoServoDrive::moveTo(float angle) {
    // Don't bother if the drive is not responding, is not initialized,
    // or we don't have drive parameters yet.
    if (! _driveResponding || ! _driveInitialized || ! _driveHomed || ! _driveParamsGood()) {
        DLOG << _driveName << " ignoring moveTo " << angle;
        return;
    }

    // Generate a command to move to the given absolute position
    std::ostringstream cmdstream;
    cmdstream << "PA=" << _angleToCounts(angle);
    _execElmoCmd(cmdstream.str());
    _execElmoCmd("BG");
}

//void
//ElmoServoDrive::setPVT(int p, int v, int t, int n) {
//    // Don't bother if the drive is not responding
//    if (! _driveResponding) {
//        return;
//    }
//
//    std::ostringstream cmdstream;
//    // Set position
//    cmdstream << "QP[" << n << "]=" << p;
//    _execElmoCmd(cmdstream.str());
//    // Set velocity
//    cmdstream.str("");
//    cmdstream << "QV[" << n << "]=" << v;
//    _execElmoCmd(cmdstream.str());
//    // Set time
//    cmdstream.str("");
//    cmdstream << "QT[" << n << "]=" << t;
//    _execElmoCmd(cmdstream.str());
//}

void
ElmoServoDrive::initScan(std::vector<float> p, std::vector<float> v,
        std::vector<float> t) {
    // Don't bother if the drive is not responding, is not initialized,
    // or we don't have drive parameters yet.
    if (! _driveResponding || ! _driveInitialized || ! _driveHomed || ! _driveParamsGood()) {
        return;
    }

    uint32_t nScanPts = p.size();
    if (v.size() != nScanPts || t.size() != nScanPts) {
        ELOG << "In initScan(), size of p, v, and t arrays are not all the same!";
        exit(1);
    }

    // Stop the drive before we mess with the scan table
    _execElmoCmd("MO=0");
    // Allow a bit of time (250 ms) for the motor to stop
    usleep(250000);

    std::ostringstream cmdstream;

    for (uint32_t i = 0; i < nScanPts; i++) {

        // Set position point
        cmdstream.str("");
        cmdstream << "QP[" << i + 1 << "]=" << int(p[i]);
        _execElmoCmd(cmdstream.str());

        // Set velocity
        cmdstream.str("");
        cmdstream << "QV[" << i + 1 << "]=" << int(v[i]);
        _execElmoCmd(cmdstream.str());

        // Set time
        cmdstream.str("");
        cmdstream << "QT[" << i + 1 << "]=" << int(t[i]);
        _execElmoCmd(cmdstream.str());
    }
    // Set PT motion parameters
    _execElmoCmd("MP[1]=1");

    cmdstream.str("");
    cmdstream << "MP[2]=" << nScanPts;
    _execElmoCmd(cmdstream.str());

    _execElmoCmd("MP[3]=1");
}

void
ElmoServoDrive::initScan(float ccwLimit, float cwLimit, float scanRate) {
    std::ostringstream cmdstream;

    float scanWidth = cwLimit - ccwLimit;
    if (scanWidth < 0) {
        scanWidth += 360.0;
    }

    // Try to set position controller sample times per point to give us
    // 0.1 s between points. However, maximum position sample times per point
    // is 255, so our time between points may be smaller than desired.
    int pcSampTimesPerPoint = int(0.1 / _pcSampleTime + 0.5);
    if (pcSampTimesPerPoint > 255)
        pcSampTimesPerPoint = 255;

    // Set sample times per point on the drive
    cmdstream.str("");
    cmdstream << "MP[4]=" << pcSampTimesPerPoint;
    _execElmoCmd(cmdstream.str());

    // Actual time between points.
    float pointTime = _pcSampleTime * pcSampTimesPerPoint;

    // Base scan time (one way)
    float baseScanTime = scanWidth / scanRate;

    // number of points per scan (both ways)
    int nScanPts = 2 * (int(baseScanTime / pointTime) + 2);

    // Add a point at either end for turn-around
    nScanPts += 2;

    // Now build the table (including an extra point for turn-around on either side)
    ILOG << "Building " << nScanPts << "-point PT table";
    ILOG << pointTime << " seconds per point";
    for (int i = 0; i < nScanPts; i++) {
        float degPerPoint = scanRate * pointTime;
        float pos = ccwLimit + (i - 1) * degPerPoint;
        if (i > (nScanPts / 2)) {
            int newi = nScanPts - i - 1;
            pos = ccwLimit + newi * degPerPoint;
        }
        int ipos = _angleToCounts(pos);

        // Set position point
        ILOG << pos << ":" << ipos;
        cmdstream.str("");
        cmdstream << "QP[" << i + 1 << "]=" << ipos;
        _execElmoCmd(cmdstream.str());
    }
    // Set PT motion parameters
    _execElmoCmd("MP[1]=1");

    cmdstream.str("");
    cmdstream << "MP[2]=" << nScanPts;
    _execElmoCmd(cmdstream.str());

    _execElmoCmd("MP[3]=1");
}

void
ElmoServoDrive::scan() {
    // Don't bother if the drive is not responding
    if (! _driveResponding) {
        return;
    }

    //    _execElmoCmd("PV=1");
    //    _execElmoCmd("TS=120");
    //    _execElmoCmd("MP[4]=256");
    // position to first point of scan
    _execElmoCmd("PA=QP[1]");
    _execElmoCmd("BG");
    // start the scan
    _execElmoCmd("PT=1");
    _execElmoCmd("BG");
}

bool
ElmoServoDrive::_execElmoCmd(const std::string cmd, bool emptyReplyExpected) {
    // TODO: verify that we got a single command, with no terminator characters
    // (or exactly one terminator at the end of the command)

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
                        cmd << "' command. Resynchronizing commands and replies.";
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
                // Special handling for errors from XQ commands
                if (! cmd.compare(0, 2, "XQ")) {
                    _xqError = true;
                }
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
                        gettimeofday(&_lastStatusTime, NULL);
                    } else {
                        WLOG << _driveName << ": bad SR reply '" <<
                                cmdReply << "'";
                    }
                }

                // Save reply from TI[1] "temperature indicator 1" command
                if (! cmd.compare("TI[1]")) {
                    uint32_t temp = qCmdReply.toInt(&ok);
                    if (ok) {
                        _driveTemperature = temp;    // drive temperature, deg C
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

                // Save reply from XM[1] "position counter min count" command
                if (! cmd.compare("XM[1]")) {
                    uint32_t count = qCmdReply.toInt(&ok);
                    if (ok) {
                        _positionMinCnt = count;    // minimum position count
                        ILOG << _driveName << " XM[1] is " << _positionMinCnt;
                    } else {
                        WLOG << _driveName << ": bad XM[1] reply '" <<
                                cmdReply << "'";
                    }
                }

                // Save reply from XM[2] "position counter max count" command
                if (! cmd.compare("XM[2]")) {
                    uint32_t count = qCmdReply.toInt(&ok);
                    if (ok) {
                        _positionMaxCnt = count;    // maximum position count
                        ILOG << _driveName << " XM[2] is " << _positionMaxCnt;
                    } else {
                        WLOG << _driveName << ": bad XM[2] reply '" <<
                                cmdReply << "'";
                    }
                }

                // Save reply from WS[55] "position controller sample time" command
                if (! cmd.compare("WS[55]")) {
                    int microsecs = qCmdReply.toInt(&ok);
                    if (ok) {
                        _pcSampleTime = 1.0e-6 * microsecs;    // convert sample time to s
                        ILOG << _driveName <<
                                " position controller sample time is " <<
                                _pcSampleTime << " s";
                    } else {
                        WLOG << _driveName << ": bad WS[55] reply '" <<
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
                "Remainder is '" <<    _rawReply << "'";
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

    // Assume that all replies from the drive, up to and including the reply
    // to the command issued above, will arrive within REPLY_TIMEOUT_MSECS.
    _gpTimer.setInterval(REPLY_TIMEOUT_MSECS);
    _gpTimer.setSingleShot(true);
    connect(& _gpTimer, SIGNAL(timeout()), this, SLOT(_syncWaitExpired()));
    _gpTimer.start();
}

void
ElmoServoDrive::_syncWaitExpired() {
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
        // We can now tell the drive to initialize its parameters
        _initDrive();
    }
}

void
ElmoServoDrive::_homeDrive() {
    // Call the drive method for homing based on _driveName
    // @TODO Disable transmitter while homing, since antenna may move anywhere
    // during this process
    _startXq(_xqHomingFunction());
    ILOG << _driveName << " XQ'ing homing function '" << _xqHomingFunction() << "'";

    // Set up a periodic timer to check whether the program we just started on
    // the drive has completed (or failed).
    _gpTimer.setInterval(STATUS_PERIOD_MSECS);
    _gpTimer.setSingleShot(false);
    connect(& _gpTimer, SIGNAL(timeout()), this, SLOT(_testForHomingCompletion()));
    _gpTimer.start();
}

void
ElmoServoDrive::_initDrive() {
    // Call the drive method to initialize drive parameters
    // @TODO Disable transmitter while homing, since antenna may move anywhere
    // during this process
    _startXq(_xqInitFunction());
    ILOG << _driveName << " XQ-ing init function '" << _xqInitFunction() << "'";

    // Set up a periodic timer to check whether the program we just started on
    // the drive has completed (or failed).
    _gpTimer.setInterval(STATUS_PERIOD_MSECS);
    _gpTimer.setSingleShot(false);
    connect(& _gpTimer, SIGNAL(timeout()), this, SLOT(_testForInitCompletion()));
    _gpTimer.start();
}

void
ElmoServoDrive::_startXq(std::string function) {
    // Clear our XQ error indicator before we begin
    _xqError = false;

    // Use XQ to execute the given function on the drive
    std::ostringstream cmdstream;
    cmdstream << "XQ##" << function;
    _execElmoCmd(cmdstream.str());

    // Save the time the XQ was started
    gettimeofday(&_xqStartTime, NULL);
}

bool
ElmoServoDrive::_xqCompleted() {
    // If there is new status since we began XQ and the program is not running
    // on the drive, the XQ is complete.
    return(timercmp(&_lastStatusTime, &_xqStartTime, >) &&
            ! SREG_programRunning(_driveStatusRegister));
}

void
ElmoServoDrive::_testForInitCompletion() {
    ILOG << _driveName << " test for init completion";
    // If there was an error executing the program on the drive, restart
    // the initialization process.
    if (_xqError) {
        ELOG << _driveName << " initialization failed on XQ. Restarting.";
        _startCommandReplySync();
        goto stop_timer;
    }

    // Perhaps time out if the XQ function has not finished executing yet
    if (! _xqCompleted()) {
        // If initialization has been proceeding for more than 10 seconds, time
        // out and start over. Otherwise return and wait for the next periodic
        // call here.
        time_t now = time(0);
        if ((now - _xqStartTime.tv_sec) > 10) {
            ELOG << _driveName << " initialization timed out. Starting over.";
            _execElmoCmd("KL"); // halt program execution and stop the motor
            _driveResponding = false;
            _execElmoCmd("");
            goto stop_timer;
        } else {
            // Nope, not done yet. Just return.
            return;
        }
    }

    // The initialization/homing program on the drive finished.
    ILOG << _driveName << " initialization complete";
    _driveInitialized = true;

    // Once the drive is initialized, we can query it for drive parameters.
    _collectDriveParams();

stop_timer:
    _gpTimer.stop();
    _gpTimer.disconnect(this);

    // If drive is initialized, we can now home it
    if (_driveInitialized) {
        _homeDrive();
    }
}

void
ElmoServoDrive::_testForHomingCompletion() {
    ILOG << _driveName << " test for homing completion";
    // If there was an error executing the program on the drive, restart
    // the initialization process.
    if (_xqError) {
        ELOG << _driveName << " homing failed on XQ. Restarting.";
        _startCommandReplySync();
        goto stop_timer;
    }

    // Perhaps time out if the XQ function has not finished executing yet
    if (! _xqCompleted()) {
        // If initialization has been proceeding for more than 10 seconds, time
        // out and start over. Otherwise return and wait for the next periodic
        // call here.
        time_t now = time(0);
        if ((now - _xqStartTime.tv_sec) > 10) {
            ELOG << _driveName << " homing timed out. Starting over.";
            _execElmoCmd("KL"); // halt program execution and stop the motor
            _startCommandReplySync();
            goto stop_timer;
        } else {
            // Nope, not done yet. Just return.
            return;
        }
    }

    // The initialization/homing program on the drive finished.
    ILOG << _driveName << " homing complete";
    _driveHomed = true;
    _execElmoCmd("MO=1");

stop_timer:
    _gpTimer.stop();
    _gpTimer.disconnect(this);
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
        // We need to consider the drive uninitialized, since there's a chance
        // it lost power.
        _driveInitialized = false;
        _driveHomed = false;
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
    _execElmoCmd("SR", false);        // status register
    _execElmoCmd("TI[1]", false);    // "temperature indicator 1", drive temperature
    _execElmoCmd("TM", false);        // system time
}

void
ElmoServoDrive::_resetStatus() {
    _driveTemperature = 0;
    _driveStatusRegister = 0;
}

void
ElmoServoDrive::_collectDriveParams() {
    // Send commands to the drive to get back drive parameters we need. The
    // status values will be parsed out and saved in _readReply() when the
    // replies come back.
    _execElmoCmd("XM[1]", false);    // position counter minimum value
    _execElmoCmd("XM[2]", false);    // position counter maximum value
    _execElmoCmd("WS[55]", false);    // sampling time of position controller
}
