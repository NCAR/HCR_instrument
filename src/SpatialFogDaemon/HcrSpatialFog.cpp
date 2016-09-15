// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2016                                         
// ** University Corporation for Atmospheric Research (UCAR)                 
// ** National Center for Atmospheric Research (NCAR)                        
// ** Boulder, Colorado, USA                                                 
// ** BSD licence applies - redistribution and use in source and binary      
// ** forms, with or without modification, are permitted provided that       
// ** the following conditions are met:                                      
// ** 1) If the software is modified to produce derivative works,            
// ** such modified software should be clearly marked, so as not             
// ** to confuse it with the version available from UCAR.                    
// ** 2) Redistributions of source code must retain the above copyright      
// ** notice, this list of conditions and the following disclaimer.          
// ** 3) Redistributions in binary form must reproduce the above copyright   
// ** notice, this list of conditions and the following disclaimer in the    
// ** documentation and/or other materials provided with the distribution.   
// ** 4) Neither the name of UCAR nor the names of its contributors,         
// ** if any, may be used to endorse or promote products derived from        
// ** this software without specific prior written permission.               
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS  
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED      
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.    
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
/*
 * HcrSpatialFOG.cpp
 *
 *  Created on: Jul 18, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#include <cerrno>
#include <sstream>
#include <unistd.h>

#include <EulerPacket.h>
#include <NEDVelocityPacket.h>
#include <SystemStatePacket.h>
#include <logx/Logging.h>

#include "HcrSpatialFog.h"

LOGGING("HcrSpatialFog")

// Report data timeout if bytes are not seen from the device for this
// period.
const float HcrSpatialFog::_DATA_TIMEOUT_SECONDS = 5.0;

HcrSpatialFog::HcrSpatialFog(std::string devName) :
    _devName(devName),
    _ttyFd(-1),
    _fdReader(NULL),
    _dataTimeoutTimer(),
    _devResponsive(false),
    _pktFactory(),
    _fmq(true) {
    // Open a file descriptor to our device, and start a Qt-based threaded
    // reader to read from the fd and publish data via its newData() signal.
    _openTtyFd();
    _fdReader = new FDReader(_ttyFd);

    // Push incoming data to the packet factory, and reset the data timeout
    // timer when new data arrive
    connect(_fdReader, SIGNAL(newData(QByteArray)),
            &_pktFactory, SLOT(appendData(QByteArray)));
    connect(_fdReader, SIGNAL(newData(QByteArray)),
            this, SLOT(_gotBytesFromDevice(QByteArray)));

    // Configure and start the data timeout timer. Call _dataTimeout() upon
    // timer expiration.
    _dataTimeoutTimer.setInterval(int(1000 * _DATA_TIMEOUT_SECONDS));
    connect(&_dataTimeoutTimer, SIGNAL(timeout()),
            this, SLOT(_onDataTimeout()));
    _dataTimeoutTimer.start();

    // Pass packets from the factory to our _packetHandler() slot
    connect(&_pktFactory, SIGNAL(newPacket(AnppPacket *)),
            this, SLOT(_packetHandler(AnppPacket *)));

    // Files of all incoming raw Advanced Navigation Packet Protocol (ANPP)
    // data will be written under this directory if it's not an empty string.
    std::string anppDestDir = "/data/hcr/INS";

    // Create the ANPP destination directory if it doesn't exist
    if (! anppDestDir.empty()) {
        // Attempt to create the destination directory using "mkdir -p"
        std::ostringstream oss;
        oss << "mkdir -p " << anppDestDir;
        FILE * mkdirPipe = popen(oss.str().c_str(), "r");
        if (! mkdirPipe) {
            ELOG << "Unable to execute '" << oss.str() <<
                    "', ANPP files will not be written!";
            anppDestDir = "";
        } else {
            // If "mkdir -p" executes properly, there won't be any output
            char reply[256];
            if (fgets(reply, sizeof(reply), mkdirPipe)) {
                ELOG << "Error creating directory '" << anppDestDir << "': " <<
                        reply;
                // Read the rest of the reply if it's multi-line
                while (fgets(reply, sizeof(reply), mkdirPipe)) {
                    ELOG << "    " << reply;
                }
                // Let them know we won't write ANPP
                ELOG << "ANPP files will not be written!";
                anppDestDir = "";
            }
            // Close the command pipe
            pclose(mkdirPipe);
        }
    }

    // If we still have a ANPP destination directory, open the file where ANPP 
    // data will be written.
    if (! anppDestDir.empty()) {
        std::ostringstream oss;
        QDateTime now = QDateTime::currentDateTimeUtc();
        oss << anppDestDir << "/" <<
                now.toString("yyyyMMdd_hhmmss").toStdString() << ".anpp";
        _anppFile = fopen(oss.str().c_str(), "w+");
    }

}

HcrSpatialFog::~HcrSpatialFog() {
    delete(_fdReader);
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

void
HcrSpatialFog::_gotBytesFromDevice(QByteArray byteArray) {
    if (! _devResponsive) {
        // Mark the device as responsive
        _devResponsive = true;
        // Set responsiveness in the FMQ message
        _fmq.storeInsResponsiveness(_devResponsive);
    }

    // Restart the data timeout timer
    _dataTimeoutTimer.start();
    
    // Archive incoming bytes to the ANPP file if it's open
    if (_anppFile) {
        fwrite(byteArray.data(), byteArray.size(), 1, _anppFile);
    }
}

void
HcrSpatialFog::_onDataTimeout() {
    if (_devResponsive) {
        _devResponsive = false;
        _fmq.storeInsResponsiveness(_devResponsive);
    }

    ELOG << "No data from SpatialFog on " << _devName << " for " <<
            _DATA_TIMEOUT_SECONDS << " s";
}
