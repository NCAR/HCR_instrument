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
#ifndef XMITDETAILS_H_
#define XMITDETAILS_H_

#include <QDialog>
#include <QPixmap>

#include "ui_XmitDetails.h"
#include <XmitdRpcClient.h>


class XmitDetails : public QDialog {
    Q_OBJECT
public:
    XmitDetails(QWidget *parent);
    virtual ~XmitDetails() {}

    void updateStatus(bool daemonResponding, const XmitStatus & xmitStatus);
    void noStatus();

protected:
    /**
     *  @brief Return "-" if the count is zero, otherwise a text representation of
     *  the count.
     *  @param count the count to be represented
     *  @return "-" if the count is zero, otherwise a text representation of
     *      the count.
     */
    static QString _countLabel(int count);

    /**
     *  Return an empty string if the time is -1, otherwise a brief text
     *  representation of the time.
     *  @param time the time_t time to be represented
     *  @return an empty string if the time is -1, otherwise a brief text
     *  representation of the time.
     */
    static QString _faultTimeLabel(time_t time);

private:
    Ui::XmitDetails _ui;
    QPixmap _redLED;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;
};
#endif /* XMITDETAILS_H_*/
