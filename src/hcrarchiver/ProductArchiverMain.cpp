#include <iostream>
#include <csignal>

#include <ArgvParams.h>
#include <QtConfig.h>
#include <XmlRpc.h>
#include <DDSSubscriber.h>
#include <boost/date_time/posix_time/posix_time.hpp>
#include <boost/program_options.hpp>

#include "svnInfo.h"
#include "ProductArchiver.h"

namespace po = boost::program_options;

// command line args - file scope

static std::string _dataDirDefault = "/data_first";
static int _rpcPortDefault = 60003;
static int _raysPerFileDefault = 1000;
static std::string _calFilePathDefault = "../hcrprod/hcr_cal.xml";

static std::string _dataDir;
static int _rpcPort;
static int _raysPerFile;
static std::string _calFilePath;

// Current write rate, in rays/second
float WriteRate = 0.0;

// The hcr configuration directory ($HCRDIR/conf)
std::string HcrConfigDir;


// Our RPC server
using namespace XmlRpc;
XmlRpcServer RpcSvr;

// Start()
// Null method, provided for convenience.
class StartMethod : public XmlRpcServerMethod {
public:
    StartMethod(XmlRpcServer* s) : XmlRpcServerMethod("Start", s) {}

    void execute(XmlRpcValue& params, XmlRpcValue& result)
    {
        result = 0;
        std::cout << "got start command" << std::endl;
    }
} startMethod(&RpcSvr);

// Stop()
// Null method, provided for convenience.
class StopMethod : public XmlRpcServerMethod {
public:
    StopMethod(XmlRpcServer* s) : XmlRpcServerMethod("Stop", s) {}

    void execute(XmlRpcValue& params, XmlRpcValue& result)
    {
        result = 0;
        std::cout << "got stop command" << std::endl;
    }
} stopMethod(&RpcSvr);

// status()
// Return a map of status values
class StatusMethod : public XmlRpcServerMethod {
public:
    StatusMethod(XmlRpcServer* s) : XmlRpcServerMethod("status", s) {}

    void execute(XmlRpcValue& params, XmlRpcValue& result)
    {
        XmlRpc::XmlRpcValue retval;
        retval["rate"] = WriteRate;
        // Return the map
        result = retval;
    }
} statusMethod(&RpcSvr);


// Time to quit?
bool Quit = false;

// Signal handler for SIGINT provides a clean shutdown on ^C
void
signalHandler(int signum) {
    Quit = 1;
}

//////////////////////////////////////////////////////////////////////
/// Parse the command line options

void parseOptions(int argc, char** argv)

{

  // get the options
  po::options_description descripts("Options");
  char outputDirHelp[1024];
  sprintf(outputDirHelp, "output data dir, default: '%s'",
          _dataDirDefault.c_str());
  char rpcPortHelp[1024];
  sprintf(rpcPortHelp, "XML RPC port, default: %d",
          _rpcPortDefault);
  char raysPerFileHelp[1024];
  sprintf(raysPerFileHelp, "Num rays per CfRadial file, default: %d",
          _raysPerFileDefault);
  char calFilePathHelp[1024];
  sprintf(calFilePathHelp, "path to cal file, default: '%s'",
          _calFilePathDefault.c_str());
  descripts.add_options()
    ("help", "describe options")
    ("DataDir", po::value<std::string>(&_dataDir), outputDirHelp)
    ("RpcPort", po::value<int>(&_rpcPort), rpcPortHelp)
    ("RaysPerFile", po::value<int>(&_raysPerFile), raysPerFileHelp)
    ("CalibFilePath", po::value<std::string>(&_calFilePath), calFilePathHelp)
    ;

  po::variables_map vm;
  po::store(po::parse_command_line(argc, argv, descripts), vm);
  po::notify(vm);
  
  if (vm.count("help")) {
    std::cout << descripts << std::endl;
    exit(1);
  }

}

