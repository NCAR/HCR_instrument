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
    static const uint32_t TILT_DRIVE_COUNTS_PER_CIRCLE = 480000;
    
    /// Instantiate a connection to the HCR tilt servo drive at the given 
    /// CANopen node ID. The drive's nickname will be set to "tilt".
    /// @param nodeId the CANopen node ID of the servo drive
    TiltServoDrive(uint8_t nodeId) :
        ElmoServoDrive(nodeId, "tilt", TILT_DRIVE_COUNTS_PER_CIRCLE, 
                -4.0, 4.0) {}
    virtual ~TiltServoDrive() {}
private:
    std::string _xqInitFunction() const { return("tiltInit"); }
    std::string _xqHomingFunction() const { return("tiltHoming"); }
};

#endif /* TILTSERVODRIVE_H_ */
