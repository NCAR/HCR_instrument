/*
 * HcrGuiMainWindow.cpp
 *
 *  Created on: Jan 14, 2011
 *      Author: burghart
 */
#include "HcrGuiMainWindow.h"

#include <cmath>
#include <sstream>
#include <unistd.h>
#include <logx/Logging.h>

#include <QDateTime>
#include <QMessageBox>

LOGGING("HcrGuiMainWindow")


HcrGuiMainWindow::HcrGuiMainWindow(std::string xmitterHost, 
    int xmitterPort, std::string rdsHost, int hcrdrxPort,
    int cmigitsPort, int motionControlPort) :
    QMainWindow(),
    _ui(),
    _updateTimer(this),
    _cmigitsDetails(this),
    _xmitDetails(this),
    _antennaModeDialog(this),
    _motionControlDetails(this),
    _xmitdStatusThread(xmitterHost, xmitterPort),
    _mcClientThread(rdsHost, motionControlPort),
    _drxStatusThread(rdsHost, hcrdrxPort),
    _cmigitsDaemonRpcClient(rdsHost, cmigitsPort),
    _redLED(":/redLED.png"),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png"),
    _nextLogIndex(0),
    _lastAngleUpdate(QDateTime::currentDateTime()) {
    // Set up the UI
    _ui.setupUi(this);
    // Limit the log area to 1000 messages
    _ui.logArea->setMaximumBlockCount(1000);
    _logMessage("hcrgui started");
    
    std::ostringstream ss;
    ss << "No response yet from hcr_xmitd at " << xmitterHost << ":" <<
            xmitterPort;
    _logMessage(ss.str());

    ss.str("");
    ss << "No response yet from hcrdrx at " << rdsHost << ":" <<
            hcrdrxPort;
    _logMessage(ss.str());

    // Disable the data system box and CmigitsDetails dialog until we get
    // status from hcrdrx.
    _ui.setHmcModeBox->setEnabled(false);
    _cmigitsDetails.setEnabled(false);

    // Connect signals from our HcrdrxStatusThread object and start the thread.
    connect(& _drxStatusThread, SIGNAL(serverResponsive(bool)),
            this, SLOT(_drxResponsivenessChange(bool)));
    connect(& _drxStatusThread, SIGNAL(newStatus(DrxStatus)),
            this, SLOT(_setDrxStatus(DrxStatus)));
    _drxStatusThread.start();

    // Disable the transmitter box.
    _ui.xmitterBox->setEnabled(false);
    // Connect signals from our XmitdStatusThread object and start the thread.
    connect(& _xmitdStatusThread, SIGNAL(serverResponsive(bool)),
            this, SLOT(_xmitdResponsivenessChange(bool)));
    connect(& _xmitdStatusThread, SIGNAL(newStatus(XmitStatus)),
            this, SLOT(_setXmitStatus(XmitStatus)));
    _xmitdStatusThread.start();

    // Connect and start the MotionControlStatusThread
    connect(& _mcClientThread, SIGNAL(serverResponsive(bool)),
            this, SLOT(_mcResponsivenessChange(bool)));
    connect(& _mcClientThread, SIGNAL(newStatus(MotionControl::Status)),
            this, SLOT(_setMotionControlStatus(MotionControl::Status)));
    _mcClientThread.start();

    // QUdpSocket listening for broadcast of angles
    _angleSocket.bind(45454, QUdpSocket::ShareAddress);
    connect(&_angleSocket, SIGNAL(readyRead()), this, SLOT(_readAngles()));

    // Update every second
    connect(& _updateTimer, SIGNAL(timeout()), this, SLOT(_update()));
    _updateTimer.start(1000);

    // Show rotation and tile angle display
    _showRotAngle(0);
    _showTiltAngle(0);
}

HcrGuiMainWindow::~HcrGuiMainWindow() {
}

void
HcrGuiMainWindow::_setDrxStatus(DrxStatus status) {
    _drxStatus = status;
    _update();
}

void
HcrGuiMainWindow::_drxResponsivenessChange(bool responding) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "hcrdrx @ " <<
            _drxStatusThread.rpcClient().getHcrdrxHost() << ":" <<
            _drxStatusThread.rpcClient().getHcrdrxPort() <<
            (responding ? " is " : " is not ") <<
            "responding";
    _logMessage(ss.str().c_str());

    _ui.setHmcModeBox->setEnabled(responding);
    _cmigitsDetails.setEnabled(responding);
    if (! responding) {
        // Create a default (bad) DrxStatus, and set it as the last status
        // received.
        _setDrxStatus(DrxStatus());
    }
}

