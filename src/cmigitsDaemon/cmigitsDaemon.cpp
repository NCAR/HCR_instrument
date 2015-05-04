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
#include <unistd.h>
#include <QApplication>
#include <QMetaType>
#include <Cmigits.h>
#include <CmigitsStatus.h>
#include <xmlrpc-c/registry.hpp>
#include <QFunctionWrapper.h>
#include <QXmlRpcServerAbyss.h>
#include <toolsa/pmu.h>
#include <logx/Logging.h>
#include "Ts2CmigitsFmqThread.h"
LOGGING("cmigitsDaemon")


quint16 ServerPort = 8002;

// Our QApplication instance
QCoreApplication * App = 0;

// Our Cmigits instance
Cmigits * Cm = 0;

// Are we playing back from time-series files?
bool Playback;

// PMU application instance name
std::string PmuInstance = "ops";   ///< application instance

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
        // Get the latest status from shared memory, and convert it to 
        // an xmlrpc_c::value_struct dictionary.
        *retvalP = CmigitsStatus::StatusFromFmq().toXmlRpcValue();
    }
};

void
updatePMURegistration() {
    // Make sure we remain registered with PMU, so it knows we're alive
    PMU_auto_register("running");
}

int
main(int argc, char *argv[]) {
    App = new QCoreApplication(argc, argv);

    // Catch INT and TERM signals so we can shut down cleanly on ^C or 'kill'
    signal(SIGINT, exitHandler);
    signal(SIGTERM, exitHandler);
    
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);

    // If the first argument is "--playback", play back from the given list of
    // IWRF time series files instead of getting data from the C-MIGITS
    Playback = false;
    bool goodargs = (argc == 2);
    if (argc > 1 && ! strcmp(argv[1], "--playback")) {
        Playback = true;
        goodargs = (argc > 2);
    }

    if (! goodargs) {
    	std::cerr << "Usage: " << argv[0] << " <tty_dev>" << std::endl;
        std::cerr << "            OR" << std::endl;
        std::cerr << "       " << argv[0] << " --playback <ts_file> [...]" << std::endl;
        std::cerr << "In playback mode, C-MIGITS data from the given file(s)" <<
                std::endl;
        std::cerr << "will be played back until the program is terminated" <<
                std::endl;
    	exit(1);
    }

    ILOG << "Started cmigitsDaemon (" << getpid() << ")" << 
            (Playback ? " in playback mode" : "");

    // set up registration with procmap if instance is specified
    if (PmuInstance.size() > 0) {
      PMU_auto_init("cmigitsDaemon", PmuInstance.c_str(), PROCMAP_REGISTER_INTERVAL);
      ILOG << "procmap instance '" << PmuInstance << "'";
    }

    // Open connection to the C-MIGITS device (or a Ts2CmigitsFmqThread for
    // time-series file playback)
    Ts2CmigitsFmqThread * playbackThread = NULL;
    if (Playback) {
        PMU_auto_register("creating Ts2CmigitsShmThread for playback");
        // Build a vector of file names from the command line
        std::vector<std::string> fileList;
        for (int i = 2; i < argc; i++) {
            fileList.push_back(argv[i]);
        }
        
        // Create the Ts2CmigitsFmqThread, which begins working immediately.
        playbackThread = new Ts2CmigitsFmqThread(fileList);

        // Stop the application when the reader thread is done
        QObject::connect(playbackThread, SIGNAL(finished()), App, SLOT(quit()));
    } else {
        PMU_auto_register("creating Cmigits instance");
        std::string devName(argv[1]);
        Cm = new Cmigits(devName, true);
    }

    // Create our XML-RPC method registry and server instance
    PMU_auto_register("instantiating XML-RPC server");
    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("getStatus", new GetStatusMethod);
    QXmlRpcServerAbyss xmlrpcServer(&myRegistry, ServerPort);
        
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
