// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2016                                         
// ** University Corporation for Atmospheric Research (UCAR)                 
// ** National Center for Atmospheric Research (NCAR)                        
// ** Boulder, Colorado, USA                                                 
// ** BSD licence applies - redistribution and use in source and binary      
// ** forms, with or without modification, are permitted provided that       
// ** the following conditions are met:                                      
// ** 1) If the software is modified to produce derivative works,            
// ** such modified software should be clearly marked, so as not             
// ** to confuse it with the version available from UCAR.                    
// ** 2) Redistributions of source code must retain the above copyright      
// ** notice, this list of conditions and the following disclaimer.          
// ** 3) Redistributions in binary form must reproduce the above copyright   
// ** notice, this list of conditions and the following disclaimer in the    
// ** documentation and/or other materials provided with the distribution.   
// ** 4) Neither the name of UCAR nor the names of its contributors,         
// ** if any, may be used to endorse or promote products derived from        
// ** this software without specific prior written permission.               
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS  
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED      
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.    
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
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
