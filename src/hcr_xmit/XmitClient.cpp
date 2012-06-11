/*
 * XmitClient.cpp
 *
 *  Created on: Mar 11, 2011
 *      Author: burghart
 */

#include "XmitClient.h"

#include <cstdlib>
#include <logx/Logging.h>

LOGGING("XmitClient")

XmitClient::XmitClient(std::string xmitdHost, int xmitdPort) :
    XmlRpc::XmlRpcClient(xmitdHost.c_str(), xmitdPort),
    _xmitdHost(xmitdHost),
    _xmitdPort(xmitdPort) {
}

XmitClient::~XmitClient() {
}

bool
XmitClient::_executeXmlRpcCommand(const std::string cmd, 
    const XmlRpc::XmlRpcValue & params, XmlRpc::XmlRpcValue & result) {
    DLOG << "Executing '" << cmd << "()' command";
    if (! execute(cmd.c_str(), params, result)) {
        DLOG << "Error executing " << cmd << "() call to ka_xmitd";
        return(false);
    }
    if (isFault()) {
        ELOG << "XML-RPC fault on " << cmd << "() call";
        abort();
    }
    return true;  
}

void
XmitClient::powerOn() {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue result;
    _executeXmlRpcCommand("powerOn", null, result);
}

void
XmitClient::powerOff() {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue result;
    _executeXmlRpcCommand("powerOff", null, result);
}

void
XmitClient::faultReset() {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue result;
    _executeXmlRpcCommand("faultReset", null, result);
}

void
XmitClient::standby() {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue result;
    _executeXmlRpcCommand("standby", null, result);
}

void
XmitClient::operate() {
    XmlRpc::XmlRpcValue null;
    XmlRpc::XmlRpcValue result;
    _executeXmlRpcCommand("operate", null, result);
}

