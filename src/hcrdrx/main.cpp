#include <iomanip>
#include <iostream>
#include <string>
#include <fcntl.h>
#include <stdio.h>
#include <math.h>
#include <sched.h>
#include <sys/timeb.h>
#include <ctime>
#include <cerrno>
#include <cstdlib>
#include <boost/program_options.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>
#include <csignal>
#include <XmlRpc.h>
#include <logx/Logging.h>
#include <toolsa/pmu.h>

LOGGING("hcrdrx")

// For configuration management
#include <QtConfig.h>

#include "HcrPmc730.h"
#include "HcrDrxPub.h"
#include "p7142sd3c.h"
#include "p7142Up.h"

#include "HcrDrxConfig.h"
#include "IwrfExport.h"
#include "HcrMonitor.h"

using namespace std;
using namespace XmlRpc;
using namespace boost::posix_time;
namespace po = boost::program_options;

std::string _drxConfig;          ///< DRX configuration file
std::string _instance = "ops";   ///< application instance
HcrMonitor * _hcrMonitor;        ///< HcrMonitor instance
int _chans = 2;                  ///< number of channels
int _tsLength;                   ///< The time series length
std::string _gaussianFile = "";  ///< gaussian filter coefficient file
std::string _kaiserFile = "";    ///< kaiser filter coefficient file
IwrfExport* _exporter = 0;       ///< The exporter - IWRF TCP server
bool _simulate;                  ///< Set true for simulate mode
int _simWaveLength;              ///< The simulated data wavelength, in samples
double _simPauseMS;              ///< The number of milliseconds to pause when reading in simulate mode.
bool _freeRun = false;           ///< To allow us to see what is happening on the ADCs
Pentek::p7142sd3c * _sd3c;

std::string _xmitdHost("archiver");///< The host on which hcr_xmitd is running
int _xmitdPort = 8000;           ///< The port on which hcr_xmitd is listening

bool _terminate = false;         ///< set true to signal the main loop to terminate

/////////////////////////////////////////////////////////////////////
void sigHandler(int sig) {
  ILOG << "Interrupt received...termination may take a few seconds";
  _terminate = true;
}

//////////////////////////////////////////////////////////////////////
///
/// get parameters that are specified in the Qt configuration file.
/// These can be overridden by command line specifications.
void getConfigParams()
{

    QtConfig config("HcrDrx", "HcrDrx");

    // set up the default configuration directory path
    std::string HcrDir("/conf/");
    char* e = getenv("HCRDIR");
    if (e) {
        HcrDir = e + HcrDir;
    } else {
        ELOG << "Environment variable HCRDIR must be set.";
        exit(1);
    }

    // get parameters
    _tsLength      = config.getInt   ("Radar/TsLength",     256);
    _simulate      = config.getBool  ("Simulate",           false);
    _simPauseMS    = config.getDouble("SimPauseMs",         0.1);
    _simWaveLength = config.getInt   ("SimWavelength",      5000);
    _freeRun       = config.getBool  ("FreeRun",            false);

}

//////////////////////////////////////////////////////////////////////
//
/// Parse the command line options, and also set some options
/// that are not specified on the command line.
/// @return The runtime options that can be passed to the
/// threads that interact with the RR314.
void parseOptions(int argc,
        char** argv)
{

    // get the options
    po::options_description descripts("Options");
    descripts.add_options()
        ("help", "Describe options")
        ("drxConfig", po::value<std::string>(&_drxConfig), "DRX configuration file")
        ("instance", po::value<std::string>(&_instance), "App instance for procmap")
        ("simulate", "Enable simulation")
        ("simPauseMS",  po::value<double>(&_simPauseMS), "Simulation pause interval between beams (ms)")
        ("xmitdHost", po::value<std::string>(&_xmitdHost), "Host machine for hcr_xmitd")
        ("xmitdPort", po::value<int>(&_xmitdPort), "Port for contacting hcr_xmitd")
        ;
    // If we get an option on the command line with no option name, it
    // is treated like --drxConfig=<option> was given.
    po::positional_options_description pd;
    pd.add("drxConfig", 1);
    
    po::variables_map vm;
    po::store(po:: command_line_parser(argc, argv).options(descripts).positional(pd).run(), vm);
    po::notify(vm);

    if (vm.count("help")) {
        std::cout << "Usage: " << argv[0] << 
                  " [OPTION]... [--drxConfig] <configFile>" << std::endl;
        std::cout << descripts << std::endl;
        exit(0);
    }

    if (vm.count("simulate"))
        _simulate = true;
    if (vm.count("drxConfig") != 1) {
        ELOG << "Exactly one DRX configuration file must be given!";
        exit(1);
    }
}

