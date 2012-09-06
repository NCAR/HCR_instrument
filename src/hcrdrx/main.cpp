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
std::string _instance;           ///< application instance
HcrMonitor * _hcrMonitor;        ///< HcrMonitor instance
int _chans = 2;                  ///< number of channels
int _tsLength;                   ///< The time series length
std::string _gaussianFile = "";  ///< gaussian filter coefficient file
std::string _kaiserFile = "";    ///< kaiser filter coefficient file
IwrfExport* _exporter = 0;       ///< The exporter - IWRF TCP server
bool _simulate;                  ///< Set true for simulate mode
int _simWaveLength;              ///< The simulated data wavelength, in samples
double _simPauseMS;              ///< The number of millisecnds to pause when reading in simulate mode.
bool _freeRun = false;           ///< To allow us to see what is happening on the ADCs

std::string _xmitdHost("hcrdrx");///< The host on which hcr_xmitd is running
int _xmitdPort = 8080;           ///< The port on which hcr_xmitd is listening

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
 * @brief Xmlrpc++ method to get transmitter status from hcr_xmitd.
 *
 * The method returns a XmlRpc::XmlRpcValue struct (dictionary) mapping
 * std::string keys to XmlRpc::XmlRpcValue values. The dictionary will
 * contain:
 * <table border>
 *   <tr>
 *     <td><b>key</b></td>
 *     <td><b>value type</b></td>
 *     <td><b>value</b></td>
 *   </tr>
 *   <tr>
 *     <td>detectedRfPower</td>
 *     <td>double</td>
 *     <td>transmit pulse power from the Mi-Wave 950W RF detector, dBm</td>
 *   </tr>
 *   <tr>
 *     <td>pvForePressure</td>
 *     <td>double</td>
 *     <td>pressure in the fore end of the pressure vessel, hPa</td>
 *   </tr>
 *   <tr>
 *     <td>pvAftPressure</td>
 *     <td>double</td>
 *     <td>pressure in the aft end of the pressure vessel, hPa</td>
 *   </tr>
 *   <tr>
 *     <td>ploTemp</td>
 *     <td>double</td>
 *     <td>temperature of the 93 GHz phase-locked oscillator, deg C</td>
 *   </tr>
 *   <tr>
 *     <td>eikTemp</td>
 *     <td>double</td>
 *     <td>temperature of the Extended Interaction Klystron (EIK), deg C</td>
 *   </tr>
 *   <tr>
 *     <td>vLnaTemp</td>
 *     <td>double</td>
 *     <td>temperature of the vertical channel LNA, deg C</td>
 *   </tr>
 *   <tr>
 *     <td>hLnaTemp</td>
 *     <td>double</td>
 *     <td>temperature of the horizontal channel LNA, deg C</td>
 *   </tr>
 *   <tr>
 *     <td>polarizationSwitchTemp</td>
 *     <td>double</td>
 *     <td>temperature of the polarization switch, deg C</td>
 *   </tr>
 *   <tr>
 *     <td>rfDetectorTemp</td>
 *     <td>double</td>
 *     <td>temperature of the Mi-Wave 950W RF detector, deg C</td>
 *   </tr>
 *   <tr>
 *     <td>noiseSourceTemp</td>
 *     <td>double</td>
 *     <td>temperature of the noise source, deg C</td>
 *   </tr>
 *   <tr>
 *     <td>ps28VTemp</td>
 *     <td>double</td>
 *     <td>temperature of the 28 V power supply, deg C</td>
 *   </tr>
 *   <tr>
 *     <td>rdsInDuctTemp</td>
 *     <td>double</td>
 *     <td>temperature at the input air duct for the remote data system (RDS), deg C</td>
 *   </tr>
 *   <tr>
 *     <td>rotationMotorTemp</td>
 *     <td>double</td>
 *     <td>temperature of the reflector rotation motor, deg C</td>
 *   </tr>
 *   <tr>
 *     <td>tiltMotorTemp</td>
 *     <td>double</td>
 *     <td>temperature of the reflector tilt motor, deg C</td>
 *   </tr>
 *   <tr>
 *     <td>cmigitsTemp</td>
 *     <td>double</td>
 *     <td>temperature of the C-MIGITS inertial navigation system, deg C</td>
 *   </tr>
 *   <tr>
 *     <td>tailconeTemp</td>
 *     <td>double</td>
 *     <td>ambient temperature in the tailcone, deg C</td>
 *   </tr>
 *   <tr>
 *     <td>psVoltage</td>
 *     <td>double</td>
 *     <td>measured voltage from the 5V power supply, V</td>
 *   </tr>
 *   <tr>
 *     <td>pentekFpgaTemp</td>
 *     <td>double</td>
 *     <td>temperature of the Pentek signal processing FPGA, deg C</td>
 *   </tr>
 *   <tr>
 *     <td>pentekBoardTemp</td>
 *     <td>double</td>
 *     <td>temperature of the Pentek PCB, deg C</td>
 *   </tr>
 *   <tr>
 *     <td>noiseSourceSelected</td>
 *     <td>bool</td>
 *     <td>true iff waveguide switch A is in the "noise source" position</td>
 *   </tr>
 *   <tr>
 *     <td>terminationSelected</td>
 *     <td>bool</td>
 *     <td>true iff waveguide switch B is in "termination" position</td>
 *   </tr>
 *   <tr>
 *     <td>locked15_5GHzPLO</td>
 *     <td>bool</td>
 *     <td>true iff 15.5 GHz PLO is phase locked</td>
 *   </tr>
 *   <tr>
 *     <td>locked1250MHzPLO</td>
 *     <td>bool</td>
 *     <td>true iff 1250 MHz PLO is phase locked</td>
 *   </tr>
 *   <tr>
 *     <td>modPulseDisabled</td>
 *     <td>bool</td>
 *     <td>true iff modulation pulses are being stopped at the HMC and not
 *         passed through to the transmitter</td>
 *   </tr>
 *   <tr>
 *     <td>rdsXmitterFilamentOn</td>
 *     <td>bool</td>
 *     <td>true iff we are currently commanding "filament on" via
 *         the RDS filament control line going to the transmitter</td>
 *   </tr>
 *   <tr>
 *     <td>rdsXmitterHvOn</td>
 *     <td>bool</td>
 *     <td>true iff we are currently commanding "high voltage on" via
 *         the RDS HV control line going to the transmitter</td>
 *   </tr>
 *   <tr>
 *     <td>hmcStatus</td>
 *     <td>int</td>
 *     <td>The status value from the Health Monitoring and Control (HMC) card.
 *         The values are: 0 = no errors, 1 = EMS power below threshold,
 *         2 = receiver protector switching error,
 *         3 = polarization switching error</td>
 *   </tr>
 * </table>
 * Example client usage, where hcrdrx is running on machine `drxhost`:
 * @code
 *     #include <XmlRpc.h>
 *     ...
 *
 *     // Get the transmitter status from hcrdrx on drxhost.local.net on port 8081
 *     XmlRpc::XmlRpcClient client("drxhost.local.net", 8081);
 *     const XmlRpc::XmlRpcValue nullParams;
 *     XmlRpc::XmlRpcValue statusDict;
 *     client.execute("getStatus", nullParams, statusDict);
 *
 *     // extract a couple of values from the dictionary
 *     bool bVal = bool(statusDict["some_bool"]));
 *     double cmigitsTemp = double(statusDict["cmigitsTemp"]));
 * @endcode
 */
