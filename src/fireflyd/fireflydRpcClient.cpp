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
 * fireflydRpcClient.cpp
 *
 *  Created on: August 13, 2012
 *      Author: burghart
 */

#include "fireflydRpcClient.h"

#include <cstdlib>
#include <logx/Logging.h>

LOGGING("fireflydRpcClient")

fireflydRpcClient::fireflydRpcClient(std::string fireflydHost,
        int fireflydPort) :
    xmlrpc_c::clientSimple(),
    _fireflydHost(fireflydHost),
    _fireflydPort(fireflydPort) {
    // build _daemonUrl: "http://<_daemonHost>:<_daemonPort>/RPC2"
    std::ostringstream ss;
    ss << "http://" << _fireflydHost << ":" << _fireflydPort << "/RPC2";
    _daemonUrl = ss.str();
    ILOG << "fireflydRpcClient on " << _daemonUrl;
}

fireflydRpcClient::~fireflydRpcClient() {
}

bool
fireflydRpcClient::getStatus(FireFlyStatus & status) {
    xmlrpc_c::value result;
    try {
        call(_daemonUrl, "getStatus", "", &result);
    } catch (std::exception & e) {
        WLOG << "Error on XML-RPC getStatus() call: " << e.what();
        return(false);
    }
    xmlrpc_c::value_struct resultStruct(result);
    status = FireFlyStatus(resultStruct);
    return(true);
}

