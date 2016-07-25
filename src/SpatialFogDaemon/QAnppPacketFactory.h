/*
 * QAnppPacketFactory.h
 *
 *  Created on: Jul 1, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#ifndef _QANPPPACKETFACTORY_H_
#define _QANPPPACKETFACTORY_H_

#include <map>
#include <vector>
#include <QObject>

#include <AnppPacket.h>

/// @brief Factory which accepts incoming raw Advanced Navigation Packet
/// Protocol (ANPP) data, then creates and emits AnppPacket objects.
///
/// Data from an Advanced Navigation INS unit (e.g., Spatial FOG) are passed
/// in to the appendData() slot. As full ANPP packets can be parsed, new
/// AnppPacket objects are created and the emitted via the newPacket() signal.
class QAnppPacketFactory: public QObject {
    Q_OBJECT
public:
    QAnppPacketFactory();
    virtual ~QAnppPacketFactory();

    /// @brief Return the number of ANPP packets received and decoded by
    /// the SFDataHandler since it was created.
    /// @return the number of ANPP packets received and decoded by
    /// the SFDataHandler since it was created.
    int totalPacketsReceived() const {
        int count = 0;
        std::map<int, int>::const_iterator it;
        // Sum the counts for each of the packet IDs we've received
        for (it = _packetCountMap.begin(); it != _packetCountMap.end(); it++) {
            count += it->second;
        }
        return(count);
    }

public slots:
    /// @brief Slot to accept incoming data from the Spatial FOG and emit
    /// newPacket() signals as packets can be parsed from the stream.
    void appendData(QByteArray newData);

signals:
    /// @brief Signal emitted when a new ANPP packet has arrived from the
    /// Spatial FOG.
    void newPacket(AnppPacket * packet);

private:
    /// @brief Parse the _data array to find complete ANPP packets, and
    /// emit a newPacket() signal as each new packet is successfully parsed.
    ///
    /// Parsed data is removed from the _data array.
    void _parseData();

    /// @brief Byte array to hold unconsumed data which has come from the
    /// Spatial FOG.
    QByteArray _data;

    // Number of bytes skipped to find a valid packet header
    uint _nskipped;

    // Map to hold a packet count by packet ID
    std::map<int, int> _packetCountMap;

};

#endif /* _QANPPPACKETFACTORY_H_ */
