#include <iomanip>
#include <iostream>
#include <string>
#include <sys/ioctl.h>
#include <sys/select.h>
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

// For configuration management
#include <QtConfig.h>
// Proxy argc/argv
#include <ArgvParams.h>

#include "p7142hcrdnThread.h"
#include "p7142.h"
#include "DDSPublisher.h"
#include "TSWriter.h"

using namespace std;
using namespace boost::posix_time;
namespace po = boost::program_options;

bool _publish;                   ///< set true if the pentek data should be published to DDS.
std::string _devRoot;            ///< Device root e.g. /dev/pentek/0
int _chans;                      ///< number of channels
std::string _ORB;                ///< path to the ORB configuration file.
std::string _DCPS;               ///< path to the DCPS configuration file.
std::string _DCPSInfoRepo;       ///< URL to access DCPSInfoRepo
std::string _tsTopic;            ///< The published timeseries topic
int _DCPSDebugLevel=0;           ///< the DCPSDebugLevel
int _DCPSTransportDebugLevel=0;  ///< the DCPSTransportDebugLevel
int _gates;                      ///< The number of gates
int _nsum;                       ///< The number of sums
int _tsLength;                   ///< The time series length
int _numChannels;                ///< The number of radar channels
int _delay = 0;					 ///< delay in ADC_Clk/2 counts (24 MHz for ddc4, 62.5 MHz for ddc8)
int _prt = 12544;                ///< prt in ADC_Clk/2 counts (24 MHz for ddc4, 62.5 MHz for ddc8)
int _prt2 = 12544;               ///< prt2 in ADC_Clk/2 counts, if == prt, then no staggered prt
int _pulseWidth = 64;            ///< pulsewidth in ADC_Clk/2 counts (24 MHz for ddc4, 62.5 MHz for ddc8)
bool _stgr_prt = false;          ///< set true for staggered prt
std::string _gaussianFile = "";  ///< gaussian filter coefficient file
std::string _kaiserFile = "";    ///< kaiser filter coefficient file
int _decim;                      ///< Decimation or bypass divider rate
DDSPublisher* _publisher = 0;    ///< The publisher.
TSWriter* _tsWriter = 0;         ///< The time series writer.
bool _simulate;                  ///< Set true for simulate mode
int _simPauseMS;                 ///< The number of millisecnds to pause when reading in simulate mode.
bool _internalClock = false;     ///< set true to use the internal clock, false otherwise
int _ddcType;                    ///< The ddc type in the pentek core. Must be 4 or 8.
bool _freeRun = false;           ///< If set true, the prf gating of the downconversion is disabled.

bool _terminate = false;         ///< set true to signal the main loop to terminate

/////////////////////////////////////////////////////////////////////
void sigHandler(int sig) {
    _terminate = true;
}

/////////////////////////////////////////////////////////////////////
void createDDSservices()
{
	ArgvParams argv("profilerdrx");
	argv["-DCPSInfoRepo"] = _DCPSInfoRepo;
	argv["-DCPSConfigFile"] = _DCPS;
	if (_DCPSDebugLevel > 0)
		argv["-DCPSDebugLevel"] = _DCPSDebugLevel;
	if (_DCPSTransportDebugLevel > 0)
		argv["-DCPSTransportDebugLevel"] = _DCPSTransportDebugLevel;
	argv["-ORBSvcConf"] = _ORB;

	// create our DDS publisher
	char **theArgv = argv.argv();
	_publisher = new DDSPublisher(argv.argc(), theArgv);
	if (_publisher->status()) {
		std::cerr << "Unable to create a publisher, exiting." << std::endl;
		exit(1);
	}

	// create the DDS time series writer
	_tsWriter = new TSWriter(*_publisher, _tsTopic.c_str());
}

