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
 * HcrExecutiveStatus.h
 *
 *  Created on: Oct 27, 2014
 *      Author: burghart
 */

#ifndef HCREXECUTIVESTATUS_H_
#define HCREXECUTIVESTATUS_H_

#include <string>
#include <sstream>
#include <iostream>
#include <stdint.h>
#include <xmlrpc-c/base.hpp>
#include <boost/serialization/nvp.hpp>
#include <boost/serialization/version.hpp>

#include "ApsControl.h"
#include "TransmitControl.h"

/// @brief Class to represent HCR digital receiver/remote data system status.
class HcrExecutiveStatus {
public:
    /// @brief Default constructor. Integer fields are set to -99.
    HcrExecutiveStatus();

    /// @brief Construct a HcrExecutiveStatus using data from the given 
    /// ApsControl and TransmitControl
    /// @param apsControl the ApsControl object from which to get status
    /// @param transmitControl the TransmitControl object from which to get 
    /// status
    HcrExecutiveStatus(const ApsControl & apsControl, 
            const TransmitControl & transmitControl);

    /// @brief Construct from an xmlrpc_c::value_struct dictionary as returned
    /// by a call to the HcrExecutiveStatus::toXmlRpcValue() method.
    /// @param statusDict an xmlrpc_c::value_struct dictionary as returned by 
    /// call to the HcrExecutiveStatus::toXmlRpcValue() method.
    HcrExecutiveStatus(xmlrpc_c::value_struct & statusDict);

    virtual ~HcrExecutiveStatus();

    /// @brief Return an external representation of the object's state as
    /// an xmlrpc_c::value_struct dictionary.
    ///
    /// The returned value can be used on the other side of an XML-RPC
    /// connection to create an identical object via the
    /// XmitStatus(const xmlrpc_c::value_struct &) constructor.
    /// @return an external representation of the object's state as
    /// an xmlrpc_c::value_struct dictionary.
    xmlrpc_c::value_struct toXmlRpcValue() const;

    /// @brief Return the APS valve control state
    /// @return the APS valve control state
    ApsControl::ValveControlState apsValveControlState() const { 
        return(_apsValveControlState);
    }

    /// @brief Return APS status text.
    /// @return APS status text.
    std::string apsStatusText() const { return(_apsStatusText); }

    /// @brief Return true iff TransmitControl is getting responses from
    /// HcrPmc730Daemon.
    /// @return true iff TransmitControl is getting responses from
    /// HcrPmc730Daemon.
    bool hcrPmc730Responsive() const { return(_hcrPmc730Responsive); }

    /// @brief Return true iff TransmitControl is getting responses from
    /// MotionControlDaemon.
    /// @return true iff TransmitControl is getting responses from
    /// MotionControlDaemon.
    bool motionControlResponsive() const { return(_motionControlResponsive); }

    /// @brief Return true iff TransmitControl is getting responses from
    /// the daemon for the INS in use.
    /// @return true iff TransmitControl is getting responses from
    /// the daemon for the INS in use.
    bool insResponsive() const { return(_insResponsive); }

    /// @brief Return true iff TransmitControl is getting responses from
    /// TerrainHtServer.
    /// @return true iff TransmitControl is getting responses from
    /// TerrainHtServer.
    bool terrainHtServerResponsive() const { return(_terrainHtServerResponsive); }

    /// @brief Return MSL altitude, meters
    /// @return MSL altitude, meters
    double mslAltitude() const { return(_mslAltitude); }

    /// @brief Return AGL altitude, meters
    /// @return AGL altitude, meters
    double aglAltitude() const { return(_aglAltitude); }

    /// @brief Return true iff current location is over water
    /// @return true iff current location is over water
    bool overWater() const { return(_overWater); }

    /// @brief Return the maximum received power, dBm
    /// @return the maximum received power, dBm
    double meanMaxPower() const { return(_meanMaxPower); }

    /// @brief Return the requested Operation mode.
    /// @return the requested Operation mode.
    HcrPmc730::OperationMode requestedOperationMode() const { return(_requestedOperationMode); }

    /// @brief Return true iff a user has requested that high voltage be 
    /// turned on.
    /// @return true iff a user has requested that high voltage be 
    /// turned on.
    bool hvRequested() const { return(_hvRequested); }

    /// @brief Return the current allowed/disallowed state for transmitting.
    /// @return the current allowed/disallowed state for transmitting.
    TransmitControl::XmitTestStatus xmitAllowedStatus() const { 
        return(_xmitTestStatus); 
    }

    /// @brief Return a string describing the current allowed/disallowed state 
    /// for transmitting.
    /// @return a string describing the current allowed/disallowed state 
    /// for transmitting.
    std::string xmitAllowedStatusText() const { 
        return(_xmitTestStatusText);
    }

    /// @brief Return true iff current conditions allow for transmit
    /// @return true iff current conditions allow for transmit
    bool transmitAllowed() const { return(_transmitAllowed); }

    /// @brief Return true iff current conditions require operating with an
    /// attenuated receive mode.
    /// @return true iff current conditions require operating with an
    /// attenuated receive mode.
    bool attenuationRequired() const { return(_attenuationRequired); }

    /// @brief Return the time HcrExecutive last forced HV off because of high
    /// max received power, seconds since 1970-01-01 00:00:00 UTC
    double timeOfLastHvOffForHighPower() const { return(_timeOfLastHvOffForHighPower); }

