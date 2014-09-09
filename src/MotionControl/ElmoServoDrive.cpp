/*
 * ElmoServoDrive.cpp
 *
 *  Created on: Jun 26, 2013
 *      Author: burghart
 */
#include "ElmoServoDrive.h"
#include "TtyElmoConnection.h"
#include "CanElmoConnection.h"

#include <sstream>
#include <string>
#include <cerrno>
#include <cstdlib>
#include <stdint.h>
#include <unistd.h>
#include <logx/Logging.h>

LOGGING("ElmoServoDrive")

ElmoServoDrive::ElmoServoDrive(std::string ttyDev, std::string driveName,
        uint32_t countsPerCircle, float lowerAngleLimit, float upperAngleLimit) :
    QObject(),
    _driveConn(0),
    _inhibitActive(false),
    _driveInitialized(false),
    _driveHomed(false),
    _homingInProgress(false),
    _statusTimer(),
    _countsPerCircle(countsPerCircle),
    _lowerLimitCounts((lowerAngleLimit / 360.0) * _countsPerCircle),
    _upperLimitCounts((upperAngleLimit / 360.0) * _countsPerCircle),
    _scanPoints() {
    // Create our serial port connection to the drive
    _driveConn = new TtyElmoConnection(ttyDev, driveName);
    // Complete our construction
    _finishConstruction();
}

ElmoServoDrive::ElmoServoDrive(uint8_t nodeId, std::string driveName,
        uint32_t countsPerCircle, float lowerAngleLimit, float upperAngleLimit) :
    QObject(),
    _driveConn(0),
    _inhibitActive(false),
    _driveInitialized(false),
    _driveHomed(false),
    _homingInProgress(false),
    _statusTimer(),
    _countsPerCircle(countsPerCircle),
    _lowerLimitCounts((lowerAngleLimit / 360.0) * _countsPerCircle),
    _upperLimitCounts((upperAngleLimit / 360.0) * _countsPerCircle),
    _scanPoints() {
    // Create our CANopen connection to the drive
    _driveConn = new CanElmoConnection(nodeId, driveName);
    // Complete our construction
    _finishConstruction();
}

ElmoServoDrive::~ElmoServoDrive() {
    // Stop the motor
    DLOG << "Turning off motor for " << _driveConn->driveName();
    _driveConn->execElmoAssignCmd("MO", 0, 0);
    // Turn on echo. Elmo's Composer software requires echo on in order
    // to function, so we try to leave the servo drive in a state to talk to
    // Composer.
    DLOG << "Turning on echo for " << _driveConn->driveName();
    _driveConn->execElmoAssignCmd("EO", 0, 1);
    // Destroy the drive connection
    delete(_driveConn);
}

void
ElmoServoDrive::_finishConstruction() {
    // Clear values which will be queried from the drive
    _clearQueriedParams();
    
    // Catch some signals from our drive connection
    connect(_driveConn, SIGNAL(readyToExecChanged(bool)), 
            this, SLOT(_onReadyToExecChanged(bool)));
    connect(_driveConn, SIGNAL(replyFromExec(std::string, ElmoConnection::ReplyType, int, float)),
            this, SLOT(_onReplyFromExec(std::string, ElmoConnection::ReplyType, int, float)));

    // Collect status information every STATUS_PERIOD_MSECS milliseconds.
    _statusTimer.setInterval(STATUS_PERIOD_MSECS);
    connect(& _statusTimer, SIGNAL(timeout()), this, SLOT(_collectStatus()));
    _statusTimer.start();
}

void
ElmoServoDrive::_onReadyToExecChanged(bool isReady) {
    if (isReady) {
        _initDrive();
    } else {
        // Assume we know nothing accurate about the state of the drive and
        // its motor at this point.
        _clearQueriedParams();
        
        // If we had already done our initialization or homing, mark those
        // as undone.
        if (_driveInitialized || _driveHomed) {
            _driveInitialized = false;
            _driveHomed = false;
        }
    }
}

