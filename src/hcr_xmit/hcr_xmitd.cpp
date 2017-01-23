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
 * hcr_xmitd.cpp
 *
 *  Created on: Jan 5, 2011
 *      Author: burghart
 */

#include <string>
#include <cerrno>
#include <csignal>
#include <cstring>
#include <cstdlib>
#include <ctime>
#include <vector>
#include <unistd.h>
#include <sys/time.h>
#include <sys/types.h>
#include <boost/program_options.hpp>
#include <QCoreApplication>
#include <QTimer>

#include <toolsa/pmu.h>
#include <logx/Logging.h>
#include <QFunctionWrapper.h>

#include <xmlrpc-c/registry.hpp>
#include <QXmlRpcServerAbyss.h>

#include "HcrXmitter.h"
#include "../HcrSharedResources.h"

namespace po = boost::program_options;

LOGGING("hcr_xmitd")

/// Our transmitter
HcrXmitter *Xmitter = 0;

/// Our QApplication
QCoreApplication *App = 0;

// Description of command line options
po::options_description OptionsDesc("Options");

/// Run in foreground?
bool Foreground = false;

/// Default instance name for procmap
std::string InstanceName = "";

/// Signal handler to allow for clean shutdown on SIGINT and SIGTERM
void sigHandler(int sig) {
  ILOG << "Signal received; stopping application.";
  App->quit();
}

void
updateRegistration() {
    // Make sure we remain registered with PMU, so it knows we're alive
    PMU_auto_register("running");
}

/// @brief xmlrpc_c::method to get status from the hcr_xmitd process.
///
/// The method returns a xmlrpc_c::value_struct (dictionary) mapping
/// std::string keys to xmlrpc_c::value values. Pass the dictionary
/// to the XmitStatus(xmlrpc_c::value_struct & dict) constructor to create a
/// usable XmitStatus object.
///
/// Example client usage, where hcr_xmitd is running on machine `xmitserver`:
/// @code
///     #include <xmlrpc-c/client_simple.hpp>
///     ...
///
///     // Get the transmitter status from hcr_xmitd on xmitserver.local.net
///     // on port 8080
///     xmlrpc_c::simpleClient client;
///     std::string daemonUrl = "http://xmitserver.local.net:8080/RPC2")
///
///     xmlrpc_c::value result;
///     try {
///         client.call(daemonUrl, "getStatus", "", &result);
///     } catch (std::exception & e) {
///         std::cerr << "XML-RPC getStatus() error: " << e.what() << std::endl;
///         exit(1);
///     }
///
///     // create an XmitStatus object from the returned dictionary
///     xmlrpc_c::value_struct resultStruct(result);
///     status = XmitdStatus(resultStruct);
///
///     // extract a couple of values from the status
///     bool filamentOn = status.filamentOn();;
///     double cathodeVoltage = status.cathodeVoltage();
/// @endcode
class GetStatusMethod : public xmlrpc_c::method {
public:
    GetStatusMethod() {
        this->_signature = "S:";
        this->_help = "This method returns the latest status from hcr_xmitd.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        DLOG << "Received 'getStatus' command";
        // Get the latest status from shared memory, and convert it to
        // an xmlrpc_c::value_struct dictionary.
        *retvalP = Xmitter->getStatus().toXmlRpcValue();
    }
};

/// xmlrpc_c::method method to turn on the transmitter klystron filament.
class XmitFilamentOnMethod : public xmlrpc_c::method {
public:
    XmitFilamentOnMethod() {
        this->_signature = "n:";
        this->_help = "This method turns on the transmitter klystron filament.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        ILOG << "Received 'xmitFilamentOn' command";
        Xmitter->setFilamentState(true);    // turn filament on
        *retvalP = xmlrpc_c::value_nil();
    }
};

/// xmlrpc_c::method method to turn off the transmitter klystron filament.
class XmitFilamentOffMethod : public xmlrpc_c::method {
public:
    XmitFilamentOffMethod() {
        this->_signature = "n:";
        this->_help = "This method turns off the transmitter klystron filament.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        ILOG << "Received 'xmitFilamentOff' command";
        Xmitter->setFilamentState(false);    // turn filament off
        *retvalP = xmlrpc_c::value_nil();
    }
};

/// xmlrpc_c::method method to turn on the transmitter high voltage.
class XmitHvOnMethod : public xmlrpc_c::method {
public:
    XmitHvOnMethod() {
        this->_signature = "n:";
        this->_help = "This method turns on the transmitter high voltage.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        ILOG << "Received 'xmitHvOn' command";
        Xmitter->setHvState(true);    // turn HV on
        *retvalP = xmlrpc_c::value_nil();
    }
};

