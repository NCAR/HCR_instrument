// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2023
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
 * HcrPmc730StatusWorker.h
 *
 *  Created on: Sep 10, 2012
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#ifndef HCRPMC730STATUSWORKER_H_
#define HCRPMC730STATUSWORKER_H_

#include <QThread>
#include <QTimer>
#include "HcrPmc730Client.h"

class QUdpSocket;

/// @brief Worker class which gets HcrPmc730Daemon status on a regular basis.
///
/// The object performs most of its work within a thread provided at construction
/// time, starting its work when the thread is started and running until the
/// thread is stopped or destroyed.
///
/// This class uses an HcrPmc730RpcClient connection to regularly query status
/// from HcrPmc730Daemon on a ~1 Hz basis (when connected). When new status is
/// received, a newStatus(HcrPmc730Status) signal is emitted. The class
/// also reports the state of the connection to the HcrPmc730Daemon RPC server,
/// via serverResponsive(bool) signals emitted when connection/disconnection is
/// detected.
class HcrPmc730StatusWorker : public QObject {
    Q_OBJECT

public:
    /// @brief Instantiate, creating an HcrPmc730Client connection to the
    /// HcrPmc730Daemon XML-RPC server.
    /// @param daemonHost the host on which HcrPmc730Daemon is running
    /// @param daemonPort the port number HcrPmc730Daemon is using for XML-RPC
	/// @param workThread the thread in which we should perform our work
    HcrPmc730StatusWorker(std::string daemonHost, int daemonPort, QThread* workThread);

    /// @brief Destructor
    virtual ~HcrPmc730StatusWorker();

    void run();

    /// @brief Return the HcrPmc730Client instance being used to talk to
    /// HcrPmc730Daemon.
    /// @return the HcrPmc730Client instance being used to talk to 
    /// HcrPmc730Daemon.
    HcrPmc730Client & rpcClient() { return _client; }

    /// @brief Return true iff the HcrPmc730Daemon is responding
    /// @return true iff the HcrPmc730Daemon is responding
    bool serverIsResponding() { return _responsive; }

signals:
    /// @brief Signal emitted when the XML-RPC client connection to the server
    /// becomes responsive or unresponsive.
    /// @param responsive true if the server has become responsive or false
    /// @param msg a message describing the associated event
    /// if the server has become unresponsive
    void serverResponsive(bool responsive, QString msg);

    /// @brief signal emitted when a new status is received from HcrPmc730Daemon
    /// @param status the new status received from HcrPmc730Daemon
    void newStatus(HcrPmc730Status status);

    /// @brief Signal emitted when HMC operation mode changes.
    /// @param mode the new HMC operation mode
    /// @param modeChangeTime the time of the mode change, double precision
    /// seconds since 1970-01-01 00:00:00 UTC
    void hmcModeChange(OperationMode mode, double modeChangeTime);

private slots:
    /// @brief Slot which initiates work
    void _beginWork();

    /// @brief Try to get latest status from HcrPmc730Daemon, and emit a newStatus()
    /// signal if successful.
    void _getStatus();
    
    /// @brief Read HMC operation mode change info
    void _readHmcModeChangeSocket();
    
private:
    /// @brief the host on which HcrPmc730Daemon is running
    std::string _daemonHost;

    /// @brief HcrPmc730Daemon's XML-RPC server port
    int _daemonPort;

    /// @brief Pointer to the QThread in which we should perform our work
    QThread* _workThread;

    /// True iff the client had a successful connection with the HcrPmc730Daemon
    /// XML-RPC server on the last XML-RPC method call.
    bool _responsive;

    /// The HcrPmc730Client object handling the XML-RPC connection
    HcrPmc730Client _client;
    
    /// QUdpSocket used to read broadcast messages of HMC operation mode 
    /// changes.
    QUdpSocket* _hmcModeChangeSocket;

    /// @brief Periodic timer to get new status from HcrPmc730Daemon
    QTimer* _getStatusTimer;

};

#endif /* HCRPMC730STATUSWORKER_H_ */
