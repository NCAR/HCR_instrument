// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2016                                         
// ** University Corporation for Atmospheric Research (UCAR)                 
// ** National Center for Atmospheric Research (NCAR)                        
// ** Boulder, Colorado, USA                                                 
// ** BSD licence applies - redistribution and use in source and binary      
// ** forms, with or without modification, are permitted provided that       
// ** the following conditions are met:                                      
// ** 1) If the software is modified to produce derivative works,            
// ** such modified software should be clearly marked, so as not             
// ** to confuse it with the version available from UCAR.                    
// ** 2) Redistributions of source code must retain the above copyright      
// ** notice, this list of conditions and the following disclaimer.          
// ** 3) Redistributions in binary form must reproduce the above copyright   
// ** notice, this list of conditions and the following disclaimer in the    
// ** documentation and/or other materials provided with the distribution.   
// ** 4) Neither the name of UCAR nor the names of its contributors,         
// ** if any, may be used to endorse or promote products derived from        
// ** this software without specific prior written permission.               
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS  
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED      
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.    
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
/*
 * MotionControlDetails.cpp
 *
 *  Created on: Jul 23, 2013
 *      Author: burghart
 */
#include "MotionControlDetails.h"
#include <QDateTime>
#include <Cmigits.h>

MotionControlDetails::MotionControlDetails(QWidget *parent) :
    QDialog(parent),
    _ui(),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png"),
    _redLED(":/redLED.png") {
    // Set up the UI and get the current status
    _ui.setupUi(this);
    // Initialize with no daemon response and empty status
    updateStatus(false, MotionControl::Status());
}

void
MotionControlDetails::updateStatus(bool daemonResponding,
        const MotionControl::Status & mcStatus) {
    // Based on whether the daemon is responding, set the "daemon responding"
    // label, and set the enabled state for the rest of the components.
    _ui.daemonRespondingLabel->setText(daemonResponding ?
            "" : "<font color='DarkRed'>No MotionControlDaemon!</font>");
    _ui.statusFrame->setEnabled(daemonResponding);

    // Fill in the rest from the status we were given
    _warningDetected = false;
	_errorDetected = false;
	_doRotStatus(mcStatus);
	_doTiltStatus(mcStatus);
}

void
MotionControlDetails::_doRotStatus(const MotionControl::Status & mcStatus) {
	typedef ElmoServoDrive ESD;	// compress our references to ElmoServoDrive somewhat...
	const ESD::StatusReg sr = mcStatus.rotDriveStatusReg;

    bool amberLight;
    bool redLight;
    if (mcStatus.rotDriveResponding) {
        // General status
        _ui.rotRespondingIcon->setPixmap(_greenLED);

        amberLight = mcStatus.rotDriveInhibitActive;
        _warningDetected |= amberLight;
        _ui.rotInhibitIcon->setPixmap(amberLight ? _amberLED : _greenLED_off);

        _ui.rotMotorOnIcon->setPixmap(ESD::SREG_motorOn(sr) ?
                _greenLED : _greenLED_off);

        _ui.rotUnitModeLabel->setText(QString::number(ESD::SREG_unitMode(sr)));

        _ui.rotMotorInitializedIcon->setPixmap(mcStatus.rotDriveInitialized ?
                _greenLED : _greenLED_off);
        
        _ui.rotAngleValue->setText(QString::number(mcStatus.rotDriveAngle, 'f', 2));
        _ui.rotTempValue->setText(QString::number(mcStatus.rotDriveTemp));

        amberLight = ESD::SREG_homingInProcess(sr);
        _warningDetected |= amberLight;
        _ui.rotMotorHomingIcon->setPixmap(amberLight ? _amberLED : _greenLED_off);

        _ui.rotMotorHomedIcon->setPixmap(mcStatus.rotDriveHomed ? _greenLED : _greenLED_off);

        amberLight = ESD::SREG_programRunning(sr);
        _warningDetected |= amberLight;
        _ui.rotProgramRunningIcon->setPixmap(amberLight ? _amberLED : _greenLED_off);

        _ui.rotMotionStatusLabel->setText(QString::number(ESD::SREG_motionStatus(sr)));

        // Drive problem?
        redLight = ESD::SREG_driveProblem(sr);
        _errorDetected |= redLight;
        _ui.rotProblemIcon->setPixmap(redLight ? _redLED : _greenLED_off);

        _ui.rotProblemCodeLabel->
            setText(QString::number(ESD::SREG_statusIndication(sr)));

        // Motor failure?
        redLight = ESD::SREG_motorFailure(sr);
        _errorDetected |= redLight;
        _ui.rotMotorFailureIcon->setPixmap(redLight ? _redLED : _greenLED_off);

        // Drive CPU problem?
        redLight = ESD::SREG_cpuProblem(sr);
        _errorDetected |= redLight;
        _ui.rotCpuErrorIcon->setPixmap(redLight ? _redLED : _greenLED_off);

        // Drive stopped by limit?
        redLight = ESD::SREG_stoppedByLimit(sr);
        _errorDetected |= redLight;
        _ui.rotStoppedByLimitIcon->setPixmap(redLight ? _redLED : _greenLED_off);

        // User program error?
        redLight = ESD::SREG_userProgramError(sr);
        _errorDetected |= redLight;
        _ui.rotProgramErrorIcon->setPixmap(redLight ? _redLED : _greenLED_off);
	} else {
		_errorDetected = true;
		_ui.rotRespondingIcon->setPixmap(_redLED);
		_ui.rotInhibitIcon->setPixmap(_greenLED_off);
		_ui.rotProblemIcon->setPixmap(_greenLED_off);
		_ui.rotProblemCodeLabel->setText("");
		_ui.rotMotorOnIcon->setPixmap(_greenLED_off);
		_ui.rotMotorFailureIcon->setPixmap(_greenLED_off);
		_ui.rotUnitModeLabel->setText("");
		_ui.rotMotorInitializedIcon->setPixmap(_greenLED_off);
		_ui.rotAngleValue->setText("x.xx");
		_ui.rotTempValue->setText("xx");
		_ui.rotMotorHomingIcon->setPixmap(_greenLED_off);
		_ui.rotMotorHomedIcon->setPixmap(_greenLED_off);
		_ui.rotProgramRunningIcon->setPixmap(_greenLED_off);
		_ui.rotMotionStatusLabel->setText("");
		_ui.rotCpuErrorIcon->setPixmap(_greenLED_off);
		_ui.rotStoppedByLimitIcon->setPixmap(_greenLED_off);
	}
}

