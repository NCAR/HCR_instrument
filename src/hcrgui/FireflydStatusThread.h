/*
 * FireflydStatusThread.h
 *
 *  Created on: April 1, 2014
 *      Author: burghart
 */

#ifndef FIREFLYSTATUSTHREAD_H_
#define FIREFLYSTATUSTHREAD_H_

#include <fireflydRpcClient.h>
#include <QThread>

/// @brief Class providing a thread which gets fireflyd status on a regular
/// basis using a fireflydRpcClient connection.
///
/// This class uses the given fireflydRpcClient connection to poll for status
/// from fireflyd on a ~1 Hz basis (when connected). When new status is received,
/// a newStatus(FireFlyStatus) signal is emitted. The class also provides a useful
/// way to test for good connection to the fireflyd RPC server, via
/// serverResponsive(bool) signals emitted when connection/disconnection is
/// detected.
class FireflydStatusThread : public QThread {
    Q_OBJECT

public:
    /// @brief Instantiate, creating an fireflydRpcClient connection to the
    /// fireflyd XML-RPC server.
    FireflydStatusThread(std::string fireflydHost, int fireflydPort);
    virtual ~FireflydStatusThread();

    void run();

    /// @brief Return the fireflydRpcClient instance being used to talk to
    /// fireflyd.
    /// @return the fireflydRpcClient instance being used to talk to fireflyd.
    fireflydRpcClient & rpcClient() { return *_client; }

    /// @brief Return true iff the server responded to the last XML-RPC command.
    /// @return true iff the server responded to the last XML-RPC command.
    bool serverIsResponding() const { return(_responsive); }

signals:
    /// @brief Signal emitted when the XML-RPC client connection to fireflyd
    /// becomes responsive or unresponsive.
    /// @param responsive true if fireflyd has become responsive or false
    /// if the server has become unresponsive
    void serverResponsive(bool responsive);

    /// @brief signal emitted when a new status is received from fireflyd
    /// @param status the new status received from fireflyd
    void newStatus(FireFlyStatus status);

private slots:
    /// @brief Try to get latest status from fireflyd, and emit a newStatus()
    /// signal if successful.
    void _getStatus();
private:
    /// True iff the client had a successful connection with the fireflyd
    /// XML-RPC server on the last XML-RPC method call.
    bool _responsive;

    std::string _fireflydHost;
    int _fireflydPort;

    /// The fireflydRpcClient object handling the XML-RPC connection
    fireflydRpcClient * _client;
};

#endif /* FIREFLYSTATUSTHREAD_H_ */
