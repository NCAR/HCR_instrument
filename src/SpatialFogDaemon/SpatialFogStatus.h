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
 * SpatialFogStatus.h
 *
 *  Created on: Aug 18, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#ifndef SPATIALFOGSTATUS_H_
#define SPATIALFOGSTATUS_H_

#include <stdint.h>
#include <boost/serialization/nvp.hpp>
#include <boost/serialization/version.hpp>
#include <xmlrpc-c/base.hpp>
#include "SpatialFogFmq.h"

/// @brief Class which encapsulates data from the Spatial FOG INS.
///
/// This class is a very thin wrapper around SpatialFogFmq::MsgStruct which
/// provides serialization to and from xmlrpc_c::value_struct. This in turn
/// allows passing the struct via XML-RPC calls.
class SpatialFogStatus : public SpatialFogFmq::MsgStruct {
public:
    /// @brief Construct a SpatialFogStatus with all zero values.
    SpatialFogStatus();

    /// @brief Construct a SpatialFogStatus from a xmlrpc_c::value_struct, as
    /// returned by SpatialFogStatus::toXmlRpcValue(). This constructor is 
    /// typically used on the client side of an XML-RPC connection, to 
    /// create a clone of a SpatialFogStatus on the server side.
    SpatialFogStatus(const xmlrpc_c::value_struct & statusDict);

    virtual ~SpatialFogStatus();
    
    /// @brief Return a SpatialFogStatus populated from latest values in
    /// SpatialFogFmq. If there is no process writing to SpatialFogFmq (e.g.,
    /// if this method is called on a machine other than the one where
    /// SpatialFogDaemon is running), the method will return a SpatialFogStatus
    /// created by the default constructor.
    static SpatialFogStatus StatusFromFmq();

    /// @brief Return an external representation of the object's state as
    /// an xmlrpc_c::value.
    ///
    /// The returned value can be used on the other side of an XML-RPC
    /// connection to create an identical object via the
    /// SpatialFogStatus(const xmlrpc_c::value &) constructor.
    /// @return an external representation of the object's state as
    /// an xmlrpc_c::value.
    xmlrpc_c::value_struct toXmlRpcValue() const;

    /// @brief Return the value of the given bit in the system status bits.
    /// @param bit the bit number to be examined
    /// @return the value of the given bit in the system status bits.
    bool statusBit(uint8_t bitNum) const { return((statusBits >> bitNum) & 0x1); }

    /// @brief Return true iff the system failure bit is set.
    /// @return true iff the system failure bit is set.
    bool systemFailureBit() const { return(statusBit(0)); }

    /// @brief Return true iff the accelerometer sensor failure bit is set.
    /// @return true iff the accelerometer sensor failure bit is set.
    bool accelerometerFailureBit() const { return(statusBit(1)); }

    /// @brief Return true iff the gyroscope sensor failure bit is set.
    /// @return true iff the gyroscope sensor failure bit is set.
    bool gyroscopeFailureBit() const { return(statusBit(2)); }

    /// @brief Return true iff the magnetometer sensor failure bit is set.
    /// @return true iff the magnetometer sensor failure bit is set.
    bool magnetometerFailureBit() const { return(statusBit(3)); }

    /// @brief Return true iff the pressure sensor failure bit is set.
    /// @return true iff the pressure sensor failure bit is set.
    bool pressureFailureBit() const { return(statusBit(4)); }

    /// @brief Return true iff the GNSS failure bit is set.
    /// @return true iff the GNSS failure bit is set.
    bool gnssFailureBit() const { return(statusBit(5)); }

    /// @brief Return true iff the accelerometer over range bit is set.
    /// @return true iff the accelerometer over range bit is set.
    bool accelerometerOverRangeBit() const { return(statusBit(6)); }

    /// @brief Return true iff the gyroscope over range bit is set.
    /// @return true iff the gyroscope over range bit is set.
    bool gyroscopeOverRangeBit() const { return(statusBit(7)); }

    /// @brief Return true iff the magnetometer over range bit is set.
    /// @return true iff the magnetometer over range bit is set.
    bool magnetometerOverRangeBit() const { return(statusBit(8)); }

    /// @brief Return true iff the pressure over range bit is set.
    /// @return true iff the pressure over range bit is set.
    bool pressureOverRangeBit() const { return(statusBit(9)); }

    /// @brief Return true iff the min temperature alarm bit is set.
    /// @return true iff the min temperature alarm bit is set.
    bool minTempAlarmBit() const { return(statusBit(10)); }

    /// @brief Return true iff the max temperature alarm bit is set.
    /// @return true iff the max temperature alarm bit is set.
    bool maxTempAlarmBit() const { return(statusBit(11)); }

    /// @brief Return true iff the low voltage alarm bit is set.
    /// @return true iff the low voltage alarm bit is set.
    bool lowVoltageAlarmBit() const { return(statusBit(12)); }

    /// @brief Return true iff the high voltage alarm bit is set.
    /// @return true iff the high voltage alarm bit is set.
    bool highVoltageAlarmBit() const { return(statusBit(13)); }

    /// @brief Return true iff the GNSS antenna disconnected bit is set.
    /// @return true iff the GNSS antenna disconnected bit is set.
    bool gnssAntennaDisconnectedBit() const { return(statusBit(14)); }

