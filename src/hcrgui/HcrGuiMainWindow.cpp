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

static inline double MetersToFeet(double m) {
    return(3.28084 * m);
}


HcrGuiMainWindow::HcrGuiMainWindow(std::string archiverHost,
    int xmitterPort, int fireflydPort, std::string rdsHost, int drxPort,
    int pmcPort, int cmigitsPort, int motionControlPort, int hcrMonitorPort) :
    QMainWindow(),
    _ui(),
    _updateTimer(this),
    _logWindow(this),
    _cmigitsDetails(this),
    _fireflydDetails(this),
    _hcrdrxDetails(this),
    _hcrMonitorDetails(this, rdsHost, hcrMonitorPort),
    _motionControlDetails(this),
    _pmc730Details(this),
    _xmitDetails(this),
    _antennaModeDialog(this),
    _cmigitsStatusThread(rdsHost, cmigitsPort),
    _dataMapperStatusThread(),
    _fireflydStatusThread(archiverHost, fireflydPort),
    _hcrdrxStatusThread(rdsHost, drxPort),
    _hcrMonitorStatusThread(rdsHost, hcrMonitorPort),
    _mcStatusThread(rdsHost, motionControlPort),
    _pmcStatusThread(rdsHost, pmcPort),
    _xmitdStatusThread(archiverHost, xmitterPort),
    _redLED(":/redLED.png"),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png"),
    _xmitStatus(),
    _rdsXmitControl(true),
    _fireflydStatus(),
    _mcStatus(),
    _pmcStatus(true),
    _cmigitsStatus(),
    _drxStatus(),
    _dmapStatus(),
    _dmapWriteRate(0.0),
    _dmapWriteRateTime(0),
    _lastAngleUpdate(QDateTime::currentDateTime()),
    _anglesValidTimer(this) {
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
    
    // Start with all-zero DataMapper status
    memset(&_dmapStatus, 0, sizeof(_dmapStatus));

    // No status from any daemons yet
    _ui.cmigitsStatusIcon->setPixmap(_redLED);
    _ui.fireflydStatusIcon->setPixmap(_redLED);
    _ui.hcrdrxStatusIcon->setPixmap(_redLED);
    _ui.hcrMonitorStatusIcon->setPixmap(_redLED);
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
    connect(& _mcStatusThread, SIGNAL(serverResponsive(bool, QString)),
            this, SLOT(_mcResponsivenessChange(bool, QString)));
    connect(& _mcStatusThread, SIGNAL(newStatus(MotionControl::Status)),
            this, SLOT(_setMotionControlStatus(MotionControl::Status)));
    _mcStatusThread.start();

    // Connect signals from our HcrdrxStatusThread object and start the thread.
    connect(& _hcrdrxStatusThread, SIGNAL(serverResponsive(bool)),
            this, SLOT(_drxResponsivenessChange(bool)));
    connect(& _hcrdrxStatusThread, SIGNAL(newStatus(DrxStatus)),
            this, SLOT(_setDrxStatus(DrxStatus)));
    _hcrdrxStatusThread.start();

    // Connect signals from our HcrMonitorStatusThread object and start the thread.
    connect(& _hcrMonitorStatusThread, SIGNAL(serverResponsive(bool, QString)),
            this, SLOT(_hcrMonitorResponsivenessChange(bool, QString)));
    connect(& _hcrMonitorStatusThread, SIGNAL(newStatus(HcrMonitorStatus)),
            this, SLOT(_setHcrMonitorStatus(HcrMonitorStatus)));
    _hcrMonitorStatusThread.start();

    // Connect signals from our HcrPmc730StatusThread object and start the thread.
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
        _ui.requestedModeCombo->insertItem(i, HcrPmc730::HmcModeNames[i].c_str(), i);
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
HcrGuiMainWindow::_mcResponsivenessChange(bool responding, QString msg) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "MotionControlDaemon " <<
            _mcStatusThread.rpcClient().daemonUrl() <<
            (responding ? " is " : " is not ") <<
            "responding (" << msg.toStdString() << ")";
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
    _motionControlDetails.updateStatus(_mcStatusThread.serverIsResponding(),
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
    } else {
        // For a newly responding hcr_xmitd, assume RDS is under control until
        // we get a new status
        _rdsXmitControl = true;
    }
}

