/*
 * HcrdrxRpcClient.cpp
 *
 *  Created on: August 13, 2012
 *      Author: burghart
 */

#include "HcrdrxRpcClient.h"

#include <cstdlib>
#include <logx/Logging.h>

LOGGING("HcrdrxRpcClient")

HcrdrxRpcClient::HcrdrxRpcClient(std::string hcrdrxHost, int hcrdrxPort) :
    _hcrdrxHost(hcrdrxHost),
    _hcrdrxPort(hcrdrxPort),
    _client() {
    // build _daemonUrl: "http://<_daemonHost>:<_daemonPort>/RPC2"
    std::ostringstream ss;
    ss << "http://" << _hcrdrxHost << ":" << _hcrdrxPort << "/RPC2";
    _daemonUrl = ss.str();
    ILOG << "HcrdrxRpcClient on " << _daemonUrl;
}

HcrdrxRpcClient::~HcrdrxRpcClient() {
}

bool
HcrdrxRpcClient::_execXmlRpcCall(std::string methodName, 
        xmlrpc_c::value & result) {
    try {
        _client.call(_daemonUrl, methodName, "", &result);
    } catch (std::exception & e) {
        WLOG << "Error on XML-RPC " << methodName << "() call: " << e.what();
        return(false);
    }
    return(true);
}

bool
HcrdrxRpcClient::zeroPentekMotorCounts() {
    xmlrpc_c::value result;
    return(_execXmlRpcCall("zeroPentekMotorCounts", result));
}

bool
HcrdrxRpcClient::getStatus(DrxStatus & status) {
    xmlrpc_c::value result;
    if (! _execXmlRpcCall("getStatus", result)) {
        return(false);
    }
    // Convert the result into a DrxStatus object and return it in status
    xmlrpc_c::value_struct resultStruct(result);
    status = DrxStatus(resultStruct);
    return(true);
}