///////////////////////////////////////////////////////////
/// If the user has root privileges, make the process real-time.
void
makeRealTime()
{
    uid_t id = getuid();

    // don't even try if we are not root.
    if (id != 0) {
        ELOG << "Not root, unable to change scheduling priority";
        return;
    }

    sched_param sparam;
    sparam.sched_priority = 50;

    if (sched_setscheduler(0, SCHED_RR, &sparam)) {
        ELOG << "warning, unable to set scheduler parameters: ";
        ELOG << strerror(errno);
    }
}

///////////////////////////////////////////////////////////
/// @return The current time, in seconds since Jan. 1, 1970.
double nowTime()
{
    struct timeb timeB;
    ftime(&timeB);
    return timeB.time + timeB.millitm/1000.0;
}

///////////////////////////////////////////////////////////
void startUpConverter(Pentek::p7142Up& upConverter, 
        unsigned int pulsewidth_counts) {

    // create the signal
    unsigned int n = pulsewidth_counts * 2;
    int32_t IQ[n];

    for (unsigned int i = 0; i < n/2; i++) {
        IQ[i]   = 0x8000 << 16 | 0x8000;
    }
    for (unsigned int i = n/2; i < n; i++) {
        IQ[i]   = 0x8000 << 16 | 0x8000;
    }
    // load mem2
    upConverter.write(IQ, n);

    // start the upconverter
    upConverter.startDAC();

}

/**
 * @brief Xmlrpc++ method to get status from the hcrdrx process.
 *
 * The method returns a XmlRpc::XmlRpcValue struct (dictionary) mapping
 * std::string keys to XmlRpc::XmlRpcValue values. The dictionary should be
 * passed to the constructor for the DrxStatus class to create a DrxStatus
 * object.
 * 
 * Example client usage, where hcrdrx is running on machine `drxhost`:
 * @code
 *     #include <XmlRpc.h>
 *     ...
 *
 *     // Get the DrxStatus from hcrdrx on drxhost.local.net on port 8081
 *     XmlRpc::XmlRpcClient client("drxhost.local.net", 8081);
 *     const XmlRpc::XmlRpcValue nullParams;
 *     XmlRpc::XmlRpcValue statusDict;
 *     client.execute("getStatus", nullParams, statusDict);
 *     
 *     // Instantiate a DrxStatus using the returned dictionary
 *     DrxStatus status(statusDict);
 *
 *     // extract a value from the status
 *     bool bVal = bool(statusDict["some_bool"]));
 *     double cmigitsTemp = status.cmigitsTemp();
 * @endcode
 */
class GetStatusMethod : public XmlRpcServerMethod {
public:
    GetStatusMethod() : XmlRpcServerMethod("getStatus") {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        retvalP = _hcrMonitor->drxStatus().toXmlRpcValue();
    }
};

/// Xmlrpc++ method to turn on the transmitter klystron filament.
class XmitFilamentOnMethod : public XmlRpcServerMethod {
public:
    XmitFilamentOnMethod() : XmlRpcServerMethod("xmitFilamentOn") {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        ILOG << "Received 'xmitFilamentOn' command";
        HcrPmc730::setXmitterFilamentOn(true);
    }
};

/// Xmlrpc++ method to turn off the transmitter klystron filament.
class XmitFilamentOffMethod : public XmlRpcServerMethod {
public:
    XmitFilamentOffMethod() : XmlRpcServerMethod("xmitFilamentOff") {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        ILOG << "Received 'xmitFilamentOff' command";
        HcrPmc730::setXmitterFilamentOn(false);
    }
};

