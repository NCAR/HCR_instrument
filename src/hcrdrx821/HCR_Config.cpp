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
 * HCR_Config.cpp
 *
 *  Created on: August 29, 2018
 *      Author: Adam Karboski <karboski@ucar.edu>
 */

#include <algorithm>
#include <fstream>
#include <string>
#include <boost/algorithm/string/predicate.hpp> // for boost::iequals(str1, str2)
#include <logx/Logging.h>

#include "HCR_Config.h"

LOGGING("HCR_Config")

// Static map of strings to PolarizationMode-s
std::map<std::string, HCR_Config::PolarizationMode>
HCR_Config::_PolModeNameMap = {
        {"HH", MODE_HH},
        {"VV", MODE_VV},
        {"HH_VV", MODE_HH_VV}
};

HCR_Config::HCR_Config()
{
    // This is the default config.
    // _processParameter() can change these values, but won't change/add keys.
    
    _cfg["config_file"] = "default";
    
    _cfg["use_internal_clock"] = "true";
    _cfg["duc_interpolation"] = "2";
    _cfg["rx_frequency"] = "93.75e6";
    _cfg["tx_frequency"] = "93.75e6";

    _cfg["instance"] = "ops";
    _cfg["publish_iwrf"] = "true";
    _cfg["fmq_path_long_pulse"] = "/tmp/fmq/ts/long_pulse/shmem_10000";
    _cfg["fmq_path_short_pulse"] = "/tmp/fmq/ts/short_pulse/shmem_10002";
    _cfg["fmq_slot_size"] = "100000";
    _cfg["fmq_nslots"] = "500";
    _cfg["iwrf_server_tcp_port"] = "12000";
    _cfg["iqcount_scale_for_mw_ch_0"] = "28.690e6";
    _cfg["iqcount_scale_for_mw_ch_1"] = "7.8855e6";
    _cfg["iqcount_scale_for_mw_ch_2"] = "28.690e6";
    _cfg["iqcount_scale_for_mw_ch_3"] = "7.8855e6";
    _cfg["pulse_interval_per_iwrf_meta_data"] = "500";
    _cfg["calib_file_long_pulse"] = "calLongPulse.xml";
    _cfg["calib_file_short_pulse"] = "calShortPulse.xml";

    _cfg["latitude"] = "40.03794";
    _cfg["longitude"] = "-105.24127";
    _cfg["altitude"] = "1609";
    _cfg["radar_id"] = "HCR";
    
    _cfg["pulse_filter_file_ch_0"] = "cdata/pulse_filter_default.csv";
    _cfg["pulse_filter_file_ch_1"] = "cdata/pulse_filter_default.csv";
    _cfg["pulse_filter_file_ch_2"] = "cdata/pulse_filter_default.csv";

    _cfg["polarization_mode"] = "HH";   // "HH", "VV" or "HH_VV"
    _cfg["prt"] = "500.0e-6";
    _cfg["tx_pulsewidth"] = "1.0e-6";           // s
    _cfg["range_to_gate0"] = "-150.0";          // range to center of gate 0, m
};

HCR_Config::~HCR_Config() {};

void HCR_Config::parse(int argc, char * argv[])
{

    std::string filename;

    // Parse the command line for the config_file parameter
    for(int arg=1; arg<argc; arg++) {
        std::string argstr = argv[arg];

        // Check for config_file parameter and handle
        if (argstr.find("config_file")!=std::string::npos) {

            if ((arg+1) < argc) {
                _processParameter(argstr + "=" + argv[arg+1], 0);
            }
            else {
                throw std::runtime_error("Cmdline syntax error : " + argstr);
            }

            // Read the config file if present
            filename = _asString("config_file");
            if (!filename.empty() && filename != "default") {

                ILOG << "Reading config file: " << filename;

                std::ifstream cfgFile(filename);
                int lineNum = 0;

                if (!cfgFile.good()) {
                    throw std::runtime_error( "Error opening config file.");
                    return;
                }

                while(true) {
                    std::string param;

                    // Read a line of the config file
                    std::getline(cfgFile, param);
                    lineNum++;
                    if (cfgFile.fail()) break;

                   _processParameter(param, lineNum);

                }
                cfgFile.close();

            }
            break;
        }
    }

    // Parse the command line for remaining arguments
    for(int arg=1; arg<argc; arg++) {
        std::string argstr = argv[arg];

        // check for help
        if (argstr == "--help" ||
            argstr == "--h" ||
            argstr == "-h") {
          continue;
        }

        if (argstr[0]=='-' && (arg+1)<argc) {

            _processParameter(argstr + "=" + argv[arg+1], 0);
            arg++;

        }
        else {
            throw std::runtime_error("Cmdline syntax error : " + argstr);
        }
    }

    // Print out the configuration
    std::string configString = "Configuration: (*=delta)\n";

    for (auto it = _cfg.begin(); it != _cfg.end(); it++) {
        std::string configItem = it->first;
        configItem.resize(25,' ');

        //Mark config deltas (non-defaults)
        if(_cfgDeltas.count(it->first)) {
            configItem += "*";
        }
        else {
            configItem += " ";
        }

        configString += "        " +configItem + ": " + it->second + "\n";
    }
    ILOG << configString;

}

