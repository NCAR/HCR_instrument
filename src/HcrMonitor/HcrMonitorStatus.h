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
#include <boost/serialization/split_free.hpp>

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
    
    /// @brief Return AGL altitude, meters
    /// @return AGL altitude, meters
    double aglAltitude() const { return(_aglAltitude); }
    
    /// @brief Return true iff current location is over water
    /// @return true iff current location is over water
    bool overWater() const { return(_overWater); }
    
    /// @brief Return true iff a user has requested that high voltage be 
    /// turned on.
    /// @return true iff a user has requested that high voltage be 
    /// turned on.
    bool hvRequested() const { return(_hvRequested); }
    
    /// @brief Return the current allowed/disallowed state for transmitting.
    /// @return the current allowed/disallowed state for transmitting.
    TransmitControl::XmitAllowedStatus xmitAllowedStatus() const { 
        return(_xmitAllowedStatus); 
    }
    
    /// @brief Return a string describing the current allowed/disallowed state 
    /// for transmitting.
    /// @return a string describing the current allowed/disallowed state 
    /// for transmitting.
    std::string xmitAllowedStatusText() const { 
        return(_xmitAllowedStatusText);
    }
    
    /// @brief Return true iff current conditions require operating with an
    /// attenuated receive mode.
    /// @return true iff current conditions require operating with an
    /// attenuated receive mode.
    bool attenuationRequired() const { return(_attenuationRequired); }

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
            ar & BOOST_SERIALIZATION_NVP(_hcrPmc730Responsive);
            ar & BOOST_SERIALIZATION_NVP(_motionControlResponsive);
            ar & BOOST_SERIALIZATION_NVP(_cmigitsResponsive);
            ar & BOOST_SERIALIZATION_NVP(_terrainHtServerResponsive);
            ar & BOOST_SERIALIZATION_NVP(_aglAltitude);
            ar & BOOST_SERIALIZATION_NVP(_overWater);
            ar & BOOST_SERIALIZATION_NVP(_hvRequested);
            ar & BOOST_SERIALIZATION_NVP(_xmitAllowedStatusText);
            ar & BOOST_SERIALIZATION_NVP(_attenuationRequired);
            
            // KLUGE: special handling for members with enumerated types. We 
            // explicitly cast to int when saving to an output stream, and 
            // explicitly cast back to the desired enum when loading from an 
            // input stream. It is hoped that later improvements in the
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
            
            // _xmitAllowedStatus
            {
                // Before output, convert _xmitAllowedState to an int
                int intXmitAllowedStatus = static_cast<int>(_xmitAllowedStatus);
                // This will save intControlState on output or load a value 
                // there on input.
                ar & BOOST_SERIALIZATION_NVP(intXmitAllowedStatus);
                // After input, convert the loaded int back to ApsControl::ValveControlState
                _xmitAllowedStatus = 
                        static_cast<TransmitControl::XmitAllowedStatus>(intXmitAllowedStatus);
            }
            
        }
        if (version >= 1) {
            // Version 1 stuff will go here...
        }
    }

    /// @brief APS valve control state: automatic, always open, or always closed
    ApsControl::ValveControlState _apsValveControlState;
    
    bool _hcrPmc730Responsive;
    bool _motionControlResponsive;
    bool _cmigitsResponsive;
    bool _terrainHtServerResponsive;
    double _aglAltitude;
    bool _overWater;
    bool _hvRequested;
    TransmitControl::XmitAllowedStatus _xmitAllowedStatus;
    std::string _xmitAllowedStatusText;
    bool _attenuationRequired;
    
};

// Increment this class version number when member variables are changed.
BOOST_CLASS_VERSION(HcrMonitorStatus, 0)

#endif /* HCRMONITORSTATUS_H_ */