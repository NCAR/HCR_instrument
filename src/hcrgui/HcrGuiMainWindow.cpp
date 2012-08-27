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
    
    // Hide fault details initially
    _ui.xmitterFaultDetailsBox->setVisible(false);
    _ui.detailVisibilityButton->setText("Show Details");
    
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
HcrGuiMainWindow::on_detailVisibilityButton_clicked() {
    _ui.xmitterFaultDetailsBox->setVisible(! _ui.xmitterFaultDetailsBox->isVisible());
    if (_ui.xmitterFaultDetailsBox->isVisible()) {
        _ui.detailVisibilityButton->setText("Hide Details");
    } else {
        _ui.detailVisibilityButton->setText("Show Details");
    }
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
    _xmitStatus = XmitdRpcClient::XmitStatus(); // start with uninitialized status
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
    _ui.powerValidIcon->setPixmap(_xmitStatus.powerValid() ? _greenLED : _greenLED_off);
    _ui.filamentIcon->setPixmap(_xmitterFilamentOn() ? _greenLED : _greenLED_off);
    // filament button disabled if control is from the CMU front panel
    _ui.filamentButton->setEnabled(! _xmitStatus.frontPanelCtlEnabled());
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
    _ui.xmittingIcon->setPixmap(_xmitStatus.rfOn() ? _greenLED : _greenLED_off);
    
    // Which control source is enabled?
    _ui.frontPanelLabel->setEnabled(_xmitStatus.frontPanelCtlEnabled());
    _ui.rs232Label->setEnabled(_xmitStatus.rs232CtlEnabled());
    _ui.rdsLabel->setEnabled(_xmitStatus.rdsCtlEnabled());
    
    // fault lights
    _ui.faultSummaryIcon->setPixmap(_xmitStatus.faultSummary() ? _redLED: _greenLED);
    _ui.modulatorFaultIcon->setPixmap(_xmitStatus.modulatorFault() ? _redLED : _greenLED);
    _ui.syncFaultIcon->setPixmap(_xmitStatus.syncFault() ? _redLED : _greenLED);
    _ui.xmitterTempFaultIcon->setPixmap(_xmitStatus.xmitterTempFault() ? _redLED : _greenLED);
    _ui.wgArcFaultIcon->setPixmap(_xmitStatus.wgArcFault() ? _redLED : _greenLED);
    _ui.collectorCurrFaultIcon->setPixmap(_xmitStatus.collectorCurrFault() ? _redLED : _greenLED);
    _ui.bodyCurrFaultIcon->setPixmap(_xmitStatus.bodyCurrFault() ? _redLED : _greenLED);
    _ui.filamentLorFaultIcon->setPixmap(_xmitStatus.filamentLorFault() ? _redLED : _greenLED);
    _ui.focusElectrodeLorFaultIcon->setPixmap(_xmitStatus.focusElectrodeLorFault() ? _redLED : _greenLED);
    _ui.cathodeLorFaultIcon->setPixmap(_xmitStatus.cathodeLorFault() ? _redLED : _greenLED);
    _ui.inverterOverloadFaultIcon->setPixmap(_xmitStatus.inverterOverloadFault() ? _redLED : _greenLED);
    _ui.extInterlockFaultIcon->setPixmap(_xmitStatus.extInterlockFault() ? _redLED : _greenLED);
    _ui.eikInterlockFaultIcon->setPixmap(_xmitStatus.eikInterlockFault() ? _redLED : _greenLED);
    
    // fault counts
    _ui.modulatorFaultCount->
        setText(_countLabel(_xmitStatus.modulatorFaultCount()));
    _ui.syncFaultCount->
        setText(_countLabel(_xmitStatus.syncFaultCount()));
    _ui.xmitterTempFaultCount->
        setText(_countLabel(_xmitStatus.xmitterTempFaultCount()));
    _ui.wgArcFaultCount->
        setText(_countLabel(_xmitStatus.wgArcFaultCount()));
    _ui.collectorCurrFaultCount->
        setText(_countLabel(_xmitStatus.collectorCurrFaultCount()));
    _ui.bodyCurrFaultCount->
        setText(_countLabel(_xmitStatus.bodyCurrFaultCount()));
    _ui.filamentLorFaultCount->
        setText(_countLabel(_xmitStatus.filamentLorFaultCount()));
    _ui.focusElectrodeLorFaultCount->
        setText(_countLabel(_xmitStatus.focusElectrodeLorFaultCount()));
    _ui.cathodeLorFaultCount->
        setText(_countLabel(_xmitStatus.cathodeLorFaultCount()));
    _ui.inverterOverloadFaultCount->
        setText(_countLabel(_xmitStatus.inverterOverloadFaultCount()));
    _ui.extInterlockFaultCount->
        setText(_countLabel(_xmitStatus.extInterlockFaultCount()));
    _ui.eikInterlockFaultCount->
        setText(_countLabel(_xmitStatus.eikInterlockFaultCount()));
    
    // latest fault times
    _ui.modulatorFaultTime->
        setText(_faultTimeLabel(_xmitStatus.modulatorFaultTime()));
    _ui.syncFaultTime->
        setText(_faultTimeLabel(_xmitStatus.syncFaultTime()));
    _ui.xmitterTempFaultTime->
        setText(_faultTimeLabel(_xmitStatus.xmitterTempFaultTime()));
    _ui.wgArcFaultTime->
        setText(_faultTimeLabel(_xmitStatus.wgArcFaultTime()));
    _ui.collectorCurrFaultTime->
        setText(_faultTimeLabel(_xmitStatus.collectorCurrFaultTime()));
    _ui.bodyCurrFaultTime->
        setText(_faultTimeLabel(_xmitStatus.bodyCurrFaultTime()));
    _ui.filamentLorFaultTime->
        setText(_faultTimeLabel(_xmitStatus.filamentLorFaultTime()));
    _ui.focusElectrodeLorFaultTime->
        setText(_faultTimeLabel(_xmitStatus.focusElectrodeLorFaultTime()));
    _ui.cathodeLorFaultTime->
        setText(_faultTimeLabel(_xmitStatus.cathodeLorFaultTime()));
    _ui.inverterOverloadFaultTime->
        setText(_faultTimeLabel(_xmitStatus.inverterOverloadFaultTime()));
    _ui.extInterlockFaultTime->
        setText(_faultTimeLabel(_xmitStatus.extInterlockFaultTime()));
    _ui.eikInterlockFaultTime->
        setText(_faultTimeLabel(_xmitStatus.eikInterlockFaultTime()));
    
    QString txt;
    // Text displays for voltage, currents, and temperature
    txt.setNum(_xmitStatus.cathodeVoltage(), 'f', 1);
    _ui.cathodeVoltageValue->setText(txt);
    
    txt.setNum(_xmitStatus.collectorCurrent(), 'f', 1);
    _ui.collectorCurrentValue->setText(txt);
    
    txt.setNum(_xmitStatus.bodyCurrent(), 'f', 1);
    _ui.bodyCurrentValue->setText(txt);
    
    txt.setNum(_xmitStatus.xmitterTemperature(), 'f', 1);
    _ui.xmitterTempValue->setText(txt);
    
    if (_xmitStatus.rs232CtlEnabled()) {
        statusBar()->clearMessage();
    } else {
        statusBar()->showMessage("RS-232 control is currently DISABLED");
    }
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
    _ui.statusBox->setEnabled(false);
    _ui.xmitterFaultDetailsBox->setEnabled(false);
    _ui.xmitterStartBox->setEnabled(false);

    _ui.powerValidIcon->setPixmap(_greenLED_off);
    _ui.filamentIcon->setPixmap(_greenLED_off);
    _ui.hvIcon->setPixmap(_greenLED_off);
    _ui.xmittingIcon->setPixmap(_greenLED_off);
    
    _ui.modulatorFaultIcon->setPixmap(_greenLED_off);
    _ui.modulatorFaultCount->setText("");
    _ui.syncFaultIcon->setPixmap(_greenLED_off);
    _ui.syncFaultCount->setText("");
    _ui.xmitterTempFaultIcon->setPixmap(_greenLED_off);
    _ui.xmitterTempFaultCount->setText("");
    _ui.wgArcFaultIcon->setPixmap(_greenLED_off);
    _ui.wgArcFaultCount->setText("");
    _ui.collectorCurrFaultIcon->setPixmap(_greenLED_off);
    _ui.collectorCurrFaultCount->setText("");
    _ui.bodyCurrFaultIcon->setPixmap(_greenLED_off);
    _ui.bodyCurrFaultCount->setText("");
    _ui.filamentLorFaultIcon->setPixmap(_greenLED_off);
    _ui.filamentLorFaultCount->setText("");
    _ui.focusElectrodeLorFaultIcon->setPixmap(_greenLED_off);
    _ui.focusElectrodeLorFaultCount->setText("");
    _ui.cathodeLorFaultIcon->setPixmap(_greenLED_off);
    _ui.cathodeLorFaultCount->setText("");
    
    _ui.cathodeVoltageValue->setText("0.0");
    _ui.collectorCurrentValue->setText("0.0");
    _ui.bodyCurrentValue->setText("0.0");
    _ui.xmitterTempValue->setText("0.0");
    
}

void
HcrGuiMainWindow::_enableUi() {
    _ui.xmitterFaultDetailsBox->setEnabled(true);
    _ui.statusBox->setEnabled(true);
    _ui.xmitterStartBox->setEnabled(true);
}

void
HcrGuiMainWindow::_logMessage(std::string message) {
    _ui.logArea->appendPlainText(
            QDateTime::currentDateTime().toUTC().toString("yyyy-MM-dd hh:mm:ss ") + 
            message.c_str());
}

QString
HcrGuiMainWindow::_countLabel(int count) {
    if (count == 0)
        return QString("-");

    QString txt;
    txt.setNum(count);
    return txt;
}

QString
HcrGuiMainWindow::_faultTimeLabel(time_t time) {
    if (time == -1)
        return QString("");
    
    QDateTime nowQDT = QDateTime::currentDateTime().toUTC();
    QDateTime faultQDT = QDateTime::fromTime_t(time).toUTC();
    if (faultQDT.date() == nowQDT.date()) {
        return(faultQDT.toString("hh:mm:ss"));
    } else {
        return(faultQDT.toString("MM/dd hh:mm:ss"));
    }
}