void HCR_Config::_processParameter(const std::string & parameter, int lineNum)
{
    // Trim comments
    std::string cfgLine = parameter.substr(0,parameter.find("#"));
    cfgLine.erase(0, cfgLine.find_first_not_of("\t\n\v\f\r "));
    if (cfgLine.empty()) return;

    // Skip lines without '='
    int separator = cfgLine.find("=");
    if (separator == std::string::npos) {
        ELOG << "Config syntax error @" << lineNum << " : \"" << cfgLine << "\"";
        throw std::runtime_error("Config syntax error");
    }

    // Split along the separator
    std::string key = cfgLine.substr(0,separator);
    std::string value = cfgLine.substr(separator+1, std::string::npos);

    // Trim whitespace
    key.erase(0, key.find_first_not_of("-\t\n\v\f\r "));
    key.erase(key.find_last_not_of("\t\n\v\f\r ") + 1);
    value.erase(0, value.find_first_not_of("\t\n\v\f\r "));
    value.erase(value.find_last_not_of("\t\n\v\f\r ") + 1);

    // Look up the key
    const auto it = _cfg.find(key);

    // Replace the new value
    if (it==_cfg.end()) {
        throw std::runtime_error("Unknown config option \"" + key + "\"");
    } else {
        _cfg[key] = value;
        _cfgDeltas.insert(key);
    }
}

const std::string & HCR_Config::_asString(const std::string & key) const
{
    const auto it = _cfg.find(key);

    if (it==_cfg.end()) {
        throw std::runtime_error("Config item " + key + " not found.");
    }

    //ILOG << key << " : " << it->second;
    return it->second;
}

bool HCR_Config::_asBool(const std::string & key) const
{
    // Convert the key's value to lower case, and accept either "true" or "false"
    std::string value = _asString(key);
    std::transform(value.begin(), value.end(), value.begin(), ::tolower);
    if (value == "true") {
        return(true);
    } else if (value == "false") {
        return(false);
    } else {
        std::ostringstream os;
        os << "Cannot convert key '" << key << "' value '" << value << "' to bool";
        throw std::runtime_error(os.str());
    }
}

int32_t HCR_Config::_asInt(const std::string & key) const
{
    std::string vString = _asString(key);
    int val;
    try {
        val = stoi(vString);
    } catch (std::invalid_argument & e) {
        // stoi throws invalid_argument if it cannot parse an int
        std::ostringstream os;
        os << "Cannot convert key '" << key << "' value '" << vString <<
              "' to int";
        throw std::runtime_error(os.str());
    }
    return(val);
}

double HCR_Config::_asDouble(const std::string & key) const
{
    std::string vString = _asString(key);
    double val;
    try {
        val = stod(vString);
    } catch (std::invalid_argument & e) {
        // stod throws invalid_argument if it cannot parse a double
        std::ostringstream os;
        os << "Cannot convert key '" << key << "' value '" << vString <<
              "' to double";
        throw std::runtime_error(os.str());
    }
    return(val);
}

uint32_t HCR_Config::_asUInt(const std::string & key) const
{
    std::string vString = _asString(key);
    uint32_t val;
    try {
        val = stoul(vString);
    } catch (std::invalid_argument & e) {
        // stoul throws invalid_argument if it cannot parse a double
        std::ostringstream os;
        os << "Cannot convert key '" << key << "' value '" << vString <<
              "' to uint32_t";
        throw std::runtime_error(os.str());
    }
    return(val);
}

double HCR_Config::iqcount_scale_for_mw(int ddcChan) const
{
    std::string key = "iqcount_scale_for_mw_ch_" + std::to_string(ddcChan);
    return(_asDouble(key));
}

/// @brief Print available parameters, with their current value
void HCR_Config::printAsSet(std::ostream &out) const
{

  for (auto ii = _cfg.begin(); ii != _cfg.end(); ii++) {
    out << "  " << ii->first << ": " << ii->second << std::endl;
  } // ii

}

std::string HCR_Config::pulse_filter_file(int chan) const
{
    std::string key = "pulse_filter_file_ch_" + std::to_string(chan);
    return(_asString(key));
}

/// @brief Print usage to override parameters
void HCR_Config::printUsage(std::ostream &out) const
{

  for (auto ii = _cfg.begin(); ii != _cfg.end(); ii++) {
    out << "  [--" << ii->first
        << " ?]: override val"
        << " (currently: " << ii->second
        << ")" << std::endl;
  } // ii

}

