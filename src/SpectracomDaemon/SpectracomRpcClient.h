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
    /// @param daemonHost the name of the host on which SpectracomDaemon is
    /// running
    /// @param daemonPort the port number being used by SpectracomDaemon
    SpectracomRpcClient(std::string daemonHost, int daemonPort);
    virtual ~SpectracomRpcClient();
    
    /// @brief Send a "getStatus" command, filling a SpectracomStatus
    /// object if we get status from the SpectracomDaemon.
    /// @param status the SpectracomRpcClient::Status object to be filled
    /// @return true and fill the status object if status is obtained from
    /// Spectracom, otherwise return false and leave the status object
    /// unmodified.
    /// @return true iff the XML-RPC call executes, otherwise return false.
    bool getStatus(SpectracomStatus & status);
    
    /// Get the port number of the associated SpectracomDaemon.
    /// @return the port number of the associated SpectracomDaemon.
    int getDaemonPort() { return(_daemonPort); }
    

    /// Get the name of the host on which the associated SpectracomDaemon is 
    /// running.
    /// @return the name of the host on which the associated SpectracomDaemon 
    /// is running.
    std::string getDaemonHost() { return(_daemonHost); }
    
private:
    std::string _daemonHost;
    int _daemonPort;
    std::string _daemonUrl;
    xmlrpc_c::clientSimple _client;
};

#endif /* SPECTRACOMRPCCLIENT_H_ */
