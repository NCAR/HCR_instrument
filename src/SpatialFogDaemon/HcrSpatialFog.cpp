/*
 * HcrSpatialFOG.cpp
 *
 *  Created on: Jul 18, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#include <cerrno>
#include <unistd.h>

#include <EulerPacket.h>
#include <NEDVelocityPacket.h>
#include <SystemStatePacket.h>
#include <logx/Logging.h>

#include "HcrSpatialFog.h"

LOGGING("HcrSpatialFog")

// Map from operating states to names
std::map<HcrSpatialFog::OperatingState, std::string>
HcrSpatialFog::OperatingStateNames = {
        {NotOperating, "NotOperating"},
        {SettingBaudRate, "SettingBaudRate"},
        {Configuring, "Configuring"},
        {Operating, "Operating"}
};

HcrSpatialFog::HcrSpatialFog(std::string devName) :
    _devName(devName),
    _ttyFd(-1),
    _fdReader(NULL),
    _pktFactory(),
    _operatingState(NotOperating),
    _fmq(true) {
    // Open a file descriptor to our device, and start a Qt-based threaded
    // reader to read from the fd and publish data via its newData() signal.
    _openTtyFd();
    _fdReader = new FDReader(_ttyFd);

    // Push incoming data to the packet factory
    connect(_fdReader, SIGNAL(newData(QByteArray)),
            &_pktFactory, SLOT(appendData(QByteArray)));

    // Pass packets from the factory to our _packetHandler() slot
    connect(&_pktFactory, SIGNAL(newPacket(AnppPacket *)),
            this, SLOT(_packetHandler(AnppPacket *)));

    _setOperatingState(Operating);
}

HcrSpatialFog::~HcrSpatialFog() {
    delete(_fdReader);
}

void
HcrSpatialFog::_setOperatingState(OperatingState newState) {
    if (newState == _operatingState) {
        WLOG << "Ignoring operating state change to same state (" <<
                _operatingState << ")";
        return;
    } else {
        ILOG << "Operating state change: " <<
                OperatingStateNames[_operatingState] << " -> " <<
                OperatingStateNames[newState];
    }
    _operatingState = newState;
}

std::string
HcrSpatialFog::_BaudToText(speed_t baudValue) {
    std::string speedTxt("unknown");
    switch (baudValue) {
    case B9600:
        speedTxt = "B9600";
        break;
    case B19200:
        speedTxt = "B19200";
        break;
    case B38400:
        speedTxt = "B38400";
        break;
    case B57600:
        speedTxt = "B57600";
        break;
    case B115200:
        speedTxt = "B115200";
        break;
    case B230400:
        speedTxt = "B230400";
        break;
    case B460800:
        speedTxt = "B460800";
        break;
    case B500000:
        speedTxt = "B500000";
        break;
    case B1000000:
        speedTxt = "B1000000";
        break;
    default:
        std::ostringstream oss;
        oss << "(Unknown speed_t value " << baudValue << ")";
        speedTxt = oss.str();
    }
    return(speedTxt);
}

void
HcrSpatialFog::_setBaud(speed_t baudValue) const {
    // Get current settings, change the port speed, and send the new settings.
    struct termios ios;
    if (tcgetattr(_ttyFd, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error getting " << _devName <<
                " attributes: " << strerror(errno);
        exit(1);
    }

    // Change speed if the current speed is not the same as the requested one
    if (cfgetispeed(&ios) == baudValue && cfgetospeed(&ios) == baudValue) {
        DLOG << __PRETTY_FUNCTION__ << ": requested baud rate matches current";
    } else {
        ILOG << "Changing speed on " << _devName << " to " <<
                _BaudToText(baudValue);
        cfsetspeed(&ios, baudValue);

        // Send new I/O settings
        if (tcsetattr(_ttyFd, TCSAFLUSH, &ios) == -1) {
            ELOG << __PRETTY_FUNCTION__ << ": error setting " << _devName <<
                    " attributes: " << strerror(errno);
            exit(1);
        }
    }
}

void
HcrSpatialFog::_openTtyFd() {
    DLOG << "Opening " << _devName;

    if ((_ttyFd = open(_devName.c_str(), O_RDWR)) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error opening " << _devName << ": " <<
                strerror(errno);
        exit(1);
    }

    // Make the port 8 data bits, 1 stop bit, odd parity, "raw"
    struct termios ios;
    if (tcgetattr(_ttyFd, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error getting " << _devName <<
                " attributes: " << strerror(errno);
        exit(1);
    }
    cfmakeraw(&ios);

    if (tcsetattr(_ttyFd, TCSAFLUSH, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error setting " << _devName <<
                " attributes: " << strerror(errno);
        exit(1);
    }

    // Start at 115200 baud
    _setBaud(B115200);

    DLOG << "Done configuring " << _devName;
}

void
HcrSpatialFog::_packetHandler(AnppPacket * pkt) {
    // Get packet time in milliseconds since 1970-01-01 00:00:00 UTC
    uint64_t pktTime = uint64_t(pkt->timeOfValidity() * 1000);

    // If it's an EulerPacket, save the new attitude information to the FMQ
    EulerPacket * ePkt = dynamic_cast<EulerPacket*>(pkt);
    if (ePkt) {
        DLOG << "Got Euler";
        _fmq.storeLatestAttitudeData(pktTime, ePkt->pitch(), ePkt->roll(),
                ePkt->heading());
    }

    // If it's a NEDVelocityPacket, save the north/east/up speeds to the FMQ
    NEDVelocityPacket * velPkt = dynamic_cast<NEDVelocityPacket*>(pkt);
    if (velPkt) {
        DLOG << "Got NEDVelocity";
        _fmq.storeLatestVelocityData(pktTime, velPkt->velocityNorth(),
                velPkt->velocityEast(), velPkt->velocityUp());
    }

    // If it's a SystemStatePacket, save status and position to the FMQ
    SystemStatePacket * ssPkt = dynamic_cast<SystemStatePacket*>(pkt);
    if (ssPkt) {
        DLOG << "Got SystemState";
        _fmq.storeLatestStatusData(pktTime, ssPkt->systemStatus(),
                ssPkt->filterStatus());
        _fmq.storeLatestPositionData(pktTime, ssPkt->latitude(),
                ssPkt->longitude(), ssPkt->altitude());
    }
}

void
HcrSpatialFog::_sendAnppPacket(const AnppPacket & packet) const {
    std::vector<uint8_t> raw(packet.rawBytes());
    int nwritten = 0;
    while (nwritten < int(raw.size())) {
        int wrote = write(_ttyFd, &raw[nwritten], raw.size() - nwritten);
        if (wrote < 0) {
            ELOG << "error writing packet (type " << packet.packetId() <<
                    "): " << strerror(errno);
            return;
        }
        nwritten += wrote;
    }
}
