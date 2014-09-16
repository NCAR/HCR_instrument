/*
 * HcrGuiMainWindow.cpp
 *
 *  Created on: Jan 14, 2011
 *      Author: burghart
 */
#include "HcrGuiMainWindow.h"

#include <cerrno>
#include <cmath>
#include <cstring>
#include <fstream>
#include <sstream>
#include <unistd.h>

#include <QDateTime>
#include <QMessageBox>

#include <logx/Logging.h>

// Invalid angle used to erase display of reflector position
static const float INVALID_ANGLE = -999.9;

LOGGING("HcrGuiMainWindow")


HcrGuiMainWindow::HcrGuiMainWindow(std::string archiverHost,
    int xmitterPort, int fireflydPort, std::string rdsHost, int drxPort,
    int pmcPort, int cmigitsPort, int motionControlPort) :
    QMainWindow(),
    _ui(),
    _updateTimer(this),
    _logWindow(this),
    _cmigitsDetails(this),
    _fireflydDetails(this),
    _hcrdrxDetails(this),
    _motionControlDetails(this),
    _pmc730Details(this),
    _xmitDetails(this),
    _antennaModeDialog(this),
    _cmigitsStatusThread(rdsHost, cmigitsPort),
    _dataMapperStatusThread(),
    _fireflydStatusThread(archiverHost, fireflydPort),
    _hcrdrxStatusThread(rdsHost, drxPort),
    _mcClientThread(rdsHost, motionControlPort),
    _pmcStatusThread(rdsHost, pmcPort),
    _xmitdStatusThread(archiverHost, xmitterPort),
    _redLED(":/redLED.png"),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png"),
    _xmitStatus(),
    _fireflydStatus(),
    _mcStatus(),
    _pmcStatus(true),
    _cmigitsStatus(),
    _drxStatus(),
    _dmapWriteRate(0.0),
    _lastAngleUpdate(QDateTime::currentDateTime()),
    _anglesValidTimer(this),
    _hvDisabledForPressure(true),
    _goodPresStartTime(0),
    _tsWriteEnableFileName("/tmp/TsSmartSave.flag.wband") {
    // Set up the UI
    _ui.setupUi(this);

    _logMessage("hcrgui started");
    
    std::ostringstream ss;
    ss << "No response yet from hcr_xmitd at " << archiverHost << ":" <<
            xmitterPort;
    _logMessage(ss.str());

    ss.str("");
    ss << "No response yet from fireflyd at " << archiverHost << ":" <<
            fireflydPort;
    _logMessage(ss.str());

    ss.str("");
    ss << "No response yet from HcrPmc730Daemon at " << rdsHost << ":" <<
            pmcPort;
    _logMessage(ss.str());

    ss.str("");
    ss << "No response yet from CmigitsDaemon at " << rdsHost << ":" <<
            cmigitsPort;
    _logMessage(ss.str());

    ss.str("");
    ss << "No response yet from hcrdrx at " << rdsHost << ":" << drxPort;
    _logMessage(ss.str());
    
    _logMessage("No response yet from DataMapper");

    // Disable the HMC mode box until we get status from HcrPmc730Daemon.
    _ui.hmcModeCombo->setEnabled(false);
    
    // No status from any daemons yet
    _ui.cmigitsStatusIcon->setPixmap(_redLED);
    _ui.fireflydStatusIcon->setPixmap(_redLED);
    _ui.hcrdrxStatusIcon->setPixmap(_redLED);
    _ui.mcStatusIcon->setPixmap(_redLED);
    _ui.pmc730StatusIcon->setPixmap(_redLED);
    _ui.xmitterStatusIcon->setPixmap(_redLED);
    
    // Connect and start the CmigitsStatusThread
    connect(& _cmigitsStatusThread, SIGNAL(serverResponsive(bool, QString)),
            this, SLOT(_cmigitsResponsivenessChange(bool, QString)));
    connect(& _cmigitsStatusThread, SIGNAL(newStatus(CmigitsStatus)),
            this, SLOT(_setCmigitsStatus(CmigitsStatus)));
    _cmigitsStatusThread.start();

    // Connect and start the MotionControlStatusThread
    connect(& _mcClientThread, SIGNAL(serverResponsive(bool)),
            this, SLOT(_mcResponsivenessChange(bool)));
    connect(& _mcClientThread, SIGNAL(newStatus(MotionControl::Status)),
            this, SLOT(_setMotionControlStatus(MotionControl::Status)));
    _mcClientThread.start();

    // Connect signals from our HcrdrxStatusThread object and start the thread.
    connect(& _hcrdrxStatusThread, SIGNAL(serverResponsive(bool)),
            this, SLOT(_drxResponsivenessChange(bool)));
    connect(& _hcrdrxStatusThread, SIGNAL(newStatus(DrxStatus)),
            this, SLOT(_setDrxStatus(DrxStatus)));
    _hcrdrxStatusThread.start();

    // Connect signals from our Pmc730StatusThread object and start the thread.
    connect(& _pmcStatusThread, SIGNAL(serverResponsive(bool, QString)),
            this, SLOT(_pmcResponsivenessChange(bool, QString)));
    connect(& _pmcStatusThread, SIGNAL(newStatus(HcrPmc730Status)),
            this, SLOT(_setPmcStatus(HcrPmc730Status)));
    _pmcStatusThread.start();

    // Connect signals from our XmitdStatusThread object and start the thread.
    connect(& _xmitdStatusThread, SIGNAL(serverResponsive(bool)),
            this, SLOT(_xmitdResponsivenessChange(bool)));
    connect(& _xmitdStatusThread, SIGNAL(newStatus(XmitStatus)),
            this, SLOT(_setXmitStatus(XmitStatus)));
    _xmitdStatusThread.start();

    // Connect signals from our DataMapperStatusThread object and start the thread.
    connect(& _dataMapperStatusThread, SIGNAL(serverResponsive(bool)),
            this, SLOT(_dataMapperResponsivenessChange(bool)));
    connect(& _dataMapperStatusThread, SIGNAL(newStatus(DMAP_info_t)),
            this, SLOT(_setDataMapperStatus(DMAP_info_t)));
    _dataMapperStatusThread.start();

    // Connect signals from our FireflydStatusThread object and start the thread.
    connect(& _fireflydStatusThread, SIGNAL(serverResponsive(bool)),
            this, SLOT(_fireflydResponsivenessChange(bool)));
    connect(& _fireflydStatusThread, SIGNAL(newStatus(FireFlyStatus)),
            this, SLOT(_setFireFlyStatus(FireFlyStatus)));
    _fireflydStatusThread.start();

    // QUdpSocket listening for broadcast of angles
    _angleSocket.bind(45454, QUdpSocket::ShareAddress);
    connect(&_angleSocket, SIGNAL(readyRead()), this, SLOT(_readAngles()));

    // Time out angle display if new angles stop arriving
    _anglesValidTimer.setInterval(500);    // 1/2 second validity
    _anglesValidTimer.setSingleShot(true);
    connect(& _anglesValidTimer, SIGNAL(timeout()), this, SLOT(_timeoutAngleDisplay()));

    // Update GUI every second
    connect(& _updateTimer, SIGNAL(timeout()), this, SLOT(_update()));
    _updateTimer.start(1000);
    
    // Populate the HMC mode combo box
    for (int i = 0; i < HcrPmc730::HMC_NMODES; i++) {
        _ui.hmcModeCombo->insertItem(i, HcrPmc730::HmcModeNames[i].c_str(), i); 
    }

    // Start with angle display cleared
    _clearAngleDisplay();
}

