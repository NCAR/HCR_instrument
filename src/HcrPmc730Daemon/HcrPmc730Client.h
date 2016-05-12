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
 * HcrPmc730Client.h
 *
 *  Created on: Aug 9, 2013
 *      Author: hcr
 */

#ifndef HCRPMC730CLIENT_H_
#define HCRPMC730CLIENT_H_

#include <string>
#include <HcrPmc730Status.h>
#include <xmlrpc-c/client_simple.hpp>

class HcrPmc730Client {
public:
    HcrPmc730Client(std::string daemonHost, int daemonPort);
    virtual ~HcrPmc730Client();
    /// @brief Return the daemon host name
    /// @return the daemon host name
    std::string getDaemonHost() const { return(_daemonHost); }

    /// @brief Return the daemon port number
    /// @return the daemon port number
    int getDaemonPort() const { return(_daemonPort); }

    /// @brief Send a "getStatus" command and return a HcrPmc730Status object.
    /// @throws exception on XML-RPC error
    /// @return Return status obtained from HcrPmc730Daemon. On XML-RPC error,
    /// an exception is thrown.
    HcrPmc730Status getStatus();

    /// @brief Send an "xmitFilamentOn" command to HcrPmc730Daemon
    /// @throws exception on XML-RPC error
    void xmitFilamentOn();

    /// @brief Send a "xmitFilamentOff" command to HcrPmc730Daemon
    /// @throws exception on XML-RPC error
    void xmitFilamentOff();

    /// @brief Send an "xmitHvOn" command to HcrPmc730Daemon
    /// @throws exception on XML-RPC error
    void xmitHvOn();

    /// @brief Send a "xmitHvOff" command to HcrPmc730Daemon
    /// @throws exception on XML-RPC error
    void xmitHvOff();

    /// @brief Send "setHmcMode" command to HcrPmc730Daemon
    /// @param mode the desired HmcOperationMode
    /// @throws exception on XML-RPC error
    void setHmcMode(HcrPmc730::HmcOperationMode mode);
    
    /// @brief Open the Active Pressurization System solenoid valve
    void openApsValve();
    
    /// @brief Close the Active Pressurization System solenoid valve
    void closeApsValve();

private:
    /// @brief Execute an XML-RPC method call and return the result.
    /// @param methodName the name of the XML-RPC method to execute
    /// @param params the list of params to pass for the method
    /// @return the result
    /// @throw std::exception if there's an error executing the XML-RPC request
    xmlrpc_c::value _execXmlRpcCall(std::string methodName, 
            xmlrpc_c::paramList = xmlrpc_c::paramList());
    
    std::string _daemonHost;
    int _daemonPort;
    std::string _daemonUrl;
    xmlrpc_c::clientSimple _client;
};

#endif /* HCRPMC730CLIENT_H_ */