bool
XmitClient::getStatus(XmitStatus & status) {
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
XmitClient::getLogMessages(unsigned int firstIndex, std::string & msgs, 
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
XmitClient::XmitStatus::XmitStatus() :
        _serialConnected(false),
        _filamentOn(false),
        _highVoltageOn(false),
        _rfOn(false),
        _modPulseExternal(false),
        _syncPulseExternal(false),
        _filamentDelayActive(false),
        _powerValid(false),
        _faultSummary(false),
        _frontPanelCtlEnabled(false),
        _rs232CtlEnabled(false),
        _rdsCtlEnabled(false),
        _modulatorFault(false),
        _syncFault(false),
        _xmitterTempFault(false),
        _wgArcFault(false),
        _collectorCurrFault(false),
        _bodyCurrFault(false),
        _filamentLorFault(false),
        _focusElectrodeLorFault(false),
        _cathodeLorFault(false),
        _inverterOverloadFault(false),
        _extInterlockFault(false),
        _eikInterlockFault(false),
        _modulatorFaultCount(-1),
        _syncFaultCount(-1),
        _xmitterTempFaultCount(-1),
        _wgArcFaultCount(-1),
        _collectorCurrFaultCount(-1),
        _bodyCurrFaultCount(-1),
        _filamentLorFaultCount(-1),
        _focusElectrodeLorFaultCount(-1),
        _cathodeLorFaultCount(-1),
        _inverterOverloadFaultCount(-1),
        _extInterlockFaultCount(-1),
        _eikInterlockFaultCount(-1),
        _modulatorFaultTime(-1),
        _syncFaultTime(-1),
        _xmitterTempFaultTime(-1),
        _wgArcFaultTime(-1),
        _collectorCurrFaultTime(-1),
        _bodyCurrFaultTime(-1),
        _filamentLorFaultTime(-1),
        _focusElectrodeLorFaultTime(-1),
        _cathodeLorFaultTime(-1),
        _inverterOverloadFaultTime(-1),
        _extInterlockFaultTime(-1),
        _eikInterlockFaultTime(-1),
        _cathodeVoltage(-9999.9),
        _bodyCurrent(-9999.9),
        _collectorCurrent(-9999.9),
        _xmitterTemp(-9999.9)
{
}

XmitClient::XmitStatus::XmitStatus(XmlRpc::XmlRpcValue & statusDict) {
    // Unpack all of the status values from the XmlRpc::XmlRpcValue dictionary
    // into local member variables
    _serialConnected = _StatusBool(statusDict, "serial_connected");
    _filamentOn = _StatusBool(statusDict, "filament_on");
    _highVoltageOn = _StatusBool(statusDict, "high_voltage_on");
    _rfOn = _StatusBool(statusDict, "rf_on");
    _modPulseExternal = _StatusBool(statusDict, "mod_pulse_external");
    _syncPulseExternal = _StatusBool(statusDict, "sync_pulse_external");
    _filamentDelayActive = _StatusBool(statusDict, "filament_delay_active");
    _powerValid = _StatusBool(statusDict, "power_valid");
    _faultSummary = _StatusBool(statusDict, "fault_summary");
    _frontPanelCtlEnabled = _StatusBool(statusDict, "front_panel_control_enabled");
    _rs232CtlEnabled = _StatusBool(statusDict, "rs232_control_enabled");
    _rdsCtlEnabled = _StatusBool(statusDict, "rds_control_enabled");
    
    _modulatorFault = _StatusBool(statusDict, "modulator_fault");
    _syncFault = _StatusBool(statusDict, "sync_fault");
    _xmitterTempFault = _StatusBool(statusDict, "xmitter_temp_fault");
    _wgArcFault = _StatusBool(statusDict, "waveguide_arc_fault");
    _collectorCurrFault = _StatusBool(statusDict, "collector_current_fault");
    _bodyCurrFault = _StatusBool(statusDict, "body_current_fault");
    _filamentLorFault = _StatusBool(statusDict, "filament_lor_fault");
    _focusElectrodeLorFault = _StatusBool(statusDict, "focus_electrode_lor_fault");
    _cathodeLorFault = _StatusBool(statusDict, "cathode_lor_fault");
    _inverterOverloadFault = _StatusBool(statusDict, "inverter_overload_fault");
    _extInterlockFault = _StatusBool(statusDict, "external_interlock_fault");
    _eikInterlockFault = _StatusBool(statusDict, "external_interlock_fault");
    
    _modulatorFaultCount = _StatusInt(statusDict, "modulator_fault_count");
    _syncFaultCount = _StatusInt(statusDict, "sync_fault_count");
    _xmitterTempFaultCount = _StatusInt(statusDict, "xmitter_temp_fault_count");
    _wgArcFaultCount = _StatusInt(statusDict, "waveguide_arc_fault_count");
    _collectorCurrFaultCount = _StatusInt(statusDict, "collector_current_fault_count");
    _bodyCurrFaultCount = _StatusInt(statusDict, "body_current_fault_count");
    _filamentLorFaultCount = _StatusInt(statusDict, "filament_lor_fault_count");
    _focusElectrodeLorFaultCount = _StatusInt(statusDict, "focus_electrode_lor_fault_count");
    _cathodeLorFaultCount = _StatusInt(statusDict, "cathode_lor_fault_count");
    _inverterOverloadFaultCount = _StatusInt(statusDict, "inverter_overload_fault_count");
    _extInterlockFaultCount = _StatusInt(statusDict, "external_interlock_fault_count");
    _eikInterlockFaultCount = _StatusInt(statusDict, "eik_interlock_fault_count");
    
    _modulatorFaultTime = _StatusInt(statusDict, "modulator_fault_time");
    _syncFaultTime = _StatusInt(statusDict, "sync_fault_time");
    _xmitterTempFaultTime = _StatusInt(statusDict, "xmitter_temp_fault_time");
    _wgArcFaultTime = _StatusInt(statusDict, "waveguide_arc_fault_time");
    _collectorCurrFaultTime = _StatusInt(statusDict, "collector_current_fault_time");
    _bodyCurrFaultTime = _StatusInt(statusDict, "body_current_fault_time");
    _filamentLorFaultTime = _StatusInt(statusDict, "filament_lor_fault_time");
    _focusElectrodeLorFaultTime = _StatusInt(statusDict, "focus_electrode_lor_fault_time");
    _cathodeLorFaultTime = _StatusInt(statusDict, "cathode_lor_fault_time");
    _inverterOverloadFaultTime = _StatusInt(statusDict, "inverter_overload_fault_time");
    _extInterlockFaultTime = _StatusInt(statusDict, "external_interlock_fault_time");
    _eikInterlockFaultTime = _StatusInt(statusDict, "eik_interlock_fault_time");
    
    _cathodeVoltage = _StatusDouble(statusDict, "cathode_voltage");
    _bodyCurrent = _StatusDouble(statusDict, "body_current");
    _collectorCurrent = _StatusDouble(statusDict, "collector_current");
    _xmitterTemp = _StatusDouble(statusDict, "xmitter_temp");
}

XmitClient::XmitStatus::~XmitStatus() {
}

bool
XmitClient::XmitStatus::_StatusBool(XmlRpc::XmlRpcValue statusDict, std::string key) {
    if (! statusDict.hasMember(key)) {
        ELOG << "Status dictionary does not contain requested key '" << key <<
            "'!";
        abort();
    } else {
        return(bool(statusDict[key]));
    }
}

int
XmitClient::XmitStatus::_StatusInt(XmlRpc::XmlRpcValue statusDict, std::string key) {
    if (! statusDict.hasMember(key)) {
        ELOG << "Status dictionary does not contain requested key '" << key <<
            "'!";
        abort();
    } else {
        return(int(statusDict[key]));
    }
}

double
XmitClient::XmitStatus::_StatusDouble(XmlRpc::XmlRpcValue statusDict, std::string key) {
    if (! statusDict.hasMember(key)) {
        ELOG << "Status dictionary does not contain requested key '" << key <<
            "'!";
        abort();
    } else {
        return(double(statusDict[key]));
    }
}
