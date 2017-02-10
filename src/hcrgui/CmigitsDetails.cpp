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
 * CmigitsDetails.cpp
 *
 *  Created on: Aug 29, 2012
 *      Author: burghart
 */
#include "CmigitsDetails.h"
#include <QDateTime>
#include <Cmigits.h>

CmigitsDetails::CmigitsDetails(QWidget *parent, const QString & title) :
    QDialog(parent),
    _ui(),
    _redLED(":/redLED.png"),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png") {
    // Set up the UI
    _ui.setupUi(this);
    if (! title.isNull()) {
        setWindowTitle(title);
    }
    // Initialize to no status available
    noStatus();
}

void
CmigitsDetails::updateStatus(bool daemonResponding,
        const CmigitsStatus & status) {
    // Based on whether the daemon is responding, set the "daemon responding"
    // label, and set the enabled state for the rest of the components.
    _ui.daemonRespondingLabel->setText(daemonResponding ?
            "" : "<font color='DarkRed'>No CmigitsDaemon!</font>");
    _ui.infoFrame->setEnabled(daemonResponding);

    // INS model name
    _ui.insModelValue->setText(status.insModelName().c_str());

    double statusTime = 0.0;
    uint16_t currentMode = 0;
    bool insAvailable = false;
    bool gpsAvailable = false;
    bool doingCoarseAlignment = false;
    uint16_t nSats = 0;
    uint16_t positionFOM = 0;
    uint16_t velocityFOM = 0;
    uint16_t headingFOM = 0;
    uint16_t timeFOM = 0;
    double expectedHPosError = 0.0;
    double expectedVPosError = 0.0;
    double expectedVelocityError = 0.0;
    status.msg3500Data(statusTime, currentMode, insAvailable,
            gpsAvailable, doingCoarseAlignment, nSats, 
            positionFOM, velocityFOM, headingFOM, timeFOM,
            expectedHPosError, expectedVPosError, expectedVelocityError);
    _ui.statusTimeValue->setText(QDateTime::fromTime_t(uint32_t(statusTime)).toUTC().toString("hh:mm:ss"));
    _ui.insValue->setPixmap(insAvailable ? _greenLED : _redLED);
    _ui.gpsValue->setPixmap(gpsAvailable ? _greenLED : _redLED);
    _ui.coarsAlignValue->setPixmap(doingCoarseAlignment ? _amberLED : _greenLED_off);
    // Green light for mode 7 or 8 (air or land navigation), amber for
    // anything else
    _ui.currentModeIcon->setPixmap((currentMode == 7 || currentMode == 8) ?
            _greenLED : _amberLED);
    _ui.currentModeValue->setText(Cmigits::ModeName(currentMode).c_str());
    _ui.satCountValue->setText(QString::number(nSats));
    _ui.positionFOMValue->setText(Cmigits::PositionFOMString(positionFOM).c_str());
    _ui.velocityFOMValue->setText(Cmigits::VelocityFOMString(velocityFOM).c_str());
    _ui.headingFOMValue->setText(Cmigits::HeadingFOMString(headingFOM).c_str());
    _ui.timeFOMValue->setText(QString::fromUtf8(Cmigits::TimeFOMString(timeFOM).c_str()));

    // Disable (gray out) the navigation solution and attitude boxes if
    // current mode is not "Air Navigation" or "Land Navigation".
    bool enableBoxes = (currentMode == 7 || currentMode == 8);
    _ui.navSolutionBox->setEnabled(enableBoxes);
    _ui.attitudeBox->setEnabled(enableBoxes);

    double navSolutionTime = 0.0;
    double latitude = 0.0;
    double longitude = 0.0;
    double altitude = 0.0;
    double velNorth = 0.0;
    double velEast = 0.0;
    double velUp = 0.0;
    status.msg3501Data(navSolutionTime, latitude, longitude, altitude);
    _ui.navSolutionTimeValue->setText(QDateTime::fromTime_t(uint32_t(navSolutionTime)).toUTC().toString("hh:mm:ss"));
    _ui.latitudeValue->setText(QString::number(latitude, 'f', 4));
    _ui.longitudeValue->setText(QString::number(longitude, 'f', 4));
    _ui.altitudeValue->setText(QString::number(altitude, 'f', 0));

    double attitudeTime = 0.0;
    double pitch = 0.0;
    double roll = 0.0;
    double heading = 0.0;
    status.msg3512Data(attitudeTime, pitch, roll, heading, velNorth, velEast, 
            velUp);
    _ui.attitudeTimeValue->setText(QDateTime::fromTime_t(uint32_t(attitudeTime)).toUTC().toString("hh:mm:ss"));
    _ui.pitchValue->setText(QString::number(pitch, 'f', 2));
    _ui.rollValue->setText(QString::number(roll, 'f', 2));
    _ui.headingValue->setText(QString::number(heading, 'f', 1));
    _ui.velNorthValue->setText(QString::number(velNorth, 'f', 1));
    _ui.velEastValue->setText(QString::number(velEast, 'f', 1));
    _ui.velUpValue->setText(QString::number(velUp, 'f', 2));
}

void
CmigitsDetails::noStatus() {
    _ui.insValue->setPixmap(_greenLED_off);
    _ui.gpsValue->setPixmap(_greenLED_off);
}
