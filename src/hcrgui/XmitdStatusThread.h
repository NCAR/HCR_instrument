/*
 * XmitdStatusThread.h
 *
 *  Created on: Sep 10, 2012
 *      Author: hcr
 */

#ifndef XMITDSTATUSTHREAD_H_
#define XMITDSTATUSTHREAD_H_

#include <XmitdRpcClient.h>
#include <QThread>

/// @brief Class providing a thread which gets hcr_xmitd status on a regular
/// basis using a XmitdRpcClient connection.
///
/// This class uses the given XmitdRpcClient connection to poll for status
/// from hcr_xmitd on a ~1 Hz basis (when connected). When new status is received,
/// a newStatus(DrxStatus) signal is emitted. The class also provides a useful
/// way to test for good connection to the hcr_xmitd RPC server, via
/// serverResponsive(bool) signals emitted when connection/disconnection is
/// detected.
class XmitdStatusThread : public QThread {
    Q_OBJECT

public:
    /// @brief Instantiate, creating an XmitdRpcClient connection to the
    /// hcr_xmitd XML-RPC server.
    XmitdStatusThread(std::string xmitdHost, int xmitdPort);
    virtual ~XmitdStatusThread();

    void run();

    /// @brief Return the XmitdRpcClient instance being used to talk to hcr_xmitd.
    /// @return the XmitdRpcClient instance being used to talk to hcr_xmitd.
    XmitdRpcClient & rpcClient() { return *_client; }

    /// @brief Return true iff the server responded to the last XML-RPC command.
    /// @return true iff the server responded to the last XML-RPC command.
    bool serverIsResponding() const { return(_responsive); }

signals:
    /// @brief Signal emitted when the XML-RPC client connection to the server
    /// becomes responsive or unresponsive.
    /// @param responsive true if the server has become responsive or false
    /// if the server has become unresponsive
    void serverResponsive(bool responsive);
    /// @brief signal emitted when a new status is received from hcr_xmitd
    /// @param status the new status received from hcr_xmitd
    void newStatus(XmitStatus status);

private slots:
    /// @brief Try to get latest status from hcr_xmitd, and emit a newStatus()
    /// signal if successful.
    void _getStatus();
private:
    /// True iff the client had a successful connection with the hcr_xmitd
    /// XML-RPC server on the last XML-RPC method call.
    bool _responsive;

    std::string _xmitdHost;
    int _xmitdPort;

    /// The XmitdRpcClient object handling the XML-RPC connection
    XmitdRpcClient * _client;
};

#endif /* XMITDSTATUSTHREAD_H_ */
