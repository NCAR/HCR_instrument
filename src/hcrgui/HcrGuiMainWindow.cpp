/*
 * HcrGuiMainWindow.cpp
 *
 *  Created on: Jan 14, 2011
 *      Author: burghart
 */
#include "HcrGuiMainWindow.h"

#include <sstream>
#include <unistd.h>
#include <logx/Logging.h>

#include <QDateTime>

LOGGING("MainWindow")


HcrGuiMainWindow::HcrGuiMainWindow(std::string xmitterHost, 
    int xmitterPort, std::string hcrdrxHost, int hcrdrxPort) :
    QMainWindow(),
    _ui(),
    _cmigitsStatusDialog(this),
    _xmitStatusDialog(this),
    _xmitdStatusThread(xmitterHost, xmitterPort),
    _drxStatusThread(hcrdrxHost, hcrdrxPort),
    _redLED(":/redLED.png"),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png"),
    _nextLogIndex(0) {
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
    ss << "No response yet from hcrdrx at " << hcrdrxHost << ":" <<
            hcrdrxPort;
    _logMessage(ss.str());

    // Disable the data system box and C-MIGITS box until we get status from
    // hcrdrx.
    _ui.dataSystemBox->setEnabled(false);
    _ui.cmigitsBox->setEnabled(false);

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

    _ui.dataSystemBox->setEnabled(responding);
    _ui.cmigitsBox->setEnabled(responding);
    if (! responding) {
        // Create a default (bad) DrxStatus, and set it as the last status
        // received.
        _setDrxStatus(DrxStatus());
        // Close the C-MIGITS status details dialog
        _cmigitsStatusDialog.accept();
    }
}

void
HcrGuiMainWindow::_setXmitStatus(XmitStatus status) {
    _xmitStatus = status;
    _update();
    // Append new log messages from hcr_xmitd
    _appendXmitdLogMsgs();
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

/// Set HMC mode 0
void
HcrGuiMainWindow::on_hmcMode0Button_clicked() {
    _drxStatusThread.rpcClient().setHmcMode(0);
}

/// Set HMC mode 1
void
HcrGuiMainWindow::on_hmcMode1Button_clicked() {
    _drxStatusThread.rpcClient().setHmcMode(1);
}

/// Set HMC mode 2
void
HcrGuiMainWindow::on_hmcMode2Button_clicked() {
    _drxStatusThread.rpcClient().setHmcMode(2);
}

/// Set HMC mode 3
void
HcrGuiMainWindow::on_hmcMode3Button_clicked() {
    _drxStatusThread.rpcClient().setHmcMode(3);
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
    _xmitStatusDialog.show();
}

void
HcrGuiMainWindow::on_cmigitsDetailsButton_clicked() {
    _cmigitsStatusDialog.show();
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
    switch (_drxStatus.hmcMode()) {
    case 0:
        _ui.hmcMode0Button->setChecked(true);
        break;
    case 1:
        _ui.hmcMode1Button->setChecked(true);
        break;
    case 2:
        _ui.hmcMode2Button->setChecked(true);
        break;
    case 3:
        _ui.hmcMode3Button->setChecked(true);
        break;
    default:
        // Whoa, unknown mode...
        _ui.hmcMode0Button->setChecked(false);
        _ui.hmcMode1Button->setChecked(false);
        _ui.hmcMode2Button->setChecked(false);
        _ui.hmcMode3Button->setChecked(false);
        ELOG << "Unknown HMC mode: " << _drxStatus.hmcMode();
        break;
    }

    // C-MIGITS status light
    {
        // Get C-MIGITS status
        double statusTime = 0.0;
        uint16_t mode = 0;
        bool insAvailable = 0;
        bool gpsAvailable = 0;
        uint16_t nSats = 0;
        uint16_t positionFOM = 0;
        uint16_t velocityFOM = 0;
        uint16_t headingFOM = 0;
        uint16_t timeFOM = 0;
        float expectedHPosError = 0.0;
        float expectedVPosError = 0.0;
        float expectedVelError = 0.0;
        _drxStatus.cmigitsStatus(statusTime, mode, insAvailable, gpsAvailable,
                nSats, positionFOM, velocityFOM, headingFOM, timeFOM,
                expectedHPosError, expectedVPosError, expectedVelError);
        // Green light if both INS and GPS are available
        bool cmigitsStatusGood = insAvailable && gpsAvailable;
        _ui.cmigitsStatusIcon->setPixmap(cmigitsStatusGood ?  _greenLED : _redLED);
    }

    // Update the transmitter status details dialog
    _xmitStatusDialog.setEnabled(_xmitStatus.serialConnected());
    _xmitStatusDialog.updateStatus(_xmitStatus);

    // Update the C-MIGITS status details dialog
    _cmigitsStatusDialog.updateStatus(_drxStatus);
}

void
HcrGuiMainWindow::_logMessage(std::string message) {
    _ui.logArea->appendPlainText(
            QDateTime::currentDateTime().toUTC().toString("yyyy-MM-dd hh:mm:ss ") + 
            message.c_str());
}