/// Xmlrpc++ method to turn on the transmitter high voltage.
class XmitHvOnMethod : public XmlRpcServerMethod {
public:
    XmitHvOnMethod() : XmlRpcServerMethod("xmitHvOn") {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        ILOG << "Received 'xmitHvOn' command";
        HcrPmc730::setXmitterHvOn(true);
    }
};

/// Xmlrpc++ method to turn off the transmitter high voltage.
class XmitHvOffMethod : public XmlRpcServerMethod {
public:
    XmitHvOffMethod() : XmlRpcServerMethod("xmitHvOff") {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        ILOG << "Received 'xmitHvOff' command";
        HcrPmc730::setXmitterHvOn(false);
    }
};

/// Xmlrpc++ method to set HMC mode.
class SetHmcModeMethod : public XmlRpcServerMethod {
public:
    SetHmcModeMethod() : XmlRpcServerMethod("setHmcMode") {}
    void execute(XmlRpcValue & args, XmlRpcValue & retvalP) {
        int iMode = int(args[0]);
        HcrPmc730::HmcOperationMode mode = static_cast<HcrPmc730::HmcOperationMode>(int(iMode));
        ILOG << "Received 'setHmcMode(" << iMode << ")' command";
        HcrPmc730::setHmcOperationMode(mode);
    }
};

/// Xmlrpc++ method to zero the Pentek's position counts for the two reflector
/// motors.
class ZeroPentekMotorCountsMethod : public XmlRpcServerMethod {
public:
    ZeroPentekMotorCountsMethod() : XmlRpcServerMethod("zeroPentekMotorCounts") {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        ILOG << "Received 'zeroPentekMotorCounts' command";
        _sd3c->zeroMotorCounts();
    }
};

