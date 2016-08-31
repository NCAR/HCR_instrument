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
 * SpatialFogDaemonRpcClient.cpp
 *
 *  Created on: August 29, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#include "SpatialFogDaemonRpcClient.h"

#include <iostream>
#include <sstream>
#include <cstdlib>
#include <logx/Logging.h>

LOGGING("SpatialFogDaemonRpcClient")

SpatialFogDaemonRpcClient::SpatialFogDaemonRpcClient(std::string daemonHost,
        int daemonPort) :
    _daemonHost(daemonHost),
    _daemonPort(daemonPort),
    _client() {
    // build _daemonUrl: "http://<_daemonHost>:<_daemonPort>/RPC2"
    std::ostringstream ss;
    ss << "http://" << _daemonHost << ":" << _daemonPort << "/RPC2";
    _daemonUrl = ss.str();
    ILOG << "SpatialFogDaemonRpcClient on " << _daemonUrl;
}

SpatialFogDaemonRpcClient::~SpatialFogDaemonRpcClient() {
}

SpatialFogStatus
SpatialFogDaemonRpcClient::getStatus() throw (std::exception) {
    try {
        xmlrpc_c::value result;
        // _client.call() may throw a girerr::error exception (a subclass
        // of std::exception). If so, we allow it to move up the chain.
        _client.call(_daemonUrl, "getStatus", "", &result);
        // The getStatus() XML-RPC method returns xmlrpc_c::value_struct, 
        // which we can use to (re)construct the SpatialFogStatus.
        xmlrpc_c::value_struct dict(result);
        SpatialFogStatus status(dict);
        return(status);
    } catch (std::exception & e) {
        WLOG << "XML-RPC call to getStatus() failed: " << e.what();
        throw; // rethrow the exception
    }
}
