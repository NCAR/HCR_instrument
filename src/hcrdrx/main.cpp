#include <iomanip>
#include <iostream>
#include <string>
#include <sys/ioctl.h>
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

#include "p7142hcr.h"
#include "DDSPublisher.h"
#include "TSWriter.h"

using namespace std;
using namespace boost::posix_time;
namespace po = boost::program_options;

bool _publish;                   ///< set true if the pentek data should be published to DDS.
std::string _devRoot;            ///< Device root e.g. /dev/pentek/0
std::string _dnName;             ///< Downconvertor name e.g. 0B
std::string _ORB;                ///< path to the ORB configuration file.
std::string _DCPS;               ///< path to the DCPS configuration file.
std::string _DCPSInfoRepo;       ///< URL to access DCPSInfoRepo
std::string _rayTopic;           ///< The published ray topic
std::string _tsTopic;            ///< The published timeseries topic
int _DCPSDebugLevel=0;           ///< the DCPSDebugLevel
int _DCPSTransportDebugLevel=0;  ///< the DCPSTransportDebugLevel
int _gates;						 ///< The number of gates
int _tsLength;                   ///< The time series length
int _numChannels;                ///< The number of radar channels
int _delay;
int _prt;
int _prt2;
int _pulsewidth;
int _stgr_prt;
int _bypdiv;
std::string _gaussianFile;
std::string _kaiserFile;
bool _simulate;                  ///< Set true for simulate mode
int _simPauseMS;                 ///< The number of milliseconds to pause when reading in simulate mode.

int _bufferSize;                 ///< Buffer size
DDSPublisher* _publisher = 0;    ///< The publisher.
TSWriter* _tsWriter = 0;         ///< The time series writer.

