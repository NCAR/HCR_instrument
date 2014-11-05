/*
 * HcrMonitorStatus.cpp
 *
 *  Created on: Oct 27, 2014
 *      Author: burghart
 */

#include "HcrMonitorStatus.h"
#include "ApsControl.h"
#include "TransmitControl.h"
#include <Archive_xmlrpc_c.h>
#include <logx/Logging.h>
#include <iomanip>

LOGGING("HcrMonitorStatus")

HcrMonitorStatus::HcrMonitorStatus() :
        _apsValveControlState(ApsControl::VALVE_AUTOMATIC),
        _hcrPmc730Responsive(false),
        _motionControlResponsive(false),
        _cmigitsResponsive(false),
        _terrainHtServerResponsive(false),
        _mslAltitude(0.0),
        _aglAltitude(0.0),
        _overWater(false),
        _requestedHmcMode(HcrPmc730::HMC_MODE_INVALID),
        _hvRequested(false),
        _xmitTestStatus(TransmitControl::NOXMIT_UNSPECIFIED),
        _transmitAllowed(false),
        _attenuationRequired(false) {
}

HcrMonitorStatus::HcrMonitorStatus(const ApsControl & apsControl,
        const TransmitControl & transmitControl) :
        _apsValveControlState(ApsControl::VALVE_AUTOMATIC),
        _hcrPmc730Responsive(false),
        _motionControlResponsive(false),
        _cmigitsResponsive(false),
        _terrainHtServerResponsive(false),
        _mslAltitude(0.0),
        _aglAltitude(0.0),
        _overWater(false),
        _requestedHmcMode(HcrPmc730::HMC_MODE_INVALID),
        _hvRequested(false),
        _xmitTestStatus(TransmitControl::NOXMIT_UNSPECIFIED),
        _transmitAllowed(false),
        _attenuationRequired(false) {
    // Get ApsControl status
    _apsValveControlState = apsControl._valveControlState;
    
    // Get TransmitControl status
    _hcrPmc730Responsive = transmitControl._hcrPmc730Responsive;
    _motionControlResponsive = transmitControl._motionControlResponsive;
    _cmigitsResponsive = transmitControl._cmigitsResponsive;
    _terrainHtServerResponsive = transmitControl._terrainHtServerResponsive;
    _mslAltitude = transmitControl._mslAltitude;
    _aglAltitude = transmitControl._aglAltitude;
    _overWater = transmitControl._overWater;
    _requestedHmcMode = transmitControl._requestedHmcMode;
    _hvRequested = transmitControl._hvRequested;
    _xmitTestStatus = transmitControl._xmitTestStatus;
    _xmitTestStatusText = transmitControl._xmitTestStatusText();
    _transmitAllowed = transmitControl.transmitAllowed();
    _attenuationRequired = transmitControl.attenuationRequired();
}

HcrMonitorStatus::HcrMonitorStatus(xmlrpc_c::value_struct & statusDict) {
    // Create an input archiver wrapper around the xmlrpc_c::value_struct
    // dictionary, and use serialize() to populate our members from its content.
    Iarchive_xmlrpc_c iar(statusDict);
    iar >> *this;
}

HcrMonitorStatus::~HcrMonitorStatus() {
}

xmlrpc_c::value_struct
HcrMonitorStatus::toXmlRpcValue() const {
    std::map<std::string, xmlrpc_c::value> statusDict;
    // Clone ourself to a non-const instance
    HcrMonitorStatus clone(*this);
    // Stuff our content into the statusDict, i.e., _serialize() to an 
    // output archiver wrapped around the statusDict.
    Oarchive_xmlrpc_c oar(statusDict);
    oar << clone;
    // Finally, return the statusDict
    return(xmlrpc_c::value_struct(statusDict));
}
