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

SpectracomRpcClient::SpectracomRpcClient(std::string spectracomHost,
        int spectracomPort) :
    _spectracomHost(spectracomHost),
    _spectracomPort(spectracomPort),
    _client() {
    // build _daemonUrl: "http://<_daemonHost>:<_daemonPort>/RPC2"
    std::ostringstream ss;
    ss << "http://" << _spectracomHost << ":" << _spectracomPort << "/RPC2";
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

