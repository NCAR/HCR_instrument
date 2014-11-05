/*
 * HcrMonitorDetails.cpp
 *
 *  Created on: Nov 5, 2014
 *      Author: burghart
 */
#include "HcrMonitorDetails.h"
#include <QDateTime>
#include <sstream>
#include <iomanip>

static inline double MetersToFeet(double m) {
    return(3.28084 * m);
}

HcrMonitorDetails::HcrMonitorDetails(QWidget *parent) :
    QDialog(parent),
    _ui(),
    _redLED(":/redLED.png"),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png") {
    // Set up the UI and get the current status
    _ui.setupUi(this);
    updateStatus(false, HcrMonitorStatus(), HcrPmc730Status(true));
}

void
HcrMonitorDetails::updateStatus(bool daemonResponding,
        const HcrMonitorStatus & hcrMonitorStatus, 
        const HcrPmc730Status & hcrPmc730Status) {
    // Based on whether the daemon is responding and the FireFly-IIA is
    // responding to the daemon, set the "responding" label, and set the
    // enabled state for the rest of the components.
    if (daemonResponding) {
        _ui.respondingLabel->setText("");
        _ui.statusFrame->setEnabled(true);
    } else {
        _ui.respondingLabel->setText("<font color='DarkRed'>No HcrMonitor!</font>");
        _ui.statusFrame->setEnabled(false);
    }

    // Now fill in the rest from the status we received
    _ui.hcrPmc730Icon->setPixmap(hcrMonitorStatus.hcrPmc730Responsive() ? _greenLED : _redLED);
    _ui.motionControlIcon->setPixmap(hcrMonitorStatus.motionControlResponsive() ? _greenLED : _redLED);
    _ui.cmigitsIcon->setPixmap(hcrMonitorStatus.cmigitsResponsive() ? _greenLED : _redLED);
    _ui.terrainHtIcon->setPixmap(hcrMonitorStatus.terrainHtServerResponsive() ? _greenLED : _redLED);
    
    std::string requestedModeName = HcrPmc730::HmcModeNames[hcrMonitorStatus.requestedHmcMode()];
    _ui.requestedModeValue->setText(QString::fromStdString(requestedModeName));
    std::string currentModeName = HcrPmc730::HmcModeNames[hcrPmc730Status.hmcMode()];
    _ui.currentModeValue->setText(QString::fromStdString(currentModeName));
    
    int mslAltFt = int(MetersToFeet(hcrMonitorStatus.mslAltitude()));
    _ui.altitudeMslLabel->setText(QString::number(mslAltFt));
    
    int aglAltFt = int(MetersToFeet(hcrMonitorStatus.aglAltitude()));
    _ui.altitudeMslLabel->setText(QString::number(aglAltFt));
    
    _ui.surfaceValue->setText(hcrMonitorStatus.overWater() ? "water" : "land");
    
    bool attenuationRequired = hcrMonitorStatus.attenuationRequired();
    _ui.attenuationRequiredIcon->setPixmap(attenuationRequired ? _amberLED : _greenLED_off);
    
    bool hvRequested = hcrMonitorStatus.hvRequested();
    _ui.hvRequestedIcon->setPixmap(hvRequested ? _greenLED : _greenLED_off);
    
    bool hvOn = hcrPmc730Status.rdsXmitterHvOn();
    _ui.hvOnIcon->setPixmap(hvOn ? _greenLED : _greenLED_off);
    
    std::string testStatusText = hcrMonitorStatus.xmitAllowedStatusText();
    _ui.testStatusText->setText(QString::fromStdString(testStatusText));
}
