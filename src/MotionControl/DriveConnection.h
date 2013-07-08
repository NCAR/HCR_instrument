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
	void point(double angle);
	/// Update aircraft attitude used to adjust drive position
	void updateAttitude();

protected:
	/// Adjust drive position according to aircraft attitude
    /// @param pitch The aircraft pitch angle
    /// @param roll The aircraft roll angle
    /// @param drift The aircraft drift angle
	void adjustDrivePosition(double pitch, double roll, double drift);

	ElmoServoDrive _rotDrive;
	ElmoServoDrive _tiltDrive;

	/// Current angle that the antenna is pointing to
	double _pointAngle;

	/// Latest aircraft attitude (in degrees)
	double _pitch;
	double _roll;
	double _drift;

	/// Cmigits shared memory object
	CmigitsSharedMemory _cmigitsShm;

};

#endif /* DRIVECONNECTION_H_ */
