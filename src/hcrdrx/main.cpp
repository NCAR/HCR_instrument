#include <iomanip>
#include <iostream>
#include <string>
#include <sstream>
#include <cstdio>
#include <cmath>
#include <cassert>
#include <sys/timeb.h>
#include <ctime>
#include <cerrno>
#include <csignal>
#include <cstdlib>
#include <unistd.h>
#include <boost/program_options.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>
#include <logx/Logging.h>
#include <toolsa/pmu.h>
#include <HcrPmc730Client.h>
#include <QCoreApplication>

// For configuration management
#include <QtConfig.h>

#include "HcrDrxPub.h"
#include "p7142sd3c.h"
#include "p7142Up.h"

#include "HcrDrxConfig.h"
#include "IwrfExport.h"
#include "StatusGrabber.h"

#include <xmlrpc-c/registry.hpp>
#include <QFunctionWrapper.h>
#include <QXmlRpcServerAbyss.h>

LOGGING("hcrdrx")

using namespace std;
using namespace boost::posix_time;
namespace po = boost::program_options;

std::string _drxConfig;          ///< DRX configuration file
std::string _instance = "ops";   ///< application instance
StatusGrabber * _statusGrabber;        ///< StatusGrabber instance

/// Pentek channels to use for H and V. We use channels 0 and 2 because
/// they exhibit lower noise than channels 1 and 3 when using the DDC8 bitstream
int _chanNums[] = { 0, 2 };
int _nChans = sizeof(_chanNums) / sizeof(*_chanNums);   ///< number of channels

std::vector<HcrDrxPub*> _downThreads(_nChans);  ///< per-channel publishers

int _tsLength;                   ///< The time series length
std::string _gaussianFile = "";  ///< gaussian filter coefficient file
std::string _kaiserFile = "";    ///< kaiser filter coefficient file
IwrfExport* _exporter = 0;       ///< The exporter - IWRF TCP server
bool _simulate;                  ///< Set true for simulate mode
int _simWaveLength;              ///< The simulated data wavelength, in samples
double _simPauseMS;              ///< The number of milliseconds to pause when reading in simulate mode.
bool _freeRun = false;           ///< To allow us to see what is happening on the ADCs
Pentek::p7142sd3c * _sd3c;
QCoreApplication * _app;

std::string _xmitdHost("archiver");     ///< The host on which hcr_xmitd is running
int _xmitdPort = 8000;                  ///< hcr_xmitd's XML-RPC port

std::string _pmc730dHost("localhost");  ///< The host on which HcrPmc730Daemon is running
int _pmc730dPort = 8003;                ///< HcrPmc730Daemon's XML-RPC port

