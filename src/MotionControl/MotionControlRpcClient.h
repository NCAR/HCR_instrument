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
#include "MotionControl.h"

/// MotionControlRpcClient encapsulates an XML-RPC connection
/// to a MotionControlDaemon process.
class MotionControlRpcClient
{
public:
    /// @brief Instantiate MotionControlRpcClient to communicate with a
	/// MotionControlDaemon process running on host daemonHost using port
	/// daemonPort.
    /// @param daemonHost the name of the host on which MotionControlDaemon is running
    /// @param daemonPort the port number being used by MotionControlDaemon
	MotionControlRpcClient(std::string daemonHost, int daemonPort);
    virtual ~MotionControlRpcClient();

    /// @brief Point the antenna to a specific angle
    /// @param angle The angle that the antenna points to
    /// @throws std::exception if there's a problem in the XML-RPC call.
    void point(float angle) throw (std::exception);

	/// @brief Scan the antenna between the given counterclockwise and clockwise
	/// limits, at the given scan rate.
	/// @param ccwLimit the counterclockwise limit of the scan, deg
	/// @param cwLimit the clockwise limit of the scan, deg
	/// @param scanRate the scan rate, deg/s
    /// @throws std::exception if there's a problem in the XML-RPC call.
	void scan(float ccwLimit, float cwLimit, float scanRate) throw (std::exception);

	/// @brief Get motion control status
	/// @return a MotionControlStatus object
    /// @throws std::exception if there's a problem in the XML-RPC call.
	MotionControl::Status status() throw (std::exception);

	/// @brief Return true iff the MotionControlDaemon is responding.
	/// @return true iff the MotionControlDaemon is responding.
	bool daemonResponding() const { return(_daemonResponding); }

private:
	bool _daemonResponding;
	std::string _daemonUrl;
    xmlrpc_c::clientSimple _client;
};

#endif /* MOTIONCONTROLRPCCLIENT_H_ */
