/*
 * SFDataHandler.cpp
 *
 *  Created on: Jul 1, 2016
 *      Author: burghart
 */

#include <inttypes.h>
#include <ANPPPacketFactory.h>
#include "SFDataHandler.h"

SFDataHandler::SFDataHandler() {
}

SFDataHandler::~SFDataHandler() {
}

void
SFDataHandler::handleData(QByteArray data) {
    const uint8_t* uint8Data = reinterpret_cast<uint8_t*>(data.data());
    int dataLen = data.length();
    ANPPPacketFactory::instance().constructANPPPacket(uint8Data, dataLen);
}