void
HcrGuiMainWindow::_mcResponsivenessChange(bool responding) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "MotionControlDaemon @ " <<
            _mcClientThread.rpcClient().daemonUrl() <<
            (responding ? " is " : " is not ") <<
            "responding";
    _logMessage(ss.str().c_str());
}

void
HcrGuiMainWindow::_setXmitStatus(XmitStatus status) {
    _xmitStatus = status;
    _update();
    // Append new log messages from hcr_xmitd
    _appendXmitdLogMsgs();
}

void
HcrGuiMainWindow::_setMotionControlStatus(const MotionControl::Status & status) {
    _mcStatus = status;
    _update();
}

void
HcrGuiMainWindow::_xmitdResponsivenessChange(bool responding) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "hcr_xmitd @ " <<
            _xmitdStatusThread.rpcClient().getXmitdHost() << ":" <<
            _xmitdStatusThread.rpcClient().getXmitdPort() <<
            (responding ? " is " : " is not ") <<
            "responding";
    _logMessage(ss.str().c_str());

    _ui.xmitterBox->setEnabled(responding);
    if (! responding) {
        // If we lose contact with hcr_xmitd, reset _nextLogIndex to zero so we
        // start fresh when we connect again
        _nextLogIndex = 0;
        // Create a default (bad) XmitStatus, and set it as the last status
        // received.
        _setXmitStatus(XmitStatus());
    }
}

bool
HcrGuiMainWindow::_xmitterFilamentOn() const {
    // If transmitter control is via RS-232 or front panel, we can trust the
    // "filament on" bit in the transmitter's status. Otherwise, we just test
    // if the hcrdrx is commanding "filament on" via its RDS control
    // line.
    return(_xmitStatus.rdsCtlEnabled() ?
            _drxStatus.rdsXmitterFilamentOn() : _xmitStatus.filamentOn());
}

bool
HcrGuiMainWindow::_xmitterHvOn() const {
    // If transmitter control is via RS-232 or front panel, we can trust the
    // "filament on" bit in the transmitter's status. Otherwise, we just test
    // if the hcrdrx is commanding "filament on" via its RDS control
    // line.
    return(_xmitStatus.rdsCtlEnabled() ?
            _drxStatus.rdsXmitterHvOn() : _xmitStatus.highVoltageOn());
}

bool
HcrGuiMainWindow::_xmitting() const {
    // If transmitter control is via RS-232 or front panel, we can trust the
    // "RF on" status bit to tell us we're transmitting. Otherwise, we need
    // to cobble together information provided by the RDS.
    if (!_xmitStatus.rdsCtlEnabled()) {
        return(_xmitStatus.rfOn());
    } else {
        // We're transmitting if the filament is on, HV is on, and modulation
        // pulses are being allowed through.
        return(_xmitterFilamentOn() && _xmitterHvOn() &&
                ! _drxStatus.modPulseDisabled());
    }
}
/// Toggle the current on/off state of the transmitter klystron filament
void
HcrGuiMainWindow::on_filamentButton_clicked() {
    if (_xmitStatus.rs232CtlEnabled()) {
        // If RS-232 control is enabled, then transmitter commands go
        // to hcr_xmitd, which owns the serial line talking to the transmitter
        // CMU.
        if (_xmitterFilamentOn()) {
            _xmitdStatusThread.rpcClient().xmitFilamentOff();
        } else {
            _xmitdStatusThread.rpcClient().xmitFilamentOn();
        }
    } else if (_xmitStatus.rdsCtlEnabled()) {
        // If RDS control is enabled, then transmitter commands go to hcrdrx
        // (i.e., the Remote Data System), since it owns the digital lines
        // controlling the transmitter.
        if (_xmitterFilamentOn()) {
            _drxStatusThread.rpcClient().xmitFilamentOff();
        } else {
            _drxStatusThread.rpcClient().xmitFilamentOn();
        }
    }
}

