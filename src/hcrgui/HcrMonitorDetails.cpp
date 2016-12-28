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

HcrMonitorDetails::HcrMonitorDetails(QWidget *parent, 
        std::string hcrMonitorHost, int hcrMonitorPort) :
    QDialog(parent),
    _ui(),
    _rpcClient(hcrMonitorHost, hcrMonitorPort),
    _redLED(":/redLED.png"),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png") {
    // Set up the UI and get the current status
    _ui.setupUi(this);
    updateStatus(false, HcrMonitorStatus(), HcrPmc730Status(true));
    
    // Populate the APS ValveControlState mode combo box
    for (int i = 0; i < ApsControl::VALVE_CONTROL_NSTATES; i++) {
        _ui.apsValveControlCombo->insertItem(i, ApsControl::ValveControlStateNames[i].c_str(), i);
    }
}

void
HcrMonitorDetails::on_apsValveControlCombo_activated(int index) {
    // Tell HcrMonitor to use the selected valve control state
    _rpcClient.setApsValveControl(static_cast<ApsControl::ValveControlState>(index));
}

void
HcrMonitorDetails::updateStatus(bool daemonResponding,
        const HcrMonitorStatus & hcrMonitorStatus, 
        const HcrPmc730Status & hcrPmc730Status) {
    // Based on whether the daemon is responding, set the "responding" label, 
    // and set the enabled state for the rest of the contents.
    _ui.contentFrame->setEnabled(daemonResponding);
    _ui.respondingLabel->setText(daemonResponding ? 
            "" : "<font color='DarkRed'>No HcrMonitor!</font>");
    
    // ApsControl status
    
    // APS valve control state
    _ui.apsValveControlCombo->setCurrentIndex(hcrMonitorStatus.apsValveControlState());
    
    // APS status text
    _ui.apsStatusText->setText(hcrMonitorStatus.apsStatusText().c_str());

    // TransmitControl altitudes and surface type
    int mslAltFt = int(MetersToFeet(hcrMonitorStatus.mslAltitude()));
    _ui.altitudeMslValue->setText(QString::number(mslAltFt));
    
    int aglAltFt = int(MetersToFeet(hcrMonitorStatus.aglAltitude()));
    _ui.altitudeAglValue->setText(QString::number(aglAltFt));
    
    _ui.surfaceValue->setText(hcrMonitorStatus.overWater() ? "Water" : "Land");
    
    // TransmitControl max received power. We avoid printing values greater
    // than 100 dBm, since numbers that scale and bigger are not realistic,
    // and we don't want to print the HUGE values returned by the MaxPower
    // server before data with real numbers are available.
    double maxPower = hcrMonitorStatus.meanMaxPower();
    _ui.maxPowerValue->setText((maxPower < 100.0) ?
            QString::number(maxPower, 'f', 1) : "HUGE");
    
    // TransmitControl attenuation required, HV requested
    _ui.attenuationRequiredIcon->setPixmap(hcrMonitorStatus.attenuationRequired() ? 
            _amberLED : _greenLED_off);
    
    bool hvRequested = hcrMonitorStatus.hvRequested();
    _ui.hvRequestedIcon->setPixmap(hvRequested ? _greenLED : _greenLED_off);
    
    // Actual state of HV on comes from HcrPmc730Daemon
    bool hvOn = hcrPmc730Status.rdsXmitterHvOn();
    _ui.hvOnIcon->setPixmap(hvOn ? _greenLED : _greenLED_off);
    
    // Requested and current HMC modes. Note that current HMC mode comes from
    // HcrPmc730Status and not from HcrMonitorStatus. Use emphasis background 
    // color if current mode differs from requested mode.
    HcrPmc730::HmcOperationMode requestedMode = hcrMonitorStatus.requestedHmcMode();
    std::string requestedModeName = HcrPmc730::HmcModeNames[requestedMode];
    _ui.requestedModeValue->setText(QString::fromStdString(requestedModeName));
    
    HcrPmc730::HmcOperationMode currentMode = hcrPmc730Status.hmcMode();
    std::string currentModeName = HcrPmc730::HmcModeNames[currentMode];
    _ui.currentModeValue->setText(currentModeName.c_str());

    std::string styleSheet = (currentMode == requestedMode) ? 
            "" : "background-color: #FFFFD0";
    _ui.requestedModeValue->setStyleSheet(styleSheet.c_str());
    _ui.currentModeValue->setStyleSheet(styleSheet.c_str());
    
    // Show the results of TransmitControl tests. Change background color of 
    // the box if transmit is not allowed or if attenuation is required.
    _ui.testResultText->setText(hcrMonitorStatus.xmitAllowedStatusText().c_str());
    
    styleSheet = "";
    if (! hcrMonitorStatus.transmitAllowed()) {
        // Transmit not allowed; make the background light pink
        styleSheet = "background-color: #FFD0D0";
    } else if (hcrMonitorStatus.attenuationRequired()) {
        // Attenuation required; make the background light yellow
        styleSheet = "background-color: #FFFFD0";
    }
    _ui.testResultText->setStyleSheet(styleSheet.c_str());
}
