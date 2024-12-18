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
 * MotionControlStatusWorker.h
 *
 *  Created on: Oct 22, 2014
 *      Author: burghart
 */

#ifndef MOTIONCONTROLSTATUSWORKER_H_
#define MOTIONCONTROLSTATUSWORKER_H_

#include <QObject>
#include "MotionControlRpcClient.h"

/// @brief Class providing a thread which gets hcrdrx status on a regular
/// basis using a MotionControlRpcClient connection.
///
/// This class uses the given MotionControlRpcClient connection to poll for status
/// from hcrdrx on a ~1 Hz basis (when connected). When new status is received,
/// a newStatus(DrxStatus) signal is emitted. The class also provides a useful
/// way to test for good connection to the hcrdrx RPC server, via
/// serverResponsive(bool) signals emitted when connection/disconnection is
/// detected.
class MotionControlStatusWorker : public QObject, public MotionControlRpcClient {
    Q_OBJECT

public:
    /// @brief Instantiate, creating a MotionControlRpcClient connection to the
    /// MotionControlDaemon XML-RPC server.
    /// @param mcdHost name of the host on which MotionControlDaemon is running
    /// @param mcdPort port for MotionControlDaemon's XML-RPC
    /// @param workThread pointer to the thread in which this worker should do
    /// most of its work.
    MotionControlStatusWorker(std::string mcdHost, int mcdPort, QThread* workThread);
    virtual ~MotionControlStatusWorker();

signals:
    /// @brief Signal emitted when the XML-RPC client connection to the server
    /// becomes responsive or unresponsive.
    /// @param responsive true if the server has become responsive or false
    /// @param msg a message describing the associated event
    /// if the server has become unresponsive
    void serverResponsive(bool responsive, QString msg);

    /// @brief signal emitted when a new status is received from 
    /// MotionControlDaemon
    /// @param status the new status received from MotionControlDaemon
    void newStatus(MotionControl::Status status);

private slots:
    /// @brief Slot which initiates our work, which will continue until our
    /// work thread is stopped.
    void _beginWork();

    /// @brief Try to get latest status from hcrdrx, and emit a newStatus()
    /// signal if successful.
    void _collectStatus();
private:
    /// True iff the client had a successful connection with the hcrdrx
    /// XML-RPC server on the last XML-RPC method call.
    bool _daemonAlive;

    std::string _mcdHost;
    int _mcdPort;

    /// @brief The thread in which most of our work should be performed
    QThread* _workThread;

    QTimer* _getStatusTimer;
};

#endif /* MOTIONCONTROLSTATUSWORKER_H_ */