/// Toggle the current on/off state of the transmitter high voltage
void
HcrGuiMainWindow::on_hvButton_clicked() {
    if (_xmitStatus.rs232CtlEnabled()) {
        // If RS-232 control is enabled, then transmitter commands go
        // to hcr_xmitd, which owns the serial line talking to the transmitter
        // CMU.
        if (_xmitterHvOn()) {
            _xmitdStatusThread.rpcClient().xmitHvOff();
        } else {
            _xmitdStatusThread.rpcClient().xmitHvOn();
        }
    } else if (_xmitStatus.rdsCtlEnabled()) {
        // If RDS control is enabled, then transmitter commands go to hcrdrx
        // (i.e., the Remote Data System), since it owns the digital lines
        // controlling the transmitter.
        if (_xmitterHvOn()) {
            _drxStatusThread.rpcClient().xmitHvOff();
        } else {
            _drxStatusThread.rpcClient().xmitHvOn();
        }
    }
}

/// Set HMC mode
void
HcrGuiMainWindow::on_hmcModeCombo_activated(int index) {
    _drxStatusThread.rpcClient().setHmcMode(index);
}

/// Pop up the antenna mode editing dialog
void
HcrGuiMainWindow::on_antennaModeButton_clicked() {
    if (_antennaModeDialog.exec() == QDialog::Accepted) {
    	if (_antennaModeDialog.getMode() == AntennaModeDialog::POINTING) {
    		float angle;
    		_antennaModeDialog.getPointingAngle(angle);
    		// Point the antenna to the angle
        	_mcClientThread.rpcClient().point(angle);
    	}
    	else if (_antennaModeDialog.getMode() == AntennaModeDialog::SCANNING) {
    		float ccwLimit, cwLimit, scanRate;
    		_antennaModeDialog.getScanningParam(ccwLimit, cwLimit, scanRate);
    		// Put the antenna to scan
    		_mcClientThread.rpcClient().scan(ccwLimit, cwLimit, scanRate);
    	}
    }
}

/// Set drives to home position
void
HcrGuiMainWindow::on_driveHomeButton_clicked() {
    // Confirm that it's OK to set drives to home position
    QMessageBox confirmBox(QMessageBox::Question, "Confirm Home Drives",
            "Continue to home the drives?",
            QMessageBox::Ok | QMessageBox::Cancel, this);
    confirmBox.setInformativeText(
            "Radar transmitter must be turned off before homing drives!\n");
    if (confirmBox.exec() == QMessageBox::Cancel) {
        return;
    }

    // We got confirmation, so start the homing procedure.
    _mcClientThread.rpcClient().homeDrive();

    // Poll until homing is complete
    ILOG << "Waiting for servo drives to complete homing";
    while (true) {
        if (! _mcClientThread.rpcClient().homingInProgress()) {
            break;
        }
        // Let other things run for up to 200 ms
        QCoreApplication::processEvents(QEventLoop::AllEvents, 200);
    }
    
    // Update motion control status and verify drives are homed. Pop up
    // a warning box if homing failed.
    _mcStatus = _mcClientThread.rpcClient().status();
    if (! _mcStatus.rotDriveHomed || ! _mcStatus.tiltDriveHomed) {
        // Let the user know that homing failed
        QMessageBox failureBox(QMessageBox::Warning, "Homing Failed",
                "Drive homing failed!\nYou will need to try again.",
                QMessageBox::Ok, this);
        failureBox.exec();
        // Just return now
        return;
    }

    // With the motors positioned at zero, tell the Pentek to zero *its* 
    // position counts now for both motors.
    ILOG << "Elmo homing complete. Zeroing Pentek's motor counts.";
    _drxStatusThread.rpcClient().zeroPentekMotorCounts();
}

/// Toggle motion control attitude correction
void
HcrGuiMainWindow::on_attitudeCorrectionButton_clicked() {
    // Toggle the current state of attitude correction
    bool correction = _mcStatus.attitudeCorrectionEnabled;
    ILOG << "Correction is currently " << (correction ? "enabled": "disabled");
    _mcClientThread.rpcClient().setCorrectionEnabled(! correction);
}

void
HcrGuiMainWindow::_appendXmitdLogMsgs() {
    unsigned int firstIndex = _nextLogIndex;
    std::string msgs;
    _xmitdStatusThread.rpcClient().getLogMessages(firstIndex, msgs, _nextLogIndex);
    if (_nextLogIndex != firstIndex) {
        _ui.logArea->appendPlainText(msgs.c_str());
    }
}

void
HcrGuiMainWindow::on_xmitterDetailsButton_clicked() {
    _xmitDetails.show();
}