HcrGuiMainWindow::~HcrGuiMainWindow() {
}

void
HcrGuiMainWindow::_cmigitsResponsivenessChange(bool responding, QString msg) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "cmigitsDaemon @ " <<
            _cmigitsStatusThread.rpcClient().getDaemonHost() << ":" <<
            _cmigitsStatusThread.rpcClient().getDaemonPort() <<
            (responding ? " is " : " is not ") <<
            "responding: " << msg.toStdString();
    _logMessage(ss.str().c_str());

    if (! responding) {
        // Create a default (bad) CmigitsStatus, and set it as the last status
        // received.
        _setCmigitsStatus(CmigitsStatus());
    }
}

void
HcrGuiMainWindow::_setCmigitsStatus(const CmigitsStatus & status) {
    _cmigitsStatus = status;
    // Update the C-MIGITS status details dialog.
    _cmigitsDetails.updateStatus(_cmigitsStatusThread.serverIsResponding(),
            _cmigitsStatus);
    // Update the main GUI
    _update();
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

    if (! responding) {
        // Create a default (bad) MotionControl::Status, and set it as the
        // last status received.
        _setMotionControlStatus(MotionControl::Status());
    }
}

void
HcrGuiMainWindow::_setMotionControlStatus(const MotionControl::Status & status) {
    _mcStatus = status;
    // Update the details dialog
    _motionControlDetails.updateStatus(_mcClientThread.serverIsResponding(),
            _mcStatus);
    // Update the main GUI
    _update();
}