class GetStatusMethod : public XmlRpcServerMethod {
public:
    GetStatusMethod() : XmlRpcServerMethod("getStatus") {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        XmlRpcValue statusDict;
        statusDict["detectedRfPower"] = XmlRpcValue(_hcrMonitor->detectedRfPower());
        statusDict["pvForePressure"] = XmlRpcValue(_hcrMonitor->pvForePressure());
        statusDict["pvAftPressure"] = XmlRpcValue(_hcrMonitor->pvAftPressure());
        statusDict["ploTemp"] = XmlRpcValue(_hcrMonitor->ploTemp());
        statusDict["eikTemp"] = XmlRpcValue(_hcrMonitor->eikTemp());
        statusDict["vLnaTemp"] = XmlRpcValue(_hcrMonitor->vLnaTemp());
        statusDict["hLnaTemp"] = XmlRpcValue(_hcrMonitor->hLnaTemp());
        statusDict["polarizationSwitchTemp"] = XmlRpcValue(_hcrMonitor->polarizationSwitchTemp());
        statusDict["rfDetectorTemp"] = XmlRpcValue(_hcrMonitor->rfDetectorTemp());
        statusDict["noiseSourceTemp"] = XmlRpcValue(_hcrMonitor->noiseSourceTemp());
        statusDict["ps28VTemp"] = XmlRpcValue(_hcrMonitor->ps28VTemp());
        statusDict["rdsInDuctTemp"] = XmlRpcValue(_hcrMonitor->rdsInDuctTemp());
        statusDict["rotationMotorTemp"] = XmlRpcValue(_hcrMonitor->rotationMotorTemp());
        statusDict["tiltMotorTemp"] = XmlRpcValue(_hcrMonitor->tiltMotorTemp());
        statusDict["cmigitsTemp"] = XmlRpcValue(_hcrMonitor->cmigitsTemp());
        statusDict["tailconeTemp"] = XmlRpcValue(_hcrMonitor->tailconeTemp());
        statusDict["psVoltage"] = XmlRpcValue(_hcrMonitor->psVoltage());
        statusDict["pentekFpgaTemp"] = XmlRpcValue(_hcrMonitor->pentekFpgaTemp());
        statusDict["pentekBoardTemp"] = XmlRpcValue(_hcrMonitor->pentekBoardTemp());
        statusDict["noiseSourceSelected"] = XmlRpcValue(_hcrMonitor->noiseSourceSelected());
        statusDict["terminationSelected"] = XmlRpcValue(_hcrMonitor->terminationSelected());
        statusDict["locked15_5GHzPLO"] = XmlRpcValue(_hcrMonitor->locked15_5GHzPLO());
        statusDict["locked1250MHzPLO"] = XmlRpcValue(_hcrMonitor->locked1250MHzPLO());
        statusDict["modPulseDisabled"] = XmlRpcValue(_hcrMonitor->modPulseDisabled());
        statusDict["hmcStatus"] = XmlRpcValue(_hcrMonitor->hmcStatus());
        // Get the state of the RDS (Remote Data System) control lines going
        // to the transmitter.
        statusDict["rdsXmitterFilamentOn"] = XmlRpcValue(_hcrMonitor->rdsXmitterFilamentOn());
        statusDict["rdsXmitterHvOn"] = XmlRpcValue(_hcrMonitor->rdsXmitterHvOn());
        retvalP = statusDict;
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
    void execute(XmlRpcValue & modeVal, XmlRpcValue & retvalP) {
        int iMode = int(modeVal);
        HcrPmc730::HmcOperationMode mode = static_cast<HcrPmc730::HmcOperationMode>(int(iMode));
        ILOG << "Received 'setHmcMode(" << iMode << ")' command";
        HcrPmc730::setHmcOperationMode(mode);
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
    HcrPmc730::setHmcResetOn(true);    // Start with HMC in reset...
    HcrPmc730::setNoiseSourceOn(false);
    HcrPmc730::setWaveguideSwitchC(0);
    HcrPmc730::setWaveguideSwitchD(0);
    HcrPmc730::setXmitterFilamentOn(false);
    HcrPmc730::setXmitterHvOn(false);
    HcrPmc730::setHmcOperationMode(HcrPmc730::HMC_NORMAL_OPERATION);
    // Now allow the HMC to operate
    HcrPmc730::setHmcResetOn(false);

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
    if (! rpcServer.bindAndListen(8081)) {
        ELOG << "Failed to initialize XmlRpcServer!";
        exit(1);
    }
    rpcServer.enableIntrospection(true);

    if (_simulate)
      ILOG << "*** Operating in simulation mode";

    // Instantiate our p7142sd3c
    Pentek::p7142sd3c sd3c(_simulate, hcrConfig.tx_delay(),
        hcrConfig.tx_pulse_width(), hcrConfig.prt1(), hcrConfig.prt2(),
        hcrConfig.staggered_prt(), hcrConfig.gates(), 1, _freeRun, 
        Pentek::p7142sd3c::DDC8DECIMATE, false, _simPauseMS);
    
    if (! sd3c.ok()) {
        ELOG << "P7142 was not opened successfully!";
        abort();
    }
    
    // Start our status monitoring thread.
    _hcrMonitor = new HcrMonitor(hcrConfig, sd3c, _xmitdHost, _xmitdPort);
    _hcrMonitor->start();

    // create the export object
    _exporter = new IwrfExport(hcrConfig, *_hcrMonitor);

    // We use SD3C's first general purpose timer for transmit pulse modulation
    sd3c.setGPTimer0(hcrConfig.tx_pulse_mod_delay(), hcrConfig.tx_pulse_mod_width());
    
    // General purpose timer 1 (SD3C timer 5) is used for EMS switch timing.
    // Use 800 ns + transmit pulse width + transmit delay
    PMU_auto_register("timers enable");
    sd3c.setGPTimer1(0.0, 
        800e-9 + hcrConfig.tx_pulse_width() + hcrConfig.tx_delay());
    
    // Create (but don't yet start) the downconversion threads.
    
    // Create the down converter threads. The threads are not run at creation, 
    // but they do instantiate the down converters.
    std::vector<HcrDrxPub*> downThreads(_chans);

    for (int c = 0; c < _chans; c++) {
        ILOG << "*** Channel " << c << " ***";
        downThreads[c] = new HcrDrxPub(sd3c, c, hcrConfig, _exporter, _tsLength,
                _gaussianFile, _kaiserFile, _simWaveLength);
    }

    // Create the upConverter.
    // Configure the DAC to use CMIX by fDAC/4 (coarse mixer mode = 9)
    PMU_auto_register("create upconverter");
    Pentek::p7142Up & upConverter = *sd3c.addUpconverter(sd3c.adcFrequency(), 
            sd3c.adcFrequency() / 4, 9);

    // catch a control-C
    signal(SIGINT, sigHandler);

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
    sd3c.startFilters();

    // Load the DAC memory bank 2, clear the DACM fifo, and enable the 
    // DAC memory counters. This must take place before the timers are started.
    PMU_auto_register("starting upconverter");
    startUpConverter(upConverter, sd3c.txPulseWidthCounts());

    // start the IWRF export
    PMU_auto_register("start export");
    _exporter->start();

    // Start the timers, which will allow data to flow.
    sd3c.timersStartStop(true);

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
        std::cout << "detectedRfPower: " << _hcrMonitor->detectedRfPower() << std::endl;
        std::cout << "pvForePressure: " << _hcrMonitor->pvForePressure() << std::endl;
        std::cout << "pvAftPressure: " << _hcrMonitor->pvAftPressure() << std::endl;
        std::cout << "ploTemp: " << _hcrMonitor->ploTemp() << std::endl;
        std::cout << "eikTemp: " << _hcrMonitor->eikTemp() << std::endl;
        std::cout << "vLnaTemp: " << _hcrMonitor->vLnaTemp() << std::endl;
        std::cout << "hLnaTemp: " << _hcrMonitor->hLnaTemp() << std::endl;
        std::cout << "polarizationSwitchTemp: " << _hcrMonitor->polarizationSwitchTemp() << std::endl;
        std::cout << "rfDetectorTemp: " << _hcrMonitor->rfDetectorTemp() << std::endl;
        std::cout << "noiseSourceTemp: " << _hcrMonitor->noiseSourceTemp() << std::endl;
        std::cout << "ps28VTemp: " << _hcrMonitor->ps28VTemp() << std::endl;
        std::cout << "rdsInDuctTemp: " << _hcrMonitor->rdsInDuctTemp() << std::endl;
        std::cout << "rotationMotorTemp: " << _hcrMonitor->rotationMotorTemp() << std::endl;
        std::cout << "tiltMotorTemp: " << _hcrMonitor->tiltMotorTemp() << std::endl;
        std::cout << "cmigitsTemp: " << _hcrMonitor->cmigitsTemp() << std::endl;
        std::cout << "tailconeTemp: " << _hcrMonitor->tailconeTemp() << std::endl;
        std::cout << "psVoltage: " << _hcrMonitor->psVoltage() << std::endl;
        std::cout << "noiseSourceSelected: " << _hcrMonitor->noiseSourceSelected() << std::endl;
        std::cout << "terminationSelected: " << _hcrMonitor->terminationSelected() << std::endl;
        std::cout << "locked15_5GHzPLO: " << _hcrMonitor->locked15_5GHzPLO() << std::endl;
        std::cout << "locked1250MHzPLO: " << _hcrMonitor->locked1250MHzPLO() << std::endl;
        std::cout << "modPulseDisabled: " << _hcrMonitor->modPulseDisabled() << std::endl;
        std::cout << "hmcStatus: " << _hcrMonitor->hmcStatus() << std::endl;
        std::cout << "rdsXmitterFilamentOn: " << _hcrMonitor->rdsXmitterFilamentOn() << std::endl;
        std::cout << "rdsXmitterHvOn: " << _hcrMonitor->rdsXmitterHvOn() << std::endl;
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
    sd3c.timersStartStop(false);
    
    return(0);
}

