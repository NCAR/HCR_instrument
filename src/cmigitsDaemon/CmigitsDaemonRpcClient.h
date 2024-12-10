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
class CmigitsDaemonRpcClient : public xmlrpc_c::clientSimple {
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
     * @brief Get current status from the cmigitsDaemon via a getStatus() 
     * XML-RPC call.
     * @return current CmigitsStatus from the cmigitsDaemon
     * @throws std::exception if there's a problem executing the XML-RPC
     * call.
     */
    CmigitsStatus getStatus();
    
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
    
private:
    std::string _daemonHost;
    int _daemonPort;
    std::string _daemonUrl;
};

#endif /* CMIGITSDAEMONRPCCLIENT_H_ */
