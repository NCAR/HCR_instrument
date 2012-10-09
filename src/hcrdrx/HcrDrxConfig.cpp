/*
 * HcrDrxConfig.cpp
 *
 *  Created on: Jun 11, 2010
 *      Author: burghart
 */

#include "HcrDrxConfig.h"

#include <algorithm>
#include <iostream>
#include <fstream>
#include <sstream>
#include <cerrno>
#include <climits>
#include <cmath>
#include <cstring>

const double HcrDrxConfig::UNSET_DOUBLE = -INFINITY;
const int HcrDrxConfig::UNSET_INT = INT_MIN;
const std::string HcrDrxConfig::UNSET_STRING("<unset string>");
const int HcrDrxConfig::UNSET_BOOL = UNSET_INT;

// Keys for floating point values we'll accept
std::set<std::string> HcrDrxConfig::_DoubleLegalKeys(_createDoubleLegalKeys());
std::set<std::string> HcrDrxConfig::_createDoubleLegalKeys() {
    std::set<std::string> keys;
    keys.insert("prt1");
    keys.insert("prt2");
    keys.insert("tx_delay");
    keys.insert("tx_latency");
    keys.insert("tx_pulse_width");
    keys.insert("tx_pulse_mod_delay");
    keys.insert("tx_pulse_mod_width");
    keys.insert("digitizer_gate0_delay");
    keys.insert("digitizer_sample_width");
    keys.insert("latitude");
    keys.insert("longitude");
    keys.insert("altitude");
    keys.insert("iqcount_scale_for_mw");
    keys.insert("sim_start_elev");
    keys.insert("sim_delta_elev");
    keys.insert("sim_az_rate");
    return keys;
}

// Keys for integer values we'll accept
std::set<std::string> HcrDrxConfig::_IntLegalKeys(_createIntLegalKeys());
std::set<std::string> HcrDrxConfig::_createIntLegalKeys() {
    std::set<std::string> keys;
    keys.insert("gates");
    keys.insert("merge_queue_size");
    keys.insert("iwrf_server_tcp_port");
    keys.insert("pulse_interval_per_iwrf_meta_data");
    keys.insert("sim_n_elev");
    return keys;
}

// Keys for boolean values we'll accept
std::set<std::string> HcrDrxConfig::_BoolLegalKeys(_createBoolLegalKeys());
std::set<std::string> HcrDrxConfig::_createBoolLegalKeys() {
    std::set<std::string> keys;
    keys.insert("staggered_prt");
    keys.insert("simulate_antenna_angles");
    keys.insert("simulate_pmc730");
    keys.insert("start_on_1pps");
    return keys;
}

// Keys for string values we'll accept
std::set<std::string> HcrDrxConfig::_StringLegalKeys(_createStringLegalKeys());
std::set<std::string> HcrDrxConfig::_createStringLegalKeys() {
    std::set<std::string> keys;
    keys.insert("radar_id");
    keys.insert("calibration_file");
    return keys;
}

// Return a copy of a string, without comments and leading and trailing whitespace
static std::string
trimmedString(const std::string& str) {
    std::string s(str);
    // strip comment (from first '#' to end of line)
    if (s.find('#') != s.npos)
        s.erase(s.find('#'));
    // strip leading whitespace
    s.erase(s.begin(), std::find_if(s.begin(), s.end(), 
            std::not1(std::ptr_fun<int,int>(std::isspace))));
    // strip trailing whitespace
    s.erase(std::find_if(s.rbegin(), s.rend(), std::not1(std::ptr_fun<int,int>(std::isspace))).base(), 
            s.end());
    return s;
}

// Return the contents of the given key/value line *before* the first whitespace
static std::string
keyFromLine(const std::string& line) {
    std::string s(line);
    s.erase(std::find_if(s.begin(), s.end(), std::ptr_fun<int,int>(std::isspace)), 
            s.end());
    return s;
}

