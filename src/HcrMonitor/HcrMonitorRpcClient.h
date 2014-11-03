/*
 * HcrMonitorRpcClient.cpp
 *
 *  Created on: Oct 28, 2014
 *      Author: burghart
 */

#ifndef HCRMONITORRPCCLIENT_H_
#define HCRMONITORRPCCLIENT_H_

#include <xmlrpc-c/client_simple.hpp>
#include <string>
#include "HcrMonitorStatus.h"

/// MotionControlRpcClient encapsulates an XML-RPC connection to an HcrMonitor 
/// process.
class HcrMonitorRpcClient
{
public:
    /// @brief Instantiate HcrMonitorRpcClient to communicate with an
	/// HcrMonitor process running on host daemonHost using port
	/// daemonPort.
    /// @param daemonHost the name of the host on which HcrMonitor is running
    /// @param daemonPort the port number being used by HcrMonitor
	HcrMonitorRpcClient(std::string daemonHost, int daemonPort);
    virtual ~HcrMonitorRpcClient();

    /// @brief Set valve control state in the Active Pressurization System (APS)
    /// @param state the desired APS valve control state
    /// @throws std::exception if there's a problem in the XML-RPC call.
    void setApsValveControl(ApsControl::ValveControlState state);

    /// @brief Set the HMC mode
    /// @param mode the desired HmcOperationMode
    /// @throws std::exception if there's a problem in the XML-RPC call.
    void setHmcMode(HcrPmc730::HmcOperationMode mode);
    
    /// @brief Set the requested state for transmitter high voltage
    /// @param hvRequested true if high voltage is desired, false otherwise
    /// @throws std::exception if there's a problem in the XML-RPC call.
    void setHvRequested(bool hvRequested);

    /// @brief Get motion control status
    /// @return a HcrMonitorStatus object
    /// @throws std::exception if there's a problem in the XML-RPC call.
    HcrMonitorStatus status();

	/// @brief Return true iff the HcrMonitor is responding.
	/// @return true iff the HcrMonitor is responding.
	bool daemonResponding() const { return(_daemonResponding); }

	/// @brief Return the URL used to communicate with HcrMonitor.
	/// @return the URL used to communicate with HcrMonitor.
	std::string daemonUrl() const { return(_daemonUrl); }

private:
    /// @brief Execute an XML-RPC method call and return the result.
    /// @param methodName the name of the XML-RPC method to execute
    /// @param params the list of params to pass for the method
    /// @return the result
    /// @throw std::exception if there's an error executing the XML-RPC request
    xmlrpc_c::value _execXmlRpcCall(std::string methodName, 
            xmlrpc_c::paramList = xmlrpc_c::paramList());
    
	bool _daemonResponding;
	std::string _daemonUrl;
    xmlrpc_c::clientSimple _client;
};

#endif /* HCRMONITORRPCCLIENT_H_ */
