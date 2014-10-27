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
    _pentekFpgaTemp(-99),
    _pentekBoardTemp(-99),
    _xmitPulseWidth(0.0),
    _prt(0.0),
    _nGates(0),
    _gateSpacing(0.0) {
}

HcrMonitorStatus::HcrMonitorStatus(const ApsControl & apsControl,
        const TransmitControl & transmitControl) {
}

HcrMonitorStatus::HcrMonitorStatus(xmlrpc_c::value_struct & statusDict) :
    _pentekFpgaTemp(-99),
    _pentekBoardTemp(-99),
    _xmitPulseWidth(0.0),
    _prt(0.0),
    _nGates(0),
    _gateSpacing(0.0) {
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
