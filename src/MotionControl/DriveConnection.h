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
	/// @param keep True to keep antenna at this angle
	void point(double angle, bool keep = true);
	/// Update aircraft attitude used to adjust drive position
	void updateAttitude();

protected slots:
	/// Called when a message has arrived from rotation UDP socket
	void rotationUdpRead();

protected:
	/// Initialize the sockets
	void initUdpSockets();
	/// Adjust tile drive to point to a specific angle
	void tilt(double angle);
	/// Send a command to the specific drive
	/// @param driveSocket The drive socket
	/// @param cmd The command.
	void sendCmd(QUdpSocket* driveSocket, std::string cmd);
	/// Adjust drive position according to aircraft attitude
    /// @param pitch The aircraft pitch angle
    /// @param roll The aircraft roll angle
    /// @param drift The aircraft drift angle
	void adjustDrivePosition(double pitch, double roll, double drift);

	/// The rotation drive socket
	QUdpSocket* _rotationUdpSocket;
	/// The tilt drive socket
	QUdpSocket* _tiltUdpSocket;
	/// Drive IP
	QString _driveIP;
	/// Port number for rotation drive
	int _rotationPort;
	/// Port number for tilt drive
	int _tiltPort;

	/// Current angle that the antenna is pointing to
	double _pointAngle;

	/// Latest aircraft attitude (in degrees)
	double _pitch;
	double _roll;
	double _drift;

	/// Cmigits shared memory object
	CmigitsSharedMemory* _sharedMemory;
};

#endif /* DRIVECONNECTION_H_ */