void
ElmoServoDrive::_onReplyFromExec(std::string cmd, 
        ElmoConnection::ReplyType replyType, int iVal, float fVal) {
    switch (replyType) {
    case ElmoConnection::ErrorReply:
        if (iVal > 0) {
            ELOG << driveName() << ": command '" << cmd << "' generated " <<
                    "Elmo SimplIQ error code " << iVal;
            
        } else {
            ELOG << driveName() << ": command '" << cmd << "' generated " <<
                    "ElmoConnection internal error " << iVal;
        }
        
        // Special handling for errors on XQ commands
        if (cmd.compare(0, 2, "XQ") == 0) {
            _xqError = true;
            return;
        }
        
        ELOG << driveName() << " connection will be reinitialized";
        _driveConn->reinitialize();
        return;
    case ElmoConnection::IntReply:
        // Look for replies to status requests we've made, and stash
        // the returned values.
    
        // Save reply from SR "status register" command
        if (! cmd.compare("SR")) {
            _driveStatusRegister = iVal;
            // Assign the time that the SR request was issued to
            // the returned value.
            _lastSrTime = _srRequestTime;
        }
        // Save reply from TI[1] "temperature indicator 1" command
        else if (! cmd.compare("TI[1]")) {
            _driveTemperature = iVal;    // drive temperature, deg C
        }
        // Save reply from TM "system time" command
        else if (! cmd.compare("TM")) {
            // System time is actually a 32-bit unsigned count, but the reply sends 
            // it as a signed value. Reinterpret the returned value as an *unsigned*
            // 32-bit int.
            _driveSystemTime = *(reinterpret_cast<uint32_t*>(&iVal));
        }
        // Save reply from TR[1] "target radius" command
        else if (! cmd.compare("TR[1]")) {
            _targetRadius = iVal;
        }
        // Save reply from PX "main position" command
        else if (! cmd.compare("PX")) {
            // PX is reported in counts in the range [XM[1],XM[2]-1]
            _angleCounts = iVal;
        }
        // Save the state of the external inhibit bit
        else if (! cmd.compare("IB[12]")) {
            bool inhibit(iVal);
            if (inhibit != _inhibitActive) {
                ILOG << driveName() << " external inhibit is now " << 
                        (inhibit ? "enabled" : "disabled");
            }
            _inhibitActive = inhibit;
        }
        // Log reply from XM[1] "position counter min count" command
        else if (! cmd.compare("XM[1]")) {
            ILOG << driveName() << " XM[1] is " << iVal;
        }
        // Log reply from XM[2] "position counter max count" command
        else if (! cmd.compare("XM[2]")) {
            ILOG << driveName() << " XM[2] is " << iVal;
        }
        // Save reply from WS[55] "position controller sample time" command
        else if (! cmd.compare("WS[55]")) {
            _pcSampleTime = 1.0e-6 * iVal;  // convert sample time in us to s
            ILOG << driveName() << " position controller sample time is " <<
                    _pcSampleTime << " s";
        }
        else {
            DLOG << driveName() << " integer reply to '" << cmd << "' was " <<
                    iVal;
        }
        break;
    case ElmoConnection::FloatReply:
        DLOG << driveName() << " float reply to '" << cmd << "' was " << fVal;
        break;
    case ElmoConnection::EmptyReply:
        DLOG << driveName() << " reply to '" << cmd << "' was empty";
        break;
    }
}

int
ElmoServoDrive::_angleToCounts(float angleDeg) const {
    // Normalize the angle into interval [0,360)
    angleDeg = fmodf(angleDeg, 360.0);
    if (angleDeg < 0.0) {
        angleDeg += 360.0;
    }

    // Convert angle to drive counts
    int counts = int(roundf(countsPerDegree() * angleDeg));
    
    // If the count is outside our allowed motion range, try to shift it into 
    // the allowed range.
    if (! _canMoveToCount(counts)) {
        // Try shifting up or down one circle, depending on which side of the 
        // limits we're on.
        int shiftSign = (counts < _lowerLimitCounts) ? 1 : -1;
        int newCounts = counts + shiftSign * _countsPerCircle;
        
        // Apply the new counts if it's a position we can get to
        if (_canMoveToCount(newCounts)) {
            counts = newCounts;
        }
    }
    
    // The counts value now contains a value in counts yielding the given angle,
    // and, if possible, within the interval [_lowerLimitCounts,_upperLimitCounts].
    return(counts);
}

