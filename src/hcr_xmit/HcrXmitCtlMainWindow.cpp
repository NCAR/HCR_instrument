/*
 * HcrXmitCtlMainWindow.cpp
 *
 *  Created on: Jan 14, 2011
 *      Author: burghart
 */
#include "HcrXmitCtlMainWindow.h"

#include <sstream>
#include <unistd.h>
#include <logx/Logging.h>

#include <QDateTime>

LOGGING("MainWindow")


HcrXmitCtlMainWindow::HcrXmitCtlMainWindow(std::string xmitterHost, 
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

HcrXmitCtlMainWindow::~HcrXmitCtlMainWindow() {
}

/// Toggle the current on/off state of the transmitter klystron filament
void
HcrXmitCtlMainWindow::on_filamentButton_clicked() {
    if (_status.rs232CtlEnabled()) {
        // If RS-232 control is enabled, then transmitter commands go
        // to hcr_xmitd, which owns the serial line talking to the transmitter
        // CMU.
        if (_status.filamentOn()) {
            _xmitClient.xmitFilamentOff();
        } else {
            _xmitClient.xmitFilamentOn();
        }
    } else if (_status.rdsCtlEnabled()) {
        // If RDS control is enabled, then transmitter commands go to hcrdrx
        // (i.e., the Remote Data System), since it owns the digital lines
        // controlling the transmitter.
        if (_status.filamentOn()) {
            _drxClient.xmitFilamentOff();
        } else {
            _drxClient.xmitFilamentOn();
        }
    }
    _update();
}

/// Toggle the current on/off state of the transmitter high voltage
void
HcrXmitCtlMainWindow::on_hvButton_clicked() {
    if (_status.rs232CtlEnabled()) {
        // If RS-232 control is enabled, then transmitter commands go
        // to hcr_xmitd, which owns the serial line talking to the transmitter
        // CMU.
//        _xmitClient.something();    // @TODO implement this
    } else if (_status.rdsCtlEnabled()) {
        // If RDS control is enabled, then transmitter commands go to hcrdrx
        // (i.e., the Remote Data System), since it owns the digital lines
        // controlling the transmitter.
        if (_status.highVoltageOn()) {
            _drxClient.xmitHvOff();
        } else {
            _drxClient.xmitHvOn();
        }
    }
    _update();
}

void
HcrXmitCtlMainWindow::_appendXmitdLogMsgs() {
    unsigned int firstIndex = _nextLogIndex;
    std::string msgs;
    _xmitClient.getLogMessages(firstIndex, msgs, _nextLogIndex);
    if (_nextLogIndex != firstIndex) {
        _ui.logArea->appendPlainText(msgs.c_str());
    }
}

void
HcrXmitCtlMainWindow::on_detailVisibilityButton_clicked() {
    _ui.xmitterFaultDetailsBox->setVisible(! _ui.xmitterFaultDetailsBox->isVisible());
    if (_ui.xmitterFaultDetailsBox->isVisible()) {
        _ui.detailVisibilityButton->setText("Hide Details");
    } else {
        _ui.detailVisibilityButton->setText("Show Details");
    }
}

void
HcrXmitCtlMainWindow::_update() {
    // Update the current time string
    char timestring[32];
    time_t now = time(0);
    strftime(timestring, sizeof(timestring) - 1, "%F %T", gmtime(&now));
    _ui.clockLabel->setText(timestring);
    
    // Append new log messages from hcr_xmitd
    _appendXmitdLogMsgs();
    
    // Get status from hcr_xmitd
    _status = XmitdRpcClient::XmitStatus(); // start with uninitialized status
    if (! _xmitClient.getStatus(_status)) {
        _noDaemon();
        return;
    } 
    if (_noXmitd){
        // we were out of touch with the hcr_xmitd
	std::ostringstream ss;
	ss << "Connected to hcr_xmitd @ " << _xmitClient.getXmitdHost() << ":" <<
		_xmitClient.getXmitdPort();
	_logMessage(ss.str().c_str());
	_noXmitd = false;
    } 
    if (! _status.serialConnected()) {
        _noXmitter();
        return;
    }
    
    _enableUi();

    // Update transmitter control
    _ui.powerValidIcon->setPixmap(_status.powerValid() ? _greenLED : _greenLED_off);
    _ui.filamentIcon->setPixmap(_status.filamentOn() ? _greenLED : _greenLED_off);
    if (! _status.filamentOn()) {
        // Warmup LED is off if the filament is not on
        _ui.filamentWarmupIcon->setPixmap(_greenLED_off);
        _ui.filamentWarmupLabel->setText("Filament warmup");
    } else {
        // Amber during filament warmup, then green when warm
        _ui.filamentWarmupIcon->setPixmap(_status.filamentDelayActive() ? _amberLED : _greenLED);
        _ui.filamentWarmupLabel->setText(_status.filamentDelayActive() ?
                "Waiting for warmup" : "Filament is warm");
    }
    _ui.hvIcon->setPixmap(_status.highVoltageOn() ? _greenLED : _greenLED_off);
    // Enable the HV button as soon as filament delay has expired
    _ui.hvButton->setEnabled(! _status.filamentDelayActive());
    _ui.xmittingIcon->setPixmap(_status.rfOn() ? _greenLED : _greenLED_off);
    
    // Which control source is enabled?
    _ui.frontPanelLabel->setEnabled(_status.frontPanelCtlEnabled());
    _ui.rs232Label->setEnabled(_status.rs232CtlEnabled());
    _ui.rdsLabel->setEnabled(_status.rdsCtlEnabled());
    
    // fault lights
    _ui.faultSummaryIcon->setPixmap(_status.faultSummary() ? _redLED: _greenLED);
    _ui.modulatorFaultIcon->setPixmap(_status.modulatorFault() ? _redLED : _greenLED);
    _ui.syncFaultIcon->setPixmap(_status.syncFault() ? _redLED : _greenLED);
    _ui.xmitterTempFaultIcon->setPixmap(_status.xmitterTempFault() ? _redLED : _greenLED);
    _ui.wgArcFaultIcon->setPixmap(_status.wgArcFault() ? _redLED : _greenLED);
    _ui.collectorCurrFaultIcon->setPixmap(_status.collectorCurrFault() ? _redLED : _greenLED);
    _ui.bodyCurrFaultIcon->setPixmap(_status.bodyCurrFault() ? _redLED : _greenLED);
    _ui.filamentLorFaultIcon->setPixmap(_status.filamentLorFault() ? _redLED : _greenLED);
    _ui.focusElectrodeLorFaultIcon->setPixmap(_status.focusElectrodeLorFault() ? _redLED : _greenLED);
    _ui.cathodeLorFaultIcon->setPixmap(_status.cathodeLorFault() ? _redLED : _greenLED);
    _ui.inverterOverloadFaultIcon->setPixmap(_status.inverterOverloadFault() ? _redLED : _greenLED);
    _ui.extInterlockFaultIcon->setPixmap(_status.extInterlockFault() ? _redLED : _greenLED);
    _ui.eikInterlockFaultIcon->setPixmap(_status.eikInterlockFault() ? _redLED : _greenLED);
    
    // fault counts
    _ui.modulatorFaultCount->
        setText(_countLabel(_status.modulatorFaultCount()));
    _ui.syncFaultCount->
        setText(_countLabel(_status.syncFaultCount()));
    _ui.xmitterTempFaultCount->
        setText(_countLabel(_status.xmitterTempFaultCount()));
    _ui.wgArcFaultCount->
        setText(_countLabel(_status.wgArcFaultCount()));
    _ui.collectorCurrFaultCount->
        setText(_countLabel(_status.collectorCurrFaultCount()));
    _ui.bodyCurrFaultCount->
        setText(_countLabel(_status.bodyCurrFaultCount()));
    _ui.filamentLorFaultCount->
        setText(_countLabel(_status.filamentLorFaultCount()));
    _ui.focusElectrodeLorFaultCount->
        setText(_countLabel(_status.focusElectrodeLorFaultCount()));
    _ui.cathodeLorFaultCount->
        setText(_countLabel(_status.cathodeLorFaultCount()));
    _ui.inverterOverloadFaultCount->
        setText(_countLabel(_status.inverterOverloadFaultCount()));
    _ui.extInterlockFaultCount->
        setText(_countLabel(_status.extInterlockFaultCount()));
    _ui.eikInterlockFaultCount->
        setText(_countLabel(_status.eikInterlockFaultCount()));
    
    // latest fault times
    _ui.modulatorFaultTime->
        setText(_faultTimeLabel(_status.modulatorFaultTime()));
    _ui.syncFaultTime->
        setText(_faultTimeLabel(_status.syncFaultTime()));
    _ui.xmitterTempFaultTime->
        setText(_faultTimeLabel(_status.xmitterTempFaultTime()));
    _ui.wgArcFaultTime->
        setText(_faultTimeLabel(_status.wgArcFaultTime()));
    _ui.collectorCurrFaultTime->
        setText(_faultTimeLabel(_status.collectorCurrFaultTime()));
    _ui.bodyCurrFaultTime->
        setText(_faultTimeLabel(_status.bodyCurrFaultTime()));
    _ui.filamentLorFaultTime->
        setText(_faultTimeLabel(_status.filamentLorFaultTime()));
    _ui.focusElectrodeLorFaultTime->
        setText(_faultTimeLabel(_status.focusElectrodeLorFaultTime()));
    _ui.cathodeLorFaultTime->
        setText(_faultTimeLabel(_status.cathodeLorFaultTime()));
    _ui.inverterOverloadFaultTime->
        setText(_faultTimeLabel(_status.inverterOverloadFaultTime()));
    _ui.extInterlockFaultTime->
        setText(_faultTimeLabel(_status.extInterlockFaultTime()));
    _ui.eikInterlockFaultTime->
        setText(_faultTimeLabel(_status.eikInterlockFaultTime()));
    
    QString txt;
    // Text displays for voltage, currents, and temperature
    txt.setNum(_status.cathodeVoltage(), 'f', 1);
    _ui.cathodeVoltageValue->setText(txt);
    
    txt.setNum(_status.collectorCurrent(), 'f', 1);
    _ui.collectorCurrentValue->setText(txt);
    
    txt.setNum(_status.bodyCurrent(), 'f', 1);
    _ui.bodyCurrentValue->setText(txt);
    
    txt.setNum(_status.xmitterTemperature(), 'f', 1);
    _ui.xmitterTempValue->setText(txt);
    
//    // enable/disable buttons
//    if (_status.serialConnected() && _status.rs232CtlEnabled()) {
//        if (_status.faultSummary()) {
//            _ui.standbyButton->setEnabled(true);
//            _ui.operateButton->setEnabled(false);
//        } else {
//            _ui.standbyButton->setEnabled(_status.hvpsRunup() && ! _status.heaterWarmup());
//            _ui.operateButton->setEnabled(! _status.filamentDelayActive() && ! _status.heaterWarmup());
//        }
//    } else {
//        _ui.standbyButton->setEnabled(false);
//        _ui.operateButton->setEnabled(false);
//    }
    
    if (_status.rs232CtlEnabled()) {
        statusBar()->clearMessage();
    } else {
        statusBar()->showMessage("RS-232 control is currently DISABLED");
    }
}

void
HcrXmitCtlMainWindow::_noDaemon() {
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
HcrXmitCtlMainWindow::_noXmitter() {
    statusBar()->showMessage("No serial connection from hcr_xmitd to xmitter!");
    _disableUi();
}

void
HcrXmitCtlMainWindow::_disableUi() {
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
HcrXmitCtlMainWindow::_enableUi() {
    _ui.xmitterFaultDetailsBox->setEnabled(true);
    _ui.statusBox->setEnabled(true);
    _ui.xmitterStartBox->setEnabled(true);
}

void
HcrXmitCtlMainWindow::_logMessage(std::string message) {
    _ui.logArea->appendPlainText(
            QDateTime::currentDateTime().toUTC().toString("yyyy-MM-dd hh:mm:ss ") + 
            message.c_str());
}

QString
HcrXmitCtlMainWindow::_countLabel(int count) {
    if (count == 0)
        return QString("-");

    QString txt;
    txt.setNum(count);
    return txt;
}

QString
HcrXmitCtlMainWindow::_faultTimeLabel(time_t time) {
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
