/*
 * MotionControlRpcClient.cpp
 *
 *  Created on: June 3, 2013
 *      Author: avaps
 */

#ifndef MOTIONCONTROLRPCCLIENT_H_
#define MOTIONCONTROLRPCCLIENT_H_

#include <xmlrpc-c/client_simple.hpp>
#include <string>

/// MotionControlRpcClient encapsulates an XML-RPC connection
/// to a MotionControlDaemon process.
class MotionControlRpcClient
{
public:
    /// Instantiate MotionControlRpcClient to communicate with a MotionControlDaemon
    /// process running on host daemonHost using port daemonPort.
    /// @param daemonHost the name of the host on which MotionControlDaemon is running
    /// @param daemonPort the port number being used by MotionControlDaemon
	MotionControlRpcClient(std::string daemonHost, int daemonPort);
    virtual ~MotionControlRpcClient();

    /// Point the antenna to a specific angle
    /// @param angle The angle that the antenna points to
    /// @throws std::exception if there's a problem in the XML-RPC call.
    void point(float angle) throw (std::exception);
	/// Scan the antenna between the given counterclockwise and clockwise
	/// limits, at the given scan rate.
	/// @param ccwLimit the counterclockwise limit of the scan, deg
	/// @param cwLimit the clockwise limit of the scan, deg
	/// @pararm scanRate the scan rate, deg/s
	void scan(float ccwLimit, float cwLimit, float scanRate) throw (std::exception);

private:
    std::string _daemonHost;
    int _daemonPort;
    std::string _daemonUrl;
    xmlrpc_c::clientSimple _client;

};

#endif /* MOTIONCONTROLRPCCLIENT_H_ */
