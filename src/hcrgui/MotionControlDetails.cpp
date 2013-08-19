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
    // Initialize with empty status
    updateStatus(MotionControl::Status());
}

void
MotionControlDetails::updateStatus(const MotionControl::Status & mcStatus) {
    _warningDetected = false;
	_errorDetected = false;
	_doRotStatus(mcStatus);
	_doTiltStatus(mcStatus);
}

void
MotionControlDetails::_doRotStatus(const MotionControl::Status & mcStatus) {
	typedef ElmoServoDrive ESD;	// compress our references to ElmoServoDrive somewhat...
	const ESD::StatusReg sr = mcStatus.rotDriveStatusReg;

	if (mcStatus.rotDriveResponding) {
		// General status
		_ui.rotRespondingIcon->setPixmap(_greenLED);
		_ui.rotMotorOnIcon->setPixmap(ESD::SREG_motorOn(sr) ?
				_greenLED : _greenLED_off);
		_ui.rotUnitModeLabel->setText(QString::number(ESD::SREG_unitMode(sr)));
		_ui.rotMotorInitializedIcon->setPixmap(mcStatus.rotDriveInitialized ?
				_greenLED : _greenLED_off);
		_ui.rotMotorHomingIcon->setPixmap(ESD::SREG_homingInProcess(sr) ?
				_amberLED : _greenLED_off);
		_ui.rotMotorHomedIcon->setPixmap(mcStatus.rotDriveHomed ? _greenLED : _greenLED_off);
		_ui.rotProgramRunningIcon->setPixmap(ESD::SREG_programRunning(sr) ?
				_amberLED : _greenLED_off);
		_ui.rotMotionStatusLabel->setText(QString::number(ESD::SREG_motionStatus(sr)));
		// Drive problem?
		bool redLight;
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
		_ui.rotProblemIcon->setPixmap(_greenLED_off);
		_ui.rotProblemCodeLabel->setText("");
		_ui.rotMotorOnIcon->setPixmap(_greenLED_off);
		_ui.rotMotorFailureIcon->setPixmap(_greenLED_off);
		_ui.rotUnitModeLabel->setText("");
		_ui.rotMotorInitializedIcon->setPixmap(_greenLED_off);
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
		_ui.tiltMotorOnIcon->setPixmap(ESD::SREG_motorOn(sr) ?
				_greenLED : _greenLED_off);
		_ui.tiltUnitModeLabel->setText(QString::number(ESD::SREG_unitMode(sr)));
		_ui.tiltMotorInitializedIcon->setPixmap(mcStatus.tiltDriveInitialized ?
				_greenLED : _greenLED_off);
		amberLight = ESD::SREG_homingInProcess(sr);
		_warningDetected = amberLight;
		_ui.tiltMotorHomingIcon->setPixmap(amberLight ?	_amberLED : _greenLED_off);
		_ui.tiltMotorHomedIcon->setPixmap(mcStatus.tiltDriveHomed ? _greenLED : _greenLED_off);
        amberLight = ESD::SREG_programRunning(sr);
        _warningDetected = amberLight;
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
		_ui.tiltProblemIcon->setPixmap(_greenLED_off);
		_ui.tiltProblemCodeLabel->setText("");
		_ui.tiltMotorOnIcon->setPixmap(_greenLED_off);
		_ui.tiltMotorFailureIcon->setPixmap(_greenLED_off);
		_ui.tiltUnitModeLabel->setText("");
		_ui.tiltMotorInitializedIcon->setPixmap(_greenLED_off);
		_ui.tiltMotorHomingIcon->setPixmap(_greenLED_off);
		_ui.tiltMotorHomedIcon->setPixmap(_greenLED_off);
		_ui.tiltProgramRunningIcon->setPixmap(_greenLED_off);
		_ui.tiltMotionStatusLabel->setText("");
		_ui.tiltCpuErrorIcon->setPixmap(_greenLED_off);
		_ui.tiltStoppedByLimitIcon->setPixmap(_greenLED_off);
	}
}
