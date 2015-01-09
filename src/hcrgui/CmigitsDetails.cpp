/*
 * CmigitsDetails.cpp
 *
 *  Created on: Aug 29, 2012
 *      Author: burghart
 */
#include "CmigitsDetails.h"
#include <QDateTime>
#include <Cmigits.h>

CmigitsDetails::CmigitsDetails(QWidget *parent) :
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
CmigitsDetails::updateStatus(bool daemonResponding,
        const CmigitsStatus & status) {
    // Based on whether the daemon is responding, set the "daemon responding"
    // label, and set the enabled state for the rest of the components.
    _ui.daemonRespondingLabel->setText(daemonResponding ?
            "" : "<font color='DarkRed'>No CmigitsDaemon!</font>");
    _ui.infoFrame->setEnabled(daemonResponding);

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
