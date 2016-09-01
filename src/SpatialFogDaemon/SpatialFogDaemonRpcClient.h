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
 * SpatialFogDaemonRpcClient.h
 *
 *  Created on: August 29, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#ifndef SPATIALFOGDAEMONRPCCLIENT_H_
#define SPATIALFOGDAEMONRPCCLIENT_H_

#include <xmlrpc-c/client_simple.hpp>
#include <string>
#include "SpatialFogStatus.h"

/**
 * SpatialFogDaemonRpcClient encapsulates an XML-RPC connection to a
 * SpatialFogDaemon process.
 */
class SpatialFogDaemonRpcClient {
public:
    /**
     * @brief Construct a SpatialFogDaemonRpcClient to communicate with a
     * SpatialFogDaemon process running on host daemonHost and using port
     * daemonPort.
     * @param daemonHost the name of the host on which SpatialFogDaemon is
     * running
     * @param daemonPort the port number being used by SpatialFogDaemon
     */
    SpatialFogDaemonRpcClient(std::string daemonHost, int daemonPort);
    virtual ~SpatialFogDaemonRpcClient();

    /**
     * @brief Get current status from the SpatialFogDaemon via a getStatus()
     * XML-RPC call.
     * @return current SpatialFogStatus from the SpatialFogDaemon
     * @throws std::exception if there's a problem executing the XML-RPC
     * call.
     */
    SpatialFogStatus getStatus() throw (std::exception);
    
    /**
     * Get the port number of the associated SpatialFogDaemon.
     * @return the port number of the associated SpatialFogDaemon.
     */
    int getDaemonPort() { return(_daemonPort); }
    
    /**
     * Get the name of the host on which the associated SpatialFogDaemon is
     * running.
     * @return the name of the host on which the associated SpatialFogDaemon is
     * running.
     */
    std::string getDaemonHost() { return(_daemonHost); }
    
private:
    std::string _daemonHost;
    int _daemonPort;
    std::string _daemonUrl;
    xmlrpc_c::clientSimple _client;
};

#endif /* SPATIALFOGDAEMONRPCCLIENT_H_ */
