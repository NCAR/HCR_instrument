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
	/// Constructor
	DriveConnection();
	/// Destructor
	virtual ~DriveConnection();

    /// Point the antenna to a specific angle
    /// @param angle The angle that the antenna points to
	void point(float angle);

	/// Scan the antenna between the given counterclockwise and clockwise
	/// limits, at the given scan rate.
	/// @param ccwLimit the counterclockwise limit of the scan, deg
	/// @param cwLimit the clockwise limit of the scan, deg
	/// @pararm scanRate the scan rate, deg/s
	void scan(float ccwLimit, float cwLimit, float scanRate);

	/// Update aircraft attitude used to adjust drive position
	void updateAttitude();

	/// Antenna motion mode: pointing or scanning
	typedef enum {
		POINTING,
		SCANNING
	} AntennaMode;

protected:
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

	ElmoServoDrive _rotDrive;
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

};

#endif /* DRIVECONNECTION_H_ */
