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
#include <xercesc/parsers/XercesDOMParser.hpp>

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
    /// @param time the time for the max power data, seconds since 
    ///    1970-01-01 00:00:00 UTC
    /// @param maxPower the maximum power measured, dBm
    /// @param rangeToMax the range from the radar to the maximum power 
    ///    return, m
    void newMaxPower(double time, double maxPower, double rangeToMax);
    
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
    ///        <time>2014-10-17T21:39:00</time>
    ///        <msecs>848</msecs>
    ///        <prf>9864.27</prf>
    ///        <nSamples>1000</nSamples>
    ///        <startGate>30</startGate>
    ///        <nGates>670</nGates>
    ///        <el>-88.9096</el>
    ///        <az>185.969</az>
    ///        <maxDbm0>-44.7249</maxDbm0>
    ///        <maxDbm1>-52.216</maxDbm1>
    ///        <rangeToMax0>2539.84</rangeToMax0>
    ///        <rangeToMax1>2539.84</rangeToMax1>
    ///     </TsPrintMaxPower>
    /// @param text the text of the max power XML element
    void _handleMaxPowerElement(const QByteArray & text);
    
    /// @brief Set up a timer to trigger an attempt to connect to the server
    /// after a brief wait.
    void _setUpDelayedConnectRetry();
    
    /// @brief Return the text of the requested Xerces DOM document element as 
    /// a QString
    /// @param doc a pointer to the Xerces DOM document
    /// @param elementName the name of the element to be extracted from the 
    /// document
    /// @return the text of the requested Xerces DOM document element as 
    /// a QString
    static QString _DocElementText(xercesc::DOMElement * doc, std::string elementName);
    
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
    
    /// @brief XML parser
    xercesc::XercesDOMParser * _xmlParser;
};

#endif /* MAXPOWERSERVERCLIENT_H_ */
