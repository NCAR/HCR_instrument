/*
 * AltitudeMonitorDaemon.cpp
 *
 * Daemon which monitors aircraft altitude and acts to protect the radar
 * receiver depending on altitude and whether flying over land or water.
 *
 * Created on: Jul 24, 2014
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
#include <CmigitsSharedMemory.h>
#include <QFunctionWrapper.h>

#include <xmlrpc-c/registry.hpp>
#include <QXmlRpcServerAbyss.h>

LOGGING("AltitudeMonitorDaemon")

namespace po = boost::program_options;

/// Our QApplication
QCoreApplication *App = 0;

/// Signal handler to allow for clean shutdown on SIGINT and SIGTERM
void sigHandler(int sig) {
  ILOG << "Signal received; stopping AltitudeMonitorDaemon.";
  App->quit();
}

// Update our registration with PMU at this interval.
static const int REGISTRATION_INTERVAL_SECS = 60;

// Log a brief status message at this interval.
static const int LOG_STATUS_INTERVAL_SECS = 15;

// Update position at this interval.
static const int POSITION_UPDATE_INTERVAL_MS = 500;

void
updateRegistration() {
    // Make sure we remain registered with PMU, so it knows we're alive
    PMU_auto_register("running");
}

void
logStatus() {
    ILOG << "AltitudeMonitorDaemon still running...";
}

// Our access to the C-MIGITS data shared memory segment.
CmigitsSharedMemory CmShm;

void
updatePosition() {
    uint64_t time3501;
    double latitude;
    double longitude;
    double altitudeMSL;
    CmShm.getLatest3501Data(time3501, latitude, longitude, altitudeMSL);

    ILOG << time3501 << ", lat: " << latitude << ", lon: " << longitude <<
            ", altMSL: " << altitudeMSL;
}

/// @brief xmlrpc_c::method to get status from the AltitudeMonitorDaemon process.
///
/// The method returns a xmlrpc_c::value_struct (dictionary) mapping
/// std::string keys to xmlrpc_c::value values. Pass the dictionary
/// to the AltitudeMonitorStatus(xmlrpc_c::value_struct & dict) constructor to
/// create a usable AltitudeMonitorStatus object.
///
/// Example client usage, where AltitudeMonitorDaemon is running on machine
/// `amdserver`:
/// @code
///     #include <xmlrpc-c/client_simple.hpp>
///     ...
///
///     // Get the status from AltitudeMonitorDaemon on amdserver.local.net
///     // on port 8004
///     xmlrpc_c::simpleClient client;
///     std::string daemonUrl = "http://amdserver.local.net:8004/RPC2")
///
///     xmlrpc_c::value result;
///     try {
///         client.call(daemonUrl, "getStatus", "", &result);
///     } catch (std::exception & e) {
///         std::cerr << "XML-RPC getStatus() error: " << e.what() << std::endl;
///         exit(1);
///     }
///
///     // create an AltitudeMonitorStatus object from the returned dictionary
///     xmlrpc_c::value_struct resultStruct(result);
///     status = AltitudeMonitorStatus(resultStruct);
///
///     // extract a value from the status
///     bool pllLocked = status.pllLocked();;
/// @endcode
class GetStatusMethod : public xmlrpc_c::method {
public:
    GetStatusMethod() {
        this->_signature = "S:";
        this->_help = "This method returns the latest status from AltitudeMonitorDaemon.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        DLOG << "Received 'getStatus' command";
        // Get the latest status from shared memory, and convert it to
        // an xmlrpc_c::value_struct dictionary.
//        *retvalP = Firefly->getStatus().toXmlRpcValue();
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

    // Get AltitudeMonitorDaemon's options
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
        PMU_auto_init("AltitudeMonitorDaemon", instanceName.c_str(), PROCMAP_REGISTER_INTERVAL);
        ILOG << "Initializing procmap registration as instance '" << 
                instanceName << "'";
    }

    ILOG << "AltitudeMonitorDaemon (" << getpid() << ") started";

    PMU_auto_register("initializing");

    // Initialize our RPC server
    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("getStatus", new GetStatusMethod);
    QXmlRpcServerAbyss rpcServer(&myRegistry, xmlrpcPortNum);
    
    // catch a control-C or kill to shut down cleanly
    signal(SIGINT, sigHandler);
    signal(SIGTERM, sigHandler);

    /// Set up a timer to periodically register with PMU so it knows we're still
    /// alive.
    QTimer registrationTimer;
    registrationTimer.setInterval(REGISTRATION_INTERVAL_SECS * 1000);   // interval in ms
    QFunctionWrapper registrationFuncWrapper(updateRegistration);
    QObject::connect(&registrationTimer, SIGNAL(timeout()),
            &registrationFuncWrapper, SLOT(callFunction()));
    registrationTimer.start();

    // Set up a timer to report status information occasionally
    QTimer statusTimer;
    statusTimer.setInterval(LOG_STATUS_INTERVAL_SECS * 1000);
    QFunctionWrapper statusFuncWrapper(logStatus);
    QObject::connect(&statusTimer, SIGNAL(timeout()),
            &statusFuncWrapper, SLOT(callFunction()));
    statusTimer.start();
    
    // Set up a timer to periodically get current position and decide about
    // protective measures.
    QTimer positionUpdateTimer;
    positionUpdateTimer.setInterval(POSITION_UPDATE_INTERVAL_MS);
    QFunctionWrapper updateFuncWrapper(updatePosition);
    QObject::connect(&positionUpdateTimer, SIGNAL(timeout()),
            &updateFuncWrapper, SLOT(callFunction()));
    positionUpdateTimer.start();

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
    ILOG << "AltitudeMonitorDaemon (" << getpid() << ") exiting";
    return 0;
} 