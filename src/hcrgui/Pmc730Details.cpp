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
 * Pmc730Details.cpp
 *
 *  Created on: Aug 29, 2012
 *      Author: burghart
 */
#include "Pmc730Details.h"
#include <QtCore/QDateTime>

// Convert pressure in hPa to PSI
static double
HpaToPsi(double presHpa) {
    return(0.0145037738 * presHpa);
}

Pmc730Details::Pmc730Details(QWidget *parent) :
    QDialog(parent),
    _ui(),
    _redLED(":/redLED.png"),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png") {
    // Set up the UI and get the current status
    _ui.setupUi(this);
    // Initialize with no daemon response and default/bad status
    updateStatus(false, HcrPmc730Status());
}

void
Pmc730Details::updateStatus(bool daemonResponding,
        const HcrPmc730Status & status) {
    // Disable the status boxes if the daemon is not responding
    _ui.mainBox->setEnabled(daemonResponding);
    _ui.hmcModeBox->setEnabled(daemonResponding);

    // Set status label
    if (daemonResponding) {
        _ui.daemonRespondingLabel->setText(QString("Status updated ") +
                QDateTime::currentDateTime().toUTC().toString("HH:mm:ss"));
    } else {
        _ui.daemonRespondingLabel->setText("<font color='DarkRed'>No HcrPmc730Daemon!</font>");
    }
    _warnState = false;
    _errState = false;
    
    // HMC mode
    auto hmcModeString = toString(status.hmcMode()) + " (HMC mode " +
            std::to_string(static_cast<int>(status.hmcMode())) + ")";
    _ui.hmcModeValue->setText(hmcModeString.c_str());

    // temperatures
    _ui.ploTempValue->setText(QString::number(status.ploTemp(), 'f', 1));
    _ui.eikTempValue->setText(QString::number(status.eikTemp(), 'f', 1));
    _ui.hLnaTempValue->setText(QString::number(status.hLnaTemp(), 'f', 1));
    _ui.vLnaTempValue->setText(QString::number(status.vLnaTemp(), 'f', 1));
    _ui.polSwitchTempValue->
        setText(QString::number(status.polarizationSwitchTemp(), 'f', 1));
    _ui.rfDetectorTempValue->
        setText(QString::number(status.rfDetectorTemp(), 'f', 1));
    _ui.noiseSourceTempValue->
        setText(QString::number(status.noiseSourceTemp(), 'f', 1));
    _ui.ps28VTempValue->setText(QString::number(status.ps28VTemp(), 'f', 1));
    _ui.rdsDuctTempValue->
        setText(QString::number(status.rdsInDuctTemp(), 'f', 1));
    _ui.rotMotorTempValue->
        setText(QString::number(status.rotationMotorTemp(), 'f', 1));
    _ui.tiltMotorTempValue->
        setText(QString::number(status.tiltMotorTemp(), 'f', 1));
    _ui.insTempValue->
        setText(QString::number(status.insTemp(), 'f', 1));
    _ui.tailconeTempValue->
        setText(QString::number(status.tailconeTemp(), 'f', 1));
    
    // errors
    if (status.radarPowerError()) {
        _errState = true;
        _ui.radarPowerErrorIcon->setPixmap(_redLED);
    } else {
        _ui.radarPowerErrorIcon->setPixmap(_greenLED_off);
    }
    
    if (status.waveguideSwitchError()) {
        _errState = true;
        _ui.wgSwitchErrorIcon->setPixmap(_redLED);
    } else {
        _ui.wgSwitchErrorIcon->setPixmap(_greenLED_off);
    }
    
    if (status.emsError1()) {
        _errState = true;
        _ui.emsError1Icon->setPixmap(_redLED);
    } else {
        _ui.emsError1Icon->setPixmap(_greenLED_off);
    }
    
    if (status.emsError2()) {
        _errState = true;
        _ui.emsError2Icon->setPixmap(_redLED);
    } else {
        _ui.emsError2Icon->setPixmap(_greenLED_off);
    }
    
    if (status.emsError3()) {
        _errState = true;
        _ui.emsError3Icon->setPixmap(_redLED);
    } else {
        _ui.emsError3Icon->setPixmap(_greenLED_off);
    }
    
    if (status.emsError4Or5()) {
        _errState = true;
        _ui.emsError4Or5Icon->setPixmap(_redLED);
    } else {
        _ui.emsError4Or5Icon->setPixmap(_greenLED_off);
    }
    
    if (status.emsError6Or7()) {
        _errState = true;
        _ui.emsError6Or7Icon->setPixmap(_redLED);
    } else {
        _ui.emsError6Or7Icon->setPixmap(_greenLED_off);
    }
    
    if (status.emsPowerError()) {
        _errState = true;
        _ui.emsPowerErrorIcon->setPixmap(_redLED);
    } else {
        _ui.emsPowerErrorIcon->setPixmap(_greenLED_off);
    }
    
    _ui.emsErrorCountValue->setText(QString::number(status.emsErrorCount()));
    
    // Active Pressurization System
    double highSidePresPsi = HpaToPsi(status.apsHighSidePressure());
    _ui.highSideValue->setText(QString::number(highSidePresPsi, 'f', 0));
    double lowSidePresPsi = HpaToPsi(status.apsLowSidePressure());
    _ui.lowSideValue->setText(QString::number(lowSidePresPsi, 'f', 1));
    _ui.pressurizingIcon->setPixmap(status.apsValveOpen() ?
            _greenLED : _greenLED_off);

    // miscellaneous
    if (status.locked125MHzPLO()) {
        _ui.locked125MHzIcon->setPixmap(_greenLED);
    } else {
        _errState = true;
        _ui.locked125MHzIcon->setPixmap(_redLED);
    }
    
    if (status.locked1250MHzPLO()) {
        _ui.locked1250MHzIcon->setPixmap(_greenLED);
    } else {
        _errState = true;
        _ui.locked1250MHzIcon->setPixmap(_redLED);
    }
    
    if (status.locked15_5GHzPLO()) {
        _ui.locked15_5GHzIcon->setPixmap(_greenLED);
    } else {
        _errState = true;
        _ui.locked15_5GHzIcon->setPixmap(_redLED);
    }
    
    _ui.filamentOnIcon->setPixmap(status.rdsXmitterFilamentOn() ?
            _greenLED : _greenLED_off);
    
    _ui.hvOnIcon->setPixmap(status.rdsXmitterHvOn() ?
            _greenLED : _greenLED_off);
    
    _ui.modPulseDisabledIcon->setPixmap(status.modPulseDisabled() ?
            _greenLED : _greenLED_off);
    
    _ui.rfPowerValue->setText(QString::number(status.detectedRfPower(), 'f', 1));
    
    double aftPresPsi = HpaToPsi(status.pvAftPressure());
    _ui.vesselPresAftValue->
        setText(QString::number(aftPresPsi, 'f', 1));
    double forePresPsi = HpaToPsi(status.pvForePressure());
    _ui.vesselPresForeValue->
        setText(QString::number(forePresPsi, 'f', 1));
    _ui.psVoltageValue->setText(QString::number(status.psVoltage(), 'f', 2));
}
