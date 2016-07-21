/*
 * HcrSpatialFog.h
 *
 *  Created on: Jul 18, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#ifndef _HCRSPATIALFOG_H_
#define _HCRSPATIALFOG_H_

#include <map>
#include <string>
#include <termios.h>

#include <AnppPacket.h>
#include <SpatialFogFmq.h>

#include <QDateTime>
#include <QObject>

#include "FDReader.h"
#include "QAnppPacketFactory.h"

class HcrSpatialFog: public QObject {
    Q_OBJECT
public:
    HcrSpatialFog(std::string devName);
    virtual ~HcrSpatialFog();

signals:
    void newAttitude(QDateTime time,
                     double pitchDeg, double rollDeg, double headingDeg);

private:
    /// @brief Open and configure the terminal port to the Spatial FOG
    void _openTtyFd();

    /// @brief Set the baud rate of our terminal device
    void _setBaud(speed_t baudValue) const;

    /// @brief Return a string representation of the given speed_t value
    static std::string _BaudToText(speed_t baudValue);

    /// @brief Send an AnppPacket to the Spatial FOG
    void _sendAnppPacket(const AnppPacket & packet) const;

    /// @brief Enumerated operating states
    typedef enum {
        NotOperating,
        SettingBaudRate,
        Configuring,
        Operating
    } OperatingState;

    /// @brief Map of OperatingState-s to names.
    static std::map<OperatingState, std::string> OperatingStateNames;

    /// @brief Set the operating state
    void _setOperatingState(OperatingState newState);

    /// @brief Device/port name for the SpatialFOG
    std::string _devName;

    /// @brief File descriptor for the open device
    int _ttyFd;

    /// @brief File descriptor reader thread
    FDReader * _fdReader;

    /// @brief Factory for AnppPacket objects
    QAnppPacketFactory _pktFactory;

    /// @brief Current operating state
    OperatingState _operatingState;

    /// @brief The file message queue where data will be written for sharing
    /// with other processes.
    SpatialFogFmq _fmq;

private slots:
    /// @brief Slot which receives incoming Advanced Navigation Packet Protocol
    /// packets, in the form of ANPPPacket objects.
    void _packetHandler(AnppPacket pkt);
};

#endif /* _HCRSPATIALFOG_H_ */
