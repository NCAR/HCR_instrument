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
	catch (std::exception e) {
		WLOG << "XML-RPC error calling point(): " << e.what();
	}
}

/////////////////////////////////////////////////////////////////////
void
MotionControlRpcClient::scan(int angleA, int angleB) throw (std::exception)
{
	std::cout << "scan() from " << angleA << " to " << angleB << std::endl;

	try {
		xmlrpc_c::value result;
		_client.call(_daemonUrl, "Scan", "ii", &result, angleA, angleB);
	}
	catch (std::exception e) {
		WLOG << "XML-RPC error calling scan(): " << e.what();
	}
}
