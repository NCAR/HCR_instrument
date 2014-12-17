/*
 * fireflyd.cpp
 *
 * Created on: Mar 26, 2014
 *      Author: burghart
 */

#include <unistd.h>
#include <csignal>
#include <sstream>
#include <boost/program_options.hpp>
#include <QCoreApplication>
#include <QTimer>

#include <toolsa/pmu.h>
#include <logx/Logging.h>
#include <QFunctionWrapper.h>

#include <xmlrpc-c/registry.hpp>
#include <QXmlRpcServerAbyss.h>

#include "FireFly.h"

LOGGING("fireflyd")

namespace po = boost::program_options;

/// Our FireFly
FireFly *Firefly = 0;

/// Our QApplication
QCoreApplication *App = 0;

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

void
logStatus() {
    FireFlyStatus status = Firefly->getStatus();
    if (status.deviceResponding()) {
        ILOG << "PLL " << (status.pllLocked() ? "locked" : "NOT LOCKED") <<
                ", health status: 0x" << std::hex << status.healthStatus() <<
                (status.configError() ? ", DEVICE CONFIG ERROR!" : "");
        ILOG << "1 PPS offset from GPS: " << status.timeDiff1PPS() << " s";
        ILOG << "Frequency error estimate: " << status.freqErrorEstimate();
    } else {
        ILOG << "FireFly-IIA device is not currently responding!";
    }
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
///     bool pllLocked = status.pllLocked();;
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

    // tty device name
    std::string devName("/dev/ttyS2");

    // XML-RPC server port number
    int xmlrpcPortNum = 8001;

    // procmap instance name
    std::string instanceName("ops");

    // Get fireflyd's options
    po::options_description opts("Options");
    opts.add_options()
        ("help,h", "Describe options")
        ("instance,i", po::value<std::string>(&instanceName)->default_value(""),
                "instance name for procmap connection")
        ("devName,d", po::value<std::string>(&devName)->default_value("/dev/ttyS2"),
                "tty device name for FireFly-IIA connection")
        ("xmlrpcPortNum,x", po::value<int>(&xmlrpcPortNum)->default_value(8001),
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
        PMU_auto_init("fireflyd", instanceName.c_str(), PROCMAP_REGISTER_INTERVAL);
        ILOG << "Initializing procmap registration as instance '" << 
                instanceName << "'";
    }

    ILOG << "fireflyd (" << getpid() << ") started";

    // Instantiate a FireFly communication thread, using the given serial port
    PMU_auto_register("instantiating FireFly");
    Firefly = new FireFly(devName);
    
    // Initialize our RPC server
    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("getStatus", new GetStatusMethod);
    QXmlRpcServerAbyss rpcServer(&myRegistry, xmlrpcPortNum);
    
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

    // Set up a timer to report status information occasionally
    QTimer statusTimer;
    statusTimer.setInterval(15000); // 15 s
    QFunctionWrapper statusFuncWrapper(logStatus);
    QObject::connect(&statusTimer, SIGNAL(timeout()),
            &statusFuncWrapper, SLOT(callFunction()));
    statusTimer.start();

    // Now just run the application until somebody or something interrupts it
    try {
        App->exec();
    } catch (std::exception & e) {
        ELOG << "Bailing out on exception: " << e.what();
    } catch (...) {
        ELOG << "Bailing out on exception";
    }

    // Unregister with procmap
    PMU_auto_unregister();

    // Clean up before exit
    delete(Firefly);
    ILOG << "fireflyd (" << getpid() << ") exiting";
    return 0;
} 
