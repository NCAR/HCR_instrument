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

#include <CmigitsSharedMemory.h>
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
    std::string instanceName("ops");

    // Get HcrMonitor's options
    po::options_description opts("Options");
    opts.add_options()
        ("help,h", "Describe options")
        ("instance,i",
                po::value<std::string>(&instanceName)->default_value(""),
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
    QXmlRpcServerAbyss rpcServer(&myRegistry, xmlrpcPortNum);
    
    // Start a thread to get HcrPmc730Daemon status on a regular basis.
    HcrPmc730StatusThread hcrPmc730StatusThread("localhost", 8003);
    hcrPmc730StatusThread.start();
    
    // Start a thread to get MotionControlDaemon status on a regular basis
    MotionControlStatusThread mcStatusThread("localhost", 8080);
    mcStatusThread.start();
    
    // MaxPowerClient instance
    MaxPowerClient maxPowerClient("localhost", 8111);
    maxPowerClient.start();
    
    // Instantiate the object which will monitor pressure and control the
    // Active Pressurization System (APS)
    TheApsControl = new ApsControl(hcrPmc730StatusThread);
    
    // Instantiate the object which will implement safety monitoring for the
    // transmitter
    TheTransmitControl = new TransmitControl(hcrPmc730StatusThread, mcStatusThread);
    
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
