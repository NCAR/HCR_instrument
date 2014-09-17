/*
 * MotionControlRpcClient.cpp
 *
 *  Created on: June 3, 2013
 *      Author: avaps
 */

#include <cstdlib>
#include <iostream>
#include <sstream>
#include <math.h>
#include "MotionControlRpcClient.h"
#include <logx/Logging.h>

LOGGING("MotionControlRpcClient")

/////////////////////////////////////////////////////////////////////
MotionControlRpcClient::MotionControlRpcClient(
		std::string daemonHost,
        int daemonPort) :
        _daemonResponding(false),
        _client() {
    // build _daemonUrl: "http://<_daemonHost>:<_daemonPort>/RPC2"
    std::ostringstream ss;
    ss << "http://" << daemonHost << ":" << daemonPort << "/RPC2";
    _daemonUrl = ss.str();
    ILOG << "MotionControlRpcClient talking to " << _daemonUrl;
}

/////////////////////////////////////////////////////////////////////
MotionControlRpcClient::~MotionControlRpcClient()
{
}

xmlrpc_c::value
MotionControlRpcClient::_execXmlRpcCall(std::string methodName, 
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
        throw;
    }
}

/////////////////////////////////////////////////////////////////////
void
MotionControlRpcClient::homeDrive()
{
	ILOG << "homeDrive()";
	_execXmlRpcCall("Home");
}

/////////////////////////////////////////////////////////////////////
void
MotionControlRpcClient::point(float angle)
{
	ILOG << "point() to " << angle;

	xmlrpc_c::paramList params;
	params.add(xmlrpc_c::value_double(angle));
	_execXmlRpcCall("Point", params);
}

/////////////////////////////////////////////////////////////////////
void
MotionControlRpcClient::scan(float ccwLimit, float cwLimit, float scanRate,
        float beamTilt)
{
	ILOG << "scan() between " << ccwLimit << " and " << cwLimit << " at " << 
	        scanRate << " deg/s, with beam tilt " << beamTilt;
	
	xmlrpc_c::paramList params;
    params.add(xmlrpc_c::value_double(ccwLimit));
    params.add(xmlrpc_c::value_double(cwLimit));
    params.add(xmlrpc_c::value_double(scanRate));
    params.add(xmlrpc_c::value_double(beamTilt));
	_execXmlRpcCall("Scan", params);
}

/////////////////////////////////////////////////////////////////////
void
MotionControlRpcClient::setCorrectionEnabled(bool state)
{
    ILOG << (state ? "enabling" : "disabling") << " attitude correction";
    
    xmlrpc_c::paramList params;
    params.add(xmlrpc_c::value_boolean(state));
    _execXmlRpcCall("SetCorrectionEnabled", params);
}

/////////////////////////////////////////////////////////////////////
MotionControl::Status
MotionControlRpcClient::status()
{
    xmlrpc_c::value result = _execXmlRpcCall("Status");
    // Construct an xmlrpc_c::value_struct from the result, and use that
    // to construct the  MotionControl::Status which we return.
    xmlrpc_c::value_struct vStruct(result);
    return(MotionControl::Status(vStruct));
}

/////////////////////////////////////////////////////////////////////
bool
MotionControlRpcClient::homingInProgress()
{
    xmlrpc_c::value result = _execXmlRpcCall("HomingInProgress");
    // Construct an xmlrpc_c::value_boolean from the result, and return
    // the associated C boolean value.
    return(bool(xmlrpc_c::value_boolean(result)));
}
