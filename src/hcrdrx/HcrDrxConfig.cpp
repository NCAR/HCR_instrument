// HcrDrxConfig.cpp
//
//
// Copyright © 2020 University Corporation for Atmospheric Research
// All rights reserved.

#include <algorithm>
#include <fstream>
#include <string>
#include <boost/algorithm/string.hpp>
#include <boost/program_options.hpp>
#include <logx/Logging.h>
#include "HcrDrxConfig.h"

LOGGING("HcrDrxConfig")

namespace po = boost::program_options;

// Singleton default configuration instance
HcrDrxConfig * HcrDrxConfig::DefaultConfig_;

namespace po = boost::program_options;

/// @brief Macro to build a boost::program_options option which will set a
/// member variable
/// @param optName the option name to use on the command line or in the
/// config file
/// @param description the description for the option
/// @param default_val the default value for the option
///
/// The macro will generate an option entry with the given name which will
/// set the value of the private member of the same name with an underscore
/// appended. The default_val will be applied to the member if the user does
/// not supply the option.
///
/// E.g., if a class has a private member of type int named "nWidgets_", which
/// should have default value 100, the macro call would be:
///
///     MAKE_OPT(nWidgets, "the number of widgets to build", 100)
///
/// which the macros translates to the somewhat opaque option definition:
///
///     ("nWidgets", po::value<decltype(nWidgets_)>(& nWidgets_)->default_value(100), "the number of widgets to build")
///
/// The user could then set the nWidgets_ member to 5 from the command line
/// with the option "--nWidgets 5"
///
#define MEMBER_PROGOPT(optName, description, default_val) \
    ( \
        #optName,   \
        po::value<decltype(optName##_)>(& optName##_)->default_value(default_val), \
        description \
    )

/// @brief Output the given option name and the value of its associated member
/// to a stream with format "<optName>: <optValue>". If the option's current
/// value is not the default value, " *" will be appended to the output.
///
/// Note that the macro explicitly displays bool values as "true" or "false"
/// rather than "1" or "0"
#define STREAM_OPT_AND_MEMBER(optName) \
    #optName << ": " << std::boolalpha << optName##_ \
             << ((optName##_ == HcrDrxConfig::DefaultConfig().optName##_) ? "" : " *") \
             << '\n'

HcrDrxConfig::HcrDrxConfig(int argc, char * argv[]) : HcrDrxConfig()
{
    // For command line use, add non-configuration option --configFileName
    // to those in configVarsDesc_
    std::string configFileName;
    po::options_description optsDesc("Configuration options");
    optsDesc.add(configVarsDesc_).add_options()
            ("help,h", "show HcrDrxConfig command line options")
            ("configFile", po::value<std::string>(&configFileName), "HCR config file path")
            ;

    // We also allow a config file name to be given on the command line
    // without --configFile, i.e., as a "positional" argument
    po::positional_options_description posDesc;
    posDesc.add("configFile", 1);

    // The default constructor was already applied, so we have the default
    // configuration values in place. Now parse the command line and apply
    // any options set there
    po::variables_map vm;
    po::store(po::command_line_parser(argc, argv)
        .options(optsDesc).positional(posDesc).run(), vm);
    notify(vm);

    // If the help option was selected, print our help information and return
    // now.
    if (vm.count("help") > 0)
    {
        std::cerr << optsDesc << "\n";
        return;
    }

    // Finally, if a config file was given on the command line, parse that
    // now. Note that although the config file is loaded last, any command
    // line options parsed above have precedence over the same options
    // given in the config file!
    if (! configFileName.empty()) {
        DLOG << "Loading config file " << configFileName;
        po::store(po::parse_config_file<char>(configFileName.c_str(), configVarsDesc_), vm);
        notify(vm);
    }
};

HcrDrxConfig::~HcrDrxConfig() {};

const HcrDrxConfig &
HcrDrxConfig::DefaultConfig()
{
    // Instantiate the singleton default configuration on first access
    if (! DefaultConfig_) {
        DefaultConfig_ = new HcrDrxConfig;
    }
    return(*DefaultConfig_);
}

const std::string HcrDrxConfig::pulse_filter_file(uint chan) const
{
    switch(chan) {
        case 0: return pulse_filter_file_ch_0();
        case 1: return pulse_filter_file_ch_1();
        case 2: return pulse_filter_file_ch_2();
    }
    throw std::runtime_error("Unknown channel.");
}

bool HcrDrxConfig::enable_rx(uint chan) const
{
    switch(chan) {
        case 0: return enable_rx_ch_0();
        case 1: return enable_rx_ch_1();
        case 2: return enable_rx_ch_2();
    }
    throw std::runtime_error("Unknown channel.");
}

HcrDrxConfig::HcrDrxConfig() :
        configVarsDesc_("Direct configuration variable setters")
{
    // Assemble command line / configuration file options for each of our
    // configuration variables
    configVarsDesc_.add_options()
        MEMBER_PROGOPT( latitude,                          "description",                                  40.03794 )
        MEMBER_PROGOPT( longitude,                         "description",                                  -105.24127 )
        MEMBER_PROGOPT( altitude,                          "description",                                  1609 )
        MEMBER_PROGOPT( iqcount_scale_for_mw,              "description",                                  780446 )
        MEMBER_PROGOPT( simulate_antenna_angles,           "description",                                  false )
        MEMBER_PROGOPT( sim_start_elev,                    "description",                                  0.0 )
        MEMBER_PROGOPT( sim_delta_elev,                    "description",                                  0.0 )
        MEMBER_PROGOPT( sim_az_rate,                       "description",                                  0.0 )
        MEMBER_PROGOPT( sim_n_elev,                        "description",                                  0 )
        MEMBER_PROGOPT( merge_queue_size,                  "description",                                  100000 )
        MEMBER_PROGOPT( iwrf_fmq_nslots,                   "description",                                  100 )
        MEMBER_PROGOPT( iwrf_fmq_bufsize,                  "description",                                  1000000000 )
        MEMBER_PROGOPT( iwrf_fmq_report_interval,          "description",                                  1 )
        MEMBER_PROGOPT( iwrf_fmq_npackets_per_message,     "description",                                  1000 )
        MEMBER_PROGOPT( iwrf_server_tcp_port,              "description",                                  12000 )
        MEMBER_PROGOPT( pulse_interval_per_iwrf_meta_data, "description",                                  5000 )
        MEMBER_PROGOPT( export_iwrf_via_fmq,               "description",                                  true )
        MEMBER_PROGOPT( instance,                          "description",                                  "ops" )
        MEMBER_PROGOPT( radar_id,                          "description",                                  "HCR" )
        MEMBER_PROGOPT( calibration_file,                  "description",                                  "defaultCal.xml" )
        MEMBER_PROGOPT( iwrf_fmq_path,                     "description",                                  "/tmp/fmq/ts/wband/shmem_10000" )
        MEMBER_PROGOPT( range_to_gate0_m,                  "distance to the 0th range cell",               -198.0 )
        MEMBER_PROGOPT( start_on_1pps,                     "wait for timing pulse to start",               true )
        MEMBER_PROGOPT( ems_pulse_width,                   "time that the T/R switch is set to T",         4160e-9 )
        MEMBER_PROGOPT( tx_pulse_offset,                   "transmit pulse delay/advance from TR",         -686e-9 )
        MEMBER_PROGOPT( mod_pulse_offset,                  "modulator pulse delay/advance from TR",        -200e-9 )
        MEMBER_PROGOPT( rx_offset,                         "sample collection delay/advance from TR",      0 )
        MEMBER_PROGOPT( use_internal_clock,                "synthesize internal clock from reference",     true )
        MEMBER_PROGOPT( clock_mode_125,                    "false = experimental",                         true )
        MEMBER_PROGOPT( refclk_frequency,                  "frequency of external reference clock",        10.0e6 )
        MEMBER_PROGOPT( rx_frequency,                      "ddc center (IF) frequency, rx",                156.25e6 )
        MEMBER_PROGOPT( tx_frequency,                      "ddc center (IF) frequency, tx",                156.25e6 )
        MEMBER_PROGOPT( extra_ddc_gain,                    "adjustment to default ddc filter gain",        0.015625 )
        MEMBER_PROGOPT( extra_pulse_gain,                  "adjustment to default gaussian filter gain",   16.0 )
        MEMBER_PROGOPT( final_decimation,                  "decimation after the last rx filter",          2 )
        MEMBER_PROGOPT( pulses_to_run,                     "number of pulses to schedule before exiting",  INFINITY )
        MEMBER_PROGOPT( pulses_per_xfer,                   "ratio of pulses to interrupts",                200 )
        MEMBER_PROGOPT( pulse_filter_file_ch_0,            "gaussian filter coefs",                        "default_gaussian_filters.csv" )
        MEMBER_PROGOPT( pulse_filter_file_ch_1,            "gaussian filter coefs",                        "default_gaussian_filters.csv" )
        MEMBER_PROGOPT( pulse_filter_file_ch_2,            "gaussian filter coefs",                        "default_gaussian_filters.csv" )
        MEMBER_PROGOPT( phase_code_file,                   "phase coding coefs",                           "default_phase_codes.csv" )
        MEMBER_PROGOPT( enable_rx_ch_0,                    "enable ADC channel",                           true )
        MEMBER_PROGOPT( enable_rx_ch_1,                    "enable ADC channel",                           true )
        MEMBER_PROGOPT( enable_rx_ch_2,                    "enable ADC channel",                           false )
        MEMBER_PROGOPT( default_tx_pulse_width,            "legacy mode pulse definition",                 256e-9 )
        MEMBER_PROGOPT( default_rx_gates,                  "legacy mode pulse definition",                 758 )
        MEMBER_PROGOPT( default_pulses,                    "legacy mode pulse definition",                 100 )
        MEMBER_PROGOPT( default_prt1,                      "legacy mode pulse definition",                 101.376e-6 )
        MEMBER_PROGOPT( default_prt2,                      "legacy mode pulse definition",                 0.0 ) //300.0e-6 )
        MEMBER_PROGOPT( default_post_time,                 "legacy mode pulse definition",                 0.0 )
        MEMBER_PROGOPT( default_filter,                    "legacy mode pulse definition",                 1 )
        ;

    // Apply the command_line_parser with no arguments to initialize the
    // configuration members to the default values shown above
    po::variables_map vm;
    std::vector<std::string> noArgs;
    po::store(po::command_line_parser(noArgs).options(configVarsDesc_).run(), vm);
    notify(vm);
}

std::string
HcrDrxConfig::configString() const {
    std::ostringstream os;
    os << STREAM_OPT_AND_MEMBER( latitude );
    os << STREAM_OPT_AND_MEMBER( longitude );
    os << STREAM_OPT_AND_MEMBER( altitude );
    os << STREAM_OPT_AND_MEMBER( iqcount_scale_for_mw );
    os << STREAM_OPT_AND_MEMBER( simulate_antenna_angles );
    os << STREAM_OPT_AND_MEMBER( sim_start_elev );
    os << STREAM_OPT_AND_MEMBER( sim_delta_elev );
    os << STREAM_OPT_AND_MEMBER( sim_az_rate );
    os << STREAM_OPT_AND_MEMBER( sim_n_elev );
    os << STREAM_OPT_AND_MEMBER( merge_queue_size );
    os << STREAM_OPT_AND_MEMBER( iwrf_fmq_nslots );
    os << STREAM_OPT_AND_MEMBER( iwrf_fmq_bufsize );
    os << STREAM_OPT_AND_MEMBER( iwrf_fmq_report_interval );
    os << STREAM_OPT_AND_MEMBER( iwrf_fmq_npackets_per_message );
    os << STREAM_OPT_AND_MEMBER( iwrf_server_tcp_port );
    os << STREAM_OPT_AND_MEMBER( pulse_interval_per_iwrf_meta_data );
    os << STREAM_OPT_AND_MEMBER( export_iwrf_via_fmq );
    os << STREAM_OPT_AND_MEMBER( instance );
    os << STREAM_OPT_AND_MEMBER( radar_id );
    os << STREAM_OPT_AND_MEMBER( calibration_file );
    os << STREAM_OPT_AND_MEMBER( iwrf_fmq_path );
    os << STREAM_OPT_AND_MEMBER( range_to_gate0_m );
    os << STREAM_OPT_AND_MEMBER( start_on_1pps );
    os << STREAM_OPT_AND_MEMBER( ems_pulse_width );
    os << STREAM_OPT_AND_MEMBER( tx_pulse_offset );
    os << STREAM_OPT_AND_MEMBER( mod_pulse_offset );
    os << STREAM_OPT_AND_MEMBER( rx_offset );
    os << STREAM_OPT_AND_MEMBER( use_internal_clock );
    os << STREAM_OPT_AND_MEMBER( clock_mode_125 );
    os << STREAM_OPT_AND_MEMBER( refclk_frequency );
    os << STREAM_OPT_AND_MEMBER( rx_frequency );
    os << STREAM_OPT_AND_MEMBER( tx_frequency );
    os << STREAM_OPT_AND_MEMBER( extra_ddc_gain );
    os << STREAM_OPT_AND_MEMBER( extra_pulse_gain );
    os << STREAM_OPT_AND_MEMBER( final_decimation );
    os << STREAM_OPT_AND_MEMBER( pulses_to_run );
    os << STREAM_OPT_AND_MEMBER( pulses_per_xfer );
    os << STREAM_OPT_AND_MEMBER( pulse_filter_file_ch_0 );
    os << STREAM_OPT_AND_MEMBER( pulse_filter_file_ch_1 );
    os << STREAM_OPT_AND_MEMBER( pulse_filter_file_ch_2 );
    os << STREAM_OPT_AND_MEMBER( phase_code_file );
    os << STREAM_OPT_AND_MEMBER( enable_rx_ch_0 );
    os << STREAM_OPT_AND_MEMBER( enable_rx_ch_1 );
    os << STREAM_OPT_AND_MEMBER( enable_rx_ch_2 );
    os << STREAM_OPT_AND_MEMBER( default_tx_pulse_width );
    os << STREAM_OPT_AND_MEMBER( default_rx_gates );
    os << STREAM_OPT_AND_MEMBER( default_pulses );
    os << STREAM_OPT_AND_MEMBER( default_prt1 );
    os << STREAM_OPT_AND_MEMBER( default_prt2 );
    os << STREAM_OPT_AND_MEMBER( default_post_time );
    os << STREAM_OPT_AND_MEMBER( default_filter );

    return(os.str());
}

