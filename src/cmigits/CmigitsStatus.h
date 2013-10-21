/*
 * CmigitsStatus.h
 *
 *  Created on: Aug 14, 2013
 *      Author: burghart
 */

#ifndef CMIGITSSTATUS_H_
#define CMIGITSSTATUS_H_

#include <stdint.h>
#include <boost/serialization/nvp.hpp>
#include <boost/serialization/version.hpp>
#include <xmlrpc-c/base.hpp>
#include "CmigitsSharedMemory.h"

/// @brief Class which encapsulates data from the C-MIGITS.
class CmigitsStatus {
public:
    /// @brief Construct a CmigitsStatus with all zero values.
    CmigitsStatus();

    /// @brief Construct a CmigitsStatus from a xmlrpc_c::value_struct, as
    /// returned by CmigitsStatus::toXmlRpcValue(). This constructor is 
    /// typically used on the client side of an XML-RPC connection, to 
    /// create a clone of a CmigitsStatus on the server side.
    CmigitsStatus(const xmlrpc_c::value_struct & statusDict);

    virtual ~CmigitsStatus();
    
    /// @brief Return a CmigitsStatus populated from current values in 
    /// CmigitsSharedMemory. If there is no process writing to 
    /// CmigitsSharedMemory (e.g., if this method is called on a machine
    /// other than the one where cmigitsDaemon is running), the method
    /// will return a CmigitsStatus created by the default constructor.
    static CmigitsStatus StatusFromSharedMemory();

    /// @brief Return an external representation of the object's state as
    /// an xmlrpc_c::value.
    ///
    /// The returned value can be used on the other side of an XML-RPC
    /// connection to create an identical object via the
    /// CmigitsStatus(const xmlrpc_c::value &) constructor.
    /// @return an external representation of the object's state as
    /// an xmlrpc_c::value.
    xmlrpc_c::value_struct toXmlRpcValue() const;

    /**
     * @brief Return the latest status information from the C-MIGITS
     * (information from the C-MIGITS 3500 message).
     * @param[out] dataTime time of the status data, seconds since 1970-01-01
     * 00:00:00 UTC
     * @param[out] currentMode current C-MIGITS mode
     * @param[out] insAvailable true iff INS data are available
     * @param[out] gpsAvailable true iff GPS time is good and 4 or more
     * satellites are seen
     * @param[out] doingCoarseAlignment true iff C-MIGITS is in "Coarse
     * Alignment" submode
     * @param[out] nSats number of GPS satellites tracked
     * @param[out] positionFOM position figure-of-merit, values 1-9
     * @param[out] velocityFOM velocity figure-of-merit, values 1-9
     * @param[out] headingFOM heading figure-of-merit, values 1-9
     * @param[out] timeFOM time figure-of-merit, values 1-9
     * @param[out] expectedHPosError expected horizontal position error, m
     * @param[out] expectedVPosError expected vertical position error, m
     * @param[out] expectedVelocityError expected velocity error, m/s
     */
    void msg3500Data(double & dataTime, uint16_t & currentMode,
              bool & insAvailable, bool & gpsAvailable,
              bool & doingCoarseAlignment, uint16_t & nSats,
              uint16_t & positionFOM, uint16_t & velocityFOM,
              uint16_t & headingFOM, uint16_t & timeFOM,
              double & expectedHPosError, double & expectedVPosError,
              double & expectedVelocityError) const {
        dataTime = _statusTime;
        currentMode = _currentMode;
        insAvailable = _insAvailable;
        gpsAvailable = _gpsAvailable;
        doingCoarseAlignment = _doingCoarseAlignment;
        nSats = _nSats;
        positionFOM = _positionFOM;
        velocityFOM = _velocityFOM;
        headingFOM = _headingFOM;
        timeFOM = _timeFOM;
        expectedHPosError = _expectedHPosError;
        expectedVPosError = _expectedVPosError;
        expectedVelocityError = _expectedVelocityError;
    }

    /**
     * @brief Return the latest attitude data from the C-MIGITS (information
     * from the C-MIGITS 3512 message)
     * @param[out] dataTime time of the attitude data, seconds since
     * 1970-01-01 00:00:00 UTC
     * @param[out] pitch pitch, deg
     * @param[out] roll roll, deg
     * @param[out] heading heading, deg clockwise from true north
     */
    void msg3512Data(double & dataTime,
            double & pitch, double & roll, double & heading) const {
        dataTime = _attitudeTime;
        pitch = _pitch;
        roll = _roll;
        heading = _heading;
    }

