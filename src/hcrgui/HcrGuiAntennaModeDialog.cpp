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

HcrGuiAntennaModeDialog::AntennaMode
HcrGuiAntennaModeDialog::getMode() {
	int index = _ui.tabWidget->currentIndex();
	if (_ui.tabWidget->tabText(index).contains("Pointing"))
		return HcrGuiAntennaModeDialog::POINTING;
	else
		return HcrGuiAntennaModeDialog::SCANNING;
}

void
HcrGuiAntennaModeDialog::getPointingAngle(float& angle) {
	angle = (float)_ui.pointingSpinBox->value();
}

void
HcrGuiAntennaModeDialog::on_buttonBox_clicked() {
	this->accept();
}
