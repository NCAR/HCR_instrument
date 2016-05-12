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
 * XmitdRpcClient.cpp
 *
 *  Created on: Mar 11, 2011
 *      Author: burghart
 */

#include "XmitdRpcClient.h"

#include <cerrno>
#include <cstdlib>
#include <cstring>
#include <sstream>
#include <logx/Logging.h>

LOGGING("XmitdRpcClient")

XmitdRpcClient::XmitdRpcClient(std::string xmitdHost, int xmitdPort) :
    _xmitdHost(xmitdHost),
    _xmitdPort(xmitdPort) {
    // Build the URL for hcr_xmitd, of the form:
    //    http://<xmitd_host>:<xmitd_port>/RPC2
    std::ostringstream ss;
    ss << "http://" << _xmitdHost << ":" << _xmitdPort << "/RPC2";
    _xmitdUrl = ss.str();
}

XmitdRpcClient::~XmitdRpcClient() {
}

bool
XmitdRpcClient::_executeXmlRpcCommand(const std::string cmd,
        xmlrpc_c::value * result) {
    try {
        DLOG << "Executing '" << cmd << "()' call";
        call(_xmitdUrl, cmd, "", result);
    } catch (std::exception & e) {
        WLOG << "Error on XML-RPC '" << cmd << "()' call: " << e.what();
        return(false);
    }
    return(true);
}

void
XmitdRpcClient::xmitFilamentOn() {
    xmlrpc_c::value result;
    _executeXmlRpcCommand("xmitFilamentOn", &result);
}

void
XmitdRpcClient::xmitFilamentOff() {
    xmlrpc_c::value result;
    _executeXmlRpcCommand("xmitFilamentOff", &result);
}

void
XmitdRpcClient::xmitHvOn() {
    xmlrpc_c::value result;
    _executeXmlRpcCommand("xmitHvOn", &result);
}

void
XmitdRpcClient::xmitHvOff() {
    xmlrpc_c::value result;
    _executeXmlRpcCommand("xmitHvOff", &result);
}

bool
XmitdRpcClient::getStatus(XmitStatus & status) {
    xmlrpc_c::value result;
    if (! _executeXmlRpcCommand("getStatus", &result)) {
        WLOG << __PRETTY_FUNCTION__ << ": getStatus failed!";
        return(false);
    }

    xmlrpc_c::value_struct statusDict(result);
    status = XmitStatus(statusDict);
    return(true);
}
