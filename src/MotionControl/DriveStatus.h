/*
 * DriveStatus.h
 *
 *  Created on: July 10, 2013
 *      Author: burghart
 */

#ifndef DRIVESTATUS_H_
#define DRIVESTATUS_H_

#include <Archive_xmlrpc_c.h>
#include <boost/serialization/nvp.hpp>
#include <boost/serialization/version.hpp>

#include "ElmoServoDrive.h"

/// @brief Class to represent HCR antenna drive status.
class DriveStatus {
public:
    /// @brief Construct status using values obtained from the given drives.
	/// @param rotDrive the rotation drive
	/// @param tiltDrive the tilt drive
    DriveStatus(const ElmoServoDrive & rotDrive, const ElmoServoDrive & tiltDrive);

    /// @brief Construct from an xmlrpc_c::value_struct dictionary as returned
    /// by a call to the DriveStatus::to_value_struct() method.
    /// @param statusDict an xmlrpc_c::value_struct dictionary as returned by a
    /// call to the DriveStatus::to_value_struct() method.
    DriveStatus(xmlrpc_c::value_struct & statusDict);

    virtual ~DriveStatus();

    /// @brief Return an external representation of the object's state as
    /// an xmlrpc_c::value_struct dictionary.
    ///
    /// The returned value can be used on the other side of an XML-RPC
    /// connection to create an identical object via the
    /// XmitStatus(const xmlrpc_c::value_struct &) constructor.
    /// @return an external representation of the object's state as
    /// an xmlrpc_c::value_struct dictionary.
    xmlrpc_c::value_struct to_value_struct() const;

    /**
     * @brief Return true iff the tilt drive is currently responding.
     * @return true iff the tilt drive is currently responding.
     */
    bool tiltDriveResponding() const { return(_tiltDriveResponding); }

    /**
     * @brief Return true iff the tilt drive is currently responding.
     * @return true iff the tilt drive is currently responding.
     */
    bool rotDriveResponding() const { return(_rotDriveResponding); }

    /**
     * @brief Return the tilt drive temperature, deg C.
     * @return the tilt drive temperature, deg C.
     */
    int tiltDriveTemp() const { return(_tiltDriveTemp); }

    /**
     * @brief Return the rotation drive temperature, deg C.
     * @return the rotation drive temperature, deg C.
     */
    int rotDriveTemp() const { return(_rotDriveTemp); }
private:
    
    friend class boost::serialization::access;
    /**
     * @brief Serialize our members to a boost save (output) archive or populate
     * our members from a boost load (input) archive.
     * @param ar the archive to load from or save to.
     * @param version the version 
     */
    template<class Archive>
    void serialize(Archive & ar, const unsigned int version) {
        using boost::serialization::make_nvp;
        // Version 0 (see BOOST_CLASS_VERSION macro below for latest version) 
        if (version >= 0) {
            // Map named entries to our member variables using serialization's
            // name/value pairs (nvp).
            ar & BOOST_SERIALIZATION_NVP(_rotDriveResponding);
            ar & BOOST_SERIALIZATION_NVP(_rotDriveTemp);
            ar & BOOST_SERIALIZATION_NVP(_tiltDriveResponding);
            ar & BOOST_SERIALIZATION_NVP(_tiltDriveTemp);
        }
        if (version >= 1) {
            // Version 1 stuff will go here...
        }
    }

    /// Is the rotation drive responding?
    bool _rotDriveResponding;
    /// Rotation drive temperature, deg C
    int _rotDriveTemp;

    /// Is the tilt drive responding?
    bool _tiltDriveResponding;
    /// Tilt drive temperature, deg C
    int _tiltDriveTemp;

};

// Increment this class version number when member variables are changed.
BOOST_CLASS_VERSION(DriveStatus, 0)

#endif /* DRIVESTATUS_H_ */
