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

#include "p7140dnThread.h"
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
int _tsLength;                   ///< The time series length
int _numChannels;                ///< The number of radar channels
int _delay = 0;
int _prt = 2000;                 ///< prt in 10 MHz counts
int _prt2 = 2000;                ///< prt2 in 10 MHz counts, if == prt, then no staggered prt
int _pulsewidth = 10;            ///< pulsewidth in 10 MHz counts
bool _stgr_prt = false;          ///< set true for staggered prt
std::string _gaussianFile = "";  ///< gaussian filter coefficient file
std::string _kaiserFile = "";    ///< kaiser filter coefficient file
int _decim;                      ///< Decimation or bypass divider rate
DDSPublisher* _publisher = 0;    ///< The publisher.
TSWriter* _tsWriter = 0;         ///< The time series writer.
bool _simulate;                  ///< Set true for simulate mode
int _simPauseMS;                 ///< The number of millisecnds to pause when reading in simulate mode.
bool _do7140 = false;            ///< Set truue if we are using the p7140, false otherwise. Default is false
/////////////////////////////////////////////////////////////////////
void createDDSservices()
{
	ArgvParams argv("profilerdrx");
	argv["-ORBSvcConf"] = _ORB;
	argv["-DCPSConfigFile"] = _DCPS;
	argv["-DCPSInfoRepo"] = _DCPSInfoRepo;
	if (_DCPSDebugLevel > 0)
		argv["-DCPSDebugLevel"] = _DCPSDebugLevel;
	if (_DCPSTransportDebugLevel > 0)
		argv["-DCPSTransportDebugLevel"] = _DCPSTransportDebugLevel;

	// create our DDS publisher
#ifdef ORIG
	_publisher = new DDSPublisher(argv.argc(), argv.argv());
#else
	char **theArgv = argv.argv();
	//    std::cerr << "theArgv[0] = " << theArgv[0] << std::endl;
	_publisher = new DDSPublisher(argv.argc(), theArgv);
#endif
	if (_publisher->status()) {
		std::cerr << "Unable to create a publisher, exiting." << std::endl;
		exit(1);
	}

	// create the time series writer
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
	_publish      = config.getBool("DDS/Publish", true);
	_ORB          = config.getString("DDS/ORBConfigFile",  orbFile);
	_DCPS         = config.getString("DDS/DCPSConfigFile", dcpsFile);
	_tsTopic      = config.getString("DDS/TopicTS",        "PROFILERTS");
	_DCPSInfoRepo = config.getString("DDS/DCPSInfoRepo",   dcpsInfoRepo);
	_devRoot      = config.getString("Device/DeviceRoot",  "/dev/pentek/p7140/0");
	_chans        = config.getInt("Device/Channels",       1);
	_decim        = config.getInt("Device/Decimation",     8);
	_gates        = config.getInt("Radar/Gates",           100);
	_tsLength     = config.getInt("Radar/TsLength",        256);
	_numChannels  = config.getInt("Radar/Channels",        4);
	_simulate     = config.getBool("Simulate",             false);
	_simPauseMS   = config.getInt("SimPauseMs",            20);
	_do7140      = config.getBool("Use7140",               false);

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
	("help", "describe options")
	("devRoot", po::value<std::string>(&_devRoot), "cevice root (e.g. /dev/pentek/0)")
	("chans",  po::value<int>(&_chans),  "number of channels")
	("decimation",  po::value<int>(&_decim),  "GC decimation rate")
	("nopublish", "do not publish data")
	("p7140", "use p7140 card (otherwise 7142 will be used")
	("simulate", "Enable simulation")
	("simPauseMS",  po::value<int>(&_simPauseMS),  "Simulation pause interval (ms)")
	("ORB", po::value<std::string>(&_ORB), "ORB service configuration file (Corba ORBSvcConf arg)")
	("DCPS", po::value<std::string>(&_DCPS), "DCPS configuration file (OpenDDS DCPSConfigFile arg)")
	("DCPSInfoRepo", po::value<std::string>(&_DCPSInfoRepo), "DCPSInfoRepo URL (OpenDDS DCPSInfoRepo arg)")
	("DCPSDebugLevel", po::value<int>(&_DCPSDebugLevel), "DCPSDebugLevel ")
	("DCPSTransportDebugLevel", po::value<int>(&_DCPSTransportDebugLevel),
			"DCPSTransportDebugLevel ")
			;

	po::variables_map vm;
	po::store(po::parse_command_line(argc, argv, descripts), vm);
	po::notify(vm);

	_publish = vm.count("nopublish") == 0;
	_simulate = vm.count("simulate") != 0;
	_do7140 = vm.count("p7140") != 0;

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

	// try to change scheduling to real-time
	makeRealTime();

	// get the configuration parameters from the configuration file
	getConfigParams();

	// parse the command line optins, substituting for config params.
	parseOptions(argc, argv);

	// create the dds services
	if (_publish)
		createDDSservices();

	// create the downconverter threads
	std::vector<p7140dnThread*> down7140;
	std::vector<p7142hcrdnThread*> down7142;
	down7140.resize(_chans);
	down7142.resize(_chans);

	if (_simulate)
		std::cout << "*** Operating in simulation mode" << std::endl;

	// create the down converter threads. Remember that
	// these are multiply inherited from the down converters
	// and QThread. The threads are not run at creation, but
	// they do instantiate the down converters.
	if (_do7140) {
		for (int c = 0; c < _chans; c++) {
			p7140dnThread* p = new p7140dnThread(
					_tsWriter,
					_publish,
					_gates,
					_tsLength,
					_devRoot,
					c,
					_decim,
					_simulate,
					_simPauseMS);
			down7140[c] = p;
			if (!down7140[c]->ok()) {
				std::cerr << "cannot access " << down7140[c]->dnName() << "\n";
				perror("");
				exit(1);
			}
			std::cout << "Using p7140 device: "  << down7140[c]->dnName() << std::endl;
		}
	} else {
		for (int c = 0; c < _chans; c++) {
			p7142hcrdnThread* p = new p7142hcrdnThread(
					_tsWriter,
					_publish,
					_tsLength,
					_devRoot,
					c,
					_gates,
					_delay,
					_prt,
					_prt2,
					_pulsewidth,
					_stgr_prt,
					_gaussianFile,
					_kaiserFile,
					_decim,
					_simulate,
					_simPauseMS);
			down7142[c] = p;
			if (!down7142[c]->ok()) {
				std::cerr << "cannot access " << down7142[c]->dnName() << "\n";
				perror("");
				exit(1);
			}
			std::cout << "Using p7142 device: "  << down7142[c]->dnName() << std::endl;
		}
	}

	// start the down converter threads.
	if (_do7140) {
		for (int c = 0; c < _chans; c++) {
			down7140[c]->start();
		}
	} else {
		for (int c = 0; c < _chans; c++) {
			down7142[c]->start();
		}
	}

	sleep(1);

	if (!_do7140) {
		// all of the filters are started by any call to
		// start filters(). So just call it for channel 0
		down7142[0]->startFilters();
	}

	while (1) {
		sleep(1);
	}
}

