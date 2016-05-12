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
 * FireFlyStatus.cpp
 *
 *  Created on: Aug 31, 2012
 *      Author: burghart
 */

#include "FireFlyStatus.h"
#include <cstdlib>
#include <Archive_xmlrpc_c.h>
#include <logx/Logging.h>

LOGGING("FireFlyStatus")

FireFlyStatus::FireFlyStatus() :
    _statusTime(time(0)),
    _deviceResponding(false),
    _pllLocked(false),
    _lastHoldoverDuration(0),
    _inHoldover(false),
    _freqErrorEstimate(1.0),
    _timeDiff1PPS(1.0),
    _healthStatus(0xfff),
    _configError(false) {
}

FireFlyStatus::FireFlyStatus(bool deviceResponding, bool pllLocked,
        int lastHoldoverDuration, bool inHoldover, float freqErrorEstimate,
        float timeDiff1PPS, uint16_t healthStatus, bool configError):
    _statusTime(time(0)),
    _deviceResponding(deviceResponding),
    _pllLocked(pllLocked),
    _lastHoldoverDuration(lastHoldoverDuration),
    _inHoldover(inHoldover),
    _freqErrorEstimate(freqErrorEstimate),
    _timeDiff1PPS(timeDiff1PPS),
    _healthStatus(healthStatus),
    _configError(configError) {
}

FireFlyStatus::FireFlyStatus(xmlrpc_c::value_struct & statusDict):
    _statusTime(time(0)),
    _deviceResponding(false),
    _pllLocked(false),
    _lastHoldoverDuration(0),
    _inHoldover(false),
    _freqErrorEstimate(0.0),
    _timeDiff1PPS(0.0),
    _healthStatus(0),
    _configError(false) {
    // Create an input archiver wrapper around the xmlrpc_c::value_struct
    // dictionary, and use serialize() to populate our members from its content.
    Iarchive_xmlrpc_c iar(statusDict);
    iar >> *this;
}

FireFlyStatus::~FireFlyStatus() {
}

xmlrpc_c::value_struct
FireFlyStatus::toXmlRpcValue() const {
    std::map<std::string, xmlrpc_c::value> statusDict;
    // Clone ourself to a non-const instance
    FireFlyStatus clone(*this);
    // Stuff our content into the statusDict, i.e., _serialize() to an
    // output archiver wrapped around the statusDict.
    Oarchive_xmlrpc_c oar(statusDict);
    oar << clone;
    // Finally, return the statusDict
    return(xmlrpc_c::value_struct(statusDict));
}

FireFlyStatus::Severity
FireFlyStatus::overallStatus() {
    // Error if:
    //    1) the device is not responding
    //    2) PLL is not locked
    //    3) a health bit is set which we consider to be an error bit
    if (! _deviceResponding || ! _pllLocked || (_healthStatus & _ErrorBits)) {
        return(ERROR);
    }
    // Warning if:
    //   1) The unit is in GPS holdover
    //   2) a health bit is set which we consider to be a warning bit
    if (_inHoldover || (_healthStatus & _WarningBits)) {
        return(WARNING);
    }

    // Otherwise, consider everything OK
    return(OK);
}