/////////////////////////////////////////////////////////////////////
void sigHandler(int sig) {
  ILOG << "Interrupt received...termination may take a few seconds";
  _app->quit();
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
        ("xmitdPort", po::value<int>(&_xmitdPort), "hcr_xmitd's XML-RPC port")
        ("pmc730dHost", po::value<std::string>(&_pmc730dHost), "Host machine for HcrPmc730Daemon")
        ("pmc730dPort", po::value<int>(&_pmc730dPort), "HcrPmc730Daemon's XML-RPC port")
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
 * @brief xmlrpc_c::method to get status from the hcrdrx process.
 *
 * The method returns a xmlrpc_c::value_struct (dictionary) mapping
 * std::string keys to xmlrpc_c::value values. The dictionary can be
 * passed to the constructor for the DrxStatus class to create a DrxStatus
 * object.
 * 
 * Example client usage, where hcrdrx is running on machine `drxhost`:
 * @code
 *     #include <xmlrpc-c/client_simple.hpp>
 *     #include <DrxStatus.h>
 *     ...
 *
 *     // Execute "getStatus" on drxhost/port 8081
 *     xmlrpc_c::clientSimple client;
 *     xmlrpc_c::value result;
 *     client.call("http://drxhost:8081/RPC2", "getStatus", "", &result);
 *     
 *     // Instantiate a DrxStatus using the returned dictionary
 *     xmlrpc_c::value_struct statusDict(result);
 *     DrxStatus status(statusDict);
 * @endcode
 */
class GetStatusMethod : public xmlrpc_c::method {
public:
    GetStatusMethod() {
        this->_signature = "S:";
        this->_help = "This method returns the latest status from hcrdrx.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        DLOG << "Received 'getStatus' command";
        // Get the latest status from shared memory, and convert it to 
        // an xmlrpc_c::value_struct dictionary.
        *retvalP = DrxStatus(*_sd3c).toXmlRpcValue();
    }
};

/// xmlrpc_c::method to zero the Pentek's position counts for the two reflector
/// motors.
class ZeroPentekMotorCountsMethod : public xmlrpc_c::method {
public:
    ZeroPentekMotorCountsMethod() {
        this->_signature = "n:";
        this->_help = "This method causes the Pentek to zero its counts for the reflector drives.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        ILOG << "Received 'zeroPentekMotorCounts' command";
        _sd3c->zeroMotorCounts();
    }
};

///////////////////////////////////////////////////////////
// How frequently will we call printStatsAndUpdateRegistration?
static const int UPDATE_INTERVAL_SECS = 10;

void
printStatsAndUpdateRegistration() {
    // Make sure we remain registered with PMU, so it knows we're alive
    PMU_auto_register("running");

    // Print data rates and other interesting tidbits
    std::ostringstream ss;
    for (int c = 0; c < _nChans; c++) {
        Pentek::p7142sd3cDn * down = _downThreads[c]->downconverter();
        if (c != 0) {
            ss << "  ";
        }
        ss << std::setprecision(3) << std::setw(5)
           << "chan " << _chanNums[c] << " -- "
           << down->bytesRead() / 1000000.0 / float(UPDATE_INTERVAL_SECS) << " MB/s "
           << " drop:" << down->droppedPulses()
           << " sync:" << down->syncErrors();
    }
    ILOG << ss.str();

    DrxStatus status(*_sd3c);
    ILOG << "Pentek board temp: " << status.pentekBoardTemp();
    ILOG << "Pentek FPGA temp: " << status.pentekFpgaTemp();
}

///////////////////////////////////////////////////////////
// Function called if we wait too long for first data
void
dataWaitTimedOut() {
    ELOG << "***********";
    ELOG << "";
    ELOG << "FIRST DATA NOT SEEN IN 1 SECOND";
    ELOG << "Likely there was no 1 PPS signal to start timers!";
    ELOG << "";
    ELOG << "***********";
    _app->quit();
}

///////////////////////////////////////////////////////////
// Function called when first data arrive
void
onFirstData() {
    DLOG << "First data seen at " << 
            to_simple_string(microsec_clock::universal_time());
}

///////////////////////////////////////////////////////////
// Verify that the system clock offset is less than 0.2 seconds
bool
systemClockOffsetOk() {
    // Use 'ntpq -p' to get clock offset. The peer with a '*' in the first
    // character is the one being used to discipline our system clock, i.e.,
    // the "system peer". The peer is in column 1, and system clock offset 
    // w.r.t. this peer (in ms) is in column 9 of the output.
    std::string ntpqCmd = 
            "ntpq -p | grep -e '^*' | sed 's/ \\+/ /g' | cut -d' ' -f1,9";

    // Open a pipe to read the output from the ntpq command.
    FILE * ntpqPipe = popen(ntpqCmd.c_str(), "r");
    if (! ntpqPipe) {
        ELOG << "Unable to execute command: " << ntpqCmd;
        return(false);
    }

    // Read the system clock offset from command output. If there is no output,
    // no system peer was found.
    float msOffset;
    char peer[40];
    if (fscanf(ntpqPipe, "%s %f", peer, &msOffset) != 2) {
        ELOG << "No NTP system peer found";
        return(false);
    }

    // Offset is meaningless if the peer is 'LOCAL' (self)
    if (! strncmp(peer, "*LOCAL", 6)) {
        ELOG << "NTP peer is currently 'LOCAL' (i.e., self); " <<
                "system clock offset is unknown";
        return(false);
    }
    
    // Determine if the magnitude of the offset is acceptable, then log and
    // return the result.
    float offset = 0.001 * msOffset;    // ms -> s
    bool offsetOk = (fabsf(offset) < 0.2);
    ILOG << "System clock offset is currently " << offset << " s (" <<
            (offsetOk ? "OK" : "BAD") << ")";
    return(offsetOk);
}

///////////////////////////////////////////////////////////
int
main(int argc, char** argv)
{
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);
    ILOG << "hcrdrx (" << getpid() << ") starting";

    // get the configuration parameters from the configuration file
    getConfigParams();

    // parse the command line options, substituting for config params.
    parseOptions(argc, argv);

    // QApplication
    _app = new QCoreApplication(argc, argv);

    // Read the HCR configuration file
    HcrDrxConfig hcrConfig(_drxConfig);
    if (! hcrConfig.isValid()) {
        ELOG << "Exiting on incomplete configuration!";
        exit(1);
    }
    
    // set to ignore SIGPIPE errors which occur when sockets
    // are broken between client and server
    signal(SIGPIPE, SIG_IGN);

    // set up registration with procmap if instance is specified
    if (_instance.size() > 0) {
      PMU_auto_init("hcrdrx", _instance.c_str(), PROCMAP_REGISTER_INTERVAL);
      ILOG << "will register with procmap, instance: " << _instance;
    }

    // Initialize our RPC server on port 8081
    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("getStatus", new GetStatusMethod);
    myRegistry.addMethod("zeroPentekMotorCounts", new ZeroPentekMotorCountsMethod);
    QXmlRpcServerAbyss rpcServer(&myRegistry, 8081);

    if (_simulate)
      ILOG << "*** Operating in simulation mode";

    // If we're starting on 1 PPS, make sure our system time is within 0.2 s
    // of "actual" time. That assures that p7142sd3c will determine the correct
    // data start time.
    if (hcrConfig.start_on_1pps() && ! systemClockOffsetOk()) {
        ELOG << "***********";
        ELOG << "";
        ELOG << "EXITING ON ERROR: bad or unknown system clock offset";
        ELOG << "";
        ELOG << "***********";
        exit(1);
    }

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
    _statusGrabber = new StatusGrabber(_sd3c, _pmc730dHost, _pmc730dPort,
            _xmitdHost, _xmitdPort);
    _statusGrabber->start();

    // create the export object
    _exporter = new IwrfExport(hcrConfig, *_statusGrabber);

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
    
    // Create the down converter threads. The threads are not started at
    // creation, but they do instantiate the down converters.
    assert(_nChans <= HcrDrxPub::N_CHANNELS);
    for (int c = 0; c < _nChans; c++) {
        ILOG << "*** Pentek channel " << _chanNums[c] << " ***";
        _downThreads[c] = new HcrDrxPub(*_sd3c, _chanNums[c], 
                HcrDrxPub::DataChannelType(c), hcrConfig,
                _exporter, _tsLength, _gaussianFile, _kaiserFile,
                _simWaveLength);
    }

    // Create the upConverter.
    // Configure the DAC to use CMIX by fDAC/4 (coarse mixer mode = 9)
    PMU_auto_register("create upconverter");
    Pentek::p7142Up & upConverter = *_sd3c->addUpconverter(_sd3c->adcFrequency(),
            _sd3c->adcFrequency() / 4, 9);

    // catch a control-C or kill to shut down cleanly
    signal(SIGINT, sigHandler);
    signal(SIGTERM, sigHandler);

    for (int c = 0; c < _nChans; c++) {
        // run the downconverter thread. This will cause the
        // thread code to call the run() method, which will
        // start reading data, but should block on the first
        // read since the timers and filters are not running yet.
        _downThreads[c]->start();
        ILOG << "processing enabled on Pentek channel " << _chanNums[c];
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

    // Set up a one-shot timer to make sure we see first data within a 
    // reasonable time. If we're starting on a 1 PPS trigger, data should show
    // up within a second, otherwise it should start flowing immediately.
    // (Neglecting latency in filling the Pentek DMA buffer).
    //
    // We stop the timer as soon as data are seen on _downThreads[0].
    QTimer dataWaitTimeoutTimer;
    dataWaitTimeoutTimer.setInterval(1000);     // 1000 ms -> 1 s
    QFunctionWrapper dataWaitFuncWrapper(dataWaitTimedOut);
    QFunctionWrapper onFirstDataFuncWrapper(onFirstData);
    QObject::connect(&dataWaitTimeoutTimer, SIGNAL(timeout()),
            &dataWaitFuncWrapper, SLOT(callFunction()));
    QObject::connect(_downThreads[0], SIGNAL(firstDataSeen(int)),
            &dataWaitTimeoutTimer, SLOT(stop()));
    QObject::connect(_downThreads[0], SIGNAL(firstDataSeen(int)),
            &onFirstDataFuncWrapper, SLOT(callFunction()));
    dataWaitTimeoutTimer.start();

    // Set up a periodic timer to print statistics and maintain registration
    // with PMU
    QTimer updateTimer;
    updateTimer.setInterval(UPDATE_INTERVAL_SECS * 1000); // interval in ms
    QFunctionWrapper updateFuncWrapper(printStatsAndUpdateRegistration);
    QObject::connect(&updateTimer, SIGNAL(timeout()),
            &updateFuncWrapper, SLOT(callFunction()));
    updateTimer.start();

    // Now just run the QCoreApplication until somebody stops us, usually via
    // a 'kill' command or ^C
    _app->exec();
    
    // We're done
    ILOG << "Shutting down...";
    
    // Stop the downconverter threads
    for (int c = 0; c < _nChans; c++) {
        DLOG << "Stopping thread for channel " << _chanNums[c];
        _downThreads[c]->terminate();
        _downThreads[c]->wait(1000);    // wait up to a second for termination
    }

    // stop the DAC
    upConverter.stopDAC();

    // stop the timers
    _sd3c->timersStartStop(false);

    delete(_sd3c);
    
    // Tell HcrPmc730Daemon to turn off transmitter high voltage and set the
    // HMC operating mode to "Bench Test" before we exit.
    HcrPmc730Client pmc730Client(_pmc730dHost, _pmc730dPort);
    try {
        pmc730Client.xmitHvOff();
        DLOG << "Turned off transmitter HV via HcrPmc730Daemon";
    } catch (std::exception & e) {
        WLOG << "Failed to turn off transmitter HV via HcrPmc730Daemon!: " << e.what();
    }
    
    const HcrPmc730::HmcOperationMode DEFAULT_HMC_MODE = HcrPmc730::HMC_MODE_BENCH_TEST;
    try {
        pmc730Client.setHmcMode(DEFAULT_HMC_MODE);
        DLOG << "Set HMC mode to '" << 
                HcrPmc730::HmcModeNames[DEFAULT_HMC_MODE] << 
                "' via HcrPmc730Daemon";
    } catch (std::exception & e) {
        WLOG << "Failed to set HMC mode to '" << 
                HcrPmc730::HmcModeNames[DEFAULT_HMC_MODE] <<  
                "' via HcrPmc730Daemon: " << e.what();
    }

    // Unregister with procmap
    PMU_auto_unregister();

    ILOG << "hcrdrx (" << getpid() << ") is done\n\n";

    return(0);
}

