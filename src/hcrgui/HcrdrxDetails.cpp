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
HcrdrxDetails::updateStatus(const DrxStatus & status) {
    _ui.pentekFpgaTempValue->setText(QString::number(status.pentekFpgaTemp()));
    _ui.pentekBoardTempValue->setText(QString::number(status.pentekBoardTemp()));
}

void
HcrdrxDetails::noStatus() {
    _ui.pentekFpgaTempValue->setText("---");
    _ui.pentekBoardTempValue->setText("---");
}
