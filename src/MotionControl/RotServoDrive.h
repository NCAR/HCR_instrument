/*
 * RotServoDrive.h
 *
 *  Created on: Aug 5, 2013
 *      Author: burghart
 */

#ifndef ROTSERVODRIVE_H_
#define ROTSERVODRIVE_H_
#include "ElmoServoDrive.h"

/// @brief Class to connect to and control a rotation servo drive at a given
/// CANopen node ID. This is a very thin wrapper around the ElmoServoDrive 
/// class.
class RotServoDrive : public ElmoServoDrive {
public:
    /// Our rotation motor has 400000 encoder counts per full circle
    static const uint32_t ROT_DRIVE_COUNTS_PER_CIRCLE = 400000;
    
    /// Instantiate a connection the HCR rotation servo drive at the given 
    /// CANopen node ID. The drive's nickname will be set to "rotation".
    /// @param nodeId the CANopen node ID of the servo drive
    RotServoDrive(uint8_t nodeId) :
        ElmoServoDrive(nodeId, "rotation", ROT_DRIVE_COUNTS_PER_CIRCLE,
                -30.0, 225.0) {}
    virtual ~RotServoDrive() {}
private:
    std::string _xqInitFunction() const { return("rotInit"); }
    std::string _xqHomingFunction() const { return("rotHoming"); }
};

#endif /* ROTSERVODRIVE_H_ */