    /**
     * @brief Return the latest navigation solution data from the C-MIGITS
     * (information from the C-MIGITS 3501 message).
     * @param[out] dataTime time of the navigation solution data, seconds since
     * 1970-01-01 00:00:00 UTC
     * @param[out] latitude latitude, deg
     * @param[out] longitude longitude, deg
     * @param[out] altitude altitude, m above MSL
     * @param[out] velNorth north component of velocity, m/s
     * @param[out] velEast east component of velocity, m/s
     * @param[out] velUp upward component of velocity, m/s
     */
    void msg3501Data(double & dataTime,
            double & latitude, double & longitude, double & altitude,
            double & velNorth, double & velEast, double & velUp) const {
        dataTime = _navSolutionTime;
        latitude = _latitude;
        longitude = _longitude;
        altitude = _altitude;
        velNorth = _velNorth;
        velEast = _velEast;
        velUp = _velUp;
    }
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
            ar & BOOST_SERIALIZATION_NVP(_altitude);
            ar & BOOST_SERIALIZATION_NVP(_attitudeTime);
            ar & BOOST_SERIALIZATION_NVP(_currentMode);
            ar & BOOST_SERIALIZATION_NVP(_doingCoarseAlignment);
            ar & BOOST_SERIALIZATION_NVP(_expectedHPosError);
            ar & BOOST_SERIALIZATION_NVP(_expectedVelocityError);
            ar & BOOST_SERIALIZATION_NVP(_expectedVPosError);
            ar & BOOST_SERIALIZATION_NVP(_gpsAvailable);
            ar & BOOST_SERIALIZATION_NVP(_heading);
            ar & BOOST_SERIALIZATION_NVP(_headingFOM);
            ar & BOOST_SERIALIZATION_NVP(_insAvailable);
            ar & BOOST_SERIALIZATION_NVP(_latitude);
            ar & BOOST_SERIALIZATION_NVP(_longitude);
            ar & BOOST_SERIALIZATION_NVP(_navSolutionTime);
            ar & BOOST_SERIALIZATION_NVP(_nSats);
            ar & BOOST_SERIALIZATION_NVP(_pitch);
            ar & BOOST_SERIALIZATION_NVP(_positionFOM);
            ar & BOOST_SERIALIZATION_NVP(_roll);
            ar & BOOST_SERIALIZATION_NVP(_statusTime);
            ar & BOOST_SERIALIZATION_NVP(_timeFOM);
            ar & BOOST_SERIALIZATION_NVP(_velEast);
            ar & BOOST_SERIALIZATION_NVP(_velNorth);
            ar & BOOST_SERIALIZATION_NVP(_velocityFOM);
            ar & BOOST_SERIALIZATION_NVP(_velUp);
        }
        if (version >= 1) {
            // Stuff added for version 1 will go here...
        }
    }

    /// Static connection to the CmigitsSharedMemory segment
    static CmigitsSharedMemory * _Shm;

    /// Time of last status information, seconds since 1970-01-01 00:00:00 UTC.
    /// This time applies to current mode, INS available, GPS available,
    /// position FOM, velocity FOM, heading FOM, time FOM, H position error,
    /// V position error, and velocity error.
    double _statusTime;
    /// Current mode (see documentation for the C-MIGITS 3500 message)
    uint16_t _currentMode;
    /// Number of satellites tracked
    uint16_t _nSats;
    /// INS available
    bool _insAvailable;
    /// GPS available
    bool _gpsAvailable;
    /// Is C-MIGITS currently in "Coarse Alignment" submode?
    bool _doingCoarseAlignment;
    /// position figure of merit (see documentation for the C-MIGITS 3500 message)
    uint16_t _positionFOM;
    /// velocity figure of merit (see documentation for the C-MIGITS 3500 message)
    uint16_t _velocityFOM;
    /// heading figure of merit (see documentation for the C-MIGITS 3500 message)
    uint16_t _headingFOM;
    /// time figure of merit (see documentation for the C-MIGITS 3500 message)
    uint16_t _timeFOM;
    /// expected horizontal position error, m
    double _expectedHPosError;
    /// expected vertical position error, m
    double _expectedVPosError;
    /// expected velocity error, m/s
    double _expectedVelocityError;

    /// Time of last navigation solution, seconds since 1970-01-01 00:00:00 UTC.
    /// This time applies to latitude, longitude, altitude, north velocity
    /// component, east velocity component, and upward velocity component.
    double _navSolutionTime;
    /// latitude, deg
    double _latitude;
    /// longitude, deg
    double _longitude;
    /// altitude, m above MSL
    double _altitude;
    /// north component of velocity, m/s
    double _velNorth;
    /// east component of velocity, m/s
    double _velEast;
    /// upward component of velocity, m/s
    double _velUp;

    /// Time of latest attitude information, seconds since 1970-01-01 00:00:00
    /// UTC. This time applies to pitch, roll, and heading.
    double _attitudeTime;
    /// C-MIGITS latest pitch, deg
    double _pitch;
    /// C-MIGITS latest roll, deg
    double _roll;
    /// C-MIGITS latest heading, deg clockwise from true north
    double _heading;
};

// Increment this class version number and update the serialize method above
// when member variables are changed.
BOOST_CLASS_VERSION(CmigitsStatus, 0)

#endif /* CMIGITSSTATUS_H_ */