void
HcrGuiMainWindow::on_cmigitsDetailsButton_clicked() {
    _cmigitsDetails.show();
}

void
HcrGuiMainWindow::on_cmigitsInitButton_clicked() {
    // Confirm that it's OK to begin initialization
    QMessageBox confirmBox(QMessageBox::Question, "Confirm Initialization",
            "Continue with C-MIGITS initialization?", 
            QMessageBox::Ok | QMessageBox::Cancel, this);
    confirmBox.setInformativeText("Criteria for initialization are:\n\n"
            "Aircraft is stationary and will remain stationary\n"
            "for two minutes.\n"
            "\n"
            "OR\n"
            "\n"
            "Aircraft is flying straight and level, and will continue\n"
            "straight and level until the C-MIGITS leaves 'Coarse\n"
            "Alignment' submode, *followed* by an acceleration\n"
            "(speed change or turn).");
    if (confirmBox.exec() == QMessageBox::Cancel) {
        return;
    }
    
    // We got confirmation, so send the XML-RPC command to begin initialization.
    try {
        if (_cmigitsDaemonRpcClient.initializeUsingIwg1()) {
            QMessageBox msgBox(QMessageBox::Information,
                    "C-MIGITS initialization", "C-MIGITS initialization started",
                    QMessageBox::Close, this);
            msgBox.exec();
        } else {
            QMessageBox msgBox(QMessageBox::Warning,
                    "C-MIGITS initialization", "Failed to start C-MIGITS initialization",
                    QMessageBox::Close, this);
            msgBox.setInformativeText("This generally happens if the C-MIGITS "
                    "is not getting IWG1 packets.");
            msgBox.exec();
        }
    } catch (std::exception & e) {
        std::ostringstream ss;
        ss << "XML-RPC error calling initializeUsingIwg1(): " << e.what();
        _logMessage(ss.str());
        QMessageBox msgBox(QMessageBox::Warning, "cmigitsDaemon XML-RPC Error",
                "Error calling initializeUsingIwg1()", QMessageBox::Close, this);
        msgBox.setDetailedText(e.what());
        msgBox.exec();
    }
}

void
HcrGuiMainWindow::on_mcDetailsButton_clicked() {
    _motionControlDetails.show();
}

