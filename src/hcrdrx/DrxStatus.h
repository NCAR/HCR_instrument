/*
 * DrxStatus.h
 *
 *  Created on: Sep 6, 2012
 *      Author: burghart
 */

#ifndef DRXSTATUS_H_
#define DRXSTATUS_H_

#include <exception>
#include <string>
#include <numeric>
#include <stdint.h>
#include <xmlrpc-c/base.hpp>
#include <boost/serialization/nvp.hpp>
#include <boost/serialization/version.hpp>

namespace Pentek {
    class p7142;
}

/// @brief Class to represent HCR digital receiver/remote data system status.
class DrxStatus {
public:
    /// @brief Default constructor. Integer fields are set to -99.
    DrxStatus();

    /// @brief Construct a DrxStatus using data from the given 
    /// Pentek::p7142 device.
    /// @param pentek the Pentek::p7142 device from which to get status
    DrxStatus(const Pentek::p7142 & pentek);

    /// @brief Construct from an XmlRpcValue dictionary as returned by a call
    /// to the DrxStatus::toXmlRpcValue() method.
    /// @param statusDict an xmlrpc_c::value_struct dictionary as returned by 
    /// call to the DrxStatus::toXmlRpcValue() method.
    DrxStatus(xmlrpc_c::value_struct & statusDict);

    virtual ~DrxStatus();

    /// @brief Return an external representation of the object's state as
    /// an xmlrpc_c::value_struct dictionary.
    ///
    /// The returned value can be used on the other side of an XML-RPC
    /// connection to create an identical object via the
    /// XmitStatus(const xmlrpc_c::value_struct &) constructor.
    /// @return an external representation of the object's state as
    /// an xmlrpc_c::value_struct dictionary.
    xmlrpc_c::value_struct toXmlRpcValue() const;

    /**
     * @brief Return the signal processing FPGA temperature from the Pentek
     * card, deg C
     * @return the signal processing FPGA temperature from the Pentek
     * card, deg C
     */
    int pentekFpgaTemp() const { return(_pentekFpgaTemp); }
    
    /**
     * @brief Return the PCB temperature from the Pentek card, deg C
     * @return the PCB temperature from the Pentek card, deg C
     */
    int pentekBoardTemp() const { return(_pentekBoardTemp); }
    
private:
    /**
     * @brief Get new sensor data from the Pentek P7142 card.
     */
    void _getPentekValues(const Pentek::p7142 & pentek);
    
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
            ar & BOOST_SERIALIZATION_NVP(_pentekBoardTemp);
            ar & BOOST_SERIALIZATION_NVP(_pentekFpgaTemp);
        }
        if (version >= 1) {
            // Version 1 stuff will go here...
        }
    }

    /// Pentek FPGA temperature
    int _pentekFpgaTemp;

    /// Pentek board temperature;
    int _pentekBoardTemp;

};

// Increment this class version number when member variables are changed.
BOOST_CLASS_VERSION(DrxStatus, 1)

#endif /* DRXSTATUS_H_ */
