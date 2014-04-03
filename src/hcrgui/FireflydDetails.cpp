/*
 * FireflydDetails.cpp
 *
 *  Created on: Apr 1, 2014
 *      Author: burghart
 */
#include "FireflydDetails.h"
#include <QDateTime>
#include <sstream>
#include <iomanip>

FireflydDetails::FireflydDetails(QWidget *parent) :
    QDialog(parent),
    _ui(),
    _redLED(":/redLED.png"),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png") {
    // Set up the UI and get the current status
    _ui.setupUi(this);
    updateStatus(false, FireFlyStatus());
}

void
FireflydDetails::updateStatus(bool daemonResponding,
        const FireFlyStatus & status) {
    // Based on whether the daemon is responding and the FireFly-IIA is
    // responding to the daemon, set the "responding" label, and set the
    // enabled state for the rest of the components.
    if (daemonResponding && status.deviceResponding()) {
        _ui.respondingLabel->setText("");
        _ui.statusFrame->setEnabled(true);
    } else {
        if (daemonResponding) {
            _ui.respondingLabel->setText("<font color='DarkRed'>"
                    "FireFly-IIA not responding to fireflyd!</font>");
        } else {
            _ui.respondingLabel->setText("<font color='DarkRed'>"
                    "No fireflyd!</font>");
        }
        _ui.statusFrame->setEnabled(false);
    }

    // Now fill in the rest from the status we received

    // Status time
    _ui.statusTimeLabel->setText(QDateTime::fromTime_t(uint32_t(status.statusTime())).toUTC().toString("hh:mm:ss"));
    _ui.pllLockIcon->setPixmap(status.pllLocked() ? _greenLED : _redLED);

    std::ostringstream ss;
    ss << "1 PPS offset from GPS: " <<
            std::scientific << std::setprecision(2) <<
            status.timeDiff1PPS() << " s";
    _ui.timeDiff1PpsLabel->setText(ss.str().c_str());

    // Holdover info
    _ui.holdoverIcon->setPixmap(status.inHoldover() ? _amberLED : _greenLED_off);

    ss.str("");
    ss << "Last holdover duration: " << status.lastHoldoverDuration() << " s";
    _ui.lastHoldoverTimeLabel->setText(ss.str().c_str());

    // Frequency error estimate
    ss.str("");
    ss << "Frequency error estimate: " <<
            std::scientific << std::setprecision(2) <<
            status.freqErrorEstimate();
    _ui.freqErrorLabel->setText(ss.str().c_str());

    // Lights for health bits
    FireFlyStatus::Severity bitSeverity;
    bool bitOn;
    QPixmap badLED;
    QPixmap goodLED = _greenLED_off;

    bitOn = status.coarseDacIsAtMax(&bitSeverity);
    badLED = (bitSeverity == FireFlyStatus::ERROR) ? _redLED : _amberLED;
    _ui.coarseDacAtMaxIcon->setPixmap(bitOn ? badLED : goodLED);

    bitOn = status.coarseDacIsAtMin(&bitSeverity);
    badLED = (bitSeverity == FireFlyStatus::ERROR) ? _redLED : _amberLED;
    _ui.coarseDacAtMinIcon->setPixmap(bitOn ? badLED : goodLED);

    bitOn = status.phaseOffsetLarge(&bitSeverity);
    badLED = (bitSeverity == FireFlyStatus::ERROR) ? _redLED : _amberLED;
    _ui.largePhaseOffsetIcon->setPixmap(bitOn ? badLED : goodLED);

    bitOn = status.runTimeUnder300Sec(&bitSeverity);
    badLED = (bitSeverity == FireFlyStatus::ERROR) ? _redLED : _amberLED;
    _ui.runTimeIcon->setPixmap(bitOn ? badLED : goodLED);

    bitOn = status.longHoldover(&bitSeverity);
    badLED = (bitSeverity == FireFlyStatus::ERROR) ? _redLED : _amberLED;
    _ui.longHoldoverIcon->setPixmap(bitOn ? badLED : goodLED);

    bitOn = status.freqErrEstOutOfBounds(&bitSeverity);
    badLED = (bitSeverity == FireFlyStatus::ERROR) ? _redLED : _amberLED;
    _ui.feeOutOfBoundsIcon->setPixmap(bitOn ? badLED : goodLED);

    bitOn = status.oscVoltageTooHigh(&bitSeverity);
    badLED = (bitSeverity == FireFlyStatus::ERROR) ? _redLED : _amberLED;
    _ui.highOcxoVoltageIcon->setPixmap(bitOn ? badLED : goodLED);

    bitOn = status.oscVoltageTooLow(&bitSeverity);
    badLED = (bitSeverity == FireFlyStatus::ERROR) ? _redLED : _amberLED;
    _ui.lowOcxoVoltageIcon->setPixmap(bitOn ? badLED : goodLED);

    bitOn = status.shortTermDriftLarge(&bitSeverity);
    badLED = (bitSeverity == FireFlyStatus::ERROR) ? _redLED : _amberLED;
    _ui.shortTermDriftIcon->setPixmap(bitOn ? badLED : goodLED);

    bitOn = status.recentPhaseResetOrCoarseDacChange(&bitSeverity);
    badLED = (bitSeverity == FireFlyStatus::ERROR) ? _redLED : _amberLED;
    _ui.phaseResetCoarseDacIcon->setPixmap(bitOn ? badLED : goodLED);

    bitOn = status.strongGpsJamming(&bitSeverity);
    badLED = (bitSeverity == FireFlyStatus::ERROR) ? _redLED : _amberLED;
    _ui.gpsJammingIcon->setPixmap(bitOn ? badLED : goodLED);

}
