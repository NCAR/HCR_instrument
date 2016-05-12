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
 * SpectracomStatus.h
 *
 *  Created on: Aug 31, 2012
 *      Author: burghart
 */

#ifndef SPECTRACOMSTATUS_H_
#define SPECTRACOMSTATUS_H_

#include <ctime>
#include <exception>
#include <string>
#include <stdint.h>
#include <xmlrpc-c/base.hpp>
#include <boost/serialization/nvp.hpp>
#include <boost/serialization/version.hpp>

/// @brief Class to represent HCR Spectracom SecureSync status.
class SpectracomStatus {
public:
    /// @brief Default constructor. Status time is set to current time,
    /// the device is marked as not responding. Other values are set to
    /// generally indicate badness.
    SpectracomStatus();

    /// @brief Construct from an xmlrpc_c::value_struct dictionary as returned
    /// by a call to SpectracomDaemon's XML-RPC getStatus() method.
    /// @param statusDict an xmlrpc_c::value_struct dictionary as returned
    /// by a call to SpectracomDaemon's XML-RPC getStatus() method.
    SpectracomStatus(xmlrpc_c::value_struct & statusDict);

    /// @brief destructor
    virtual ~SpectracomStatus();

    /// @brief Return an external representation of the object's state as
    /// an xmlrpc_c::value_struct dictionary.
    ///
    /// The returned value can be used on the other side of an XML-RPC
    /// connection to create an identical object via the
    /// SpectracomStatus(const xmlrpc_c::value_struct &) constructor.
    /// @return an external representation of the object's state as
    /// an xmlrpc_c::value_struct dictionary.
    xmlrpc_c::value_struct toXmlRpcValue() const;
    
    /// @brief Return the status time, seconds since 1970-01-01 00:00:00 UTC.
    /// @return the status time, seconds since 1970-01-01 00:00:00 UTC.
    time_t statusTime() const { return(_statusTime); }

    /// @brief Return the host name (or IP address string) for the Spectracom
    /// @return the host name (or IP address string) for the Spectracom
    std::string hostName() const { return(_hostName); }

    /// @brief Return true iff the Spectracom is responding to queries
    /// @return true iff the Spectracom is responding to queries
    bool hostResponding() const { return(_hostResponding); }

    /// @brief Return a string describing the current time and 1 PPS references
    /// used by the Spectracom
    /// @return a string describing the current time and 1 PPS references
    /// used by the Spectracom
    std::string reference() const { return(_reference); }

    /// @brief Return the Spectracom's current NTP stratum
    /// @return the Spectracom's current NTP stratum
    int ntpStratum() const { return(_ntpStratum); }

    /// @brief Return true iff the Spectracom is currently synchronized
    /// @return true iff the Spectracom is currently synchronized
    bool inSync() const { return(_inSync); }

    /// @brief Return a string describing the oscillator installed in the
    /// Spectracom
    /// @return a string describing the oscillator installed in the
    /// Spectracom
    std::string oscType() const { return(_oscType); }

    /// @brief Return a string describing the oscillator state. States which
    /// may be returned include: "Warm Up", "Setup", "Free Run", and "Trk/Lock".
    /// @return a string describing the oscillator state.  States which
    /// may be returned include: "Warm Up", "Setup", "Free Run", and "Trk/Lock".
    std::string oscState() const { return(_oscState); }

    /// @brief Return the current TFOM (time figure of merit) of the Spectracom.
    /// (See the Spectracom manual for details).
    /// @return the current TFOM (time figure of merit) of the Spectracom.
    /// (See the Spectracom manual for details).
    int tfom() const { return(_tfom); }

    /// @brief Return the maximum TFOM (time figure of merit) for which the
    /// Spectracom will generate a 1 PPS output signal.
    /// @return the maximum TFOM (time figure of merit) for which the Spectracom
    /// will generate a 1 PPS output signal.
    int maxTfom() const { return(_maxTfom); }

    /// @brief Return the alarm status time, in seconds since 1970-01-01
    /// 00:00:00 UTC. This time applies to values returned by majorAlarm(),
    /// minorAlarm(), and alarmList().
    /// @return the alarm status time, in seconds since 1970-01-01
    /// 00:00:00 UTC. This time applies to values returned by majorAlarm(),
    /// minorAlarm(), and alarmList().
    double alarmStatusTime() const { return(_alarmStatusTime); }

    /// @brief Return true iff a major alarm is currently in effect.
    /// @return true iff a major alarm is currently in effect.
    bool majorAlarm() const { return(_majorAlarm); }

    /// @brief Return true iff a minor alarm is currently in effect.
    /// @return true iff a minor alarm is currently in effect.
    bool minorAlarm() const { return(_minorAlarm); }

    /// @brief Return a list of strings describing current alarm conditions.
    /// @return a list of strings describing current alarm conditions.
    std::vector<std::string> alarmList() const { return(_alarmList); }

    /// @brief Return the time of the last discipline report, in seconds since
    /// 1970-01-01 00:00:00 UTC. This time applies to values returned by
    /// dacValue(), ppsPhaseErr(), freqErr(), and oscTemp().
    /// @return the time of the last discipline report, in seconds since
    /// 1970-01-01 00:00:00 UTC. This time applies to values returned by
    /// dacValue(), ppsPhaseErr(), freqErr(), and oscTemp().
    double disciplineTime() const { return(_disciplineTime); }

