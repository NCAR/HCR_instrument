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

void
HcrPmc730Client::xmitFilamentOn() throw (girerr::error) {
    xmlrpc_c::value result;
    _client.call(_daemonUrl, "xmitFilamentOn", "", &result);
}

void
HcrPmc730Client::xmitFilamentOff() throw (girerr::error) {
    xmlrpc_c::value result;
    _client.call(_daemonUrl, "xmitFilamentOff", "", &result);
}

void
HcrPmc730Client::xmitHvOn() throw (girerr::error) {
    xmlrpc_c::value result;
    _client.call(_daemonUrl, "xmitHvOn", "", &result);
}

void
HcrPmc730Client::xmitHvOff() throw (girerr::error) {
    xmlrpc_c::value result;
    _client.call(_daemonUrl, "xmitHvOff", "", &result);
}

void
HcrPmc730Client::setHmcMode(int mode) throw (girerr::error) {
    xmlrpc_c::value result;
    _client.call(_daemonUrl, "setHmcMode", "i", &result, mode);
}

bool
HcrPmc730Client::getStatus(HcrPmc730Status & status) throw (girerr::error) {
    xmlrpc_c::value result;
    // _client.call() will throw a girerr::error exception on RPC failure
    _client.call(_daemonUrl, "getStatus", "", &result);
    xmlrpc_c::value_struct statusDict = xmlrpc_c::value_struct(result);
    status = HcrPmc730Status(statusDict);
    return(true);
}
