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
 * HcrdrxStatusThread.cpp
 *
 *  Created on: Sep 10, 2012
 *      Author: hcr
 */

#include "HcrdrxStatusThread.h"
#include <logx/Logging.h>
#include <QMetaType>
#include <QTimer>

LOGGING("HcrdrxStatusThread")

HcrdrxStatusThread::HcrdrxStatusThread(std::string drxHost, int drxPort) :
    _responsive(false),
    _drxHost(drxHost),
    _drxPort(drxPort),
    _client(0) {
    // We need to register DrxStatus as a metatype, since we'll be passing it
    // as an argument in a signal.
    qRegisterMetaType<DrxStatus>("DrxStatus");
    // Set thread affinity to self, so that signals connected to our slot(s)
    // will execute the slots in this thread, and not our parent's.
    moveToThread(this);
}

HcrdrxStatusThread::~HcrdrxStatusThread() {
    quit();
    // Wait up to a second for thread completion
    if (! wait(1000)) {
        WLOG << "HcrdrxStatusThread did not stop. Exiting anyway.";
    }
}

void
HcrdrxStatusThread::run() {
    // Instantiate the HcrdrxRpcClient
    _client = new HcrdrxRpcClient(_drxHost, _drxPort);
    // Set up a 1 Hz timer to call _getStatus()
    QTimer timer;
    connect(&timer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    timer.start(1000);
    // Start the event loop
    exec();
    return;
}

void
HcrdrxStatusThread::_getStatus() {
    DrxStatus status;
    bool gotResponse = _client->getStatus(status);
    if (gotResponse != _responsive) {
        _responsive = gotResponse;
        emit serverResponsive(gotResponse);
    }
    emit newStatus(status);
}
