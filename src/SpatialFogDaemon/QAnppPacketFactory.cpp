/*
 * QAnppPacketFactory.cpp
 *
 *  Created on: Jul 1, 2016
 *      Author: burghart
 */

#include <inttypes.h>
#include <iomanip>
#include <logx/Logging.h>
#include <AnppPacketFactory.h>
#include <QDateTime>
#include <QThread>

#include "QAnppPacketFactory.h"

LOGGING("QAnppPacketFactory")

QAnppPacketFactory::QAnppPacketFactory() :
    _data(),
    _nskipped(0),
    _packetCountMap() {
}

QAnppPacketFactory::~QAnppPacketFactory() {
    if (! _packetCountMap.empty()) {
        ILOG << "Packet counts by ID:";
        for (std::map<int, int>::const_iterator it = _packetCountMap.begin();
             it != _packetCountMap.end(); it++) {
            ILOG << "  " << it->first << " - " << it->second;
        }
    }
}

void
QAnppPacketFactory::appendData(QByteArray newData) {
    // Append the new data to what we already have
    _data += newData;

    // Look for and pass on any valid packet(s) we now have in the data
    _parseData();
}

void
QAnppPacketFactory::_parseData() {
    // Try to extract valid ANPP packets from the data
    while (_data.length() > 0) {
        // Cast our data into a pointer to an array of uint8_t
        const uint8_t* uint8Data = reinterpret_cast<uint8_t*>(_data.data());
        uint dataLen(_data.length());

        try {
            // Let the ANPPPacketFactory try to create a packet
            AnppPacket * pkt =
                    AnppPacketFactory::ConstructAnppPacket(uint8Data, dataLen);
            if (_nskipped) {
                WLOG << "Skipped " << _nskipped <<
                        " bytes to find a pkt (after " <<
                        totalPacketsReceived() << " pkts received)";
                _nskipped = 0;
            }

            // Update our packet count
            _packetCountMap[pkt->packetId()]++;

            // Emit the newPacket() signal
            emit(SIGNAL(newPacket(*pkt)));

            // Drop the bytes from the packet we just decoded from the front
            // of _data
            _data.remove(0, pkt->fullPacketLen());

            // Delete the packet
            delete(pkt);

            continue;
        } catch (AnppPacket::NeedMoreData & x) {
            // Break out, since the factory needs more data to continue
            DLOG << "Waiting for more data: " << x.what();
            break;
        } catch (AnppPacket::BadHeader & x) {
            // Our data does not begin with a valid header. Drop the first
            // byte of _data and try again.
            _data.remove(0, 1);
            _nskipped++;
            if ((_nskipped % 100) == 0) {
                WLOG << "Looking for a header; " << _nskipped <<
                        " bytes skipped so far...";
            }
            continue;
        }
    }
}
