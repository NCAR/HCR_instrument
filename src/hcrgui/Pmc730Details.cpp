/*
 * Pmc730Details.cpp
 *
 *  Created on: Aug 29, 2012
 *      Author: burghart
 */
#include "Pmc730Details.h"
#include <QDateTime>

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
    updateStatus(false, HcrPmc730Status(true));
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
    _ui.hmcModeValue->setText(HcrPmc730::HmcModeNames[status.hmcMode()].c_str());
    
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
    _ui.cmigitsTempValue->
        setText(QString::number(status.cmigitsTemp(), 'f', 1));
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
