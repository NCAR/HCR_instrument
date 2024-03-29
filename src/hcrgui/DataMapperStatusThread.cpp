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
 * DataMapperStatusThread.cpp
 *
 *  Created on: Sep 24, 2013
 *      Author: burghart
 */

#include "DataMapperStatusThread.h"
#include <cstring>
#include <iomanip>
#include <sstream>
#include <QDateTime>
#include <QMetaType>
#include <QTimer>
#include <boost/date_time/posix_time/posix_time.hpp>
#include <logx/Logging.h>

using namespace boost::posix_time;

LOGGING("DataMapperStatusThread")

static const std::string DATA_TYPE = "iwrf_ts";
static const std::string DATA_DIR = "time_series/wband/save";

DataMapperStatusThread::DataMapperStatusThread(std::string dmapHost) :
    _dmapHost(dmapHost),
    _dmapAccess(),
    _responsive(false){
    
    // We need to register DMAP_info_t as a metatype, since we'll be passing
    // it as an argument in a signal.
    qRegisterMetaType<DMAP_info_t>("DMAP_info_t");

    // Zero out _dmInfo
    memset(&_dmInfo, 0, sizeof(_dmInfo));
    
    // Set thread affinity to self, so that signals connected to our slot(s)
    // will execute the slots in this thread, and not our parent's.
    moveToThread(this);
}

DataMapperStatusThread::~DataMapperStatusThread() {
}

void
DataMapperStatusThread::run() {
    // Get first-time status
    _getStatus();
    // Set up a 5 second timer to call _getStatus()
    QTimer timer;
    connect(&timer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    timer.start(5000);
    // Start the event loop
    exec();
    return;
}

void
DataMapperStatusThread::_getStatus() {
    bool fail = _dmapAccess.reqSelectedInfo(DATA_TYPE, DATA_DIR, _dmapHost);
                    
    // On failure, mark the server as unresponsive and return. That's the best 
    // we can do, since we cannot determine the specific reason for failure.
    if (fail) {
        if (_responsive) {
            _responsive = false;
            WLOG << "Bad (or no) response from DataMapper @ " << _dmapHost;
            emit serverResponsive(false);
        }
        return;
    }
    
    // We got a good reply from DataMapper. Emit a signal if DataMapper just 
    // became responsive.
    if (! _responsive) {
        _responsive = true;
        ILOG << "DataMapper is now responding";
        emit serverResponsive(true);
    }

    // Extract the status we just requested, or build a "nothing written" status
    // if zero entries were returned.
    DMAP_info_t info = _dmInfo;
    
    int nInfo = _dmapAccess.getNInfo();
    switch (nInfo) {
    case 0:
        // Nobody has registered to write our DATA_TYPE to DATA_DIR.
        // Continue using _dmInfo.
        break;
    case 1:
        // This is the common case; we should almost always get 1 info block.
        // Get the block.
        info = _dmapAccess.getInfo(0);
        break;
    default:
        WLOG << "Got " << nInfo << " info entries from DataMapper, but " <<
            "expected 1. Using first entry.";
        info = _dmapAccess.getInfo(0);
        break;
    }
    
    // Save this info block
    _dmInfo = info;
    
    // Emit the new status.
    emit newStatus(_dmInfo);
}
