/*
 * profilerprod.cpp
 *
 *  Created on: Oct 14, 2009
 *      Author: burghart
 */

#include <QApplication>

#include <boost/program_options.hpp>
#include <QtConfig.h>
#include <ArgvParams.h>

#include "DDSPublisher.h"
#include "DDSSubscriber.h"
#include "ProductGenerator.h"
#include "QtTSReader.h"
#include "ProductWriter.h"

std::string _ORB;                ///< path to the ORB configuration file.
std::string _DCPS;               ///< path to the DCPS configuration file.
std::string _DCPSInfoRepo;       ///< URL to access DCPSInfoRepo
std::string _tsTopic;            ///< topic for (incoming) time-series
std::string _prodTopic;          ///< topic for (outgoing) products
int _DCPSDebugLevel=0;           ///< the DCPSDebugLevel
int _DCPSTransportDebugLevel=0;  ///< the DCPSTransportDebugLevel

namespace po = boost::program_options;

//////////////////////////////////////////////////////////////////////
///
/// get parameters that are specified in the configuration file.
/// These can be overriden by command line specifications.
void getConfigParams()
{

    QtConfig config("ProfilerProd", "ProfilerProd");

    // set up the default configuration directory path
    std::string ProfilerDir;
    char* e = getenv("PROFILERDIR");
    if (e) {
        ProfilerDir = std::string(e) + "/conf/";
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
    _ORB          = config.getString("DDS/ORBConfigFile",  orbFile);
    _DCPS         = config.getString("DDS/DCPSConfigFile", dcpsFile);
    _tsTopic      = config.getString("DDS/TopicTS",        "PROFILERTS");
    _prodTopic    = config.getString("DDS/TopicProduct",   "PROFILERPROD");
    _DCPSInfoRepo = config.getString("DDS/DCPSInfoRepo",   dcpsInfoRepo);
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
        ("DCPSDebugLevel", po::value<int>(&_DCPSDebugLevel), "DCPSDebugLevel ")
        ("DCPSTransportDebugLevel", po::value<int>(&_DCPSTransportDebugLevel), "DCPSTransportDebugLevel ")
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
main (int argc, char** argv) {

    // get the configuration parameters from the configuration file
    getConfigParams();

    // parse the command line options, substituting for config params.
    parseOptions(argc, argv);

    ArgvParams newargv("profilerprod");
    newargv["-ORBSvcConf"] = _ORB;
    newargv["-DCPSConfigFile"] = _DCPS;
    newargv["-DCPSInfoRepo"] = _DCPSInfoRepo;
    
    std::cout << "ORB service configuration: " << _ORB << std::endl;
    std::cout << "DCPS configuration: " << _DCPS << std::endl;
    std::cout << "DCPSInfoRepo: " << _DCPSInfoRepo << std::endl;
    if (_DCPSDebugLevel > 0)
        newargv["-DCPSDebugLevel"] = _DCPSDebugLevel;
    if (_DCPSTransportDebugLevel > 0)
        newargv["-DCPSTransportDebugLevel"] = _DCPSTransportDebugLevel;

    // create our DDS subscriber for incoming time-series data
    char **theArgv = newargv.argv();
    DDSSubscriber subscriber(newargv.argc(), theArgv);
    if (subscriber.status()) {
        std::cerr << "Unable to create a subscriber, exiting." << std::endl;
        exit(1);
    }
    // create our DDS publisher for outgoing products
    DDSPublisher publisher(newargv.argc(), theArgv);
    if (publisher.status()) {
        std::cerr << "Unable to create a publisher, exiting." << std::endl;
        exit(1);
    }

    QApplication app(argc, argv);

    // create the DDS reader for incoming time-series data
    QtTSReader *tsReader = new QtTSReader(subscriber, _tsTopic);

    // create the DDS writer for outgoing products
    ProductWriter *productWriter = new ProductWriter(publisher, _prodTopic);

    // create the products generator thread and run it
    float rfRcvrGain = 40.0;
    float pentek7142Gain = -2.67;
    ProductGenerator generator(tsReader, productWriter, rfRcvrGain, pentek7142Gain, -110.0, 1024);
    generator.run();

    return app.exec();
}

