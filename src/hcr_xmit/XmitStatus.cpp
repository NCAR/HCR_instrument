// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2016                                         
// ** University Corporation for Atmospheric Research (UCAR)                 
// ** National Center for Atmospheric Research (NCAR)                        
// ** Boulder, Colorado, USA                                                 
// ** BSD licence applies - redistribution and use in source and binary      
// ** forms, with or without modification, are permitted provided that       
// ** the following conditions are met:                                      
// ** 1) If the software is modified to produce derivative works,            
// ** such modified software should be clearly marked, so as not             
// ** to confuse it with the version available from UCAR.                    
// ** 2) Redistributions of source code must retain the above copyright      
// ** notice, this list of conditions and the following disclaimer.          
// ** 3) Redistributions in binary form must reproduce the above copyright   
// ** notice, this list of conditions and the following disclaimer in the    
// ** documentation and/or other materials provided with the distribution.   
// ** 4) Neither the name of UCAR nor the names of its contributors,         
// ** if any, may be used to endorse or promote products derived from        
// ** this software without specific prior written permission.               
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS  
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED      
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.    
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
/*
 * XmitStatus.cpp
 *
 *  Created on: Aug 31, 2012
 *      Author: burghart
 */

#include "XmitStatus.h"
#include <cstdlib>
#include <Archive_xmlrpc_c.h>
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

