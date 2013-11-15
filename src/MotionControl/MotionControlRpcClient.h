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

    /// @brief Set drives to home position
    /// @throws std::exception if there's a problem in the XML-RPC call.
    void homeDrive() throw (std::exception);

    /// @brief Point the antenna to a specific angle
    /// @param angle The angle that the antenna points to
    /// @throws std::exception if there's a problem in the XML-RPC call.
    void point(float angle) throw (std::exception);

	/// @brief Scan the antenna between the given counterclockwise and clockwise
	/// limits, at the given scan rate.
	/// @param ccwLimit the counterclockwise limit of the scan, deg
	/// @param cwLimit the clockwise limit of the scan, deg
	/// @param scanRate the scan rate, deg/s
    /// @param beamTilt the beam tilt angle, deg
    /// @throws std::exception if there's a problem in the XML-RPC call.
	void scan(float ccwLimit, float cwLimit, float scanRate, 
	        float beamTilt) throw (std::exception);

    /// @brief Set the on/off state of attitude correction
    /// @param state the desired state for attitude correction
    /// @throws std::exception if there's a problem in the XML-RPC call.
    void setCorrectionEnabled(bool state) throw (std::exception);

    /// @brief Get motion control status
    /// @return a MotionControlStatus object
    /// @throws std::exception if there's a problem in the XML-RPC call.
    MotionControl::Status status() throw (std::exception);

    /// @brief Return true iff homing is in progress for either of the drives.
    /// @return true iff homing is in progress for either of the drives.
    /// @throws std::exception if there's a problem in the XML-RPC call.
    bool homingInProgress() throw (std::exception);

	/// @brief Return true iff the MotionControlDaemon is responding.
	/// @return true iff the MotionControlDaemon is responding.
	bool daemonResponding() const { return(_daemonResponding); }

	/// @brief Return the URL used to communicate with MotionControlDaemon.
	/// @return the URL used to communicate with MotionControlDaemon.
	std::string daemonUrl() const { return(_daemonUrl); }

private:
	bool _daemonResponding;
	std::string _daemonUrl;
    xmlrpc_c::clientSimple _client;
};

#endif /* MOTIONCONTROLRPCCLIENT_H_ */
