/*
 * FireflydDetails.cpp
 *
 *  Created on: Apr 1, 2014
 *      Author: burghart
 */
#include "FireflydDetails.h"

FireflydDetails::FireflydDetails(QWidget *parent) :
    QDialog(parent),
    _ui() {
    // Set up the UI and get the current status
    _ui.setupUi(this);
}

void
FireflydDetails::updateStatus(const FireFlyStatus & status) {
//    _ui.pentekFpgaTempValue->setText(QString::number(status.pentekFpgaTemp()));
//    _ui.pentekBoardTempValue->setText(QString::number(status.pentekBoardTemp()));
}
