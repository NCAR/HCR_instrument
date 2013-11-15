/*
 * HcrMonitor.h
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

#include <p7142.h>
#include <CmigitsStatus.h>
#include <HcrPmc730Client.h>
#include <XmitdRpcClient.h>

#include "DrxStatus.h"

class HcrMonitorPriv;

/// @brief QThread object which handles HCR monitoring, regularly sampling all
/// status available via the multi-IO card and transmitter status
/// information obtained from the hcr_xmitd process.
class HcrMonitor : public QThread {
public:
    /**
     * @brief Construct a HcrMonitor which will read data on a regular basis from
     * the PMC-730 card, and get transmitter status from hcr_xmitd.
     * @param pentek pointer to the p7142 Pentek card to be monitored for 
     * temperatures
     * @param pmc730dHost the name of the host on which HcrPmc730Dameon is
     *      running
     * @param pmc730dPort the port number HcrPmc730Daemon is using for XML-RPC
     * @param xmitdHost the name of the host on which hcr_xmitd is running
     * @param xmitdPort the port number hcr_xmitd is using for XML-RPC
     */
    HcrMonitor(const Pentek::p7142 * pentek,
            std::string pmc730dHost, int pmc730dPort,
            std::string xmitdHost, int xmitdPort);
    
    virtual ~HcrMonitor();
    
    void run();

    /**
     * @brief Return the transmitter status.
     * @return the transmitter status.
     */
    XmitStatus transmitterStatus() const;

    /**
     * @brief Return the C-MIGITS status.
     * @return the C-MIGITS status.
     */
    CmigitsStatus cmigitsStatus() const;

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

private:

    /**
     * @brief Get data from the C-MIGITS
     */
    void _getCmigitsStatus();

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

    /// The Pentek P7142 we're monitoring for temperatures
    const Pentek::p7142 * _pentek;

    /// Last CmigitsStatus we obtained
    CmigitsStatus _cmigitsStatus;

    /// Last DrxStatus we obtained
    DrxStatus _drxStatus;

    /// Last HcrPmc730Status we obtained
    HcrPmc730Status _pmc730Status;

    /// XML-RPC access to HcrPmc730Daemon for status it provides
    HcrPmc730Client _pmc730Client;

    /// XML-RPC access to hcr_xmitd for its status
    XmitdRpcClient _xmitClient;

    /// Last transmitter status we obtained
    XmitStatus _xmitStatus;

    /**
     * Thread access mutex (mutable so we can lock the mutex even in const
     * methods)
     */
    mutable QMutex _mutex;
};


#endif /* HCR_MONITOR_H_ */
