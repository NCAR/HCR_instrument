/*
 * XmitStatus.cpp
 *
 *  Created on: Aug 31, 2012
 *      Author: burghart
 */

#include "XmitStatus.h"
#include <cstdlib>
#include <logx/Logging.h>
#include <toolsa/TaXml.hh>

LOGGING("XmitStatus")

int XmitStatus::_SummaryFaultCount = 0;
int XmitStatus::_ModulatorFaultCount = 0;
int XmitStatus::_SyncFaultCount = 0;
int XmitStatus::_XmitterTempFaultCount = 0;
int XmitStatus::_WaveguideArcFaultCount = 0;
int XmitStatus::_CollectorCurrentFaultCount = 0;
int XmitStatus::_BodyCurrentFaultCount = 0;
int XmitStatus::_FilamentLorFaultCount = 0;
int XmitStatus::_FocusElectrodeLorFaultCount = 0;
int XmitStatus::_CathodeLorFaultCount = 0;
int XmitStatus::_InverterOverloadFaultCount = 0;
int XmitStatus::_ExternalInterlockFaultCount = 0;
int XmitStatus::_EikInterlockFaultCount = 0;

time_t XmitStatus::_SummaryFaultTime = -1;
time_t XmitStatus::_ModulatorFaultTime = -1;
time_t XmitStatus::_SyncFaultTime = -1;
time_t XmitStatus::_XmitterTempFaultTime = -1;
time_t XmitStatus::_WaveguideArcFaultTime = -1;
time_t XmitStatus::_CollectorCurrentFaultTime = -1;
time_t XmitStatus::_BodyCurrentFaultTime = -1;
time_t XmitStatus::_FilamentLorFaultTime = -1;
time_t XmitStatus::_FocusElectrodeLorFaultTime = -1;
time_t XmitStatus::_CathodeLorFaultTime = -1;
time_t XmitStatus::_InverterOverloadFaultTime = -1;
time_t XmitStatus::_ExternalInterlockFaultTime = -1;
time_t XmitStatus::_EikInterlockFaultTime = -1;

XmitStatus XmitStatus::_PrevStatus;

XmitStatus::XmitStatus() {
    _serialConnected = false;
    _badChecksumReceived = false;
    
    _filamentOn = false;
    _highVoltageOn = false;
    _rfOn = false;
    _modPulseExternal = false;
    _syncPulseExternal = false;
    _filamentDelayActive = false;
    _psmPowerOn = false;
    _summaryFault = false;
    _controlSource = UnknownControl;
    _modulatorFault = false;
    _syncFault = false;
    _xmitterTempFault = false;
    _waveguideArcFault = false;
    _collectorCurrentFault = false;
    _bodyCurrentFault = false;
    _filamentLorFault = false;
    _focusElectrodeLorFault = false;
    _cathodeLorFault = false;
    _inverterOverloadFault = false;
    _externalInterlockFault = false;
    _eikInterlockFault = false;

    _cathodeVoltage = -99.9;
    _bodyCurrent = -99.9;
    _collectorCurrent = -99.9;
    _xmitterTemp = -99.9;

    _pulsewidthSelector = 0;
    _prfSelector = 0;
}

