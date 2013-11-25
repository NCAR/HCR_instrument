/*
 * CmigitsStatusThread.h
 *
 *  Created on: Sep 24, 2013
 *      Author: burghart
 */
#ifndef CMIGITSSTATUSTHREAD_H_
#define CMIGITSSTATUSTHREAD_H_

#include <CmigitsDaemonRpcClient.h>
#include <QThread>

/// @brief Class providing a thread which gets cmigitsDaemon status on a regular
/// basis using a CmigitsDaemonRpcClient connection.
///
/// This class uses the given CmigitsDaemonRpcClient connection to poll for 
/// status from cmigitsDaemon on a ~1 Hz basis (when connected). When new status
/// is received, newStatus(CmigitsStatus) signal is emitted. The class also 
/// provides a useful way to test for good connection to the cmigitsDaemon RPC 
/// server, via serverResponsive(bool) signals emitted when connection/
/// disconnection is detected.
class CmigitsStatusThread : public QThread {
    Q_OBJECT

public:
    /// @brief Instantiate, creating an CmigitsDaemonRpcClient connection to the
    /// cmigitsDaemon XML-RPC server.
    CmigitsStatusThread(std::string cmigitsHost, int cmigitsPort);
    virtual ~CmigitsStatusThread();

    void run();

    /// @brief Return the CmigitsDaemonRpcClient instance being used to talk to 
    /// cmigitsDaemon.
    /// @return the CmigitsDaemonRpcClient instance being used to talk to 
    /// cmigitsDaemon.
    CmigitsDaemonRpcClient & rpcClient() { return *_client; }

    /// @brief Return true iff the server responded to the last XML-RPC command.
    /// @return true iff the server responded to the last XML-RPC command.
    bool serverIsResponding() const { return(_responsive); }

signals:
    /// @brief Signal emitted when the XML-RPC client connection to the server
    /// becomes responsive or unresponsive.
    /// @param responsive true if the server has become responsive or false
    /// if the server has become unresponsive
    /// @param msg a message describing the associated event
    void serverResponsive(bool responsive, QString msg);

    /// @brief signal emitted when a new status is received from CmigitsDaemon
    /// @param status the new status received from CmigitsDaemon
    void newStatus(CmigitsStatus status);

private slots:
    /// @brief Try to get latest status from cmigitsDaemon, and emit a 
    /// newStatus() signal if successful.
    void _getStatus();
private:
    /// True iff the client had a successful connection with the cmigitsDaemon
    /// XML-RPC server on the last XML-RPC method call.
    bool _responsive;

    std::string _cmigitsHost;
    int _cmigitsPort;

    /// The CmigitsDaemonRpcClient object handling the XML-RPC connection
    CmigitsDaemonRpcClient * _client;
};

#endif /* CMIGITSSTATUSTHREAD_H_ */
