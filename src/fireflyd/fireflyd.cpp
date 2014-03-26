/*
 * fireflyd.cpp
 *
 * Created on: Mar 26, 2014
 *      Author: burghart
 */

#include <unistd.h>
#include <csignal>
#include <QCoreApplication>
#include <QTimer>

#include <toolsa/pmu.h>
#include <logx/Logging.h>
#include <QFunctionWrapper.h>

#include <xmlrpc-c/registry.hpp>
#include <QXmlRpcServerAbyss.h>

#include "FireFly.h"

LOGGING("fireflyd")

/// Our FireFly
FireFly *Firefly = 0;

/// Our QApplication
QCoreApplication *App = 0;

/// Default instance name for procmap
std::string InstanceName = "ops";

/// Signal handler to allow for clean shutdown on SIGINT and SIGTERM
void sigHandler(int sig) {
  ILOG << "Signal received; stopping fireflyd.";
  App->quit();
}

// Function to update our registration with PMU.
static const int UPDATE_INTERVAL_SECS = 60;

void
updateRegistration() {
    // Make sure we remain registered with PMU, so it knows we're alive
    PMU_auto_register("running");
}

/// @brief xmlrpc_c::method to get status from the fireflyd process.
///
/// The method returns a xmlrpc_c::value_struct (dictionary) mapping
/// std::string keys to xmlrpc_c::value values. Pass the dictionary
/// to the XmitStatus(xmlrpc_c::value_struct & dict) constructor to create a
/// usable XmitStatus object.
///
/// Example client usage, where fireflyd is running on machine `ffserver`:
/// @code
///     #include <xmlrpc-c/client_simple.hpp>
///     ...
///
///     // Get the status from fireflyd on ffserver.local.net
///     // on port 8007
///     xmlrpc_c::simpleClient client;
///     std::string daemonUrl = "http://ffserver.local.net:8007/RPC2")
///
///     xmlrpc_c::value result;
///     try {
///         client.call(daemonUrl, "getStatus", "", &result);
///     } catch (std::exception & e) {
///         std::cerr << "XML-RPC getStatus() error: " << e.what() << std::endl;
///         exit(1);
///     }
///
///     // create a FireFlyStatus object from the returned dictionary
///     xmlrpc_c::value_struct resultStruct(result);
///     status = FireFlyStatus(resultStruct);
///
///     // extract a value from the status
///     bool locked10Mhz = status.locked10Mhz();;
/// @endcode
class GetStatusMethod : public xmlrpc_c::method {
public:
    GetStatusMethod() {
        this->_signature = "S:";
        this->_help = "This method returns the latest status from fireflyd.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        DLOG << "Received 'getStatus' command";
        // Get the latest status from shared memory, and convert it to
        // an xmlrpc_c::value_struct dictionary.
        *retvalP = Firefly->getStatus().toXmlRpcValue();
    }
};


int
main(int argc, char *argv[]) {
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);
    
    // Instantiate our QCoreApplication
    App = new QCoreApplication(argc, argv);

    // Remaining args should just be serial device attached to the FireFly and
    // port number we should use.
    if (argc != 3) {
        std::cerr << "Usage: " << argv[0] << " <tty_dev> <xmlrpc_portnum>" <<
                std::endl;
        exit(1);
    }
    
    // Initialize registration with procmap if instance is specified
    if (InstanceName.size() > 0) {
        PMU_auto_init("fireflyd", InstanceName.c_str(), PROCMAP_REGISTER_INTERVAL);
        ILOG << "Initializing procmap registration as instance '" << 
                InstanceName << "'";
    }

    ILOG << "fireflyd (" << getpid() << ") started";

    // Instantiate and start our transmitter thread, communicating over the
    // given serial port
    PMU_auto_register("instantiating FireFly");
    Firefly = new FireFly(argv[1]);
    Firefly->start();
    
    // Initialize our RPC server
    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("getStatus", new GetStatusMethod);
    int serverPort = atoi(argv[2]);
    QXmlRpcServerAbyss rpcServer(&myRegistry, serverPort);
    
    // catch a control-C or kill to shut down cleanly
    signal(SIGINT, sigHandler);
    signal(SIGTERM, sigHandler);

    /// Set up a timer to periodically register with PMU so it knows we're still
    /// alive.
    QTimer registerTimer;
    registerTimer.setInterval(UPDATE_INTERVAL_SECS * 1000);   // interval in ms
    QFunctionWrapper updateFuncWrapper(updateRegistration);
    QObject::connect(&registerTimer, SIGNAL(timeout()),
            &updateFuncWrapper, SLOT(callFunction()));
    registerTimer.start();

    // Now just run the application until somebody or something interrupts it
    App->exec();

    // Unregister with procmap
    PMU_auto_unregister();

    // Clean up before exit
    delete(Firefly);
    ILOG << "fireflyd (" << getpid() << ") exiting";
    return 0;
} 
