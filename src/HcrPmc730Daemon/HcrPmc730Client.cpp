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

bool
HcrPmc730Client::xmitFilamentOn() {
    try {
        xmlrpc_c::value result;
        _client.call(_daemonUrl, "xmitFilamentOn", "", &result);
    } catch (std::exception & e) {
        WLOG << "Error on XML-RPC xmitFilamentOn() call: " << e.what();
        return(false);
    }
    return(true);
}

bool
HcrPmc730Client::xmitFilamentOff() {
    try {
        xmlrpc_c::value result;
        _client.call(_daemonUrl, "xmitFilamentOff", "", &result);
    } catch (std::exception & e) {
        WLOG << "Error on XML-RPC xmitFilamentOff() call: " << e.what();
        return(false);
    }
    return(true);
}

bool
HcrPmc730Client::xmitHvOn() {
    try {
        xmlrpc_c::value result;
        _client.call(_daemonUrl, "xmitHvOn", "", &result);
    } catch (std::exception & e) {
        WLOG << "Error on XML-RPC xmitHvOn() call: " << e.what();
        return(false);
    }
    return(true);
}

bool
HcrPmc730Client::xmitHvOff() {
    try {
        xmlrpc_c::value result;
        _client.call(_daemonUrl, "xmitHvOff", "", &result);
    } catch (std::exception & e) {
        WLOG << "Error on XML-RPC xmitHvOff() call: " << e.what();
        return(false);
    }
    return(true);
}

bool
HcrPmc730Client::setHmcMode(int mode) {
    try {
        xmlrpc_c::value result;
        _client.call(_daemonUrl, "setHmcMode", "i", &result, mode);
    } catch (std::exception & e) {
        WLOG << "Error on XML-RPC setHmcMode() call: " << e.what();
        return(false);
    }
    return(true);
}

bool
HcrPmc730Client::getStatus(HcrPmc730Status & status) {
    try {
        xmlrpc_c::value result;
        // _client.call() will throw a girerr::error exception on RPC failure
        _client.call(_daemonUrl, "getStatus", "", &result);
        xmlrpc_c::value_struct statusDict = xmlrpc_c::value_struct(result);
        status = HcrPmc730Status(statusDict);
    } catch (std::exception & e) {
        WLOG << "Error on XML-RPC getStatus() call: " << e.what();
        return(false);
    }
    return(true);
}
