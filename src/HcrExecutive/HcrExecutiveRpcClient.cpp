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
 * HcrExecutiveRpcClient.cpp
 *
 *  Created on: Oct 28, 2014
 *      Author: burghart
 */

#include <cstdlib>
#include <iostream>
#include <sstream>
#include <math.h>
#include <logx/Logging.h>
#include "HcrExecutiveRpcClient.h"

LOGGING("HcrExecutiveRpcClient")

HcrExecutiveRpcClient::HcrExecutiveRpcClient(
		std::string daemonHost,
        int daemonPort) :
        _daemonResponding(false),
        _client() {
    // build _daemonUrl: "http://<_daemonHost>:<_daemonPort>/RPC2"
    std::ostringstream ss;
    ss << "http://" << daemonHost << ":" << daemonPort << "/RPC2";
    _daemonUrl = ss.str();
    ILOG << "HcrExecutiveRpcClient talking to " << _daemonUrl;
}

HcrExecutiveRpcClient::~HcrExecutiveRpcClient() {
}

xmlrpc_c::value
HcrExecutiveRpcClient::_execXmlRpcCall(std::string methodName, 
        xmlrpc_c::paramList params)
{
    try {
        xmlrpc_c::value result;
        _client.call(_daemonUrl, methodName, params, &result);
        _daemonResponding = true;
        return(result);
    }
    catch (std::exception & e) {
        WLOG << "XML-RPC error calling " << methodName << "(): " << e.what();
        _daemonResponding = false;
        throw;
    }
}

void
HcrExecutiveRpcClient::setApsValveControl(ApsControl::ValveControlState state) {
    ILOG << "Setting APS valve control to " << state;

    xmlrpc_c::paramList params;
    params.add(xmlrpc_c::value_int(state));
    _execXmlRpcCall("setApsValveControl", params);
}

void
HcrExecutiveRpcClient::setRequestedOperationMode(HcrPmc730::OperationMode& mode) {
    ILOG << "Setting requested Operation mode to " << mode.name();

    xmlrpc_c::paramList params;
    params.add(XmlrpcSerializable<HcrPmc730::OperationMode>(mode));
    _execXmlRpcCall("setRequestedOperationMode", params);
}

void
HcrExecutiveRpcClient::setHvRequested(bool hvRequested) {
    ILOG << "Setting 'HV requested' to " << (hvRequested ? "true" : "false");

    xmlrpc_c::paramList params;
    params.add(xmlrpc_c::value_boolean(hvRequested));
    _execXmlRpcCall("setHvRequested", params);
}

HcrExecutiveStatus
HcrExecutiveRpcClient::status() {
    xmlrpc_c::value result = _execXmlRpcCall("getStatus");
    // Construct an xmlrpc_c::value_struct from the result, and use that
    // to construct the  HcrExecutiveStatus which we return.
    xmlrpc_c::value_struct vStruct(result);
    return(HcrExecutiveStatus(vStruct));
}
