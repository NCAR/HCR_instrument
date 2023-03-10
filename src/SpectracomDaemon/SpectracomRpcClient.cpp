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
 * SpectracomRpcClient.cpp
 *
 *  Created on: August 13, 2012
 *      Author: burghart
 */

#include "SpectracomRpcClient.h"

#include <cstdlib>
#include <logx/Logging.h>

LOGGING("SpectracomRpcClient")

SpectracomRpcClient::SpectracomRpcClient(std::string daemonHost,
        int daemonPort) :
    xmlrpc_c::clientSimple(),
    _daemonHost(daemonHost),
    _daemonPort(daemonPort) {
    // build _daemonUrl: "http://<_daemonHost>:<_daemonPort>/RPC2"
    std::ostringstream ss;
    ss << "http://" << _daemonHost << ":" << _daemonPort << "/RPC2";
    _daemonUrl = ss.str();
    ILOG << "SpectracomRpcClient on " << _daemonUrl;
}

SpectracomRpcClient::~SpectracomRpcClient() {
}

bool
SpectracomRpcClient::getStatus(SpectracomStatus & status) {
    xmlrpc_c::value result;
    try {
        call(_daemonUrl, "getStatus", "", &result);
    } catch (std::exception & e) {
        WLOG << "Error on XML-RPC getStatus() call: " << e.what();
        return(false);
    }
    xmlrpc_c::value_struct resultStruct(result);
    std::map<std::string, xmlrpc_c::value> map = resultStruct.cvalue();
    try {
        status = SpectracomStatus(resultStruct);
    } catch (std::exception & e) {
        ELOG << "Exception constructing SpectracomStatus: " << e.what();
    }
    return(true);
}