XmitStatus::XmitStatus(const uint8_t xmitterPkt[20]) throw(ConstructError) {
    // Since we have transmitter packet, the serial line must be connected
    _serialConnected = true;

    // Byte 17 of the status packet is non-zero if the transmitter received a
    // bad communication. When this is the case, the rest of the returned status
    // can't be trusted.
    _badChecksumReceived = xmitterPkt[17];
    if (_badChecksumReceived) {
        throw ConstructError("Transmitter packet reports 'Bad communication'. "
                "No good status in packet.");
    }

    // 8 bits of boolean status in byte 3
    _filamentOn =             xmitterPkt[3] & _FILAMENT_ON_BIT;
    _highVoltageOn =          xmitterPkt[3] & _HV_ON_BIT;
    _rfOn =                   xmitterPkt[3] & _RF_ON_BIT;
    _modPulseExternal =       xmitterPkt[3] & _EXT_MOD_PULSE_BIT;
    _syncPulseExternal =      xmitterPkt[3] & _EXT_SYNC_PULSE_BIT;
    _filamentDelayActive =    xmitterPkt[3] & _FILAMENT_DELAY_BIT;
    _psmPowerOn =             xmitterPkt[3] & _POWER_VALID_BIT;
    _summaryFault =           xmitterPkt[3] & _SUMMARY_FAULT_BIT;

    DLOG << "filament on " << _filamentOn <<
            ", HV on " << _highVoltageOn <<
            ", RF on " << _rfOn <<
            ", external mod pulse " << _modPulseExternal <<
            ", external sync pulse " << _syncPulseExternal <<
            ", filament delay active " << _filamentDelayActive <<
            ", power valid " << _psmPowerOn <<
            ", fault summary " << _summaryFault;

    // Byte 4: Is control currently via front panel, RS-232, or RDS?
    uint8_t controlSource = xmitterPkt[4] & AllControlSources;
    switch (controlSource) {
    case FrontPanelControl:
        _controlSource = FrontPanelControl;
        break;
    case RS232Control:
        _controlSource = RS232Control;
        break;
    case RDSControl:
        _controlSource = RDSControl;
        break;
    default:
        ELOG << "Uh-oh, bad transmitter control source byte with value 0x" <<
            std::hex << uint16_t(xmitterPkt[4]) << std::dec;
        _controlSource = UnknownControl;
        break;
    }

    // 8 fault bits from byte 5
    _modulatorFault =         xmitterPkt[5] & _MODULATOR_FAULT_BIT;
    _syncFault =              xmitterPkt[5] & _SYNC_FAULT_BIT;
    _xmitterTempFault =       xmitterPkt[5] & _XMITTER_TEMP_FAULT_BIT;
    _waveguideArcFault =      xmitterPkt[5] & _WG_ARC_FAULT_BIT;
    _collectorCurrentFault =  xmitterPkt[5] & _COLLECTOR_CURRENT_FAULT_BIT;
    _bodyCurrentFault =       xmitterPkt[5] & _BODY_CURRENT_FAULT_BIT;
    _filamentLorFault =       xmitterPkt[5] & _FILAMENT_LOR_FAULT_BIT;
    _focusElectrodeLorFault = xmitterPkt[5] & _FOCUS_ELECTRODE_LOR_FAULT_BIT;

    // 4 fault bits from byte 6 (other 4 bits are unused)
    _cathodeLorFault =        xmitterPkt[6] & _CATHODE_LOR_FAULT_BIT;
    _inverterOverloadFault =  xmitterPkt[6] & _INVERTER_OVERLOAD_FAULT_BIT;
    _externalInterlockFault = xmitterPkt[6] & _EXT_INTERLOCK_FAULT_BIT;
    _eikInterlockFault =      xmitterPkt[6] & _EIK_INTERLOCK_FAULT_BIT;

    // Decode meter values. These values are only good if PSM power is on.
    //
    // The values are each divided into one unsigned byte of "whole" units,
    // and one unsigned byte of "fractional" units. The fractional part
    // represents tenths of a unit, but in the range from 0-10 rather than
    // 0-9. I.e., 21.0 degrees is recorded as 20 (whole) + 10 (fractional).
    // At least 0.0 shows up more rationally as 0 (whole) + 0 (fractional).
    //
    // Also, the fractional part is occasionally outside the range 0-10. Who
    // knows what that means. We note that as an error and move on. Annoying...
    _cathodeVoltage = -99.9;
    _bodyCurrent = -99.9;
    _collectorCurrent = -99.9;
    _xmitterTemp = -99.9;

    if (_psmPowerOn) {
    	// Bytes 7 and 8 contain whole and fractional cathode voltage
    	if (xmitterPkt[8] >= 0 && xmitterPkt[8] <= 10) {
        	_cathodeVoltage = xmitterPkt[7] + 0.1 * xmitterPkt[8];
    	} else {
    		ELOG << "Bad cathode voltage bytes: " << uint16_t(xmitterPkt[7]) <<
    				" (whole), " << uint16_t(xmitterPkt[8]) << " (fractional).";
    	}
    	DLOG << "Cathode voltage: " << _cathodeVoltage;

    	// Bytes 9 and 10 contain whole and fractional body current
    	if (xmitterPkt[10] >= 0 && xmitterPkt[10] <= 10) {
        	_bodyCurrent = xmitterPkt[9] + 0.1 * xmitterPkt[10];
    	} else {
    		ELOG << "Bad body current bytes: " << uint16_t(xmitterPkt[9]) <<
    				" (whole), " << uint16_t(xmitterPkt[10]) << " (fractional).";
    	}
    	DLOG << "Body current: " << _bodyCurrent;

    	// Bytes 11 and 12 contain whole and fractional collector current
    	if (xmitterPkt[12] >= 0 && xmitterPkt[12] <= 10) {
        	_collectorCurrent = xmitterPkt[11] + 0.1 * xmitterPkt[12];
    	} else {
    		ELOG << "Bad collector current bytes: " << uint16_t(xmitterPkt[11]) <<
    				" (whole), " << uint16_t(xmitterPkt[12]) << " (fractional).";
    	}
    	DLOG << "Collector current: " << _collectorCurrent;

    	// Bytes 13 and 14 contain whole and fractional transmitter temperature
    	if (xmitterPkt[14] >= 0 && xmitterPkt[14] <= 10) {
        	_xmitterTemp = xmitterPkt[13] + 0.1 * xmitterPkt[14];
    	} else {
    		ELOG << "Bad transmitter temp bytes: " << uint16_t(xmitterPkt[13]) <<
    				" (whole), " << uint16_t(xmitterPkt[14]) << " (fractional).";
    	}
    	DLOG << "Temp: " << _xmitterTemp;
    }

    // Byte 15 contains panel pulsewidth selector setting (0-15)
    _pulsewidthSelector = xmitterPkt[15];

    // Byte 16 contains panel PRF selector setting (0-15)
    _prfSelector = xmitterPkt[16];

    // Update fault counts and times
    time_t now = time(0);

    if (_summaryFault && ! _PrevStatus._summaryFault) {
        _SummaryFaultCount++;
        _SummaryFaultTime = now;
    }
    if (_modulatorFault && ! _PrevStatus._modulatorFault) {
        _ModulatorFaultCount++;
        _ModulatorFaultTime = now;
    }
    if (_syncFault && ! _PrevStatus._syncFault) {
        _SyncFaultCount++;
        _SyncFaultTime = now;
    }
    if (_xmitterTempFault && ! _PrevStatus._xmitterTempFault) {
        _XmitterTempFaultCount++;
        _XmitterTempFaultTime = now;
    }
    if (_waveguideArcFault && ! _PrevStatus._waveguideArcFault) {
        _WaveguideArcFaultCount++;
        _WaveguideArcFaultTime = now;
    }
    if (_collectorCurrentFault && ! _PrevStatus._collectorCurrentFault) {
        _CollectorCurrentFaultCount++;
        _CollectorCurrentFaultTime = now;
    }
    if (_bodyCurrentFault && ! _PrevStatus._bodyCurrentFault) {
        _BodyCurrentFaultCount++;
        _BodyCurrentFaultTime = now;
    }
    if (_filamentLorFault && ! _PrevStatus._filamentLorFault) {
        _FilamentLorFaultCount++;
        _FilamentLorFaultTime = now;
    }
    if (_focusElectrodeLorFault && ! _PrevStatus._focusElectrodeLorFault) {
        _FocusElectrodeLorFaultCount++;
        _FocusElectrodeLorFaultTime = now;
    }
    if (_cathodeLorFault && ! _PrevStatus._cathodeLorFault) {
        _CathodeLorFaultCount++;
        _CathodeLorFaultTime = now;
    }
    if (_inverterOverloadFault && ! _PrevStatus._inverterOverloadFault) {
        _InverterOverloadFaultCount++;
        _InverterOverloadFaultTime = now;
    }
    if (_externalInterlockFault && ! _PrevStatus._externalInterlockFault) {
        _ExternalInterlockFaultCount++;
        _ExternalInterlockFaultTime = now;
    }
    if (_eikInterlockFault && ! _PrevStatus._eikInterlockFault) {
        _EikInterlockFaultCount++;
        _EikInterlockFaultTime = now;
    }

    // And now we become the previous status...
    _PrevStatus = *this;
}

