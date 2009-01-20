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

#include "p7140.h"
#include "DDSPublisher.h"
#include "DDSSubscriber.h"
#include "TSWriter.h"
#include "TSReader.h"

using namespace std;
using namespace boost::posix_time;
namespace po = boost::program_options;

bool _publish;                   ///< set true if the pentek data should be published to DDS.
std::string _devRoot;            ///< Device root e.g. /dev/pentek/0
std::string _dnName;             ///< Downconvertor name e.g. 0B
int _bufferSize;                 ///< Buffer size
std::string _ORB;                ///< path to the ORB configuration file.
std::string _DCPS;               ///< path to the DCPS configuration file.
std::string _DCPSInfoRepo;       ///< URL to access DCPSInfoRepo
std::string _rayTopic;           ///< The published ray topic
std::string _tsTopic;            ///< The published timeseries topic
int _DCPSDebugLevel=0;           ///< the DCPSDebugLevel
int _DCPSTransportDebugLevel=0;  ///< the DCPSTransportDebugLevel
DDSPublisher* _publisher = 0;    ///< The publisher.
TSWriter* _tsWriter = 0;         ///< The time series writer.

/////////////////////////////////////////////////////////////////////
void createDDSservices()
{
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

    QtConfig config("NCAR", "ProfilerDrx");

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
    _bufferSize   = config.getInt("Device/BufferSize",     100000);
    _devRoot      = config.getString("Device/DeviceRoot",  "/dev/pentek/p7140/0");
    _dnName       = config.getString("Device/DownName",    "0C");
    std::cerr << "read DCPSInfoRepo = " << _DCPSInfoRepo << " from config" << std::endl;
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
    ("ORB", po::value<std::string>(&_ORB), "ORB service configuration file (Corba ORBSvcConf arg)")
    ("DCPS", po::value<std::string>(&_DCPS), "DCPS configuration file (OpenDDS DCPSConfigFile arg)")
    ("DCPSInfoRepo", po::value<std::string>(&_DCPSInfoRepo), "DCPSInfoRepo URL (OpenDDS DCPSInfoRepo arg)")
    ("nopublish", "do not publish data")
    ("DCPSDebugLevel", po::value<int>(&_DCPSDebugLevel), "DCPSDebugLevel ")
    ("DCPSTransportDebugLevel", po::value<int>(&_DCPSTransportDebugLevel),
     "DCPSTransportDebugLevel ")
    ("bufsize", po::value<int>(&_bufferSize), "Read buffer size (bytes)")
    ("devRoot", po::value<std::string>(&_devRoot), "Device root (e.g. /dev/pentek/0)")
    ("dnName",  po::value<std::string>(&_dnName),  "Downconvertor name e.g. (0C)")
     ;

    po::variables_map vm;
    po::store(po::parse_command_line(argc, argv, descripts), vm);
    po::notify(vm);

    _publish = vm.count("nopublish") == 0;
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

  // get the configuration parameters from the configuration file
  getConfigParams();

  // parse the command line optins, substituting for config params.
  parseOptions(argc, argv);

  // create the dds services
  createDDSservices();

  // create the downconvertor
  Pentek::p7140dn downConvertor(_devRoot, _dnName);

  if (!downConvertor.ok()) {
    std::cerr << "cannot access " << _devRoot << ", " << _dnName << "\n";
    perror("");
    exit(1);
  }

  // create the read buffer
  char* buf = new char[_bufferSize];

  // try to change scheduling to real-time
  makeRealTime();

 // start the loop
  int loopCount = 0;
  double total = 0;

  double startTime = nowTime();

  int lastMb = 0;

  while (1) {
    int n = downConvertor.read(buf, _bufferSize);
    if (n <= 0) {
      std::cerr << "read returned " << n << " ";
      if (n < 0)
	perror("");
      std::cerr << "\n";
    } else {
//      write(outFd, buf, n);
      total += n;
      loopCount++;
      int mb = (int)(total/1.0e6);
      if ((mb % 100) == 0 && mb > lastMb) {
	lastMb = mb;
	double elapsed = nowTime() - startTime;
	double bw = (total/elapsed)/1.0e6;

	int overruns = downConvertor.overUnderCount();

	std::cout << "total " << std::setw(5) << mb << " MB,  BW "
		  << std::setprecision(4) << std::setw(5) << bw
		  << " MB/s, overruns: "
		  << overruns << "\n";
      }


    }
    if (total > 2.0e9)
      break;
  }
}

