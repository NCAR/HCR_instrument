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
 * SpatialFogStatus.cpp
 *
 *  Created on: Aug 18, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#include <Archive_xmlrpc_c.h>
#include <logx/Logging.h>

#include "SpatialFogStatus.h"

LOGGING("SpatialFogStatus")

// Static connection to SpatialFogFmq
SpatialFogFmq * SpatialFogStatus::_Fmq = 0;

SpatialFogStatus::SpatialFogStatus() :
    SpatialFogFmq::MsgStruct() {}

SpatialFogStatus::SpatialFogStatus(const xmlrpc_c::value_struct & statusDict) :
    SpatialFogFmq::MsgStruct() {
    // Create an input archiver wrapper around the map from std::string to
    // xmlrpc_c::value, and use serialize() to populate our members from its
    // content.
    std::map<std::string, xmlrpc_c::value> statusMap(statusDict);
    Iarchive_xmlrpc_c iar(statusMap);
    iar >> *this;
    // Zero the writer PID, since it doesn't really apply on the other side of
    // an XML-RPC connection.
    writerPid = 0;
}

SpatialFogStatus::~SpatialFogStatus() {
}

xmlrpc_c::value_struct
SpatialFogStatus::toXmlRpcValue() const {
    std::map<std::string, xmlrpc_c::value> statusMap;
    // Clone ourself to a non-const instance. We take as a given that the
    // Oarchive_xmlrpc_c operator<<() will not modify us...
    SpatialFogStatus clone(*this);
    // Stuff our content into the statusMap, i.e., _serialize() to an
    // output archiver wrapped around the statusDict.
    Oarchive_xmlrpc_c oar(statusMap);
    oar << clone;
    // Finally, return a value_struct constructed from the map
    return(xmlrpc_c::value_struct(statusMap));
}

SpatialFogStatus
SpatialFogStatus::StatusFromFmq() {
    SpatialFogStatus status;
    
    // If we have no static connection to the shared memory segment, create
    // it now.
    if (! _Fmq) {
        _Fmq = new SpatialFogFmq();
    }
    
    // If a process is writing to SpatialFogFmq, get latest status from
    // there.
    if (_Fmq->getWriterPid()) {
        SpatialFogFmq::MsgStruct * mptr =
            static_cast<SpatialFogFmq::MsgStruct*>(&status);
        *mptr = _Fmq->getLatestMsg();
    } else {
        // Nobody's writing to the FMQ, so complain and just return the status
        // from the default constructor.
        WLOG << __PRETTY_FUNCTION__ << ": No writer exists for SpatialFogFmq -";
        WLOG << "    SpatialFogStatus::StatusFromFmq() should only be " <<
                "used on the machine running SpatialFogDaemon.";

    }
    return(status);
}
