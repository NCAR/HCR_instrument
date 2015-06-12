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
    _reference("Unknown"),
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
    _freqErrTime(0.0),
    _freqErr(1.0) {
}

SpectracomStatus::SpectracomStatus(xmlrpc_c::value_struct & statusDict):
    _statusTime(time(0)),
    _hostName(),
    _hostResponding(false),
    _reference("Unknown"),
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
    _freqErrTime(0.0),
    _freqErr(1.0) {
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