    /// @brief Return a string with details of why HcrExecutive last forced HV off
    /// because of high max received power
    std::string detailsForLastHvOffForHighPower() const {
        return(_detailsForLastHvOffForHighPower);
    }

    /// Current version of the XmitStatus class. This MUST be incremented if
    /// any change is made to contents handled by serialize() below.
    static const unsigned int STATUS_VERSION = 1;
private:
    friend class boost::serialization::access;

    /// @brief Serialize our members to a boost save (output) archive or populate
    /// our members from a boost load (input) archive.
    /// @param ar the archive to load from or save to.
    /// @param version the version 
    template<class Archive>
    void serialize(Archive & ar, const unsigned int version) {
        // When unmarshalling, only the current HcrExecutiveStatus version is
        // supported.
        if (version != STATUS_VERSION) {
            std::ostringstream oss;
            oss << "HcrExecutiveStatus::serialize cannot handle version " <<
                   version << "; only version " << STATUS_VERSION <<
                   " is supported.";
            throw(std::runtime_error(oss.str()));
            abort();
        }

        // Map named entries to our member variables using serialization's
        // name/value pairs (nvp). If anything is changed in this section, be
        // sure to increment the version number in STATUS_VERSION above.
        ar & BOOST_SERIALIZATION_NVP(_apsValveControlState);
        ar & BOOST_SERIALIZATION_NVP(_apsStatusText);
        ar & BOOST_SERIALIZATION_NVP(_hcrPmc730Responsive);
        ar & BOOST_SERIALIZATION_NVP(_hcrPmc730Status);
        ar & BOOST_SERIALIZATION_NVP(_motionControlResponsive);
        ar & BOOST_SERIALIZATION_NVP(_motionControlStatus);
        ar & BOOST_SERIALIZATION_NVP(_insInUse);
        ar & BOOST_SERIALIZATION_NVP(_insResponsive);
        ar & BOOST_SERIALIZATION_NVP(_terrainHtServerResponsive);
        ar & BOOST_SERIALIZATION_NVP(_mslAltitude);
        ar & BOOST_SERIALIZATION_NVP(_aglAltitude);
        ar & BOOST_SERIALIZATION_NVP(_overWater);
        ar & BOOST_SERIALIZATION_NVP(_meanMaxPower);
        ar & BOOST_SERIALIZATION_NVP(_requestedOperationMode);
        ar & BOOST_SERIALIZATION_NVP(_hvRequested);
        ar & BOOST_SERIALIZATION_NVP(_xmitTestStatus);
        ar & BOOST_SERIALIZATION_NVP(_xmitTestStatusText);
        ar & BOOST_SERIALIZATION_NVP(_transmitAllowed);
        ar & BOOST_SERIALIZATION_NVP(_attenuationRequired);
        ar & BOOST_SERIALIZATION_NVP(_timeOfLastHvOffForHighPower);
        ar & BOOST_SERIALIZATION_NVP(_detailsForLastHvOffForHighPower);
    }

    /// @brief APS valve control state: automatic, always open, or always closed
    ApsControl::ValveControlState _apsValveControlState;

    /// @brief APS status text
    std::string _apsStatusText;

    /// @brief Is HcrPmc730Daemon responsive?
    bool _hcrPmc730Responsive;

    /// @brief Latest HcrPmc730 status
    HcrPmc730Status _hcrPmc730Status;

    /// @brief Is MotionControlDaemon responsive?
    bool _motionControlResponsive;

    /// @brief Latest MotionControl status
    MotionControl::Status _motionControlStatus;

    /// @brief The INS currently in use (either 1 or 2)
    int _insInUse;

    /// @brief Is the daemon for the "INS in use" responsive?
    bool _insResponsive;

    /// @brief Is TerrainHtServer responsive?
    bool _terrainHtServerResponsive;

    /// @brief Latest MSL altitude, m
    double _mslAltitude;

    /// @brief Latest AGL altitude, m
    double _aglAltitude;

    /// @brief Are we over water?
    bool _overWater;

    /// @brief Max received power, dBm
    double _meanMaxPower;

    /// @brief Requested Operation mode
    HcrPmc730::OperationMode _requestedOperationMode;

    /// @brief Has a user requested that transmitter high voltage be turned on?
    bool _hvRequested;

    /// @brief Current allowed/disallowed status for transmitting
    TransmitControl::XmitTestStatus _xmitTestStatus;

    /// @brief Text describing the current allowed/disallowed status for 
    /// transmitting
    std::string _xmitTestStatusText;

    /// @brief Is transmit currently allowed?
    bool _transmitAllowed;

    /// @brief Do we currently need to receive using an attenuated mode?
    bool _attenuationRequired;

    /// @brief Time high voltage was last forced off because of high max power,
    /// seconds since 1970-01-01 00:00:00 UTC, or zero if HV has not been forced off.
    double _timeOfLastHvOffForHighPower;

    /// @brief String describing details of the last time high voltage was
    /// forced off because of high max power.
    std::string _detailsForLastHvOffForHighPower;
};

// Increment this class version number when member variables are changed.
BOOST_CLASS_VERSION(HcrExecutiveStatus, HcrExecutiveStatus::STATUS_VERSION)

#endif /* HCREXECUTIVESTATUS_H_ */
