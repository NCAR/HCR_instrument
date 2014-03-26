/*
 * FireFlyStatus.h
 *
 *  Created on: Aug 31, 2012
 *      Author: burghart
 */

#ifndef FIREFLYSTATUS_H_
#define FIREFLYSTATUS_H_

#include <exception>
#include <string>
#include <stdint.h>
#include <xmlrpc-c/base.hpp>
#include <boost/serialization/nvp.hpp>
#include <boost/serialization/version.hpp>

/// @brief Class to represent HCR FireFly status.
class FireFlyStatus {
public:
    /// @brief This is a subclass of std::exception thrown when there is a
    /// problem in FireFlyStatus construction.
    ///
    /// Use what() to get a description of the thrown exception.
    class ConstructError : public std::exception {
    public:
        ConstructError(std::string msg) throw() : std::exception(), _msg(msg) {}
        virtual ~ConstructError() throw() {}
        /// @brief Returns a null terminated character sequence containing a
        /// generic description of the exception.
        /// @return a null terminated character sequence containing a
        /// description of the exception.
        virtual const char* what() const throw() { return(_msg.c_str()); }
    private:
        std::string _msg;
    };

    /// @brief Default constructor. Boolean fields are set to false, integer
    /// fields are set to 0, and double fields are set to -99.9.
    FireFlyStatus();

    /// @brief Construct from a text status reply returned by the
    /// FireFly.
    /// @param statusResponse a text status response returned by the FireFly
    /// @throws ConstructError if there is a problem with the status packet
    /// from the FireFly.
    FireFlyStatus(const std::string statusResponse) throw(ConstructError);

    /// @brief Construct from an xmlrpc_c::value_struct dictionary as returned
    /// by a call to the FireFlyStatus::toXmlRpcValue() method.
    /// @param statusDict an xmlrpc_c::value_struct dictionary as returned by
    /// call to the FireFlyStatus::toXmlRpcValue() method.
    /// @throws ContructError if there is a problem unpacking the given
    /// xmlrpc_c::value_struct into an FireFlyStatus.
    FireFlyStatus(xmlrpc_c::value_struct & statusDict) throw(ConstructError);

    /// @brief destructor
    virtual ~FireFlyStatus();

    /// @brief Return an external representation of the object's state as
    /// an xmlrpc_c::value_struct dictionary.
    ///
    /// The returned value can be used on the other side of an XML-RPC
    /// connection to create an identical object via the
    /// FireFlyStatus(const xmlrpc_c::value_struct &) constructor.
    /// @return an external representation of the object's state as
    /// an xmlrpc_c::value_struct dictionary.
    xmlrpc_c::value_struct toXmlRpcValue() const;
    
    /// @brief Return true iff serial communication to the FireFly is connected
    /// @return true iff serial connection to the FireFly is connected
    bool serialConnected() const { return(_serialConnected); }
    
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
//            // Map named entries to our member variables using serialization's
//            // name/value pairs (nvp).
//            ar & BOOST_SERIALIZATION_NVP(_serialConnected);
//            ar & BOOST_SERIALIZATION_NVP(_badChecksumReceived);
//            ar & BOOST_SERIALIZATION_NVP(_filamentOn);
        }
        if (version >= 1) {
            // Version 1 stuff will go here...
        }
    }

    /// @brief Keep around a copy of the last FireFlyStatus created from a
    /// FireFly response.
    static FireFlyStatus _PrevStatus;

    /// Is serial communication to the FireFly connected?
    bool _serialConnected;
    
    /// EIK filament on?
    bool _filamentOn;
};

// Increment this class version number when member variables are changed.
BOOST_CLASS_VERSION(FireFlyStatus, 1)

#endif /* FIREFLYSTATUS_H_ */
