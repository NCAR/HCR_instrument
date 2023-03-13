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
 * MotionControlStatusWorker.cpp
 *
 *  Created on: Oct 22, 2014
 *      Author: burghart
 */

#include <QMetaType>
#include <QTimer>
#include <logx/Logging.h>
#include <MotionControl/MotionControlStatusWorker.h>

LOGGING("MotionControlStatusWorker")

MotionControlStatusWorker::MotionControlStatusWorker(std::string mcdHost, int mcdPort,
                                                     QThread* workThread) :
    QObject(),
    MotionControlRpcClient(mcdHost, mcdPort),
    _daemonAlive(false),
    _mcdHost(mcdHost),
    _mcdPort(mcdPort),
    _workThread(workThread),
    _getStatusTimer(NULL) {
    // We need to register MotionControl::Status as a metatype, since we'll be 
    // passing it as an argument in a signal.
    qRegisterMetaType<MotionControl::Status>("MotionControl::Status");

    // Initiate our work when the work thread is started, and continue until
    // the thread is stopped or destroyed.
    connect(_workThread, &QThread::started, this, &MotionControlStatusWorker::_beginWork);
    connect(_workThread, &QThread::finished, this, &MotionControlStatusWorker::deleteLater);
}

MotionControlStatusWorker::~MotionControlStatusWorker() {
}

void
MotionControlStatusWorker::_beginWork() {
    // Set our thread affinity to the work thread we were given at construction
    // time, so that signals/slots for this object will now execute in the work
    // thread.
    moveToThread(_workThread);

    // Instantiate and set up our periodic timer to call _getStatus()
    _getStatusTimer = new QTimer();
    connect(_getStatusTimer, &QTimer::timeout, this, &MotionControlStatusWorker::_collectStatus);
    connect(_workThread, &QThread::finished, _getStatusTimer, &QTimer::deleteLater);
    _getStatusTimer->start(1000);    /// 1000 ms
}

void
MotionControlStatusWorker::_collectStatus() {
    auto currentStatus = status();

    // If daemon responsiveness changed, log the change and emit a
    // serverResponsive signal
    bool previouslyAlive = _daemonAlive;
    _daemonAlive = daemonResponding();
    if (_daemonAlive != previouslyAlive) {
        std::ostringstream os;
        os << "Motion control is" << (_daemonAlive ? "" : " NOT") << " responding";
        emit serverResponsive(_daemonAlive, os.str().c_str());
    }

    // Emit the new status
    emit newStatus(currentStatus);
}
