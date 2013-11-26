/*
 * TiltServoDrive.h
 *
 *  Created on: Aug 5, 2013
 *      Author: burghart
 */

#ifndef TILTSERVODRIVE_H_
#define TILTSERVODRIVE_H_
#include "ElmoServoDrive.h"

/// @brief Class to connect to and control a tilt servo drive on a given
/// serial port. This is a very thin wrapper around the ElmoServoDrive class.
class TiltServoDrive : public ElmoServoDrive {
public:
    /**
     * Instantiate a connection to a tilt servo drive on the named serial
     * device. The drive's nickname will be set to "tilt".
     * @param ttyDev the name serial port device connected to the tilt drive
     */
    TiltServoDrive(const std::string ttyDev) :
        ElmoServoDrive(ttyDev, "tilt") {}
    virtual ~TiltServoDrive() {}
private:
    std::string _xqInitFunction() const { return("tiltInit"); }
    std::string _xqHomingFunction() const { return("tiltHoming"); }
};

#endif /* TILTSERVODRIVE_H_ */
