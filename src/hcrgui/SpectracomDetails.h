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
 *  Created on: Jan 5, 2017
 *      Author: Chris Burghart <burghart@ucar.edu>
 */
#ifndef SPECTRACOMDETAILS_H_
#define SPECTRACOMDETAILS_H_

#include <QtGui/QDialog>
#include <QtGui/QPixmap>
#include <SpectracomStatus.h>

#include "ui_SpectracomDetails.h"

/// @brief QDialog to display status details from a Spectracom SecureSync
/// time/frequency server.
class SpectracomDetails : public QDialog {
    Q_OBJECT
public:
    SpectracomDetails(QWidget *parent);
    virtual ~SpectracomDetails() {}

public slots:
    /// @brief Update the status displayed by the widget
    void updateStatus(bool daemonResponding, const SpectracomStatus & status);
private:
    /// @brief Set widget to display that no up-to-date status is
    /// available
    void _noStatus();

    /// @brief Return green, amber, or red LED pixmap appropriate for the given
    /// simple state with values 0 = good, 1 = minor issue(s),
    /// 2 = major issue(s)
    /// @param simpleState 0 = good, 1 = minor issue(s), 2 = major issue(s)
    /// @return green, amber, or red LED pixmap appropriate for the given
    /// simple state
    QPixmap & _ledForSimpleStatus(int simpleState) {
        if (simpleState == 2) {
            return(_redLED);
        } else if (simpleState == 1) {
            return(_amberLED);
        } else {
            return(_greenLED);
        }
    }

    QPixmap _redLED;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;

    Ui::SpectracomDetails _ui;
};
#endif /* SPECTRACOMDETAILS_H_*/
