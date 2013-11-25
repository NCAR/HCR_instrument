/*
 * MotionControlClientThread.h
 *
 *  Created on: Jul 25, 2013
 *      Author: burghart
 */

#ifndef MOTIONCONTROLCLIENTTHREAD_H_
#define MOTIONCONTROLCLIENTTHREAD_H_

#include <MotionControlRpcClient.h>
#include <QThread>

/// @brief Class providing a thread which gets MotionControlDaemon status on a
/// regular basis using a MotionControlRpcClient connection.
///
/// This class uses the given MotionControlRpcClient connection to poll for
/// status from MotionControlDaemon on a ~1 Hz basis. When new
/// status is received, a newStatus(MotionControl::Status) signal is emitted. The class also
/// provides a useful way to test for good connection to the MotionControlDaemon
/// RPC server, via serverResponsive(bool) signals emitted when
/// connection/disconnection is detected.
class MotionControlClientThread : public QThread {
    Q_OBJECT

public:
    /// @brief Instantiate, creating an MotionControlRpcClient connection to the
    /// MotionControlDaemon XML-RPC server.
    MotionControlClientThread(std::string xmitdHost, int xmitdPort);
    virtual ~MotionControlClientThread();

    void run();

    /// @brief Return the MotionControlRpcClient instance being used to talk to
    /// MotionControlDaemon.
    /// @return the MotionControlRpcClient instance being used to talk to
    /// MotionControlDaemon.
    MotionControlRpcClient & rpcClient() { return *_client; }

    /// @brief Return true iff the server responded to the last XML-RPC command.
    /// @return true iff the server responded to the last XML-RPC command.
    bool serverIsResponding() const { return(_responsive); }

signals:
    /// @brief Signal emitted when the XML-RPC client connection to the server
    /// becomes responsive or unresponsive.
    /// @param responsive true if the server has become responsive or false
    /// if the server has become unresponsive
    void serverResponsive(bool responsive);
    /// @brief signal emitted when a new status is received from
    /// MotionControlDaemon
    /// @param status the new status received from MotionControlDaemon
    void newStatus(MotionControl::Status status);

private slots:
    /// @brief Try to get latest status from MotionControlDaemon, and emit a
	/// newStatus() signal if successful.
    void _getStatus();
private:
    /// True iff the client had a successful connection with the
    /// MotionControlDaemon XML-RPC server on the last XML-RPC method call.
    bool _responsive;

    std::string _mcHost;
    int _mcPort;

    /// The MotionControlRpcClient object handling the XML-RPC connection
    MotionControlRpcClient * _client;
};

#endif /* MOTIONCONTROLCLIENTTHREAD_H_ */