    /// @brief Return true iff the data output overflow alarm bit is set.
    /// @return true iff the data output overflow alarm bit is set.
    bool dataOutputOverflowBit() const { return(statusBit(15)); }

    /// @brief Return the value of the given bit in the filter status bits.
    /// @param bit the bit number to be examined
    /// @return the value of the given bit in the filter status bits.
    bool filterBit(uint8_t bitNum) const { return((filterBits >> bitNum) & 0x1); }

    /// @brief Return true iff the orientation filter is initialized
    /// @return true iff the orientation filter is initialized
    bool orientationFilterInitialized() const { return(filterBit(0)); }

    /// @brief Return true iff the navigation filter is initialized
    /// @return true iff the navigation filter is initialized
    bool navigationFilterInitialized() const { return(filterBit(1)); }

    /// @brief Return true iff the heading is initialized
    /// @return true iff the heading is initialized
    bool headingInitialized() const { return(filterBit(2)); }

    /// @brief Return true iff UTC time is initialized
    /// @return true iff UTC time is initialized
    bool utcTimeInitialized() const { return(filterBit(3)); }

    /// @brief Return the value (0-7) describing the current GNSS fix.
    ///
    /// Possible values:
    ///     0 - No GNSS fix
    ///     1 - 2D GNSS fix
    ///     2 - 3D GNSS fix
    ///     3 - SBAS GNSS fix
    ///     4 - differential GNSS fix
    ///     5 - Omnistar/Starfire GNSS fix
    ///     6 - RTK float GNSS fix
    ///     7 - RTK fixed GNSS fix
    /// @return Return the value (0-7) describing the current GNSS fix.
    uint16_t gnssFixValue() const {
        return((filterBits >> 4) & 0x7);
    }

    /// @brief Return a string describing the current GNSS fix.
    /// @return a string describing the current GNSS fix.
    const char* gnssFixText() const {
        static const char *fixText[8] {
            "None",
            "2D",
            "3D",
            "SBAS",
            "differential",
            "Omnistar/Starfire",
            "RTK float",
            "RTK fixed"
        };
        return(fixText[gnssFixValue()]);
    }

    /// @brief Return true iff Event 1 occurred
    /// @return true iff Event 1 occurred
    bool event1Occurred() const { return(filterBit(7)); }

    /// @brief Return true iff Event 2 occurred
    /// @return true iff Event 2 occurred
    bool event2Occurred() const { return(filterBit(8)); }

    /// @brief Return true iff internal GNSS is enabled
    /// @return true iff internal GNSS is enabled
    bool internalGnssEnabled() const { return(filterBit(9)); }

    /// @brief Return true iff dual antenna heading is active
    /// @return true iff dual antenna heading is active
    bool dualAntennaHeadingActive() const { return(filterBit(10)); }

    /// @brief Return true iff velocity heading is enabled
    /// @return true iff velocity heading is enabled
    bool velocityHeadingEnabled() const { return(filterBit(11)); }

    /// @brief Return true iff atmospheric altitude is enabled
    /// @return true iff atmospheric altitude is enabled
    bool atmosphericAltitudeEnabled() const { return(filterBit(12)); }

    /// @brief Return true iff external position is active
    /// @return true iff external position is active
    bool externalPositionActive() const { return(filterBit(13)); }

    /// @brief Return true iff external velocity is active
    /// @return true iff external velocity is active
    bool externalVelocityActive() const { return(filterBit(14)); }

    /// @brief Return true iff external heading is active
    /// @return true iff external heading is active
    bool externalHeadingActive() const { return(filterBit(15)); }

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
            ar & BOOST_SERIALIZATION_NVP(writerPid);
            ar & BOOST_SERIALIZATION_NVP(insResponsive);
            ar & BOOST_SERIALIZATION_NVP(statusTime);
            ar & BOOST_SERIALIZATION_NVP(statusBits);
            ar & BOOST_SERIALIZATION_NVP(filterBits);
            ar & BOOST_SERIALIZATION_NVP(positionTime);
            ar & BOOST_SERIALIZATION_NVP(latitude);
            ar & BOOST_SERIALIZATION_NVP(longitude);
            ar & BOOST_SERIALIZATION_NVP(altitude);
            ar & BOOST_SERIALIZATION_NVP(attitudeTime);
            ar & BOOST_SERIALIZATION_NVP(pitch);
            ar & BOOST_SERIALIZATION_NVP(roll);
            ar & BOOST_SERIALIZATION_NVP(heading);
            ar & BOOST_SERIALIZATION_NVP(velTime);
            ar & BOOST_SERIALIZATION_NVP(velNorth);
            ar & BOOST_SERIALIZATION_NVP(velEast);
            ar & BOOST_SERIALIZATION_NVP(velUp);
        }
        if (version >= 1) {
            // Stuff added for version 1 will go here...
        }
    }

    /// Static connection to the SpatialFogSharedMemory segment
    static SpatialFogFmq * _Fmq;

};

// Increment this class version number and update the serialize method above
// when member variables are changed.
BOOST_CLASS_VERSION(SpatialFogStatus, 0)

#endif /* SPATIALFOGSTATUS_H_ */
