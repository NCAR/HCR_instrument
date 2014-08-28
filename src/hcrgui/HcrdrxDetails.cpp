/*
 * HcrdrxDetails.cpp
 *
 *  Created on: Dec 4, 2013
 *      Author: burghart
 */
#include "HcrdrxDetails.h"
#include <QDateTime>

HcrdrxDetails::HcrdrxDetails(QWidget *parent) :
    QDialog(parent),
    _ui() {
    // Set up the UI and get the current status
    _ui.setupUi(this);
    // Initialize to no status available
    noStatus();
}

void
HcrdrxDetails::updateStatus(bool daemonResponding, const DrxStatus & status) {
    // Based on whether the daemon is responding, set the "daemon responding"
    // label, and set the enabled state for the rest of the components.
    _ui.daemonRespondingLabel->setText(daemonResponding ?
            "" : "<font color='DarkRed'>No hcrdrx!</font>");
    _ui.statusFrame->setEnabled(daemonResponding);

    // Fill in with info from the DrxStatus
    QString text;
    _ui.pulsewidthValue->setText(text.sprintf("%.3f", 1.0e6 * status.xmitPulseWidth()));
    _ui.prtValue->setText(text.sprintf("%.3f", 1.0e6 * status.prt()));
    _ui.nGatesValue->setText(QString::number(status.nGates()));
    _ui.gateSpacingValue->setText(text.sprintf("%.1f", status.gateSpacing()));
    _ui.pentekFpgaTempValue->setText(QString::number(status.pentekFpgaTemp()));
    _ui.pentekBoardTempValue->setText(QString::number(status.pentekBoardTemp()));
}

void
HcrdrxDetails::noStatus() {
    _ui.pulsewidthValue->setText("0.0");
    _ui.prtValue->setText("0.0");
    _ui.nGatesValue->setText("0");
    _ui.gateSpacingValue->setText("0");
    _ui.pentekFpgaTempValue->setText("---");
    _ui.pentekBoardTempValue->setText("---");
}