// Return the contents of the given key/value line *after* the first whitespace.
static std::string
valueFromLine(const std::string& line) {
    std::string s(line);
    // erase up to the first space, then again up to the first non-space
    s.erase(s.begin(), 
            std::find_if(s.begin(), s.end(), std::ptr_fun<int,int>(std::isspace)));
    s.erase(s.begin(), 
            std::find_if(s.begin(), s.end(), std::not1(std::ptr_fun<int,int>(std::isspace))));
    return s;
}


HcrDrxConfig::HcrDrxConfig(std::string configFile) {
    std::fstream infile(configFile.c_str(), std::ios_base::in);
    if (infile.fail()) {
        std::cerr << "Error opening config file '" << configFile << "': " <<
            strerror(errno) << std::endl;
        exit(1);
    }
    // Read each line from the file, discarding empty lines and lines
    // beginning with '#'.
    // 
    // Other lines are parsed as "<key> <value>", and saved into
    // our dictionaries. Unknown keys will cause error exit.
    std::string line;
    while (true) {
        std::getline(infile, line);
        if (infile.eof())
            break;
        // Trim comments and leading and trailing space from the line
        line = trimmedString(line);
        // If there's nothing left, move to the next line
        if (! line.length())
            continue;
        
        std::string key = keyFromLine(line);
        std::string strValue = valueFromLine(line);
        std::istringstream valueStream(strValue);
        if (_DoubleLegalKeys.find(key) != _DoubleLegalKeys.end()) {
            double fVal;
            if ((valueStream >> fVal).fail()) {
                std::cerr << "Bad double value '" << strValue << "' for key " <<
                    key << " in config file" << std::endl;
                exit(1);
            }
            _doubleVals[key] = fVal;
        } else if (_IntLegalKeys.find(key) != _IntLegalKeys.end()) {
            int iVal;
            if ((valueStream >> iVal).fail()) {
                std::cerr << "Bad int value '" << strValue << "' for key " <<
                    key << " in config file" << std::endl;
                exit(1);
            }
            _intVals[key] = iVal;
        } else if (_BoolLegalKeys.find(key) != _BoolLegalKeys.end()) {
            bool bVal;
            if ((valueStream >> bVal).fail()) {
                std::cerr << "Bad bool value '" << strValue << "' for key " <<
                    key << " in config file" << std::endl;
                exit(1);
            }
            _boolVals[key] = bVal;
        } else if (_StringLegalKeys.find(key) != _StringLegalKeys.end()) {
            _stringVals[key] = strValue;
        } else {
            std::cerr << "Illegal key '" << key << "' in config file" << std::endl;
            exit(1);
        }
    }
}

HcrDrxConfig::~HcrDrxConfig() {
}

