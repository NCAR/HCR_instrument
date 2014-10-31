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
#include <QThread>
#include <xercesc/parsers/XercesDOMParser.hpp>

class QTcpSocket;

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

    /// @brief signal emitted when a new status is received from 
    /// HcrMonitor
    /// @param status the new status received from HcrMonitor
    void newMaxPower();

private slots:

    /// @brief Slot to be called on connect to server
    void _onConnect();
    
    /// @brief Slot to be called on disconnect from server
    void _onDisconnect();
    
    /// @brief Slot to be called when new data arrive from the server
    void _readData();

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
    ///          <foo>..</foo>
    ///          <bar>..</bar>
    ///          ...
    ///      </TsPrintMaxPower>
    /// @param text the text of the max power XML element
    void _handleMaxPowerElement(const QByteArray & text);
    
    /// @brief name of the host where the MaxPowerServer (a special TsPrint 
    /// process) is running
    std::string _serverHost;
    
    /// @brief port number on which the server is listening
    int _serverPort;
    
    /// @brief socket for our connection to the server
    QTcpSocket * _socket;
    
    /// @brief True iff the server is responding 
    bool _serverResponsive;
    
    /// @brief Data read from the socket but not yet parsed
    QByteArray _unparsedData;
    
    /// @brief XML parser
    xercesc::XercesDOMParser * _xmlParser;
};

#endif /* MAXPOWERSERVERCLIENT_H_ */
