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
    const xmlrpc_c::value & params, xmlrpc_c::value * result) {
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
    xmlrpc_c::value null;
    xmlrpc_c::value result;
    _executeXmlRpcCommand("xmitFilamentOn", null, &result);
}

void
XmitdRpcClient::xmitFilamentOff() {
    xmlrpc_c::value null;
    xmlrpc_c::value result;
    _executeXmlRpcCommand("xmitFilamentOff", null, &result);
}

void
XmitdRpcClient::xmitHvOn() {
    xmlrpc_c::value null;
    xmlrpc_c::value result;
    _executeXmlRpcCommand("xmitHvOn", null, &result);
}

void
XmitdRpcClient::xmitHvOff() {
    xmlrpc_c::value null;
    xmlrpc_c::value result;
    _executeXmlRpcCommand("xmitHvOff", null, &result);
}

bool
XmitdRpcClient::getStatus(XmitStatus & status) {
    xmlrpc_c::value null;
    xmlrpc_c::value result;
    if (! _executeXmlRpcCommand("getStatus", null, &result)) {
        WLOG << __PRETTY_FUNCTION__ << ": getStatus failed!";
        return(false);
    }

    xmlrpc_c::value_struct statusDict(result);
    status = XmitStatus(statusDict);
    return(true);
}
