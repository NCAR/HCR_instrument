/*
 * MaxPowerClient.cpp
 *
 *  Created on: Oct 29, 2014
 *      Author: burghart
 */

#include "MaxPowerClient.h"
#include <exception>
#include <logx/Logging.h>
#include <QDateTime>
#include <QMetaType>
#include <QTcpSocket>
#include <QTimer>
#include <xercesc/dom/DOM.hpp>
#include <xercesc/framework/MemBufInputSource.hpp>

LOGGING("MaxPowerClient")

const QByteArray MaxPowerClient::ELEMENT_START_TEXT("<TsPrintMaxPower>");
const QByteArray MaxPowerClient::ELEMENT_END_TEXT("</TsPrintMaxPower>");

// I'd rather not do this, but otherwise code gets really dense below
using namespace xercesc;

MaxPowerClient::MaxPowerClient(std::string serverHost, 
    int serverPort) :
        _serverHost(serverHost),
        _serverPort(serverPort),
        _socket(),
        _serverResponsive(false),
        _unparsedData(),
        _xmlParser(NULL) {
    // Initialize the Xerces-c infrastructure for XML parsing
    try {
        XMLPlatformUtils::Initialize();
    } catch (XMLException & e ) {
        char* msg = XMLString::transcode(e.getMessage());
        ELOG << "XML toolkit initialization error: " << msg;
        std::runtime_error runtimeErr(msg);
        XMLString::release(&msg);
        throw runtimeErr;
    }
    // Register QAbstractSocket::SocketError as a metatype, since we
    // receive it as an argument to a slot.
    qRegisterMetaType<QAbstractSocket::SocketError>("QAbstractSocket::SocketError");

    // Our XML DOM parser
    _xmlParser = new XercesDOMParser();
    
    // Connect signals from our socket which will be connected to the server
    connect(&_socket, SIGNAL(connected()), this, SLOT(_onConnect()));
    connect(&_socket, SIGNAL(disconnected()), this, SLOT(_onDisconnect()));
    connect(&_socket, SIGNAL(error(QAbstractSocket::SocketError)), 
            this, SLOT(_onSocketError(QAbstractSocket::SocketError)));
    connect(&_socket, SIGNAL(readyRead()), this, SLOT(_readData()));
    
}

MaxPowerClient::~MaxPowerClient() {
    // stop the thread
    quit();
    // wait up to a second for thread to finish
    wait(1000);
}

void
MaxPowerClient::run() {
    // Start a connection attempt the server
    _tryToConnect();
    
    // Start the event loop
    exec();
    
    _socket.disconnectFromHost();
}

void
MaxPowerClient::_tryToConnect() {
    // Try to establish a connection with the server if we're not currently
    // connected.
    if (_socket.state() == QAbstractSocket::UnconnectedState) {
        ILOG << "Trying to connect to " << _serverHost << ":" << _serverPort;
        // Open a read-only connection to the TsPrint max_power_server's port
        _socket.connectToHost(QString(_serverHost.c_str()), _serverPort, 
                QIODevice::ReadOnly);
    }
}

void
MaxPowerClient::_onConnect() {
    _serverResponsive = true;
    std::string msg("Connection established to max power server");
    ILOG << msg;
    emit serverResponsive(_serverResponsive, QString(msg.c_str()));
}

void
MaxPowerClient::_onDisconnect() {
    _serverResponsive = false;
    std::string msg("Socket to max power server is disconnected");
    ILOG << msg;
    emit serverResponsive(_serverResponsive, QString(msg.c_str()));
    
    // Try for a connection again in a bit
    _setUpDelayedConnectRetry();
}

void
MaxPowerClient::_readData() {
    // Append any new data to the end of _unparsedData, then process what we can
    _unparsedData.append(_socket.readAll());
    _parseUnparsedData();
}

void
MaxPowerClient::_onSocketError(QAbstractSocket::SocketError error) {
    switch (error) {
    case QAbstractSocket::ConnectionRefusedError:
        WLOG << "Connection refused to " << _serverHost << ":" << _serverPort;
        break;
    case QAbstractSocket::RemoteHostClosedError:
        WLOG << "Server at " << _serverHost << ":" << _serverPort << 
            " closed connection";
        break;
    default:
        WLOG << "Got QAbstractSocket::SocketError " << error;
        break;
    }
    // If we're not connected, try for a connection again in a bit
    if (_socket.state() == QAbstractSocket::UnconnectedState) {
        _setUpDelayedConnectRetry();
    }
}

void
MaxPowerClient::_setUpDelayedConnectRetry() {
    const int CONNECT_RETRY_SECONDS = 2;
    QTimer::singleShot(1000 * CONNECT_RETRY_SECONDS, this, SLOT(_tryToConnect()));
    ILOG << "...will attempt to connect again in " << CONNECT_RETRY_SECONDS <<
            " seconds";
}