bool
HcrDrxConfig::isValid(bool verbose) const {
    bool valid = true;
    if (radar_id() == UNSET_STRING) {
        if (verbose)
            std::cerr << "'radar_id' unset in DRX configuration" << std::endl;
        valid = false;
    }
    if (calibration_file() == UNSET_STRING) {
        if (verbose)
            std::cerr << "'calibration_file' unset in DRX configuration" << std::endl;
        valid = false;
    }
    if (gates() == UNSET_INT) {
        if (verbose)
            std::cerr << "'gates' unset in DRX configuration" << std::endl;
        valid = false;
    }
    if (staggered_prt() == UNSET_BOOL) {
        if (verbose)
            std::cerr << "'staggered_prt' unset in DRX configuration" << std::endl;
        valid = false;
    }
    if (prt1() == UNSET_DOUBLE) {
        if (verbose)
            std::cerr << "'prt1' unset in DRX configuration" << std::endl;
        valid = false;
    }
    if (staggered_prt() == 1 && prt2() == UNSET_DOUBLE) {
        if (verbose)
            std::cerr << "'prt2' unset in DRX configuration when "
                "'staggered_prt' is true" << std::endl;
        valid = false;
    }
    if (digitizer_gate0_delay() == UNSET_DOUBLE) {
        if (verbose)
            std::cerr << "'rcvr_gate0_delay' unset in DRX configuration" << std::endl;
        valid = false;
    }
    if (digitizer_sample_width() == UNSET_DOUBLE) {
        if (verbose)
            std::cerr << "'digitizer_sample_width' unset in DRX configuration" << std::endl;
        valid = false;
    }
    if (tx_pulse_width() == UNSET_DOUBLE) {
        if (verbose)
            std::cerr << "'tx_pulse_width' unset in DRX configuration" << std::endl;
        valid = false;
    }
    if (tx_delay() == UNSET_DOUBLE) {
        if (verbose)
            std::cerr << "'tx_delay' unset in DRX configuration" << std::endl;
        valid = false;
    }
    if (tx_latency() == UNSET_DOUBLE) {
        if (verbose)
            std::cerr << "'tx_latency' unset in DRX configuration" << std::endl;
        valid = false;
    }
    if (tx_pulse_mod_delay() == UNSET_DOUBLE) {
        if (verbose)
            std::cerr << "'tx_pulse_mod_delay' unset in DRX configuration" << std::endl;
        valid = false;
    }
    if (tx_pulse_mod_width() == UNSET_DOUBLE) {
        if (verbose)
            std::cerr << "'tx_pulse_mod_width' unset in DRX configuration" << std::endl;
        valid = false;
    }
    if (iqcount_scale_for_mw() == UNSET_DOUBLE) {
        if (verbose)
            std::cerr << "'iqcount_scale_for_mw' unset in DRX configuration" << std::endl;
        valid = false;
    }
    if (merge_queue_size() == UNSET_INT) {
        if (verbose)
            std::cerr << "'merge_queue_size' not set" << std::endl;
        valid = false;
    }
    if (iwrf_server_tcp_port() == UNSET_INT) {
        if (verbose)
            std::cerr << "'iwrf_server_tcp_port' not set" << std::endl;
        valid = false;
    }
    if (pulse_interval_per_iwrf_meta_data() == UNSET_INT) {
        if (verbose)
            std::cerr << "'pulse_interval_per_iwrf_meta_data' not set" << std::endl;
        valid = false;
    }
    if (simulate_antenna_angles() == UNSET_BOOL) {
        if (verbose)
            std::cerr << "'simulate_antenna_angles' unset in DRX configuration" << std::endl;
        valid = false;
    }
    if (simulate_antenna_angles() == 1) {
        if (sim_n_elev() == UNSET_INT) {
            if (verbose)
                std::cerr << "'simulate_antenna_angles' is true, but "
                    "'sim_n_elev' is unset in DRX configuration" << std::endl;
            valid = false;
        }
        if (sim_start_elev() == UNSET_DOUBLE) {
            if (verbose)
                std::cerr << "'simulate_antenna_angles' is true, but "
                    "'sim_start_elev' is unset in DRX configuration" << std::endl;
            valid = false;
        }
        if (sim_delta_elev() == UNSET_DOUBLE) {
            if (verbose)
                std::cerr << "'simulate_antenna_angles' is true, but "
                    "'sim_delta_elev' is unset in DRX configuration" << std::endl;
            valid = false;
        }
        if (sim_az_rate() == UNSET_DOUBLE) {
            if (verbose)
                std::cerr << "'simulate_antenna_angles' is true, but "
                    "'sim_az_rate' is unset in DRX configuration" << std::endl;
            valid = false;
        }
    }
    if (start_on_1pps() == UNSET_BOOL) {
        if (verbose)
            std::cerr << "'start_on_1pps' unset in DRX configuration" << std::endl;
        valid = false;
    }

    return valid;
}

double
HcrDrxConfig::range_to_gate0() const {
//    const double SpeedOfLight = 2.9979245e8; // m/s
//    double gateSpacing = 0.5 * SpeedOfLight * digitizer_sample_width();
//    return(digitizer_gate0_delay() - tx_delay() - tx_latency() + 0.5 * gateSpacing);
	// For now, just return 0.0
	// @TODO Come up with a better solution. 
	return(0.0);
}
