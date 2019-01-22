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
 * XmitdStatusThread.h
 *
 *  Created on: Sep 10, 2012
 *      Author: hcr
 */

#ifndef XMITDSTATUSTHREAD_H_
#define XMITDSTATUSTHREAD_H_

#include <XmitdRpcClient.h>
#include <QtCore/QThread>

/// @brief Class providing a thread which gets hcr_xmitd status on a regular
/// basis using a XmitdRpcClient connection.
///
/// This class uses the given XmitdRpcClient connection to poll for status
/// from hcr_xmitd on a ~1 Hz basis (when connected). When new status is received,
/// a newStatus(DrxStatus) signal is emitted. The class also provides a useful
/// way to test for good connection to the hcr_xmitd RPC server, via
/// serverResponsive(bool) signals emitted when connection/disconnection is
/// detected.
class XmitdStatusThread : public QThread {
    Q_OBJECT

public:
    /// @brief Instantiate, creating an XmitdRpcClient connection to the
    /// hcr_xmitd XML-RPC server.
    XmitdStatusThread(std::string xmitdHost, int xmitdPort);
    virtual ~XmitdStatusThread();

    void run();

    /// @brief Return the XmitdRpcClient instance being used to talk to hcr_xmitd.
    /// @return the XmitdRpcClient instance being used to talk to hcr_xmitd.
    XmitdRpcClient & rpcClient() { return *_client; }

    /// @brief Return true iff the server responded to the last XML-RPC command.
    /// @return true iff the server responded to the last XML-RPC command.
    bool serverIsResponding() const { return(_responsive); }

signals:
    /// @brief Signal emitted when the XML-RPC client connection to the server
    /// becomes responsive or unresponsive.
    /// @param responsive true if the server has become responsive or false
    /// if the server has become unresponsive
    void serverResponsive(bool responsive);
    /// @brief signal emitted when a new status is received from hcr_xmitd
    /// @param status the new status received from hcr_xmitd
    void newStatus(XmitStatus status);

private slots:
    /// @brief Try to get latest status from hcr_xmitd, and emit a newStatus()
    /// signal if successful.
    void _getStatus();
private:
    /// True iff the client had a successful connection with the hcr_xmitd
    /// XML-RPC server on the last XML-RPC method call.
    bool _responsive;

    std::string _xmitdHost;
    int _xmitdPort;

    /// The XmitdRpcClient object handling the XML-RPC connection
    XmitdRpcClient * _client;
};

#endif /* XMITDSTATUSTHREAD_H_ */
