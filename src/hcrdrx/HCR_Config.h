// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
// ** Copyright UCAR (c) 2018-2021
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
 * HCR_Pentek.h
 *
 *  Created on: August 29, 2018
 *      Author: karboski
 */

#ifndef HCR_Config_H_
#define HCR_Config_H_

#include <iostream>
#include <sstream>
#include <string>
#include <set>
#include <map>

/// @brief Reader for HCR config file
class HCR_Config {
public:
    /// @brief Enumerated type listing allowed tx/rx polarization schemes
    typedef enum {
        MODE_HH,     // horizontal copolar
        MODE_VV,     // vertical copolar
        MODE_HH_VV   // alternating horizontal copolar and vertical copolar
    } PolarizationMode;

    /// @brief HCR_Config constructor
    HCR_Config();

    /// @brief HCR_Config destructor
    ~HCR_Config();

    /// @brief Parse the command line for a config file,
    /// then parse the config file, then parse any remaining command line args
    void parse(int argc, char * argv[]);

    /// @brief Instance of this running application
    /// @return the instance name
    std::string instance() const { return(_asString("instance")); }

    /// @brief Return the TCP server port being used to publish IWRF time
    /// series packets
    /// @return the TCP server port being used to publish IWRF time
    /// series packets
    int iwrf_server_tcp_port() const { return(_asInt("iwrf_server_tcp_port")); }

    /// @brief Return I and Q count scaling factor to get power in mW for the
    /// given DDC channel
    ///
    /// formula: mW = (I_count / _iqScaleForMw)^2 + (Q_count / _iqScaleForMw)^2
    /// @param ddcChan the HCR DDC channel of interest
    /// @return I and Q count scaling factor to get power in mW for the
    /// given DDC channel
    double iqcount_scale_for_mw(int ddcChan) const;

    /// @brief Return the radar pulse interval between published IWRF
    /// metadata packets
    /// @return the radar pulse interval between published IWRF
    /// metadata packets
    int pulse_interval_per_iwrf_meta_data() const {
        return(_asInt("pulse_interval_per_iwrf_meta_data"));
    }

    /// @brief Return true iff the internal clock should be used
    /// @return true iff the internal clock should be used
    bool use_internal_clock() const { return(_asBool("use_internal_clock")); }
    
    /// @brief Return the receive (IF) frequency
    /// @return the receive frequency
    double rx_frequency() const { return(_asDouble("rx_frequency")); }    
    
    /// @brief Return the transmit (IF) frequency
    /// @return the transmit frequency
    double tx_frequency() const { return(_asDouble("tx_frequency")); }       

    /// @brief Return the path for the calibration file
    /// @return the path for the calibration file
    std::string calib_file_long_pulse() const { return(_asString("calib_file_long_pulse")); }
    std::string calib_file_short_pulse() const { return(_asString("calib_file_short_pulse")); }

    /// @brief Return radar latitude, deg
    /// @return radar latitude, deg
    double latitude() const { return(_asDouble("latitude")); }

    /// @brief Return radar longitude, deg
    /// @return radar longitude, deg
    double longitude() const { return(_asDouble("longitude")); }

    /// @brief Return radar altitude, m MSL
    /// @return radar altitude, m MSL
    int altitude() const { return(_asInt("altitude")); }

    /// @brief Return the radar name
    /// @return the radar name
    std::string radar_id() const { return(_asString("radar_id")); }
    
    /// @brief Return the pulse repetition time, s
    /// @return the pulse repetition time, s
    double prt() const { return(_asDouble("prt")); }    

    /// @brief Return the TQS pulse width, s
    /// @return the TQS pulse width, s
    double tx_pulsewidth() const { return(_asDouble("tx_pulsewidth")); }

    /// @brief Return the DUC interpolation factor
    /// @return the DUC interpolation factor
    uint32_t duc_interpolation() const { return(_asUInt("duc_interpolation")); }

    /// @brief Return the range to data gate 0, m
    /// @return the range to data gate 0, m
    double range_to_gate0() const { return(_asDouble("range_to_gate0")); }