void
HcrGuiMainWindow::_setXmitStatus(XmitStatus status) {  
    _xmitStatus = status;
    
    // If the CMU switch for control source is set to anything other than
    // "RDS", let the user know immediately.
    switch (_xmitStatus.controlSource()) {
    case XmitStatus::RDSControl:
        if (! _rdsXmitControl) {
            _rdsXmitControl = true;
            QMessageBox box(QMessageBox::Information,
                    "Transmitter Under RDS Control",
                    "The transmitter CMU control switch is now set to 'RDS'.",
                    QMessageBox::Ok, this);
            box.setInformativeText(
                    "GUI control of the transmitter should now function normally.");
            box.exec();
        }
        break;
    case XmitStatus::RS232Control:
    case XmitStatus::FrontPanelControl:
        if (_rdsXmitControl) {
            _rdsXmitControl = false;
            QMessageBox box(QMessageBox::Warning,
                    "Bad Transmitter Control Source",
                    "The transmitter CMU control switch is not set to 'RDS'.",
                    QMessageBox::Ok, this);
            box.setInformativeText(
                    "GUI control of the transmitter will generate unexpected results!");
            box.exec();
        }
        break;
    case XmitStatus::UnknownControl:
    default:
        // Do nothing if the controller for the transmitter is unknown. This
        // is the case when the transmitter CMU is not replying to status 
        // requests on its RS-232 interface.
        break;
    }
    
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
HcrGuiMainWindow::_hcrMonitorResponsivenessChange(bool responding, QString msg) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "HcrMonitor @ " <<
            _hcrMonitorStatusThread.daemonHost() << ":" <<
            _hcrMonitorStatusThread.daemonPort() <<
            (responding ? " is " : " is not ") <<
            "responding (" << msg.toStdString() << ")";
    _logMessage(ss.str().c_str());

    if (! responding) {
        // Create a default (bad) HcrMonitorStatus, and set it as the last 
        // status received.
        _setHcrMonitorStatus(HcrMonitorStatus());
    }
}

void
HcrGuiMainWindow::_setHcrMonitorStatus(HcrMonitorStatus status) {
    _hcrMonitorStatus = status;
    // Update the details dialog
    _hcrMonitorDetails.updateStatus(_hcrMonitorStatusThread.serverIsResponding(),
            _hcrMonitorStatus, _pmcStatus);
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
        // Set current status to all zero values
        DMAP_info_t emptyDmapStatus;
        memset(&emptyDmapStatus, 0, sizeof(emptyDmapStatus));
        _setDataMapperStatus(emptyDmapStatus);
    }
}

void
HcrGuiMainWindow::_setDataMapperStatus(DMAP_info_t newStatus) {
    time_t now = time(0);
    
    // If the status time has changed, calculate write rate using incoming and
    // previous status.
    ti32 deltaTime = newStatus.end_time - _dmapStatus.end_time;
    if (deltaTime > 0) {
        double mbWritten = (newStatus.total_bytes - _dmapStatus.total_bytes) /
                1.0e6;
        _dmapWriteRate = mbWritten / deltaTime; // MB/s
        _dmapWriteRateTime = now;
        DLOG << mbWritten << " bytes written in " << deltaTime << "s";
        DLOG << "New write rate for " << newStatus.end_time << " (@ " <<
                now << "): " << _dmapWriteRate;
    } else {
        // Time out the old write rate after TIMEOUT_SECS
        const int TIMEOUT_SECS = 60;
        if ((now - _dmapWriteRateTime) > TIMEOUT_SECS) {
            WLOG << _dmapWriteRateTime << " write rate has timed out";
            _dmapWriteRate = 0.0;
            _dmapWriteRateTime = now;
        }
    }
    // Store incoming status
    _dmapStatus = newStatus;
//    // Update the details dialog
//    _dmapDetails.updateStatus(_dmapStatus);
    // Update the main GUI
    _update();
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
    if (_rdsXmitControl) {
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
        xmitting = _pmcStatus.rdsXmitterFilamentOn() && _pmcStatus.rdsXmitterHvOn() &&
                ! _pmcStatus.modPulseDisabled() && ! hvDisableFault;
    } else {
        // If transmitter is not under RDS control, we can just use the
        // "RF on" status bit to tell us we're transmitting.
        xmitting = _xmitStatus.rfOn();
    }
    return(xmitting);
}

