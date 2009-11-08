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
#include <boost/program_options.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>

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
int _pulsewidth = 64;            ///< pulsewidth in ADC_Clk/2 counts (24 MHz for ddc4, 62.5 MHz for ddc8)
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
	_decim         = config.getInt("Device/Decimation",     8);
	_ddcType       = config.getInt("Device/DdcType",        8);
	_gates         = config.getInt("Radar/Gates",           200);
	_prt		   = config.getInt("Radar/PRT", 			12544);
	_pulsewidth    = config.getInt("Radar/PulseWidth", 		64);
	_nsum          = config.getInt("Radar/Nsum",            10);
	_tsLength      = config.getInt("Radar/TsLength",        256);
	_numChannels   = config.getInt("Radar/Channels",        4);
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
	("pulsewidth",  po::value<int>(&_pulsewidth),  "Pulsewidth in ADC_Clk/2 counts")
	("nsum",  po::value<int>(&_nsum),              "Number of coherent integrator sums")
	("decimation",  po::value<int>(&_decim),       "ADC decimation rate")
	("ddc",  po::value<int>(&_ddcType),            "DDC type (8 or 4; must match pentek firmware")
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
double nowTime()
{
	struct timeb timeB;
	ftime(&timeB);
	return timeB.time + timeB.millitm/1000.0;
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

	if (_nsum < 0 || (_nsum > 1 && (_nsum%2 != 0))) {
		std::cerr << "nsum must be greater than 0 and less than 65535. If between 2 and 65535, it must be even." << std::endl;
		exit(1);
	}

	if (_gates < 1 || _gates > 511) {
		std::cerr << "gates must be greater than 0 and less than 512." << std::endl;
		exit(1);
	}

	if (_simulate)
		std::cout << "*** Operating in simulation mode" << std::endl;

	// create the dds services
	if (_publish)
		createDDSservices();

	// create the list of channels
	for (int i = 0; i < _chans; i++) {
		channels.push_back(i);
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
				_pulsewidth,
				_stgr_prt,
				_gaussianFile,
				_kaiserFile,
				ddcType,
				_decim,
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

	// start the down converter threads.

	for (unsigned int c = 0; c < channels.size(); c++) {
		std::cout << "processing enabled on " << down7142[c]->dnName() << std::endl;
		down7142[c]->start();
	}

	sleep(1);

    // all of the filters are started by any call to
    // start filters(). So just call it for channel 0
    down7142[0]->startFilters();
    std::cout << "filters enabled" << std::endl;


	double startTime = nowTime();
	while (1) {
		sleep(10);
		double currentTime = nowTime();
		double elapsed = currentTime - startTime;
		startTime = currentTime;

		std::vector<long> bytes;
		std::vector<int> overUnder;
		std::vector<unsigned long> discards;
		bytes.resize(channels.size());
		overUnder.resize(channels.size());
		discards.resize(channels.size());
		for (unsigned int c = 0; c < channels.size(); c++) {
			bytes[c] = down7142[c]->bytesRead();
			overUnder[c] = down7142[c]->overUnderCount();
			discards[c] = down7142[c]->tsDiscards();
		}
		for (unsigned int c = 0; c < channels.size(); c++) {
			std::cout << std::setprecision(3) << std::setw(5)
					  << bytes[c]/1000000.0/elapsed << " MB/s "
					  << overUnder[c] << " overruns   "
					  << discards[c] << " discards   ";
		}
		std::cout << std::endl;

	}
}

