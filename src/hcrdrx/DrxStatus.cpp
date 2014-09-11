/*
 * DrxStatus.cpp
 *
 *  Created on: Sep 6, 2012
 *      Author: hcr
 */

#include "DrxStatus.h"
#include <p7142sd3c.h>
#include <p7142sd3cDn.h>
#include <Archive_xmlrpc_c.h>
#include <logx/Logging.h>
#include <iomanip>

LOGGING("DrxStatus")

DrxStatus::DrxStatus() :
    _pentekFpgaTemp(-99),
    _pentekBoardTemp(-99),
    _xmitPulseWidth(0.0),
    _prt(0.0),
    _nGates(0),
    _gateSpacing(0.0) {
}

DrxStatus::DrxStatus(const Pentek::p7142sd3c & pentek) {
    _pentekFpgaTemp = pentek.fpgaTemp();
    _pentekBoardTemp = pentek.circuitBoardTemp();
    _nGates = pentek.gates();
    _prt = pentek.prt();
    _xmitPulseWidth = pentek.txPulseWidth();
    // Search channel-by-channel until we find a downconverter, then query it
    // to find gate spacing.
    const Pentek::p7142sd3cDn* downconverter = NULL;
    for (int chan = 0; chan < 4 && downconverter == NULL; chan++) {
        downconverter = dynamic_cast<const Pentek::p7142sd3cDn*>(pentek.downconverter(chan));
    }
    _gateSpacing = downconverter ? downconverter->gateSpacing() : 0;
}

DrxStatus::DrxStatus(xmlrpc_c::value_struct & statusDict) :
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

DrxStatus::~DrxStatus() {
}

xmlrpc_c::value_struct
DrxStatus::toXmlRpcValue() const {
    std::map<std::string, xmlrpc_c::value> statusDict;
    // Clone ourself to a non-const instance
    DrxStatus clone(*this);
    // Stuff our content into the statusDict, i.e., _serialize() to an 
    // output archiver wrapped around the statusDict.
    Oarchive_xmlrpc_c oar(statusDict);
    oar << clone;
    // Finally, return the statusDict
    return(xmlrpc_c::value_struct(statusDict));
}
