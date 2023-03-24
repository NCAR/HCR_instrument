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
 *  Created on: February 18, 2021
 *      Author: burghart
 */

#ifndef HCRDRXRPCCLIENT_H_
#define HCRDRXRPCCLIENT_H_

#include <string>
#include <xmlrpc-c/client_simple.hpp>
#include <OperationMode.h>
#include "DrxStatus.h"

/**
 * HcrdrxRpcClient encapsulates an XML-RPC connection to an hcrdrx
 * process.
 */
class HcrdrxRpcClient : private xmlrpc_c::clientSimple {
public:
    /// @brief Instantiate HcrdrxRpcClient to communicate with an hcrdrx process
    /// @param hcrdrxHost the name of the host on which hcrdrx is running
    /// @param hcrdrxPort the port number being used by hcrdrx
    HcrdrxRpcClient(std::string hcrdrxHost, int hcrdrxPort);
    virtual ~HcrdrxRpcClient();
    
    /// @brief Zero the Pentek's position counts for the two reflector
    /// motors.
    /// @return true iff the XML-RPC call executes, otherwise return false.
    bool zeroPentekMotorCounts();

    /**
     * @brief Send a "getStatus" command, filling a DrxStatus
     * object if we get status from the hcrdrx.
     * @param status the DrxStatus object to be filled
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
    /// @brief Set the Pentek's controller schedule start and stop indices
    /// based on the given OperationMode
    ///
    /// This XML-RPC method should only be called by HcrExecutive's
    /// TransmitControl instance. That class has access to this private method since
    /// it is specified as a friend below.
    /// @param opMode the desired OperationMode to apply
    bool _useOperationMode(const OperationMode& opMode);

    /// @brief Execute an XML-RPC method call and return the result.
    /// @param[in] methodName the name of the XML-RPC method to execute
    /// @param[out] result if the call is successful, the returned value is
    /// written in result
    /// @param[in] the list of parameters to pass to the XML-RPC method
    /// @return true and write the returned value in result iff the XML-RPC 
    /// call was successful
    bool _execXmlRpcCall(std::string methodName, xmlrpc_c::value& result,
                         const xmlrpc_c::paramList& params = xmlrpc_c::paramList());
    
    std::string _hcrdrxHost;
    int _hcrdrxPort;
    std::string _daemonUrl;

    // Allow TransmitControl to call private method _useOperationMode()
    friend class TransmitControl;
};

#endif /* HCRDRXRPCCLIENT_H_ */
