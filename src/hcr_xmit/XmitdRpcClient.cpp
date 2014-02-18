/*
 * XmitdRpcClient.cpp
 *
 *  Created on: Mar 11, 2011
 *      Author: burghart
 */

#include "XmitdRpcClient.h"

#include <cerrno>
#include <cstdlib>
#include <cstring>
#include <logx/Logging.h>

LOGGING("XmitdRpcClient")

XmitdRpcClient::XmitdRpcClient(std::string xmitdHost, int xmitdPort) :
    XmlRpc::XmlRpcClient(xmitdHost.c_str(), xmitdPort),
    _xmitdHost(xmitdHost),
    _xmitdPort(xmitdPort) {
}

XmitdRpcClient::~XmitdRpcClient() {
}

bool
XmitdRpcClient::_executeXmlRpcCommand(const std::string cmd, 
    const XmlRpc::XmlRpcValue & params, XmlRpc::XmlRpcValue & result) {
    DLOG << "Executing '" << cmd << "()' command";
    if (execute(cmd.c_str(), params, result)) {
        return(true);
    }
    if (isFault()) {
        // Report the problem and return false
        WLOG << "XML-RPC fault while executing " << cmd << "() call";
    } else {
        WLOG << "Error on XML-RPC call '" << cmd << "()': " << strerror(errno);
    }
    return(false);
}

void
XmitdRpcClient::xmitFilamentOn() {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue result;
    _executeXmlRpcCommand("xmitFilamentOn", null, result);
}

void
XmitdRpcClient::xmitFilamentOff() {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue result;
    _executeXmlRpcCommand("xmitFilamentOff", null, result);
}

void
XmitdRpcClient::xmitHvOn() {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue result;
    _executeXmlRpcCommand("xmitHvOn", null, result);
}

void
XmitdRpcClient::xmitHvOff() {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue result;
    _executeXmlRpcCommand("xmitHvOff", null, result);
}

bool
XmitdRpcClient::getStatus(XmitStatus & status) {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue statusDict;
    if (! _executeXmlRpcCommand("getStatus", null, statusDict)) {
        WLOG << __PRETTY_FUNCTION__ << ": getStatus failed!";
        return(false);
    }
    status = XmitStatus(statusDict);
    return(true);
}

void
XmitdRpcClient::getLogMessages(unsigned int firstIndex, std::string & msgs, 
        unsigned int  & nextLogIndex) {
    XmlRpc::XmlRpcValue startIndex = int(firstIndex);
    XmlRpc::XmlRpcValue resultDict;
    if (! _executeXmlRpcCommand("getLogMessages", startIndex, resultDict)) {
        WLOG << __PRETTY_FUNCTION__ << ": getLogMessages failed!";
        return;
    }
    msgs.append(std::string(resultDict["logMessages"]));
    nextLogIndex = (unsigned int)(int(resultDict["nextIndex"]));
}
