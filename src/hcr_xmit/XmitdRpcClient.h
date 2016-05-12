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
 * XmitdRpcClient.h
 *
 *  Created on: Mar 11, 2011
 *      Author: burghart
 */

#ifndef XMITDRPCCLIENT_H_
#define XMITDRPCCLIENT_H_

#include <xmlrpc-c/client_simple.hpp>
#include <string>
#include "XmitStatus.h"

/**
 * XmitdRpcClient encapsulates an XML-RPC connection to a hcr_xmitd daemon 
 * process which is controlling the HCR transmitter.
 */
class XmitdRpcClient : private xmlrpc_c::clientSimple {
public:
    /**
     * Instantiate XmitdRpcClient to communicate with a hcr_xmitd process running
     * on host xmitdHost and using port xmitdPort.
     * @param xmitdHost the name of the host on which hcr_xmitd is running
     * @param xmitdPort the port number being used by hcr_xmitd
     */
    XmitdRpcClient(std::string xmitdHost, int xmitdPort);
    virtual ~XmitdRpcClient();
    
    /**
     * @brief Send a "getStatus" command, creating an XmitStatus
     * object if we get status from the hcr_xmitd.
     * @param status the XmitStatus object to be filled
     * @return true and fill the status object if status is obtained from
     * hcr_xmitd, otherwise return false and leave the status object
     * unmodified.
     */
    bool getStatus(XmitStatus & status);
    
    /**
     * Get the port number of the associated hcr_xmitd.
     * @return the port number of the associated hcr_xmitd.
     */
    int getXmitdPort() { return(_xmitdPort); }
    
    /**
     * Get the name of the host on which the associated hcr_xmitd is running.
     * @return the name of the host on which the associated hcr_xmitd is running.
     */
    std::string getXmitdHost() { return(_xmitdHost); }
    
    /**
     * @brief Turn on the klystron filament.
     */
    void xmitFilamentOn();

    /**
     * @brief Turn off the klystron filament.
     */
    void xmitFilamentOff();

    /**
     * @brief Turn on transmitter high voltage.
     */
    void xmitHvOn();

    /**
     * @brief Turn off the transmitter high voltage.
     */
    void xmitHvOff();

private:
    /**
     * Execute an XML-RPC command in hcr_xmitd and get the result.
     * @param cmd the XML-RPC command to execute
     * @param result pointer to xmlrpc_c::value to hold the command result
     * @return true iff the command was executed successfully
     */
    bool _executeXmlRpcCommand(const std::string cmd, xmlrpc_c::value * result);
    
    std::string _xmitdHost;
    int _xmitdPort;
    std::string _xmitdUrl;
};

#endif /* XMITDRPCCLIENT_H_ */
