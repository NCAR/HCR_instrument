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
 * HcrExecutiveStatusThread.h
 *
 *  Created on: Oct 28, 2014
 *      Author: burghart
 */

#ifndef HCREXECUTIVESTATUSTHREAD_H_
#define HCREXECUTIVESTATUSTHREAD_H_

#include "HcrExecutiveRpcClient.h"
#include <QThread>

/// @brief Class providing a thread which gets HcrExecutive status on a regular
/// basis using a HcrExecutiveRpcClient connection.
///
/// This class uses the given HcrExecutiveRpcClient connection to poll for status
/// from HcrExecutive on a ~1 Hz basis (when connected). When new status is received,
/// a newStatus(DrxStatus) signal is emitted. The class also provides a useful
/// way to test for good connection to the HcrExecutive RPC server, via
/// serverResponsive(bool) signals emitted when connection/disconnection is
/// detected.
class HcrExecutiveStatusThread : public QThread {
    Q_OBJECT

public:
    /// @brief Instantiate, creating a HcrExecutiveRpcClient connection to the
    /// HcrExecutive XML-RPC server.
    HcrExecutiveStatusThread(std::string mcdHost, int mcdPort);
    virtual ~HcrExecutiveStatusThread();

    void run();

    /// @brief Return the HcrExecutiveRpcClient instance being used to talk to
    /// HcrExecutive.
    /// @return the HcrExecutiveRpcClient instance being used to talk to
    /// HcrExecutive.
    HcrExecutiveRpcClient & rpcClient() const { return(*_client); }

    /// @brief Return true iff the HcrExecutive is responding
    /// @return true iff the HcrExecutive is responding
    bool serverIsResponding() const { return(_responsive); }
    
    /// @brief Return the host where HcrExecutive is running
    /// @return the host where HcrExecutive is running
    std::string daemonHost() const { return(_daemonHost); }

    /// @brief Return the port on which HcrExecutive is listening
    /// @return the port on which HcrExecutive is listening
    int daemonPort() const { return(_daemonPort); }

signals:
    /// @brief Signal emitted when the XML-RPC client connection to the server
    /// becomes responsive or unresponsive.
    /// @param responsive true if the server has become responsive or false
    /// @param msg a message describing the associated event
    /// if the server has become unresponsive
    void serverResponsive(bool responsive, QString msg);

    /// @brief signal emitted when a new status is received from 
    /// HcrExecutive
    /// @param status the new status received from HcrExecutive
    void newStatus(HcrExecutiveStatus status);

    /// @brief signal emitted on detection of a new event of high voltage
    /// forced off because of high max power
    /// @param details a string detailing the reason high voltage was forced
    /// off
    void hvForcedOffForHighMaxPower(QString details);

private slots:
    /// @brief Try to get latest status from HcrExecutive, and emit a newStatus()
    /// signal if successful.
    void _getStatus();
private:
    /// True iff the client had a successful connection with the HcrExecutive
    /// XML-RPC server on the last XML-RPC method call.
    bool _responsive;

    std::string _daemonHost;
    int _daemonPort;

    /// The HcrExecutiveRpcClient object handling the XML-RPC connection
    HcrExecutiveRpcClient * _client;

    /// @brief Time high voltage was last forced off because of high max power,
    /// seconds since 1970-01-01 00:00:00 UTC, or zero if HV has not been
    /// forced off.
    double _timeOfLastHvOffForHighPower;

};

#endif /* HCREXECUTIVESTATUSTHREAD_H_ */
