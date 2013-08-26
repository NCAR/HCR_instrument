/*
 * DrxStatus.cpp
 *
 *  Created on: Sep 6, 2012
 *      Author: hcr
 */

#include "DrxStatus.h"
#include "XmlRpcValueArchive.h"
#include <HcrPmc730.h>
#include <logx/Logging.h>
#include <iomanip>

LOGGING("DrxStatus")

DrxStatus::DrxStatus() :
    _pentekFpgaTemp(-99.9),
    _pentekBoardTemp(-99.9) {
}

DrxStatus::DrxStatus(const Pentek::p7142 & pentek) {
    _getPentekValues(pentek);
}

DrxStatus::DrxStatus(XmlRpcValue & statusDict) {
    // Create an input archiver wrapper around the XmlRpcValue dictionary,
    // and use serialize() to populate our members from its content.
    XmlRpcValueIarchive iar(statusDict);
    iar >> *this;
}

DrxStatus::~DrxStatus() {
}

XmlRpcValue
DrxStatus::toXmlRpcValue() const {
    XmlRpcValue statusDict;
    // Clone ourself to a non-const instance
    DrxStatus clone(*this);
    // Stuff our content into the statusDict, i.e., _serialize() to an 
    // output archiver wrapped around the statusDict.
    XmlRpcValueOarchive oar(statusDict);
    oar << clone;
    // Finally, return the statusDict
    return(statusDict);
}

void
DrxStatus::_getPentekValues(const Pentek::p7142 & pentek) {
    _pentekFpgaTemp = pentek.fpgaTemp();
    _pentekBoardTemp = pentek.circuitBoardTemp();
}
