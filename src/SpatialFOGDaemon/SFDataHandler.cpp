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
#include <QtCore/QDateTime>
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
            DLOG << "Packet ID " << pkt->packetId() << " @ " <<
                    QDateTime::fromTime_t(pkt->timeOfValiditySeconds())
                        .addMSecs(pkt->timeOfValidityMicroseconds() / 1000)
                        .toString("hh:mm:ss.zzz")
                        .toStdString();
            if (_nskipped) {
                WLOG << "Skipped " << _nskipped << " bytes to find the last packet";
                _nskipped = 0;
            }

            emit(SIGNAL(newPacket(*pkt)));
            delete(pkt);

            // Drop the bytes for the packet we just constructed
            _data = _data.right(_data.length() - pkt->fullPacketLen());

            continue;
        } catch (ANPPPacket::NeedMoreData & x) {
            // Break out, since we need more data to continue
            DLOG << "Waiting for more data: " << x.what();
            break;
        } catch (ANPPPacket::BadHeader & x) {
            // Not a valid header. Drop the first byte of _data and try again.
            DLOG << "Skipping a byte: " << x.what();
            _data = _data.right(_data.length() - 1);
            _nskipped++;
            if ((_nskipped % 100) == 0) {
                WLOG << "Looking for a header; " << _nskipped <<
                        " bytes skipped so far...";
            }
            continue;
        }
    }
}
