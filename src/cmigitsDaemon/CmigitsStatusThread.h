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
 * CmigitsStatusThread.h
 *
 *  Created on: Sep 24, 2013
 *      Author: burghart
 */
#ifndef CMIGITSSTATUSTHREAD_H_
#define CMIGITSSTATUSTHREAD_H_

#include <QThread>
#include "CmigitsDaemonRpcClient.h"

/// @brief Qt class providing a thread which gets cmigitsDaemon status on a
/// regular basis and emits a signal when new status is received. It also emits
/// a signal when cmigitsDaemon XML-RPC server responsiveness changes.
///
/// This class creates a CmigitsDaemonRpcClient connection to poll for
/// status from cmigitsDaemon on a periodic basis when connected (default 1 Hz).
/// When new status is received, newStatus(CmigitsStatus) signal is emitted.
/// The class also provides a useful way to test for good connection to the
/// cmigitsDaemon XML-RPC server, via serverResponsive(bool) signals emitted
/// when connection/disconnection is detected.
class CmigitsStatusThread : public QThread {
    Q_OBJECT

public:
    /// @brief Instantiate, creating an CmigitsDaemonRpcClient connection to the
    /// cmigitsDaemon XML-RPC server.
    CmigitsStatusThread(std::string cmigitsHost, int cmigitsPort);
    virtual ~CmigitsStatusThread();

    void run();

    /// @brief Return the CmigitsDaemonRpcClient instance being used to talk to 
    /// cmigitsDaemon.
    /// @return the CmigitsDaemonRpcClient instance being used to talk to 
    /// cmigitsDaemon.
    CmigitsDaemonRpcClient & rpcClient() { return *_client; }

    /// @brief Return true iff the server responded to the last XML-RPC command.
    /// @return true iff the server responded to the last XML-RPC command.
    bool serverIsResponding() const { return(_responsive); }

signals:
    /// @brief Signal emitted when the XML-RPC client connection to the server
    /// becomes responsive or unresponsive.
    /// @param responsive true if the server has become responsive or false
    /// if the server has become unresponsive
    /// @param msg a message describing the associated event
    void serverResponsive(bool responsive, QString msg);

    /// @brief signal emitted when a new status is received from CmigitsDaemon
    /// @param status the new status received from CmigitsDaemon
    void newStatus(CmigitsStatus status);

private slots:
    /// @brief Try to get latest status from cmigitsDaemon, and emit a 
    /// newStatus() signal if successful.
    void _getStatus();
private:
    /// True iff the client had a successful connection with the cmigitsDaemon
    /// XML-RPC server on the last XML-RPC method call.
    bool _responsive;

    std::string _cmigitsHost;
    int _cmigitsPort;

    /// The CmigitsDaemonRpcClient object handling the XML-RPC connection
    CmigitsDaemonRpcClient * _client;
};

#endif /* CMIGITSSTATUSTHREAD_H_ */
