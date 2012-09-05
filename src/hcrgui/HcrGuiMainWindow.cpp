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
    _xmitStatusDialog(this),
    _xmitClient(xmitterHost, xmitterPort),
    _drxClient(hcrdrxHost, hcrdrxPort),
    _updateTimer(this),
    _redLED(":/redLED.png"),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png"),
    _nextLogIndex(0),
    _noXmitd(true) {
    // Set up the UI
    _ui.setupUi(this);
    // Limit the log area to 1000 messages
    _ui.logArea->setMaximumBlockCount(1000);
    _logMessage("hcr_xmitctl started");
    
    // Schedule 1 Hz updates
    connect(&_updateTimer, SIGNAL(timeout()), this, SLOT(_update()));
    _updateTimer.start(1000);
}

HcrGuiMainWindow::~HcrGuiMainWindow() {
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
            _xmitClient.xmitFilamentOff();
        } else {
            _xmitClient.xmitFilamentOn();
        }
    } else if (_xmitStatus.rdsCtlEnabled()) {
        // If RDS control is enabled, then transmitter commands go to hcrdrx
        // (i.e., the Remote Data System), since it owns the digital lines
        // controlling the transmitter.
        if (_xmitterFilamentOn()) {
            _drxClient.xmitFilamentOff();
        } else {
            _drxClient.xmitFilamentOn();
        }
    }
    _update();
}

/// Turn on the transmitter klystron filament
void
HcrGuiMainWindow::on_filamentOnButton_clicked() {
    if (_xmitStatus.rs232CtlEnabled()) {
        // If RS-232 control is enabled, then transmitter commands go
        // to hcr_xmitd, which owns the serial line talking to the transmitter
        // CMU.
        _xmitClient.xmitFilamentOn();
    } else if (_xmitStatus.rdsCtlEnabled()) {
        // If RDS control is enabled, then transmitter commands go to hcrdrx
        // (i.e., the Remote Data System), since it owns the digital lines
        // controlling the transmitter.
        _drxClient.xmitFilamentOn();
    }
    _update();
}

/// Turn off the transmitter klystron filament
void
HcrGuiMainWindow::on_filamentOffButton_clicked() {
    if (_xmitStatus.rs232CtlEnabled()) {
        // If RS-232 control is enabled, then transmitter commands go
        // to hcr_xmitd, which owns the serial line talking to the transmitter
        // CMU.
        _xmitClient.xmitFilamentOff();
    } else if (_xmitStatus.rdsCtlEnabled()) {
        // If RDS control is enabled, then transmitter commands go to hcrdrx
        // (i.e., the Remote Data System), since it owns the digital lines
        // controlling the transmitter.
        _drxClient.xmitFilamentOff();
    }
    _update();
}

/// Toggle the current on/off state of the transmitter high voltage
void
HcrGuiMainWindow::on_hvButton_clicked() {
    if (_xmitStatus.rs232CtlEnabled()) {
        // If RS-232 control is enabled, then transmitter commands go
        // to hcr_xmitd, which owns the serial line talking to the transmitter
        // CMU.
        if (_xmitterHvOn()) {
            _xmitClient.xmitHvOff();
        } else {
            _xmitClient.xmitHvOn();
        }
    } else if (_xmitStatus.rdsCtlEnabled()) {
        // If RDS control is enabled, then transmitter commands go to hcrdrx
        // (i.e., the Remote Data System), since it owns the digital lines
        // controlling the transmitter.
        if (_xmitterHvOn()) {
            _drxClient.xmitHvOff();
        } else {
            _drxClient.xmitHvOn();
        }
    }
    _update();
}

/// Turn on the transmitter klystron HV
void
HcrGuiMainWindow::on_hvOnButton_clicked() {
    if (_xmitStatus.rs232CtlEnabled()) {
        // If RS-232 control is enabled, then transmitter commands go
        // to hcr_xmitd, which owns the serial line talking to the transmitter
        // CMU.
        _xmitClient.xmitHvOn();
    } else if (_xmitStatus.rdsCtlEnabled()) {
        // If RDS control is enabled, then transmitter commands go to hcrdrx
        // (i.e., the Remote Data System), since it owns the digital lines
        // controlling the transmitter.
        _drxClient.xmitHvOn();
    }
    _update();
}