void
HcrGuiMainWindow::_pmcResponsivenessChange(bool responding, QString msg) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "HcrPmc730Daemon @ " <<
            _pmcStatusThread.rpcClient().getDaemonHost() << ":" <<
            _pmcStatusThread.rpcClient().getDaemonPort() <<
            (responding ? " is " : " is not ") <<
            "responding (" << msg.toStdString() << ")";
    _logMessage(ss.str().c_str());

    _ui.hmcModeCombo->setEnabled(responding);
    
    if (! responding) {
        // Create a default (bad) Pmc730Status, and set it as the last status
        // received.
        _setPmcStatus(HcrPmc730Status(true));
    }
}

void
HcrGuiMainWindow::_setPmcStatus(const HcrPmc730Status & status) {
    _pmcStatus = status;
    // Update the details dialog
    _pmc730Details.updateStatus(_pmcStatusThread.serverIsResponding(),
            _pmcStatus);
    // Update the main GUI
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

    if (! responding) {
        // Create a default (bad) XmitStatus, and set it as the last status
        // received.
        _setXmitStatus(XmitStatus());
    }
}

void
HcrGuiMainWindow::_setXmitStatus(XmitStatus status) {
    _xmitStatus = status;
    // Update the transmitter status details dialog
    _xmitDetails.updateStatus(_xmitdStatusThread.serverIsResponding(),
            _xmitStatus);
    // Update the main GUI
    _update();
}

void
HcrGuiMainWindow::_fireflydResponsivenessChange(bool responding) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "fireflyd @ " <<
            _fireflydStatusThread.rpcClient().getFireflydHost() << ":" <<
            _fireflydStatusThread.rpcClient().getFireflydPort() <<
            (responding ? " is " : " is not ") <<
            "responding";
    _logMessage(ss.str().c_str());

    if (! responding) {
        // Create a default (bad) FireFlyStatus, and set it as the last status
        // received.
        _setFireFlyStatus(FireFlyStatus());
    }
}

void
HcrGuiMainWindow::_setFireFlyStatus(FireFlyStatus status) {
    _fireflydStatus = status;
    // Update the fireflyd status details dialog
    _fireflydDetails.updateStatus(_fireflydStatusThread.serverIsResponding(),
            _fireflydStatus);
    // Update the main GUI
    _update();
}

void
HcrGuiMainWindow::_drxResponsivenessChange(bool responding) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "hcrdrx @ " <<
            _hcrdrxStatusThread.rpcClient().getHcrdrxHost() << ":" <<
            _hcrdrxStatusThread.rpcClient().getHcrdrxPort() <<
            (responding ? " is " : " is not ") <<
            "responding";
    _logMessage(ss.str().c_str());

    if (! responding) {
        // Create a default (bad) DrxStatus, and set it as the last status
        // received.
        _setDrxStatus(DrxStatus());
    }
}

void
HcrGuiMainWindow::_setDrxStatus(DrxStatus status) {
    _drxStatus = status;
    // Update the details dialog
    _hcrdrxDetails.updateStatus(_hcrdrxStatusThread.serverIsResponding(),
            _drxStatus);
    // Update the main GUI
    _update();
}

void
HcrGuiMainWindow::_dataMapperResponsivenessChange(bool responding) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "DataMapper " << (responding ? " is " : " is not ") <<
            "responding";
    _logMessage(ss.str().c_str());

    if (! responding) {
        // Set data rate to 0.0 MiB/s
        _setDataMapperStatus(0.0);
    }
}

void
HcrGuiMainWindow::_setDataMapperStatus(double tsWriteRate) {
    _dmapWriteRate = tsWriteRate;
//    // Update the details dialog
//    _dmapDetails.updateStatus(_dmapStatus);
    // Update the main GUI
    _update();
}

