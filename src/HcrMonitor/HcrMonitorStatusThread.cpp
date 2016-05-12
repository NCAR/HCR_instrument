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
 * HcrMonitorStatusThread.cpp
 *
 *  Created on: Oct 28, 2014
 *      Author: burghart
 */

#include "HcrMonitorStatusThread.h"
#include <QMetaType>
#include <QTimer>
#include <logx/Logging.h>

LOGGING("HcrMonitorStatusThread")

HcrMonitorStatusThread::HcrMonitorStatusThread(std::string daemonHost, 
        int daemonPort) :
    _responsive(false),
    _daemonHost(daemonHost),
    _daemonPort(daemonPort),
    _client(0),
    _timeOfLastHvOffForHighPower(0) {
    // We need to register HcrMonitorStatus as a metatype, since we'll be 
    // passing it as an argument in a signal.
    qRegisterMetaType<HcrMonitorStatus>("HcrMonitorStatus");
    // Set thread affinity to self, so that signals connected to our slot(s)
    // will execute the slots in this thread, and not our parent's.
    moveToThread(this);
}

HcrMonitorStatusThread::~HcrMonitorStatusThread() {
}

void
HcrMonitorStatusThread::run() {
    // Instantiate the HcrMonitorRpcClient
    _client = new HcrMonitorRpcClient(_daemonHost, _daemonPort);
    // Set up a 1 s timer to call _getStatus()
    QTimer timer;
    connect(&timer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    timer.start(1000);
    // Start the event loop
    exec();
    return;
}

void
HcrMonitorStatusThread::_getStatus() {
    try {
        HcrMonitorStatus status = _client->status();
        // We got a response, so emit serverResponsive(true) if the server was
        // not previously responding.
        if (! _responsive) {
            std::ostringstream oss;
            _responsive = true;
            std::string msg = "HcrMonitor is responding";
            ILOG << msg;
            emit serverResponsive(true, QString(msg.c_str()));
        }
        // Look for a new "HV forced off because of high max power" event, and
        // emit hvForcedOffForHighMaxPower() if we find one.
        if (status.timeOfLastHvOffForHighPower() > _timeOfLastHvOffForHighPower) {
            emit hvForcedOffForHighMaxPower(status.detailsForLastHvOffForHighPower().c_str());
            _timeOfLastHvOffForHighPower = status.timeOfLastHvOffForHighPower();
        }
        // Emit the new status.
        emit newStatus(status);
    } catch (std::exception & e) {
        // As a rule, exceptions just mean the server is not responding. Emit
        // serverResponsive(false) if the server had previously been responding.
        if (_responsive) {
            _responsive = false;
            std::ostringstream oss;
            oss << "HcrMonitor failed to respond to getStatus(): " << e.what();
            WLOG << oss.str();
            emit serverResponsive(false, QString(oss.str().c_str()));
        }
    }
}
