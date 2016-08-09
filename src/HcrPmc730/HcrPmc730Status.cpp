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
 * HcrPmc730Status.cpp
 *
 *  Created on: Sep 6, 2012
 *      Author: hcr
 */

#include "HcrPmc730Status.h"
#include <Archive_xmlrpc_c.h>
#include <logx/Logging.h>
#include <iomanip>

LOGGING("HcrPmc730Status")

// Static temperature lists
HcrPmc730Status::TemperatureList HcrPmc730Status::_PloTemps;
HcrPmc730Status::TemperatureList HcrPmc730Status::_EikTemps;
HcrPmc730Status::TemperatureList HcrPmc730Status::_VLnaTemps;
HcrPmc730Status::TemperatureList HcrPmc730Status::_HLnaTemps;
HcrPmc730Status::TemperatureList HcrPmc730Status::_PolarizationSwitchTemps;
HcrPmc730Status::TemperatureList HcrPmc730Status::_RfDetectorTemps;
HcrPmc730Status::TemperatureList HcrPmc730Status::_NoiseSourceTemps;
HcrPmc730Status::TemperatureList HcrPmc730Status::_Ps28VTemps;
HcrPmc730Status::TemperatureList HcrPmc730Status::_RdsInDuctTemps;
HcrPmc730Status::TemperatureList HcrPmc730Status::_RotationMotorTemps;
HcrPmc730Status::TemperatureList HcrPmc730Status::_TiltMotorTemps;
HcrPmc730Status::TemperatureList HcrPmc730Status::_InsTemps;
HcrPmc730Status::TemperatureList HcrPmc730Status::_TailconeTemps;


HcrPmc730Status::HcrPmc730Status(bool createEmptyInstance) :
    _ploTemp(0.0),
    _eikTemp(0.0),
    _vLnaTemp(0.0),
    _hLnaTemp(0.0),
    _polarizationSwitchTemp(0.0),
    _rfDetectorTemp(0.0),
    _noiseSourceTemp(0.0),
    _ps28VTemp(0.0),
    _rdsInDuctTemp(0.0),
    _rotationMotorTemp(0.0),
    _tiltMotorTemp(0.0),
    _insTemp(0.0),
    _tailconeTemp(0.0),
    _detectedRfPower(0.0),
    _pvAftPressure(0.0),
    _pvForePressure(0.0),
    _apsLowSidePressure(0.0),
    _apsHighSidePressure(0.0),
    _psVoltage(0.0),
    _locked15_5GHzPLO(false),
    _locked1250MHzPLO(false),
    _locked125MHzPLO(false),
    _modPulseDisabled(false),
    _apsValveOpen(false),
    _rdsXmitterFilamentOn(false),
    _rdsXmitterHvOn(false),
    _radarPowerError(false),
    _emsPowerError(false),
    _waveguideSwitchError(false),
    _emsErrorCount(0),
    _emsError1(false),
    _emsError2(false),
    _emsError3(false),
    _emsError4Or5(false),
    _emsError6Or7(false),
    _hmcMode(HcrPmc730::HMC_MODE_INVALID) {
    // If requested, get real values from the local static HcrPmc730 instance
    if (! createEmptyInstance) {
        _getMultiIoValues();
    }
}

HcrPmc730Status::HcrPmc730Status(const xmlrpc_c::value_struct & statusDict) :
    _ploTemp(0.0),
    _eikTemp(0.0),
    _vLnaTemp(0.0),
    _hLnaTemp(0.0),
    _polarizationSwitchTemp(0.0),
    _rfDetectorTemp(0.0),
    _noiseSourceTemp(0.0),
    _ps28VTemp(0.0),
    _rdsInDuctTemp(0.0),
    _rotationMotorTemp(0.0),
    _tiltMotorTemp(0.0),
    _insTemp(0.0),
    _tailconeTemp(0.0),
    _detectedRfPower(0.0),
    _pvAftPressure(0.0),
    _pvForePressure(0.0),
    _apsLowSidePressure(0.0),
    _apsHighSidePressure(0.0),
    _psVoltage(0.0),
    _locked15_5GHzPLO(false),
    _locked1250MHzPLO(false),
    _locked125MHzPLO(false),
    _modPulseDisabled(false),
    _apsValveOpen(false),
    _rdsXmitterFilamentOn(false),
    _rdsXmitterHvOn(false),
    _radarPowerError(false),
    _emsPowerError(false),
    _waveguideSwitchError(false),
    _emsErrorCount(0),
    _emsError1(false),
    _emsError2(false),
    _emsError3(false),
    _emsError4Or5(false),
    _emsError6Or7(false),
    _hmcMode(HcrPmc730::HMC_MODE_INVALID) {
    // Create an input archiver wrapper around the map from std::string to
    // xmlrpc_c::value, and use serialize() to populate our members from its
    // content.
    std::map<std::string, xmlrpc_c::value> statusMap(statusDict);
    Iarchive_xmlrpc_c iar(statusMap);
    iar >> *this;
}

