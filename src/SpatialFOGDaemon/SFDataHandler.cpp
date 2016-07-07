/*
 * SFDataHandler.cpp
 *
 *  Created on: Jul 1, 2016
 *      Author: burghart
 */

#include <inttypes.h>
#include <iomanip>
#include <ANPPPacketFactory.h>
#include <logx/Logging.h>
#include "SFDataHandler.h"

LOGGING("SFDataHandler")

SFDataHandler::SFDataHandler() : _data(), _nskipped(0) {
}

SFDataHandler::~SFDataHandler() {
}

void
SFDataHandler::handleData(QByteArray newData) {
    DLOG << "handleData() got " << newData.length() << " bytes";

    // Append the new data to what we already have
    _data += newData;

    // Look for and pass on any valid packet(s) we now have in the data
    _parseData();
}

void
SFDataHandler::_parseData() {
    // Try to extract valid ANPP packets from the data
    while (_data.length() > 0) {
        // Cast our data into a pointer to an array of uint8_t
        const uint8_t* uint8Data = reinterpret_cast<uint8_t*>(_data.data());
        uint dataLen(_data.length());

        try {
            ANPPPacket * pkt =
                    ANPPPacketFactory::instance().constructANPPPacket(uint8Data, dataLen);
            if (_nskipped) {
                WLOG << "Skipped " << _nskipped << " bytes to find a good header";
                _nskipped = 0;
            }
            ILOG << "Got an ANPP packet with ID " << pkt->packetId() <<
                    ", CRC is " << (pkt->crcIsGood() ? "good" : "BAD");
            // Drop the bytes for the packet we just extracted
            _data = _data.right(_data.length() - pkt->fullPacketLen());
            emit(SIGNAL(newPacket(*pkt)));
            delete(pkt);
            continue;
        } catch (ANPPPacket::NeedMoreData & x) {
            // Break out, since we need more data to continue
            DLOG << "need more data...";
            break;
        } catch (ANPPPacket::BadHeader & x) {
            // Not a valid header. Drop the first byte of _data and try again.
            WLOG << "Skipping a byte: " << x.what();
            _data = _data.right(_data.length() - 1);
            _nskipped++;
            continue;
        }
    }
}
