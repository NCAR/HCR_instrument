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
 *  Created on: Jul 23, 2013
 *      Author: burghart
 */
#ifndef MOTIONCONTROLDETAILS_H_
#define MOTIONCONTROLDETAILS_H_

#include <QDialog>
#include <QPixmap>
#include <MotionControl.h>

#include "ui_MotionControlDetails.h"


class MotionControlDetails : public QDialog {
    Q_OBJECT
public:
    MotionControlDetails(QWidget *parent);
    virtual ~MotionControlDetails() {}

    /// @brief Return true iff there are any MotionControl problems, i.e.,
    /// if any red lights have been lit in the details display.
    /// @return true iff there are any MotionControl problems, i.e.,
    /// if any red lights have been lit in the details display.
    bool errorDetected() const { return(_errorDetected); }

    /// @brief Return true iff there are any MotionControl warnings, i.e.,
    /// if any amber lights have beein lit in the details display.
    /// @return true iff there are any MotionControl problems, i.e.,
    /// if any amber lights have been lit in the details display.
    bool warningDetected() const { return(_warningDetected); }

public slots:
    void updateStatus(bool daemonResponding, const MotionControl::Status & mcStatus);
private:
    void _doRotStatus(const MotionControl::Status & mcStatus);

    void _doTiltStatus(const MotionControl::Status & mcStatus);

    Ui::MotionControlDetails _ui;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;
    QPixmap _redLED;

    // true if we have turned on any amber lights
    bool _warningDetected;

    // true if we have turned on any red lights
    bool _errorDetected;
};
#endif /*MOTIONCONTROLDETAILS_H_*/
