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
 * SpatialFogStatusThread.h
 *
 *  Created on: Aug 29, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */
#ifndef SPATIALFOGSTATUSTHREAD_H_
#define SPATIALFOGSTATUSTHREAD_H_

#include <QThread>
#include "SpatialFogDaemonRpcClient.h"

/// @brief Qt class providing a thread which gets SpatialFogDaemon status on a
/// regular basis and emits a signal when new status is received. It also emits
/// a signal when SpatialFogDaemon XML-RPC server responsiveness changes.
///
/// This class creates a SpatialFogDaemonRpcClient connection to poll for
/// status from SpatialFogDaemon on a periodic basis when connected (default 1 Hz).
/// When new status is received, newStatus(SpatialFogStatus) signal is emitted.
/// The class also provides a useful way to test for good connection to the
/// SpatialFogDaemon XML-RPC server, via serverResponsive(bool) signals emitted
/// when connection/disconnection is detected.
class SpatialFogStatusThread : public QThread {
    Q_OBJECT

public:
    /// @brief Instantiate, creating an SpatialFogDaemonRpcClient connection to
    /// the SpatialFogDaemon XML-RPC server.
    SpatialFogStatusThread(std::string daemonHost, int daemonPort);
    virtual ~SpatialFogStatusThread();

    void run();

    /// @brief Return the SpatialFogDaemonRpcClient instance being used to talk to
    /// SpatialFogDaemon.
    /// @return the SpatialFogDaemonRpcClient instance being used to talk to
    /// SpatialFogDaemon.
    SpatialFogDaemonRpcClient & rpcClient() { return *_client; }

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

    /// @brief signal emitted when a new status is received from SpatialFogDaemon
    /// @param status the new status received from SpatialFogDaemon
    void newStatus(SpatialFogStatus status);

private slots:
    /// @brief Try to get latest status from SpatialFogDaemon, and emit a
    /// newStatus() signal if successful.
    void _getStatus();
private:
    /// True iff the client had a successful connection with the
    /// SpatialFogDaemon XML-RPC server on the last XML-RPC method call.
    bool _responsive;

    std::string _daemonHost;
    int _daemonPort;

    /// The SpatialFogDaemonRpcClient object handling the XML-RPC connection
    SpatialFogDaemonRpcClient * _client;
};

#endif /* SPATIALFOGSTATUSTHREAD_H_ */
