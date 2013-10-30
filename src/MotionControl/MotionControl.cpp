/*
 * MotionControl.cpp
 *
 *  Created on: May 30, 2013
 *      Author: Xuanyong Xu
 */

#include "MotionControl.h"
#include <unistd.h>
#include <iostream>
#include <logx/Logging.h>

LOGGING("MotionControl")

inline double DegToRad(double deg) { return(M_PI * deg / 180.0); }
inline double RadToDeg(double rad) { return(180.0 * rad / M_PI); }

/////////////////////////////////////////////////////////////////////
MotionControl::MotionControl() :
    _rotDrive("/dev/ttydp00"),
    _tiltDrive("/dev/ttydp01"),
    _antennaMode(POINTING),
    _fixedPointingAngle(0),
    _targetRadius(0.02),
    _cmigitsShm(),
    _fakeAttitude(false),
    _driveStartTime(QTime::currentTime())
{
    // Start with attitude correction enabled.
    setCorrectionEnabled(true);
}

/////////////////////////////////////////////////////////////////////
MotionControl::~MotionControl()
{
}

/////////////////////////////////////////////////////////////////////
void MotionControl::correctForAttitude()
{
    // Ignore if attitude correction is disabled
    if (! _attitudeCorrectionEnabled) {
        DLOG << "Attitude correction is currently disabled";
        return;
    }
    /*
     * The pitch, roll, and heading come from CmigitsSharedMemory
     * class. Drift is derived using heading and true ground speed (also
     * available via CmigitsSharedMemory class).
     */
    // Get aircraft attitude
    uint64_t dataTime;
    double pitch = 0.0;
    double roll = 0.0;
    double heading = 0.0;
    double velNorth = 0.0;
    double velEast = 0.0;
    double velUp = 0.0;
    double drift = 0.0;

    if (_cmigitsShm.getWriterPid()) {
        // Get pitch, roll, and heading
        _cmigitsShm.getLatest3512Data(dataTime, pitch, roll, heading, velNorth,
                velEast, velUp);
        // Get drift
        drift = _cmigitsShm.getEstimatedDriftAngle();
    }

    // Substitute fake attitude if requested
    if (_fakeAttitude) {
        // How many seconds since we started the drive?
        double secsRunning = 0.001 * _driveStartTime.msecsTo(QTime::currentTime());
        if (secsRunning < 0)
            secsRunning += 86400;	// secs per day

        // Pitch the aircraft through +/- 10 deg every 3 seconds.
        pitch = 10.0 * sin(2.0 * M_PI * fmod(secsRunning / 3.0, 1.0));
        // Roll the aircraft through +/- 45 deg every 11 seconds.
        roll = 45 * sin(2.0 * M_PI * fmod(secsRunning / 11.0, 1.0));
        // Just leave drift at zero.
        drift = 0.0;
    }

    switch (_antennaMode) {
    case POINTING:
        _adjustPointingForAttitude(pitch, roll, drift);
        break;
    case SCANNING:
        _adjustScanningForAttitude(pitch, roll, drift);
        break;
    }
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::homeDrive(int rotHomeCounts, int tiltHomeCounts)
{
    ILOG << "homeDrive";
    // Change mode to fixed pointing at 0 degrees. The mode will be retained
    // after this method exits.
    point(0.0);
    // Set both drives to find home position. Note that these methods return
    // before homing is complete.
    _rotDrive.homeDrive(rotHomeCounts);
    _tiltDrive.homeDrive(tiltHomeCounts);
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::point(double angle)
{
    ILOG << "Point to " << angle << " deg";
    
    // Make sure the target radius for the drives is what we want
    _setTargetRadius();
    
    // Set up for fixed antenna pointing
    _fixedPointingAngle = angle;
    _antennaMode = POINTING;
    _rotDrive.moveTo(angle);
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::scan(double ccwLimit, double cwLimit, double scanRate)
{
    _scanCcwLimit = ccwLimit;
    _scanCwLimit = cwLimit;
    _scanRate = scanRate;
    ILOG << "Scan from " << ccwLimit << " CCW to " << cwLimit << " CW at " <<
            scanRate << " deg/s";
    
    // Make sure the target radius for the drives is what we want
    _setTargetRadius();

    _rotDrive.initScan(ccwLimit, cwLimit, scanRate);

    // Set up for antenna scanning
    _antennaMode = SCANNING;
    _rotDrive.scan();
    _tiltDrive.scan();
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::setCorrectionEnabled(bool enabled) {
    // Are we going from attitude correction enabled to disabled?
    bool turningOff = _attitudeCorrectionEnabled && ! enabled;

    ILOG << "Attitude correction has been " << (enabled ? "enabled" : "disabled");
    _attitudeCorrectionEnabled = enabled;

    // If we were correcting and correction was just turned off, make one last
    // correction back to straight level attitude.
    if (turningOff) {
        switch (_antennaMode) {
        case POINTING:
            _adjustPointingForAttitude(0.0, 0.0, 0.0);
            break;
        case SCANNING:
            // @TODO: Figure out how to handle this once corrected scanning
            // is implemented...
            WLOG << "***Need to implement scan cleanup when attitude correction "
                "is disabled***";
            break;
        }
    }
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::_adjustForAttitude(double & rot, double & tilt, double pitch,
        double roll, double drift)
{
    double desiredRot = rot;
    double desiredTilt = tilt;

    double sinPitch = sin(DegToRad(pitch));
    double cosPitch = cos(DegToRad(pitch));

    double sinRoll = sin(DegToRad(roll));
    double cosRoll = cos(DegToRad(roll));

    double sinDrift = sin(DegToRad(drift));
    double cosDrift = cos(DegToRad(drift));

    // Track relative coordinates - desired beam position
    double sinPoint = sin(DegToRad(desiredRot));
    double cosPoint = cos(DegToRad(desiredRot));

    double sinTilt = sin(DegToRad(desiredTilt));
    double cosTilt = cos(DegToRad(desiredTilt));

    // Convert to track relative Cartesian coordinates
    double x_t = cosTilt * sinPoint;
    double y_t = sinTilt;
    double z_t = cosTilt * cosPoint;

    // Convert to pod relative Cartesian coordinates - adjusted beam position
    double x_a =
            x_t * (cosDrift * cosRoll - sinDrift * sinPitch * sinRoll) +
            y_t * (sinDrift + cosDrift * sinPitch * sinRoll) +
            -z_t * cosPitch * sinRoll;
    double y_a =
            -x_t * sinDrift * cosPitch +
            y_t * cosDrift * cosPitch +
            z_t * sinPitch;
    double z_a =
            x_t * (cosDrift * sinRoll + sinDrift * sinPitch * sinRoll) +
            y_t * (sinDrift * sinRoll - cosDrift * sinPitch * cosRoll) +
            z_t * cosPitch * cosRoll;

    // Convert from pod relative Cartesian coordinates to polar coordinates
    // and save the adjusted rotation and tilt angles.

    // tilt needs to be divided by 2!
    tilt = RadToDeg(asin(y_a)) / 2;

    // KLUGE: The algorithm above isn't really right. As compensation for now,
    // just change the sign of the corrected tilt if the desired rotation angle
    // points downward, i.e., if its cosine is less than zero.
    if (cosPoint < 0.0) {
        tilt *= -1;
    }

    // rotation needs to be in the range of 0-360
    rot  = RadToDeg(atan2(x_a, z_a));
    if (rot < 0) rot += 360.0;
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::_adjustPointingForAttitude(double pitch, double roll, double drift)
{
    // Start with the desired track-relative rotation and tilt angles
    double rot = _fixedPointingAngle;
    double tilt = 0.0;
    // Adjust to pod-relative rotation and tilt angles
    _adjustForAttitude(rot, tilt, pitch, roll, drift);
    // Move the drives to their new angles
    _rotDrive.moveTo(rot);
    _tiltDrive.moveTo(-tilt);
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::_adjustScanningForAttitude(double pitch, double roll, double drift)
{
    DLOG << "_adjustScanningForAttitude not implemented";
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::_setTargetRadius()
{
    // rot drive
    uint32_t rotTrCounts = uint32_t(_rotDrive.countsPerDegree() * _targetRadius);
    if (_rotDrive.targetRadius() != rotTrCounts) {
        ILOG << "Setting rot drive target radius to " << _targetRadius << " deg";
        _rotDrive.setTargetRadius(rotTrCounts);
    }
    
    // tilt drive
    uint32_t tiltTrCounts = uint32_t(_tiltDrive.countsPerDegree() * _targetRadius);
    if (_tiltDrive.targetRadius() != tiltTrCounts) {
        ILOG << "Setting tilt drive target radius to " << _targetRadius << " deg";
        _tiltDrive.setTargetRadius(tiltTrCounts);
    }
}

/////////////////////////////////////////////////////////////////////
MotionControl::Status::Status() :
    rotDriveResponding(false),
    rotDriveInitialized(false),
    rotDriveHomed(false),
    rotDriveStatusReg(0),
    rotDriveTemp(0),
    rotDriveAngle(0.0),
    rotDriveSystemTime(0),
    tiltDriveResponding(false),
    tiltDriveInitialized(false),
    tiltDriveHomed(false),
    tiltDriveStatusReg(0),
    tiltDriveTemp(0),
    tiltDriveAngle(0.0),
    tiltDriveSystemTime(0),
    antennaMode(POINTING),
    fixedPointingAngle(0.0),
    scanCcwLimit(0.0),
    scanCwLimit(0.0),
    scanRate(0.0),
    attitudeCorrectionEnabled(false) {}

/////////////////////////////////////////////////////////////////////
MotionControl::Status::Status(const MotionControl & mc) :
    rotDriveResponding(mc.rotationDrive().driveResponding()),
    rotDriveInitialized(mc.rotationDrive().driveInitialized()),
    rotDriveHomed(mc.rotationDrive().driveHomed()),
    rotDriveStatusReg(mc.rotationDrive().driveStatusRegister()),
    rotDriveTemp(mc.rotationDrive().driveTemperature()),
    rotDriveAngle(mc.rotationDrive().angle()),
    rotDriveSystemTime(mc.rotationDrive().driveSystemTime()),
    tiltDriveResponding(mc.tiltDrive().driveResponding()),
    tiltDriveInitialized(mc.tiltDrive().driveInitialized()),
    tiltDriveHomed(mc.tiltDrive().driveHomed()),
    tiltDriveStatusReg(mc.tiltDrive().driveStatusRegister()),
    tiltDriveTemp(mc.tiltDrive().driveTemperature()),
    tiltDriveAngle(mc.tiltDrive().angle()),
    tiltDriveSystemTime(mc.tiltDrive().driveSystemTime()),
    antennaMode(mc.antennaMode()),
    fixedPointingAngle(mc.fixedPointingAngle()),
    attitudeCorrectionEnabled(mc.attitudeCorrectionEnabled()) {
    // Use the MotionControl::getScanParams() method to get all three scan
    // parameters
    mc.getScanParams(scanCcwLimit, scanCwLimit, scanRate);
}

/////////////////////////////////////////////////////////////////////
MotionControl::Status::Status(xmlrpc_c::value_struct & statusDict) {
    // Cast the given xmlrpc_c::value_struct into a map from string to
    // xmlrpc_c::value.
    std::map<std::string, xmlrpc_c::value> statusMap =
            static_cast<std::map<std::string, xmlrpc_c::value> >(statusDict);
    rotDriveResponding = static_cast<xmlrpc_c::value_boolean>(statusMap["rotDriveResponding"]);
    rotDriveInitialized = static_cast<xmlrpc_c::value_boolean>(statusMap["rotDriveInitialized"]);
    rotDriveHomed = static_cast<xmlrpc_c::value_boolean>(statusMap["rotDriveHomed"]);
    rotDriveStatusReg = static_cast<xmlrpc_c::value_int>(statusMap["rotDriveStatusReg"]);
    rotDriveTemp = static_cast<xmlrpc_c::value_int>(statusMap["rotDriveTemp"]);
    rotDriveAngle = static_cast<xmlrpc_c::value_double>(statusMap["rotDriveAngle"]);
    // Unsigned time is in the XML as a signed int. Pull it out as int, then
    // reinterpret as unsigned.
    int signedTime = static_cast<xmlrpc_c::value_int>(statusMap["rotDriveSystemTime"]);
    rotDriveSystemTime = *(reinterpret_cast<uint32_t *>(&signedTime));
    tiltDriveResponding = static_cast<xmlrpc_c::value_boolean>(statusMap["tiltDriveResponding"]);
    tiltDriveInitialized = static_cast<xmlrpc_c::value_boolean>(statusMap["tiltDriveInitialized"]);
    tiltDriveHomed = static_cast<xmlrpc_c::value_boolean>(statusMap["tiltDriveHomed"]);
    tiltDriveStatusReg = static_cast<xmlrpc_c::value_int>(statusMap["tiltDriveStatusReg"]);
    tiltDriveTemp = static_cast<xmlrpc_c::value_int>(statusMap["tiltDriveTemp"]);
    tiltDriveAngle = static_cast<xmlrpc_c::value_double>(statusMap["tiltDriveAngle"]);
    // Unsigned time is in the XML as a signed int. Pull it out as int, then
    // reinterpret as unsigned.
    signedTime = static_cast<xmlrpc_c::value_int>(statusMap["tiltDriveSystemTime"]);
    tiltDriveSystemTime = *(reinterpret_cast<uint32_t *>(&signedTime));
    antennaMode = static_cast<AntennaMode>(int(static_cast<xmlrpc_c::value_int>(statusMap["antennaMode"])));
    fixedPointingAngle = static_cast<xmlrpc_c::value_double>(statusMap["fixedPointingAngle"]);
    scanCcwLimit = static_cast<xmlrpc_c::value_double>(statusMap["scanCcwLimit"]);
    scanCwLimit = static_cast<xmlrpc_c::value_double>(statusMap["scanCwLimit"]);
    scanRate = static_cast<xmlrpc_c::value_double>(statusMap["scanRate"]);
    attitudeCorrectionEnabled = static_cast<xmlrpc_c::value_boolean>(statusMap["attitudeCorrectionEnabled"]);
}

/////////////////////////////////////////////////////////////////////
MotionControl::Status::~Status() {
}

/////////////////////////////////////////////////////////////////////
xmlrpc_c::value_struct
MotionControl::Status::to_value_struct() const {
    // Stuff our content into a dictionary mapping string to
    // xmlrpc_c::value.
    std::map<std::string, xmlrpc_c::value> dict;
    dict["rotDriveResponding"] = xmlrpc_c::value_boolean(rotDriveResponding);
    dict["rotDriveInitialized"] = xmlrpc_c::value_boolean(rotDriveInitialized);
    dict["rotDriveHomed"] = xmlrpc_c::value_boolean(rotDriveHomed);
    dict["rotDriveStatusReg"] = xmlrpc_c::value_int(rotDriveStatusReg);
    dict["rotDriveTemp"] = xmlrpc_c::value_int(rotDriveTemp);
    dict["rotDriveAngle"] = xmlrpc_c::value_double(rotDriveAngle);
    // We cannot pack unsigned 32-bit int into XML-RPC, so reinterpret it as
    // signed and push it out that way.
    int signedTime = *(reinterpret_cast<const int *>(&rotDriveSystemTime));
    dict["rotDriveSystemTime"] = xmlrpc_c::value_int(signedTime);
    dict["tiltDriveResponding"] = xmlrpc_c::value_boolean(tiltDriveResponding);
    dict["tiltDriveInitialized"] = xmlrpc_c::value_boolean(tiltDriveInitialized);
    dict["tiltDriveHomed"] = xmlrpc_c::value_boolean(tiltDriveHomed);
    dict["tiltDriveStatusReg"] = xmlrpc_c::value_int(tiltDriveStatusReg);
    dict["tiltDriveTemp"] = xmlrpc_c::value_int(tiltDriveTemp);
    dict["tiltDriveAngle"] = xmlrpc_c::value_double(tiltDriveAngle);
    // We cannot pack unsigned 32-bit int into XML-RPC, so reinterpret it as
    // signed and push it out that way.
    signedTime = *(reinterpret_cast<const int *>(&tiltDriveSystemTime));
    dict["tiltDriveSystemTime"] = xmlrpc_c::value_int(signedTime);
    dict["antennaMode"] = xmlrpc_c::value_int(antennaMode);
    dict["fixedPointingAngle"] = xmlrpc_c::value_double(fixedPointingAngle);
    dict["scanCcwLimit"] = xmlrpc_c::value_double(scanCcwLimit);
    dict["scanCwLimit"] = xmlrpc_c::value_double(scanCwLimit);
    dict["scanRate"] = xmlrpc_c::value_double(scanRate);
    dict["attitudeCorrectionEnabled"] = xmlrpc_c::value_boolean(attitudeCorrectionEnabled);
    // Construct an xmlrpc_c::value_struct from the map and return it.
    return(xmlrpc_c::value_struct(dict));
}
