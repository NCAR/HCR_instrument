/*
 * fireflydRpcClient.h
 *
 *  Created on: April 1, 2014
 *      Author: burghart
 */

#ifndef FIREFLYDRPCCLIENT_H_
#define FIREFLYDRPCCLIENT_H_

#include <xmlrpc-c/client_simple.hpp>
#include <string>
#include "FireFlyStatus.h"

/**
 * fireflydRpcClient encapsulates an XML-RPC connection to a fireflyd
 * process.
 */
class fireflydRpcClient {
public:
    /// Instantiate fireflydRpcClient to communicate with a fireflyd process
    /// running
    /// on host fireflydHost and using port fireflydPort.
    /// @param fireflydHost the name of the host on which fireflyd is running
    /// @param fireflydPort the port number being used by fireflyd
    fireflydRpcClient(std::string fireflydHost, int fireflydPort);
    virtual ~fireflydRpcClient();
    
    /**
     * @brief Send a "getStatus" command, filling a FireFlyStatus
     * object if we get status from the fireflyd.
     * @param status the fireflydRpcClient::Status object to be filled
     * @return true and fill the status object if status is obtained from
     * fireflyd, otherwise return false and leave the status object
     * unmodified.
     * @return true iff the XML-RPC call executes, otherwise return false.
     */
    bool getStatus(FireFlyStatus & status);
    
    /**
     * Get the port number of the associated fireflyd.
     * @return the port number of the associated fireflyd.
     */
    int getFireflydPort() { return(_fireflydPort); }
    
    /**
     * Get the name of the host on which the associated fireflyd is running.
     * @return the name of the host on which the associated fireflyd is running.
     */
    std::string getFireflydHost() { return(_fireflydHost); }
    
private:
    std::string _fireflydHost;
    int _fireflydPort;
    std::string _daemonUrl;
    xmlrpc_c::clientSimple _client;
};

#endif /* FIREFLYDRPCCLIENT_H_ */
