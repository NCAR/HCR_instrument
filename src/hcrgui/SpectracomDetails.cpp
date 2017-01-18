// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2017
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
 * SpectracomDetails.cpp
 *
 *  Created on: Jan 5, 2017
 *      Author: Chris Burghart <burghart@ucar.edu>
 */
#include "SpectracomDetails.h"
#include <sstream>
#include <QtCore/QDateTime>

SpectracomDetails::SpectracomDetails(QWidget *parent) :
    QDialog(parent),
    _redLED(":/redLED.png"),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png"),
    _ui() {
    // Set up the UI and get the current status
    _ui.setupUi(this);
    // Initialize to no status available
    _noStatus();
}

void
SpectracomDetails::updateStatus(bool daemonResponding,
		const SpectracomStatus & status) {
    // Time of general status report
    QDateTime qTime = QDateTime::fromTime_t(time_t(status.statusTime())).toUTC();

    // Based on whether the daemon is responding, set the "daemon responding"
    // label, and set the enabled state for the rest of the components.
    QString daemonText;
    if (daemonResponding) {
        daemonText.append("Spectracom status at ");
        daemonText.append(qTime.toString("yyyy-MM-dd hh:mm:ss"));
    } else {
        daemonText.append("<font color='DarkRed'>");
        daemonText.append("No daemon response at ");
        daemonText.append(qTime.toString("yyyy-MM-dd hh:mm:ss"));
        daemonText.append("</font>");
    }
    _ui.daemonRespondingLabel->setText(daemonText);
    _ui.statusFrame->setEnabled(daemonResponding);


    // Synchronized?
    _ui.synchronizedIcon->setPixmap(_ledForSimpleStatus(status.syncSimpleStatus()));

    // Alarm state icon: red if major alarm, amber if minor alarm, green if
    // no alarm
    _ui.alarmsIcon->setPixmap(_ledForSimpleStatus(status.alarmsSimpleStatus()));
    if (status.majorAlarm()) {
        _ui.alarmsSeverityValue->setText(status.minorAlarm() ? "Major + Minor" : "Major");
    } else if (status.minorAlarm()) {
        _ui.alarmsSeverityValue->setText("Minor");
    } else {
        _ui.alarmsSeverityValue->setText("None");
    }

    // List alarms named in the last alarms report
    _ui.alarmsList->setText(QString::fromStdString(status.alarmList()));

    // NTP stratum
    _ui.ntpStratumValue->setText(QString::number(status.ntpStratum()));

    // time reference
    _ui.timeReferenceValue->setText(QString::fromStdString(status.timeReference()));

    // 1PPS reference
    _ui.ppsReferenceValue->setText(QString::fromStdString(status.ppsReference()));

    // time figure of merit (TFOM)
    _ui.tfomIcon->setPixmap(_ledForSimpleStatus(status.tfomSimpleStatus()));
    std::ostringstream oss;
    oss << status.tfom() << "/" << status.maxTfom();
    _ui.tfomValue->setText(QString::fromStdString(oss.str()));

    // oscillator state icon and text
    // green icon if oscillator state is "Trk/Lock", otherwise amber
    _ui.oscStateIcon->setPixmap(_ledForSimpleStatus(status.oscSimpleStatus()));
    _ui.oscStateValue->setText(QString::fromStdString(status.oscState()));

    // oscillator type
    _ui.oscTypeValue->setText(QString::fromStdString(status.oscType()));

    // oscillator discipline report time
    qTime = QDateTime::fromTime_t(time_t(status.disciplineTime())).toUTC();
    _ui.oscDisciplineTimeValue->setText(qTime.toString("yyyy-MM-dd hh:mm:ss"));

    // oscillator discipline report: frequency error, Hz
    _ui.oscFreqErrorValue->setText(QString::number(status.freqErr(), 'e', 1) +
                                   " Hz");

    // oscillator discipline report: 1PPS phase error, ns
    _ui.oscPpsPhaseErrorValue->setText(QString::number(status.ppsPhaseErr()) +
                                       " ns");

    // discipline report: oscillator temperature, deg C
    _ui.oscTempValue->setText(QString::number(status.oscTemp(), 'f', 1) +
                              " deg C");

    // oscillator discipline report: DAC value
    _ui.oscDacValue->setText(QString::number(status.dacValue()));
}

void
SpectracomDetails::_noStatus() {
    _ui.daemonRespondingLabel->setText(
            "<font color='DarkRed'>No daemon response!</font>");
    _ui.statusFrame->setEnabled(false);
    _ui.synchronizedIcon->setPixmap(_greenLED_off);
    _ui.alarmsIcon->setPixmap(_greenLED_off);
    _ui.alarmsList->setText("--");
    _ui.ntpStratumValue->setText("--");
    _ui.timeReferenceValue->setText("--");
    _ui.ppsReferenceValue->setText("--");
    _ui.tfomValue->setText("-/-");
    _ui.oscStateIcon->setPixmap(_greenLED_off);
    _ui.oscStateValue->setText("--");
    _ui.oscTypeValue->setText("--");
    _ui.oscDisciplineTimeValue->setText("0000-00-00 00:00:00");
    _ui.oscFreqErrorValue->setText("-- Hz");
    _ui.oscPpsPhaseErrorValue->setText("-- ns");
    _ui.oscTempValue->setText("-- deg C");
    _ui.oscDacValue->setText("--");
}
