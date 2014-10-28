/*
 * TransmitControlStatus.h
 *
 *  Created on: Oct 28, 2014
 *      Author: burghart
 */

#ifndef TRANSMITCONTROLSTATUS_H_
#define TRANSMITCONTROLSTATUS_H_

#include <boost/serialization/nvp.hpp>
#include <boost/serialization/version.hpp>
#include "TransmitControl.h"

class TransmitControlStatus {
public:
    /// @brief Default constructor.
    TransmitControlStatus();
    
    /// @brief Construct a TransmitControlStatus using data from the given 
    /// TransmitControl
    /// @param tc the TransmitControl object from which to get status
    TransmitControlStatus(const TransmitControl & tc);
    
    /// @brief Construct from an xmlrpc_c::value_struct dictionary as returned
    /// by a call to the TransmitControlStatus::toXmlRpcValue() method.
    /// @param statusDict an xmlrpc_c::value_struct dictionary as returned by 
    /// call to the TransmitControlStatus::toXmlRpcValue() method.
    TransmitControlStatus(xmlrpc_c::value_struct & statusDict);

    virtual ~TransmitControlStatus();

    /// @brief Return an external representation of the object's state as
    /// an xmlrpc_c::value_struct dictionary.
    ///
    /// The returned value can be used on the other side of an XML-RPC
    /// connection to create an identical object via the
    /// XmitStatus(const xmlrpc_c::value_struct &) constructor.
    /// @return an external representation of the object's state as
    /// an xmlrpc_c::value_struct dictionary.
    xmlrpc_c::value_struct toXmlRpcValue() const;
    
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
            ar & BOOST_SERIALIZATION_NVP(_xmitAllowedStatus);
            ar & BOOST_SERIALIZATION_NVP(_attenuationRequired);
        }
        if (version >= 1) {
            // Version 1 stuff will go here...
        }
    }

    /// @brief Is HcrPmc730Daemon currently responsive?
    bool _hcrPmc730Responsive;
    
    /// @brief Is MotionControlDaemon currently responsive?
    bool _motionControlResponsive;
    
    /// @brief Is new data showing up in CmigitsSharedMemory?
    bool _cmigitsResponsive;
    
    /// @brief Is the TerrainHtServer responsive?
    bool _terrainHtServerResponsive;
    
    /// @brief last AGL altitude
    double _aglAltitude;
    
    /// @brief Are we over water?
    bool _overWater;
    
    /// @brief User's intended state for transmitter high voltage
    bool _hvRequested;
    
    /// @brief Current reason for disabling transmit (XMIT_ALLOWED if transmit
    /// is currently allowed)
    TransmitControl::XmitAllowedStatus _xmitAllowedStatus;
    
    /// @brief Is an attenuated receive mode required by current conditions?
    bool _attenuationRequired;
};

#endif /* TRANSMITCONTROLSTATUS_H_ */
