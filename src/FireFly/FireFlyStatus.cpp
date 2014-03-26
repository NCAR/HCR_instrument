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

FireFlyStatus FireFlyStatus::_PrevStatus;

FireFlyStatus::FireFlyStatus() {
    _serialConnected = false;
    _filamentOn = false;
}

FireFlyStatus::FireFlyStatus(std::string statusResponse) throw(ConstructError) {
    // Since we have transmitter packet, the serial line must be connected
    _serialConnected = true;

    // 8 bits of boolean status in byte 3
    _filamentOn = false;

    // And now we become the previous status...
    _PrevStatus = *this;
}

FireFlyStatus::FireFlyStatus(xmlrpc_c::value_struct & statusDict) throw(ConstructError) {
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