XmitStatus::XmitStatus(XmlRpcValue & statusDict) throw(ConstructError) {
    // Unpack the XmlRpcValue dictionary into our members
    _serialConnected = _StatusBool(statusDict, "serialConnected");
    _badChecksumReceived = _StatusBool(statusDict, "badChecksumReceived");
    _filamentOn = _StatusBool(statusDict, "filamentOn");
    _highVoltageOn = _StatusBool(statusDict, "highVoltageOn");
    _rfOn = _StatusBool(statusDict, "rfOn");
    _modPulseExternal = _StatusBool(statusDict, "modPulseExternal");
    _syncPulseExternal = _StatusBool(statusDict, "syncPulseExternal");
    _filamentDelayActive = _StatusBool(statusDict, "filamentDelayActive");
    _psmPowerOn = _StatusBool(statusDict, "psmPowerOn");
    _controlSource = static_cast<ControlSource>(_StatusInt(statusDict, "controlSource"));
    _summaryFault = _StatusBool(statusDict, "summaryFault");
    _SummaryFaultCount = _StatusInt(statusDict, "summaryFaultCount");
    _SummaryFaultTime = _StatusInt(statusDict, "summaryFaultTime");
    _modulatorFault = _StatusBool(statusDict, "modulatorFault");
    _ModulatorFaultCount = _StatusInt(statusDict, "modulatorFaultCount");
    _ModulatorFaultTime = _StatusInt(statusDict, "modulatorFaultTime");
    _syncFault = _StatusBool(statusDict, "syncFault");
    _SyncFaultCount = _StatusInt(statusDict, "syncFaultCount");
    _SyncFaultTime = _StatusInt(statusDict, "syncFaultTime");
    _xmitterTempFault = _StatusBool(statusDict, "xmitterTempFault");
    _XmitterTempFaultCount = _StatusInt(statusDict, "xmitterTempFaultCount");
    _XmitterTempFaultTime = _StatusInt(statusDict, "xmitterTempFaultTime");
    _waveguideArcFault = _StatusBool(statusDict, "waveguideArcFault");
    _WaveguideArcFaultCount = _StatusInt(statusDict, "waveguideArcFaultCount");
    _WaveguideArcFaultTime = _StatusInt(statusDict, "waveguideArcFaultTime");
    _collectorCurrentFault = _StatusBool(statusDict, "collectorCurrentFault");
    _CollectorCurrentFaultCount = _StatusInt(statusDict, "collectorCurrentFaultCount");
    _CollectorCurrentFaultTime = _StatusInt(statusDict, "collectorCurrentFaultTime");
    _bodyCurrentFault = _StatusBool(statusDict, "bodyCurrentFault");
    _BodyCurrentFaultCount = _StatusInt(statusDict, "bodyCurrentFaultCount");
    _BodyCurrentFaultTime = _StatusInt(statusDict, "bodyCurrentFaultTime");
    _filamentLorFault = _StatusBool(statusDict, "filamentLorFault");
    _FilamentLorFaultCount = _StatusInt(statusDict, "filamentLorFaultCount");
    _FilamentLorFaultTime = _StatusInt(statusDict, "filamentLorFaultTime");
    _focusElectrodeLorFault = _StatusBool(statusDict, "focusElectrodeLorFault");
    _FocusElectrodeLorFaultCount = _StatusInt(statusDict, "focusElectrodeLorFaultCount");
    _FocusElectrodeLorFaultTime = _StatusInt(statusDict, "focusElectrodeLorFaultTime");
    _cathodeLorFault = _StatusBool(statusDict, "cathodeLorFault");
    _CathodeLorFaultCount = _StatusInt(statusDict, "cathodeLorFaultCount");
    _CathodeLorFaultTime = _StatusInt(statusDict, "cathodeLorFaultTime");
    _inverterOverloadFault = _StatusBool(statusDict, "inverterOverloadFault");
    _InverterOverloadFaultCount = _StatusInt(statusDict, "inverterOverloadFaultCount");
    _InverterOverloadFaultTime = _StatusInt(statusDict, "inverterOverloadFaultTime");
    _externalInterlockFault = _StatusBool(statusDict, "externalInterlockFault");
    _ExternalInterlockFaultCount = _StatusInt(statusDict, "externalInterlockFaultCount");
    _ExternalInterlockFaultTime = _StatusInt(statusDict, "externalInterlockFaultTime");
    _eikInterlockFault = _StatusBool(statusDict, "eikInterlockFault");
    _EikInterlockFaultCount = _StatusInt(statusDict, "eikInterlockFaultCount");
    _EikInterlockFaultTime = _StatusInt(statusDict, "eikInterlockFaultTime");

    _cathodeVoltage = _StatusDouble(statusDict, "cathodeVoltage");
    _bodyCurrent = _StatusDouble(statusDict, "bodyCurrent");
    _collectorCurrent = _StatusDouble(statusDict, "collectorCurrent");
    _xmitterTemp = _StatusDouble(statusDict, "xmitterTemp");
}

