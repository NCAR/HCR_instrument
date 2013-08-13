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

inline float DegToRad(float deg) { return(M_PI * deg / 180.0); }
inline float RadToDeg(float rad) { return(180.0 * rad / M_PI); }

/////////////////////////////////////////////////////////////////////
MotionControl::MotionControl() :
    _rotDrive("/dev/ttydp00"),
    _tiltDrive("/dev/ttydp01"),
    _antennaMode(POINTING),
    _fixedPointingAngle(0),
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
    float pitch = 0.0;
    float roll = 0.0;
    float heading = 0.0;
    float drift = 0.0;

    if (_cmigitsShm.getWriterPid()) {
        // Get pitch, roll, and heading
        _cmigitsShm.getLatest3512Data(dataTime, pitch, roll, heading);
        // Get drift
        drift = _cmigitsShm.getEstimatedDriftAngle();
    }

    // Substitute fake attitude if requested
    if (_fakeAttitude) {
        // How many seconds since we started the drive?
        float secsRunning = 0.001 * _driveStartTime.msecsTo(QTime::currentTime());
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
MotionControl::homeDrive()
{
    ILOG << "homeDrive";
    // Set both drives to home position
    _rotDrive.homeDrive();
    _tiltDrive.homeDrive();
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::point(float angle)
{
    ILOG << "Point to " << angle << " deg";
    // Set up for fixed antenna pointing
    _fixedPointingAngle = angle;
    _antennaMode = POINTING;
    _rotDrive.moveTo(angle);
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::scan(float ccwLimit, float cwLimit, float scanRate)
{
    _scanCcwLimit = ccwLimit;
    _scanCwLimit = cwLimit;
    _scanRate = scanRate;
    ILOG << "Scan from " << ccwLimit << " CCW to " << cwLimit << " CW at " <<
            scanRate << " deg/s";

    // time vector for both rotation and tilt
    float t[] = { 153.85, 153.85, 153.85, 153.85, 153.85,
            153.85, 153.85, 153.85, 153.85, 153.85,
            153.85, 153.85, 153.85, 153.85, 250,
            250,    250,    250,    250,    250,
            153.85, 153.85, 153.85, 153.85, 153.85,
            153.85, 153.85, 153.85, 153.85, 153.85,
            153.85, 153.85, 153.85, 250,    250,
            250,    250,    250,    250
    };
    std::vector<float> time(t, t + sizeof(t) / sizeof(*t));

    // Build up PVT table for rotation drive
    std::vector<float> rotPos;
    std::vector<float> rotVel;
    {
        // position
        float p[] = { 167560, 172690, 177820, 182950, 188070,
                193200, 198330, 203450, 208580, 213700,
                218820, 223950, 229070, 234190, 238820,
                241590, 242520, 241590, 238820, 234190,
                229440, 224680, 219920, 215160, 210410,
                205650, 200890, 196130, 191370, 186610,
                181850, 177080, 172320, 167560, 162920,
                160140, 159220, 160140, 162920
        };
        rotPos = std::vector<float>(p, p + sizeof(p) / sizeof(*p));
        // velocity
        float v[] = {  33333,   33333,    33333,  33333,  33333,
                33333,   33333,    33333,  33333,  33333,
                33333,   33333,    33333,  33333,  25000,
                8333.3, -8333.3, -25000, -33333, -33333,
                -33333,  -33333,   -33333, -33333, -33333,
                -33333,  -33333,   -33333, -33333, -33333,
                -33333,  -33333,   -33333, -33333, -25000,
                -8333.3,  8333.3,  25000,  33333
        };
        rotVel = std::vector<float>(v, v + sizeof(v) / sizeof(*v));
    }

    // Build up PVT table for tilt drive
    std::vector<float> tiltPos;
    std::vector<float> tiltVel;
    {
        float p[] = { -189.64,  -180.03,  -169.25,  -157.37,   -144.48,
                -130.64,  -115.96,  -100.53,   -84.448,   -67.819,
                -50.751,  -33.355,  -15.743,    1.9716,   17.956,
                27.506,   30.679,   27.506,   17.956,     1.9716,
                -14.479,  -30.849,  -47.047,  -62.983,   -78.566,
                -93.711, -108.33,  -122.35,  -135.68,   -148.26,
                -160.01,  -170.86,  -180.76,  -189.64,   -197.27,
                -201.34,  -202.62,  -201.34,  -197.27
        };
        tiltPos = std::vector<float>(p, p + sizeof(p) / sizeof(*p));
        float v[] = {    0,       62.486,    70.074,   77.205,   83.835,
                89.92,    95.421,   100.3,    104.53,   108.09,
                110.94,   113.08,    114.48,   115.14,    63.937,
                38.202,   12.691,   -12.691,  -38.202,  -63.937,
                -106.93,  -106.41,   -105.29,  -103.58,  -101.29,
                -98.443,  -95.042,   -91.11,   -86.668,  -81.741,
                -76.356,  -70.544,   -64.335,  -35.548,  -30.495,
                -16.304,   -5.0954,    5.0954,  16.304
        };
        tiltVel = std::vector<float>(v, v + sizeof(v) / sizeof(*v));
    }

    //	_rotDrive.initScan(rotPos, rotVel, time);
    //	_tiltDrive.initScan(tiltPos, tiltVel, time);
    _rotDrive.initScan(ccwLimit, cwLimit, scanRate);
    //	for (int i = 0; i < 40; i++) {
    //		_rotDrive.setPVT(int(posR[i]), int(velR[i]), int(tm[i]), i+1);
    //		_tiltDrive.setPVT(int(posT[i]), int(velT[i]), int(tm[i]), i+1);
    //	}

    // Set up for antenna scanning
    _antennaMode = SCANNING;
    //	_rotDrive.scan(40);
    //	_tiltDrive.scan(40);
    _rotDrive.scan();
    _tiltDrive.scan();
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::setCorrectionEnabled(bool enabled) {
    ILOG << "Attitude correction has been " << (enabled ? "enabled" : "disabled");
    _attitudeCorrectionEnabled = enabled;
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::_adjustForAttitude(float & rot, float & tilt, float pitch,
        float roll, float drift)
{
    float desiredRot = rot;
    float desiredTilt = tilt;

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
    // rotation needs to be in the range of 0-360
    rot  = RadToDeg(atan2(x_a, z_a));
    if (rot < 0) rot += 360.0;
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::_adjustPointingForAttitude(float pitch, float roll, float drift)
{
    // Start with the desired track-relative rotation and tilt angles
    float rot = _fixedPointingAngle;
    float tilt = 0.0;
    // Adjust to pod-relative rotation and tilt angles
    _adjustForAttitude(rot, tilt, pitch, roll, drift);
    // Move the drives to their new angles
    _rotDrive.moveTo(rot);
    _tiltDrive.moveTo(-tilt);
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::_adjustScanningForAttitude(float pitch, float roll, float drift)
{
    DLOG << "_adjustScanningForAttitude not implemented";
}

/////////////////////////////////////////////////////////////////////
MotionControl::Status::Status() :
    rotDriveResponding(false),
    rotDriveInitialized(false),
    rotDriveHomed(false),
    rotDriveStatusReg(0),
    rotDriveTemp(0),
    tiltDriveResponding(false),
    tiltDriveInitialized(false),
    tiltDriveHomed(false),
    tiltDriveStatusReg(0),
    tiltDriveTemp(0),
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
    tiltDriveResponding(mc.tiltDrive().driveResponding()),
    tiltDriveInitialized(mc.tiltDrive().driveInitialized()),
    tiltDriveHomed(mc.tiltDrive().driveHomed()),
    tiltDriveStatusReg(mc.tiltDrive().driveStatusRegister()),
    tiltDriveTemp(mc.tiltDrive().driveTemperature()),
    antennaMode(mc.antennaMode()),
    fixedPointingAngle(mc.fixedPointingAngle()),
    attitudeCorrectionEnabled(mc.attitudeCorrectionEnabled()) {
    // Use the MotionControl::getScanParams() method to get all three scan
    // parameters
    mc.getScanParams(scanCcwLimit, scanCwLimit, scanRate);
    DLOG << "rotDriveResponding: " << rotDriveResponding;
    DLOG << "rotDriveInitialized: " << rotDriveInitialized;
    DLOG << "rotDriveHomed: " << rotDriveHomed;
    DLOG << "rotDriveTemp: " << rotDriveTemp;
    DLOG << "tiltDriveResponding: " << tiltDriveResponding;
    DLOG << "tiltDriveInitialized: " << tiltDriveInitialized;
    DLOG << "tiltDriveHomed: " << tiltDriveHomed;
    DLOG << "tiltDriveTemp: " << tiltDriveTemp;
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
    tiltDriveResponding = static_cast<xmlrpc_c::value_boolean>(statusMap["tiltDriveResponding"]);
    tiltDriveInitialized = static_cast<xmlrpc_c::value_boolean>(statusMap["tiltDriveInitialized"]);
    tiltDriveHomed = static_cast<xmlrpc_c::value_boolean>(statusMap["tiltDriveHomed"]);
    tiltDriveStatusReg = static_cast<xmlrpc_c::value_int>(statusMap["tiltDriveStatusReg"]);
    tiltDriveTemp = static_cast<xmlrpc_c::value_int>(statusMap["tiltDriveTemp"]);
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
    dict["tiltDriveResponding"] = xmlrpc_c::value_boolean(tiltDriveResponding);
    dict["tiltDriveInitialized"] = xmlrpc_c::value_boolean(tiltDriveInitialized);
    dict["tiltDriveHomed"] = xmlrpc_c::value_boolean(tiltDriveHomed);
    dict["tiltDriveStatusReg"] = xmlrpc_c::value_int(tiltDriveStatusReg);
    dict["tiltDriveTemp"] = xmlrpc_c::value_int(tiltDriveTemp);
    dict["antennaMode"] = xmlrpc_c::value_int(antennaMode);
    dict["fixedPointingAngle"] = xmlrpc_c::value_double(fixedPointingAngle);
    dict["scanCcwLimit"] = xmlrpc_c::value_double(scanCcwLimit);
    dict["scanCwLimit"] = xmlrpc_c::value_double(scanCwLimit);
    dict["scanRate"] = xmlrpc_c::value_double(scanRate);
    dict["attitudeCorrectionEnabled"] = xmlrpc_c::value_boolean(attitudeCorrectionEnabled);
    // Construct an xmlrpc_c::value_struct from the map and return it.
    return(xmlrpc_c::value_struct(dict));
}