/// Pop up the antenna mode editing dialog
void
HcrGuiMainWindow::on_antennaModeButton_clicked() {
    // Pop up the antenna mode dialog, and apply the new mode if the dialog
    // is accepted.
    if (_antennaModeDialog.exec() == QDialog::Accepted) {
        if (_antennaModeDialog.getMode() == AntennaModeDialog::POINTING) {
            float angle;
            _antennaModeDialog.getPointingAngle(angle);
            // Point the antenna to the angle
            _mcStatusThread.rpcClient().point(angle);
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
            _mcStatusThread.rpcClient().scan(ccwLimit, cwLimit, scanRate, beamTilt);
        }
    }
}

/// Toggle motion control attitude correction
void
HcrGuiMainWindow::on_attitudeCorrectionButton_clicked() {
    // Toggle the current state of attitude correction
    bool correction = _mcStatus.attitudeCorrectionEnabled;
    ILOG << "Correction is currently " << (correction ? "enabled": "disabled");
    _mcStatusThread.rpcClient().setCorrectionEnabled(! correction);
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
    _mcStatusThread.rpcClient().setCorrectionEnabled(false);

    // Start the drive homing program.
    _mcStatusThread.rpcClient().homeDrive();

    // Poll until homing is complete
    ILOG << "Waiting for servo drives to complete homing";
    while (true) {
        if (! _mcStatusThread.rpcClient().homingInProgress()) {
            break;
        }
        // Let other things run for up to 200 ms
        QCoreApplication::processEvents(QEventLoop::AllEvents, 200);
    }
    
    // Update motion control status and verify drives actually got homed. Pop up
    // a warning box if homing failed.
    _mcStatus = _mcStatusThread.rpcClient().status();
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
    _mcStatusThread.rpcClient().setCorrectionEnabled(savedState);
}

