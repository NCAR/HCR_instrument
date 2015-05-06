/*
 * HcrMonitorStatus.h
 *
 *  Created on: Oct 27, 2014
 *      Author: burghart
 */

#ifndef HCRMONITORSTATUS_H_
#define HCRMONITORSTATUS_H_

#include <string>
#include <iostream>
#include <stdint.h>
#include <xmlrpc-c/base.hpp>
#include <boost/serialization/nvp.hpp>
#include <boost/serialization/version.hpp>

#include "ApsControl.h"
#include "TransmitControl.h"

/// @brief Class to represent HCR digital receiver/remote data system status.
class HcrMonitorStatus {
public:
    /// @brief Default constructor. Integer fields are set to -99.
    HcrMonitorStatus();

    /// @brief Construct a HcrMonitorStatus using data from the given 
    /// ApsControl and TransmitControl
    /// @param apsControl the ApsControl object from which to get status
    /// @param transmitControl the TransmitControl object from which to get 
    /// status
    HcrMonitorStatus(const ApsControl & apsControl, 
            const TransmitControl & transmitControl);

    /// @brief Construct from an xmlrpc_c::value_struct dictionary as returned
    /// by a call to the HcrMonitorStatus::toXmlRpcValue() method.
    /// @param statusDict an xmlrpc_c::value_struct dictionary as returned by 
    /// call to the HcrMonitorStatus::toXmlRpcValue() method.
    HcrMonitorStatus(xmlrpc_c::value_struct & statusDict);

    virtual ~HcrMonitorStatus();

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
    /// cmigitsDaemon.
    /// @return true iff TransmitControl is getting responses from
    /// cmigitsDaemon.
    bool cmigitsResponsive() const { return(_cmigitsResponsive); }

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
    
    /// @brief Return the requested HMC mode.
    /// @return the requested HMC mode.
    HcrPmc730::HmcOperationMode requestedHmcMode() const { return(_requestedHmcMode); }
    
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

    /// @brief Return the time HcrMonitor last forced HV off because of high
    /// max received power, seconds since 1970-01-01 00:00:00 UTC
    double timeOfLastHvOffForHighPower() const { return(_timeOfLastHvOffForHighPower); }

    /// @brief Return a string with details of why HcrMonitor last forced HV off
    /// because of high max received power
    std::string detailsForLastHvOffForHighPower() const {
        return(_detailsForLastHvOffForHighPower);
    }

private:
    friend class boost::serialization::access;
    
    /// @brief Serialize our members to a boost save (output) archive or populate
    /// our members from a boost load (input) archive.
    /// @param ar the archive to load from or save to.
    /// @param version the version 
    template<class Archive>
    void serialize(Archive & ar, const unsigned int version) {
        using boost::serialization::make_nvp;
        // Version 0 (see BOOST_CLASS_VERSION macro below for latest version) 
        if (version >= 0) {
            // Map named entries to our member variables using serialization's
            // name/value pairs (nvp).
            ar & BOOST_SERIALIZATION_NVP(_apsStatusText);
            ar & BOOST_SERIALIZATION_NVP(_hcrPmc730Responsive);
            ar & BOOST_SERIALIZATION_NVP(_motionControlResponsive);
            ar & BOOST_SERIALIZATION_NVP(_cmigitsResponsive);
            ar & BOOST_SERIALIZATION_NVP(_terrainHtServerResponsive);
            ar & BOOST_SERIALIZATION_NVP(_mslAltitude);
            ar & BOOST_SERIALIZATION_NVP(_aglAltitude);
            ar & BOOST_SERIALIZATION_NVP(_overWater);
            ar & BOOST_SERIALIZATION_NVP(_meanMaxPower);
            ar & BOOST_SERIALIZATION_NVP(_hvRequested);
            ar & BOOST_SERIALIZATION_NVP(_xmitTestStatusText);
            ar & BOOST_SERIALIZATION_NVP(_transmitAllowed);
            ar & BOOST_SERIALIZATION_NVP(_attenuationRequired);
            ar & BOOST_SERIALIZATION_NVP(_timeOfLastHvOffForHighPower);
            ar & BOOST_SERIALIZATION_NVP(_detailsForLastHvOffForHighPower);
            
            // KLUGE: special handling for members with enumerated types. We 
            // explicitly cast to int when saving to an output archive, and 
            // explicitly cast back to the desired enum when loading from an 
            // input archive. It is hoped that later improvements in the
            // Archive_xmlrpc_c classes will remove the need for this...
            
            // _apsValveControlState
            {
                // For output, convert _apsValveControlState to an int
                int intValveControlState = static_cast<int>(_apsValveControlState);
                // This will save intControlState on output or load a value 
                // there on input.
                ar & BOOST_SERIALIZATION_NVP(intValveControlState);
                // On input, convert the loaded int back to ApsControl::ValveControlState
                _apsValveControlState = 
                        static_cast<ApsControl::ValveControlState>(intValveControlState);
            }
            
            // _requestedHmcMode
            {
                // Before output, convert _requestedHmcMode to an int
                int intRequestedHmcMode = static_cast<int>(_requestedHmcMode);
                // This will save intControlState on output or load a value 
                // there on input.
                ar & BOOST_SERIALIZATION_NVP(intRequestedHmcMode);
                // After input, convert the loaded int back to HcrPmc730::HmcOperationMode
                _requestedHmcMode = 
                        static_cast<HcrPmc730::HmcOperationMode>(intRequestedHmcMode);
            }
            
            // _xmitTestStatus
            {
                // Before output, convert _xmitTestStatus to an int
                int intXmitTestStatus = static_cast<int>(_xmitTestStatus);
                // This will save intXmitTestStatus on output or load a value 
                // there on input.
                ar & BOOST_SERIALIZATION_NVP(intXmitTestStatus);
                // After input, convert the loaded int back to TransmitControl::XmitTestStatus
                _xmitTestStatus = 
                        static_cast<TransmitControl::XmitTestStatus>(intXmitTestStatus);
            }
            
        }
        if (version >= 1) {
            // Version 1 stuff will go here...
        }
    }

    /// @brief APS valve control state: automatic, always open, or always closed
    ApsControl::ValveControlState _apsValveControlState;
    
    /// @brief APS status text
    std::string _apsStatusText;
    
    /// @brief Is HcrPmc730Daemon responsive?
    bool _hcrPmc730Responsive;
    
    /// @brief Is MotionControlDaemon responsive?
    bool _motionControlResponsive;
    
    /// @brief Is cmigitsDaemon responsive?
    bool _cmigitsResponsive;
    
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
    
    /// @brief Requested HMC mode
    HcrPmc730::HmcOperationMode _requestedHmcMode;
    
    /// @brief Has a user requested that transmitter high voltage be turned on?
    bool _hvRequested;
    
    /// @brief Current allowed/disallowed status for transmitting
    TransmitControl::XmitTestStatus _xmitTestStatus;
    
    /// @brief Text describing the currend allowed/disallowed status for 
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
BOOST_CLASS_VERSION(HcrMonitorStatus, 0)

#endif /* HCRMONITORSTATUS_H_ */