bool
HcrGuiMainWindow::_xmitterFilamentIsOn() const {
    bool filamentOn;
    // If RDS is in control, we have to use the state of the RDS control lines
    // from the PMC-730. The status reported directly by the transmitter will 
    // *not* reflect the correct state when RDS is in control.
    //
    // If the control source is unknown (this is true when hcr_xmitd is not
    // responding), we assume RDS control since that's effectively always true
    // for HCR.
    switch (_xmitStatus.controlSource()) {
    case XmitStatus::RDSControl:
    case XmitStatus::UnknownControl:
        filamentOn = _pmcStatus.rdsXmitterFilamentOn();
        break;
    default:
        // The "filament on" bit from transmitter status is only meaningful
        // if the transmitter is *not* under RDS control.
        filamentOn = _xmitStatus.filamentOn();
        break;
    }
    return(filamentOn);
}

bool
HcrGuiMainWindow::_xmitterHvIsOn() const {
    bool hvOn;
    // If RDS is in control, we have to use the state of the RDS control lines
    // from the PMC-730. The status reported directly by the transmitter will 
    // *not* reflect the correct state when RDS is in control.
    //
    // If the control source is unknown (this is true when hcr_xmitd is not
    // responding), we assume RDS control since that's effectively always true
    // for HCR.
    switch (_xmitStatus.controlSource()) {
    case XmitStatus::RDSControl:
    case XmitStatus::UnknownControl:
        hvOn = _pmcStatus.rdsXmitterHvOn();
        break;
    default:
        // The "HV on" bit from transmitter status is only meaningful
        // if the transmitter is *not* under RDS control.
        hvOn = _xmitStatus.highVoltageOn();
        break;
    }
    return(hvOn);
}

bool
HcrGuiMainWindow::_xmitting() const {
    bool xmitting;
    // If RDS is in control, we have to use the state of the RDS control lines
    // from the PMC-730. The status reported directly by the transmitter will 
    // *not* reflect the correct state when RDS is in control.
    //
    // If the control source is unknown (this is true when hcr_xmitd is not
    // responding), we assume RDS control since that's effectively always true
    // for HCR.
    switch (_xmitStatus.controlSource()) {
    case XmitStatus::RDSControl:
    case XmitStatus::UnknownControl:
    {
        // We're transmitting if the filament is on, HV is on, modulation
        // pulses are being allowed through, and we have no HV disabling fault.
        bool hvDisableFault = _xmitStatus.bodyCurrentFault() ||
                _xmitStatus.cathodeLorFault() ||
                _xmitStatus.collectorCurrentFault() ||
                _xmitStatus.eikInterlockFault() ||
                _xmitStatus.externalInterlockFault() ||
                _xmitStatus.filamentLorFault() ||
                _xmitStatus.modulatorFault() ||
                _xmitStatus.focusElectrodeLorFault() ||
                _xmitStatus.inverterOverloadFault() ||
                _xmitStatus.summaryFault() ||
                _xmitStatus.waveguideArcFault() ||
                _xmitStatus.xmitterTempFault();
        xmitting = _xmitterFilamentIsOn() && _xmitterHvIsOn() &&
                ! _pmcStatus.modPulseDisabled() && ! hvDisableFault;
        break;
    }
    default:
        // If transmitter is not under RDS control, we can just use the
        // "RF on" status bit to tell us we're transmitting.
        xmitting = _xmitStatus.rfOn();
        break;
    }
    return(xmitting);
}