void
ElmoServoDrive::moveTo(float angle) {
    // Don't bother if the drive is not responding, is not initialized,
    // or we don't have drive parameters yet.
    if (! _driveConn->readyToExec() || ! _driveInitialized || ! _driveHomed || 
            (_pcSampleTime == 0.0)) {
        DLOG << driveName() << " ignoring moveTo " << angle;
        return;
    }

    // Convert angle to counts and complain if we can't move there
    int counts = _angleToCounts(angle);
    if (! _canMoveToCount(counts)) {
        ELOG << driveName() << " cannot move to angle " << angle << 
                ", which is outside motion boundaries (" <<
                _lowerLimitCounts / countsPerDegree() << " to " << 
                _upperLimitCounts / countsPerDegree() << ")";
        return;
    }
    
    // Generate a command to move to the given absolute position
    DLOG << driveName() << ": move to " << angle;
    _driveConn->execElmoAssignCmd("PA", _angleToCounts(angle));
    _driveConn->execElmoCmd("BG");
}

void
ElmoServoDrive::initScan(float ccwLimit, float cwLimit, float scanRate) {
    std::ostringstream cmdstream;

    // Calculate the scan width, normalized into the interval [0,360)
    float scanWidth = fmodf(cwLimit - ccwLimit, 360.0);
    if (scanWidth < 0) {
        scanWidth += 360.0;
    }

    // Try to set position controller sample times per point to give us
    // 0.1 s between points. However, maximum position sample times per point
    // is 255, so our time between points may be smaller than desired.
    int pcSampTimesPerPoint = int(0.1 / _pcSampleTime + 0.5);
    if (pcSampTimesPerPoint > 255)
        pcSampTimesPerPoint = 255;

    // Actual time between points.
    float pointTime = _pcSampleTime * pcSampTimesPerPoint;

    // Base scan time (one way)
    float baseScanTime = scanWidth / scanRate;

    // number of points per scan (both ways)
    int nScanPts = 2 * (int(baseScanTime / pointTime) + 2);

    // Add a point at either end for turn-around
    nScanPts += 2;

    // Throw an exception if the required scan table will not fit on the drive
    if (nScanPts > 1024) {
        std::ostringstream errmsg;
        ELOG << driveName() << ": initScan failed";
        errmsg << "Requested scan would require a " << nScanPts << 
                "-point table, but the maximum is 1024 points.";
        ELOG << driveName() << ": " << errmsg.str();
        _scanPoints.clear();
        throw std::runtime_error(errmsg.str());
    }

    // Set number of position controller sample times per point in the table
    _driveConn->execElmoAssignCmd("MP", 4, pcSampTimesPerPoint);

    // Now build the table (including an extra point for turn-around on either 
    // side)
    DLOG << "Building " << nScanPts << "-point PT table";
    DLOG << pointTime << " seconds per point";
    _scanPoints.clear();
    for (int i = 0; i < nScanPts; i++) {
        float degPerPoint = scanRate * pointTime;
        float pos = ccwLimit + (i - 1) * degPerPoint;
        if (i > (nScanPts / 2)) {
            int newi = nScanPts - i - 1;
            pos = ccwLimit + newi * degPerPoint;
        }
        int ipos = _angleToCounts(pos);
        if (! _canMoveToCount(ipos)) {
            ELOG << driveName() << ": problem at index " << i << 
                    ", angle " << pos << " (" << ipos << " counts)";
            std::ostringstream errmsg;
            errmsg << "Requested scan extends outside motion boundaries (" <<
                    _lowerLimitCounts / countsPerDegree() << " to " << 
                    _upperLimitCounts / countsPerDegree() << ")";
            ELOG << driveName() << ": initScan() failed: " << errmsg.str();
            _scanPoints.clear();
            throw std::runtime_error(errmsg.str());            
        }
        _scanPoints.push_back(ipos);
    }
    
    // Put the scan position points into the drive's QP array
    for (int i = 0; i < nScanPts; i++) {
        // Set position point
        _driveConn->execElmoAssignCmd("QP", i + 1, _scanPoints[i]);        
    }
    
    // Set PT motion parameters
    _driveConn->execElmoAssignCmd("MP", 1, 1);          // start at index 1
    _driveConn->execElmoAssignCmd("MP", 2, nScanPts);   // finish at index nScanPts
    _driveConn->execElmoAssignCmd("MP", 3, 1);          // repeat
}

void
ElmoServoDrive::scan() {
    // Don't bother if the drive is not responding
    if (! _driveConn->readyToExec()) {
        return;
    }

    if (_scanPoints.empty()) {
        ELOG << driveName() << ": scan() failure; no scan has been defined!";
        return;
    }
    
    ILOG << driveName() << " starting scan"; 

    // position to first point of scan
    _driveConn->execElmoAssignCmd("PA", _scanPoints[0]);
    _driveConn->execElmoCmd("BG");

    // TODO we need to wait for motion completion here before starting the scan
    
    // start the scan
    _driveConn->execElmoAssignCmd("PT", 1);
    _driveConn->execElmoCmd("BG");
}

