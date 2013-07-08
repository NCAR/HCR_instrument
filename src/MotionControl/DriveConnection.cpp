/*
 * DriveConnection.cpp
 *
 *  Created on: May 30, 2013
 *      Author: Xuanyong Xu
 */

#include "DriveConnection.h"
#include <unistd.h>
#include <iostream>
#include <logx/Logging.h>

LOGGING("DriveConnection")

inline float DegToRad(float deg) { return(M_PI * deg / 180.0); }
inline float RadToDeg(float rad) { return(180.0 * rad / M_PI); }

/////////////////////////////////////////////////////////////////////
DriveConnection::DriveConnection() :
	_rotDrive("/dev/ttydp00", "rotation"),
	_tiltDrive("/dev/ttydp01", "tilt"),
	_antennaMode(POINTING),
	_pointingAngle(0),
	_cmigitsShm()
{
}

/////////////////////////////////////////////////////////////////////
DriveConnection::~DriveConnection()
{
}

/////////////////////////////////////////////////////////////////////
void DriveConnection::updateAttitude()
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

	// For testing purpose, the pitch, roll, and drift will be randomly generated.

	// Update aircraft attitude data in degrees (up to +-1.0 degree)
	pitch = ((rand() % 1000) * 0.001 - 0.5) * 2;
	roll  = ((rand() % 1000) * 0.001 - 0.5) * 2;
	drift = ((rand() % 1000) * 0.001 - 0.5) * 2;

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
DriveConnection::point(float angle)
{
	// Set up for fixed antenna pointing
	_pointingAngle = angle;
	_antennaMode = POINTING;
	_rotDrive.moveTo(angle);
}

/////////////////////////////////////////////////////////////////////
void
DriveConnection::scan(float ccwLimit, float cwLimit, float scanRate)
{
	WLOG << "scan not yet implemented";
}

/////////////////////////////////////////////////////////////////////
void
DriveConnection::_adjustPointingForAttitude(float pitch, float roll, float drift)
{
	double sinPitch = sin(DegToRad(pitch));
	double cosPitch = cos(DegToRad(pitch));

	double sinRoll = sin(DegToRad(roll));
	double cosRoll = cos(DegToRad(roll));

	double sinDrift = sin(DegToRad(drift));
	double cosDrift = cos(DegToRad(drift));

	// Track relative coordinates - desired beam position
	double sinPoint = sin(DegToRad(_pointingAngle));
	double cosPoint = cos(DegToRad(_pointingAngle));

	double tiltAngle = 0.0;	// fixed!
	double sinTilt = sin(DegToRad(tiltAngle));
	double cosTilt = cos(DegToRad(tiltAngle));

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
	double rot_a, tilt_a;
	// tilt_a needs to be divided by 2!
	tilt_a = RadToDeg(asin(y_a)) / 2;
	// rot_a needs to be in the range of 0-360
	rot_a  = RadToDeg(atan2(x_a, z_a));
	if (rot_a < 0) rot_a += 360.0;

	// Adjust rotation drive
	_rotDrive.moveTo(rot_a);
	// Adjust tilt drive
	_tiltDrive.moveTo(tilt_a);
}

/////////////////////////////////////////////////////////////////////
void
DriveConnection::_adjustScanningForAttitude(float pitch, float roll, float drift)
{
	ILOG << "_adjustScanningForAttitude not implemented";
}
