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
 * TiltServoDrive.h
 *
 *  Created on: Aug 5, 2013
 *      Author: burghart
 */

#ifndef TILTSERVODRIVE_H_
#define TILTSERVODRIVE_H_
#include "ElmoServoDrive.h"

/// @brief Class to connect to and control a tilt servo drive at a given
/// CANopen node ID. This is a very thin wrapper around the ElmoServoDrive
/// class.
class TiltServoDrive : public ElmoServoDrive {
public:
    /// Our tilt motor has 480000 encoder counts per full circle
    static const uint32_t COUNTS_PER_CIRCLE = 480000;

    /// Our aft and forward reflector motion limits w.r.t. the home position.
    static constexpr float MIN_LIMIT_DEG = -4.0;
    static constexpr float MAX_LIMIT_DEG = 4.0;

    /// Instantiate a connection to the HCR tilt servo drive via the given
    /// CANopen node ID. The drive's nickname will be set to "tilt".
    /// @param nodeId the CANopen node ID of the servo drive
    TiltServoDrive(uint8_t nodeId) :
        ElmoServoDrive(nodeId, "tilt", COUNTS_PER_CIRCLE,
                       MIN_LIMIT_DEG, MAX_LIMIT_DEG) {}

    /// Instantiate a serial port connection to the HCR tilt servo drive via
    /// the given serial device. The drive's nickname will be set to "tilt".
    /// @param ttyDev the serial device name for the servo drive
    TiltServoDrive(std::string ttyDev) :
        ElmoServoDrive(ttyDev, "tilt", COUNTS_PER_CIRCLE,
                       MIN_LIMIT_DEG, MAX_LIMIT_DEG) {}

    virtual ~TiltServoDrive() {}
private:
    std::string _xqInitFunction() const { return("tiltInit"); }
    std::string _xqHomingFunction() const { return("tiltHoming"); }
};

#endif /* TILTSERVODRIVE_H_ */
