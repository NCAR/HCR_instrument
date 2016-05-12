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
 *  Created on: Dec 10, 2013
 *      Author: burghart
 */
#ifndef PMC730DETAILS_H_
#define PMC730DETAILS_H_

#include <QDialog>
#include <QPixmap>
#include <HcrPmc730Status.h>

#include "ui_Pmc730Details.h"

class Pmc730Details : public QDialog {
    Q_OBJECT
public:
    Pmc730Details(QWidget *parent);
    virtual ~Pmc730Details() {}

    /// @brief Return true iff details indicates a warning condition.
    /// @return true iff details indicates a warning condition.
    bool warnState() const { return(_warnState); }
    
    /// @brief Return true iff details indicates an error condition.
    /// @return true iff details indicates an error condition.
    bool errState() const { return(_errState); }
    
public slots:
    /// @brief Slot to call to populate with new status
    /// @param daemonResponding true iff the daemon is responding
    /// @param status the new status to be displayed
    void updateStatus(bool daemonResponding, const HcrPmc730Status & status);
    
private:
    Ui::Pmc730Details _ui;
    QPixmap _redLED;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;
    
    bool _warnState;
    bool _errState;
};
#endif /* PMC730DETAILS_H_*/