/// Toggle the current on/off state of the transmitter klystron filament
void
HcrGuiMainWindow::on_filamentButton_clicked() {
    // Send the command to toggle HV state to both hcr_xmitd and 
    // HcrPmc730Daemon. If the transmitter is under RDS control (generally 
    // true), the HV line is handled by HcrPmc730Daemon. If RS-232 control, the 
    // HV line is handled by hcr_xmitd. We need to cover both cases.
    if (_pmcStatus.rdsXmitterFilamentOn()) {
        try {
            _pmcStatusThread.rpcClient().xmitFilamentOff();
        } catch (std::exception & e) {
            WLOG << "Could not tell HcrPmc730Daemon to turn off filament";
        }
    } else {
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

/// Set HMC mode via HcrMonitor
void
HcrGuiMainWindow::on_requestedModeCombo_activated(int index) {
    // Set a new requested HMC mode on HcrMonitor
    HcrPmc730::HmcOperationMode mode =
            static_cast<HcrPmc730::HmcOperationMode>(index);
    try {
        ILOG << "Requesting HMC mode " << mode;
        _hcrMonitorStatusThread.rpcClient().setRequestedHmcMode(mode);
    } catch (std::exception & e) {
        WLOG << "Could not tell HcrMonitor to request HMC mode " << mode;
    }
}

/// Toggle the requested transmitter high voltage state
void
HcrGuiMainWindow::on_requestHvButton_clicked() {
    // Send the command to request toggle of HV state to HcrMonitor.
    if (_hcrMonitorStatus.hvRequested()) {
        try {
            ILOG << "Requesting HV off";
        	_hcrMonitorStatusThread.rpcClient().setHvRequested(false);
        } catch (std::exception & e) {
            WLOG << "Could not tell HcrMonitor to turn off HV";
        }
    } else {
        try {
            ILOG << "Requesting HV on";
        	_hcrMonitorStatusThread.rpcClient().setHvRequested(true);
        } catch (std::exception & e) {
            WLOG << "Could not tell HcrMonitor to turn on HV";
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
HcrGuiMainWindow::on_hcrMonitorDetailsButton_clicked() {
    _hcrMonitorDetails.show();
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
    _ui.filamentIcon->setPixmap(_pmcStatus.rdsXmitterFilamentOn() ? _greenLED : _greenLED_off);
   if (! _pmcStatus.rdsXmitterFilamentOn()) {
        // Turn off warmup LED if the filament is not on
        _ui.filamentWarmupIcon->setPixmap(_greenLED_off);
        _ui.filamentWarmupLabel->setText("Filament warmup");
    } else {
        // Amber during filament warmup, then green when warm
        _ui.filamentWarmupIcon->setPixmap(_xmitStatus.filamentDelayActive() ? _amberLED : _greenLED);
        _ui.filamentWarmupLabel->setText(_xmitStatus.filamentDelayActive() ?
                "Waiting for warmup" : "Filament is warm");
    }
    _ui.requestHvIcon->setPixmap(_hcrMonitorStatus.hvRequested() ?
            _greenLED : _greenLED_off);
    _ui.hvOnIcon->setPixmap(_pmcStatus.rdsXmitterHvOn() ? _greenLED : _greenLED_off);
    // Enable the request HV button as soon as HcrMonitor is responding
    _ui.requestHvButton->setEnabled(_hcrMonitorStatusThread.serverIsResponding());
    // Regardless of other conditions, force the request HV button to be enabled
    // if HV is on, so that it can be turned off.
    if (_pmcStatus.rdsXmitterHvOn()) {
        _ui.requestHvButton->setEnabled(true);
    }
    _ui.xmittingIcon->setPixmap(_xmitting() ? _greenLED : _greenLED_off);

    // Which control source is enabled?
    switch (_xmitStatus.controlSource()) {
    case XmitStatus::FrontPanelControl:
        _ui.controlSourceLabel->setText("Control via <b>Front Panel</b>");
        break;
    case XmitStatus::RS232Control:
        _ui.controlSourceLabel->setText("Control via <b>RS-232</b>");
        break;
    case XmitStatus::RDSControl:
        _ui.controlSourceLabel->setText("Control via <b>RDS</b>");
        break;
    default:
        // Unknown control source. Show "Unknown" in dark red text.
        _ui.controlSourceLabel->setText("Control via <b><font color=#880000>Unknown</font></b>");
        break;
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
    _ui.requestedModeCombo->setCurrentIndex(_hcrMonitorStatus.requestedHmcMode());
    std::string modeText = HcrPmc730::HmcModeNames[_pmcStatus.hmcMode()];
    _ui.hmcModeValue->setText(QString::fromStdString(modeText));

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
    if (! _mcStatusThread.serverIsResponding() ||
            _motionControlDetails.errorDetected()) {
        _ui.mcStatusIcon->setPixmap(_redLED);
    } else if (_motionControlDetails.warningDetected()) {
        _ui.mcStatusIcon->setPixmap(_amberLED);
    } else {
        _ui.mcStatusIcon->setPixmap(_greenLED);
    }

    if (_mcStatusThread.serverIsResponding()) {
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

    // HcrMonitor status LED
    if (! _hcrMonitorStatusThread.serverIsResponding()) {
        light = _redLED;
    } else {
        // If normal transmit is allowed use green light, otherwise amber
        light = (_hcrMonitorStatus.xmitAllowedStatus() == TransmitControl::XMIT_ALLOWED) ?
                _greenLED : _amberLED;
    }
    _ui.hcrMonitorStatusIcon->setPixmap(light);

    // DataMapper status LED and current write rate
    _ui.dmStatusIcon->setPixmap(_dataMapperStatusThread.serverIsResponding() ?
            _greenLED : _redLED);
    _ui.dataRateIcon->setPixmap(_dmapWriteRate > 0 ? _greenLED : _amberLED);
    _ui.writeRateValue->setText(QString::number(_dmapWriteRate, 'f', 0));

    // Location info
    _ui.latitudeValue->setText(QString::number(_cmigitsStatus.latitude(), 'f', 4));
    _ui.longitudeValue->setText(QString::number(_cmigitsStatus.longitude(), 'f', 4));

    int iAltFt = int(MetersToFeet(_cmigitsStatus.altitude()));
    _ui.altitudeMslValue->setText(QString::number(iAltFt));

    iAltFt = int(MetersToFeet(_hcrMonitorStatus.aglAltitude()));
    _ui.altitudeAglValue->setText(QString::number(iAltFt));

    _ui.surfaceValue->setText(_hcrMonitorStatus.overWater() ? "Water" : "Land");
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
