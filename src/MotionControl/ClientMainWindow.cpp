/*
 * ClientMainWindow.cpp
 *
 *  Created on: June 3, 2013
 *      Author: avaps
 */

#include <cstdlib>
#include "ClientMainWindow.h"

/////////////////////////////////////////////////////////////////////
ClientMainWindow::ClientMainWindow(
		MotionControlRpcClient& rpcClient,
		QWidget* parent) :
_rpcClient(rpcClient)
{
	setupUi(this);

	// Controls for Pointing
	_hsPointingAngle->setRange(0, 360);
	_hsPointingAngle->setValue(0);
	_lePointingAngle->setText("0");

	connect(_hsPointingAngle, SIGNAL(valueChanged(int)), this, SLOT(lePointingAngle(int)));
	connect(_hsPointingAngle, SIGNAL(sliderReleased()),  this, SLOT(getPointingAngle()));

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
