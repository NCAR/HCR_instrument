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
 * HcrDrxConfig.h
 *
 *  Created on: Jun 11, 2010
 *      Author: burghart
 */

#ifndef HCRDRXCONFIG_H_
#define HCRDRXCONFIG_H_

#include <exception>
#include <cmath>
#include <string>
#include <map>
#include <set>
#include <vector>
#include <cstdlib>
#include <iostream>


class HcrDrxConfig {
public:
    HcrDrxConfig(std::string configFile);
    virtual ~HcrDrxConfig();

    /// radar name
    std::string radar_id() const {
        return _getStringVal("radar_id");
    }
    /// calibration file name
    std::string calibration_file() const {
        return _getStringVal("calibration_file");
    }
    /// number of gates
    int gates() const { 
        return _getIntVal("gates"); 
    }
    /** 
     * Staggered PRT? 
     * @ return 0 if false, 1 if true, or UNSET_BOOL if unset
     */
    int staggered_prt() const {
        return _getBoolVal("staggered_prt");
    }
    /// first PRT, s
    double prt1() const {
        return _getDoubleVal("prt1");
    }
    /// second PRT, s
    double prt2() const {
        return _getDoubleVal("prt2");
    }
    /// transmit pulse delay, s
    double tx_delay() const {
        return _getDoubleVal("tx_delay");
    }
    /// transmit pulse width, s
    double tx_pulse_width() const {
        return _getDoubleVal("tx_pulse_width");
    }
    /// transmit pulse modulation timer delay, s
    double tx_pulse_mod_delay() const {
        return _getDoubleVal("tx_pulse_mod_delay");
    }
    /// @brief transmitter latency, s
    ///
    /// Return the transmitter latency, the time between rising edge of the
    /// transmit trigger pulse and actual generation of the RF pulse.
    double tx_latency() const {
        return _getDoubleVal("tx_latency");
    }

    ///////////////////////////////////////////////////
    /// IWRF TCP output

    /// @brief size of queue buffers for pulse merging for IWRF
    int merge_queue_size() const {
        return _getIntVal("merge_queue_size");
    }
    /// @brief TCP port for IWRF data server
    int iwrf_server_tcp_port() const {
        return _getIntVal("iwrf_server_tcp_port");
    }
    /// @brief How often do we send IWRF meta data?
    int pulse_interval_per_iwrf_meta_data() const {
      return _getIntVal("pulse_interval_per_iwrf_meta_data");
    }

    /// @brief Digitizer sample width, s
    double digitizer_sample_width() const { return _getDoubleVal("digitizer_sample_width"); }
    /// @brief Digitizer delay before sampling the first gate, s
    double digitizer_gate0_delay() const { return _getDoubleVal("digitizer_gate0_delay"); }

    /// Return the range to the center of gate 0, in meters
    /// @return the range to the center of gate 0, in meters
    double range_to_gate0_m() const{ return _getDoubleVal("range_to_gate0_m"); };

    /// @brief radar latitude, degrees
    double latitude() const { return _getDoubleVal("latitude"); }
    /// @brief radar longitude, degrees
    double longitude() const { return _getDoubleVal("longitude"); }
    /// @brief radar altitude, m MSL
    double altitude() const { return _getDoubleVal("altitude"); }
    
    /// @brief Count scaling factor to easily get power in mW from I and Q.
    ///
    /// If I and Q are counts from the Pentek, the power at the A/D in
    /// mW is:
    ///
    ///      (I / iqcount_scale_for_mw)^2 + (Q / iqcount_scale_for_mw)^2
    ///
    /// This value is determined empirically.
    double iqcount_scale_for_mw() const {
        return _getDoubleVal("iqcount_scale_for_mw");
    }

    /// simulation of angles

    int simulate_antenna_angles() const {
      return _getBoolVal("simulate_antenna_angles");
    }
    int sim_n_elev() const {
      return _getIntVal("sim_n_elev");
    }
    double sim_start_elev() const {
      return _getDoubleVal("sim_start_elev"); /// deg
    }
    double sim_delta_elev() const {
      return _getDoubleVal("sim_delta_elev"); /// deg
    }
    double sim_az_rate() const {
      return _getDoubleVal("sim_az_rate"); /// deg/s
    }
    
    // Simulate existence of the PMC-730 multi-IO card?
    int simulate_pmc730() const {
    	return _getBoolVal("simulate_pmc730");
    }