int
main(int argc, char *argv[])
{

    std::cout << "productarchiver rev " << SVNREVISION << " from " <<
        SVNURL << std::endl;
    std::cout << "My PID is " << getpid() << std::endl;

    // Configuration

    // get the configuration
    QtConfig eaConfig("ProductArchiver", "ProductArchiver");

    // set up the configuration directory path: $HCRDIR/conf/
    char* e = getenv("HCRDIR");
    if (!e) {
        std::cerr << "Environment variable HCRDIR must be set." << std::endl;
        exit(1);
    }
    HcrConfigDir = std::string(e) + "/conf/";

    std::string orbConfigFile =
        eaConfig.getString("DDS/ORBConfigFile", HcrConfigDir + "ORBSvc.conf");
    std::string dcpsConfigFile =
        eaConfig.getString("DDS/DCPSConfigFile", HcrConfigDir + "DDSClient.ini");
    std::string dcpsInfoRepo =
        eaConfig.getString("DDS/DCPSInfoRepo", "iiop://localhost:50000/DCPSInfoRepo");
    std::string productsTopic =
        eaConfig.getString("TopicProduct", "HCRPROD");

    _dataDir = eaConfig.getString("DataDir", _dataDirDefault);
    _rpcPort = eaConfig.getInt("RpcPort", _rpcPortDefault);
    _raysPerFile = eaConfig.getInt("RaysPerFile", _raysPerFileDefault);
    _calFilePath = eaConfig.getString("CalFilePath", _calFilePathDefault);

    // Override options from command line

    parseOptions(argc, argv);

    std::cout << "Writing data to dir: " << _dataDir << std::endl;
    std::cout << "Rpc port: " << _rpcPort << std::endl;
    std::cout << "Rays per file: " << _raysPerFile << std::endl;
    std::cout << "Cal file path: " << _calFilePath << std::endl;
    
    // Call signalHandler() if we get SIGINT (^C from the keyboard) or
    // SIGTERM (e.g., default for the 'kill' command)
    struct sigaction sa;
    sa.sa_handler = signalHandler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;
    if (sigaction(SIGINT, &sa, 0) != 0) {
        perror("Failed to change action for SIGINT");
        exit(1);
    }    
    if (sigaction(SIGTERM, &sa, 0) != 0) {
        perror("Failed to change action for SIGTERM");
        exit(1);
    }    
    
    // create the subscriber
    ArgvParams subParams(argv[0]);
    subParams["-ORBSvcConf"] = orbConfigFile;
    subParams["-DCPSConfigFile"] = dcpsConfigFile;
    subParams["-DCPSInfoRepo"] = dcpsInfoRepo;

    DDSSubscriber subscriber(subParams.argc(), subParams.argv());
    int subStatus = subscriber.status();
    if (subStatus) {
        std::cerr << "Error " << subStatus << " creating subscriber" << std::endl;
        exit(subStatus);
    }

    // Instantiate our netCDF CFRadial archiver
    ProductArchiver* archiver =
      new ProductArchiver(subscriber, 
                          productsTopic,
                          _dataDir,
                          _raysPerFile,
                          RadxFile::FILE_FORMAT_CFRADIAL,
                          _calFilePath);

    // Initialize our RPC server
    RpcSvr.bindAndListen(_rpcPort);
    RpcSvr.enableIntrospection(true);

    while (! Quit) {
        // How much have we written?
        std::cerr << archiver->raysRead() << " rays read, " <<
            archiver->raysWritten() << " rays written, " << 
            std::setprecision(2) << 
            float(archiver->bytesWritten()) / (1024*1024) << " MB written" << 
            std::endl;
        
        // Listen for RPC commands for a bit
        RpcSvr.work(5.0);   // 5 seconds
    }
    RpcSvr.shutdown();
    
    // Delete our archiver, which will write out any unwritten data.
    delete(archiver);
    
    // XXX KLUGE! Just call exit(0) now to avoid a call to our DDSSubscriber's
    // destructor.  It causes a segfault, and there's no time at the moment to 
    // track it down...  (cb 4 Jun 2010)
    exit(0);
}

