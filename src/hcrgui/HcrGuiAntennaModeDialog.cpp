/*
 * HcrGuiAntennaModeDialog.cpp
 *
 *  Created on: Aug 29, 2012
 *      Author: burghart
 */
#include "HcrGuiAntennaModeDialog.h"

HcrGuiAntennaModeDialog::HcrGuiAntennaModeDialog(QWidget *parent) :
    QDialog(parent),
    _ui() {
    // Set up the UI and get the current status
    _ui.setupUi(this);
}

void
HcrGuiAntennaModeDialog::updateStatus() {
}
