/*
 * AntennaModeDialog.cpp
 *
 *  Created on: Aug 29, 2012
 *      Author: burghart
 */
#include "AntennaModeDialog.h"

AntennaModeDialog::AntennaModeDialog(QWidget *parent) :
    QDialog(parent),
    _ui() {
    // Set up the UI and get the current status
    _ui.setupUi(this);
}

AntennaModeDialog::AntennaMode
AntennaModeDialog::getMode() {
	int index = _ui.tabWidget->currentIndex();
	if (_ui.tabWidget->tabText(index).contains("Pointing"))
		return POINTING;
	else
		return SCANNING;
}

void
AntennaModeDialog::getPointingAngle(float& angle) {
	angle = (float)_ui.pointingSpinBox->value();
}

void
AntennaModeDialog::getScanningParam(float& ccwLimit, float& cwLimit, 
        float& scanRate, float& beamTilt) {
	ccwLimit = (float)_ui.ccwLimitSpinBox->value();
	cwLimit  = (float)_ui.cwLimitSpinBox->value();
	scanRate = (float)_ui.scanRateSpinBox->value();
	beamTilt = (float)_ui.beamTiltSpinBox->value();
}

void
AntennaModeDialog::on_buttonBox_clicked() {
	this->accept();
}
