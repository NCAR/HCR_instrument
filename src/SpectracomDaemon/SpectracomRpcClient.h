/*
 * SpectracomRpcClient.h
 *
 *  Created on: April 1, 2014
 *      Author: burghart
 */

#ifndef SPECTRACOMRPCCLIENT_H_
#define SPECTRACOMRPCCLIENT_H_

#include <xmlrpc-c/client_simple.hpp>
#include <string>
#include "SpectracomStatus.h"

/**
 * SpectracomRpcClient encapsulates an XML-RPC connection to a Spectracom
 * process.
 */
class SpectracomRpcClient {
public:
    /// Instantiate SpectracomRpcClient to communicate with a SpectracomDaemon 
    /// process running on host spectracomHost and using port spectracomPort.
    /// @param spectracomHost the name of the host on which spectracom is 
    /// running
    /// @param spectracomPort the port number being used by spectracom
    SpectracomRpcClient(std::string spectracomHost, int spectracomPort);
    virtual ~SpectracomRpcClient();
    
    /// @brief Send a "getStatus" command, filling a FireFlyStatus
    /// object if we get status from the SpectracomDaemon.
    /// @param status the SpectracomRpcClient::Status object to be filled
    /// @return true and fill the status object if status is obtained from
    /// Spectracom, otherwise return false and leave the status object
    /// unmodified.
    /// @return true iff the XML-RPC call executes, otherwise return false.
    bool getStatus(SpectracomStatus & status);
    
    /// Get the port number of the associated SpectracomDaemon.
    /// @return the port number of the associated SpectracomDaemon.
    int getSpectracomPort() { return(_spectracomPort); }
    

    /// Get the name of the host on which the associated SpectracomDaemon is 
    /// running.
    /// @return the name of the host on which the associated SpectracomDaemon 
    /// is running.
    std::string getFireflydHost() { return(_spectracomHost); }
    
private:
    std::string _spectracomHost;
    int _spectracomPort;
    std::string _daemonUrl;
    xmlrpc_c::clientSimple _client;
};

#endif /* SPECTRACOMRPCCLIENT_H_ */
