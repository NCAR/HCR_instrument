/*
 * HcrdrxRpcClient.h
 *
 *  Created on: August 13, 2012
 *      Author: burghart
 */

#ifndef HCRDRXRPCCLIENT_H_
#define HCRDRXRPCCLIENT_H_

#include <XmlRpc.h>
#include <string>
#include "DrxStatus.h"

/**
 * HcrdrxRpcClient encapsulates an XML-RPC connection to an hcrdrx
 * process.
 */
class HcrdrxRpcClient : private XmlRpc::XmlRpcClient {
public:
    /**
     * Instantiate HcrdrxRpcClient to communicate with an hcrdrx process running
     * on host hcrdrxHost and using port hcrdrxPort.
     * @param hcrdrxHost the name of the host on which hcrdrx is running
     * @param hcrdrxPort the port number being used by hcrdrx
     */
    HcrdrxRpcClient(std::string hcrdrxHost, int hcrdrxPort);
    virtual ~HcrdrxRpcClient();
    
    /**
     * @brief Return the current ClientConnectionState connection state, which
     * can be: NO_CONNECTION, CONNECTING, WRITE_REQUEST, READ_HEADER,
     * READ_RESPONSE, or IDLE.
     * @return the current ClientConnectionState connection state, which
     * can be: NO_CONNECTION, CONNECTING, WRITE_REQUEST, READ_HEADER,
     * READ_RESPONSE, or IDLE.
     */
    ClientConnectionState connectionState() const { return(_connectionState); }

    /// @brief Send an "xmitFilamentOn" command to hcrdrx
    void xmitFilamentOn();
    
    /// @brief Send a "xmitFilamentOff" command to hcrdrx
    void xmitFilamentOff();
    
    /// @brief Send an "xmitHvOn" command to hcrdrx
    void xmitHvOn();
    
    /// @brief Send a "xmitHvOff" command to hcrdrx
    void xmitHvOff();
    
    /// @brief Send "setHmcMode" command to hcrdrx
    /// @param mode integer mode number for the HMC, 0-3
    void setHmcMode(int mode);

    /**
     * @brief Send a "getStatus" command, filling a HcrdrxRpcClient::Status
     * object if we get status from the hcrdrx.
     * @param status the HcrdrxRpcClient::Status object to be filled
     * @return true and fill the status object if status is obtained from
     * hcrdrx, otherwise return false and leave the status object
     * unmodified.
     */
    bool getStatus(DrxStatus & status);
    
    /**
     * Get the port number of the associated hcrdrx.
     * @return the port number of the associated hcrdrx.
     */
    int getHcrdrxPort() { return(_hcrdrxPort); }
    
    /**
     * Get the name of the host on which the associated hcrdrx is running.
     * @return the name of the host on which the associated hcrdrx is running.
     */
    std::string getHcrdrxHost() { return(_hcrdrxHost); }
    
    /**
     * Get log messages from the associated hcrdrx at and after a selected
     * index.
     * @param firstIndex[in] the first message index to include in the returned
     * log messages
     * @param msgs[out] all log messages at or later than the selected start index
     * will be appended to msgs
     * @param nextLogIndex[out] the index of the next log message after the last
     * available message is returned in nextLogIndex
     */
    void getLogMessages(unsigned int firstIndex, std::string & msgs, 
            unsigned int  & nextLogIndex);
private:
    /**
     * Execute an XML-RPC command in hcrdrx and get the result.
     * @param cmd the XML-RPC command to execute
     * @param params XmlRpc::XmlRpcValue list of parameters for the command
     * @param result reference to XmlRpc::XmlRpcValue to hold the command result
     * @return true iff the command was executed successfully
     */
    bool _executeXmlRpcCommand(const std::string cmd, 
        const XmlRpc::XmlRpcValue & params, XmlRpc::XmlRpcValue & result);
    
    std::string _hcrdrxHost;
    int _hcrdrxPort;
};

#endif /* HCRDRXRPCCLIENT_H_ */
