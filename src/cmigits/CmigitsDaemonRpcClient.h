/*
 * CmigitsDaemonRpcClient.h
 *
 *  Created on: August 13, 2012
 *      Author: burghart
 */

#ifndef CMIGITSDAEMONRPCCLIENT_H_
#define CMIGITSDAEMONRPCCLIENT_H_

#include <xmlrpc-c/client_simple.hpp>
#include <string>
#include <CmigitsStatus.h>

/**
 * CmigitsDaemonRpcClient encapsulates an XML-RPC connection to a cmigitsDaemon
 * process.
 */
class CmigitsDaemonRpcClient {
public:
    /**
     * @brief Construct a CmigitsDaemonRpcClient to communicate with a 
     * cmigitsDaemon process running on host daemonHost and using port
     * daemonPort.
     * @param daemonHost the name of the host on which cmigitsDaemon is running
     * @param daemonPort the port number being used by cmigitsDaemon
     */
    CmigitsDaemonRpcClient(std::string daemonHost, int daemonPort);
    virtual ~CmigitsDaemonRpcClient();

    /**
     * @brief Send InitializeUsingIwg1() command and return the result.
     * @return true if the initialization process is started.
     * @throws std::exception if there's a problem executing the XML-RPC
     * call.
     */
    bool initializeUsingIwg1() throw (std::exception);
    
    /**
     * @brief Get current status from the cmigitsDaemon via a getStatus() 
     * XML-RPC call.
     * @return current CmigitsStatus from the cmigitsDaemon
     * @throws std::exception if there's a problem executing the XML-RPC
     * call.
     */
    CmigitsStatus getStatus() throw (std::exception);
    
    /**
     * Get the port number of the associated cmigitsDaemon.
     * @return the port number of the associated cmigitsDaemon.
     */
    int getDaemonPort() { return(_daemonPort); }
    
    /**
     * Get the name of the host on which the associated cmigitsDaemon is running.
     * @return the name of the host on which the associated cmigitsDaemon is running.
     */
    std::string getDaemonHost() { return(_daemonHost); }
    
//    /**
//     * Get log messages from the associated cmigitsDaemon at and after a selected
//     * index.
//     * @param[in] firstIndex the first message index to include in the returned
//     * log messages
//     * @param[out] msgs all log messages at or later than the selected start index
//     * will be appended to msgs
//     * @param[out] nextLogIndex the index of the next log message after the last
//     * available message is returned in nextLogIndex
//     */
//    void getLogMessages(unsigned int firstIndex, std::string & msgs, 
//            unsigned int  & nextLogIndex);
private:
    std::string _daemonHost;
    int _daemonPort;
    std::string _daemonUrl;
    xmlrpc_c::clientSimple _client;
};

#endif /* CMIGITSDAEMONRPCCLIENT_H_ */
