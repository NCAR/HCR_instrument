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
 * HcrExecutiveStatus.cpp
 *
 *  Created on: Oct 27, 2014
 *      Author: burghart
 */

#include "HcrExecutiveStatus.h"
#include "ApsControl.h"
#include "TransmitControl.h"
#include <Archive_xmlrpc_c.h>
#include <logx/Logging.h>
#include <cmath>
#include <iomanip>

LOGGING("HcrExecutiveStatus")

HcrExecutiveStatus::HcrExecutiveStatus() :
        _apsValveControlState(ApsControl::VALVE_AUTOMATIC),
        _apsStatusText("no status"),
        _hcrPmc730Responsive(false),
        _hcrPmc730Status(),
        _motionControlResponsive(false),
        _motionControlStatus(),
        _insInUse(1),
        _insResponsive(false),
        _terrainHtServerResponsive(false),
        _mslAltitude(NAN),
        _aglAltitude(NAN),
        _overWater(false),
        _meanMaxPower(-999.9),
        _requestedOperationMode(),
        _currentOperationMode(),
        _hvRequested(false),
        _xmitTestStatus(TransmitControl::NOXMIT_UNSPECIFIED),
        _transmitAllowed(false),
        _attenuationRequired(false),
        _timeOfLastHvOffForHighPower(0),
        _detailsForLastHvOffForHighPower("") {
}

HcrExecutiveStatus::HcrExecutiveStatus(const ApsControl & apsControl,
        const TransmitControl & transmitControl) :
        _apsValveControlState(ApsControl::VALVE_AUTOMATIC),
        _apsStatusText("no status"),
        _hcrPmc730Responsive(false),
        _hcrPmc730Status(transmitControl.hcrPmc730Status()),
        _motionControlResponsive(false),
        _motionControlStatus(transmitControl.motionControlStatus()),
        _insInUse(1),
        _insResponsive(false),
        _terrainHtServerResponsive(false),
        _mslAltitude(0.0),
        _aglAltitude(0.0),
        _overWater(false),
        _meanMaxPower(-999.9),
        _requestedOperationMode(),
        _currentOperationMode(),
        _hvRequested(false),
        _xmitTestStatus(TransmitControl::NOXMIT_UNSPECIFIED),
        _transmitAllowed(false),
        _attenuationRequired(false),
        _timeOfLastHvOffForHighPower(0),
        _detailsForLastHvOffForHighPower("") {
    // Get ApsControl status
    _apsValveControlState = apsControl._valveControlState;
    _apsStatusText = apsControl._statusText;
    
    // Get TransmitControl status
    _hcrPmc730Responsive = transmitControl._hcrPmc730Responsive;
    _motionControlResponsive = transmitControl._motionControlResponsive;
    _insInUse = transmitControl._insInUse;
    _insResponsive = transmitControl._insResponsive;
    _terrainHtServerResponsive = transmitControl._terrainHtServerResponsive;
    _mslAltitude = transmitControl._mslAltitude;
    _aglAltitude = transmitControl._aglAltitude;
    _overWater = transmitControl._overWater;
    _meanMaxPower = transmitControl._maxPowerReport.meanMaxPower;
    _requestedOperationMode = transmitControl._requestedOperationMode;
    _currentOperationMode = transmitControl._currentOperationMode;
    _hvRequested = transmitControl._hvRequested;
    _xmitTestStatus = transmitControl._xmitTestStatus;
    _xmitTestStatusText = transmitControl._xmitTestStatusText();
    _transmitAllowed = transmitControl.transmitAllowed();
    _attenuationRequired = transmitControl.attenuationRequired();
    _timeOfLastHvOffForHighPower = transmitControl._timeOfLastHvOffForHighPower;
    _detailsForLastHvOffForHighPower = transmitControl._detailsForLastHvOffForHighPower;
}

HcrExecutiveStatus::HcrExecutiveStatus(xmlrpc_c::value_struct & statusDict) :
    _apsValveControlState(ApsControl::VALVE_AUTOMATIC),
    _apsStatusText("no status"),
    _hcrPmc730Responsive(false),
    _motionControlResponsive(false),
    _insInUse(1),
    _insResponsive(false),
    _terrainHtServerResponsive(false),
    _mslAltitude(0.0),
    _aglAltitude(0.0),
    _overWater(false),
    _meanMaxPower(-999.9),
    _requestedOperationMode(),
    _currentOperationMode(),
    _hvRequested(false),
    _xmitTestStatus(TransmitControl::NOXMIT_UNSPECIFIED),
    _transmitAllowed(false),
    _attenuationRequired(false),
    _timeOfLastHvOffForHighPower(0),
    _detailsForLastHvOffForHighPower("") {
    // Create an input archiver wrapper around the xmlrpc_c::value_struct
    // dictionary, and use serialize() to populate our members from its content.
    Iarchive_xmlrpc_c iar(statusDict);
    iar >> *this;
}

HcrExecutiveStatus::~HcrExecutiveStatus() {
}

xmlrpc_c::value_struct
HcrExecutiveStatus::toXmlRpcValue() const {
    std::map<std::string, xmlrpc_c::value> statusDict;
    // Clone ourself to a non-const instance
    HcrExecutiveStatus clone(*this);
    // Stuff our content into the statusDict, i.e., _serialize() to an 
    // output archiver wrapped around the statusDict.
    Oarchive_xmlrpc_c oar(statusDict);
    oar << clone;
    // Finally, return the statusDict
    return(xmlrpc_c::value_struct(statusDict));
}
