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
 *  Created on: Jan 14, 2011
 *      Author: burghart
 */
#ifndef ANTENNAMODEDIALOG_H_
#define ANTENNAMODEDIALOG_H_

#include <QDialog>
#include <DrxStatus.h>

#include "ui_AntennaModeDialog.h"


class AntennaModeDialog : public QDialog {
    Q_OBJECT

public:
	/// Antenna motion mode: pointing or scanning
	typedef enum {
		POINTING,
		SCANNING
	} AntennaMode;

    AntennaModeDialog(QWidget *parent);
    virtual ~AntennaModeDialog() {}

    // Get selected antenna mode
    AntennaMode getMode();
    // Get antenna pointing angle
    void getPointingAngle(float& angle);
    // Get antenna scanning parameters
    void getScanningParam(float& ccwLimit, float& cwLimit, float& scanRate, float& beamTilt);

private slots:
    // auto-connected slots
    void on_buttonBox_clicked();        // Accept button
    void on_pointingSpinBox_valueChanged(double val);   // UI pointing value
    void on_zenithButton_clicked();     // zenith quick point button
    void on_horizontalButton_clicked(); // horizontal quick point button
    void on_nadirButton_clicked();      // nadir quick point button
    void on_ssCal170Button_clicked();   // sea surface cal (170) quick point button
    void on_ssCal190Button_clicked();   // sea surface cal (190) quick point button

private:
    Ui::AntennaModeDialog _ui;
};

#endif /* ANTENNAMODEDIALOG_H_*/
