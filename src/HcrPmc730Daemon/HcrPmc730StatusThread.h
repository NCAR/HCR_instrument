/*
 * HcrPmc730StatusThread.h
 *
 *  Created on: Sep 10, 2012
 *      Author: hcr
 */

#ifndef HCRPMC730STATUSTHREAD_H_
#define HCRPMC730STATUSTHREAD_H_

#include <QThread>
#include "HcrPmc730Client.h"

/// @brief Class providing a thread which gets hcrdrx status on a regular
/// basis using a HcrPmc730Client connection.
///
/// This class uses the given HcrPmc730RpcClient connection to poll for status
/// from hcrdrx on a ~1 Hz basis (when connected). When new status is received,
/// a newStatus(DrxStatus) signal is emitted. The class also provides a useful
/// way to test for good connection to the hcrdrx RPC server, via
/// serverResponsive(bool) signals emitted when connection/disconnection is
/// detected.
class HcrPmc730StatusThread : public QThread {
    Q_OBJECT

public:
    /// @brief Instantiate, creating an HcrPmc730Client connection to the
    /// hcrdrx XML-RPC server.
    HcrPmc730StatusThread(std::string hcrdrxHost, int hcrdrxPort);
    virtual ~HcrPmc730StatusThread();

    void run();

    /// @brief Return the HcrPmc730Client instance being used to talk to hcrdrx.
    /// @return the HcrPmc730Client instance being used to talk to hcrdrx.
    HcrPmc730Client & rpcClient() { return *_client; }

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

    /// The HcrPmc730Client object handling the XML-RPC connection
    HcrPmc730Client * _client;
};

#endif /* HCRPMC730STATUSTHREAD_H_ */