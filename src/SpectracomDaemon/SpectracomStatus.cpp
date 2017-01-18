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
 * SpectracomStatus.cpp
 *
 *  Created on: Aug 31, 2012
 *      Author: burghart
 */

#include <cstdlib>
#include <Archive_xmlrpc_c.h>
#include <logx/Logging.h>
#include <SpectracomDaemon/SpectracomStatus.h>

LOGGING("SpectracomStatus")

SpectracomStatus::SpectracomStatus() :
    _statusTime(time(0)),
    _hostName("Unknown"),
    _hostResponding(false),
    _timeReference("----"),
    _ppsReference("----"),
    _ntpStratum(999),
    _inSync(false),
    _oscType("Unknown"),
    _oscState("Unknown"),
    _tfom(999),
    _maxTfom(999),
    _alarmStatusTime(0.0),
    _majorAlarm(false),
    _minorAlarm(false),
    _alarmList(),
    _disciplineTime(0.0),
    _dacValue(0),
    _ppsPhaseErr(0),
    _freqErr(1.0),
    _oscTemp(0.0) {
}

SpectracomStatus::SpectracomStatus(xmlrpc_c::value_struct & statusDict):
    _statusTime(time(0)),
    _hostName(),
    _hostResponding(false),
    _timeReference("----"),
    _ppsReference("----"),
    _ntpStratum(999),
    _inSync(false),
    _oscType("Unknown"),
    _oscState("Unknown"),
    _tfom(999),
    _maxTfom(999),
    _alarmStatusTime(0.0),
    _majorAlarm(false),
    _minorAlarm(false),
    _alarmList(),
    _disciplineTime(0.0),
    _dacValue(0),
    _ppsPhaseErr(0),
    _freqErr(1.0),
    _oscTemp(0.0) {
    // Create an input archiver wrapper around the xmlrpc_c::value_struct
    // dictionary, and use serialize() to populate our members from its content.
    Iarchive_xmlrpc_c iar(statusDict);
    iar >> *this;
}

SpectracomStatus::~SpectracomStatus() {
}

xmlrpc_c::value_struct
SpectracomStatus::toXmlRpcValue() const {
    std::map<std::string, xmlrpc_c::value> statusDict;
    // Clone ourself to a non-const instance
    SpectracomStatus clone(*this);
    // Stuff our content into the statusDict, i.e., _serialize() to an
    // output archiver wrapped around the statusDict.
    Oarchive_xmlrpc_c oar(statusDict);
    oar << clone;
    // Finally, return the statusDict
    return(xmlrpc_c::value_struct(statusDict));
}

int
SpectracomStatus::syncSimpleStatus() const {
    // Currently, we indicate only minor problems or none for sync state
    return(_inSync ? 0 : 1);
}

int
SpectracomStatus::alarmsSimpleStatus() const {
    if (_majorAlarm) {
        return 2;
    } else if (_minorAlarm) {
        return 1;
    }
    return 0;
}

int
SpectracomStatus::tfomSimpleStatus() const {
    // Currently, we indicate only minor problems or none for TFOM state
    return((_tfom <= _maxTfom) ? 0 : 1);
}

int
SpectracomStatus::oscSimpleStatus() const {
    // Currently, we indicate only minor problems or none for oscillator state
    return((_oscState == "Trk/Lock") ? 0 : 1);
}

int
SpectracomStatus::simpleStatus() const {
    // Major problem if the host is not responding
    int status = _hostResponding ? 0 : 2;
    // Change overall status if we get worse status for sync, alarms, TFOM,
    // or the oscillator
    if (syncSimpleStatus() > status) {
        status = syncSimpleStatus();
    }
    if (alarmsSimpleStatus() > status) {
        status = alarmsSimpleStatus();
    }
    if (tfomSimpleStatus() > status) {
        status = tfomSimpleStatus();
    }
    if (oscSimpleStatus() > status) {
        status = oscSimpleStatus();
    }

    return(status);
}
