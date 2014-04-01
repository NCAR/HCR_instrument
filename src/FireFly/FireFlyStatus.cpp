/*
 * FireFlyStatus.cpp
 *
 *  Created on: Aug 31, 2012
 *      Author: burghart
 */

#include "FireFlyStatus.h"
#include <cstdlib>
#include <ctime>
#include <Archive_xmlrpc_c.h>
#include <logx/Logging.h>

LOGGING("FireFlyStatus")

FireFlyStatus::FireFlyStatus() :
    _statusTime(time(0)),
    _deviceResponding(false),
    _locked1PPS(false),
    _lastHoldoverDuration(0),
    _inHoldover(false),
    _freqErrorEstimate(1.0),
    _timeDiff1PPS(1.0),
    _healthStatus(0xfff),
    _configError(false) {
}

FireFlyStatus::FireFlyStatus(bool deviceResponding, bool locked1PPS,
        int lastHoldoverDuration, bool inHoldover, float freqErrorEstimate,
        float timeDiff1PPS, uint16_t healthStatus, bool configError):
    _statusTime(time(0)),
    _deviceResponding(deviceResponding),
    _locked1PPS(locked1PPS),
    _lastHoldoverDuration(lastHoldoverDuration),
    _inHoldover(inHoldover),
    _freqErrorEstimate(freqErrorEstimate),
    _timeDiff1PPS(timeDiff1PPS),
    _healthStatus(healthStatus),
    _configError(configError) {
}

FireFlyStatus::FireFlyStatus(xmlrpc_c::value_struct & statusDict) {
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