    /// @brief Return the scale factor to apply to the tx waveform
    /// @return the scale factor to apply to the tx waveform
    double tx_scale_db() const { return(_asDouble("tx_scale_db")); }        

    /// @brief Return true iff digital downconversion (DDC) blocks should
    /// be enabled
    /// @return true iff digital downconversion (DDC) blocks should
    /// be enabled
    bool ddc_enable() const { return(_asBool("ddc_enable")); }

    /// @brief Return true iff IWRF time series publishing is enabled
    /// @return true iff IWRF time series publishing is enabled
    bool publish_iwrf() const { return(_asBool("publish_iwrf")); }

    /// @brief Return the path name for the long-pulse time series FMQ
    /// @return the path name for the long-pulse time series FMQ
    std::string fmq_path_long_pulse() const {
        return(_asString("fmq_path_long_pulse"));
    }

    /// @brief Return the path name for the short-pulse time series FMQ
    /// @return the path name for the short-pulse time series FMQ
    std::string fmq_path_short_pulse() const {
        return(_asString("fmq_path_short_pulse"));
    }

    /// @brief Return the FMQ slot size for time series data
    /// @return the FMQ slot size for time series data
    uint32_t fmq_slot_size() const {
        return(_asUInt("fmq_slot_size"));
    }

    /// @brief Return the number of slots to create in the output FMQ
    /// @return the number of slots to create in the output FMQ
    uint32_t fmq_nslots() const {
        return(_asUInt("fmq_nslots"));
    }
    
    /// @brief Return the filter file name for
    /// the selected ADC channel
    /// @param chan the ADC channel number (0-3)
    /// @return the pulse filter file name for the selected channel
    std::string pulse_filter_file(int chan) const;

    /// @brief Return the radar polarization operating mode
    /// @return the radar polarization operating mode
    PolarizationMode polarization_mode() const {
        std::string modeName = _asString("polarization_mode");
        const auto it = _PolModeNameMap.find(modeName);
        if (it == _PolModeNameMap.end()) {
            std::ostringstream os;
            os << "Unknown polarization_mode string '" << modeName << "'";
            throw std::runtime_error(os.str());
        }
        return(it->second);
    }

    /// @brief Return the first string in _PolModeNameMap which maps to the
    /// given PolarizationMode
    /// @param mode the PolarizationMode of interest
    static std::string PolarizationModeName(PolarizationMode mode) {
        for (auto it = _PolModeNameMap.begin(); it != _PolModeNameMap.end() ; it++) {
            if (it->second == mode) {
                return(it->first);
            }
        }
        std::ostringstream os;
        os << "No name found for PolarizationMode " << mode << "!";
        throw std::runtime_error(os.str());
    }

    /// @brief Print available parameters, with their current value
    void printAsSet(std::ostream &out) const;

    /// @brief Print usage to override parameters
    void printUsage(std::ostream &out) const;
    
private:

    /// @brief Parse a line of the config
    void _processParameter(const std::string & parameter, int lineNum);

    /// @brief Return value at key as string
    /// @param key The key to retrieve
    /// @return value at key as string
    const std::string & _asString(const std::string & key) const;

    /// @brief Return value at key as bool
    /// @param key The key to retrieve
    /// @return value at key as bool
    bool _asBool(const std::string & key) const;

    /// @brief Return value at key as double-precision float
    /// @param key The key to retrieve
    /// @return value at key as double-precision float
    double _asDouble(const std::string & key) const;

    /// @brief Return value at key as int32_t
    /// @param key The key to retrieve
    /// @return value at key as int32_t
    int32_t _asInt(const std::string & key) const;

    /// @brief Return value at key as uint32_t
    /// @param key The key to retrieve
    /// @return value at key as uint32_t
    uint32_t _asUInt(const std::string & key) const;

    /// @brief The config data structure
    std::map<std::string, std::string> _cfg;

    /// @brief List of config items that have been modified from the app default
    std::set<std::string> _cfgDeltas;

    /// @brief Map of strings to PolarizationMode-s
    static std::map<std::string, PolarizationMode> _PolModeNameMap;

};


#endif /* HCR_Config_H_ */