/// Pop up the antenna mode editing dialog
void
HcrGuiMainWindow::on_antennaModeButton_clicked() {
    // Don't pop up the dialog if we're transmitting. At this point, moving the
    // reflector between pointing locations may steer the beam through the
    // aircraft fuselage. If we do that while transmitting, the return signal
    // could damage the radar.
    if (_xmitterHvIsOn()) {
        QMessageBox box(QMessageBox::Warning,
                "No Mode Change While Transmitting",
                "Reflector mode cannot be changed while transmitting.",
                QMessageBox::Ok, this);
        box.setInformativeText(
                "Radar transmitter HV must be turned off before changing mode!");
        box.exec();
        return;
    }
    
    // Pop up the antenna mode dialog, and apply the new mode if the dialog
    // is accepted.
    if (_antennaModeDialog.exec() == QDialog::Accepted) {
        if (_antennaModeDialog.getMode() == AntennaModeDialog::POINTING) {
            float angle;
            _antennaModeDialog.getPointingAngle(angle);
            // Point the antenna to the angle
            _mcClientThread.rpcClient().point(angle);
        }
        else if (_antennaModeDialog.getMode() == AntennaModeDialog::SCANNING) {
            float ccwLimit, cwLimit, scanRate, beamTilt;
            _antennaModeDialog.getScanningParam(ccwLimit, cwLimit, scanRate,
                    beamTilt);
            // If beam tilt angle is not zero, confirm that it's intentional.
            if (beamTilt != 0.0) {
                QMessageBox confirmBox(QMessageBox::Question,
                        "Confirm Non-Zero Tilt",
                        "A non-zero tilt angle was given for the scan.\n"
                        "Are you sure you want to continue?",
                        QMessageBox::Ok | QMessageBox::Cancel, this);
                confirmBox.setInformativeText(
                        "Non-zero tilt is only useful for special scanning cases");
                if (confirmBox.exec() == QMessageBox::Cancel) {
                    return;
                }
            }
            // Start scanning
            _mcClientThread.rpcClient().scan(ccwLimit, cwLimit, scanRate, beamTilt);
        }
    }
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
HcrGuiMainWindow::on_cmigitsDetailsButton_clicked() {
    _cmigitsDetails.show();
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

    // Save the current state of attitude correction, then disable correction
    // until we exit. At exit, the current correction state will be restored.
    // We disable correction because we need the motors to remain at their
    // zero-count positions after homing long enough for us to also zero the
    // motor counts on the Pentek.
    bool savedState = _mcStatus.attitudeCorrectionEnabled;
    _mcClientThread.rpcClient().setCorrectionEnabled(false);

    // Start the drive homing program.
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
    
    // Update motion control status and verify drives actually got homed. Pop up
    // a warning box if homing failed.
    _mcStatus = _mcClientThread.rpcClient().status();
    if (! _mcStatus.rotDriveHomed || ! _mcStatus.tiltDriveHomed) {
        WLOG << "Homing failed";
        // Let the user know that homing failed
        QMessageBox failureBox(QMessageBox::Warning, "Homing Failed",
                "Drive homing failed!\nYou will need to try again.",
                QMessageBox::Ok, this);
        failureBox.exec();
        goto done;
    }

    // With the motors both at their zero positions, tell the Pentek to zero
    // its position counts for both motors.
    ILOG << "Elmo homing complete. Zeroing Pentek's motor counts.";
    _hcrdrxStatusThread.rpcClient().zeroPentekMotorCounts();

done:
    // Sleep momentarily, then restore the previous state for attitude
    // correction
    usleep(100000);
    _mcClientThread.rpcClient().setCorrectionEnabled(savedState);
}

/// Toggle the current on/off state of the transmitter klystron filament
void
HcrGuiMainWindow::on_filamentButton_clicked() {
    // Send the command to toggle HV state to both hcr_xmitd and 
    // HcrPmc730Daemon. If the transmitter is under RDS control (generally 
    // true), the HV line is handled by HcrPmc730Daemon. If RS-232 control, the 
    // HV line is handled by hcr_xmitd. We need to cover both cases.
    if (_xmitterFilamentIsOn()) {
        _xmitdStatusThread.rpcClient().xmitFilamentOff();
        try {
            _pmcStatusThread.rpcClient().xmitFilamentOff();
        } catch (std::exception & e) {
            WLOG << "Could not tell HcrPmc730Daemon to turn off filament";
        }
    } else {
        _xmitdStatusThread.rpcClient().xmitFilamentOn();
        try {
            _pmcStatusThread.rpcClient().xmitFilamentOn();
        } catch (std::exception & e) {
            WLOG << "Could not tell HcrPmc730Daemon to turn on filament";
        }
    }
}

void
HcrGuiMainWindow::on_hcrdrxDetailsButton_clicked() {
    _hcrdrxDetails.show();
}

/// Set HMC mode
void
HcrGuiMainWindow::on_hmcModeCombo_activated(int index) {
    try {
        _pmcStatusThread.rpcClient().setHmcMode(index);
    } catch (std::exception & e) {
        WLOG << "Could not tell HcrPmc730Daemon to change to HMC mode " << index;
    }
}

/// Toggle the current on/off state of the transmitter high voltage
void
HcrGuiMainWindow::on_hvButton_clicked() {
    // Send the command to toggle HV state to both hcr_xmitd and 
    // HcrPmc730Daemon. If the transmitter is under RDS control (generally 
    // true), the HV line is handled by HcrPmc730Daemon. If RS-232 control, the 
    // HV line is handled by hcr_xmitd. We need to cover both cases.
    if (_xmitterHvIsOn()) {
        _xmitdStatusThread.rpcClient().xmitHvOff();
        try {
        	_pmcStatusThread.rpcClient().xmitHvOff();
        } catch (std::exception & e) {
            WLOG << "Could not tell HcrPmc730Daemon to turn off HV";
        }
    } else {
        _xmitdStatusThread.rpcClient().xmitHvOn();
        try {
        	_pmcStatusThread.rpcClient().xmitHvOn();
        } catch (std::exception & e) {
            WLOG << "Could not tell HcrPmc730Daemon to turn on HV";
        }
    }
}

void
HcrGuiMainWindow::on_mcDetailsButton_clicked() {
    _motionControlDetails.show();
}

void
HcrGuiMainWindow::on_pmc730DetailsButton_clicked() {
    _pmc730Details.show();
}

void
HcrGuiMainWindow::on_recordingButton_clicked() {
    _toggleTsWriteEnabled();
    _update();
}

void
HcrGuiMainWindow::on_showLogButton_clicked() {
    _logWindow.show();
}

void
HcrGuiMainWindow::on_xmitterDetailsButton_clicked() {
    _xmitDetails.show();
}

void
HcrGuiMainWindow::on_fireflydDetailsButton_clicked() {
    _fireflydDetails.show();
}

void
HcrGuiMainWindow::_update() {
    // convenience variable
    QPixmap light;

    // Update the current time string
    char timestring[32];
    time_t now = time(0);
    strftime(timestring, sizeof(timestring) - 1, "%F %T", gmtime(&now));
    _ui.clockLabel->setText(timestring);
    
    // Update transmitter control
    _ui.powerValidIcon->setPixmap(_xmitStatus.psmPowerOn() ? _greenLED : _greenLED_off);
    _ui.filamentIcon->setPixmap(_xmitterFilamentIsOn() ? _greenLED : _greenLED_off);
    // filament button disabled if control is from the CMU front panel
    _ui.filamentButton->setEnabled(_pmcStatusThread.serverIsResponding() &&
            _xmitStatus.psmPowerOn() && ! _xmitStatus.frontPanelCtlEnabled());
    if (! _xmitterFilamentIsOn()) {
        // Turn off warmup LED if the filament is not on
        _ui.filamentWarmupIcon->setPixmap(_greenLED_off);
        _ui.filamentWarmupLabel->setText("Filament warmup");
    } else {
        // Amber during filament warmup, then green when warm
        _ui.filamentWarmupIcon->setPixmap(_xmitStatus.filamentDelayActive() ? _amberLED : _greenLED);
        _ui.filamentWarmupLabel->setText(_xmitStatus.filamentDelayActive() ?
                "Waiting for warmup" : "Filament is warm");
    }
    _ui.hvIcon->setPixmap(_xmitterHvIsOn() ? _greenLED : _greenLED_off);
    // Enable the HV button as soon as filament delay has expired (and control
    // is not via the CMU front panel)
    _ui.hvButton->setEnabled(_pmcStatusThread.serverIsResponding() &&
            ! _xmitStatus.frontPanelCtlEnabled() &&
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

    // Set the overall transmitter status LED
    if (! _xmitStatus.serialConnected() || (faultCount > 0)) {
        _ui.xmitterStatusIcon->setPixmap(_redLED);
    } else {
        _ui.xmitterStatusIcon->setPixmap(_greenLED);
    }

    // HMC mode
    _ui.hmcModeCombo->setCurrentIndex(_pmcStatus.hmcMode());

    // C-MIGITS status light
    light = _redLED;
    uint16_t mode = _cmigitsStatus.currentMode();
    if (mode == 7 || mode == 8) {
        // Green light if mode is "Air Navigation" or "Land Navigation"
        light = _greenLED;
    } else if (_cmigitsStatus.insAvailable() &&
            _cmigitsStatus.gpsAvailable()) {
        // Amber light if we have both INS and GPS
        light = _amberLED;
    }
    _ui.cmigitsStatusIcon->setPixmap(light);

    // MotionControl status LED
    if (! _mcClientThread.serverIsResponding() ||
            _motionControlDetails.errorDetected()) {
        _ui.mcStatusIcon->setPixmap(_redLED);
    } else if (_motionControlDetails.warningDetected()) {
        _ui.mcStatusIcon->setPixmap(_amberLED);
    } else {
        _ui.mcStatusIcon->setPixmap(_greenLED);
    }

    if (_mcClientThread.serverIsResponding()) {
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
        _ui.attitudeCorrectionWidget->setEnabled(true);
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
        _ui.antennaModeLabel->setText("<font color='DarkRed'>MotionControlDaemon not responding</font>");
        _ui.attitudeCorrectionWidget->setEnabled(false);
        _ui.driveHomeButton->setEnabled(false);
        _ui.antennaModeButton->setEnabled(false);
    }
    
    // hcrdrx status LED
    _ui.hcrdrxStatusIcon->setPixmap(_hcrdrxStatusThread.serverIsResponding() ?
            _greenLED : _redLED);
    
    // Time-series data recording enabled LED
    _ui.recordingEnabledIcon->setPixmap(_tsWriteEnabled() ? 
            _greenLED : _greenLED_off);

    // HcrPmc730Daemon status LED
    light = _greenLED;
    if (! _pmcStatusThread.serverIsResponding() || _pmc730Details.errState()) {
        light = _redLED;
    } else if (_pmc730Details.warnState()) {
        light = _amberLED;
    }
    _ui.pmc730StatusIcon->setPixmap(light);
    
    // fireflyd status LED
    if (! _fireflydStatusThread.serverIsResponding()) {
        light = _redLED;
    } else {
        // If we have a good status, use its overallStatus() value
        switch (_fireflydStatus.overallStatus()) {
        case FireFlyStatus::OK:
            light = _greenLED;
            break;
        case FireFlyStatus::WARNING:
            light = _amberLED;
            break;
        case FireFlyStatus::ERROR:
            light = _redLED;
            break;
        default:
            ELOG << "Unknown FireFlyStatus severity " <<
                _fireflydStatus.overallStatus() << " treated as an error";
            light = _redLED;
            break;
        }
    }
    _ui.fireflydStatusIcon->setPixmap(light);

    // Make sure transmitter HV is turned off if the pressure in the pressure 
    // vessel drops below 760 hPa.
    if (_pmcStatus.pvForePressure() < 760) {
        // Disable the HV button as long as pressure remains too low
        _ui.hvButton->setEnabled(false);
        
        // If HV is on, turn it off now
        if (_xmitterHvIsOn()) {
            // Act as if the user clicked the HV button to turn off HV
            on_hvButton_clicked();
        }

        // Remember that we've disabled HV
        bool stateChanged = ! _hvDisabledForPressure;
        _hvDisabledForPressure = true;

        // Mark as having no continuous good pressures
        _goodPresStartTime = 0;

        // Popup a message if we just changed the state of _hvDisabledForPressure
        if (stateChanged) {
            // Warn the user that we have disabled HV
            QMessageBox box(QMessageBox::Warning, "Disabling Transmitter HV",
                    "Disabling transmitter HV due to hcrdrx shutdown\n"
                    "or low pressure in the pressure vessel",
                    QMessageBox::Ok, this);
            box.exec();
        }
    } else {
        // If the last pressure was bad, mark now as the start of good
        // pressures
        time_t now = time(0);
        if (! _goodPresStartTime) {
            _goodPresStartTime = now;
        }
        // Allow HV again if we've had continuous good pressure values
        // for more than 60 seconds
        if (_hvDisabledForPressure &&
                _goodPresStartTime && ((now - _goodPresStartTime) > 60)) {
            _hvDisabledForPressure = false;
            QMessageBox box(QMessageBox::Information, "HV Allowed",
                    "Transmitter HV is now allowed, with 60 seconds\n"
                    "of good pressures",
                    QMessageBox::Ok, this);
            box.exec();
        }
    }
    
    // DataMapper status LED
    _ui.dmStatusIcon->setPixmap(_dataMapperStatusThread.serverIsResponding() ?
            _greenLED : _redLED);
}

void
HcrGuiMainWindow::_logMessage(std::string message) {
    _logWindow.appendPlainText(
            QDateTime::currentDateTime().toUTC().toString("yyyy-MM-dd hh:mm:ss ") + 
            message.c_str());
    ILOG << message;
}

void
HcrGuiMainWindow::_readAngles()
{
    // Note that these two *must* be 32-bit floats, since the data we memcpy
    // into these variables from the UDP stream is 32-bit floats.
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

        // Start/restart the timer which will clear the angle display if
        // angles stop arriving.
        _anglesValidTimer.start();
    }
    // Only update the GUI if the time since last update is greater than 50 ms.
    // The test is klugy for now, since older QDateTime implementations do not
    // have the msecsTo(QDateTime) method... Mostly the test below works, but
    // we'll wait up to a second for an update at a day boundary.
    QDateTime now = QDateTime::currentDateTime();
    if (_lastAngleUpdate.secsTo(now) > 0 ||
            _lastAngleUpdate.time().msecsTo(now.time()) > 50) {
        _ui.rotationValue->setText(QString::number(rotation, 'f', 2));
        _showRotAngle(rotation);
        _ui.tiltValue->setText(QString::number(tilt, 'f', 2));
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
	double ccwLimit = _mcStatus.scanCcwLimit;
	double cwLimit = _mcStatus.scanCwLimit;
	double scanRange = cwLimit - ccwLimit;
	if (scanRange < 0)
		scanRange += 360;
	if (_mcStatus.antennaMode == MotionControl::SCANNING) {
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
		double theta = (r-90)*M_PI/180.0;
		double dx = 0, dy = 0;
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
	// If we're scanning, indicate scanning limits
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

    // Draw the current position if the angle is valid
    if (rotAngle != INVALID_ANGLE) {
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
		double theta = (r-90)*M_PI/180.0;
		double dx = 0;
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

	// Display current tilt angle, if the angle is valid
	if (tiltAngle != INVALID_ANGLE) {
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

void
HcrGuiMainWindow::_timeoutAngleDisplay() {
    _logMessage("Angles from hcrdrx have stopped arriving");
    _clearAngleDisplay();
}

void
HcrGuiMainWindow::_clearAngleDisplay() {
    _ui.rotationValue->setText("---");
    _showRotAngle(INVALID_ANGLE);
    _ui.tiltValue->setText("---");
    _showTiltAngle(INVALID_ANGLE);
}

bool
HcrGuiMainWindow::_tsWriteEnabled() {
    // If the file named by _tsWriteEnableFileName exists, writing is enabled.
    struct stat buf;
    if (stat(_tsWriteEnableFileName.c_str(), &buf)) {
        // Log a message if the error is something other than "No such file or 
        // directory".
        if (errno != ENOENT) {
            ELOG << "Error testing for existence of '" << 
                    _tsWriteEnableFileName << "': " << strerror(errno);
        }
        // We didn't find the file, so consider writing disabled.
        return(false);
    }
    
    bool exists = S_ISREG(buf.st_mode);
    return(exists);
}

void
HcrGuiMainWindow::_setTsWriteEnabled(bool state) {
    // If desired state is already in effect, just return
    if (state == _tsWriteEnabled()) {
        return;
    }
    // If we're enabling writing, create the write enable file, otherwise
    // delete it.
    if (state) {
        std::ofstream ofs(_tsWriteEnableFileName.c_str(), std::ios_base::out);
        if (ofs.fail()) {
            // Could not create the write enable file...
            ELOG << "Failed to create write enable file '" << 
                    _tsWriteEnableFileName << "': " << strerror(errno);
            ELOG << "Time-series writing was not enabled!";
            return;
        }
        // The file just needs to exist, but we write a line to the file to 
        // describe its purpose.
        ofs << "When file " << _tsWriteEnableFileName << " exists, " <<
                "TsSmartSave.wband will write time-series data to disk.";
        ofs.close();
    } else {
        if (unlink(_tsWriteEnableFileName.c_str()) != 0) {
            ELOG << "Failed to remove write enable file '" <<
                    _tsWriteEnableFileName << "': " << strerror(errno);
            ELOG << "Time-series writing was not disabled!";
            return;
        }
    }
}

void
HcrGuiMainWindow::_toggleTsWriteEnabled() {
    _setTsWriteEnabled(! _tsWriteEnabled());
}
