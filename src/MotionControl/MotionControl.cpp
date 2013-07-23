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
	_rotDrive("/dev/ttydp00", "rotation"),
	_tiltDrive("/dev/ttydp01", "tilt"),
	_antennaMode(POINTING),
	_fixedPointingAngle(0),
	_cmigitsShm(),
	_fakeAttitude(true),
	_driveStartTime(QTime::currentTime())
{
}

/////////////////////////////////////////////////////////////////////
MotionControl::~MotionControl()
{
}

/////////////////////////////////////////////////////////////////////
void MotionControl::updateAttitude()
{
	/**
	 * The pitch, roll, and heading come from CmigitsSharedMemory
	 * class. Using heading along with gps heading and true ground
	 * speed (also available via CmigitsSharedMemory class), the
	 * drift can be derived.
	**/

	// Get aircraft attitude
	uint64_t dataTime;
	float pitch, roll, heading;
	_cmigitsShm.getLatest3512Data(dataTime, pitch, roll, heading);
	// Get ground speed components
	float lat, lon, alt, velNorth, velEast, velUp;
	_cmigitsShm.getLatest3501Data(dataTime, lat, lon, alt, velNorth, velEast, velUp);
	// Calculate aircraft drift
	float drift = 90 - RadToDeg(atan2(velNorth, velEast)) - heading;

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
MotionControl::point(float angle)
{
	// Set up for fixed antenna pointing
	_fixedPointingAngle = angle;
	_antennaMode = POINTING;
	_rotDrive.moveTo(angle);
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::scan(float ccwLimit, float cwLimit, float scanRate)
{
	WLOG << "scan not yet implemented";

	// Build up PVT table for rotation drive
	float rpos[40] = { 167560, 172690, 177820, 182950, 188070,
			           193200, 198330, 203450, 208580, 213700,
			           218820, 223950, 229070, 234190, 238820,
			           241590, 242520, 241590, 238820, 234190,
			           229440, 224680, 219920, 215160, 210410,
			           205650, 200890, 196130, 191370, 186610,
			           181850, 177080, 172320, 167560, 162920,
			           160140, 159220, 160140, 162920, 167560
			         };
	float rvel[40] = {  33333,   33333,    33333,  33333,  33333,
					    33333,   33333,    33333,  33333,  33333,
			            33333,   33333,    33333,  33333,  25000,
			             8333.3, -8333.3, -25000, -33333, -33333,
			           -33333,  -33333,   -33333, -33333, -33333,
			           -33333,  -33333,   -33333, -33333, -33333,
			           -33333,  -33333,   -33333, -33333, -25000,
			            -8333.3,  8333.3,  25000,  33333,  33333
			         };
	float rtm[40] = { 153.85, 153.85, 153.85, 153.85, 153.85,
			          153.85, 153.85, 153.85, 153.85, 153.85,
			          153.85, 153.85, 153.85, 153.85, 250,
			          250,    250,    250,    250,    250,
			          153.85, 153.85, 153.85, 153.85, 153.85,
			          153.85, 153.85, 153.85, 153.85, 153.85,
			          153.85, 153.85, 153.85, 250,    250,
			          250,    250,    250,    250,    250
			        };

	for (int i = 0; i < 40; i++)
		_rotDrive.setPVT(int(rpos[i]), int(rvel[i]), int(rtm[i]), i+1);

	// Set up for antenna scanning
	_antennaMode = SCANNING;
	_rotDrive.scan(40);
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
	_tiltDrive.moveTo(tilt);
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::_adjustScanningForAttitude(float pitch, float roll, float drift)
{
	ILOG << "_adjustScanningForAttitude not implemented";
}

/////////////////////////////////////////////////////////////////////
MotionControl::Status::Status() :
	rotDriveResponding(false),
	rotDriveTemp(0.0),
	tiltDriveResponding(false),
	tiltDriveTemp(0.0),
	antennaMode(POINTING),
	fixedPointingAngle(0.0),
	scanCcwLimit(0.0),
	scanCwLimit(0.0),
	scanRate(0.0) {}

/////////////////////////////////////////////////////////////////////
MotionControl::Status::Status(const MotionControl & mc) :
	rotDriveResponding(mc.rotationDrive().driveResponding()),
	rotDriveStatusReg(mc.rotationDrive().driveStatusRegister()),
	rotDriveTemp(mc.rotationDrive().driveTemperature()),
	tiltDriveResponding(mc.tiltDrive().driveResponding()),
	tiltDriveStatusReg(mc.tiltDrive().driveStatusRegister()),
	tiltDriveTemp(mc.tiltDrive().driveTemperature()),
	antennaMode(mc.antennaMode()),
	fixedPointingAngle(mc.fixedPointingAngle()) {
	mc.getScanParams(scanCcwLimit, scanCwLimit, scanRate);
	DLOG << "rotDriveResponding: " << rotDriveResponding;
	DLOG << "rotDriveTemp: " << rotDriveTemp;
	DLOG << "tiltDriveResponding: " << tiltDriveResponding;
	DLOG << "tiltDriveTemp: " << tiltDriveTemp;
}

/////////////////////////////////////////////////////////////////////
MotionControl::Status::Status(xmlrpc_c::value_struct & statusDict) {
	// Cast the given xmlrpc_c::value_struct into a map from string to
	// xmlrpc_c::value.
	std::map<std::string, xmlrpc_c::value> statusMap =
			static_cast<std::map<std::string, xmlrpc_c::value> >(statusDict);
	rotDriveResponding = static_cast<xmlrpc_c::value_boolean>(statusMap["rotDriveResponding"]);
	rotDriveStatusReg = static_cast<xmlrpc_c::value_int>(statusMap["rotDriveStatusReg"]);
	rotDriveTemp = static_cast<xmlrpc_c::value_int>(statusMap["rotDriveTemp"]);
	tiltDriveResponding = static_cast<xmlrpc_c::value_boolean>(statusMap["tiltDriveResponding"]);
	tiltDriveStatusReg = static_cast<xmlrpc_c::value_int>(statusMap["tiltDriveStatusReg"]);
	tiltDriveTemp = static_cast<xmlrpc_c::value_int>(statusMap["tiltDriveTemp"]);
	antennaMode = static_cast<AntennaMode>(int(static_cast<xmlrpc_c::value_int>(statusMap["antennaMode"])));
	fixedPointingAngle = static_cast<xmlrpc_c::value_double>(statusMap["fixedPointingAngle"]);
	scanCcwLimit = static_cast<xmlrpc_c::value_double>(statusMap["scanCcwLimit"]);
	scanCwLimit = static_cast<xmlrpc_c::value_double>(statusMap["scanCwLimit"]);
	scanRate = static_cast<xmlrpc_c::value_double>(statusMap["scanRate"]);
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
	dict["rotDriveTemp"] = xmlrpc_c::value_int(rotDriveTemp);
	dict["tiltDriveResponding"] = xmlrpc_c::value_boolean(tiltDriveResponding);
	dict["tiltDriveTemp"] = xmlrpc_c::value_int(tiltDriveTemp);
	dict["antennaMode"] = xmlrpc_c::value_int(antennaMode);
	dict["fixedPointingAngle"] = xmlrpc_c::value_double(fixedPointingAngle);
	dict["scanCcwLimit"] = xmlrpc_c::value_double(scanCcwLimit);
	dict["scanCwLimit"] = xmlrpc_c::value_double(scanCwLimit);
	dict["scanRate"] = xmlrpc_c::value_double(scanRate);
    // Construct an xmlrpc_c::value_struct from the map and return it.
    return(xmlrpc_c::value_struct(dict));
}
