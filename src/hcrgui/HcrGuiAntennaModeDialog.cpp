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
		return POINTING;
	else
		return SCANNING;
}

void
HcrGuiAntennaModeDialog::getPointingAngle(float& angle) {
	angle = (float)_ui.pointingSpinBox->value();
}

void
HcrGuiAntennaModeDialog::getScanningParam(float& ccwLimit, float& cwLimit, float& scanRate) {
	ccwLimit = (float)_ui.ccwLimitSpinBox->value();
	cwLimit  = (float)_ui.cwLimitSpinBox->value();
	scanRate = (float)_ui.scanRateSpinBox->value();
}

void
HcrGuiAntennaModeDialog::on_buttonBox_clicked() {
	this->accept();
}