XmitStatus::~XmitStatus() {
}

XmitStatus
XmitStatus::simulatedStatus(bool filamentOn, bool highVoltageOn) {
    XmitStatus simStatus;
    simStatus._serialConnected = true;
    simStatus._psmPowerOn = true;
    simStatus._filamentOn = filamentOn;
    simStatus._highVoltageOn = highVoltageOn;
    simStatus._cathodeVoltage = 14.9 + (0.2 * random()) / RAND_MAX;
    simStatus._collectorCurrent = 390. + (20.0 * random()) / RAND_MAX;
    simStatus._bodyCurrent = 49.0 + (2.0 * random()) / RAND_MAX;
    simStatus._xmitterTemp = 39.5 + (1.0 * random()) / RAND_MAX;
    return simStatus;
}

XmlRpcValue
XmitStatus::toXmlRpcValue() const {
    XmlRpcValue statusDict;

    // Save state into our XML-RPC statusDict
    statusDict["serialConnected"] = XmlRpcValue(_serialConnected);
    statusDict["badChecksumReceived"] = XmlRpcValue(_badChecksumReceived);
    statusDict["filamentOn"] = XmlRpcValue(_filamentOn);
    statusDict["highVoltageOn"] = XmlRpcValue(_highVoltageOn);
    statusDict["rfOn"] = XmlRpcValue(_rfOn);
    statusDict["modPulseExternal"] = XmlRpcValue(_modPulseExternal);
    statusDict["syncPulseExternal"] = XmlRpcValue(_syncPulseExternal);
    statusDict["filamentDelayActive"] = XmlRpcValue(_filamentDelayActive);
    statusDict["psmPowerOn"] = XmlRpcValue(_psmPowerOn);
    statusDict["controlSource"] = XmlRpcValue(_controlSource);
    statusDict["summaryFault"] = XmlRpcValue(_summaryFault);
    statusDict["summaryFaultCount"] = XmlRpcValue(_SummaryFaultCount);
    statusDict["summaryFaultTime"] = XmlRpcValue(int(_SummaryFaultTime));
    statusDict["modulatorFault"] = XmlRpcValue(_modulatorFault);
    statusDict["modulatorFaultCount"] = XmlRpcValue(_ModulatorFaultCount);
    statusDict["modulatorFaultTime"] = XmlRpcValue(int(_ModulatorFaultTime));
    statusDict["syncFault"] = XmlRpcValue(_syncFault);
    statusDict["syncFaultCount"] = XmlRpcValue(_SyncFaultCount);
    statusDict["syncFaultTime"] = XmlRpcValue(int(_SyncFaultTime));
    statusDict["xmitterTempFault"] = XmlRpcValue(_xmitterTempFault);
    statusDict["xmitterTempFaultCount"] = XmlRpcValue(_XmitterTempFaultCount);
    statusDict["xmitterTempFaultTime"] = XmlRpcValue(int(_XmitterTempFaultTime));
    statusDict["waveguideArcFault"] = XmlRpcValue(_waveguideArcFault);
    statusDict["waveguideArcFaultCount"] = XmlRpcValue(_WaveguideArcFaultCount);
    statusDict["waveguideArcFaultTime"] = XmlRpcValue(int(_WaveguideArcFaultTime));
    statusDict["collectorCurrentFault"] = XmlRpcValue(_collectorCurrentFault);
    statusDict["collectorCurrentFaultCount"] = XmlRpcValue(_CollectorCurrentFaultCount);
    statusDict["collectorCurrentFaultTime"] = XmlRpcValue(int(_CollectorCurrentFaultTime));
    statusDict["bodyCurrentFault"] = XmlRpcValue(_bodyCurrentFault);
    statusDict["bodyCurrentFaultCount"] = XmlRpcValue(_BodyCurrentFaultCount);
    statusDict["bodyCurrentFaultTime"] = XmlRpcValue(int(_BodyCurrentFaultTime));
    statusDict["filamentLorFault"] = XmlRpcValue(_filamentLorFault);
    statusDict["filamentLorFaultCount"] = XmlRpcValue(_FilamentLorFaultCount);
    statusDict["filamentLorFaultTime"] = XmlRpcValue(int(_FilamentLorFaultTime));
    statusDict["focusElectrodeLorFault"] = XmlRpcValue(_focusElectrodeLorFault);
    statusDict["focusElectrodeLorFaultCount"] = XmlRpcValue(_FocusElectrodeLorFaultCount);
    statusDict["focusElectrodeLorFaultTime"] = XmlRpcValue(int(_FocusElectrodeLorFaultTime));
    statusDict["cathodeLorFault"] = XmlRpcValue(_cathodeLorFault);
    statusDict["cathodeLorFaultCount"] = XmlRpcValue(_CathodeLorFaultCount);
    statusDict["cathodeLorFaultTime"] = XmlRpcValue(int(_CathodeLorFaultTime));
    statusDict["inverterOverloadFault"] = XmlRpcValue(_inverterOverloadFault);
    statusDict["inverterOverloadFaultCount"] = XmlRpcValue(_InverterOverloadFaultCount);
    statusDict["inverterOverloadFaultTime"] = XmlRpcValue(int(_InverterOverloadFaultTime));
    statusDict["externalInterlockFault"] = XmlRpcValue(_externalInterlockFault);
    statusDict["externalInterlockFaultCount"] = XmlRpcValue(_ExternalInterlockFaultCount);
    statusDict["externalInterlockFaultTime"] = XmlRpcValue(int(_ExternalInterlockFaultTime));
    statusDict["eikInterlockFault"] = XmlRpcValue(_eikInterlockFault);
    statusDict["eikInterlockFaultCount"] = XmlRpcValue(_EikInterlockFaultCount);
    statusDict["eikInterlockFaultTime"] = XmlRpcValue(int(_EikInterlockFaultTime));

    statusDict["cathodeVoltage"] = XmlRpcValue(_cathodeVoltage);
    statusDict["bodyCurrent"] = XmlRpcValue(_bodyCurrent);
    statusDict["collectorCurrent"] = XmlRpcValue(_collectorCurrent);
    statusDict["xmitterTemp"] = XmlRpcValue(_xmitterTemp);

    return(statusDict);
}

