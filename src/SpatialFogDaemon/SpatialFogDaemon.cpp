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
 * SpatialFogDaemon.cpp
 *
 *  Created on: Jun 28, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#include <csignal>
#include <cstring>
#include <string>
#include <QFunctionWrapper.h>
#include <QXmlRpcServerAbyss.h>
#include <logx/Logging.h>
#include <toolsa/pmu.h>

#include <QApplication>
#include <QTimer>

#include <HcrPortNumbers.h>

#include "HcrSpatialFog.h"

LOGGING("SpatialFogDaemon")

// QApplication instance
QApplication * App;

// Our instance name for PMU
static const std::string PmuInstance("ops");

void
usage() {
    std::cerr << "Usage: SpatialFogDaemon [(logx_argument)...] <tty_dev>" <<
            std::endl;
    logx::LogUsage(std::cerr);
}

void stopApp(int sig) {
    if (App) {
        ILOG << "Stopping app; received '" << strsignal(sig) << "' signal";
        App->quit();
    }
}

void
updatePMURegistration() {
    // Make sure we remain registered with PMU, so it knows we're alive
    PMU_auto_register("running");
}

/// XML-RPC method class for getStatus()
class GetStatusMethod : public xmlrpc_c::method {
public:
    GetStatusMethod() {
        this->_signature = "S:";
        this->_help = "Return the latest status/data from the SpatialFogDaemon.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        DLOG << "Executing XML-RPC call to getStatus()";
        // Get the latest status from the FMQ, and convert it to 
        // an xmlrpc_c::value_struct dictionary.
//        *retvalP = .toXmlRpcValue();
    }
};

int
main(int argc, char * argv[]) {
    // Initialize logx, letting it get and strip out its command line arguments
    logx::ParseLogArgs(argc, argv);
    ILOG << "======================";
    ILOG << "SpatialFogDaemon start";

    // Set up to exit on INT or TERM signals sent to the process
    signal(SIGINT, stopApp);
    signal(SIGTERM, stopApp);

    // Create a non-GUI QApplication instance
    App = new QApplication(argc, argv, false);

    // We should have one remaining argument after the program name: the device
    // port to which the Spatial FOG is attached
    if (argc != 2) {
        usage();
        exit(1);
    }

    std::string devName(argv[1]);

    // Create a HcrSpatialFog instance, which will open and read the given
    // device and publish data from the device on a shared memory file message
    // queue (FMQ).
    HcrSpatialFog * spatialFog = new HcrSpatialFog(devName);

    // set up registration with procmap if instance is specified
    if (PmuInstance.size() > 0) {
      PMU_auto_init("SpatialFogDaemon", PmuInstance.c_str(), PROCMAP_REGISTER_INTERVAL);
      ILOG << "procmap instance '" << PmuInstance << "'";
    }

    // Create our XML-RPC method registry and server instance
    PMU_auto_register("instantiating XML-RPC server");
    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("getStatus", new GetStatusMethod);
    QXmlRpcServerAbyss xmlrpcServer(&myRegistry, SPATIALFOGDAEMON_PORT);
        
    // Create a QFunctionWrapper around the updatePMURegistration() function,
    // as well as a QTimer, and use them to cause a call to the function on
    // a periodic basis so that PMU knows we're still alive.
    QFunctionWrapper registrationWrapper(updatePMURegistration);
    QTimer registrationTimer;
    registrationTimer.setInterval(10000);   // 10 s
    QObject::connect(&registrationTimer, SIGNAL(timeout()),
            &registrationWrapper, SLOT(callFunction()));
    registrationTimer.start();

    // Start the app
    App->exec();

    delete(spatialFog);
    delete(App);
    
    ILOG << "SpatialFogDaemon exit";
    ILOG << "======================";
}