HcrPmc730Status::~HcrPmc730Status() {
}

xmlrpc_c::value_struct
HcrPmc730Status::toXmlRpcValue() const {
    std::map<std::string, xmlrpc_c::value> statusMap;
    // Clone ourself to a non-const instance. We take as a given that the
    // Oarchive_xmlrpc_c operator<<() will not modify us...
    HcrPmc730Status clone(*this);
    // Stuff our content into the statusMap, i.e., _serialize() to an
    // output archiver wrapped around the statusDict.
    Oarchive_xmlrpc_c oar(statusMap);
    oar << clone;
    // Finally, return a value_struct constructed from the map
    return(xmlrpc_c::value_struct(statusMap));
}

void
HcrPmc730Status::_getMultiIoValues() {
    // Load current analog values from the PMC-730
    HcrPmc730::updateAnalogValues();
    
    // Get various temperatures from sensors connected to the PMC-730. The data 
    // are a bit noisy, so we keep up to TemperatureList::_MAX_SIZE samples so 
    // we can generate moving averages.
    _PloTemps.addTemperature(HcrPmc730::ploTemperature());
    _EikTemps.addTemperature(HcrPmc730::eikTemperature());
    _VLnaTemps.addTemperature(HcrPmc730::vLnaTemperature());
    _HLnaTemps.addTemperature(HcrPmc730::hLnaTemperature());
    _PolarizationSwitchTemps.addTemperature(HcrPmc730::polSwitchTemperature());
    _RfDetectorTemps.addTemperature(HcrPmc730::rfDetectorTemperature());
    _NoiseSourceTemps.addTemperature(HcrPmc730::noiseSourceTemperature());
    _Ps28VTemps.addTemperature(HcrPmc730::ps28vTemperature());
    _RdsInDuctTemps.addTemperature(HcrPmc730::rdsInDuctTemperature());
    _InsTemps.addTemperature(HcrPmc730::insTemperature());
    _TiltMotorTemps.addTemperature(HcrPmc730::tiltMotorTemperature());
    _RotationMotorTemps.addTemperature(HcrPmc730::rotMotorTemperature());
    _TailconeTemps.addTemperature(HcrPmc730::tailconeTemperature());

    // Save the current averaged temperatures
    _ploTemp = _PloTemps.mean();
    _eikTemp = _EikTemps.mean();
    _vLnaTemp = _VLnaTemps.mean();
    _hLnaTemp = _HLnaTemps.mean();
    _polarizationSwitchTemp = _PolarizationSwitchTemps.mean();
    _rfDetectorTemp = _RfDetectorTemps.mean();
    _noiseSourceTemp = _NoiseSourceTemps.mean();
    _ps28VTemp = _Ps28VTemps.mean();
    _rdsInDuctTemp = _RdsInDuctTemps.mean();
    _insTemp = _InsTemps.mean();
    _tiltMotorTemp = _TiltMotorTemps.mean();
    _rotationMotorTemp = _RotationMotorTemps.mean();
    _tailconeTemp = _TailconeTemps.mean();
    
    // Other status from the PMC-730
    _detectedRfPower = HcrPmc730::detectedRfPower();
    _pvAftPressure = HcrPmc730::pvAftPressure();
    _pvForePressure = HcrPmc730::pvForePressure();
    _apsLowSidePressure = HcrPmc730::apsLowSidePressure();
    _apsHighSidePressure = HcrPmc730::apsHighSidePressure();
    _psVoltage = HcrPmc730::ps5vVoltage();
    _locked15_5GHzPLO = HcrPmc730::locked15_5GHzPLO();
    _locked1250MHzPLO = HcrPmc730::locked1250MHzPLO();
    _locked125MHzPLO = HcrPmc730::locked125MHzPLO();
    _modPulseDisabled = HcrPmc730::modPulseDisabled();
    _emsErrorCount = HcrPmc730::emsErrorCount();
    _emsError1 = HcrPmc730::emsError1();
    _emsError2 = HcrPmc730::emsError2();
    _emsError3 = HcrPmc730::emsError3();
    _emsError4Or5 = HcrPmc730::emsError4Or5();
    _emsError6Or7 = HcrPmc730::emsError6Or7();
    _emsPowerError = HcrPmc730::emsPowerError();
    _radarPowerError = HcrPmc730::radarPowerError();
    _waveguideSwitchError = HcrPmc730::waveguideSwitchError();
    _apsValveOpen = HcrPmc730::apsValveOpen();
    _rdsXmitterFilamentOn = HcrPmc730::xmitterFilamentOn();
    _rdsXmitterHvOn = HcrPmc730::xmitterHvOn();
    _hmcMode = HcrPmc730::hmcMode();
    
    // Raise the 'status_ack' line on the HMC briefly so that it will reset
    // status values for which it does sense-and-hold.
    HcrPmc730::ackHmcStatus();
}
