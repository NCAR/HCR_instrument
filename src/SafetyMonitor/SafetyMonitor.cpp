/*
 * SafetyMonitor.cpp
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
#include <QCoreApplication>
#include <QTimer>

#include <toolsa/pmu.h>
#include <logx/Logging.h>
#include <CmigitsSharedMemory.h>
#include <HcrPmc730Client.h>
#include <QFunctionWrapper.h>

#include <xmlrpc-c/client_simple.hpp>
#include <xmlrpc-c/registry.hpp>
#include <QXmlRpcServerAbyss.h>

LOGGING("SafetyMonitor")

namespace po = boost::program_options;

/// Our QApplication
QCoreApplication *App = 0;

/// Signal handler to allow for clean shutdown on SIGINT and SIGTERM
void sigHandler(int sig) {
  ILOG << "Signal received; stopping SafetyMonitor.";
  App->quit();
}

// Update our registration with PMU at this interval.
static const int REGISTRATION_INTERVAL_SECS = 60;

// Log a brief status message at this interval.
static const int LOG_STATUS_INTERVAL_SECS = 15;

// Check state at this interval.
static const int CHECK_INTERVAL_MSECS = 1000;

// XML-RPC client instance
xmlrpc_c::clientSimple _XmlRpcClient;

// TerrainHtServer XML-RPC URL
const std::string _TerrainHtServerURL = "http://archiver:9090/RPC2";

void
updateRegistration() {
    // Make sure we remain registered with PMU, so it knows we're alive
    PMU_auto_register("running");
}

void
logStatus() {
    ILOG << "SafetyMonitor still running...";
}

// Access to the C-MIGITS data shared memory segment.
CmigitsSharedMemory _CmShm;

// Surface types
typedef enum {
    SURFACE_LAND,
    SURFACE_WATER,
    SURFACE_UNKNOWN
} SurfaceType;

static const double BAD_AGL_ALTITUDE = -999.;

// Variables to be included in SafetyMonitor's status
double _AltitudeAGL = BAD_AGL_ALTITUDE;
SurfaceType _SurfType = SURFACE_UNKNOWN;
bool _TransmitRestrictedByAlt = false;

// Check aircraft altitude AGL and react if it's low enough for ground return
// to damage the receiver LNAs.
void
checkAltitude() {
    _AltitudeAGL = BAD_AGL_ALTITUDE;
    _SurfType = SURFACE_UNKNOWN;
    
    // Get instrument latitude, longitude, and MSL altitude from the C-MIGITS
    uint64_t time3501;
    double latitude;
    double longitude;
    double altitudeMSL;
    _CmShm.getLatest3501Data(time3501, latitude, longitude, altitudeMSL);
    if (time3501 == 0) {
        WLOG << "No current data available from C-MIGITS";
    } else {
        ILOG << time3501 << ", lat: " << latitude << ", lon: " << longitude <<
                ", altMSL: " << altitudeMSL;

        // Get surface altitude MSL from the TerrainHtServer
        try {
            xmlrpc_c::value result;
            _XmlRpcClient.call(_TerrainHtServerURL, "get.height", "dd", &result, 
                    latitude, longitude);
            
            // The value returned should be a dictionary
            std::map<std::string, xmlrpc_c::value> dict =
              static_cast<std::map<std::string, xmlrpc_c::value> >(xmlrpc_c::value_struct(result));
            
            // First see if TerrainHtServer reported an error
            bool error = xmlrpc_c::value_boolean(dict["isError"]);
            if (error) {
                WLOG << std::fixed << std::setprecision(4) << 
                        "TerrainHtServer returned an error for lat " << latitude << 
                        "/lon " << longitude;
            } else {
                // Get the surface altitude above MSL then calculate aircraft height 
                // above the surface
                double surfaceAltMSL = xmlrpc_c::value_double(dict["heightM"]);
                _AltitudeAGL = altitudeMSL - surfaceAltMSL;
                
                // Over land or water?
                bool overWater = xmlrpc_c::value_boolean(dict["isWater"]);
                _SurfType = overWater ? SURFACE_WATER : SURFACE_LAND;
                
                // Log what we got
                ILOG << "Sensor height AGL " << _AltitudeAGL << " m (over " << 
                        (overWater ? "water" : "land") << ")";
            }
        } catch (std::exception & e) {
            WLOG << "Error on TerrainHtServer get.height() call: " << e.what();
        }
    }
}

// Pointer to current status from HcrPmc730, or NULL if status is too old.
HcrPmc730Status * _HcrPmc730Status = 0;

// Check pressure vessel pressure and react if it's too low for transmitter
// operation.
void
checkPVPressure() {
    if (_HcrPmc730Status) {
        ILOG << "PV pressure " << _HcrPmc730Status->pvForePressure() << " hPa";
    } else {
        WLOG << "No current HcrPmc730 status for PV pressure";
    }
}


void
updateHcrPmc730Status() {
    static HcrPmc730Client * client = 0;
    static HcrPmc730Status status(true);
    
    if (! client) {
        client = new HcrPmc730Client("rds", 8003);
    }
    
    try {
        status = client->getStatus();
        _HcrPmc730Status = & status;
    } catch (std::exception & e) { 
        WLOG << "Failed to get HcrPmc730 status: " << e.what();
        _HcrPmc730Status = NULL;
    }
}

// Perform the periodic safety checks
void
doChecks() {
    // Check aircraft AGL altitude
    checkAltitude();
    // Get status from HcrPmc730Daemon
    updateHcrPmc730Status();
    // Check pressure vessel pressure
    checkPVPressure();
}

/// @brief xmlrpc_c::method to get status from the SafetyMonitor process.
///
/// The method returns a xmlrpc_c::value_struct (dictionary) mapping
/// std::string keys to xmlrpc_c::value values. Pass the dictionary
/// to the SafetyMonitorStatus(xmlrpc_c::value_struct & dict) constructor to
/// create a usable SafetyMonitorStatus object.
///
/// Example client usage, where SafetyMonitor is running on machine
/// `smserver`:
/// @code
///     #include <xmlrpc-c/client_simple.hpp>
///     ...
///
///     // Get the status from SafetyMonitor on smserver.local.net
///     // on port 8004
///     xmlrpc_c::simpleClient client;
///     std::string daemonUrl = "http://smserver.local.net:8004/RPC2")
///
///     xmlrpc_c::value result;
///     try {
///         client.call(daemonUrl, "getStatus", "", &result);
///     } catch (std::exception & e) {
///         std::cerr << "XML-RPC getStatus() error: " << e.what() << std::endl;
///         exit(1);
///     }
///
///     // create a SafetyMonitorStatus object from the returned dictionary
///     xmlrpc_c::value_struct resultStruct(result);
///     status = SafetyMonitorStatus(resultStruct);
///
///     // extract a value from the status
///     bool pllLocked = status.pllLocked();;
/// @endcode
class GetStatusMethod : public xmlrpc_c::method {
public:
    GetStatusMethod() {
        this->_signature = "S:";
        this->_help = "This method returns status from SafetyMonitor.";
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

    // Get SafetyMonitor's options
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
        PMU_auto_init("SafetyMonitor", instanceName.c_str(), PROCMAP_REGISTER_INTERVAL);
        ILOG << "Initializing procmap registration as instance '" << 
                instanceName << "'";
    }

    ILOG << "SafetyMonitor (" << getpid() << ") started";

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
    
    // Set up a timer to periodically get current state and apply protective 
    // measures if necessary.
    QTimer checkTimer;
    checkTimer.setInterval(CHECK_INTERVAL_MSECS);
    QFunctionWrapper doChecksFuncWrapper(doChecks);
    QObject::connect(&checkTimer, SIGNAL(timeout()),
            &doChecksFuncWrapper, SLOT(callFunction()));
    checkTimer.start();

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
    ILOG << "SafetyMonitor (" << getpid() << ") exiting";
    return 0;
} 
