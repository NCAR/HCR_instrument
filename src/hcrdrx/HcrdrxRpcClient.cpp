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

void
HcrdrxRpcClient::setHmcMode(int mode) {
    XmlRpc::XmlRpcValue args;
    XmlRpc::XmlRpcValue result;
    args[0] = XmlRpc::XmlRpcValue(mode);
    _executeXmlRpcCommand("setHmcMode", args, result);
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
    _detectedRfPower(-9999.9),
    _pvForePressure(-9999.9),
    _pvAftPressure(-9999.9),
    _ploTemp(-9999.9),
    _eikTemp(-9999.9),
    _vLnaTemp(-9999.9),
    _hLnaTemp(-9999.9),
    _polarizationSwitchTemp(-9999.9),
    _rfDetectorTemp(-9999.9),
    _noiseSourceTemp(-9999.9),
    _ps28VTemp(-9999.9),
    _rdsInDuctTemp(-9999.9),
    _rotationMotorTemp(-9999.9),
    _tiltMotorTemp(-9999.9),
    _cmigitsTemp(-9999.9),
    _tailconeTemp(-9999.9),
    _psVoltage(-9999.9),
    _pentekFpgaTemp(-9999.9),
    _pentekBoardTemp(-9999.9),
    _noiseSourceSelected(false),
    _terminationSelected(false),
    _locked15_5GHzPLO(false),
    _locked1250MHzPLO(false),
    _modPulseDisabled(false),
    _rdsXmitterFilamentOn(false),
    _rdsXmitterHvOn(false),
    _hmcStatus(-1)
{
}

HcrdrxRpcClient::Status::Status(XmlRpc::XmlRpcValue & statusDict) {
    // Unpack all of the status values from the XmlRpc::XmlRpcValue dictionary
    // into local member variables
    _detectedRfPower = _StatusDouble(statusDict, "detectedRfPower");
    _pvForePressure = _StatusDouble(statusDict, "pvForePressure");
    _pvAftPressure = _StatusDouble(statusDict, "pvAftPressure");
    _ploTemp = _StatusDouble(statusDict, "ploTemp");
    _eikTemp = _StatusDouble(statusDict, "eikTemp");
    _vLnaTemp = _StatusDouble(statusDict, "vLnaTemp");
    _hLnaTemp = _StatusDouble(statusDict, "hLnaTemp");
    _polarizationSwitchTemp = _StatusDouble(statusDict, "polarizationSwitchTemp");
    _rfDetectorTemp = _StatusDouble(statusDict, "rfDetectorTemp");
    _noiseSourceTemp = _StatusDouble(statusDict, "noiseSourceTemp");
    _ps28VTemp = _StatusDouble(statusDict, "ps28VTemp");
    _rdsInDuctTemp = _StatusDouble(statusDict, "rdsInDuctTemp");
    _rotationMotorTemp = _StatusDouble(statusDict, "rotationMotorTemp");
    _tiltMotorTemp = _StatusDouble(statusDict, "tiltMotorTemp");
    _cmigitsTemp = _StatusDouble(statusDict, "cmigitsTemp");
    _tailconeTemp = _StatusDouble(statusDict, "tailconeTemp");
    _psVoltage = _StatusDouble(statusDict, "psVoltage");
    _pentekFpgaTemp = _StatusDouble(statusDict, "pentekFpgaTemp");
    _pentekBoardTemp = _StatusDouble(statusDict, "pentekBoardTemp");

    _noiseSourceSelected = _StatusBool(statusDict, "noiseSourceSelected");
    _terminationSelected = _StatusBool(statusDict, "terminationSelected");
    _locked15_5GHzPLO = _StatusBool(statusDict, "locked15_5GHzPLO");
    _locked1250MHzPLO = _StatusBool(statusDict, "locked1250MHzPLO");
    _modPulseDisabled = _StatusBool(statusDict, "modPulseDisabled");
    _rdsXmitterFilamentOn = _StatusBool(statusDict, "rdsXmitterFilamentOn");
    _rdsXmitterHvOn = _StatusBool(statusDict, "rdsXmitterHvOn");

    _hmcStatus = _StatusInt(statusDict, "hmcStatus");
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