void
MotionControlDetails::_doTiltStatus(const MotionControl::Status & mcStatus) {
	typedef ElmoServoDrive ESD;	// compress our references to ElmoServoDrive somewhat...
	const ESD::StatusReg sr = mcStatus.tiltDriveStatusReg;

	bool amberLight;
	bool redLight;
	if (mcStatus.tiltDriveResponding) {
		// General status
		_ui.tiltRespondingIcon->setPixmap(_greenLED);

        amberLight = mcStatus.tiltDriveInhibitActive;
        _warningDetected |= amberLight;
        _ui.tiltInhibitIcon->setPixmap(amberLight ? _amberLED : _greenLED_off);

		_ui.tiltMotorOnIcon->setPixmap(ESD::SREG_motorOn(sr) ?
				_greenLED : _greenLED_off);

		_ui.tiltUnitModeLabel->setText(QString::number(ESD::SREG_unitMode(sr)));

		_ui.tiltMotorInitializedIcon->setPixmap(mcStatus.tiltDriveInitialized ?
				_greenLED : _greenLED_off);

        _ui.tiltAngleValue->setText(QString::number(mcStatus.tiltDriveAngle, 'f', 2));
        _ui.tiltTempValue->setText(QString::number(mcStatus.tiltDriveTemp));

		amberLight = ESD::SREG_homingInProcess(sr);
		_warningDetected |= amberLight;
		_ui.tiltMotorHomingIcon->setPixmap(amberLight ?	_amberLED : _greenLED_off);

		_ui.tiltMotorHomedIcon->setPixmap(mcStatus.tiltDriveHomed ? _greenLED : _greenLED_off);

		amberLight = ESD::SREG_programRunning(sr);
        _warningDetected |= amberLight;
		_ui.tiltProgramRunningIcon->setPixmap(amberLight ? _amberLED : _greenLED_off);

		_ui.tiltMotionStatusLabel->setText(QString::number(ESD::SREG_motionStatus(sr)));

		// Drive problem?
		redLight = ESD::SREG_driveProblem(sr);
		_errorDetected |= redLight;
		_ui.tiltProblemIcon->setPixmap(redLight ? _redLED : _greenLED_off);

		_ui.tiltProblemCodeLabel->
			setText(QString::number(ESD::SREG_statusIndication(sr)));

		// Motor failure?
		redLight = ESD::SREG_motorFailure(sr);
		_errorDetected |= redLight;
		_ui.tiltMotorFailureIcon->setPixmap(redLight ? _redLED : _greenLED_off);

		// Drive CPU problem?
		redLight = ESD::SREG_cpuProblem(sr);
		_errorDetected |= redLight;
		_ui.tiltCpuErrorIcon->setPixmap(redLight ? _redLED : _greenLED_off);

		// Drive stopped by limit?
		redLight = ESD::SREG_stoppedByLimit(sr);
		_errorDetected |= redLight;
		_ui.tiltStoppedByLimitIcon->setPixmap(redLight ? _redLED : _greenLED_off);

		// User program error?
		redLight = ESD::SREG_userProgramError(sr);
		_errorDetected |= redLight;
		_ui.tiltProgramErrorIcon->setPixmap(redLight ? _redLED : _greenLED_off);
	} else {
		_errorDetected = true;
		_ui.tiltRespondingIcon->setPixmap(_redLED);
		_ui.tiltInhibitIcon->setPixmap(_greenLED_off);
		_ui.tiltProblemIcon->setPixmap(_greenLED_off);
		_ui.tiltProblemCodeLabel->setText("");
		_ui.tiltMotorOnIcon->setPixmap(_greenLED_off);
		_ui.tiltMotorFailureIcon->setPixmap(_greenLED_off);
		_ui.tiltUnitModeLabel->setText("");
		_ui.tiltMotorInitializedIcon->setPixmap(_greenLED_off);
        _ui.tiltAngleValue->setText("x.xx");
        _ui.tiltTempValue->setText("xx");
		_ui.tiltMotorHomingIcon->setPixmap(_greenLED_off);
		_ui.tiltMotorHomedIcon->setPixmap(_greenLED_off);
		_ui.tiltProgramRunningIcon->setPixmap(_greenLED_off);
		_ui.tiltMotionStatusLabel->setText("");
		_ui.tiltCpuErrorIcon->setPixmap(_greenLED_off);
		_ui.tiltStoppedByLimitIcon->setPixmap(_greenLED_off);
	}
}