void
ElmoServoDrive::homeDrive(int homeCounts) {
    // If drive is initialized, we can not home it
    if (!_driveInitialized) {
        return;
    }
    _driveHomed = false;

    // Set UI[1] to the count value we want associated with the home position.
    _driveConn->execElmoAssignCmd("UI", 1, homeCounts);

    // Call the drive homing function. The function sets the count value for
    // the home position to the number it finds in UI[1].
    _startXq(_xqHomingFunction());
    _homingInProgress = true;

    // Set up a periodic timer to check whether the program we just started on
    // the drive has completed (or failed).
    _gpTimer.setInterval(STATUS_PERIOD_MSECS);
    _gpTimer.setSingleShot(false);
    connect(& _gpTimer, SIGNAL(timeout()), this, SLOT(_testForHomingCompletion()));
    _gpTimer.start();
}

void
ElmoServoDrive::setTargetRadius(uint32_t targetRadius) {
    // Don't bother if the drive is not responding, is not initialized,
    // or we don't have good drive parameters yet.
    if (! _driveConn->readyToExec() || ! _driveInitialized || 
            (_pcSampleTime == 0.0)) {
        DLOG << driveName() << " not ready; ignoring setTargetRadius to " << 
                targetRadius << " counts";
        return;
    }
    // Send the TR[1]=<targetRadius> command.
    _driveConn->execElmoAssignCmd("TR", 1, targetRadius);
}

void
ElmoServoDrive::_initDrive() {
    // Call the drive method to initialize drive parameters
    _startXq(_xqInitFunction());

    // Set up a periodic timer to check whether the program we just started on
    // the drive has completed (or failed).
    _gpTimer.setInterval(STATUS_PERIOD_MSECS);
    _gpTimer.setSingleShot(false);
    connect(& _gpTimer, SIGNAL(timeout()), this, SLOT(_testForInitCompletion()));
    _gpTimer.start();
}

void
ElmoServoDrive::_startXq(std::string function) {
    // Before executing a drive program, stop any program running on the 
    // drive and disarm any homing which may be in progress.
    _driveConn->execElmoCmd("KL");
    _driveConn->execElmoAssignCmd("HM", 1, 0);
    usleep(100000); // sleep 0.1 s

    // Clear our XQ error indicator before we begin
    _xqError = false;

    // Use XQ to execute the given function on the drive
    std::string cmd = std::string("XQ##") + function;
    _driveConn->execElmoCmd(cmd);
    ILOG << driveName() << " executing drive-resident function: " << cmd;

    // Save the time the XQ was started
    gettimeofday(&_xqStartTime, NULL);
}

bool
ElmoServoDrive::_xqCompleted() {
    // (last status time - XQ start time), in microseconds 
    int32_t diffUs = 1000000 * (_lastSrTime.tv_sec - _xqStartTime.tv_sec) +
            (_lastSrTime.tv_usec - _xqStartTime.tv_usec);
    // If the latest status is from at least 0.1 second after we began XQ and 
    // the program is not running on the drive, the XQ is complete.
    // We put in the 0.1 s cushion because it is possible to collect status
    // immediately after XQ has been initiated but *before* the "program 
    // running" bit is set, and hence we could report the program has completed
    // before it even starts.
    bool completed = (diffUs > 100000) && 
            ! SREG_programRunning(_driveStatusRegister);
    if (completed) {
        DLOG << "Status is from " << diffUs << " us after XQ was started";
    }
    return(completed);
}

