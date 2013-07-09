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
	_cmigitsShm(),
	_fakeAttitude(true),
	_driveStartTime(QTime::currentTime())
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

	// Substitute fake attitude if requested
	if (_fakeAttitude) {
		// How many seconds since we started the drive?
		float secsRunning = 0.001 * _driveStartTime.msecsTo(QTime::currentTime());
		if (secsRunning < 0)
			secsRunning += 86400;	// secs per day

		// Pitch the aircraft through +/- 10 deg every seven seconds.
		pitch = 10.0 * sin(2.0 * M_PI * fmod(secsRunning / 7.0, 1.0));
		// Roll the aircraft through +/- 45 deg every 12 seconds.
		roll = 45 * sin(2.0 * M_PI * fmod(secsRunning / 12.0, 1.0));
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
DriveConnection::_adjustForAttitude(float & rot, float & tilt, float pitch,
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
DriveConnection::_adjustPointingForAttitude(float pitch, float roll, float drift)
{
	// Start with the desired track-relative rotation and tilt angles
	float rot = _pointingAngle;
	float tilt = 0.0;
	// Adjust to pod-relative rotation and tilt angles
	_adjustForAttitude(rot, tilt, pitch, roll, drift);
	// Move the drives to their new angles
	_rotDrive.moveTo(rot);
	_tiltDrive.moveTo(tilt);
}

/////////////////////////////////////////////////////////////////////
void
DriveConnection::_adjustScanningForAttitude(float pitch, float roll, float drift)
{
	ILOG << "_adjustScanningForAttitude not implemented";
}
