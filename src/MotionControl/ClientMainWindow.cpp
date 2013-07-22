/*
 * ClientMainWindow.cpp
 *
 *  Created on: June 3, 2013
 *      Author: avaps
 */

#include <cstdlib>
#include <sstream>
#include "ClientMainWindow.h"

/////////////////////////////////////////////////////////////////////
ClientMainWindow::ClientMainWindow(
		MotionControlRpcClient& rpcClient,
		QWidget* parent) :
_rpcClient(rpcClient),
_statusTimer()
{
	setupUi(this);

	// Controls for Pointing
	_hsPointingAngle->setRange(0, 360);
	_hsPointingAngle->setValue(0);
	_lePointingAngle->setText("0");

	connect(_hsPointingAngle, SIGNAL(valueChanged(int)), this, SLOT(lePointingAngle(int)));
	connect(_hsPointingAngle, SIGNAL(sliderReleased()),  this, SLOT(getPointingAngle()));

	// Update status every second
	connect(& _statusTimer, SIGNAL(timeout()), this, SLOT(updateStatus()));
	_statusTimer.start(1000);

	// Hide statusbar
	_statusbar->setVisible(false);
}

/////////////////////////////////////////////////////////////////////
ClientMainWindow::~ClientMainWindow()
{
}

/////////////////////////////////////////////////////////////////////
void
ClientMainWindow::lePointingAngle(int angle)
{
	_lePointingAngle->setText(QString::number(angle));
}

/////////////////////////////////////////////////////////////////////
void
ClientMainWindow::getPointingAngle()
{
	int angle = _hsPointingAngle->value();

	_rpcClient.point(angle);
}

/////////////////////////////////////////////////////////////////////
void
ClientMainWindow::updateStatus()
{
	MotionControl::Status status = _rpcClient.status();
	if (! _rpcClient.daemonResponding()) {
		_statusLabel->setText("MotionControlDaemon not responding");
	} else {
		std::ostringstream ss;
		switch (status.antennaMode) {
		case MotionControl::POINTING:
			ss << "Fixed pointing at " << status.fixedPointingAngle << " degrees";
			break;
		case MotionControl::SCANNING:
			ss << "Scanning from " << status.scanCcwLimit << " CCW to " <<
				status.scanCwLimit << " CW at " << status.scanRate << " deg/s";
			break;
		default:
			ss << "Unknown antenna mode: " << status.antennaMode;
			break;
		}
		_statusLabel->setText(ss.str().c_str());
	}
}
