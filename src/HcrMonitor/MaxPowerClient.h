/*
 * MaxPowerClient.h
 *
 *  Created on: Oct 29, 2014
 *      Author: burghart
 */

#ifndef MAXPOWERCLIENT_H_
#define MAXPOWERCLIENT_H_

#include <string>
#include <QByteArray>
#include <QTcpSocket>
#include <QThread>

class QDomDocument;

class MaxPowerClient : public QThread {
    Q_OBJECT
public:
    MaxPowerClient(std::string serverHost, int serverPort);
    virtual ~MaxPowerClient();
    
    void run();
signals:
    /// @brief Signal emitted when the XML-RPC client connection to the server
    /// becomes responsive or unresponsive.
    /// @param responsive true if the server has become responsive or false
    /// @param msg a message describing the associated event
    /// if the server has become unresponsive
    void serverResponsive(bool responsive, QString msg);

    /// @brief Signal emitted when a new maximum power is received from 
    /// the TsPrint max power server.
    /// @param time the center time for of the max power dwell, seconds since
    ///    1970-01-01 00:00:00 UTC
    /// @param dwellTime the length of time over which max power was sampled, s
    /// @param maxPower the maximum power measured, dBm
    /// @param rangeToMax the range from the radar to the maximum power 
    ///    return, m
    void newMaxPower(double time, double dwellTime, double maxPower, double rangeToMax);
    
private slots:

    /// @brief Slot to be called on connect to server
    void _onConnect();
    
    /// @brief Slot to be called on disconnect from server
    void _onDisconnect();
    
    /// @brief Slot to be called when new data arrive from the server
    void _readData();
    
    /// @brief Slot to be called on socket errors
    /// @param error the socket error which occurred
    void _onSocketError(QAbstractSocket::SocketError error);
    
    /// @brief Start a connection attempt with our server
    void _tryToConnect();

private:
    /// @brief Text marking the start of a TsPrintMaxPower element
    static const QByteArray ELEMENT_START_TEXT;
    
    /// @brief Text marking the end of a TsPrintMaxPower element
    static const QByteArray ELEMENT_END_TEXT;
    
    /// @brief Parse our _unparsedData array, handling each complete 
    /// TsPrintMaxPower element found, and removing parsed data.
    void _parseUnparsedData();
    
    /// @brief Deal with a max power XML element, which should be of the
    /// form:
    ///      <TsPrintMaxPower>
    ///        <time>2014-11-20T18:03:51</time>
    ///        <msecs>679</msecs>
    ///        <dwellSecs>0.506881</dwellSecs>
    ///        <prf>9864.27</prf>
    ///        <nSamples>5000</nSamples>
    ///        <startGate>30</startGate>
    ///        <nGates>740</nGates>
    ///        <el>87.9828</el>
    ///        <az>228.685</az>
    ///        <maxDbm0>-96.5835</maxDbm0>
    ///        <maxDbm1>-95.2945</maxDbm1>
    ///        <rangeToMax0>7374.89</rangeToMax0>
    ///        <rangeToMax1>7183.03</rangeToMax1>
    ///      </TsPrintMaxPower>
    /// Emit a newMaxPower() signal if the element parses correctly.
    /// @param text the text of the max power XML element
    void _handleMaxPowerElement(const QByteArray & text);
    
    /// @brief Set up a timer to trigger an attempt to connect to the server
    /// after a brief wait.
    void _setUpDelayedConnectRetry();
    
    /// @brief Return the text of the requested element from the given DOM
    /// document as a QString
    /// @param doc the QDomDocument from which to extract the desired element
    /// @param elementName the name of the element to be extracted from the 
    /// document
    /// @return the text of the requested DOM document element as a QString
    static QString _DocElementText(const QDomDocument & doc, QString elementName);
    
    /// @brief name of the host where the MaxPowerServer (a special TsPrint 
    /// process) is running
    std::string _serverHost;
    
    /// @brief port number on which the server is listening
    int _serverPort;
    
    /// @brief socket for our connection to the server
    QTcpSocket _socket;
    
    /// @brief True iff the server is responding 
    bool _serverResponsive;
    
    /// @brief Data read from the socket but not yet parsed
    QByteArray _unparsedData;
};

#endif /* MAXPOWERSERVERCLIENT_H_ */
