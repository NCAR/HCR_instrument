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
 * HcrExecutiveRpcClient.cpp
 *
 *  Created on: Oct 28, 2014
 *      Author: burghart
 */

#ifndef HCREXECUTIVERPCCLIENT_H_
#define HCREXECUTIVERPCCLIENT_H_

#include <xmlrpc-c/client_simple.hpp>
#include <string>
#include "HcrExecutiveStatus.h"

/// HcrExecutiveRpcClient encapsulates an XML-RPC connection to an HcrExecutive 
/// process.
class HcrExecutiveRpcClient : private xmlrpc_c::clientSimple
{
public:
    /// @brief Instantiate HcrExecutiveRpcClient to communicate with an
	/// HcrExecutive process running on host daemonHost using port
	/// daemonPort.
    /// @param daemonHost the name of the host on which HcrExecutive is running
    /// @param daemonPort the port number being used by HcrExecutive
	HcrExecutiveRpcClient(std::string daemonHost, int daemonPort);
    virtual ~HcrExecutiveRpcClient();

    /// @brief Set valve control state in the Active Pressurization System (APS)
    /// @param state the desired APS valve control state
    /// @throws std::exception if there's a problem in the XML-RPC call.
    void setApsValveControl(ApsControl::ValveControlState state);

    /// @brief Set the requested Operation mode
    /// @param mode the requested OperationMode
    /// @throws std::exception if there's a problem in the XML-RPC call.
    void setRequestedOperationMode(OperationMode& mode);
    
    /// @brief Get the current operation mode
    /// @param mode reference in which to store the current operation mode
    /// @return current OperationMode
    /// @throws std::exception if there's a problem in the XML-RPC call.
    OperationMode getCurrentOperationMode();

    /// @brief Set the requested state for transmitter high voltage
    /// @param hvRequested true if high voltage is desired, false otherwise
    /// @throws std::exception if there's a problem in the XML-RPC call.
    void setHvRequested(bool hvRequested);

    /// @brief Get current HcrExecutive status
    /// @return a HcrExecutiveStatus object
    /// @throws std::exception if there's a problem in the XML-RPC call.
    HcrExecutiveStatus status();

	/// @brief Return true iff the HcrExecutive is responding.
	/// @return true iff the HcrExecutive is responding.
	bool daemonResponding() const { return(_daemonResponding); }

	/// @brief Return the URL used to communicate with HcrExecutive.
	/// @return the URL used to communicate with HcrExecutive.
	std::string daemonUrl() const { return(_daemonUrl); }

private:
    /// @brief Execute an XML-RPC method call and return the result.
    /// @param methodName the name of the XML-RPC method to execute
    /// @param params the list of params to pass for the method
    /// @return the result
    /// @throw std::exception if there's an error executing the XML-RPC request
    xmlrpc_c::value _execXmlRpcCall(std::string methodName, 
            xmlrpc_c::paramList = xmlrpc_c::paramList());
    
	bool _daemonResponding;
	std::string _daemonUrl;
};

#endif /* HCREXECUTIVERPCCLIENT_H_ */
