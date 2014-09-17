/*
 * HcrPmc730Client.h
 *
 *  Created on: Aug 9, 2013
 *      Author: hcr
 */

#ifndef HCRPMC730CLIENT_H_
#define HCRPMC730CLIENT_H_

#include <string>
#include <HcrPmc730Status.h>
#include <xmlrpc-c/client_simple.hpp>

class HcrPmc730Client {
public:
    HcrPmc730Client(std::string daemonHost, int daemonPort);
    virtual ~HcrPmc730Client();
    /// @brief Return the daemon host name
    /// @return the daemon host name
    std::string getDaemonHost() const { return(_daemonHost); }

    /// @brief Return the daemon port number
    /// @return the daemon port number
    int getDaemonPort() const { return(_daemonPort); }

    /// @brief Send a "getStatus" command and return a HcrPmc730Status object.
    /// @throws exception on XML-RPC error
    /// @return Return status obtained from HcrPmc730Daemon. On XML-RPC error,
    /// an exception is thrown.
    HcrPmc730Status getStatus();

    /// @brief Send an "xmitFilamentOn" command to HcrPmc730Daemon
    /// @throws exception on XML-RPC error
    void xmitFilamentOn();

    /// @brief Send a "xmitFilamentOff" command to HcrPmc730Daemon
    /// @throws exception on XML-RPC error
    void xmitFilamentOff();

    /// @brief Send an "xmitHvOn" command to HcrPmc730Daemon
    /// @throws exception on XML-RPC error
    void xmitHvOn();

    /// @brief Send a "xmitHvOff" command to HcrPmc730Daemon
    /// @throws exception on XML-RPC error
    void xmitHvOff();

    /// @brief Send "setHmcMode" command to HcrPmc730Daemon
    /// @param mode integer mode number for the HMC, 0-7
    /// @throws exception on XML-RPC error
    void setHmcMode(int mode);

private:
    /// @brief Execute an XML-RPC method call and return the result.
    /// @param methodName the name of the XML-RPC method to execute
    /// @param params the list of params to pass for the method
    /// @return the result
    /// @throw std::exception if there's an error executing the XML-RPC request
    xmlrpc_c::value _execXmlRpcCall(std::string methodName, 
            xmlrpc_c::paramList = xmlrpc_c::paramList());
    
    std::string _daemonHost;
    int _daemonPort;
    std::string _daemonUrl;
    xmlrpc_c::clientSimple _client;
};

#endif /* HCRPMC730CLIENT_H_ */
