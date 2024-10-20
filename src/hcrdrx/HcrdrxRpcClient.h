// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2016                                         
// ** University Corporation for Atmospheric Research (UCAR)                 
// ** National Center for Atmospheric Research (NCAR)                        
// ** Boulder, Colorado, USA                                                 
// ** BSD licence applies - redistribution and use in source and binary      
// ** forms, with or without modification, are permitted provided that       
// ** the following conditions are met:                                      
// ** 1) If the software is modified to produce derivative works,            
// ** such modified software should be clearly marked, so as not             
// ** to confuse it with the version available from UCAR.                    
// ** 2) Redistributions of source code must retain the above copyright      
// ** notice, this list of conditions and the following disclaimer.          
// ** 3) Redistributions in binary form must reproduce the above copyright   
// ** notice, this list of conditions and the following disclaimer in the    
// ** documentation and/or other materials provided with the distribution.   
// ** 4) Neither the name of UCAR nor the names of its contributors,         
// ** if any, may be used to endorse or promote products derived from        
// ** this software without specific prior written permission.               
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS  
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED      
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.    
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
/*
 * HcrdrxRpcClient.h
 *
 *  Created on: August 13, 2012
 *      Author: burghart
 */

#ifndef HCRDRXRPCCLIENT_H_
#define HCRDRXRPCCLIENT_H_

#include <xmlrpc-c/client_simple.hpp>
#include <string>
#include "DrxStatus.h"

/**
 * HcrdrxRpcClient encapsulates an XML-RPC connection to an hcrdrx
 * process.
 */
class HcrdrxRpcClient {
public:
    /**
     * Instantiate HcrdrxRpcClient to communicate with an hcrdrx process running
     * on host hcrdrxHost and using port hcrdrxPort.
     * @param hcrdrxHost the name of the host on which hcrdrx is running
     * @param hcrdrxPort the port number being used by hcrdrx
     */
    HcrdrxRpcClient(std::string hcrdrxHost, int hcrdrxPort);
    virtual ~HcrdrxRpcClient();
    
    /// @brief Zero the Pentek's position counts for the two reflector
    /// motors.
    /// @return true iff the XML-RPC call executes, otherwise return false.
    bool zeroPentekMotorCounts();

    /**
     * @brief Send a "getStatus" command, filling a DrxStatus
     * object if we get status from the hcrdrx.
     * @param status the HcrdrxRpcClient::Status object to be filled
     * @return true and fill the status object if status is obtained from
     * hcrdrx, otherwise return false and leave the status object
     * unmodified.
     * @return true iff the XML-RPC call executes, otherwise return false.
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
    
private:
    /// @brief Execute an XML-RPC method call and return the result.
    /// @param[in] methodName the name of the XML-RPC method to execute
    /// @param[out] result if the call is successful, the returned value is
    /// written in result
    /// @return true and write the returned value in result iff the XML-RPC 
    /// call was successful
    bool _execXmlRpcCall(std::string methodName, xmlrpc_c::value & result);
    
    std::string _hcrdrxHost;
    int _hcrdrxPort;
    std::string _daemonUrl;
    xmlrpc_c::clientSimple _client;
};

#endif /* HCRDRXRPCCLIENT_H_ */
