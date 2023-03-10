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
class fireflydRpcClient : private xmlrpc_c::clientSimple {
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
};

#endif /* FIREFLYDRPCCLIENT_H_ */
