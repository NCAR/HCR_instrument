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
#include <iostream>
#include <stdint.h>
#include <OperationMode.h>
#include <xmlrpc-c/base.hpp>
#include <boost/serialization/nvp.hpp>
#include <boost/serialization/version.hpp>
#include <boost/serialization/vector.hpp>
#include <boost/archive/text_iarchive.hpp>
#include <boost/archive/text_oarchive.hpp>

/// @brief Class to represent HCR digital receiver/remote data system status.
class DrxStatus {
public:
    /// @brief Default constructor. Integer fields are set to -99.
    DrxStatus();

    /// @brief Construct a DrxStatus using data from the given data.
    DrxStatus(
        int pentekFpgaTemp,
        int pentekBoardTemp,
        double xmitPulseWidth,
        double prt,
        uint16_t nGates,
        double gateSpacing,
        bool motorZeroPositionSet,
        std::vector<OperationMode>& supportedOpsModes
    ) : _pentekFpgaTemp(pentekFpgaTemp),
        _pentekBoardTemp(pentekBoardTemp),
        _xmitPulseWidth(xmitPulseWidth),
        _prt(prt),
        _nGates(nGates),
        _gateSpacing(gateSpacing),
        _motorZeroPositionSet(motorZeroPositionSet),
        _supportedOpsModes(supportedOpsModes) {}; 

    /// @brief Construct from an xmlrpc_c::value_struct dictionary as returned
    /// by a call to the DrxStatus::toXmlRpcValue() method.
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

    /// @brief Return true iff the zero position for motor counts has been set
    /// @return true iff the zero position for motor counts has been set
    bool motorZeroPositionSet() const { return(_motorZeroPositionSet); }

    const std::vector<OperationMode>& supportedOpsModes() const { return(_supportedOpsModes); }

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
            ar & BOOST_SERIALIZATION_NVP(_motorZeroPositionSet);
            if(Archive::is_loading::value) {
                std::string modes;
                ar & BOOST_SERIALIZATION_NVP(modes);
                std::istringstream iss(modes);
                boost::archive::text_iarchive ia(iss);
                ia >> _supportedOpsModes;
            }
            else {
                std::ostringstream oss;
                boost::archive::text_oarchive oa(oss);
                oa << _supportedOpsModes;
                std::string modes = oss.str();
                ar & BOOST_SERIALIZATION_NVP(modes);
            }
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

    /// Has zero position for Pentek motor quadrature counts been set?
    bool _motorZeroPositionSet;

    /// List of available OperationModes
    std::vector<OperationMode> _supportedOpsModes;
};

// Increment this class version number when member variables are changed.
BOOST_CLASS_VERSION(DrxStatus, 0)

#endif /* DRXSTATUS_H_ */
