// HcrDrxConfig.h
//
// Created on: March 31, 2020
//     Author: Chris Burghart <burghart@ucar.edu>
//
// Copyright © 2020 University Corporation for Atmospheric Research
// All rights reserved.

#ifndef HcrDrxConfig_H_
#define HcrDrxConfig_H_

#include <iostream>
#include <sstream>
#include <string>
#include <set>
#include <map>
#include <boost/program_options.hpp>

#define OPT_AND_GETTER(optType, optName) \
    private : optType optName##_; \
    public : const optType optName() const { return optName##_; }


/// @brief Reader for HCR config file
class HcrDrxConfig {
public:

    /// @brief Constructor for HcrDrxConfig with all default values
    HcrDrxConfig();

    /// @brief HcrDrxConfig constructor
    /// @param argc command line argument count
    /// @param argv command line argument value list
    HcrDrxConfig(int argc, char * argv[]);

    /// @brief HcrDrxConfig destructor
    ~HcrDrxConfig();

    /// @brief Return a string with the contents of the configuration
    std::string configString() const;

private:
    /// @brief A pointer to a singleton instance of a default configuration
    static HcrDrxConfig * DefaultConfig_;

    /// @brief Return an HcrDrxConfig with default settings
    static const HcrDrxConfig & DefaultConfig();

    /// @brief Program options to set our radar configuration members directly
    boost::program_options::options_description configVarsDesc_;

    // Below are the user-settable radar configuration variables

    OPT_AND_GETTER( double,       range_to_gate0_m );
    OPT_AND_GETTER( double,       latitude );
    OPT_AND_GETTER( double,       longitude );
    OPT_AND_GETTER( double,       altitude );
    OPT_AND_GETTER( double,       iqcount_scale_for_mw );
    OPT_AND_GETTER( double,       sim_start_elev );
    OPT_AND_GETTER( double,       sim_delta_elev );
    OPT_AND_GETTER( double,       sim_az_rate );
    OPT_AND_GETTER( uint,         merge_queue_size );
    OPT_AND_GETTER( uint,         iwrf_fmq_nslots );
    OPT_AND_GETTER( uint,         iwrf_fmq_bufsize );
    OPT_AND_GETTER( uint,         iwrf_fmq_report_interval );
    OPT_AND_GETTER( uint,         iwrf_fmq_npackets_per_message );
    OPT_AND_GETTER( uint,         iwrf_server_tcp_port );
    OPT_AND_GETTER( uint,         pulse_interval_per_iwrf_meta_data );
    OPT_AND_GETTER( uint,         sim_n_elev );
    OPT_AND_GETTER( bool,         export_iwrf_via_fmq );
    OPT_AND_GETTER( bool,         simulate_antenna_angles );
    OPT_AND_GETTER( bool,         simulate_pmc730 );
    OPT_AND_GETTER( bool,         start_on_1pps );
    OPT_AND_GETTER( std::string,  instance );
    OPT_AND_GETTER( std::string,  radar_id );
    OPT_AND_GETTER( std::string,  calibration_file );
    OPT_AND_GETTER( std::string,  iwrf_fmq_path );
    OPT_AND_GETTER( double,       tx_delay );
    OPT_AND_GETTER( double,       tx_mod_pulse_delay );
    OPT_AND_GETTER( double,       rx_delay );
    OPT_AND_GETTER( bool,         use_internal_clock );
    OPT_AND_GETTER( bool,         clock_mode_125 );
    OPT_AND_GETTER( double,       refclk_frequency );
    OPT_AND_GETTER( double,       rx_frequency );
    OPT_AND_GETTER( double,       tx_frequency );
    OPT_AND_GETTER( uint,         final_decimation );
    OPT_AND_GETTER( double,       pulses_to_run );
    OPT_AND_GETTER( uint,         pulses_per_xfer );
    OPT_AND_GETTER( std::string,  pulse_filter_file_ch_0 );
    OPT_AND_GETTER( std::string,  pulse_filter_file_ch_1 );
    OPT_AND_GETTER( std::string,  pulse_filter_file_ch_2 );
    OPT_AND_GETTER( bool,         enable_rx_ch_0 );
    OPT_AND_GETTER( bool,         enable_rx_ch_1 );
    OPT_AND_GETTER( bool,         enable_rx_ch_2 );
    OPT_AND_GETTER( double,       default_tx_pulse_width );
    OPT_AND_GETTER( uint,         default_rx_gates );
    OPT_AND_GETTER( uint,         default_pulses );
    OPT_AND_GETTER( double,       default_prt1 );
    OPT_AND_GETTER( double,       default_prt2 );
    OPT_AND_GETTER( double,       default_post_time );
    OPT_AND_GETTER( uint,         default_filter );

public:

    const std::string pulse_filter_file(uint chan) const;

    bool enable_rx(uint chan) const;

};

#endif /* HcrDrxConfig_H_ */