void
HcrGuiMainWindow::_update() {
    // Update the current time string
    char timestring[32];
    time_t now = time(0);
    strftime(timestring, sizeof(timestring) - 1, "%F %T", gmtime(&now));
    _ui.clockLabel->setText(timestring);
    
    // Update transmitter control
    _ui.xmitterBox->setEnabled(_xmitStatus.serialConnected());
    _ui.powerValidIcon->setPixmap(_xmitStatus.psmPowerOn() ? _greenLED : _greenLED_off);
    _ui.filamentIcon->setPixmap(_xmitterFilamentOn() ? _greenLED : _greenLED_off);
    // filament button disabled if control is from the CMU front panel
    _ui.filamentButton->setEnabled(_xmitStatus.psmPowerOn() &&
            ! _xmitStatus.frontPanelCtlEnabled());
    if (! _xmitterFilamentOn()) {
        // Turn off warmup LED if the filament is not on
        _ui.filamentWarmupIcon->setPixmap(_greenLED_off);
        _ui.filamentWarmupLabel->setText("Filament warmup");
    } else {
        // Amber during filament warmup, then green when warm
        _ui.filamentWarmupIcon->setPixmap(_xmitStatus.filamentDelayActive() ? _amberLED : _greenLED);
        _ui.filamentWarmupLabel->setText(_xmitStatus.filamentDelayActive() ?
                "Waiting for warmup" : "Filament is warm");
    }
    _ui.hvIcon->setPixmap(_xmitterHvOn() ? _greenLED : _greenLED_off);
    // Enable the HV button as soon as filament delay has expired (and control
    // is not via the CMU front panel)
    _ui.hvButton->setEnabled(! _xmitStatus.frontPanelCtlEnabled() &&
            ! _xmitStatus.filamentDelayActive());
    _ui.xmittingIcon->setPixmap(_xmitting() ? _greenLED : _greenLED_off);

    // Which control source is enabled?
    if (_xmitStatus.frontPanelCtlEnabled()) {
        _ui.controlSourceLabel->setText("Control via <b>Front Panel</b>");
    } else if (_xmitStatus.rs232CtlEnabled()) {
        _ui.controlSourceLabel->setText("Control via <b>RS-232</b>");
    } else if (_xmitStatus.rdsCtlEnabled()) {
        _ui.controlSourceLabel->setText("Control via <b>RDS</b>");
    } else {
        // Unknown control source. Show "Unknown" in dark red text.
        _ui.controlSourceLabel->setText("Control via <b><font color=#880000>Unknown</font></b>");
    }

    // Status summary: "OK" or "<n> Faults".
    int faultCount = 0;
    faultCount += _xmitStatus.modulatorFault() ? 1 : 0;
    faultCount += _xmitStatus.syncFault() ? 1 : 0;
    faultCount += _xmitStatus.xmitterTempFault() ? 1 : 0;
    faultCount += _xmitStatus.waveguideArcFault() ? 1 : 0;
    faultCount += _xmitStatus.collectorCurrentFault() ? 1 : 0;
    faultCount += _xmitStatus.bodyCurrentFault() ? 1 : 0;
    faultCount += _xmitStatus.filamentLorFault() ? 1 : 0;
    faultCount += _xmitStatus.focusElectrodeLorFault() ? 1 : 0;
    faultCount += _xmitStatus.cathodeLorFault() ? 1 : 0;
    faultCount += _xmitStatus.inverterOverloadFault() ? 1 : 0;
    faultCount += _xmitStatus.externalInterlockFault() ? 1 : 0;
    faultCount += _xmitStatus.eikInterlockFault() ? 1 : 0;

    if (faultCount > 0) {
        std::ostringstream ss;
        ss << faultCount << " Transmitter Fault(s)";
        _ui.xmitterStatusSummaryLabel->setText(ss.str().c_str());
        _ui.xmitterStatusSummaryIcon->setPixmap(_redLED);
    } else {
        _ui.xmitterStatusSummaryLabel->setText("Transmitter OK");
        _ui.xmitterStatusSummaryIcon->setPixmap(_greenLED);
    }

    // HMC mode
    _ui.hmcModeCombo->setCurrentIndex(_drxStatus.hmcMode());

    // C-MIGITS status light
    {
        // Get C-MIGITS status
        double statusTime = 0.0;
        uint16_t mode = 0;
        bool insAvailable = 0;
        bool gpsAvailable = 0;
        bool doingCoarseAlignment = 0;
        uint16_t nSats = 0;
        uint16_t positionFOM = 0;
        uint16_t velocityFOM = 0;
        uint16_t headingFOM = 0;
        uint16_t timeFOM = 0;
        float expectedHPosError = 0.0;
        float expectedVPosError = 0.0;
        float expectedVelError = 0.0;
        _drxStatus.cmigitsStatus(statusTime, mode, insAvailable, gpsAvailable,
                doingCoarseAlignment, nSats, 
                positionFOM, velocityFOM,  headingFOM, timeFOM,
                expectedHPosError, expectedVPosError, expectedVelError);
        QPixmap light;
        if (mode == 7 || mode == 8) {
            // Green light if mode is "Air Navigation" or "Land Navigation"
            light = _greenLED;
        } else if (insAvailable && gpsAvailable) {
            // Amber light if we have both INS and GPS
            light = _amberLED;
        } else {
            // Otherwise red light
            light = _redLED;
        }
        _ui.cmigitsStatusIcon->setPixmap(light);
    }

    // Update the transmitter status details dialog
    _xmitDetails.setEnabled(_xmitStatus.serialConnected());
    _xmitDetails.updateStatus(_xmitStatus);

    // Update the C-MIGITS status details dialog
    _cmigitsDetails.updateStatus(_drxStatus);
    
    // MotionControl status LED
    _motionControlDetails.updateStatus(_mcStatus);
    if (! _mcClientThread.serverIsResponding() ||
            _motionControlDetails.errorDetected()) {
        _ui.mcStatusIcon->setPixmap(_redLED);
    } else if (_motionControlDetails.warningDetected()) {
        _ui.mcStatusIcon->setPixmap(_amberLED);
    } else {
        _ui.mcStatusIcon->setPixmap(_greenLED);
    }

    if (_mcClientThread.serverIsResponding()) {
        _motionControlDetails.setEnabled(true);

        // Reflector mode
        std::ostringstream ss;
        switch (_mcStatus.antennaMode) {
        case MotionControl::POINTING:
            ss << "Fixed pointing at " << _mcStatus.fixedPointingAngle << " deg";
            break;
        case MotionControl::SCANNING:
            ss << "Scanning:\n" <<
                "    from " << _mcStatus.scanCcwLimit << " deg CCW to " <<
                _mcStatus.scanCwLimit << " deg CW\n" <<
                "    at " << _mcStatus.scanRate << " deg/s";
            break;
        default:
            ss << "Unknown antenna mode " << _mcStatus.antennaMode;
            break;
        }
        _ui.antennaModeLabel->setText(ss.str().c_str());

        // Attitude correction
        _ui.attitudeCorrectionFrame->setEnabled(true);
        _ui.attitudeCorrectionIcon->setPixmap(
                _mcStatus.attitudeCorrectionEnabled ?
                _greenLED : _greenLED_off);

        // Drive homing
        if (_mcStatus.rotDriveHomed && _mcStatus.tiltDriveHomed) {
            _ui.driveHomeButton->setText("Rehome the Drives");
            _ui.driveHomeButton->setEnabled(true);
        	_ui.antennaModeButton->setEnabled(true);
        } else {
            _ui.driveHomeButton->setText("Home the Drives");
            _ui.driveHomeButton->setEnabled(true);
            _ui.antennaModeButton->setEnabled(false);
        }
    } else {
        _mcStatus = MotionControl::Status();    // go to an empty status
        _motionControlDetails.setEnabled(false);
        _ui.antennaModeLabel->setText("<font color='DarkRed'>MotionControlDaemon not responding</font>");
        _ui.attitudeCorrectionFrame->setEnabled(false);
        _ui.driveHomeButton->setEnabled(false);
        _ui.antennaModeButton->setEnabled(false);
    }
    
    // Make sure transmitter HV is turned off if the pressure in the pressure 
    // vessel drops below 760 hPa.
    if (_drxStatus.pvForePressure() < 760) {
        // Disable the HV button as long as pressure remains too low
        _ui.hvButton->setEnabled(false);
        
        // If HV is on, turn it off now
        if (_xmitterHvOn()) {
            // Act as if the user clicked the HV button to turn off HV
            on_hvButton_clicked();
            // Warn the user that we have turned off HV
            QMessageBox box(QMessageBox::Warning, "Turning Off Transmitter HV",
                    "Turning off transmitter HV due to low pressure\n"
                    "in the pressure vessel",
                    QMessageBox::Ok, this);
            box.exec();
        }
    }
}

