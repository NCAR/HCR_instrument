/*
 * DriveConnection.h
 *
 *  Created on: May 30, 2013
 *      Author: avaps
 */

#ifndef DRIVECONNECTION_H_
#define DRIVECONNECTION_H_

#include <QtCore>
#include <QtNetwork>

#include "CmigitsSharedMemory.h"
#include "ElmoServoDrive.h"

class DriveConnection : public QObject
{
	Q_OBJECT

public:
	/// @brief Constructor
	DriveConnection();
	/// @brief Destructor
	virtual ~DriveConnection();

    /// @brief Point the antenna to a specific angle
    /// @param angle The angle that the antenna points to
	void point(float angle);

	/// @brief Scan the antenna between the given counterclockwise and clockwise
	/// limits, at the given scan rate.
	/// @param ccwLimit the counterclockwise limit of the scan, deg
	/// @param cwLimit the clockwise limit of the scan, deg
	/// @pararm scanRate the scan rate, deg/s
	void scan(float ccwLimit, float cwLimit, float scanRate);

	/// @brief Get current aircraft attitude and adjust drive position
	void updateAttitude();

	/// @brief Return a reference to the rotation drive.
	/// @return a reference to the rotation drive.
	const ElmoServoDrive & rotationDrive() const { return(_rotDrive); }

	/// @brief Return a reference to the tilt drive.
	/// @return a reference to the tilt drive.
	const ElmoServoDrive & tiltDrive() const { return(_tiltDrive); }

	/// Antenna motion mode: pointing or scanning
	typedef enum {
		POINTING,
		SCANNING
	} AntennaMode;

protected:
	// Given desired rotation and tilt angles, adjust to pod-relative angles
	// using the given pod attitude information.
	// @param[in,out] rot the desired rotation angle (in), and the needed
	//	 pod-relative rotation angle (out), deg
	// @param[in,out] tilt the desired tilt angle (in), and the needed
	//   pod-relative tilt angle (out), deg
	// @param pitch the pod pitch, deg
	// @param roll the pod roll angle, deg
	// @param drift the pod drift angle, deg
	void _adjustForAttitude(float & rot, float & tilt, float pitch, float roll,
			float drift);

	/// Adjust pointing position according to aircraft attitude
    /// @param pitch The aircraft pitch angle
    /// @param roll The aircraft roll angle
    /// @param drift The aircraft drift angle
	void _adjustPointingForAttitude(float pitch, float roll, float drift);

	/// Adjust scanning table according to aircraft attitude
    /// @param pitch The aircraft pitch angle
    /// @param roll The aircraft roll angle
    /// @param drift The aircraft drift angle
	void _adjustScanningForAttitude(float pitch, float roll, float drift);

	/// Rotation drive
	ElmoServoDrive _rotDrive;
	/// Tilt drive
	ElmoServoDrive _tiltDrive;

	/// Current antenna mode
	AntennaMode _antennaMode;

	/// Current angle that the antenna is pointing to
	float _pointingAngle;

	/// Scanning counterclockwise limit, deg
	float _ccwLimit;

	/// Scanning clockwise limit, deg
	float _cwLimit;

	/// Scan rate, deg/s
	float _scanRate;

	/// Cmigits shared memory object
	CmigitsSharedMemory _cmigitsShm;

	/// Are we generating fake attitude values?
	bool _fakeAttitude;

	/// Drive "start" time (object instantiation time), used when generating
	/// fake attitude.
	QTime _driveStartTime;
};

#endif /* DRIVECONNECTION_H_ */
