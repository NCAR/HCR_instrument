/*
 * KaMonitor.h
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
#include <XmitdRpcClient.h>

#include "DrxStatus.h"

class HcrMonitorPriv;

/// @brief QThread object which handles HCR monitoring, regularly sampling all
/// status available via the multi-IO card as well as transmitter status
/// information obtained from the hcr_xmitd process.
class HcrMonitor : public QThread {
public:
    /**
     * @brief Construct a HcrMonitor which will read data on a regular basis from
     * the PMC-730 card, and get transmitter status from ka_xmitd
     * running on host xmitdHost/port xmitdPort.
     * @param pentek the p7142 Pentek card to be monitored for temperatures
     * @param xmitdHost the name of the host on which hcr_xmitd is running
     * @param xmitdPort the port number hcr_xmitd is using for XmlRpc calls
     */
    HcrMonitor(const Pentek::p7142 & pentek, std::string xmitdHost, int xmitdPort);
    
    virtual ~HcrMonitor();
    
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

private:

    /**
     * @brief Get transmitter status information from the hcr_xmitd process.
     */
    void _getXmitStatus();

    /**
     * @brief Get status from the multi-IO card and the Pentek
     */
    void _getDrxStatus();

    /// The Pentek P7142 we're monitoring for temperatures
    const Pentek::p7142 & _pentek;

    /// Last DrxStatus we created
    DrxStatus _drxStatus;

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
