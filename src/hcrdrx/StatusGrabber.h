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
 * StatusGrabber.h
 *
 *  Created on: Dec 13, 2010
 *      Author: burghart
 */

#ifndef HCR_MONITOR_H_
#define HCR_MONITOR_H_

#include <deque>
#include <numeric>
#include <string>
#include <stdint.h>

#include <QThread>
#include <QMutex>

#include <HcrPmc730Client.h>
#include <XmitdRpcClient.h>
#include <MotionControlRpcClient.h>

#include "DrxStatus.h"

class HCR_Pentek;

class QUdpSocket;

/// @brief QThread object which regularly polls for status from HcrPmc730Daemon,
/// hcr_xmitd, the Pentek card, and MotionControlDaemon. The API provides access
/// to the latest status obtained from each of these.
class StatusGrabber : public QThread {
    Q_OBJECT
public:
    /**
     * @brief Construct a StatusGrabber which will read data on a regular basis
     * from the PMC-730 card, and get transmitter status from hcr_xmitd.
     * @param pentek pointer to the HCR_Pentek instance to be monitored
     * @param pmc730dHost the name of the host on which HcrPmc730Dameon is
     *      running
     * @param pmc730dPort the port number HcrPmc730Daemon is using for XML-RPC
     * @param xmitdHost the name of the host on which hcr_xmitd is running
     * @param xmitdPort the port number hcr_xmitd is using for XML-RPC
     * @param motionControlHost the name of the host on which
     * MotionControlDaemon is running
     * @param motionControlPort the port number for MotionControlDaemon XML-RPC
     */
    StatusGrabber(HCR_Pentek & pentek,
            std::string pmc730dHost, int pmc730dPort,
            std::string xmitdHost, int xmitdPort,
            std::string motionControlHost, int motionControlPort);
    
    virtual ~StatusGrabber();
    
    void run();

    /**
     * @brief Return the transmitter status.
     * @return the transmitter status.
     */
    XmitStatus transmitterStatus() const;

    /**
     * @brief Return the DRX status.
     * @return the DRX status.
     */
    DrxStatus drxStatus() const;

    /**
     * @brief Return the status collected from HcrPmc730Daemon.
     * @return the status collected from HcrPmc730Daemon.
     */
    HcrPmc730Status pmc730Status() const;

    /**
     * @brief Return the status collected from MotionControlDaemon.
     * @return the status collected from MotionControlDaemon.
     */
    MotionControl::Status motionControlStatus() const;

private slots:
    /// @brief Get current status from all sources
    void _getStatus();

    /// @brief Read an incoming broadcast packet on the HMC mode change socket
    void _readHmcModeChangeSocket();

private:

    /**
     * @brief Get status from the Pentek
     */
    void _getDrxStatus();

    /**
     * @brief Get status from the multi-IO card
     */
    void _getPmc730Status();

    /**
     * @brief Get transmitter status information from the hcr_xmitd process.
     */
    void _getXmitStatus();
    
    ///
    /// @brief Get status information from MotionControlDaemon.
    ///
    void _getMotionControlStatus();
    
    /// The Pentek we're monitoring
    HCR_Pentek & _pentek;

    /// Last DrxStatus we obtained
    DrxStatus _drxStatus;

    /// XML-RPC access to HcrPmc730Daemon for status it provides
    HcrPmc730Client _pmc730Client;

    /// Last HcrPmc730Status we obtained
    HcrPmc730Status _pmc730Status;

    /// XML-RPC access to hcr_xmitd for its status
    XmitdRpcClient _xmitClient;

    /// Last transmitter status we obtained
    XmitStatus _xmitStatus;

    /// XML-RPC access to MotionControlDaemon for its status
    MotionControlRpcClient _motionControlClient;

    /// Last MotionControlDaemon status we obtained
    MotionControl::Status _motionControlStatus;
    /**
     * Thread access mutex (mutable so we can lock the mutex even in const
     * methods)
     */
    mutable QMutex _mutex;
    
    /// Socket to receive HMC mode change broadcasts
    QUdpSocket * _hmcModeChangeSocket;
};


#endif /* HCR_MONITOR_H_ */
