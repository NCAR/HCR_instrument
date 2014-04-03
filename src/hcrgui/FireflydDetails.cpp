/*
 * FireflydDetails.cpp
 *
 *  Created on: Apr 1, 2014
 *      Author: burghart
 */
#include "FireflydDetails.h"

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
}