std::string
XmitStatus::toTaXmlString(int depth) const {
    std::string xml;

    // booleans
    xml += TaXml::writeBoolean
            ("SerialConnected", depth, _serialConnected);
    xml += TaXml::writeBoolean
            ("BadChecksumReceived", depth, _badChecksumReceived);
    xml += TaXml::writeBoolean
            ("FilamentOn", depth, _filamentOn);
    xml += TaXml::writeBoolean
            ("HighVoltageOn", depth, _highVoltageOn);
    xml += TaXml::writeBoolean
            ("RfOn", depth, _rfOn);
    xml += TaXml::writeBoolean
            ("ModPulseExternal", depth, _modPulseExternal);
    xml += TaXml::writeBoolean
            ("SyncPulseExternal", depth, _syncPulseExternal);
    xml += TaXml::writeBoolean
            ("FilamentDelayActive", depth, _filamentDelayActive);
    xml += TaXml::writeBoolean
            ("PsmPowerOn", depth, _psmPowerOn);
    xml += TaXml::writeBoolean
            ("FrontPanelCtlEnabled", depth, (_controlSource == FrontPanelControl));
    xml += TaXml::writeBoolean
            ("Rs232CtlEnabled", depth, (_controlSource == RS232Control));
    xml += TaXml::writeBoolean
            ("RdsCtlEnabled", depth, (_controlSource == RDSControl));
    xml += TaXml::writeBoolean
            ("SummaryFault", depth, _summaryFault);
    xml += TaXml::writeBoolean
            ("ModulatorFault", depth, _modulatorFault);
    xml += TaXml::writeBoolean
            ("SyncFault", depth, _syncFault);
    xml += TaXml::writeBoolean
            ("XmitterTempFault", depth, _xmitterTempFault);
    xml += TaXml::writeBoolean
            ("WaveguideArcFault", depth, _waveguideArcFault);
    xml += TaXml::writeBoolean
            ("CollectorCurrentFault", depth, _collectorCurrentFault);
    xml += TaXml::writeBoolean
            ("BodyCurrentFault", depth, _bodyCurrentFault);

    xml += TaXml::writeBoolean
            ("FilamentLorFault", depth, _filamentLorFault);
    xml += TaXml::writeBoolean
            ("FocusElectrodeLorFault", depth, _focusElectrodeLorFault);
    xml += TaXml::writeBoolean
            ("CathodeLorFault", depth, _cathodeLorFault);
    xml += TaXml::writeBoolean
            ("InverterOverloadFault", depth, _inverterOverloadFault);
    xml += TaXml::writeBoolean
            ("ExternalInterlockFault", depth, _externalInterlockFault);
    xml += TaXml::writeBoolean
            ("EikInterlockFault", depth, _eikInterlockFault);

    // doubles
    xml += TaXml::writeDouble
            ("CathodeVoltage", depth, _cathodeVoltage);
    xml += TaXml::writeDouble
            ("BodyCurrent", depth, _bodyCurrent);
    xml += TaXml::writeDouble
            ("CollectorCurrent", depth, _collectorCurrent);
    xml += TaXml::writeDouble
            ("XmitterTemp", depth, _xmitterTemp);

    // ints
    xml += TaXml::writeInt
            ("SummaryFaultCount", depth, _SummaryFaultCount);
    xml += TaXml::writeInt
            ("ModulatorFaultCount", depth, _ModulatorFaultCount);
    xml += TaXml::writeInt
            ("SyncFaultCount", depth, _SyncFaultCount);
    xml += TaXml::writeInt
            ("XmitterTempFaultCount", depth, _XmitterTempFaultCount);
    xml += TaXml::writeInt
            ("WaveguideArcFaultCount", depth, _WaveguideArcFaultCount);
    xml += TaXml::writeInt
            ("CollectorCurrentFaultCount", depth, _CollectorCurrentFaultCount);
    xml += TaXml::writeInt
            ("BodyCurrentFaultCount", depth, _BodyCurrentFaultCount);
    xml += TaXml::writeInt
            ("FilamentLorFaultCount", depth, _FilamentLorFaultCount);
    xml += TaXml::writeInt
            ("FocusElectrodeLorFaultCount", depth, _FocusElectrodeLorFaultCount);
    xml += TaXml::writeInt
            ("CathodeLorFaultCount", depth, _CathodeLorFaultCount);
    xml += TaXml::writeInt
            ("InverterOverloadFaultCount", depth, _InverterOverloadFaultCount);
    xml += TaXml::writeInt
            ("ExternalInterlockFaultCount", depth, _ExternalInterlockFaultCount);
    xml += TaXml::writeInt
            ("EikInterlockFaultCount", depth, _EikInterlockFaultCount);

    // times
    xml += TaXml::writeTime
            ("SummaryFaultTime", depth, _SummaryFaultTime);
    xml += TaXml::writeTime
            ("ModulatorFaultTime", depth, _ModulatorFaultTime);
    xml += TaXml::writeTime
            ("SyncFaultTime", depth, _SyncFaultTime);
    xml += TaXml::writeTime
            ("XmitterTempFaultTime", depth, _XmitterTempFaultTime);
    xml += TaXml::writeTime
            ("WaveguideArcFaultTime", depth, _WaveguideArcFaultTime);
    xml += TaXml::writeTime
            ("CollectorCurrentFaultTime", depth, _CollectorCurrentFaultTime);
    xml += TaXml::writeTime
            ("BodyCurrentFaultTime", depth, _BodyCurrentFaultTime);
    xml += TaXml::writeTime
            ("FilamentLorFaultTime", depth, _FilamentLorFaultTime);
    xml += TaXml::writeTime
            ("FocusElectrodeLorFaultTime", depth, _FocusElectrodeLorFaultTime);
    xml += TaXml::writeTime
            ("CathodeLorFaultTime", depth, _CathodeLorFaultTime);
    xml += TaXml::writeTime
            ("InverterOverloadFaultTime", depth, _InverterOverloadFaultTime);
    xml += TaXml::writeTime
            ("ExternalInterlockFaultTime", depth, _ExternalInterlockFaultTime);
    xml += TaXml::writeTime
            ("EikInterlockFaultTime", depth, _EikInterlockFaultTime);


    return xml;
}

bool
XmitStatus::_StatusBool(XmlRpc::XmlRpcValue & statusDict,
        std::string key) throw(ConstructError) {
    if (! statusDict.hasMember(key)) {
        std::ostringstream ss;
        ss << "XML-RPC status dictionary does not contain key '" << key << "'";
        throw(ConstructError(ss.str()));
    } else {
        return(bool(statusDict[key]));
    }
}

int
XmitStatus::_StatusInt(XmlRpc::XmlRpcValue & statusDict,
        std::string key) throw(ConstructError) {
    if (! statusDict.hasMember(key)) {
        std::ostringstream ss;
        ss << "XML-RPC status dictionary does not contain key '" << key << "'";
        throw(ConstructError(ss.str()));
    } else {
        return(int(statusDict[key]));
    }
}

double
XmitStatus::_StatusDouble(XmlRpc::XmlRpcValue & statusDict,
        std::string key) throw(ConstructError) {
    if (! statusDict.hasMember(key)) {
        std::ostringstream ss;
        ss << "XML-RPC status dictionary does not contain key '" << key << "'";
        throw(ConstructError(ss.str()));
    } else {
        return(double(statusDict[key]));
    }
}
