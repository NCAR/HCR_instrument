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
    std::cout << "_daemonUrl = " << _daemonUrl << std::endl;
}

/////////////////////////////////////////////////////////////////////
MotionControlRpcClient::~MotionControlRpcClient()
{
}

/////////////////////////////////////////////////////////////////////
void
MotionControlRpcClient::point(int angle) throw (std::exception)
{
	std::cout << "point() to " << angle << std::endl;

	xmlrpc_c::value result;
	_client.call(_daemonUrl, "Point", "i", &result, angle);
}

/////////////////////////////////////////////////////////////////////
void
MotionControlRpcClient::scan(int angleA, int angleB) throw (std::exception)
{
	std::cout << "scan() from " << angleA << " to " << angleB << std::endl;

	xmlrpc_c::value result;
	_client.call(_daemonUrl, "Scan", "ii", &result, angleA, angleB);
}
