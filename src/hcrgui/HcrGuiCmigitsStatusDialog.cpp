/*
 * HcrGuiCmigitsStatusDialog.cpp
 *
 *  Created on: Aug 29, 2012
 *      Author: burghart
 */
#include "HcrGuiCmigitsStatusDialog.h"
#include <QDateTime>

HcrGuiCmigitsStatusDialog::HcrGuiCmigitsStatusDialog(QWidget *parent) :
    QDialog(parent),
    _ui(),
    _cmigitsShm(),
    _redLED(":/redLED.png"),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png"),
    _updateTimer() {
    // Set up the UI and get the current status
    _ui.setupUi(this);
    // Initialize to no status available
    noStatus();
    // Set up a timer to update the dialog every second
    _updateTimer.setInterval(1000); // 1000 ms
    connect(&_updateTimer, SIGNAL(timeout()), this, SLOT(updateStatus()));
    _updateTimer.start();
}

void
HcrGuiCmigitsStatusDialog::updateStatus(const DrxStatus & drxStatus) {
    double statusTime = 0.0;
    uint16_t currentMode = 0;
    bool insAvailable = false;
    bool gpsAvailable = false;
    uint16_t nSats = 0;
    uint16_t positionFOM = 0;
    uint16_t velocityFOM = 0;
    uint16_t headingFOM = 0;
    uint16_t timeFOM = 0;
    float expectedHPosError = 0.0;
    float expectedVPosError = 0.0;
    float expectedVelocityError = 0.0;
    drxStatus.cmigitsStatus(statusTime, currentMode, insAvailable,
            gpsAvailable, nSats, positionFOM, velocityFOM, headingFOM, timeFOM,
            expectedHPosError, expectedVPosError, expectedVelocityError);
    _ui.statusTimeValue->setText(QDateTime::fromTime_t(uint32_t(statusTime)).toUTC().toString("hh:mm:ss"));
    _ui.insValue->setPixmap(insAvailable ? _greenLED : _redLED);
    _ui.gpsValue->setPixmap(gpsAvailable ? _greenLED : _redLED);
    _ui.currentModeValue->setText(QString::number(currentMode));
    _ui.satCountValue->setText(QString::number(nSats));
    _ui.positionFOMValue->setText(QString::number(positionFOM));
    _ui.velocityFOMValue->setText(QString::number(velocityFOM));
    _ui.headingFOMValue->setText(QString::number(headingFOM));
    _ui.timeFOMValue->setText(QString::number(timeFOM));

    double navSolutionTime = 0.0;
    float latitude = 0.0;
    float longitude = 0.0;
    float altitude = 0.0;
    float velNorth = 0.0;
    float velEast = 0.0;
    float velUp = 0.0;
    drxStatus.cmigitsNavSolution(navSolutionTime, latitude, longitude, altitude,
            velNorth, velEast, velUp);
    _ui.navSolutionTimeValue->setText(QDateTime::fromTime_t(uint32_t(navSolutionTime)).toUTC().toString("hh:mm:ss"));
    _ui.latitudeValue->setText(QString::number(latitude, 'f', 4));
    _ui.longitudeValue->setText(QString::number(longitude, 'f', 4));
    _ui.altitudeValue->setText(QString::number(altitude, 'f', 0));
    _ui.velNorthValue->setText(QString::number(velNorth, 'f', 1));
    _ui.velEastValue->setText(QString::number(velEast, 'f', 1));
    _ui.velUpValue->setText(QString::number(velUp, 'f', 2));

    double attitudeTime = 0.0;
    float pitch = 0.0;
    float roll = 0.0;
    float heading = 0.0;
    drxStatus.cmigitsAttitude(attitudeTime, pitch, roll, heading);
    _ui.attitudeTimeValue->setText(QDateTime::fromTime_t(uint32_t(attitudeTime)).toUTC().toString("hh:mm:ss"));
    _ui.pitchValue->setText(QString::number(pitch, 'f', 1));
    _ui.rollValue->setText(QString::number(roll, 'f', 1));
    _ui.headingValue->setText(QString::number(heading, 'f', 1));
}

void
HcrGuiCmigitsStatusDialog::noStatus() {
    _ui.insValue->setPixmap(_greenLED_off);
    _ui.gpsValue->setPixmap(_greenLED_off);
}