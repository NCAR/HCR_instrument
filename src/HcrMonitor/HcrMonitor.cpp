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
 * HcrMonitor.cpp
 *
 * Daemon which performs some basic monitoring and reacts if necessary to 
 * protect the HCR transmitter and its receiver LNAs. For the transmitter, 
 * high voltage will be disabled if pressure vessel pressure drops below a 
 * set threshold in order to prevent transmitter arcing. For the LNAs, steps
 * are taken to prevent transmitting toward the ground when aircraft
 * altitude above the surface is low enough that returns might damage the LNAs.
 *
 * Created on: Jul 24, 2014
 *      Author: burghart
 */

#include <unistd.h>
#include <csignal>
#include <iomanip>
#include <map>
#include <sstream>
#include <string>
#include <boost/program_options.hpp>

#include <HcrPmc730StatusThread.h>
#include <logx/Logging.h>
#include <MotionControlStatusThread.h>
#include <QCoreApplication>
#include <QFunctionWrapper.h>
#include <QTimer>
#include <QXmlRpcServerAbyss.h>
#include <toolsa/pmu.h>
#include <xmlrpc-c/client_simple.hpp>
#include <xmlrpc-c/registry.hpp>

#include "ApsControl.h"
#include "HcrMonitorStatus.h"
#include "MaxPowerClient.h"
#include "TransmitControl.h"

LOGGING("HcrMonitor")

namespace po = boost::program_options;

/// Our QApplication
QCoreApplication * App = 0;

// APS control
ApsControl * TheApsControl = 0;

// Transmit control
TransmitControl * TheTransmitControl = 0;

/// Signal handler to allow for clean shutdown on SIGINT and SIGTERM
void sigHandler(int sig) {
    ILOG << "Stopping HcrMonitor on signal " << sig << 
            " (" << strsignal(sig) << ")";
    App->quit();
}

// Update our registration with PMU at this interval.
static const int REGISTRATION_INTERVAL_SECS = 60;

// Log a brief status message at this interval.
static const int LOG_STATUS_INTERVAL_SECS = 15;

void
updateRegistration() {
    // Make sure we remain registered with PMU, so it knows we're alive
    PMU_auto_register("running");
}

void
logStatus() {
    ILOG << "HcrMonitor still running...";
}

/// @brief xmlrpc_c::method to get status from the HcrMonitor process.
///
/// The method returns a xmlrpc_c::value_struct (dictionary) mapping
/// std::string keys to xmlrpc_c::value values. Pass the dictionary
/// to the HcrMonitorStatus(xmlrpc_c::value_struct & dict) constructor to
/// create a usable HcrMonitorStatus object.
///
/// Example client usage, where HcrMonitor is running on machine
/// `rds`:
/// @code
///     #include <xmlrpc-c/client_simple.hpp>
///     ...
///
///     // Get the status from HcrMonitor on rds on port 8004
///     xmlrpc_c::simpleClient client;
///     std::string daemonUrl = "http://rds:8004/RPC2")
///
///     xmlrpc_c::value result;
///     try {
///         client.call(daemonUrl, "getStatus", "", &result);
///     } catch (std::exception & e) {
///         std::cerr << "XML-RPC getStatus() error: " << e.what() << std::endl;
///         exit(1);
///     }
///
///     // create a HcrMonitorStatus object from the returned dictionary
///     xmlrpc_c::value_struct resultStruct(result);
///     status = HcrMonitorStatus(resultStruct);
///
///     // extract a value from the status
///     bool pllLocked = status.pllLocked();;
/// @endcode
class GetStatusMethod : public xmlrpc_c::method {
public:
    GetStatusMethod() {
        this->_signature = "S:";
        this->_help = "This method returns status from HcrMonitor.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        DLOG << "Received 'getStatus' command";
        // Get the latest status from shared memory, and convert it to
        // an xmlrpc_c::value_struct dictionary.
        *retvalP = HcrMonitorStatus(*TheApsControl, *TheTransmitControl).toXmlRpcValue();
    }
};

/// @brief xmlrpc_c::method to set APS valve control state
class SetApsValveControlMethod : public xmlrpc_c::method {
public:
    SetApsValveControlMethod() {
        this->_signature = "n:i";
        this->_help = "This method sets the APS valve control state.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        // Get the requested mode
        int const state(paramList.getInt(0));
        paramList.verifyEnd(1);

        ILOG << "Received 'setApsValveControl(" << state << ")' command";
        TheApsControl->setValveControl(static_cast<ApsControl::ValveControlState>(state));
        *retvalP = xmlrpc_c::value_nil();
    }
};

/// @brief xmlrpc_c::method to set HMC mode
class SetRequestedHmcModeMethod : public xmlrpc_c::method {
public:
    SetRequestedHmcModeMethod() {
        this->_signature = "n:i";
        this->_help = "This method sets the requested HMC mode.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        // Get the requested mode
        int const mode(paramList.getInt(0));
        paramList.verifyEnd(1);

        ILOG << "Received 'setRequestedHmcMode(" << mode << ")' command";
        TheTransmitControl->setRequestedHmcMode(static_cast<HcrPmc730::HmcOperationMode>(mode));
        *retvalP = xmlrpc_c::value_nil();
    }
};

