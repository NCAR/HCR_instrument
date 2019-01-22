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
 * cmigitsDaemon.cpp
 *
 *  Created on: Oct 31, 2012
 *      Author: burghart
 *
 * Daemon which communicates with a C-MIGITS or SDN500 INS unit and provides
 * the following services:
 *   o Regularly collect status from the INS and provide the latest status to
 *     external processes which call our XML-RPC getStatus() method
 *   o Record contents of all received data packets into a CSV-formatted file
 *   o Publish all INS data in real time to a file message queue (FMQ)
 */
#include <cerrno>
#include <csignal>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <string>
#include <vector>
#include <unistd.h>
#include <boost/program_options.hpp>
#include <QtCore/QCoreApplication>
#include <QtCore/QMetaType>
#include <Cmigits.h>
#include <CmigitsStatus.h>
#include <HcrSharedResources.h>
#include <xmlrpc-c/registry.hpp>
#include <QFunctionWrapper.h>
#include <QXmlRpcServerAbyss.h>
#include <toolsa/pmu.h>
#include <logx/Logging.h>

#include "../HcrSharedResources.h"
#include "Ts2CmigitsFmqThread.h"
LOGGING("cmigitsDaemon")

namespace po = boost::program_options;

// Our QApplication instance
QCoreApplication * App = 0;

// Our Cmigits instance
Cmigits * Cm = 0;

// Handler for SIGINT and SIGTERM signals.
void
exitHandler(int signal) {
    ILOG << "cmigitsDaemon (" << getpid() << ") stopping on signal " << signal;
    App->quit();
}

class GetStatusMethod : public xmlrpc_c::method {
public:
    GetStatusMethod() {
        this->_signature = "b:";
        this->_help = "This method returns latest status/data from the C-MIGITS.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        DLOG << "Executing XML-RPC call to getStatus()";
        // Get the latest status from the shared memory FMQ, and convert it to
        // an xmlrpc_c::value_struct dictionary.
        *retvalP = CmigitsStatus::StatusFromFmq(Cm->fmqUrl()).toXmlRpcValue();
    }
};

void
updatePMURegistration() {
    // Make sure we remain registered with PMU, so it knows we're alive
    PMU_auto_register("running");
}

void
usage(const po::options_description & opts) {
    // brief usage
    std::cout << "Usage: cmigitsDaemon (--1 | --2) [OPTIONS] --antennaOffset <x,y,z> <cmigitsTtyDev>" << std::endl;
    std::cout << "       cmigitsDaemon (--1 | --2) [OPTIONS] --playback <file> [<file> ...]" << std::endl;

    // command line options, as provided to boost::program_options
    std::cout << opts << std::endl;

    // more detailed program information
    std::cout << std::endl;
    std::cout << "cmigitsDaemon communicates with a C-MIGITS or SDN500 INS unit" << std::endl;
    std::cout << "and provides the following services:" << std::endl;
    std::cout << "  o " <<
        "Regularly collect status from the INS and provide the latest status to" << std::endl;
    std::cout << "    " <<
        "external processes which call our XML-RPC getStatus() method" << std::endl;
    std::cout << "    " <<
        "(XML-RPC service is provided on port " << INS1_DAEMON_PORT <<
        " for INS1, or port" << std::endl;
    std::cout << "    " <<
        INS2_DAEMON_PORT << " for INS2)" << std::endl;
    std::cout << "  o " <<
        "Record contents of all received data packets into a CSV-formatted file" << std::endl;
    std::cout << "  o " <<
        "Publish all INS data in real time to a file message queue (FMQ)" << std::endl;
    std::cout << "    " <<
        "(FMQ URL is " << INS1_FMQ_URL << " for INS1" << std::endl;
    std::cout << "    " <<
        "and " << INS2_FMQ_URL << " for INS2)" << std::endl;
    std::cout << std::endl;
}