void
HcrGuiMainWindow::_logMessage(std::string message) {
    _ui.logArea->appendPlainText(
            QDateTime::currentDateTime().toUTC().toString("yyyy-MM-dd hh:mm:ss ") + 
            message.c_str());
}

void
HcrGuiMainWindow::_readAngles()
{
    float rotation = 0.0;
    float tilt = 0.0;
    while (_angleSocket.hasPendingDatagrams()) {
        QByteArray datagram;
        datagram.resize(_angleSocket.pendingDatagramSize());
        QHostAddress sender;
        quint16 senderPort;
        _angleSocket.readDatagram(datagram.data(), datagram.size(),
                                &sender, &senderPort);

        memcpy(reinterpret_cast<char*>(&rotation), datagram.data(), 4);
        memcpy(reinterpret_cast<char*>(&tilt), datagram.data() + 4, 4);
    }
    // Only update the GUI if the time since last update is greater than 50 ms.
    // The test is klugy for now, since older QDateTime implementations do not
    // have the msecsTo(QDateTime) method... Mostly the test below works, but
    // we'll wait up to a second for an update at a day boundary.
    QDateTime now = QDateTime::currentDateTime();
    if (_lastAngleUpdate.secsTo(now) > 0 ||
            _lastAngleUpdate.time().msecsTo(now.time()) > 50) {
        _ui.rotationValue->setText(QString::number(rotation, 'f', 1));
        _showRotAngle(rotation);
        _ui.tiltValue->setText(QString::number(tilt, 'f', 1));
        _showTiltAngle(tilt);

        _lastAngleUpdate = now;
    }
}