//////////////////////////////////////////////////////////////////////
///
/// get parameters that are spcified in the configuration file.
/// These can be overriden by command line specifications.
void getConfigParams()
{

	QtConfig config("ProfilerDrx", "ProfilerDrx");

	// set up the default configuration directory path
	std::string ProfilerDir("/conf/");
	char* e = getenv("PROFILERDIR");
	if (e) {
		ProfilerDir = e + ProfilerDir;
	} else {
		std::cerr << "Environment variable PROFILERDIR must be set." << std::endl;
		exit(1);
	}

	// and create the default DDS configuration file paths, since these
	// depend upon HCRDIR
	std::string orbFile      = ProfilerDir + "ORBSvc.conf";
	std::string dcpsFile     = ProfilerDir + "DDSClient.ini";
	std::string dcpsInfoRepo = "iiop://localhost:50000/DCPSInfoRepo";

	// get parameters
	_publish       = config.getBool("DDS/Publish", true);
	_ORB           = config.getString("DDS/ORBConfigFile",  orbFile);
	_DCPS          = config.getString("DDS/DCPSConfigFile", dcpsFile);
	_tsTopic       = config.getString("DDS/TopicTS",        "PROFILERTS");
	_DCPSInfoRepo  = config.getString("DDS/DCPSInfoRepo",   dcpsInfoRepo);
	_devRoot       = config.getString("Device/DeviceRoot",  "/dev/pentek/p7142/0");
	_chans         = config.getInt("Device/Channels",       1);
	_ddcType       = config.getInt("Device/DdcType",        8);
	_gates         = config.getInt("Radar/Gates",           50);
	_prt		   = config.getInt("Radar/PRT", 			1200);
	_pulseWidth    = config.getInt("Radar/PulseWidth", 		16);
	_nsum          = config.getInt("Radar/Nsum",            1);
	_tsLength      = config.getInt("Radar/TsLength",        256);
	_numChannels   = config.getInt("Radar/Channels",        4);
	_freeRun       = config.getBool("Radar/FreeRunning",    false);
	_simulate      = config.getBool("Simulate",             false);
	_simPauseMS    = config.getInt("SimPauseMs",            20);
	_internalClock = config.getBool("InternalClock",        false);

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
	("devRoot", po::value<std::string>(&_devRoot), "Device root (e.g. /dev/pentek/0)")
	("chans",  po::value<int>(&_chans),            "Number of channels")
	("gates",  po::value<int>(&_gates),            "Number of gates")
	("prt",  po::value<int>(&_prt),                "PRT in ADC_Clk/2 counts")
	("pulseWidth",  po::value<int>(&_pulseWidth),  "Pulsewidth in ADC_Clk/2 counts")
	("nsum",  po::value<int>(&_nsum),              "Number of coherent integrator sums")
	("ddc",  po::value<int>(&_ddcType),            "DDC type (8 or 4; must match pentek firmware)")
	("freeRun",                                    "Free running mode, PRT gating is disabled")
	("nopublish",                                  "Do not publish data")
	("simulate",                                   "Enable simulation")
	("simPauseMS",  po::value<int>(&_simPauseMS),  "Simulation pause interval (ms)")
    ("internalClock",                              "Use the internal clock instead of the front panel clock")
	("ORB", po::value<std::string>(&_ORB),         "ORB service configuration file (Corba ORBSvcConf arg)")
	("DCPS", po::value<std::string>(&_DCPS),       "DCPS configuration file (OpenDDS DCPSConfigFile arg)")
	("DCPSInfoRepo", po::value<std::string>(&_DCPSInfoRepo),
	                                               "DCPSInfoRepo URL (OpenDDS DCPSInfoRepo arg)")
	("DCPSDebugLevel", po::value<int>(&_DCPSDebugLevel), "DCPSDebugLevel")
	("DCPSTransportDebugLevel", po::value<int>(&_DCPSTransportDebugLevel),
			                                       "DCPSTransportDebugLevel")
			;

	po::variables_map vm;
	po::store(po::parse_command_line(argc, argv, descripts), vm);
	po::notify(vm);

	if (vm.count("nopublish"))
	    _publish = false;
	if (vm.count("simulate"))
	    _simulate = true;
	if (vm.count("internalClock"))
	    _internalClock = true;
	if (vm.count("freeRun"))
		_freeRun = true;

	if (vm.count("ddc")) {
		if (_ddcType != 4 && _ddcType != 8) {
			std::cout << "ddc must be 4 or 8"  << std::endl;
			exit(1);
		}
	}

	if (vm.count("help")) {
		std::cout << descripts << std::endl;
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
		std::cerr << "Not root, unable to change scheduling priority" << std::endl;
		return;
	}

	sched_param sparam;
	sparam.sched_priority = 50;

	if (sched_setscheduler(0, SCHED_RR, &sparam)) {
		std::cerr << "warning, unable to set scheduler parameters: ";
		perror("");
		std::cerr << "\n";
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
/// Make sure that the configuration parameters are self consist.
/// Print an error message and exit the process if not.

void argumentCheck() {

	if (_nsum < 0 || (_nsum > 1 && (_nsum%2 != 0))) {
		std::cerr << "nsum must be greater than 0 and less than 65535. If between 2 and 65535, it must be even." << std::endl;
		exit(1);
	}

	if (_gates < 1 || _gates > 511) {
		std::cerr << "gates must be greater than 0 and less than 512." << std::endl;
		exit(1);
	}

	if (_prt % _pulseWidth) {
		std::cerr << "PRT must be an integral number of pulse widths." << std::endl;
		exit(1);
	}

	if (_prt <= (_gates+1)*_pulseWidth) {
		std::cerr << "PRT must be greater than (gates+1)*(pulse width)," << std::endl;
		exit(1);
	}

	if (_simulate)
		std::cout << "*** Operating in simulation mode" << std::endl;

}

///////////////////////////////////////////////////////////
void startUpConverter(Pentek::p7142up& upConverter) {

	// create the signal
//	unsigned int n = _pulseWidth*2;
	unsigned int n = _pulseWidth*2;
	long IQ[n];

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

///////////////////////////////////////////////////////////
int
main(int argc, char** argv)
{
	// a list of channels
	std::vector<int> channels;

	// try to change scheduling to real-time
	makeRealTime();

	// get the configuration parameters from the configuration file
	getConfigParams();

	// parse the command line optins, substituting for config params.
	parseOptions(argc, argv);

    // make sure that the specified arguments are compatible
	argumentCheck();

	// create the dds services
	if (_publish)
		createDDSservices();

	// create the list of channels
	for (int i = 0; i < _chans; i++) {
		channels.push_back(i);
	}

	// create the upconvertor. Use coarse mixer mode = ?, as specified in X4L FMIX CMIX
	/// @todo Need reference that explains which cm_mode to specify here.
	double sampleClock = 0;
	double ncoFreq = 0;
	if (_ddcType == 4) {
		sampleClock = 48.0e6;
		ncoFreq     = 12.0e6;
	} else {
		sampleClock = 125.0e6;
		ncoFreq     = 31.25e6;
	}
	
	// Create the upConverter.
	// Configure the DAC to use CMIX by fDAC/4 (coarse mixer mode = 9)
	Pentek::p7142up upConverter(_devRoot, "0C", sampleClock, ncoFreq, 9, _simulate); 

	if (!upConverter.ok()) {
		std::cerr << "cannot access " << upConverter.upName() << "\n";
		exit(1);
	}

	// create the down converter threads. Remember that
	// these are multiply inherited from the down converters
	// and QThread. The threads are not run at creation, but
	// they do instantiate the down converters.
	std::vector<p7142hcrdnThread*> down7142;
	down7142.resize(channels.size());

	Pentek::p7142hcrdn::DDCDECIMATETYPE ddcType = Pentek::p7142hcrdn::DDC8DECIMATE;
	if (_ddcType == 4) {
		ddcType = Pentek::p7142hcrdn::DDC4DECIMATE;
	}
	for (unsigned int c = 0; c < channels.size(); c++) {

		std::cout << "*** Channel " << channels[c] << " ***" << std::endl;

		p7142hcrdnThread* p = new p7142hcrdnThread(
				_tsWriter,
				_publish,
				_tsLength,
				_devRoot,
				channels[c],
				_gates,
				_nsum,
				_delay,
				_prt,
				_prt2,
				_pulseWidth,
				_stgr_prt,
				_freeRun,
				_gaussianFile,
				_kaiserFile,
				ddcType,
				2*_pulseWidth,
				_simulate,
				_simPauseMS,
				_internalClock);
		down7142[c] = p;
		if (!down7142[c]->ok()) {
			std::cerr << "cannot access " << down7142[c]->dnName() << "\n";
			perror("");
			exit(1);
		}
	}

    // catch a control-C
    signal(SIGINT, sigHandler);

	for (unsigned int c = 0; c < channels.size(); c++) {
		// run the downconverter thread. This will cause the
		// thread code to call the run() method, which will
		// start reading data, but should block on the first
		// read since the timers and filters are not running yet.
		down7142[c]->start();
		std::cout << "processing enabled on " << down7142[c]->dnName() << std::endl;
	}

	// wait awhile, so that the threads can all get to the first read.
	struct timespec sleepTime = { 1, 0 }; // 1 second, 0 nanoseconds
	while (nanosleep(&sleepTime, &sleepTime)) {
	    if (errno != EINTR) {
	        std::cerr << "Error " << errno << " from nanosleep().  Aborting." <<
                std::endl;
	        abort();
	    } else {
	        // We were interrupted. Return to sleeping until the interval is done.
	        continue;
	    }
	}

	// all of the filters are started by any call to
    // start filters(). So just call it for channel 0
    down7142[0]->startFilters();

	// Load the DAC memory bank 2, clear the DACM fifo, and enable the 
	// DAC memory counters. This must take place before the timers are started.
	startUpConverter(upConverter);

	// Start the timers, which will allow data to flow.
    // All timers are started by calling timerStartStop for
    // any one channel.
    down7142[0]->timersStartStop(true);

	double startTime = nowTime();
	while (1) {
		for (int i = 0; i < 100; i++) {
			// check for the termination request
			if (_terminate) {
				break;
			}
			usleep(100000);
		}
		if (_terminate) {
			break;
		}

		double currentTime = nowTime();
		double elapsed = currentTime - startTime;
		startTime = currentTime;

		std::vector<long> bytes;
		std::vector<int> overUnder;
		std::vector<unsigned long> discards;
		std::vector<unsigned long> droppedPulses;
		std::vector<unsigned long> syncErrors;
		bytes.resize(channels.size());
		overUnder.resize(channels.size());
		discards.resize(channels.size());
		droppedPulses.resize(channels.size());
		syncErrors.resize(channels.size());
		for (unsigned int c = 0; c < channels.size(); c++) {
			bytes[c] = down7142[c]->bytesRead();
			overUnder[c] = down7142[c]->overUnderCount();
			discards[c] = down7142[c]->tsDiscards();
			droppedPulses[c] = down7142[c]->droppedPulses();
		}
		for (unsigned int c = 0; c < channels.size(); c++) {
			std::cout << std::setprecision(3) << std::setw(5)
					  << bytes[c]/1000000.0/elapsed << " MB/s "
					  << " ovr:" << overUnder[c]
					  << " discards:"<< discards[c]
					  << " drops:" << droppedPulses[c]
	                  << " sync:" << syncErrors[c];
		}
		std::cout << std::endl;
	}

	// stop the DAC
	upConverter.stopDAC();

	// stop the timers
    down7142[0]->timersStartStop(false);

	std::cout << "terminated on command" << std::endl;
}