/////////////////////////////////////////////////////////////////////
void createDDSservices()
{
	if (!_publish)
		return;

	std::cout <<__FILE__ << " creating DDS services" << std::endl;

	ArgvParams argv("eldoradrx");
	argv["-ORBSvcConf"] = _ORB;
	argv["-DCPSConfigFile"] = _DCPS;
	argv["-DCPSInfoRepo"] = _DCPSInfoRepo;
	if (_DCPSDebugLevel > 0)
		argv["-DCPSDebugLevel"] = _DCPSDebugLevel;
	if (_DCPSTransportDebugLevel > 0)
		argv["-DCPSTransportDebugLevel"] = _DCPSTransportDebugLevel;

	// create our DDS publisher
	_publisher = new DDSPublisher(argv.argc(), argv.argv());

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

	QtConfig config("HcrDrx", "HcrDrx");

	// set up the default configuration directory path
	std::string HcrDir("/conf/");
	char* e = getenv("HCRDIR");
	if (e) {
		HcrDir = e + HcrDir;
	} else {
		std::cerr << "Environment variable HCRDIR must be set." << std::endl;
		exit(1);
	}

	// and create the default DDS configuration file paths, since these
	// depend upon HCRDIR
	std::string orbFile      = HcrDir + "ORBSvc.conf";
	std::string dcpsFile     = HcrDir + "DDSClient.ini";
	std::string dcpsInfoRepo = "iiop://localhost:50000/DCPSInfoRepo";

	// get parameters
	_publish      = config.getBool("DDS/Publish", true);
	_ORB          = config.getString("DDS/ORBConfigFile",  orbFile);
	_DCPS         = config.getString("DDS/DCPSConfigFile", dcpsFile);
	_tsTopic      = config.getString("DDS/TopicTS",        "HCRTS");
	_DCPSInfoRepo = config.getString("DDS/DCPSInfoRepo",   dcpsInfoRepo);
	_devRoot      = config.getString("Device/DeviceRoot",  "/dev/pentek/p7142/0");
	_dnName       = config.getString("Device/DownName",    "0B");
	_simulate     = config.getBool("Simulate",             false);
	_simPauseMS   = config.getInt("SimPauseMs",            100);

	_gates        = config.getInt("Radar/Gates",           200);
	_tsLength     = config.getInt("Radar/TsLength",        1024);
	_bypdiv       = config.getInt("Radar/BypDiv",          125);
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
	("devRoot", po::value<std::string>(&_devRoot), "Device root (e.g. /dev/pentek/p7142/0)")
	("dnName",  po::value<std::string>(&_dnName),  "Downconvertor name e.g. (0B)")
	("nopublish", "do not publish data")
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
void
publish(char* buf, int n) {

	if (!_publish)
		return;

	HcrDDS::TimeSeries* ts = _tsWriter->getEmptyItem();

	if (!ts) {
		// keep in mind that there will be a lot of unavailable
		// buffer requests when there are no subscribers and
		// we keep throwing data at it.
		return;
	}

	int len = n;

	ts->tsdata.length(len/2);

	ts->hskp.gates = _gates;
	ts->hskp.numChannels = _numChannels;
	ts->hskp.tsLength = _tsLength;

	// convert to shorts
	short* data = (short*)buf;
	for (int i = 0; i < n/2; i++) {
		ts->tsdata[i] = data[i];
//		if (i % 2)
//			std::cout << i << "  " << ts->tsdata[i-1]
//			          << "  " << ts->tsdata[i] << std::endl;
	}

	_tsWriter->publishItem(ts);
}
///////////////////////////////////////////////////////////
int
main(int argc, char** argv)
{
	// stick with 1 channel for now
	_numChannels = 1;

	// default to publishing
	_publish = true;

	// get the configuration parameters from the configuration file
	getConfigParams();

	// parse the command line optins, substituting for config params.
	parseOptions(argc, argv);

	/// there will be an I and Q for each channel
	_bufferSize   = _gates*_tsLength*2*sizeof(short);

	// create the dds services
	createDDSservices();

	// default configuration
	_delay = 0;
	_prt = 2000; // 10 MHz counts
	_prt2 = _prt; // no staggered prt
	_pulsewidth = 10; // 10 MHz counts
	_stgr_prt = false;

	// create the downconvertor
	/**
   Pentek::p7142hcrdn downConvertor(
				   _devRoot,
				   _dnName,
				   _gates,
				   _delay,
				   _prt,
				   _prt2,
				   _pulsewidth,
				   _stgr_prt,
				   _gaussianFile,
				   _kaiserFile,
				   _bypdiv,
				   _simulate,
				   _simPauseMS);
	 **/

	std::cout << "simulate mode is " << _simulate << std::endl;

	Pentek::p7142dn downConvertor(
			_devRoot,
			_dnName,
			_bypdiv,
			_simulate,
			_simPauseMS);

	if (!downConvertor.ok()) {
		std::cerr << "cannot access " << _devRoot << ", " << _dnName << "\n";
		perror("");
		exit(1);
	}

	// create the read buffer
	int delta = _bufferSize/_gates;
	char* buf = new char[_bufferSize];
	std::cout << "buffer size is " << delta << std::endl;

	// try to change scheduling to real-time
	makeRealTime();

	// start the loop
	double total = 0;

	double startTime = nowTime();

	int lastMb = 0;
	int samples = 0;

	while (1) {
		int bytes = 0;
		for (int b = 0; b < _bufferSize; b += delta) {
			int n = downConvertor.read(buf+bytes, delta);
			if (n <= 0) {
				std::cerr << "read returned " << n << " ";
				if (n < 0)
					perror("");
				std::cerr << "\n";
			} else {
				total += n;
				bytes += n;
			}

		}
		samples++;
		// publish new data
		if (bytes > 0) {
			publish(buf, bytes);
		}

		int mb = (int)(total/1.0e6);
		if ((mb % 100) == 0 && mb > lastMb) {
			lastMb = mb;
			double elapsed = nowTime() - startTime;
			double bw = (total/elapsed)/1.0e6;

			int overruns = downConvertor.overUnderCount();

			std::cout << "total " << std::setw(5) << mb << " MB,  BW "
			<< std::setprecision(4) << std::setw(5) << bw
			<< " MB/s, overruns: "
			<< overruns << "   samples: " << samples << std::endl;
		}

	}
}

