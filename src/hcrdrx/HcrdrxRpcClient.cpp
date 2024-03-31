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
 * HcrdrxRpcClient.cpp
 *
 *  Created on: August 13, 2012
 *      Author: burghart
 */
#include "HcrdrxRpcClient.h"

#include <cstdlib>
#include <logx/Logging.h>
#include <Archive_xmlrpc_c.h>
#include <OperationMode.h>

LOGGING("HcrdrxRpcClient")

HcrdrxRpcClient::HcrdrxRpcClient(std::string hcrdrxHost, int hcrdrxPort) :
    xmlrpc_c::clientSimple(),
    _hcrdrxHost(hcrdrxHost),
    _hcrdrxPort(hcrdrxPort) {
    // build _daemonUrl: "http://<_daemonHost>:<_daemonPort>/RPC2"
    std::ostringstream ss;
    ss << "http://" << _hcrdrxHost << ":" << _hcrdrxPort << "/RPC2";
    _daemonUrl = ss.str();
    ILOG << "HcrdrxRpcClient on " << _daemonUrl;
}

HcrdrxRpcClient::~HcrdrxRpcClient() {
}

bool
HcrdrxRpcClient::_execXmlRpcCall(std::string methodName, 
        xmlrpc_c::value& result, const xmlrpc_c::paramList& params) {
    try {
        call(_daemonUrl, methodName, params, &result);
    } catch (std::exception & e) {
        WLOG << "Error on XML-RPC " << methodName << "() call: " << e.what();
        return(false);
    }
    return(true);
}

bool
HcrdrxRpcClient::zeroPentekMotorCounts() {
    xmlrpc_c::value result;
    return(_execXmlRpcCall("zeroPentekMotorCounts", result));
}

bool
HcrdrxRpcClient::_useOperationMode(const OperationMode& opMode) {
    xmlrpc_c::value result;
    xmlrpc_c::paramList params;
    params.add(XmlrpcSerializable<OperationMode>(opMode));
    return(_execXmlRpcCall("setControllerSchedule", result, params));
}

bool
HcrdrxRpcClient::getStatus(DrxStatus & status) {
    xmlrpc_c::value result;
    if (! _execXmlRpcCall("getStatus", result)) {
        return(false);
    }
    // Convert the result into a DrxStatus object and return it in status
    xmlrpc_c::value_struct resultStruct(result);
    status = DrxStatus(resultStruct);
    return(true);
}

