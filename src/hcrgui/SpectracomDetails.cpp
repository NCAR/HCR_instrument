// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2017
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
 * SpectracomDetails.cpp
 *
 *  Created on: Jan 5, 2017
 *      Author: Chris Burghart <burghart@ucar.edu>
 */
#include "SpectracomDetails.h"
#include <QtCore/QDateTime>

SpectracomDetails::SpectracomDetails(QWidget *parent) :
    QDialog(parent),
    _ui(),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png") {
    // Set up the UI and get the current status
    _ui.setupUi(this);
    // Initialize to no status available
    noStatus();
}

void
SpectracomDetails::updateStatus(bool daemonResponding,
		const SpectracomStatus & status) {
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
    _ui.zeroSetValue->setText(status.motorZeroPositionSet() ? "Set" : "Unset");
    _ui.zeroSetIcon->setPixmap(status.motorZeroPositionSet() ? _greenLED : _amberLED);
    _ui.pentekFpgaTempValue->setText(QString::number(status.pentekFpgaTemp()));
    _ui.pentekBoardTempValue->setText(QString::number(status.pentekBoardTemp()));
}

void
SpectracomDetails::noStatus() {
    _ui.pulsewidthValue->setText("0.0");
    _ui.prtValue->setText("0.0");
    _ui.nGatesValue->setText("0");
    _ui.gateSpacingValue->setText("0");
    _ui.zeroSetValue->setText("Unknown");
    _ui.zeroSetIcon->setPixmap(_greenLED_off);
    _ui.pentekFpgaTempValue->setText("---");
    _ui.pentekBoardTempValue->setText("---");
}
