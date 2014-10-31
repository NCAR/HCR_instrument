/*
 * MaxPowerClient.cpp
 *
 *  Created on: Oct 29, 2014
 *      Author: burghart
 */

#include "MaxPowerClient.h"
#include <exception>
#include <logx/Logging.h>
#include <QTcpSocket>
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
    try {
        XMLPlatformUtils::Initialize();  // Initialize Xerces infrastructure
    } catch (XMLException & e ) {
        char* msg = XMLString::transcode(e.getMessage());
        ELOG << "XML toolkit initialization error: " << msg;
        std::runtime_error runtimeErr(msg);
        XMLString::release(&msg);
        throw runtimeErr;
    }

    _xmlParser = new XercesDOMParser();
}

MaxPowerClient::~MaxPowerClient() {
    // stop the thread
    quit();
    // wait up to a second for thread to finish
    wait(1000);
}

void
MaxPowerClient::run() {
    _socket = new QTcpSocket();
    
    // Create the socket to get data from the server, and connect its signals.
    connect(_socket, SIGNAL(connected()), this, SLOT(_onConnect()));
    connect(_socket, SIGNAL(disconnected()), this, SLOT(_onDisconnect()));
    connect(_socket, SIGNAL(onReadyRead()), this, SLOT(_readData()));
    
    // Open a read-only connection to the server
    _socket->connectToHost(QString(_serverHost.c_str()), _serverPort, 
            QIODevice::ReadOnly);
    
    // XXX TODO REMOVE THIS. One-time file parse test for now.
    _unparsedData = 
            "<TsPrintMaxPower> \n"
            "  <time>2014-10-17T21:39:00</time>\n"
            "  <msecs>848</msecs>\n"
            "  <prf>9864.27</prf>\n"
            "  <nSamples>1000</nSamples>\n"
            "  <startGate>30</startGate>\n"
            "  <nGates>670</nGates>\n"
            "  <el>-88.9096</el>\n"
            "  <az>185.969</az>\n"
            "  <maxDbm0>-44.7249</maxDbm0>\n"
            "  <maxDbm1>-52.216</maxDbm1>\n"
            "  <rangeToMax0>2539.84</rangeToMax0>\n"
            "  <rangeToMax1>2539.84</rangeToMax1>\n"
            "</TsPrintMaxPower>\n"
            "\n"
            "<TsPrintMaxPower>\n"
            "  <time>2014-10-17T21:39:00</time>\n"
            "  <msecs>950</msecs>\n"
            "  <prf>9864.27</prf>\n"
            "  <nSamples>1000</nSamples>\n"
            "  <startGate>30</startGate>\n"
            "  <nGates>670</nGates>\n"
            "  <el>-88.9096</el>\n"
            "  <az>185.969</az>\n"
            "  <maxDbm0>-43.9097</maxDbm0>\n"
            "  <maxDbm1>-52.3913</maxDbm1>\n"
            "  <rangeToMax0>2539.84</rangeToMax0>\n"
            "  <rangeToMax1>2539.84</rangeToMax1>\n"
            "</TsPrintMaxPower>\n"
            "\n"
            "<TsPrintMaxPower>\n"
            "  <time>2014-10-17T21:39:01</time>\n"
            "  <msecs>51</msecs>\n"
            "  <prf>9864.27</prf>\n"
            "  <nSamples>1000</nSamples>\n"
            "  <startGate>30</startGate>\n"
            "  <nGates>670</nGates>\n"
            "  <el>-88.9096</el>\n"
            "  <az>185.969</az>\n"
            "  <maxDbm0>-45.2106</maxDbm0>\n"
            "  <maxDbm1>-52.3038</maxDbm1>\n"
            "  <rangeToMax0>2539.84</rangeToMax0>\n"
            "  <rangeToMax1>2539.84</rangeToMax1>\n"
            "</TsPrintMaxPower>\n"
            "\n"
            "<TsPrintMaxPower>\n"
            "  <time>2014-10-17T21:39:01</time>\n"
            "  <msecs>153</msecs>\n"
            "  <prf>9864.27</prf>\n"
            "  <nSamples>1000</nSamples>\n"
            "  <startGate>30</startGate>\n"
            "  <nGates>670</nGates>\n"
            "  <el>-88.9096</el>\n"
            "  <az>185.969</az>\n"
            "  <maxDbm0>-45.9284</maxDbm0>\n"
            "  <maxDbm1>-52.3559</maxDbm1>\n"
            "  <rangeToMax0>2539.84</rangeToMax0>\n"
            "  <rangeToMax1>2539.84</rangeToMax1>\n"
            "</TsPrintMaxPower>\n"
            "\n";

    _parseUnparsedData();

//    _xmlParser->parse("maxpower.xml");
//    DOMElement * doc = _xmlParser->getDocument()->getDocumentElement();
//    ILOG << "Root element has " << doc->getChildElementCount() << " child elements";
//    for (DOMElement * element = doc->getFirstElementChild(); element; 
//            element = element->getNextElementSibling()) {
//        ILOG << "Element '" << XMLString::transcode(element->getTagName()) << "'";
//        ILOG << "    has " << element->getChildElementCount() << " child elements";
//        ILOG << "    and its time is " << XMLString::transcode(element->getElementsByTagName(XMLString::transcode("time"))->item(0)->getTextContent());
//    }
    
    // Start the event loop
    exec();
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
    std::string msg("Connection established to max power server");
    ILOG << msg;
    emit serverResponsive(_serverResponsive, QString(msg.c_str()));
}

void
MaxPowerClient::_readData() {
    ILOG << "Max power server data arrived";
    _unparsedData.append(_socket->readAll());
    _parseUnparsedData();
}

void
MaxPowerClient::_parseUnparsedData() {
    // Loop through the unparsed data to find the last element of the form:
    //     <TsPrintMaxPower>...</TsPrintMaxPower>
    // and if found, pass it to _parseMaxPowerElement().
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
                if (_unparsedData.size()) {
                    ILOG << "_unparsedData is now:\n" << _unparsedData.data();
                }
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
                if (_unparsedData.size()) {
                    ILOG << "_unparsedData is now:\n" << _unparsedData.data();
                }
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
    if (_unparsedData.size()) {
        ILOG << "_unparsedData is now:\n" << _unparsedData.data();
    }
}

void
MaxPowerClient::_handleMaxPowerElement(const QByteArray & text) {
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
    
    // Map the element text into a MemBufInputSource and have Xerces
    // parse from that.
    const XMLByte * srcData = reinterpret_cast<const XMLByte*>(text.data());
    MemBufInputSource src(srcData, text.size(), "foo");
    _xmlParser->parse(src);
    
    // Get the document, which is the TsPrintMaxPower element
    DOMElement * doc = _xmlParser->getDocument()->getDocumentElement();
    DOMElement * timeElement = dynamic_cast<DOMElement*>(
            doc->getElementsByTagName(XMLString::transcode("time"))->item(0));
    const char * timeText = XMLString::transcode(timeElement->getTextContent());
    ILOG << "TsPrintMaxPower element time is " << timeText;
    
//    for (DOMElement * element = doc->getFirstElementChild(); element; 
//            element = element->getNextElementSibling()) {
//        ILOG << "Element '" << XMLString::transcode(element->getTagName()) << "'";
//        ILOG << "    has " << element->getChildElementCount() << " child elements";
//        ILOG << "    and its time is " << XMLString::transcode(element->getElementsByTagName(XMLString::transcode("time"))->item(0)->getTextContent());
//    }    
}
