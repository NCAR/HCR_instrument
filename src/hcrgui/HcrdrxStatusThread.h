/*
 * HcrdrxStatusThread.h
 *
 *  Created on: Sep 10, 2012
 *      Author: hcr
 */

#ifndef HCRDRXSTATUSTHREAD_H_
#define HCRDRXSTATUSTHREAD_H_

#include <HcrdrxRpcClient.h>
#include <QThread>

/// @brief Class providing a thread which gets hcrdrx status on a regular
/// basis using a HcrdrxRpcClient connection.
///
/// This class uses the given HcrdrxRpcClient connection to poll for status
/// from hcrdrx on a ~1 Hz basis (when connected). When new status is received,
/// a newStatus(DrxStatus) signal is emitted. The class also provides a useful
/// way to test for good connection to the hcrdrx RPC server, via
/// serverResponsive(bool) signals emitted when connection/disconnection is
/// detected.
class HcrdrxStatusThread : public QThread {
    Q_OBJECT

public:
    /// @brief Instantiate, creating an HcrdrxRpcClient connection to the
    /// hcrdrx XML-RPC server.
    HcrdrxStatusThread(std::string hcrdrxHost, int hcrdrxPort);
    virtual ~HcrdrxStatusThread();

    void run();

    /// @brief Return the HcrdrxRpcClient instance being used to talk to hcrdrx.
    /// @return the HcrdrxRpcClient instance being used to talk to hcrdrx.
    HcrdrxRpcClient & rpcClient() { return *_client; }

    /// @brief Return true iff the server responded to the last XML-RPC command.
    /// @return true iff the server responded to the last XML-RPC command.
    bool serverIsResponding() { return(_responsive); }

signals:
    /// @brief Signal emitted when the XML-RPC client connection to the server
    /// becomes responsive or unresponsive.
    /// @param responsive true if the server has become responsive or false
    /// if the server has become unresponsive
    void serverResponsive(bool responsive);
    /// @brief signal emitted when a new status is received from hcrdrx
    /// @param status the new status received from hcrdrx
    void newStatus(DrxStatus status);

private slots:
    /// @brief Try to get latest status from hcrdrx, and emit a newStatus()
    /// signal if successful.
    void _getStatus();
private:
    /// True iff the client had a successful connection with the hcrdrx
    /// XML-RPC server on the last XML-RPC method call.
    bool _responsive;

    std::string _drxHost;
    int _drxPort;

    /// The HcrdrxRpcClient object handling the XML-RPC connection
    HcrdrxRpcClient * _client;
};

#endif /* HCRDRXSTATUSTHREAD_H_ */
