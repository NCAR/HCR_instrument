/*
 * HcrGuiXmitStatusDialog.cpp
 *
 *  Created on: Aug 29, 2012
 *      Author: burghart
 */
#include "HcrGuiXmitStatusDialog.h"
#include <QDateTime>

HcrGuiXmitStatusDialog::HcrGuiXmitStatusDialog(QWidget *parent) :
    QDialog(parent),
    _ui(),
    _redLED(":/redLED.png"),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png") {
    _ui.setupUi(this);
}

void
HcrGuiXmitStatusDialog::updateStatus(const XmitdRpcClient::XmitStatus & xmitStatus) {
    // fault lights
    _ui.modulatorFaultIcon->
        setPixmap(xmitStatus.modulatorFault() ? _redLED : _greenLED);
    _ui.syncFaultIcon->
        setPixmap(xmitStatus.syncFault() ? _redLED : _greenLED);
    _ui.xmitterTempFaultIcon->
        setPixmap(xmitStatus.xmitterTempFault() ? _redLED : _greenLED);
    _ui.wgArcFaultIcon->
        setPixmap(xmitStatus.wgArcFault() ? _redLED : _greenLED);
    _ui.collectorCurrFaultIcon->
        setPixmap(xmitStatus.collectorCurrFault() ? _redLED : _greenLED);
    _ui.bodyCurrFaultIcon->
        setPixmap(xmitStatus.bodyCurrFault() ? _redLED : _greenLED);
    _ui.filamentLorFaultIcon->
        setPixmap(xmitStatus.filamentLorFault() ? _redLED : _greenLED);
    _ui.focusElectrodeLorFaultIcon->
        setPixmap(xmitStatus.focusElectrodeLorFault() ? _redLED : _greenLED);
    _ui.cathodeLorFaultIcon->
        setPixmap(xmitStatus.cathodeLorFault() ? _redLED : _greenLED);
    _ui.inverterOverloadFaultIcon->
        setPixmap(xmitStatus.inverterOverloadFault() ? _redLED : _greenLED);
    _ui.extInterlockFaultIcon->
        setPixmap(xmitStatus.extInterlockFault() ? _redLED : _greenLED);
    _ui.eikInterlockFaultIcon->
        setPixmap(xmitStatus.eikInterlockFault() ? _redLED : _greenLED);
    // fault counts
    _ui.modulatorFaultCount->
        setText(_countLabel(xmitStatus.modulatorFaultCount()));
    _ui.syncFaultCount->
        setText(_countLabel(xmitStatus.syncFaultCount()));
    _ui.xmitterTempFaultCount->
        setText(_countLabel(xmitStatus.xmitterTempFaultCount()));
    _ui.wgArcFaultCount->
        setText(_countLabel(xmitStatus.wgArcFaultCount()));
    _ui.collectorCurrFaultCount->
        setText(_countLabel(xmitStatus.collectorCurrFaultCount()));
    _ui.bodyCurrFaultCount->
        setText(_countLabel(xmitStatus.bodyCurrFaultCount()));
    _ui.filamentLorFaultCount->
        setText(_countLabel(xmitStatus.filamentLorFaultCount()));
    _ui.focusElectrodeLorFaultCount->
        setText(_countLabel(xmitStatus.focusElectrodeLorFaultCount()));
    _ui.cathodeLorFaultCount->
        setText(_countLabel(xmitStatus.cathodeLorFaultCount()));
    _ui.inverterOverloadFaultCount->
        setText(_countLabel(xmitStatus.inverterOverloadFaultCount()));
    _ui.extInterlockFaultCount->
        setText(_countLabel(xmitStatus.extInterlockFaultCount()));
    _ui.eikInterlockFaultCount->
        setText(_countLabel(xmitStatus.eikInterlockFaultCount()));

    // latest fault times
    _ui.modulatorFaultTime->
        setText(_faultTimeLabel(xmitStatus.modulatorFaultTime()));
    _ui.syncFaultTime->
        setText(_faultTimeLabel(xmitStatus.syncFaultTime()));
    _ui.xmitterTempFaultTime->
        setText(_faultTimeLabel(xmitStatus.xmitterTempFaultTime()));
    _ui.wgArcFaultTime->
        setText(_faultTimeLabel(xmitStatus.wgArcFaultTime()));
    _ui.collectorCurrFaultTime->
        setText(_faultTimeLabel(xmitStatus.collectorCurrFaultTime()));
    _ui.bodyCurrFaultTime->
        setText(_faultTimeLabel(xmitStatus.bodyCurrFaultTime()));
    _ui.filamentLorFaultTime->
        setText(_faultTimeLabel(xmitStatus.filamentLorFaultTime()));
    _ui.focusElectrodeLorFaultTime->
        setText(_faultTimeLabel(xmitStatus.focusElectrodeLorFaultTime()));
    _ui.cathodeLorFaultTime->
        setText(_faultTimeLabel(xmitStatus.cathodeLorFaultTime()));
    _ui.inverterOverloadFaultTime->
        setText(_faultTimeLabel(xmitStatus.inverterOverloadFaultTime()));
    _ui.extInterlockFaultTime->
        setText(_faultTimeLabel(xmitStatus.extInterlockFaultTime()));
    _ui.eikInterlockFaultTime->
        setText(_faultTimeLabel(xmitStatus.eikInterlockFaultTime()));

    QString txt;
    // Text displays for voltage, currents, and temperature
    txt.setNum(xmitStatus.cathodeVoltage(), 'f', 1);
    _ui.cathodeVoltageValue->setText(txt);

    txt.setNum(xmitStatus.collectorCurrent(), 'f', 1);
    _ui.collectorCurrentValue->setText(txt);

    txt.setNum(xmitStatus.bodyCurrent(), 'f', 1);
    _ui.bodyCurrentValue->setText(txt);

    txt.setNum(xmitStatus.xmitterTemperature(), 'f', 1);
    _ui.xmitterTempValue->setText(txt);
}

void
HcrGuiXmitStatusDialog::noStatus() {
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
QString
HcrGuiXmitStatusDialog::_countLabel(int count) {
    if (count == 0)
        return QString("-");

    QString txt;
    txt.setNum(count);
    return txt;
}

QString
HcrGuiXmitStatusDialog::_faultTimeLabel(time_t time) {
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