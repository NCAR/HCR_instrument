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

#include <p7142sd3c.h>
#include <CmigitsStatus.h>
#include <HcrPmc730Client.h>
#include <XmitdRpcClient.h>

#include "DrxStatus.h"

/// @brief QThread object which regularly polls for status from HcrPmc730Daemon,
/// hcr_xmitd, CmigitsDaemon, and the Pentek card. The API provides access to 
/// the latest status obtained from each of these.
class StatusGrabber : public QThread {
    Q_OBJECT
public:
    /**
     * @brief Construct a StatusGrabber which will read data on a regular basis from
     * the PMC-730 card, and get transmitter status from hcr_xmitd.
     * @param pentek pointer to the p7142sd3c Pentek card to be monitored
     * @param pmc730dHost the name of the host on which HcrPmc730Dameon is
     *      running
     * @param pmc730dPort the port number HcrPmc730Daemon is using for XML-RPC
     * @param xmitdHost the name of the host on which hcr_xmitd is running
     * @param xmitdPort the port number hcr_xmitd is using for XML-RPC
     */
    StatusGrabber(const Pentek::p7142sd3c * pentek,
            std::string pmc730dHost, int pmc730dPort,
            std::string xmitdHost, int xmitdPort);
    
    virtual ~StatusGrabber();
    
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
private slots:
    /**
     * @brief Get current status from all sources
     */
    void _getStatus();

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

    /// The Pentek P7142 we're monitoring
    const Pentek::p7142sd3c * _pentek;

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