void
ElmoServoDrive::_testForInitCompletion() {
    ILOG << driveName() << " test for init completion";
    // If there was an error executing the program on the drive, restart
    // the initialization process.
    if (_xqError) {
        ELOG << driveName() << " initialization XQ failed. Restarting connection.";
        _driveConn->reinitialize();
        goto stop_timer;
    }

    // Perhaps time out if the XQ function has not finished executing yet
    if (! _xqCompleted()) {
        // If initialization has been proceeding for more than 10 seconds, time
        // out and start over. Otherwise return and wait for the next periodic
        // call here.
        time_t now = time(0);
        if ((now - _xqStartTime.tv_sec) > 10) {
            ELOG << driveName() << " initialization timed out. Starting over.";
            _driveConn->execElmoCmd("KL");
            _driveConn->reinitialize();
            goto stop_timer;
        } else {
            // Nope, not done yet. Just return.
            return;
        }
    }

    // The initialization/homing program on the drive finished.
    ILOG << driveName() << " initialization complete";
    _driveInitialized = true;
    
    // One-time query to get the position controller sample time, using the
    // "WS[55]" command. The returned value will be extracted in 
    // _onReplyFromExec().
    _driveConn->execElmoCmd("WS", 55);
    
    // Turn off motor for setting XM[1], XM[2], LL[3], and HL[3]
    _driveConn->execElmoAssignCmd("MO", 0, 0);

    // Override minimum and maximum position counts to their default values
    // of essentially +/- infinity. This disables angle modulo arithmetic on 
    // the servo drive, which is necessary to create an enforceable "keep-out" 
    // wedge.
    _driveConn->execElmoAssignCmd("XM", 1, -1000000000);
    _driveConn->execElmoAssignCmd("XM", 2, 1000000000);
    
    // Load the lower and upper limits for motor position which were specified
    // in the constructor
    _driveConn->execElmoAssignCmd("LL", 3, _lowerLimitCounts);
    _driveConn->execElmoAssignCmd("HL", 3, _upperLimitCounts);
    
    // Turn motor back on
    _driveConn->execElmoAssignCmd("MO", 0, 1);

stop_timer:
    _gpTimer.stop();
    _gpTimer.disconnect(this);
}

void
ElmoServoDrive::_testForHomingCompletion() {
    ILOG << driveName() << " test for homing completion";
    // If there was an error executing the program on the drive, restart
    // the initialization process.
    if (_xqError) {
        ELOG << driveName() << " homing failed on XQ. Restarting.";
        _driveConn->reinitialize();
        goto stop_timer;
    }

    // Perhaps time out if the XQ function has not finished executing yet
    if (! _xqCompleted()) {
        // If initialization has been proceeding for more than 10 seconds, time
        // out and start over. Otherwise return and wait for the next periodic
        // call here.
        time_t now = time(0);
        if ((now - _xqStartTime.tv_sec) > 10) {
            ELOG << driveName() << " homing timed out. Starting over.";
            _driveConn->execElmoCmd("KL"); // halt program execution and stop the motor
            _driveConn->reinitialize();
            goto stop_timer;
        } else {
            // Nope, not done yet. Just return.
            return;
        }
    }

    // The initialization/homing program on the drive finished.
    ILOG << driveName() << " homing complete";
    _driveHomed = true;
    _driveConn->execElmoAssignCmd("MO", 1);

stop_timer:
    _homingInProgress = false;
    _gpTimer.stop();
    _gpTimer.disconnect(this);
}

void
ElmoServoDrive::_collectStatus() {
    if (! _driveConn->readyToExec()) {
        DLOG << "Skipping status collection; drive is not ready.";
        return;
    }
    // Send commands to the drive to get back status values we want. The
    // status values will be parsed out and saved in _readReply when the
    // replies come back.

    // Save the time at which we request SR. This time will be used to
    // as the time tag for the reply.
    gettimeofday(&_srRequestTime, NULL);

    // Send the commands for the status values we want
    _driveConn->execElmoCmd("SR");      // status register
    _driveConn->execElmoCmd("TI", 1);   // TI[1]: drive temperature
    _driveConn->execElmoCmd("TR", 1);   // TR[1]: target radius counts
    _driveConn->execElmoCmd("PX");      // main position
    _driveConn->execElmoCmd("IB", 12);  // IB[12]: external inhibit line state
    _driveConn->execElmoCmd("TM");      // system time
}

void
ElmoServoDrive::_clearQueriedParams() {
    _pcSampleTime = 0.0;
    _driveStatusRegister = 0;
    _lastSrTime.tv_sec = 0;
    _lastSrTime.tv_usec = 0;
    _driveTemperature = 0;
    _targetRadius = 0;
    _angleCounts = 0;
    _driveSystemTime = 0;
}

bool
ElmoServoDrive::_canMoveToCount(int count) const {
    // We apply a small cushion angle on either side to narrow the interval 
    // [_lowerLimitCounts,_upperLimitCounts]. This allows for moderate
    // imprecision in positioning without triggering motor faults.
    const int CUSHION_COUNTS = 0.5 * countsPerDegree();
    return((count >= (_lowerLimitCounts + CUSHION_COUNTS)) && 
           (count <= (_upperLimitCounts - CUSHION_COUNTS)));
}