/// Turn off the transmitter klystron HV
void
HcrGuiMainWindow::on_hvOffButton_clicked() {
    if (_xmitStatus.rs232CtlEnabled()) {
        // If RS-232 control is enabled, then transmitter commands go
        // to hcr_xmitd, which owns the serial line talking to the transmitter
        // CMU.
        _xmitClient.xmitHvOff();
    } else if (_xmitStatus.rdsCtlEnabled()) {
        // If RDS control is enabled, then transmitter commands go to hcrdrx
        // (i.e., the Remote Data System), since it owns the digital lines
        // controlling the transmitter.
        _drxClient.xmitHvOff();
    }
    _update();
}

void
HcrGuiMainWindow::_appendXmitdLogMsgs() {
    unsigned int firstIndex = _nextLogIndex;
    std::string msgs;
    _xmitClient.getLogMessages(firstIndex, msgs, _nextLogIndex);
    if (_nextLogIndex != firstIndex) {
        _ui.logArea->appendPlainText(msgs.c_str());
    }
}

void
HcrGuiMainWindow::on_xmitterDetailsButton_clicked() {
    _xmitStatusDialog.show();
}

void
HcrGuiMainWindow::_update() {
    // Update the current time string
    char timestring[32];
    time_t now = time(0);
    strftime(timestring, sizeof(timestring) - 1, "%F %T", gmtime(&now));
    _ui.clockLabel->setText(timestring);
    
    // Append new log messages from hcr_xmitd
    _appendXmitdLogMsgs();
    
    // Get status from hcr_xmitd
    _xmitStatus = XmitStatus(); // start with uninitialized status
    if (! _xmitClient.getStatus(_xmitStatus)) {
        _noDaemon();
        return;
    }
    if (_noXmitd) {
        // we were out of touch with the hcr_xmitd
        std::ostringstream ss;
        ss << "Connected to hcr_xmitd @ " << _xmitClient.getXmitdHost() << ":" <<
                _xmitClient.getXmitdPort();
        _logMessage(ss.str().c_str());
        _noXmitd = false;
    } 
    if (! _xmitStatus.serialConnected()) {
        _noXmitter();
        return;
    }
    
    _enableUi();

    _drxStatus = HcrdrxRpcClient::Status(); // start with uninitialized status
    if (! _drxClient.getStatus(_drxStatus)) {
        std::ostringstream ss;
        ss << "No connection to hcrdrx @ " << _drxClient.getHcrdrxHost() << ":" <<
                _drxClient.getHcrdrxPort();
        _logMessage(ss.str().c_str());
    }

    // Update transmitter control
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

    // Update the transmitter status details dialog
    _xmitStatusDialog.updateStatus(_xmitStatus);
}

void
HcrGuiMainWindow::_noDaemon() {
    // Note lack of daemon connection in the status bar
    std::ostringstream ss;
    ss << "No connection to hcr_xmitd @ " << _xmitClient.getXmitdHost() << ":" <<
            _xmitClient.getXmitdPort();
    statusBar()->showMessage(ss.str().c_str());
    // If we've been in contact with a hcr_xmitd, log that we lost contact
    if (_noXmitd == false) {
        ss.seekp(0, std::ios_base::beg); // start over in the ostringstream
        ss << "Lost contact with hcr_xmitd @ " << _xmitClient.getXmitdHost() <<
                ":" << _xmitClient.getXmitdPort();
        _logMessage(ss.str());
    }
    // If we lose contact with hcr_xmitd, reset _nextLogIndex to zero so we
    // start fresh when we connect again
    _nextLogIndex = 0;
    // Disable the UI when we are out of contact
    _noXmitd = true;
    _disableUi();
}

void
HcrGuiMainWindow::_noXmitter() {
    statusBar()->showMessage("No serial connection from hcr_xmitd to xmitter!");
    _disableUi();
}

void
HcrGuiMainWindow::_disableUi() {
    _ui.xmitterStartBox->setEnabled(false);

    _ui.powerValidIcon->setPixmap(_greenLED_off);
    _ui.filamentIcon->setPixmap(_greenLED_off);
    _ui.hvIcon->setPixmap(_greenLED_off);
    _ui.xmittingIcon->setPixmap(_greenLED_off);
    
    _xmitStatusDialog.noStatus();
}

void
HcrGuiMainWindow::_enableUi() {
    _ui.xmitterStartBox->setEnabled(true);
}

void
HcrGuiMainWindow::_logMessage(std::string message) {
    _ui.logArea->appendPlainText(
            QDateTime::currentDateTime().toUTC().toString("yyyy-MM-dd hh:mm:ss ") + 
            message.c_str());
}
