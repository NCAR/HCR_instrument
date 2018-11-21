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
 * HcrPmc730Client.cpp
 *
 *  Created on: Aug 9, 2013
 *      Author: hcr
 */
#include <sstream>
#include <XmlrpcSerializable.h>
#include <logx/Logging.h>
#include "HcrPmc730Client.h"

LOGGING("HcrPmc730Client")

HcrPmc730Client::HcrPmc730Client(std::string daemonHost, int daemonPort) :
    _daemonHost(daemonHost),
    _daemonPort(daemonPort),
    _client() {
    // build _daemonUrl: "http://<_daemonHost>:<_daemonPort>/RPC2"
    std::ostringstream ss;
    ss << "http://" << _daemonHost << ":" << _daemonPort << "/RPC2";
    _daemonUrl = ss.str();
    ILOG << "HcrPmc730Client on " << _daemonUrl;
}

HcrPmc730Client::~HcrPmc730Client() {
}

xmlrpc_c::value
HcrPmc730Client::_execXmlRpcCall(std::string methodName, 
        xmlrpc_c::paramList params) {
    try {
        xmlrpc_c::value result;
        _client.call(_daemonUrl, methodName, params, &result);
        return(result);
    } catch (std::exception & e) {
        WLOG << "Error on XML-RPC " << methodName << "() call: " << e.what();
        throw; // rethrow the exception
    }
}

void
HcrPmc730Client::xmitFilamentOn() {
    _execXmlRpcCall("xmitFilamentOn");
}

void
HcrPmc730Client::xmitFilamentOff() {
    _execXmlRpcCall("xmitFilamentOff");
}

void
HcrPmc730Client::xmitHvOn() {
    _execXmlRpcCall("xmitHvOn");
}

void
HcrPmc730Client::xmitHvOff() {
    _execXmlRpcCall("xmitHvOff");
}

void
HcrPmc730Client::setHmcMode(HcrPmc730::HmcOperationMode mode) {
    xmlrpc_c::paramList params;
    params.add(xmlrpc_c::value_int(mode));
    _execXmlRpcCall("setHmcMode", params);
}

HcrPmc730Status
HcrPmc730Client::getStatus() {
    xmlrpc_c::value result = _execXmlRpcCall("getStatus");
    XmlrpcSerializable<HcrPmc730Status> status(result);
    return(status);
}

void
HcrPmc730Client::openApsValve() {
    _execXmlRpcCall("openApsValve");
}

void
HcrPmc730Client::closeApsValve() {
    _execXmlRpcCall("closeApsValve");
}
