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
 * FireflydStatusThread.cpp
 *
 *  Created on: April 1, 2014
 *      Author: burghart
 */

#include "FireflydStatusThread.h"
#include <logx/Logging.h>
#include <QMetaType>
#include <QTimer>

LOGGING("FireFlyStatusThread")

FireflydStatusThread::FireflydStatusThread(std::string fireflydHost,
        int fireflydPort) :
    _responsive(false),
    _fireflydHost(fireflydHost),
    _fireflydPort(fireflydPort),
    _client(0) {
    // We need to register FireFlyStatus as a metatype, since we'll be passing
    // it as an argument in a signal.
    qRegisterMetaType<FireFlyStatus>("FireFlyStatus");
    // Set thread affinity to self, so that signals connected to our slot(s)
    // will execute the slots in this thread, and not our parent's.
    moveToThread(this);
}

FireflydStatusThread::~FireflydStatusThread() {
    quit();
    // Wait up to a second for thread completion
    if (! wait(1000)) {
        WLOG << "FireFlyStatusThread did not stop. Exiting anyway.";
    }
}

void
FireflydStatusThread::run() {
    // Instantiate the fireflydRpcClient
    _client = new fireflydRpcClient(_fireflydHost, _fireflydPort);

    // Set up a 1 Hz timer to call _getStatus()
    QTimer timer;
    connect(&timer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    timer.start(1000);
    // Start the event loop
    exec();
    return;
}

void
FireflydStatusThread::_getStatus() {
    FireFlyStatus status;
    bool gotResponse = _client->getStatus(status);
    if (gotResponse != _responsive) {
        _responsive = gotResponse;
        emit serverResponsive(gotResponse);
    }
    emit newStatus(status);
}
