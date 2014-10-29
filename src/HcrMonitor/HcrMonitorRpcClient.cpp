/*
 * HcrMonitorRpcClient.cpp
 *
 *  Created on: Oct 28, 2014
 *      Author: burghart
 */

#include <cstdlib>
#include <iostream>
#include <sstream>
#include <math.h>
#include "HcrMonitorRpcClient.h"
#include <logx/Logging.h>

LOGGING("HcrMonitorRpcClient")

/////////////////////////////////////////////////////////////////////
HcrMonitorRpcClient::HcrMonitorRpcClient(
		std::string daemonHost,
        int daemonPort) :
        _daemonResponding(false),
        _client() {
    // build _daemonUrl: "http://<_daemonHost>:<_daemonPort>/RPC2"
    std::ostringstream ss;
    ss << "http://" << daemonHost << ":" << daemonPort << "/RPC2";
    _daemonUrl = ss.str();
    ILOG << "HcrMonitorRpcClient talking to " << _daemonUrl;
}

/////////////////////////////////////////////////////////////////////
HcrMonitorRpcClient::~HcrMonitorRpcClient() {
}

xmlrpc_c::value
HcrMonitorRpcClient::_execXmlRpcCall(std::string methodName, 
        xmlrpc_c::paramList params)
{
    try {
        xmlrpc_c::value result;
        _client.call(_daemonUrl, methodName, params, &result);
        _daemonResponding = true;
        return(result);
    }
    catch (std::exception & e) {
        WLOG << "XML-RPC error calling " << methodName << "(): " << e.what();
        _daemonResponding = false;
        throw;
    }
}

/////////////////////////////////////////////////////////////////////
void
HcrMonitorRpcClient::setApsValveControl(ApsControl::ValveControlState state) {
	ILOG << "set APS valve control to " << state;

	xmlrpc_c::paramList params;
	params.add(xmlrpc_c::value_int(state));
	_execXmlRpcCall("setApsValveControl", params);
}

/////////////////////////////////////////////////////////////////////
HcrMonitorStatus
HcrMonitorRpcClient::status() {
    xmlrpc_c::value result = _execXmlRpcCall("getStatus");
    // Construct an xmlrpc_c::value_struct from the result, and use that
    // to construct the  HcrMonitorStatus which we return.
    xmlrpc_c::value_struct vStruct(result);
    return(HcrMonitorStatus(vStruct));
}
