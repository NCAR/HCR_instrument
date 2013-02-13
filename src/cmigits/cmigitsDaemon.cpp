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
#include <CmigitsSharedMemory.h>
#include <xmlrpc-c/base.hpp>
#include <xmlrpc-c/registry.hpp>
#include <xmlrpc-c/server_abyss.hpp>
#include <toolsa/pmu.h>
#include <logx/Logging.h>
LOGGING("cmigitsDaemon")


quint16 ServerPort = 8002;

// Our QApplication instance
QCoreApplication * App = 0;

// Our Cmigits instance
Cmigits * Cm = 0;

// Flag set when exit is requested.
bool ExitRequested = false;

// PMU application instance name
std::string PmuInstance = "ops";   ///< application instance

// Handler for SIGINT and SIGTERM signals.
void
exitHandler(int signal) {
    ExitRequested = true;
}

// Handler for SIGALRM signals.
void
alarmHandler(int signal) {
    // Do nothing. This handler just assures that arrival of the signal doesn't 
    // terminate our process. The intention of the signal is to force the
    // XML-RPC server runOnce() method to return occasionally, even if no
    // request comes in.
    DLOG << "Got itimer ALRM signal";
}

// Create a periodic ALRM signal to break us out of
// xmlrpc_c::serverAbyss::runOnce() so we can process Qt stuff.
void
startXmlrpcWorkAlarm() {
    const struct timeval tv = { 0, 100000 }; // 0.1 s
    const struct itimerval iv = { tv, tv };
    setitimer(ITIMER_REAL, &iv, 0);
}


// Stop the alarm which breaks us out of xmlrpc_c::serverAbyss::runOnce()
// while our server is actually processing an XML-RPC command.
void
stopXmlrpcWorkAlarm() {
    // Stop the periodic timer.
    const struct timeval tv = { 0, 0 }; // zero time stops the timer
    const struct itimerval iv = { tv, tv };
   setitimer(ITIMER_REAL, &iv, 0);
}


class InitializeUsingIwg1Method : public xmlrpc_c::method {
public:
    InitializeUsingIwg1Method() {
        this->_signature = "b:";
        this->_help = "This method causes the C-MIGITS to initialize using IWG1 data.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        // Stop the work alarm while we're working.
        stopXmlrpcWorkAlarm();

        ILOG << "Executing XML-RPC call to initializeUsingIwg1()";
        bool ok = (Cm && Cm->initializeUsingIwg1());
        if (ok) {
            ILOG << "C-MIGITS beginning initialization using IWG1 data";
        } else {
            WLOG << "C-MIGITS initializeUsingIwg1() failed!";
        }
        *retvalP = xmlrpc_c::value_boolean(ok);

        // Restart the work alarm.
        startXmlrpcWorkAlarm();
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

    // Get a writable connection to the shared memory segment where we will
    // put C-MIGITS data.
    PMU_auto_register("opening shared memory segment");
    CmigitsSharedMemory shm(true);
    
    // Open connection to the C-MIGITS device.
    PMU_auto_register("creating Cmigits instance");
    std::string devName(argv[1]);
    Cm = new Cmigits(devName);

    // Register uint16_t and uint64_t as a Qt metatype, since we need to use
    // them as signal/slot arguments below.
    qRegisterMetaType<uint16_t>("uint16_t");
    qRegisterMetaType<uint64_t>("uint64_t");

    // When new status arrives, stuff into shared memory.
    QObject::connect(
            Cm, SIGNAL(new3500Data(uint64_t, uint16_t, bool, bool, bool, uint16_t, uint16_t, uint16_t, uint16_t, uint16_t, float, float, float)),
            &shm, SLOT(storeLatest3500Data(uint64_t, uint16_t, bool, bool, bool, uint16_t, uint16_t, uint16_t, uint16_t, uint16_t, float, float, float)));
    // When new navigation solution arrives, stuff into shared memory.
    QObject::connect(
            Cm, SIGNAL(new3501Data(uint64_t, float, float, float, float, float, float)),
            &shm, SLOT(storeLatest3501Data(uint64_t, float, float, float, float, float, float)));
    // When new attitude arrives, stuff into shared memory.
    QObject::connect(
            Cm, SIGNAL(new3512Data(uint64_t, float, float, float)),
            &shm, SLOT(storeLatest3512Data(uint64_t, float, float, float)));

    // Create our XML-RPC method registry and server instance
    PMU_auto_register("instantiating XML-RPC server");
    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("initializeUsingIwg1", new InitializeUsingIwg1Method);
    xmlrpc_c::serverAbyss xmlrpcServer(myRegistry, ServerPort);
        
    // Set up an interval timer to deliver SIGALRM every 0.01 s. The signal
    // arrival causes the XML-RPC server's runOnce() method to return so that 
    // we can process Qt events on a regular basis.
    signal(SIGALRM, alarmHandler);
    startXmlrpcWorkAlarm();
    
    // Now enter our processing loop
    while (1) {
        PMU_auto_register("running");

        // Handle the next XML-RPC request, or return after receiving a SIGALRM
        // from our timer above
        xmlrpcServer.runOnce();
        
        // Exit when the exit flag gets raised
        if (ExitRequested)
            break;
        
        // Process Qt events
        App->processEvents();
    }
    
    PMU_auto_register("exiting");
    
    return 0;
}