///////////////////////////////////////////////////////////
int
main(int argc, char** argv)
{
    // try to change scheduling to real-time
    makeRealTime();

    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);

    // get the configuration parameters from the configuration file
    getConfigParams();

    // parse the command line options, substituting for config params.
    parseOptions(argc, argv);

    // Read the HCR configuration file
    HcrDrxConfig hcrConfig(_drxConfig);
    if (! hcrConfig.isValid()) {
        ELOG << "Exiting on incomplete configuration!";
        exit(1);
    }
    
    // Make sure our KaPmc730 is created in simulation mode if requested
    HcrPmc730::doSimulate(hcrConfig.simulate_pmc730());
    
    // Just refer to theHcrPmc730() to instantiate the singleton.
    HcrPmc730::theHcrPmc730();
    
    // Initialize output lines.
    HcrPmc730::setPentekRotationZero(false);
    HcrPmc730::setPentekTiltZero(false);
    HcrPmc730::setXmitterFilamentOn(false);
    HcrPmc730::setXmitterHvOn(false);
    HcrPmc730::setHmcOperationMode(HcrPmc730::HMC_CORNER_REFLECTOR_CAL);

    // set to ignore SIGPIPE errors which occur when sockets
    // are broken between client and server
    signal(SIGPIPE, SIG_IGN);

    // set up registration with procmap if instance is specified
    if (_instance.size() > 0) {
      PMU_auto_init("hcrdrx", _instance.c_str(), PROCMAP_REGISTER_INTERVAL);
      ILOG << "will register with procmap, instance: " << _instance;
    }

    // Initialize our RPC server on port 8081
    XmlRpc::XmlRpcServer rpcServer;
    rpcServer.addMethod(new GetStatusMethod());
    rpcServer.addMethod(new XmitFilamentOnMethod());
    rpcServer.addMethod(new XmitFilamentOffMethod());
    rpcServer.addMethod(new XmitHvOnMethod());
    rpcServer.addMethod(new XmitHvOffMethod());
    rpcServer.addMethod(new SetHmcModeMethod());
    rpcServer.addMethod(new ZeroPentekMotorCountsMethod());
    if (! rpcServer.bindAndListen(8081)) {
        ELOG << "Failed to initialize XmlRpcServer!";
        exit(1);
    }
    rpcServer.enableIntrospection(true);

    if (_simulate)
      ILOG << "*** Operating in simulation mode";

    // Instantiate our p7142sd3c
    _sd3c = new Pentek::p7142sd3c(_simulate, hcrConfig.tx_delay(),
        hcrConfig.tx_pulse_width(), hcrConfig.prt1(), hcrConfig.prt2(),
        hcrConfig.staggered_prt(), hcrConfig.gates(), 1, _freeRun, 
        Pentek::p7142sd3c::DDC8DECIMATE, hcrConfig.start_on_1pps(), 
        _simPauseMS);
    
    if (! _sd3c->ok()) {
        ELOG << "P7142 was not opened successfully!";
        abort();
    }
    
    // Start our status monitoring thread.
    _hcrMonitor = new HcrMonitor(_sd3c, _xmitdHost, _xmitdPort);
    _hcrMonitor->start();

    // create the export object
    _exporter = new IwrfExport(hcrConfig, *_hcrMonitor);

    // We use SD3C's first general purpose timer for transmit pulse modulation
    // The width of the modulation pulse is transmit pulse width + 272 ns,
    // where the 272 ns was empirically measured.
    double pulseModWidth = hcrConfig.tx_pulse_width() + 2.72e-7;
    _sd3c->setGPTimer0(hcrConfig.tx_pulse_mod_delay(), pulseModWidth);
    
    // General purpose timer 1 (SD3C timer 5) is used for EMS switch timing.
    // Use 800 ns + transmit pulse width + transmit delay
    PMU_auto_register("timers enable");
    _sd3c->setGPTimer1(0.0,
        800e-9 + hcrConfig.tx_pulse_width() + hcrConfig.tx_delay());
    
    // Create (but don't yet start) the downconversion threads.
    
    // Create the down converter threads. The threads are not run at creation, 
    // but they do instantiate the down converters.
    std::vector<HcrDrxPub*> downThreads(_chans);

    for (int c = 0; c < _chans; c++) {
        ILOG << "*** Channel " << c << " ***";
        downThreads[c] = new HcrDrxPub(*_sd3c, c, hcrConfig, _exporter, _tsLength,
                _gaussianFile, _kaiserFile, _simWaveLength);
    }

    // Create the upConverter.
    // Configure the DAC to use CMIX by fDAC/4 (coarse mixer mode = 9)
    PMU_auto_register("create upconverter");
    Pentek::p7142Up & upConverter = *_sd3c->addUpconverter(_sd3c->adcFrequency(),
            _sd3c->adcFrequency() / 4, 9);

    // catch a control-C or kill to shut down cleanly
    signal(SIGINT, sigHandler);
    signal(SIGTERM, sigHandler);

    for (int c = 0; c < _chans; c++) {
        // run the downconverter thread. This will cause the
        // thread code to call the run() method, which will
        // start reading data, but should block on the first
        // read since the timers and filters are not running yet.
        downThreads[c]->start();
        ILOG << "processing enabled on channel " << c;
    }

    // wait awhile, so that the threads can all get to the first read.
    struct timespec sleepTime = { 1, 0 }; // 1 second, 0 nanoseconds
    while (nanosleep(&sleepTime, &sleepTime)) {
        if (errno != EINTR) {
            ELOG << "Error " << errno << " from nanosleep().  Aborting.";
            abort();
        } else {
            // We were interrupted. Return to sleeping until the interval is done.
            continue;
        }
    }

    // all of the filters are started by any call to
    // start filters(). So just call it for channel 0
    PMU_auto_register("starting filters");
    _sd3c->startFilters();

    // Load the DAC memory bank 2, clear the DACM fifo, and enable the 
    // DAC memory counters. This must take place before the timers are started.
    PMU_auto_register("starting upconverter");
    startUpConverter(upConverter, _sd3c->txPulseWidthCounts());

    // start the IWRF export
    PMU_auto_register("start export");
    _exporter->start();

    // Start the timers, which will allow data to flow.
    _sd3c->timersStartStop(true);

    double startTime = nowTime();

    while (1) {
        for (int i = 0; i < 100; i++) {
            // check for the termination request
            if (_terminate) {
                break;
            }
            // handle XML-RPC commands for 0.1 second
            rpcServer.work(0.1);
        }
        if (_terminate) {
            break;
        }

        double currentTime = nowTime();
        double elapsed = currentTime - startTime;
        startTime = currentTime;

        std::vector<long> bytes(_chans);
        std::vector<unsigned long> droppedPulses(_chans);
        std::vector<unsigned long> syncErrors(_chans);
        
        for (int c = 0; c < _chans; c++) {
            Pentek::p7142sd3cDn * down = downThreads[c]->downconverter();
            bytes[c] = down->bytesRead();
            droppedPulses[c] = down->droppedPulses();
            syncErrors[c] = down->syncErrors();
        }
        
        for (int c = 0; c < _chans; c++) {
            if (c != 0) {
                std::cout << "  ";
            }
            std::cout << std::setprecision(3) << std::setw(5)
                      << "chan " << c << " -- "
                      << bytes[c]/1000000.0/elapsed << " MB/s "
                      << " drop:" << droppedPulses[c]
                      << " sync:" << syncErrors[c];
        }
        std::cout << std::endl;

        DrxStatus status = _hcrMonitor->drxStatus();
//        std::cout << "detectedRfPower: " << status.detectedRfPower() << std::endl;
        std::cout << "pvForePressure: " << status.pvForePressure() << std::endl;
//        std::cout << "pvAftPressure: " << status.pvAftPressure() << std::endl;
        std::cout << "ploTemp: " << status.ploTemp() << std::endl;
        std::cout << "eikTemp: " << status.eikTemp() << std::endl;
        std::cout << "vLnaTemp: " << status.vLnaTemp() << std::endl;
//        std::cout << "hLnaTemp: " << status.hLnaTemp() << std::endl;
//        std::cout << "polarizationSwitchTemp: " << status.polarizationSwitchTemp() << std::endl;
//        std::cout << "rfDetectorTemp: " << status.rfDetectorTemp() << std::endl;
        std::cout << "noiseSourceTemp: " << status.noiseSourceTemp() << std::endl;
        std::cout << "ps28VTemp: " << status.ps28VTemp() << std::endl;
        std::cout << "rdsInDuctTemp: " << status.rdsInDuctTemp() << std::endl;
        std::cout << "cmigitsTemp: " << status.cmigitsTemp() << std::endl;
        std::cout << "tiltMotorTemp: " << status.tiltMotorTemp() << std::endl;
        std::cout << "rotationMotorTemp: " << status.rotationMotorTemp() << std::endl;
        std::cout << "tailconeTemp: " << status.tailconeTemp() << std::endl;
        std::cout << "psVoltage: " << status.psVoltage() << std::endl;
        std::cout << "locked15_5GHzPLO: " << status.locked15_5GHzPLO() << std::endl;
        std::cout << "locked1250MHzPLO: " << status.locked1250MHzPLO() << std::endl;
        std::cout << "modPulseDisabled: " << status.modPulseDisabled() << std::endl;
        std::cout << "emsPowerError: " << status.emsPowerError() << std::endl;
        std::cout << "waveguideSwitchError: " << status.waveguideSwitchError() << std::endl;
//        std::cout << "rdsXmitterFilamentOn: " << status.rdsXmitterFilamentOn() << std::endl;
//        std::cout << "rdsXmitterHvOn: " << status.rdsXmitterHvOn() << std::endl;
    }
    
    ILOG << "Shutting down...";
    
    // Stop the downconverter threads
    for (int c = 0; c < _chans; c++) {
        ILOG << "Stopping thread for channel " << c;
        downThreads[c]->terminate();
        downThreads[c]->wait(1000);    // wait up to a second for termination
    }

    // stop the DAC
    upConverter.stopDAC();

    // stop the timers
    _sd3c->timersStartStop(false);

    delete(_sd3c);
    
    return(0);
}

