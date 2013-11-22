/*
 * CmigitsDaemonRpcClient.cpp
 *
 *  Created on: August 13, 2012
 *      Author: burghart
 */

#include "CmigitsDaemonRpcClient.h"

#include <iostream>
#include <sstream>
#include <cstdlib>
#include <logx/Logging.h>

LOGGING("CmigitsDaemonRpcClient")

CmigitsDaemonRpcClient::CmigitsDaemonRpcClient(std::string daemonHost,
        int daemonPort) :
    _daemonHost(daemonHost),
    _daemonPort(daemonPort),
    _client() {
    // build _daemonUrl: "http://<_daemonHost>:<_daemonPort>/RPC2"
    std::ostringstream ss;
    ss << "http://" << _daemonHost << ":" << _daemonPort << "/RPC2";
    _daemonUrl = ss.str();
    ILOG << "CmigitsDaemonRpcClient on " << _daemonUrl;
}

CmigitsDaemonRpcClient::~CmigitsDaemonRpcClient() {
}

bool
CmigitsDaemonRpcClient::initializeUsingIwg1() throw (std::exception) {
    try {
        xmlrpc_c::value result;
        // _client.call() may throw a girerr::error exception (a subclass
        // of std::exception). If so, we allow it to move up the chain.
        _client.call(_daemonUrl, "initializeUsingIwg1", "", &result);
        return(xmlrpc_c::value_boolean(result));
    } catch (std::exception & e) {
        WLOG << "XML-RPC call to initializeUsingIwg1() failed: " << e.what();
        throw; // rethrow the exception
    }
}

CmigitsStatus
CmigitsDaemonRpcClient::getStatus() throw (std::exception) {
    try {
        xmlrpc_c::value result;
        // _client.call() may throw a girerr::error exception (a subclass
        // of std::exception). If so, we allow it to move up the chain.
        _client.call(_daemonUrl, "getStatus", "", &result);
        // The getStatus() XML-RPC method returns xmlrpc_c::value_struct, 
        // which we can use to (re)construct the CmigitsStatus.
        xmlrpc_c::value_struct dict(result);
        CmigitsStatus status(dict);
        return(status);
    } catch (std::exception & e) {
        WLOG << "XML-RPC call to initializeUsingIwg1() failed: " << e.what();
        throw; // rethrow the exception
    }
}
