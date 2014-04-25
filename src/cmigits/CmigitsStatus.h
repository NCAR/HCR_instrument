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
     * @param[out] time3500 time of the status data, seconds since 1970-01-01
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
    void msg3500Data(double & time3500, uint16_t & currentMode,
              bool & insAvailable, bool & gpsAvailable,
              bool & doingCoarseAlignment, uint16_t & nSats,
              uint16_t & positionFOM, uint16_t & velocityFOM,
              uint16_t & headingFOM, uint16_t & timeFOM,
              double & expectedHPosError, double & expectedVPosError,
              double & expectedVelocityError) const {
        time3500 = _time3500;
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

    /// @brief Return the time of the last 3500 message, seconds since
    /// 1970-01-01 00:00:00 UTC.
    /// @return the time of the last 3500 message, seconds since
    /// 1970-01-01 00:00:00 UTC.
    double time3500() const { return(_time3500); }
    
    /// @brief Return the current mode.
    /// @return the current mode.
    uint16_t currentMode() const { return(_currentMode); }
    
    /// @brief Return true iff C-MIGITS reports INS is available.
    /// @return true iff C-MIGITS reports INS is available.
    bool insAvailable() const { return(_insAvailable); }
    
    /// @brief Return true iff C-MIGITS reports GPS time is good and 4 or more
    /// satellites are seen.
    /// @return true iff C-MIGITS reports GPS time is good and 4 or more
    /// satellites are seen.
    bool gpsAvailable() const { return(_gpsAvailable); }
    
    /// @brief Return true iff C-MIGITS is in coarse alignment submode.
    /// @return true iff C-MIGITS is in coarse alignment submode.
    bool doingCoarseAlignment() const { return(_doingCoarseAlignment); }
    
    /// @brief Return the number of GPS satellites used for the last navigation
    /// solution.
    /// @return the number of GPS satellites used for the last navigation
    /// solution.
    uint16_t nSats() const { return(_nSats); }
    
    /// @brief Return the position figure-of-merit, values 1-9.
    /// @return the position figure-of-merit, values 1-9.
    uint16_t positionFOM() const { return(_positionFOM); }

    /// @brief Return the velocity figure-of-merit, values 1-9.
    /// @return the velocity figure-of-merit, values 1-9.
    uint16_t velocityFOM() const { return(_velocityFOM); }

    /// @brief Return the heading figure-of-merit, values 1-9.
    /// @return the heading figure-of-merit, values 1-9.
    uint16_t headingFOM() const { return(_headingFOM); }

    /// @brief Return the time figure-of-merit, values 1-9.
    /// @return the time figure-of-merit, values 1-9.
    uint16_t timeFOM() const { return(_timeFOM); }
    
    /// @brief Return the expected horizontal position error, m.
    /// @return the expected horizontal position error, m.
    double expectedHPosError() const { return(_expectedHPosError); }

    /// @brief Return the expected vertical position error, m.
    /// @return the expected vertical position error, m.
    double expectedVPosError() const { return(_expectedVPosError); }

    /// @brief Return the expected velocity error, m/s.
    /// @return the expected velocity error, m/s.
    double expectedVelocityError() const { return(_expectedVelocityError); }

    /**
     * @brief Return the latest attitude data from the C-MIGITS (information
     * from the C-MIGITS 3512 message)
     * @param[out] time3512 time of the attitude data, seconds since
     * 1970-01-01 00:00:00 UTC
     * @param[out] pitch pitch, deg
     * @param[out] roll roll, deg
     * @param[out] heading heading, deg clockwise from true north
     * @param[out] velNorth north component of velocity, m/s
     * @param[out] velEast east component of velocity, m/s
     * @param[out] velUp upward component of velocity, m/s
     */
    void msg3512Data(double & time3512,
            double & pitch, double & roll, double & heading,
            double & velNorth, double & velEast, double & velUp) const {
        time3512 = _time3512;
        pitch = _pitch;
        roll = _roll;
        heading = _heading;
        velNorth = _velNorth;
        velEast = _velEast;
        velUp = _velUp;
    }
    
    /// @brief Return the time of the last 3512 message, seconds since 
    /// 1970-01-01 00:00:00 UTC.
    /// @return the time of the last 3512 message, seconds since 
    /// 1970-01-01 00:00:00 UTC.
    double time3512() const { return(_time3512); }
    
    /// @brief Return the pitch, deg.
    /// @return the pitch, deg.
    double pitch() const { return(_pitch); }
    
    /// @brief Return the roll, deg.
    /// @return the roll, deg.
    double roll() const { return(_roll); }
    
    /// @brief Return the true heading, deg.
    /// @return the true heading, deg.
    double heading() const { return(_heading); }
    
    /// @brief Return the north component of velocity, m/s.
    /// @return the north component of velocity, m/s.
    double velNorth() const { return(_velNorth); }
    
    /// @brief Return the east component of velocity, m/s.
    /// @return the east component of velocity, m/s.
    double velEast() const { return(_velEast); }
    
    /// @brief Return the upward component of velocity, m/s.
    /// @return the upward component of velocity, m/s.
    double velUp() const { return(_velUp); }
    
    /**
     * @brief Return the latest navigation solution data from the C-MIGITS
     * (information from the C-MIGITS 3501 message).
     * @param[out] time3501 time of the navigation solution data, seconds since
     * 1970-01-01 00:00:00 UTC
     * @param[out] latitude latitude, deg
     * @param[out] longitude longitude, deg
     * @param[out] altitude altitude, m above MSL
     */
    void msg3501Data(double & time3501,
            double & latitude, double & longitude, double & altitude) const {
        time3501 = _time3501;
        latitude = _latitude;
        longitude = _longitude;
        altitude = _altitude;
    }
    
    /// @brief Return the time of the last 3501 message, seconds since 
    /// 1970-01-01 00:00:00 UTC.
    /// @return the time of the last 3501 message, seconds since 
    /// 1970-01-01 00:00:00 UTC.
    double time3501() const { return(_time3501); }
    
    /// @brief Return the latitude, deg.
    /// @return the latitude, deg.
    double latitude() const { return(_latitude); }

    /// @brief Return the longitude, deg.
    /// @return the longitude, deg.
    double longitude() const { return(_longitude); }

    /// @brief Return the altitude, m above MSL.
    /// @return the altitude, m above MSL.
    double altitude() const { return(_altitude); }

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
            ar & BOOST_SERIALIZATION_NVP(_time3512);
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
            ar & BOOST_SERIALIZATION_NVP(_time3501);
            ar & BOOST_SERIALIZATION_NVP(_nSats);
            ar & BOOST_SERIALIZATION_NVP(_pitch);
            ar & BOOST_SERIALIZATION_NVP(_positionFOM);
            ar & BOOST_SERIALIZATION_NVP(_roll);
            ar & BOOST_SERIALIZATION_NVP(_time3500);
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
    double _time3500;
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
    double _time3501;
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
    double _time3512;
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
