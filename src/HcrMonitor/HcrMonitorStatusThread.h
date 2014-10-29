/*
 * HcrMonitorStatusThread.h
 *
 *  Created on: Oct 28, 2014
 *      Author: burghart
 */

#ifndef HCRMONITORSTATUSTHREAD_H_
#define HCRMONITORSTATUSTHREAD_H_

#include <QThread>
#include "HcrMonitorRpcClient.h"

/// @brief Class providing a thread which gets HcrMonitor status on a regular
/// basis using a HcrMonitorRpcClient connection.
///
/// This class uses the given HcrMonitorRpcClient connection to poll for status
/// from HcrMonitor on a ~1 Hz basis (when connected). When new status is received,
/// a newStatus(DrxStatus) signal is emitted. The class also provides a useful
/// way to test for good connection to the HcrMonitor RPC server, via
/// serverResponsive(bool) signals emitted when connection/disconnection is
/// detected.
class HcrMonitorStatusThread : public QThread {
    Q_OBJECT

public:
    /// @brief Instantiate, creating a HcrMonitorRpcClient connection to the
    /// HcrMonitor XML-RPC server.
    HcrMonitorStatusThread(std::string mcdHost, int mcdPort);
    virtual ~HcrMonitorStatusThread();

    void run();

    /// @brief Return the HcrMonitorRpcClient instance being used to talk to
    /// HcrMonitor.
    /// @return the HcrMonitorRpcClient instance being used to talk to
    /// HcrMonitor.
    HcrMonitorRpcClient & rpcClient() const { return(*_client); }

    /// @brief Return true iff the HcrMonitor is responding
    /// @return true iff the HcrMonitor is responding
    bool serverIsResponding() const { return(_responsive); }
    
    /// @brief Return the host where HcrMonitor is running
    /// @return the host where HcrMonitor is running
    std::string daemonHost() const { return(_daemonHost); }

    /// @brief Return the port on which HcrMonitor is listening
    /// @return the port on which HcrMonitor is listening
    int daemonPort() const { return(_daemonPort); }

signals:
    /// @brief Signal emitted when the XML-RPC client connection to the server
    /// becomes responsive or unresponsive.
    /// @param responsive true if the server has become responsive or false
    /// @param msg a message describing the associated event
    /// if the server has become unresponsive
    void serverResponsive(bool responsive, QString msg);

    /// @brief signal emitted when a new status is received from 
    /// HcrMonitor
    /// @param status the new status received from HcrMonitor
    void newStatus(HcrMonitorStatus status);

private slots:
    /// @brief Try to get latest status from HcrMonitor, and emit a newStatus()
    /// signal if successful.
    void _getStatus();
private:
    /// True iff the client had a successful connection with the HcrMonitor
    /// XML-RPC server on the last XML-RPC method call.
    bool _responsive;

    std::string _daemonHost;
    int _daemonPort;

    /// The HcrMonitorRpcClient object handling the XML-RPC connection
    HcrMonitorRpcClient * _client;
};

#endif /* HCRMONITORSTATUSTHREAD_H_ */
