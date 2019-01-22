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
 * SpectracomStatusThread.h
 *
 *  Created on: June 12, 2015
 *      Author: burghart
 */

#ifndef SPECTRACOMSTATUSTHREAD_H_
#define SPECTRACOMSTATUSTHREAD_H_

#include <SpectracomRpcClient.h>
#include <QtCore/QThread>

/// @brief Class providing a thread which gets Spectracom status on a regular
/// basis using a SpectracomRpcClient connection.
///
/// This class uses the given SpectracomRpcClient connection to poll for status
/// from Spectracom on a ~1 Hz basis (when connected). When new status is received,
/// a newStatus(SpectracomStatus) signal is emitted. The class also provides a useful
/// way to test for good connection to the SpectracomDaemon RPC server, via
/// serverResponsive(bool) signals emitted when connection/disconnection is
/// detected.
class SpectracomStatusThread : public QThread {
    Q_OBJECT

public:
    /// @brief Instantiate, creating an SpectracomRpcClient connection to the
    /// SpectracomDaemon XML-RPC server.
    SpectracomStatusThread(std::string daemonHost, int daemonPort);
    virtual ~SpectracomStatusThread();

    void run();

    /// @brief Return the SpectracomRpcClient instance being used to talk to
    /// Spectracom.
    /// @return the SpectracomRpcClient instance being used to talk to 
    /// SpectracomDaemon.
    SpectracomRpcClient & rpcClient() { return *_client; }

    /// @brief Return true iff the server responded to the last XML-RPC command.
    /// @return true iff the server responded to the last XML-RPC command.
    bool serverIsResponding() const { return(_responsive); }

signals:
    /// @brief Signal emitted when the XML-RPC client connection to 
    /// SpectracomDaemon becomes responsive or unresponsive.
    /// @param responsive true if SpectracomDaemon has become responsive or 
    /// false if the server has become unresponsive
    void serverResponsive(bool responsive);

    /// @brief signal emitted when a new status is received from 
    /// SpectracomDaemon
    /// @param status the new status received from SpectracomDaemon
    void newStatus(SpectracomStatus status);

private slots:
    /// @brief Try to get latest status from SpectracomDaemon, and emit a 
    /// newStatus() signal if successful.
    void _getStatus();
private:
    /// True iff the client had a successful connection with the 
    /// SpectracomDaemon XML-RPC server on the last XML-RPC method call.
    bool _responsive;

    std::string _daemonHost;
    int _daemonPort;

    /// The SpectracomRpcClient object handling the XML-RPC connection
    SpectracomRpcClient * _client;
};

#endif /* SPECTRACOMSTATUSTHREAD_H_ */
