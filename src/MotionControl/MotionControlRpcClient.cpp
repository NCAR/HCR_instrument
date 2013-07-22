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
_daemonHost(daemonHost),
_daemonPort(daemonPort),
_client() {
    // build _daemonUrl: "http://<_daemonHost>:<_daemonPort>/RPC2"
    std::ostringstream ss;
    ss << "http://" << _daemonHost << ":" << _daemonPort << "/RPC2";
    _daemonUrl = ss.str();
    ILOG << "MotionControlRpcClient on " << _daemonUrl;
}

/////////////////////////////////////////////////////////////////////
MotionControlRpcClient::~MotionControlRpcClient()
{
}

/////////////////////////////////////////////////////////////////////
void
MotionControlRpcClient::point(float angle) throw (std::exception)
{
	std::cout << "point() to " << angle << std::endl;

	try {
		xmlrpc_c::value result;
		_client.call(_daemonUrl, "Point", "d", &result, angle);
	}
	catch (std::exception & e) {
		WLOG << "XML-RPC error calling Point(): " << e.what();
	}
}

/////////////////////////////////////////////////////////////////////
void
MotionControlRpcClient::scan(float ccwLimit, float cwLimit, float scanRate)
throw (std::exception)
{
	std::cout << "scan() between " << ccwLimit << " and " << cwLimit << " at rate " << scanRate << std::endl;

	try {
		xmlrpc_c::value result;
		_client.call(_daemonUrl, "Scan", "ddd", &result, ccwLimit, cwLimit, scanRate);
	}
	catch (std::exception & e) {
		WLOG << "XML-RPC error calling Scan(): " << e.what();
	}
}

/////////////////////////////////////////////////////////////////////
MotionControl::Status
MotionControlRpcClient::status()
throw (std::exception)
{
	try {
		xmlrpc_c::value result;
		_client.call(_daemonUrl, "Status", "", &result);
		xmlrpc_c::value_struct vstruct = static_cast<xmlrpc_c::value_struct>(result);
		return(MotionControl::Status(vstruct));
	}
	catch (std::exception & e) {
		WLOG << "XML-RPC error calling Status(): " << e.what();
	}
	return(MotionControl::Status());
}