void
MaxPowerClient::_parseUnparsedData() {
    // Loop through the unparsed data to find the last element (if any) of the 
    // form:
    //
    //     <TsPrintMaxPower>...</TsPrintMaxPower>
    //
    // If found, extract it and pass it to _parseMaxPowerElement().
    int lastMaxPwrStart = 0;
    int lastMaxPwrLen = 0;
    int elementsFound = 0;
    
    while (true) {
        // Find the position of the next start tag after the end of
        // the last complete element we found (if any).
        int startTagIndex = _unparsedData.indexOf(ELEMENT_START_TEXT, 
                lastMaxPwrStart + lastMaxPwrLen);
        
        // If we didn't find a next start tag, we're done.
        if (startTagIndex == -1) {
            if (! elementsFound) {
                // No element was found. Just keep the last few bytes of
                // _unparsedData in case it's an incomplete start tag and 
                // return.
                _unparsedData = _unparsedData.right(ELEMENT_START_TEXT.size() - 1);
                return;
            } else {
                // We have the bounds of the last complete <TsPrintMaxPower> 
                // element, continue to the parsing of it.
                break;
            }
        }
        
        // Find the associated end tag (if any) for the start tag at startTagIndex
        int endTagIndex = _unparsedData.indexOf(ELEMENT_END_TEXT, startTagIndex);
        
        // If we didn't find a next end tag, we're done
        if (endTagIndex == -1) {
            if (! elementsFound) {
                // No complete element was found. Drop everything in 
                // _unparsedData before the start tag we just found and return.
                _unparsedData = _unparsedData.right(_unparsedData.size() - startTagIndex);
                return;
            } else {
                // We have the bounds of the last complete <TsPrintMaxPower> 
                // element, continue to the parsing of it.
                break;
            }
        }
        
        // Save the bounds of this <TsPrintMaxPower> element, and go back to
        // look for the next one, if any.
        elementsFound++;
        lastMaxPwrStart = startTagIndex;
        lastMaxPwrLen = (endTagIndex - startTagIndex) + ELEMENT_END_TEXT.size();
    }
    
    // Warn if we found more than one TsPrintMaxPower element in the text
    // which arrived, since we only handle the last one.
    if (elementsFound > 1) {
        WLOG << "Dropping " << elementsFound - 1 << 
                " TsPrintMaxPower elements of " << elementsFound << 
                " which arrived";
    }
    
    // We have the bounds of the last <TsPrintMaxPower>...</TsPrintMaxPower>
    // element now. Extract the element text and pass it on to 
    // _parseTsPrintMaxPower().
    QByteArray elementText = _unparsedData.mid(lastMaxPwrStart, lastMaxPwrLen);
    _handleMaxPowerElement(elementText);
    
    // Keep everything remaining after the last <TsPrintMaxPower> element in 
    // _unparsedData and return.
    _unparsedData = _unparsedData.right(_unparsedData.size() - 
            (lastMaxPwrStart + lastMaxPwrLen));
}

QString
MaxPowerClient::_DocElementText(DOMElement * doc, std::string elementName) {
    // We have to use transcode() to move back and forth between Xerces-friendly
    // chars and native. Every time we do this, we have to explicitly release
    // the memory returned by transcode(). Pain in the butt.
    XMLCh * xercesElementName = XMLString::transcode(elementName.c_str());
    DOMElement * childElement = 
            dynamic_cast<DOMElement*>(doc->getElementsByTagName(xercesElementName)->item(0));
    XMLString::release(&xercesElementName);
    
    char * textContent = XMLString::transcode(childElement->getTextContent());
    QString elementText(textContent);
    XMLString::release(&textContent);
    return(elementText);
}

void
MaxPowerClient::_handleMaxPowerElement(const QByteArray & text) {
    ILOG << "Max power element: \n" << text.data();
    // The text we're given must begin with ELEMENT_START_TEXT and end with
    // ELEMENT_END_TEXT.
    if (text.indexOf(ELEMENT_START_TEXT) != 0 ||
        text.indexOf(ELEMENT_END_TEXT) != (text.size() - ELEMENT_END_TEXT.size())) {
        std::ostringstream oss;
        oss << "BUG: text in _handleMaxPowerElement() does not start with '" <<
                ELEMENT_START_TEXT.data() << "' and end with '" <<
                ELEMENT_END_TEXT.data() << "'";
        ELOG << oss.str();
        throw std::runtime_error(oss.str());
    }
    
    // Map the incoming text into a MemBufInputSource and have Xerces
    // parse from that.
    const XMLByte * srcData = reinterpret_cast<const XMLByte*>(text.data());
    MemBufInputSource src(srcData, text.size(), "foo");
    _xmlParser->parse(src);
    
    // Get the document, which is the parsed contents of the incoming text
    DOMElement * doc = _xmlParser->getDocument()->getDocumentElement();
    
    // Initialize dataTime from the "time" child element (ISO time to the 
    // second)
    QString timeText = _DocElementText(doc, "time");
    QDateTime dataTime = QDateTime::fromString(timeText, Qt::ISODate);
    
    // Unpack the parsed "msecs" element, which is the milliseconds portion of 
    // the data time, and add it to dataTime.
    int msecs = _DocElementText(doc, "msecs").toInt();
    dataTime = dataTime.addMSecs(msecs);
    
    // Get H channel max power from "maxDbm0" element
    double maxDbmH = _DocElementText(doc, "maxDbm0").toDouble();
    
    // Get V channel max power from "maxDbm1" element
    double maxDbmV = _DocElementText(doc, "maxDbm1").toDouble();
    
    // Get range to H channel max power from "rangeToMax0" element
    double rangeToMaxH = _DocElementText(doc, "rangeToMax0").toDouble();
    
    // Get range to V channel max power from "rangeToMax1" element
    double rangeToMaxV = _DocElementText(doc, "rangeToMax1").toDouble();
    
    // Figure out which max is *really* max
    double maxDbm = (maxDbmH > maxDbmV) ? maxDbmH : maxDbmV;
    double rangeToMax = (maxDbmH > maxDbmV) ? rangeToMaxH : rangeToMaxV;
    
    // Emit newMaxPower() signal
    ILOG << "New max power at " << 
            dataTime.toString("yyyy/MM/dd hh:mm:ss.zzz").toStdString() <<
            ": " << maxDbm << " dBm (" << rangeToMax << " m range)";
    double secondsSinceEpoch = dataTime.toTime_t() + 0.001 * dataTime.time().msec();
    emit(newMaxPower(secondsSinceEpoch, maxDbm, rangeToMax));
}