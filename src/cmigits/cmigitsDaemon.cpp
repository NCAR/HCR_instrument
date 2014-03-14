/*
 * cmigitsDaemon.cpp
 *
 *  Created on: Oct 31, 2012
 *      Author: burghart
 */
#include <iostream>
#include <cerrno>
#include <cstdlib>
#include <csignal>
#include <QApplication>
#include <QMetaType>
#include <Cmigits.h>
#include <CmigitsStatus.h>
#include <CmigitsSharedMemory.h>
#include <xmlrpc-c/registry.hpp>
#include <QXmlRpcServerAbyss.h>
#include <toolsa/pmu.h>
#include <logx/Logging.h>
LOGGING("cmigitsDaemon")


quint16 ServerPort = 8002;

// Our QApplication instance
QCoreApplication * App = 0;

// Our Cmigits instance
Cmigits * Cm = 0;

// PMU application instance name
std::string PmuInstance = "ops";   ///< application instance

// Handler for SIGINT and SIGTERM signals.
void
exitHandler(int signal) {
    App->quit();
}

class InitializeUsingIwg1Method : public xmlrpc_c::method {
public:
    InitializeUsingIwg1Method() {
        this->_signature = "b:";
        this->_help = "This method causes the C-MIGITS to initialize using IWG1 data.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        ILOG << "Executing XML-RPC call to initializeUsingIwg1()";
        bool ok = (Cm && Cm->initializeUsingIwg1());
        if (ok) {
            ILOG << "C-MIGITS beginning initialization using IWG1 data";
        } else {
            WLOG << "C-MIGITS initializeUsingIwg1() failed!";
        }
        *retvalP = xmlrpc_c::value_boolean(ok);
    }
};

class GetStatusMethod : public xmlrpc_c::method {
public:
    GetStatusMethod() {
        this->_signature = "b:";
        this->_help = "This method returns latest status/data from the C-MIGITS.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        DLOG << "Executing XML-RPC call to getStatus()";
        // Get the latest status from shared memory, and convert it to 
        // an xmlrpc_c::value_struct dictionary.
        *retvalP = CmigitsStatus::StatusFromSharedMemory().toXmlRpcValue();
    }
};

int
main(int argc, char *argv[]) {
    App = new QCoreApplication(argc, argv);

    // Catch INT and TERM signals so we can shut down cleanly on ^C or 'kill'
    signal(SIGINT, exitHandler);
    signal(SIGTERM, exitHandler);
    
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);

    // set up registration with procmap if instance is specified
    if (PmuInstance.size() > 0) {
      PMU_auto_init("cmigitsDaemon", PmuInstance.c_str(), PROCMAP_REGISTER_INTERVAL);
      ILOG << "will register with procmap, instance: " << PmuInstance;
    }

    if (argc != 2) {
    	std::cerr << "Usage: " << argv[0] << " <tty_dev>" << std::endl;
    	exit(1);
    }
    
    ILOG << "Started cmigitsDaemon";

    // Open connection to the C-MIGITS device.
    PMU_auto_register("creating Cmigits instance");
    std::string devName(argv[1]);
    Cm = new Cmigits(devName, true);

    // Create our XML-RPC method registry and server instance
    PMU_auto_register("instantiating XML-RPC server");
    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("initializeUsingIwg1", new InitializeUsingIwg1Method);
    myRegistry.addMethod("getStatus", new GetStatusMethod);
    QXmlRpcServerAbyss xmlrpcServer(&myRegistry, ServerPort);
        
    // Fire up the Qt event loop
    App->exec();
    
    PMU_auto_register("exiting");
    
    delete(Cm);

    return 0;
}