void HcrGuiMainWindow::_showRotAngle(float rotAngle)
{
	QPixmap *rotDisplay = new QPixmap(90, 90);
	QPainter painter(rotDisplay);
	painter.setRenderHint(QPainter::Antialiasing);
	// Background
	painter.setPen(Qt::NoPen);
	painter.setBrush(QColor(0, 100, 0));
	painter.drawRect(0, 0, 90, 90);
	// Scan range
	float ccwLimit = _mcStatus.scanCcwLimit;
	float cwLimit = _mcStatus.scanCwLimit;
	float scanRange = cwLimit - ccwLimit;
	if (scanRange < 0)
		scanRange += 360;
	if (_mcStatus.rotDriveResponding &&
		_mcStatus.antennaMode == MotionControl::SCANNING) {
	   	painter.setBrush(QColor(0, 200, 80));
	   	painter.drawPie(13, 13, 64, 64, (90-ccwLimit)*16, -scanRange*16);
	}
	// Circles
	QPen pen("lightgreen");
	painter.setPen(pen);
	painter.setBrush(Qt::NoBrush);
	painter.drawEllipse(13, 13, 64, 64);
	// Angle text
	painter.translate(46, 45);
	painter.setFont(QFont("arial", 5, QFont::Bold));
	for (int r = 0; r < 360; r += 30) {
		float theta = (r-90)*M_PI/180.0;
		float dx = 0, dy = 0;
		if (r == 0)   dx = -2;
		if (r == 180) dx = -5;
		if (r > 180)  dx = -13;
		if (r > 90 && r < 270) dy = 5*sin(theta);
		painter.drawText(QPointF(34*cos(theta)+dx, 34*sin(theta)+dy), QString::number(r));
	}
	// Radius lines
	for (int r = 0; r < 360; r += 10) {
		if (r % 30 == 0)
			painter.drawLine(0, 0, 32, 0);
		else
			painter.drawLine(30, 0, 32, 0);
		painter.rotate(10);
	}
	// Rot angle
	if (_mcStatus.rotDriveResponding) {
    	if (_mcStatus.antennaMode == MotionControl::SCANNING) {
    		pen.setColor("yellow");
    		pen.setWidth(1);
    		painter.setPen(pen);
    		painter.rotate(ccwLimit-90);
    		painter.drawLine(0, 0, 32, 0);
    		painter.rotate(scanRange);
    		painter.drawLine(0, 0, 32, 0);
    		painter.rotate(90-cwLimit);
    	}
		pen.setColor("white");
		pen.setWidth(2);
		painter.setPen(pen);
		painter.rotate(rotAngle-90);
		painter.drawLine(0, 0, 32, 0);
	}

	painter.end();
	_ui.rotAngleDisplay->setPixmap(*rotDisplay);
	delete(rotDisplay);
}

void HcrGuiMainWindow::_showTiltAngle(float tiltAngle)
{
	QPixmap *tiltDisplay = new QPixmap(90, 90);
	QPainter painter(tiltDisplay);
	painter.setRenderHint(QPainter::Antialiasing);
	// Background
	painter.setPen(Qt::NoPen);
	painter.setBrush(QColor(0, 100, 0));
	painter.drawRect(0, 0, 90, 90);
	// Pie
	QPen pen("lightgreen");
	painter.setPen(pen);
	painter.setBrush(Qt::NoBrush);
	painter.drawPie(-19, 13, 128, 128, (90+36)*16, -72*16);
	// Angle text
	painter.translate(45, 77);
	painter.setFont(QFont("arial", 6, QFont::Bold));
	for (int r = -36; r <= 36; r += 6) {
		if (r/6 % 2 != 0) continue;
		float theta = (r-90)*M_PI/180.0;
		float dx = 0;
		if (r < 0) dx = -5;
		if (r == 0) dx = -2;
		painter.drawText(QPointF(68*cos(theta)+dx, 68*sin(theta)), QString::number(r/6));
	}
	painter.drawText(QPoint(-39, 8), "Angle Magnified by 6");
	// Radius lines
	painter.rotate(-54);
	int rc = 0;
	for (int r = -36; r <= 36; r += 6) {
		if (r/6 % 2 == 0)
			painter.drawLine(0, 0, 64, 0);
		else
			painter.drawLine(62, 0, 64, 0);
		painter.rotate(-6);
		rc++;
	}
	painter.rotate(54+6*rc);
	// Tilt angle
	if (_mcStatus.tiltDriveResponding) {
		pen.setColor("white");
		pen.setWidth(2);
		painter.setPen(pen);
		painter.rotate(tiltAngle*6-90);
		painter.drawLine(0, 0, 64, 0);
	}

	painter.end();
	_ui.tiltAngleDisplay->setPixmap(*tiltDisplay);
	delete(tiltDisplay);
}
