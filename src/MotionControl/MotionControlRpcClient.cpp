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

/////////////////////////////////////////////////////////////////////
void
MotionControlRpcClient::homeDrive() throw (std::exception)
{
	ILOG << "homeDrive()";
	_daemonResponding = true;

	try {
		xmlrpc_c::value result;
		_client.call(_daemonUrl, "Home", &result);
	}
	catch (std::exception & e) {
		_daemonResponding = false;
		WLOG << "XML-RPC error calling Home(): " << e.what();
	}
}

/////////////////////////////////////////////////////////////////////
void
MotionControlRpcClient::point(float angle) throw (std::exception)
{
	ILOG << "point() to " << angle;
	_daemonResponding = true;

	try {
		xmlrpc_c::value result;
		_client.call(_daemonUrl, "Point", "d", &result, angle);
	}
	catch (std::exception & e) {
		_daemonResponding = false;
		WLOG << "XML-RPC error calling Point(): " << e.what();
	}
}

/////////////////////////////////////////////////////////////////////
void
MotionControlRpcClient::scan(float ccwLimit, float cwLimit, float scanRate,
        float beamTilt)
throw (std::exception)
{
	ILOG << "scan() between " << ccwLimit << " and " << cwLimit << " at " << 
	        scanRate << " deg/s, with beam tilt " << beamTilt;
	_daemonResponding = true;

	try {
		xmlrpc_c::value result;
		_client.call(_daemonUrl, "Scan", "ddd", &result, ccwLimit, cwLimit, 
		        scanRate, beamTilt);
	}
	catch (std::exception & e) {
		_daemonResponding = false;
		WLOG << "XML-RPC error calling Scan(): " << e.what();
	}
}

/////////////////////////////////////////////////////////////////////
void
MotionControlRpcClient::setCorrectionEnabled(bool state)
throw (std::exception)
{
    ILOG << (state ? "enabling" : "disabling") << " attitude correction";
    _daemonResponding = true;

    try {
        xmlrpc_c::value result;
        _client.call(_daemonUrl, "SetCorrectionEnabled", "b", &result, state);
    }
    catch (std::exception & e) {
        _daemonResponding = false;
        WLOG << "XML-RPC error calling SetCorrectionEnabled(): " << e.what();
    }
}

/////////////////////////////////////////////////////////////////////
MotionControl::Status
MotionControlRpcClient::status()
throw (std::exception)
{
    _daemonResponding = true;
    try {
        xmlrpc_c::value result;
        _client.call(_daemonUrl, "Status", "", &result);
        // Construct an xmlrpc_c::value_struct from the result, and use that
        // to construct the  MotionControl::Status which we return.
        xmlrpc_c::value_struct vstruct(result);
        return(MotionControl::Status(vstruct));
    }
    catch (std::exception & e) {
        _daemonResponding = false;
        WLOG << "XML-RPC error calling Status(): " << e.what();
    }
    return(MotionControl::Status());
}

/////////////////////////////////////////////////////////////////////
bool
MotionControlRpcClient::homingInProgress()
throw (std::exception)
{
    xmlrpc_c::value result;
    _client.call(_daemonUrl, "HomingInProgress", "", &result);
    // Construct an xmlrpc_c::value_struct from the result, and use that
    // to construct the  MotionControl::Status which we return.
    xmlrpc_c::value_boolean boolResult(result);
    return(bool(boolResult));
}
