/*
 * HcrPmc730Client.cpp
 *
 *  Created on: Aug 9, 2013
 *      Author: hcr
 */
#include <sstream>
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
    xmlrpc_c::value_struct statusDict = xmlrpc_c::value_struct(result);
    HcrPmc730Status status(statusDict);
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
