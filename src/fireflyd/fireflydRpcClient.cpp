/*
 * fireflydRpcClient.cpp
 *
 *  Created on: August 13, 2012
 *      Author: burghart
 */

#include "fireflydRpcClient.h"

#include <cstdlib>
#include <logx/Logging.h>

LOGGING("fireflydRpcClient")

fireflydRpcClient::fireflydRpcClient(std::string fireflydHost,
        int fireflydPort) :
    _fireflydHost(fireflydHost),
    _fireflydPort(fireflydPort),
    _client() {
    // build _daemonUrl: "http://<_daemonHost>:<_daemonPort>/RPC2"
    std::ostringstream ss;
    ss << "http://" << _fireflydHost << ":" << _fireflydPort << "/RPC2";
    _daemonUrl = ss.str();
    ILOG << "fireflydRpcClient on " << _daemonUrl;
}

fireflydRpcClient::~fireflydRpcClient() {
}

bool
fireflydRpcClient::getStatus(FireFlyStatus & status) {
    xmlrpc_c::value result;
    try {
        _client.call(_daemonUrl, "getStatus", "", &result);
    } catch (std::exception & e) {
        WLOG << "Error on XML-RPC getStatus() call: " << e.what();
        return(false);
    }
    xmlrpc_c::value_struct resultStruct(result);
    status = FireFlyStatus(resultStruct);
    return(true);
}

