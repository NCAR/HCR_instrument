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
    /// Move (Scan) the antenna from angle A to angle B
    /// @param angleA The starting angle
    /// @param angleB The ending angle
    /// @throws std::exception if there's a problem in the XML-RPC call.
    void scan(int angleA, int angleB) throw (std::exception);

private:
    std::string _daemonHost;
    int _daemonPort;
    std::string _daemonUrl;
    xmlrpc_c::clientSimple _client;

};

#endif /* MOTIONCONTROLRPCCLIENT_H_ */
