/*
 * DriveConnection.cpp
 *
 *  Created on: May 30, 2013
 *      Author: avaps
 */

#include "DriveConnection.h"
#include <unistd.h>
#include <iostream>

#define PI 3.14159265
#define CntPerDeg 400000/360.0

/////////////////////////////////////////////////////////////////////
DriveConnection::DriveConnection() :
_rotationUdpSocket(0),
_tiltUdpSocket(0),
_driveIP("192.168.0.201"),
_rotationPort(2101),
_tiltPort(0),
_pointAngle(0),
_pitch(0.0),
_roll(0.0),
_drift(0.0)
{
	// Initialize the UDP sockets.
	initUdpSockets();

	_sharedMemory = new CmigitsSharedMemory();

	// Create log file driveUdpLogs.txt
	_logFile = new QFile("driveUdpLog.txt");
	_textStream = new QTextStream(_logFile);
	_logFile->open(QIODevice::WriteOnly);
}

/////////////////////////////////////////////////////////////////////
DriveConnection::~DriveConnection()
{
	// deleteLater() is used in cases where this delete may
	// be happening during a slot invocation, and there may be
	// pending signals for the object being deleted.

	if (_rotationUdpSocket)
		_rotationUdpSocket->deleteLater();

	if (_tiltUdpSocket)
		_tiltUdpSocket->deleteLater();

	if (_sharedMemory)
		delete _sharedMemory;

	if (_logFile) {
		_logFile->close();
		delete _textStream;
		delete _logFile;
	}
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
	float pitch, roll, heading, drift;
	_sharedMemory->getLatest3512Data(dataTime, pitch, roll, heading);
	// Get ground speed components
	float lat, lon, alt, velNorth, velEast, velUp;
	_sharedMemory->getLatest3501Data(dataTime, lat, lon, alt, velNorth, velEast, velUp);
	// Calculate aircraft drift
	drift = 90 - atan2(velNorth, velEast)*180/PI - heading;

	// For testing purpose, the pitch, roll, and drift will be randomly generated.

	// Update aircraft attitude data in degrees (up to +-1.0 degree)
	pitch = (rand() % 20 - 10) / 10.0;
	roll  = (rand() % 20 - 10) / 10.0;
	drift = (rand() % 20 - 10) / 10.0;

	if (_pitch != pitch || _roll != roll || _drift != drift) {
		//qDebug() << "*** Pitch" << pitch << "Roll" << roll << "Drift" << drift;
		_pitch = pitch;
		_roll  = roll;
		_drift = drift;
		adjustDrivePosition(pitch, roll, drift);
	}
}

/////////////////////////////////////////////////////////////////////
void
DriveConnection::initUdpSockets()
{
	// The rotation drive socket
	_rotationUdpSocket = new QUdpSocket(this);

	bool status = _rotationUdpSocket->bind(_rotationPort);
	if (!status) {
		qDebug() << "Unable to bind to UDP port" << _rotationPort;
		return;
	}

	connect(_rotationUdpSocket, SIGNAL(readyRead()), this, SLOT(rotationUdpRead()));
}

/////////////////////////////////////////////////////////////////////
void
DriveConnection::sendCmd(QUdpSocket* driveSocket, std::string cmd)
{
	if (cmd.empty())
		return;

	size_t sent;
	// Command will be unicast
	sent = driveSocket->writeDatagram(
			cmd.c_str(), cmd.size(), QHostAddress(_driveIP), _rotationPort);

	if (sent != cmd.size()) {
		qDebug() << "Warning, only" << sent << "bytes out of" << cmd.size() <<
				"were sent to port" << _rotationPort;
	}

	// Log the sent message
	writeLog(cmd, driveSocket, true);
}

/////////////////////////////////////////////////////////////////////
void
DriveConnection::point(double angle, bool keep)
{
	// Save current pointing angle
	if (keep)
		_pointAngle = angle;

	std::string cmd("PA=");
	cmd += QString::number(angle*CntPerDeg).toStdString();
	cmd += ";BG\n";

	sendCmd(_rotationUdpSocket, cmd);
}

/////////////////////////////////////////////////////////////////////
void
DriveConnection::tilt(double angle)
{
	std::string cmd("PA=");
	cmd += QString::number(angle*CntPerDeg).toStdString();
	cmd += ";BG\n";

	sendCmd(_tiltUdpSocket, cmd);
}

/////////////////////////////////////////////////////////////////////
void
DriveConnection::adjustDrivePosition(double pitch, double roll, double drift)
{
	// Convert degrees to radians
	pitch = pitch * PI / 180.0;
	roll  = roll  * PI / 180.0;
	drift = drift * PI / 180.0;

	// Track relative coordinates - desired beam position
	double rot_t, tilt_t;
	rot_t  = _pointAngle * PI / 180.0;
	tilt_t = 0.0;

	// Convert to track relative Cartesian coordinates
	double x_t, y_t, z_t;
	x_t = cos(tilt_t)*sin(rot_t);
	y_t = sin(tilt_t);
	z_t = cos(tilt_t)*cos(rot_t);

	// Convert to pod relative Cartesian coordinates - adjusted beam position
	double x_a, y_a, z_a;
	x_a = (cos(drift)*cos(roll)-sin(drift)*sin(pitch)*sin(roll))*x_t +
	      (sin(drift)+cos(drift)*sin(pitch)*sin(roll))*y_t - cos(pitch)*sin(roll)*z_t;
	y_a = -sin(drift)*cos(pitch)*x_t + cos(drift)*cos(pitch)*y_t + sin(pitch)*z_t;
	z_a = (cos(drift)*sin(roll)+sin(drift)*sin(pitch)*sin(roll))*x_t +
	      (sin(drift)*sin(roll)-cos(drift)*sin(pitch)*cos(roll))*y_t + cos(pitch)*cos(roll)*z_t;

	// Convert from pod relative Cartesian coordinates to polar coordinates
	double rot_a, tilt_a;
	// tilt_a needs to be divided by 2!
	tilt_a = asin(y_a)*180/PI/2;
	// rot_a needs to be in the range of 0-360
	rot_a  = atan2(x_a, z_a)*180/PI;
	if (rot_a < 0) rot_a += 360;
	qDebug() << "rot_a" << rot_a << "tilt_a" << tilt_a;

	// Adjust rotation drive
	point(rot_a, false);
	// Adjust tilt drive
	//tilt(tilt_a);
}

/////////////////////////////////////////////////////////////////////
void
DriveConnection::rotationUdpRead()
{
	// A message has arrived from the rotation drive
	while (_rotationUdpSocket->hasPendingDatagrams()) {
		// read the datagram
		int dataSize = _rotationUdpSocket->pendingDatagramSize();
		QByteArray data;
		data.resize(dataSize);
		_rotationUdpSocket->readDatagram(data.data(), dataSize);

		std::string msg = QString(data).toStdString();
		// Log the received message
		writeLog(msg, _rotationUdpSocket, false);
	}
}

/////////////////////////////////////////////////////////////////////
void
DriveConnection::writeLog(std::string msg, QUdpSocket* socket, bool toDrive)
{
	QDateTime now = QDateTime::currentDateTime();
	QString log = now.toString(QString("yyyy-MM-dd hh:mm:ss.zzzZ "));
	if (toDrive)
		log += "--> ";
	else
		log += "<-- ";
	if (socket == _rotationUdpSocket)
		log += "Rotation Drive, Message: ";
	else
		log += "Tilt Drive, Message: ";
	log += msg.c_str();

	(*_textStream) << log;
	_textStream->flush();
}
