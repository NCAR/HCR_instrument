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
    _daemonHost(daemonHost),
    _daemonPort(daemonPort),
    _client() {
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
        _client.call(_daemonUrl, "getStatus", "", &result);
    } catch (std::exception & e) {
        WLOG << "Error on XML-RPC getStatus() call: " << e.what();
        return(false);
    }
    xmlrpc_c::value_struct resultStruct(result);
    status = SpectracomStatus(resultStruct);
    return(true);
}

