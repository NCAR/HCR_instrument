/*
 * HcrMonitorStatus.h
 *
 *  Created on: Oct 27, 2014
 *      Author: burghart
 */

#ifndef HCRMONITORSTATUS_H_
#define HCRMONITORSTATUS_H_

#include <exception>
#include <string>
#include <numeric>
#include <stdint.h>
#include <xmlrpc-c/base.hpp>
#include <boost/serialization/nvp.hpp>
#include <boost/serialization/version.hpp>

class ApsControl;
class TransmitControl;

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

    /// @brief Return the signal processing FPGA temperature from the Pentek
    /// card, deg C
    /// @return the signal processing FPGA temperature from the Pentek
    /// card, deg C
    int pentekFpgaTemp() const { return(_pentekFpgaTemp); }
    
    /// @brief Return the PCB temperature from the Pentek card, deg C
    /// @return the PCB temperature from the Pentek card, deg C
    int pentekBoardTemp() const { return(_pentekBoardTemp); }
    
    /// @brief Return the number of gates being sampled
    /// @return the number of gates being sampled
    uint16_t nGates() const { return(_nGates); }
    
    /// @brief Return the PRT (pulse repetition time), s
    /// @return the PRT (pulse repetition time), s
    double prt() const { return(_prt); }
    
    /// @brief Return the gate spacing, m
    /// @return the gate spacing, m
    double gateSpacing() const { return(_gateSpacing); }
    
    /// @brief Return the transmitter pulse width, s
    /// @return the transmitter pulse width, s
    double xmitPulseWidth() const { return(_xmitPulseWidth); }
    
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
            ar & BOOST_SERIALIZATION_NVP(_pentekBoardTemp);
            ar & BOOST_SERIALIZATION_NVP(_pentekFpgaTemp);
            ar & BOOST_SERIALIZATION_NVP(_xmitPulseWidth);
            ar & BOOST_SERIALIZATION_NVP(_prt);
            ar & BOOST_SERIALIZATION_NVP(_nGates);
            ar & BOOST_SERIALIZATION_NVP(_gateSpacing);
        }
        if (version >= 1) {
            // Version 1 stuff will go here...
        }
    }

    /// Pentek FPGA temperature
    int _pentekFpgaTemp;

    /// Pentek board temperature
    int _pentekBoardTemp;
    
    /// transmit pulse width, s
    double _xmitPulseWidth;

    /// pulse repetition time, s
    double _prt;
    
    /// Number of gates being sampled
    uint16_t _nGates;
    
    /// gate spacing, m
    double _gateSpacing;
    
};

// Increment this class version number when member variables are changed.
BOOST_CLASS_VERSION(HcrMonitorStatus, 0)

#endif /* HCRMONITORSTATUS_H_ */