    /// @brief Return the current oscillator DAC value.
    /// @return the current oscillator DAC value.
    int dacValue() const { return(_dacValue); }

    /// @brief Return the current offset of the generated 1 PPS signal w.r.t.
    /// the reference 1 PPS signal, in nanoseconds.
    /// @return the current offset of the generated 1 PPS signal w.r.t. the
    /// reference 1 PPS signal, in nanoseconds.
    int ppsPhaseErr() const { return(_ppsPhaseErr); }

    /// @brief Return the current estimated frequency error for the 10 MHz
    /// oscillator, in Hz.
    /// @return the current estimated frequency error for the 10 MHz
    /// oscillator, in Hz.
    double freqErr() const { return(_freqErr); }

    /// @brief Return the current temperature of the 10 MHz oscillator, deg C.
    /// @return the current temperature of the 10 MHz oscillator, deg C.
    double oscTemp() const { return(_oscTemp); }

private:
    friend class boost::serialization::access;

    /// @brief Serialize our members to a boost save/output archive or
    /// populate our members from a boost load/input archive.
    /// @param ar the archive to load from or save to.
    /// @param version the version
    template<class Archive>
    void serialize(Archive & ar, const unsigned int version) {
        using boost::serialization::make_nvp;
        // Version 0 (see BOOST_CLASS_VERSION macro below for latest version)
        if (version >= 0) {
            // Map named entries to our member variables using serialization's
            // name/value pairs (nvp).
            ar & BOOST_SERIALIZATION_NVP(_statusTime);
            ar & BOOST_SERIALIZATION_NVP(_hostName);
            ar & BOOST_SERIALIZATION_NVP(_hostResponding);
            ar & BOOST_SERIALIZATION_NVP(_reference);
            ar & BOOST_SERIALIZATION_NVP(_ntpStratum);
            ar & BOOST_SERIALIZATION_NVP(_inSync);
            ar & BOOST_SERIALIZATION_NVP(_oscType);
            ar & BOOST_SERIALIZATION_NVP(_oscState);
            ar & BOOST_SERIALIZATION_NVP(_tfom);
            ar & BOOST_SERIALIZATION_NVP(_maxTfom);
            ar & BOOST_SERIALIZATION_NVP(_alarmStatusTime);
            ar & BOOST_SERIALIZATION_NVP(_majorAlarm);
            ar & BOOST_SERIALIZATION_NVP(_minorAlarm);
            ar & BOOST_SERIALIZATION_NVP(_alarmList);
            ar & BOOST_SERIALIZATION_NVP(_disciplineTime);
            ar & BOOST_SERIALIZATION_NVP(_dacValue);
            ar & BOOST_SERIALIZATION_NVP(_ppsPhaseErr);
            ar & BOOST_SERIALIZATION_NVP(_freqErr);
            ar & BOOST_SERIALIZATION_NVP(_oscTemp);
        }
        if (version >= 1) {
            // Version 1 stuff will go here...
        }
    }

    /// Status time, seconds since 1970-01-01 00:00:00 UTC
    double _statusTime;
    
    /// Host name (or IP address string) for the Spectracom SecureSync
    std::string _hostName;
    
    /// Is the Spectracom responding?
    bool _hostResponding;
    
    /// String describing the Spectracom's current time and frequency 
    /// reference sources
    std::string _reference;
    
    /// NTP stratum
    int _ntpStratum;
    
    /// Is the Spectracom synchronized with its time and 1PPS references?
    bool _inSync;
    
    /// String describing the type of oscillator installed in the Spectracom
    std::string _oscType;
    
    /// String describing the current oscillator state
    std::string _oscState;
    
    /// TFOM (time figure of merit) is an integer describing a range containing
    /// the current time accuracy
    int _tfom;
    
    /// Max TFOM. Maximum TFOM for which a 1 PPS signal will be generated by 
    /// the Spectracom.
    int _maxTfom;
    
    /// Time at which alarm status was collected, seconds since 1970-01-01 
    /// 00:00:00 UTC
    double _alarmStatusTime;
    
    /// Is a major alarm indicated?
    bool _majorAlarm;
    
    /// Is a minor alarm indicated?
    bool _minorAlarm;
    
    /// List of strings describing current alarms.
    std::vector<std::string> _alarmList;

    /// Time at which frequency error was reported, seconds since 1970-01-01 
    /// 00:00:00 UTC. This is the time which applies to _dacValue, _ppsPhaseErr,
    ///_freqErr, and _oscTemp.
    double _disciplineTime;
    
    /// Oscillator discipline DAC value, int
    int _dacValue;

    /// 1 PPS phase error, ns
    int _ppsPhaseErr;

    /// Estimated frequency error
    double _freqErr;

    /// Oscillator temperature
    double _oscTemp;
};

// Increment this class version number when member variables are changed.
BOOST_CLASS_VERSION(SpectracomStatus, 0)

#endif /* SPECTRACOMSTATUS_H_ */