int
main(int argc, char *argv[]) {
    // First let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);

    // QCoreApplication gets its arguments
    App = new QCoreApplication(argc, argv);

    // Command line options we will display to the user
    po::options_description visible_opts("Options");
    visible_opts.add_options()
            ("help,h", "print usage information and exit")
            ("antennaOffset", po::value<string>(),
                              "<x,y,z> offset in body coordinates from the INS to\n"
                              "the GPS antenna, in cm")
            ("1", "run as INS1")
            ("2", "run as INS2 (different XML-RPC port and FMQ URL)")
            ("playback", "play back from listed file(s)");

    // All options includes the above, plus a "patharg" option which we
    // will hide when showing usage, but need for use as a marker for
    // "positional arguments", i.e., file or device names given on the command
    // line.
    po::options_description all_opts("All");
    all_opts.add(visible_opts).add_options()
            ("patharg", po::value<std::vector<std::string> >());

    // Positional option maps unknown arguments as if they were --patharg <arg>
    po::positional_options_description pos_opts;
    pos_opts.add("patharg", -1);

    po::variables_map vm;
    try {
    po::store(po::command_line_parser(argc, argv).
              options(all_opts).positional(pos_opts).run(), vm);
    } catch (std::exception & e) {
        ELOG << "po::store failure: " << e.what();
    }
    po::notify(vm);

    // If requested, show the usage message and exit
    if (vm.count("help")) {
        usage(visible_opts);
        exit(1);
    }

    // Make sure the user selected either INS1 or INS2, but not both
    if ((vm.count("1") == 0 && vm.count("2") == 0) ||
            (vm.count("1") > 0 && vm.count("2") > 0)) {
        std::cout << "Either --1 or --2 must be given, but not both." <<
                std::endl;
        usage(visible_opts);
        exit(1);
    }

    // Are we running as INS1 or INS2?
    int insNum = (vm.count("1") > 0) ? 1 : 2;

    // Set the pieces which are different for INS1 and INS2
    std::string pmuInstance((insNum == 1) ? "ins1" : "ins2");
    int xmlrpcPort = (insNum == 1) ? INS1_DAEMON_PORT : INS2_DAEMON_PORT;
    std::string csvFilePath = (insNum == 1) ? "/data/hcr/ins1_csv" : "/data/hcr/ins2_csv";
    std::string fmqUrl = (insNum == 1) ? INS1_FMQ_URL : INS2_FMQ_URL;

    // Are we running in playback mode?
    bool playback = vm.count("playback");

    // If not playback, we require --antennaOffset to provide antenna offset
    // in body coordinates from the INS to the GPS antenna, x,y,z in integer
    // cm (e.g., "--antennaOffset -20,5,-18")
    int16_t antennaOffsetX = 0;
    int16_t antennaOffsetY = 0;
    int16_t antennaOffsetZ = 0;
    if (! playback) {
        // Verify we got exactly one --antennaOffset argument
        if (vm.count("antennaOffset") != 1) {
            std::cerr << "If not playback, one '--antennaOffset <x,y,z>' is required!" << std::endl;
            std::cerr << std::endl;
            usage(visible_opts);
            exit(1);
        }
        // Parse 
        if (3 != sscanf(vm["antennaOffset"].as<std::string>().c_str(),
                        "%hd,%hd,%hd", &antennaOffsetX, &antennaOffsetY,
                        &antennaOffsetZ)) {
            std::cerr << "Bad antennaOffset '%s'" << std::endl;
            std::cerr << std::endl;
            usage(visible_opts);
            exit(1);
        }
    }

    // Catch INT and TERM signals so we can shut down cleanly on ^C or 'kill'
    signal(SIGINT, exitHandler);
    signal(SIGTERM, exitHandler);

    // For normal operation, the command line should have single "patharg"
    // with the TTY device for communication with the INS.
    // For playback mode, the command line must have one or more "patharg"-s
    // listing files to be played back.
    std::vector<std::string> pathArgs;
    if (vm.count("patharg")) {
        // Get paths from the command line as a vector of strings
        pathArgs = vm["patharg"].as<std::vector<std::string> >();
    }
    if (! playback) {
        if (pathArgs.size() != 1) {
            std::cerr << "Exactly one TTY device file is required on the " <<
                         "command line!" << std::endl;
            std::cerr << std::endl;
            usage(visible_opts);
            exit(1);
        }
    } else {
        if (pathArgs.size() == 0) {
            std::cerr << "No files for playback were given on the " <<
                         "command line!" << std::endl;
            std::cerr << std::endl;
            usage(visible_opts);
            exit(1);
        }
    }

    ILOG << "Started " << ((insNum == 1) ? "INS1" : "INS2") <<
            " cmigitsDaemon (" << getpid() << ")";
    if (playback) {
    } else {
    }

    // set up registration with procmap if instance is specified
    PMU_auto_init("cmigitsDaemon", pmuInstance.c_str(), PROCMAP_REGISTER_INTERVAL);
    ILOG << "procmap instance '" << pmuInstance << "'";

    // Open connection to the C-MIGITS device (or a Ts2CmigitsFmqThread for
    // time-series file playback)
    Ts2CmigitsFmqThread * playbackThread = NULL;
    if (playback) {
        ILOG << "Playback mode";
        PMU_auto_register("creating Ts2CmigitsShmThread for playback");
        // Create the Ts2CmigitsFmqThread, which begins working immediately.
        playbackThread = new Ts2CmigitsFmqThread(pathArgs, fmqUrl);

        // Stop the application when the reader thread is done
        QObject::connect(playbackThread, SIGNAL(finished()), App, SLOT(quit()));
    } else {
        PMU_auto_register("creating Cmigits instance");
        std::string devName = pathArgs[0];
        ILOG << "Communicating on device " << devName;
        ILOG << "Using INS-to-antenna x,y,z offset (" <<
                antennaOffsetX << " cm, " << antennaOffsetY << " cm, " <<
                antennaOffsetZ << " cm)";
        Cm = new Cmigits(devName,
                         antennaOffsetX, antennaOffsetY, antennaOffsetZ,
                         fmqUrl, csvFilePath);
    }

    // Create our XML-RPC method registry and server instance
    PMU_auto_register("instantiating XML-RPC server");
    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("getStatus", new GetStatusMethod);
    QXmlRpcServerAbyss xmlrpcServer(&myRegistry, xmlrpcPort);
        
    // Create a QFunctionWrapper around the updatePMURegistration() function,
    // as well as a QTimer, and use them to cause a call to the function on
    // a periodic basis so that PMU knows we're still alive.
    QFunctionWrapper registrationWrapper(updatePMURegistration);
    QTimer registrationTimer;
    registrationTimer.setInterval(10000);   // 10 s
    QObject::connect(&registrationTimer, SIGNAL(timeout()),
            &registrationWrapper, SLOT(callFunction()));
    registrationTimer.start();

    // Fire up the Qt event loop
    App->exec();
    
    // Tell procmap we're done
    PMU_auto_unregister();
    
    delete(Cm);
    delete(playbackThread);

    return 0;
}
