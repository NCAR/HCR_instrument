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

    /// @brief Device/port name for the SpatialFOG
    std::string _devName;

    /// @brief File descriptor for the open device
    int _ttyFd;

    /// @brief File descriptor reader thread
    FDReader * _fdReader;

    /// @brief Factory for AnppPacket objects
    QAnppPacketFactory _pktFactory;

    /// @brief The file message queue (FMQ) where data will be written for
    /// sharing with other processes.
    SpatialFogFmq _fmq;

private slots:
    /// @brief Slot which receives incoming Advanced Navigation Packet Protocol
    /// packets, in the form of ANPPPacket objects.
    void _packetHandler(AnppPacket * pkt);
};

#endif /* _HCRSPATIALFOG_H_ */