    // Start radar on external 1 PPS trigger signal?
    int start_on_1pps() const {
        return _getBoolVal("start_on_1pps");
    }

    /**
     * Validate that all metadata values required for product generation 
     * have been set.
     * @return true iff metadata values required for product generation have
     * all been set
     */
    bool isValid(bool verbose = true) const;  
    
    /**
     * Value returned when an unset double item is requested.
     */
    static const double UNSET_DOUBLE;
    /**
     * Value returned when an unset int item is requested.
     */
    static const int UNSET_INT;
    /**
     * Value returned when an unset string item is requested.
     */
    static const std::string UNSET_STRING;
    /**
     * Value returned when an unset boolean item is requested.
     */
    static const int UNSET_BOOL;
    
private:
    
    /**
     * Look up the given key and return the associated double value, or
     * UNSET_DOUBLE if the key has no value set.
     * @param key the key to look up
     * @return the double value for the key, or UNSET_DOUBLE if the key has
     *    no value set.
     */
    double _getDoubleVal(std::string key) const {
        if (_DoubleLegalKeys.find(key) == _DoubleLegalKeys.end()) {
            std::cerr << __FUNCTION__ << ": Oops, request for bad double key " <<
                key << std::endl;
            exit(1);
        }
        std::map<std::string, double>::const_iterator it =  _doubleVals.find(key);
        if (it != _doubleVals.end())
            return it->second;
        else
            return UNSET_DOUBLE;
    }
    
    /**
     * Look up the given key and return the associated string value, or
     * an empty string if the key has no value set.
     * @param key the key to look up
     * @return the string value for the key, or an empty string if the key has
     *    no value set.
     */
    std::string _getStringVal(std::string key) const {
        if (_StringLegalKeys.find(key) == _StringLegalKeys.end()) {
            std::cerr << __FUNCTION__ << ": Oops, request for bad string key " <<
                key << std::endl;
            exit(1);
        }
        std::map<std::string, std::string>::const_iterator it = _stringVals.find(key);
        if (it != _stringVals.end())
            return it->second;
        else
            return UNSET_STRING;
    }
    
    /**
     * Look up the given key and return the associated int value, or
     * UNSET_INT if the key has no value set.
     * @param key the key to look up
     * @return the int value for the key, or UNSET_INT if the key has
     *    no value set.
     */
    int _getIntVal(std::string key) const {
        if (_IntLegalKeys.find(key) == _IntLegalKeys.end()) {
            std::cerr << __FUNCTION__ << ": Oops, request for bad int key " <<
                key << std::endl;
            exit(1);
        }
        std::map<std::string, int>::const_iterator it = _intVals.find(key);
        if (it != _intVals.end())
            return it->second;
        else
            return UNSET_INT;
    }
    
    /**
     * Look up the given key and return the associated boolean value. 
     * 0 is returned if the value is false, 1 if it is true, or UNSET_BOOL if 
     * the value is unset.
     * @param key the key to look up
     * @return 0 if the boolean value is false, 1 if it is true, or UNSET_BOOL
     *     if it is unset
     */
    int _getBoolVal(std::string key) const {
        if (_BoolLegalKeys.find(key) == _BoolLegalKeys.end()) {
            std::cerr << __FUNCTION__ << ": Oops, request for bad bool key " <<
                key << std::endl;
            exit(1);
        }
        std::map<std::string, bool>::const_iterator it = _boolVals.find(key);
        if (it != _boolVals.end())
            return(it->second ? 1 : 0);
        else
//            throw new UnsetItem(std::string("Config bool value for '") + key + "' is unset.");
            return UNSET_BOOL;  // unset
    }
    
    // Keys we allow
    static std::set<std::string> _DoubleLegalKeys;
    static std::set<std::string> _StringLegalKeys;
    static std::set<std::string> _IntLegalKeys;
    static std::set<std::string> _BoolLegalKeys;
    
    static std::set<std::string> _createDoubleLegalKeys();
    static std::set<std::string> _createStringLegalKeys();
    static std::set<std::string> _createIntLegalKeys();
    static std::set<std::string> _createBoolLegalKeys();
    
    // Our dictionaries for the values
    std::map<std::string, double> _doubleVals;
    std::map<std::string, int> _intVals;
    std::map<std::string, bool> _boolVals;
    std::map<std::string, std::string> _stringVals;
};

#endif /* HCRDRXCONFIG_H_ */
