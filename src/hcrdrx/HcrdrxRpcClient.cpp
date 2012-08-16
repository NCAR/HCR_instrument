/*
 * HcrdrxRpcClient.cpp
 *
 *  Created on: August 13, 2012
 *      Author: burghart
 */

#include "HcrdrxRpcClient.h"

#include <cstdlib>
#include <logx/Logging.h>

LOGGING("HcrdrxRpcClient")

HcrdrxRpcClient::HcrdrxRpcClient(std::string hcrdrxHost, int hcrdrxPort) :
    XmlRpc::XmlRpcClient(hcrdrxHost.c_str(), hcrdrxPort),
    _hcrdrxHost(hcrdrxHost),
    _hcrdrxPort(hcrdrxPort) {
}

HcrdrxRpcClient::~HcrdrxRpcClient() {
}

bool
HcrdrxRpcClient::_executeXmlRpcCommand(const std::string cmd,
    const XmlRpc::XmlRpcValue & params, XmlRpc::XmlRpcValue & result) {
    DLOG << "Executing '" << cmd << "()' command";
    if (! execute(cmd.c_str(), params, result)) {
        DLOG << "Error executing " << cmd << "() call to hcrdrx";
        return(false);
    }
    if (isFault()) {
        ELOG << "XML-RPC fault on " << cmd << "() call";
        abort();
    }
    return true;  
}

void
HcrdrxRpcClient::xmitFilamentOn() {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue result;
    _executeXmlRpcCommand("xmitFilamentOn", null, result);
}

void
HcrdrxRpcClient::xmitFilamentOff() {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue result;
    _executeXmlRpcCommand("xmitFilamentOff", null, result);
}

void
HcrdrxRpcClient::xmitHvOn() {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue result;
    _executeXmlRpcCommand("xmitHvOn", null, result);
}

void
HcrdrxRpcClient::xmitHvOff() {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue result;
    _executeXmlRpcCommand("xmitHvOff", null, result);
}

bool
HcrdrxRpcClient::getStatus(Status & status) {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue statusDict;
    if (! _executeXmlRpcCommand("getStatus", null, statusDict)) {
        WLOG << __PRETTY_FUNCTION__ << ": getStatus failed!";
        return(false);
    }
    status = Status(statusDict);
    return(true);
}

void
HcrdrxRpcClient::getLogMessages(unsigned int firstIndex, std::string & msgs,
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

// Default constructor; fill with bad values.
HcrdrxRpcClient::Status::Status() :
        _someBoolean(false),
        _someInt(-1),
        _someDouble(-9999.9)
{
}

HcrdrxRpcClient::Status::Status(XmlRpc::XmlRpcValue & statusDict) {
    // Unpack all of the status values from the XmlRpc::XmlRpcValue dictionary
    // into local member variables
//    _someBoolean = _StatusBool(statusDict, "some_boolean");
    
//    _someInt = _StatusInt(statusDict, "some_int");
    
    _someDouble = _StatusDouble(statusDict, "cmigitsTemp");
}

HcrdrxRpcClient::Status::~Status() {
}

bool
HcrdrxRpcClient::Status::_StatusBool(XmlRpc::XmlRpcValue statusDict, std::string key) {
    if (! statusDict.hasMember(key)) {
        ELOG << "Status dictionary does not contain requested key '" << key <<
            "'!";
        abort();
    } else {
        return(bool(statusDict[key]));
    }
}

int
HcrdrxRpcClient::Status::_StatusInt(XmlRpc::XmlRpcValue statusDict, std::string key) {
    if (! statusDict.hasMember(key)) {
        ELOG << "Status dictionary does not contain requested key '" << key <<
            "'!";
        abort();
    } else {
        return(int(statusDict[key]));
    }
}

double
HcrdrxRpcClient::Status::_StatusDouble(XmlRpc::XmlRpcValue statusDict, std::string key) {
    if (! statusDict.hasMember(key)) {
        ELOG << "Status dictionary does not contain requested key '" << key <<
            "'!";
        abort();
    } else {
        return(double(statusDict[key]));
    }
}
