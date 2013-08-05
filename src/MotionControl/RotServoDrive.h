/*
 * RotServoDrive.h
 *
 *  Created on: Aug 5, 2013
 *      Author: burghart
 */

#ifndef ROTSERVODRIVE_H_
#define ROTSERVODRIVE_H_
#include "ElmoServoDrive.h"

/// @brief Class to connect to and control a rotation servo drive on a given
/// serial port. This is a very thin wrapper around the ElmoServoDrive class.
class RotServoDrive : public ElmoServoDrive {
public:
    /**
     * Instantiate a connection to a rotation servo drive on the named serial
     * device. The drive's nickname will be set to "rotation".
     * @param ttyDev the name serial port device connected to the rotation drive
     * @param driveName nickname used for the drive in log messages
     */
    RotServoDrive(const std::string ttyDev) :
        ElmoServoDrive(ttyDev, "rotation") {}
    virtual ~RotServoDrive() {}
private:
    std::string _xqInitFunction() const { return("rotInit"); }
    std::string _xqHomingFunction() const { return("rotHoming"); }
};

#endif /* ROTSERVODRIVE_H_ */
