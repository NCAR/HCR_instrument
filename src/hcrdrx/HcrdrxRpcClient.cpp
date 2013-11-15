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
HcrdrxRpcClient::zeroPentekMotorCounts() {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue result;
    _executeXmlRpcCommand("zeroPentekMotorCounts", null, result);
}

bool
HcrdrxRpcClient::getStatus(DrxStatus & status) {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue statusDict;
    if (! _executeXmlRpcCommand("getStatus", null, statusDict)) {
        WLOG << __PRETTY_FUNCTION__ << ": getStatus failed!";
        return(false);
    }
    status = DrxStatus(statusDict);
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