/// @brief xmlrpc_c::method to set whether transmitter high voltage is requested
class SetHvRequestedMethod : public xmlrpc_c::method {
public:
    SetHvRequestedMethod() {
        this->_signature = "n:b";
        this->_help = "This method chooses if transmitter high voltage is requested.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        // Get the requested mode
        bool const hvRequested(paramList.getBoolean(0));
        paramList.verifyEnd(1);

        TheTransmitControl->setHvRequested(hvRequested);
        *retvalP = xmlrpc_c::value_nil();
    }
};

int
main(int argc, char *argv[]) {
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);
    
    // Instantiate our QCoreApplication
    App = new QCoreApplication(argc, argv);

    // XML-RPC server port number
    static const int DEFAULT_XMLRPC_PORT = 8004;
    int xmlrpcPortNum;
    
    // procmap instance name
    std::string instanceName;

    // Get HcrMonitor's options
    po::options_description opts("Options");
    opts.add_options()
        ("help,h", "Describe options")
        ("instance,i",
                po::value<std::string>(&instanceName)->default_value("ops"),
                "instance name for procmap connection")
        ("xmlrpcPortNum,x",
                po::value<int>(&xmlrpcPortNum)->default_value(DEFAULT_XMLRPC_PORT),
                "XML-RPC server port number")
        ;
    bool argError = false;
    po::variables_map vm;
    try {
        po::store(po::command_line_parser(argc, argv).options(opts).run(), vm);
        po::notify(vm);
    } catch (...) {
        argError = true;
    }

    // Give usage information and exit if 1) help was requested, or 2) there
    // is an argument error
    if (vm.count("help") || argError) {
        std::cout << "Usage: " << argv[0] <<
                  " [OPTION]..." << std::endl;
        std::cout << opts << std::endl;
        exit(1);
    }
    
    // Initialize registration with procmap if instance is specified
    if (instanceName.size() > 0) {
        PMU_auto_init("HcrMonitor", instanceName.c_str(), PROCMAP_REGISTER_INTERVAL);
        ILOG << "Initializing procmap registration as instance '" << 
                instanceName << "'";
    }

    ILOG << "HcrMonitor (" << getpid() << ") started";

    PMU_auto_register("initializing");

    // Initialize our RPC server
    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("getStatus", new GetStatusMethod);
    myRegistry.addMethod("setApsValveControl", new SetApsValveControlMethod);
    myRegistry.addMethod("setRequestedHmcMode", new SetRequestedHmcModeMethod);
    myRegistry.addMethod("setHvRequested", new SetHvRequestedMethod);
    QXmlRpcServerAbyss rpcServer(&myRegistry, xmlrpcPortNum);
    
    // Start a thread to get HcrPmc730Daemon status on a regular basis.
    HcrPmc730StatusThread hcrPmc730StatusThread("localhost", 8003);
    hcrPmc730StatusThread.start();
    
    // Start a thread to get MotionControlDaemon status on a regular basis
    MotionControlStatusThread mcStatusThread("localhost", 8080);
    mcStatusThread.start();
    
    // MaxPowerClient instance
    MaxPowerClient maxPowerClient("archiver", 13000);
    maxPowerClient.start();
    
    // Instantiate the object which will monitor pressure and control the
    // Active Pressurization System (APS)
    TheApsControl = new ApsControl(hcrPmc730StatusThread);
    
    // Instantiate the object which will implement safety monitoring for the
    // transmitter
    TheTransmitControl = new TransmitControl(hcrPmc730StatusThread, 
            mcStatusThread, maxPowerClient);
    
    // catch a control-C or kill to shut down cleanly
    signal(SIGINT, sigHandler);
    signal(SIGTERM, sigHandler);
 
    // Set up a timer to periodically register with PMU so it knows we're still
    // alive.
    QTimer registrationTimer;
    registrationTimer.setInterval(REGISTRATION_INTERVAL_SECS * 1000);   // interval in ms
    QFunctionWrapper registrationFuncWrapper(updateRegistration);
    QObject::connect(&registrationTimer, SIGNAL(timeout()),
            &registrationFuncWrapper, SLOT(callFunction()));
    registrationTimer.start();

    // Set up a timer to log status information occasionally
    QTimer statusTimer;
    statusTimer.setInterval(LOG_STATUS_INTERVAL_SECS * 1000);
    QFunctionWrapper statusFuncWrapper(logStatus);
    QObject::connect(&statusTimer, SIGNAL(timeout()),
            &statusFuncWrapper, SLOT(callFunction()));
    statusTimer.start();
    
    // Now just run the application until somebody or something interrupts it
    try {
        App->exec();
    } catch (std::exception & e) {
        ELOG << "Application stopped on exception: " << e.what();
    } catch (...) {
        ELOG << "Application stopped on unknown exception";
    }

    // Unregister with procmap
    PMU_auto_unregister();

    // Clean up before exit
    delete(TheTransmitControl);
    delete(TheApsControl);

    maxPowerClient.quit();
    maxPowerClient.wait(500);
    mcStatusThread.quit();
    mcStatusThread.wait(500);
    hcrPmc730StatusThread.quit();
    hcrPmc730StatusThread.wait(500);

    ILOG << "HcrMonitor (" << getpid() << ") exiting";

    return 0;
} 