XmitStatus::XmitStatus(const uint8_t xmitterPkt[20]) {
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
    	if (xmitterPkt[8] <= 10) {
        	_cathodeVoltage = xmitterPkt[7] + 0.1 * xmitterPkt[8];
    	} else {
    		ELOG << "Bad cathode voltage bytes: " << uint16_t(xmitterPkt[7]) <<
    				" (whole), " << uint16_t(xmitterPkt[8]) << " (fractional).";
    	}
    	DLOG << "Cathode voltage: " << _cathodeVoltage;

    	// Bytes 9 and 10 contain whole and fractional body current
    	if (xmitterPkt[10] <= 10) {
        	_bodyCurrent = xmitterPkt[9] + 0.1 * xmitterPkt[10];
    	} else {
    		ELOG << "Bad body current bytes: " << uint16_t(xmitterPkt[9]) <<
    				" (whole), " << uint16_t(xmitterPkt[10]) << " (fractional).";
    	}
    	DLOG << "Body current: " << _bodyCurrent;

    	// Bytes 11 and 12 contain whole and fractional collector current
    	if (xmitterPkt[12] <= 10) {
        	_collectorCurrent = xmitterPkt[11] + 0.1 * xmitterPkt[12];
    	} else {
    		ELOG << "Bad collector current bytes: " << uint16_t(xmitterPkt[11]) <<
    				" (whole), " << uint16_t(xmitterPkt[12]) << " (fractional).";
    	}
    	DLOG << "Collector current: " << _collectorCurrent;

    	// Bytes 13 and 14 contain whole and fractional transmitter temperature
    	if (xmitterPkt[14] <= 10) {
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
    if (_summaryFault != _PrevStatus._summaryFault) {
        if (_summaryFault) {
            WLOG << "summary fault detected";
            _SummaryFaultCount++;
            _SummaryFaultTime = now;
        } else {
            ILOG << "summary fault has cleared";
        }
    }
    if (_modulatorFault != _PrevStatus._modulatorFault) {
        if (_modulatorFault) {
            WLOG << "modulator fault detected";
            _ModulatorFaultCount++;
            _ModulatorFaultTime = now;
        } else {
            ILOG << "modulator fault has cleared";
        }
    }
    if (_syncFault != _PrevStatus._syncFault) {
        if (_syncFault) {
            WLOG << "sync fault detected";
            _SyncFaultCount++;
            _SyncFaultTime = now;
        } else {
            ILOG << "sync fault has cleared";
        }
    }
    if (_xmitterTempFault != _PrevStatus._xmitterTempFault) {
        if (_xmitterTempFault) {
            WLOG << "transmitter temperature fault detected";
            _XmitterTempFaultCount++;
            _XmitterTempFaultTime = now;
        } else {
            ILOG << "xmitterTemp fault has cleared";
        }
    }
    if (_waveguideArcFault != _PrevStatus._waveguideArcFault) {
        if (_waveguideArcFault) {
            WLOG << "waveguide arc fault detected";
            _WaveguideArcFaultCount++;
            _WaveguideArcFaultTime = now;
        } else {
            ILOG << "waveguideArc fault has cleared";
        }
    }
    if (_collectorCurrentFault != _PrevStatus._collectorCurrentFault) {
        if (_collectorCurrentFault) {
            WLOG << "collector current fault detected";
            _CollectorCurrentFaultCount++;
            _CollectorCurrentFaultTime = now;
        } else {
            ILOG << "collectorCurrent fault has cleared";
        }
    }
    if (_bodyCurrentFault != _PrevStatus._bodyCurrentFault) {
        if (_bodyCurrentFault) {
            WLOG << "body current fault detected";
            _BodyCurrentFaultCount++;
            _BodyCurrentFaultTime = now;
        } else {
            ILOG << "bodyCurrent fault has cleared";
        }
    }
    if (_filamentLorFault != _PrevStatus._filamentLorFault) {
        if (_filamentLorFault) {
            WLOG << "filament LOR fault detected";
            _FilamentLorFaultCount++;
            _FilamentLorFaultTime = now;
        } else {
            ILOG << "filamentLor fault has cleared";
        }
    }
    if (_focusElectrodeLorFault != _PrevStatus._focusElectrodeLorFault) {
        if (_focusElectrodeLorFault) {
            WLOG << "focus electrode LOR fault detected";
            _FocusElectrodeLorFaultCount++;
            _FocusElectrodeLorFaultTime = now;
        } else {
            ILOG << "focusElectrodeLor fault has cleared";
        }
    }
    if (_cathodeLorFault != _PrevStatus._cathodeLorFault) {
        if (_cathodeLorFault) {
            WLOG << "cathode LOR fault detected";
            _CathodeLorFaultCount++;
            _CathodeLorFaultTime = now;
        } else {
            ILOG << "cathode LOR fault has cleared";
        }
    }
    if (_inverterOverloadFault != _PrevStatus._inverterOverloadFault) {
        if (_inverterOverloadFault) {
            WLOG << "inverter overload fault detected";
            _InverterOverloadFaultCount++;
            _InverterOverloadFaultTime = now;
        } else {
            ILOG << "inverter overload fault has cleared";
        }
    }
    if (_externalInterlockFault != _PrevStatus._externalInterlockFault) {
        if (_externalInterlockFault) {
            WLOG << "external interlock is engaged";
            _ExternalInterlockFaultCount++;
            _ExternalInterlockFaultTime = now;
        } else {
            ILOG << "external interlock is disengaged";
        }
    }
    if (_eikInterlockFault != _PrevStatus._eikInterlockFault) {
        if (_eikInterlockFault) {
            WLOG << "EIK interlock fault detected";
            _EikInterlockFaultCount++;
            _EikInterlockFaultTime = now;
        } else {
            ILOG << "EIK interlock fault has cleared";
        }
    }

    // And now we become the previous status...
    _PrevStatus = *this;
}

XmitStatus::XmitStatus(xmlrpc_c::value_struct & statusDict) {
    // Create an input archiver wrapper around the xmlrpc_c::value_struct
    // dictionary, and use serialize() to populate our members from its content.
    Iarchive_xmlrpc_c iar(statusDict);
    iar >> *this;
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

xmlrpc_c::value_struct
XmitStatus::toXmlRpcValue() const {
    std::map<std::string, xmlrpc_c::value> statusDict;
    // Clone ourself to a non-const instance
    XmitStatus clone(*this);
    // Stuff our content into the statusDict, i.e., _serialize() to an
    // output archiver wrapped around the statusDict.
    Oarchive_xmlrpc_c oar(statusDict);
    oar << clone;
    // Finally, return the statusDict
    return(xmlrpc_c::value_struct(statusDict));
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
