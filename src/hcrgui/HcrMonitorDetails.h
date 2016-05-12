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
 *  Created on: Nov 5, 2014
 *      Author: burghart
 */
#ifndef HCRMONITORDETAILS_H_
#define HCRMONITORDETAILS_H_

#include <QDialog>
#include <QPixmap>
#include <HcrMonitorStatus.h>
#include <HcrMonitorRpcClient.h>
#include <HcrPmc730Status.h>

#include "ui_HcrMonitorDetails.h"


class HcrMonitorDetails : public QDialog {
    Q_OBJECT
public:
    HcrMonitorDetails(QWidget *parent, std::string hcrMonitorHost, 
            int hcrMonitorPort);
    virtual ~HcrMonitorDetails() {}

    void noStatus();
public slots:
    void updateStatus(bool daemonResponding, 
            const HcrMonitorStatus & hcrMonitorStatus,
            const HcrPmc730Status & hcrPmc730Status);
    
    void on_apsValveControlCombo_activated(int index);
private:
    Ui::HcrMonitorDetails _ui;
    
    /// @brief client to be used for sending XML-RPC commands to HcrMonitor
    HcrMonitorRpcClient _rpcClient;
    
    QPixmap _redLED;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;
};
#endif /* HCRMONITORDETAILS_H_*/
