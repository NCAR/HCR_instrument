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
 * SpatialFogDetails.cpp
 *
 *  Created on: Aug 10, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */
#include "SpatialFogDetails.h"
#include <string>
#include <QDateTime>
#include <SpatialFogStatus.h>

SpatialFogDetails::SpatialFogDetails(QWidget *parent) :
    QDialog(parent),
    _ui(),
    _redLED(":/redLED.png"),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png") {
    // Set up the UI and get the current status
    _ui.setupUi(this);
    // Initialize to no status available
    noStatus();
}

void
SpatialFogDetails::updateStatus(bool daemonResponding,
        const SpatialFogStatus & status) {
    // Based on whether the daemon is responding, set the "daemon responding"
    // label, and set the enabled state for the rest of the components.
    _ui.daemonRespondingLabel->setText(daemonResponding ?
            "" : "<font color='DarkRed'>No SpatialFogDaemon!</font>");
    _ui.stateBox->setEnabled(daemonResponding);
    _ui.dataBox->setEnabled(daemonResponding);

    // Info from the system status bits
    _ui.statusTimeValue->setText(
            QDateTime::fromMSecsSinceEpoch(status.statusTime).toUTC().toString("hh:mm:ss.zzz"));
    _ui.systemFailureLed->setPixmap(
            status.systemFailureBit() ? _redLED : _greenLED_off);
    _ui.accelerometerFailureLed->setPixmap(
            status.accelerometerFailureBit() ? _redLED : _greenLED_off);
    _ui.gyroscopeFailureLed->setPixmap(
            status.gyroscopeFailureBit() ? _redLED : _greenLED_off);
    _ui.magnetometerFailureLed->setPixmap(
            status.magnetometerFailureBit() ? _redLED : _greenLED_off);
    _ui.pressureSensorFailureLed->setPixmap(
            status.pressureFailureBit() ? _redLED : _greenLED_off);
    _ui.gnssFailureLed->setPixmap(
            status.gnssFailureBit() ? _redLED : _greenLED_off);
    _ui.accelerometerOverRangeLed->setPixmap(
            status.accelerometerOverRangeBit() ? _redLED : _greenLED_off);
    _ui.gyroscopeOverRangeLed->setPixmap(
            status.gyroscopeOverRangeBit() ? _redLED : _greenLED_off);
    _ui.magnetometerOverRangeLed->setPixmap(
            status.magnetometerOverRangeBit() ? _redLED : _greenLED_off);
    _ui.pressureOverRangeLed->setPixmap(
            status.pressureOverRangeBit() ? _redLED : _greenLED_off);
    _ui.minTempAlarmLed->setPixmap(
            status.minTempAlarmBit() ? _redLED : _greenLED_off);
    _ui.maxTempAlarmLed->setPixmap(
            status.maxTempAlarmBit() ? _redLED : _greenLED_off);
    _ui.lowVoltageAlarmLed->setPixmap(
            status.lowVoltageAlarmBit() ? _redLED : _greenLED_off);
    _ui.highVoltageAlarmLed->setPixmap(
            status.highVoltageAlarmBit() ? _redLED : _greenLED_off);
    _ui.gnssAntennaDisconnectLed->setPixmap(
            status.gnssAntennaDisconnectedBit() ? _redLED : _greenLED_off);
    _ui.dataOutputOverflowLed->setPixmap(
            status.dataOutputOverflowBit() ? _redLED : _greenLED_off);

    // Info from the filter status bits
    _ui.orientationInitializedLed->setPixmap(
            status.orientationFilterInitialized() ? _greenLED : _greenLED_off);
    _ui.navigationInitializedLed->setPixmap(
            status.navigationFilterInitialized() ? _greenLED : _greenLED_off);
    _ui.headingInitializedLed->setPixmap(
            status.headingInitialized() ? _greenLED : _greenLED_off);
    _ui.utcTimeInitializedLed->setPixmap(
            status.utcTimeInitialized() ? _greenLED : _greenLED_off);
    // Red light for no GNSS fix, amber for 2D fix, and green for
    // anything above that.
    QPixmap & led(_redLED);
    if (status.gnssFixValue() == 1) {
        led = _amberLED;
    } else if (status.gnssFixValue() > 1) {
        led = _greenLED;
    }
    _ui.gnssFixLed->setPixmap(led);
    _ui.gnssFixDescription->setText(status.gnssFixText());
    _ui.event1OccurredLed->setPixmap(
            status.event1Occurred() ? _greenLED : _greenLED_off);
    _ui.event2OccurredLed->setPixmap(
            status.event2Occurred() ? _greenLED : _greenLED_off);
    _ui.internalGnssEnabledLed->setPixmap(
            status.internalGnssEnabled() ? _greenLED : _greenLED_off);
    _ui.dualAntHeadingActiveLed->setPixmap(
            status.dualAntennaHeadingActive() ? _greenLED : _greenLED_off);
    _ui.velocityHeadingEnabledLed->setPixmap(
            status.velocityHeadingEnabled() ? _greenLED : _greenLED_off);
    _ui.atmosphericAltEnabledLed->setPixmap(
            status.atmosphericAltitudeEnabled() ? _greenLED : _greenLED_off);
    _ui.externalPositionActiveLed->setPixmap(
            status.externalPositionActive() ? _greenLED : _greenLED_off);
    _ui.externalVelocityActiveLed->setPixmap(
            status.externalVelocityActive() ? _greenLED : _greenLED_off);
    _ui.externalHeadingActiveLed->setPixmap(
            status.externalHeadingActive() ? _greenLED : _greenLED_off);

    // Disable (gray out) the navigation solution and attitude boxes if
    // we have at least a 2D GNSS fix.
    bool enableBoxes = (status.gnssFixValue() > 0);
    _ui.navSolutionBox->setEnabled(enableBoxes);
    _ui.attitudeBox->setEnabled(enableBoxes);

    _ui.navSolutionTimeValue->setText(
            QDateTime::fromMSecsSinceEpoch(status.positionTime).toUTC().toString("hh:mm:ss.zzz"));
    _ui.latitudeValue->setText(QString::number(status.latitude, 'f', 4));
    _ui.longitudeValue->setText(QString::number(status.longitude, 'f', 4));
    _ui.altitudeValue->setText(QString::number(status.altitude, 'f', 0));

    _ui.attitudeTimeValue->setText(
            QDateTime::fromMSecsSinceEpoch(status.attitudeTime).toUTC().toString("hh:mm:ss.zzz"));
    _ui.pitchValue->setText(QString::number(status.pitch, 'f', 2));
    _ui.rollValue->setText(QString::number(status.roll, 'f', 2));
    _ui.headingValue->setText(QString::number(status.heading, 'f', 1));
    _ui.velNorthValue->setText(QString::number(status.velNorth, 'f', 1));
    _ui.velEastValue->setText(QString::number(status.velEast, 'f', 1));
    _ui.velUpValue->setText(QString::number(status.velUp, 'f', 2));
}

void
SpatialFogDetails::noStatus() {
    updateStatus(false, SpatialFogStatus());
}