/// xmlrpc_c::method method to turn off the transmitter high voltage.
class XmitHvOffMethod : public xmlrpc_c::method {
public:
    XmitHvOffMethod() {
        this->_signature = "n:";
        this->_help = "This method turns off the transmitter high voltage.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        ILOG << "Received 'xmitHvOff' command";
        Xmitter->setHvState(false);    // turn HV off
        *retvalP = xmlrpc_c::value_nil();
    }
};

/// Print usage information
void
usage(const char* argv0) {
    std::cerr << "Usage: " << argv0 << 
            " [option]... <xmitter_ttydev>" << std::endl;
    std::cerr << OptionsDesc << std::endl;
    logx::LogUsage(std::cerr);
    std::cerr << std::endl;
    std::cerr << "Use ""SimulatedHcrXmitter"" as <xmitter_ttydev> to " << 
            "simulate a transmitter" << std::endl;
}

/// Parse the command line options, removing the successfully parsed bits from
/// argc/argv.
void
parseOptions(int & argc, char** argv)
{
    // get the options
    OptionsDesc.add_options()
            ("help", "Describe options")
            ("foreground", po::bool_switch(&Foreground),
                    "Run in foreground, rather than as a daemon process")
            ("instance", po::value<std::string>(&InstanceName), 
                    "Instance name for procmap")
            ;

    po::variables_map vm;
    po::command_line_parser parser(argc, argv);
    parser.options(OptionsDesc);
    po::parsed_options parsedOpts = parser.run();
    po::store(parsedOpts, vm);
    po::notify(vm);
    
    if (vm.count("help")) {
        usage(argv[0]);
        exit(0);
    }
    
    // Retain only the unparsed args in argv, adjusting argc and argv
    std::vector<std::string> unparsed = 
            po::collect_unrecognized(parsedOpts.options, po::include_positional);
    argc = 1 + unparsed.size();
    for (unsigned int i = 0; i < unparsed.size(); i++) {
        argv[i + 1] = strdup(unparsed[i].c_str());
    }
}


int
main(int argc, char *argv[]) {
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);
    
    // Get our local options
    parseOptions(argc, argv);
    
    // Instantiate our QCoreApplication
    App = new QCoreApplication(argc, argv);

    // Remaining args should just be serial device for the transmitter.
    if (argc != 2) {
        std::cout << "remaining args: ";
        for (int i = 0; i < argc; i++) {
            std::cout << argv[i] << " ";
        }
        std::cout << std::endl;
        usage(argv[0]);
        exit(1);
    }
    
    // Normally we fork off a background process and run as a daemon
    if (! Foreground) {
        pid_t pid = fork();
        if (pid < 0) {
            ELOG << "Error forking: " << strerror(errno);
            exit(1);
        } else if (pid > 0) {
            exit(0);    // parent process exits now, leaving the child in background
        }
    }
    
    // Initialize registration with procmap if instance is specified
    if (InstanceName.size() > 0) {
        PMU_auto_init("hcr_xmitd", InstanceName.c_str(), PROCMAP_REGISTER_INTERVAL);
        ILOG << "Initializing procmap registration as instance '" << 
                InstanceName << "'";
    }

    ILOG << "hcr_xmitd (" << getpid() << ") started";

    // Instantiate and start our transmitter thread, communicating over the
    // given serial port
    PMU_auto_register("instantiating HcrXmitter");
    Xmitter = new HcrXmitter(argv[1]);
    Xmitter->start();
    
    // Initialize our RPC server
    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("getStatus", new GetStatusMethod);
    myRegistry.addMethod("xmitFilamentOn", new XmitFilamentOnMethod);
    myRegistry.addMethod("xmitFilamentOff", new XmitFilamentOffMethod);
    myRegistry.addMethod("xmitHvOn", new XmitHvOnMethod);
    myRegistry.addMethod("xmitHvOff", new XmitHvOffMethod);
    QXmlRpcServerAbyss rpcServer(&myRegistry, HCR_XMITD_PORT);
    
    // catch a control-C or kill to shut down cleanly
    signal(SIGINT, sigHandler);
    signal(SIGTERM, sigHandler);

    /// Set up a timer to periodically register with PMU so it knows we're still
    /// alive.
    QTimer registerTimer;
    registerTimer.setInterval(10000);   // 10000 ms -> 10 s
    QFunctionWrapper updateFuncWrapper(updateRegistration);
    QObject::connect(&registerTimer, SIGNAL(timeout()),
            &updateFuncWrapper, SLOT(callFunction()));
    registerTimer.start();

    // Now just run the application until somebody or something interrupts it
    App->exec();

    // Unregister with procmap
    PMU_auto_unregister();

    // Clean up before exit
    delete(Xmitter);
    ILOG << "hcr_xmitd (" << getpid() << ") exiting";
    return 0;
} 
