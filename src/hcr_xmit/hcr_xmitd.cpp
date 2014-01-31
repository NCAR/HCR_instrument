/*
 * hcr_xmitd.cpp
 *
 *  Created on: Jan 5, 2011
 *      Author: burghart
 */

#include <string>
#include <cerrno>
#include <csignal>
#include <cstring>
#include <cstdlib>
#include <ctime>
#include <deque>
#include <vector>
#include <unistd.h>
#include <sys/time.h>
#include <sys/types.h>
#include <boost/program_options.hpp>
#include <QCoreApplication>

#include <toolsa/pmu.h>
#include <logx/Logging.h>
#include <log4cpp/SyslogAppender.hh>
#include <RecentHistoryAppender.h>

#include <XmlRpc.h>

#include "HcrXmitter.h"

namespace po = boost::program_options;

LOGGING("hcr_xmitd")

/// Our transmitter
HcrXmitter *Xmitter = 0;

/// Our RPC server
using namespace XmlRpc;
XmlRpcServer RpcServer;

// log4cpp Appender which keeps around the 50 most recent log messages. 
logx::RecentHistoryAppender RecentLogHistory("RecentHistoryAppender", 50);

// Description of command line options
po::options_description OptionsDesc("Options");

/// Run in foreground?
bool Foreground = false;

/// Default instance name for procmap
std::string InstanceName = "";

/// Signal handler to allow for clean shutdown on SIGINT and SIGTERM
bool Terminate = false;
void sigHandler(int sig) {
  ILOG << "Interrupt received...termination may take a few seconds";
  Terminate = true;
}

/**
 * @brief Xmlrpc++ method to get transmitter status from hcr_xmitd. 
 *
 * The method returns a XmlRpc::XmlRpcValue struct (dictionary) mapping 
 * std::string keys to XmlRpc::XmlRpcValue values. Pass the dictionary
 * to the XmitStatus(XmlRpcValue & dict) constructor to create a usable
 * XmitStatus object.
 * Example client usage, where hcr_xmitd is running on machine `xmitserver`:
 * @code
 *     #include <XmlRpc.h>
 *     ...
 *
 *     // Get the transmitter status from hcr_xmitd on xmitserver.local.net on port 8080
 *     XmlRpc::XmlRpcClient client("xmitserver.local.net", 8080);
 *     const XmlRpc::XmlRpcValue nullParams;
 *     XmlRpc::XmlRpcValue statusDict;
 *     client.execute("getStatus", nullParams, statusDict);
 *
 *     // create an XmitStatus object from the returned dictionary
 *     XmitStatus status(statusDict);
 *
 *     // extract a couple of values from the status
 *     bool filamentOn = status.filamentOn();;
 *     double cathodeVoltage = status.cathodeVoltage();
 * @endcode
 */
class GetStatusMethod : public XmlRpcServerMethod {
public:
    GetStatusMethod(XmlRpcServer *s) : XmlRpcServerMethod("getStatus", s) {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        DLOG << "Received 'getStatus' command";
        retvalP = Xmitter->getStatus().toXmlRpcValue();
        XmitStatus rStatus(retvalP);
        DLOG << "returned status w/xmitter temp " << rStatus.xmitterTemp() << " deg C";
    }
} getStatusMethod(&RpcServer);

/// Xmlrpc++ method to turn on the transmitter klystron filament.
class XmitFilamentOnMethod : public XmlRpcServerMethod {
public:
    XmitFilamentOnMethod(XmlRpcServer *s) : XmlRpcServerMethod("xmitFilamentOn", s) {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        ILOG << "Received 'xmitFilamentOn' command";
        Xmitter->setFilamentState(true);    // turn filament on
    }
} xmitFilamentOnMethod(&RpcServer);

/// Xmlrpc++ method to turn off the transmitter klystron filament.
class XmitFilamentOffMethod : public XmlRpcServerMethod {
public:
    XmitFilamentOffMethod(XmlRpcServer *s) : XmlRpcServerMethod("xmitFilamentOff", s) {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        ILOG << "Received 'xmitFilamentOff' command";
        Xmitter->setFilamentState(false);   // turn filament off
    }
} xmitFilamentOffMethod(&RpcServer);

/// Xmlrpc++ method to turn on the transmitter high voltage.
class XmitHvOnMethod : public XmlRpcServerMethod {
public:
    XmitHvOnMethod(XmlRpcServer *s) : XmlRpcServerMethod("xmitHvOn", s) {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        ILOG << "Received 'xmitHvOn' command";
        Xmitter->setHvState(true);  // turn HV on
    }
} xmitHvOnMethod(&RpcServer);

/// Xmlrpc++ method to turn off the transmitter high voltage.
class XmitHvOffMethod : public XmlRpcServerMethod {
public:
    XmitHvOffMethod(XmlRpcServer *s) : XmlRpcServerMethod("xmitHvOff", s) {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        ILOG << "Received 'xmitHvOff' command";
        Xmitter->setHvState(true);  // turn HV off
    }
} xmitHvOffMethod(&RpcServer);

/// Xmlrpc++ method to get a string containing all available xmitd log 
/// messages at or later than the given index. If the index is zero, all 
/// available messages are returned. The method returns a XmlRpc::XmlRpcValue 
/// struct (dictionary) mapping std::string keys to XmlRpc::XmlRpcValue values.
/// The dictionary will contain:
/// <table border>
///   <tr>
///     <td><b>key</b></td>
///     <td><b>value type</b></td>
///     <td><b>value</b></td>
///   </tr>
///   <tr>
///     <td>logMessages</td>
///     <td>string</td>
///     <td>A string holding all of the requested log messages</td>
///   </tr>
///   <tr>
///     <td>nextIndex</td>
///     <td>int</td>
///     <td>The index of the next log message following the returned messages</td>
///   </tr>
class GetLogMessagesMethod : public XmlRpcServerMethod {
public:
    GetLogMessagesMethod(XmlRpcServer *s) : XmlRpcServerMethod("getLogMessages", s) {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        DLOG << "getLogMessages command received";
        if (paramList[0].getType() != XmlRpcValue::TypeInt) {
            ELOG << "getLogMessages got non-integer param[0]!";
        }
        unsigned int startIndex = int(paramList[0]);
        // Note that the parameter to getMessages() is in/out, and on return
        // it will contain the next index to get.
        std::vector<std::string> msgs = RecentLogHistory.getMessages(startIndex);
        std::string appendedMsgs("");
        for (unsigned int i = 0; i < msgs.size(); i++) {
            appendedMsgs.append(msgs[i]);
        }
        // Trim a trailing newline
        if (appendedMsgs[appendedMsgs.size() - 1] == '\n')
            appendedMsgs.resize(appendedMsgs.size() - 1);
        
        XmlRpcValue dict;
        dict["logMessages"] = appendedMsgs;
        dict["nextIndex"] = int(startIndex);
        retvalP = dict;
    }
} getLogMessagesMethod(&RpcServer);

/// Print usage information
void
usage(const char* argv0) {
    std::cerr << "Usage: " << argv0 << 
            " [option]... <xmitter_ttydev> <server_port>" << std::endl;
    std::cerr << OptionsDesc << std::endl;
    logx::LogUsage(std::cerr);
    std::cerr << std::endl;
    std::cerr << "Use ""SimulatedHcrXmitter"" as <xmitter_ttydev> to " << 
            "simulate a transmitter" << std::endl;
}

/// Parse the command line options, removing the successfully parsed bits from
/// argc/argv.
void
parseOptions(int & argc, char** argv)
{
    // get the options
    OptionsDesc.add_options()
            ("help", "Describe options")
            ("foreground", po::bool_switch(&Foreground),
                    "Run in foreground, rather than as a daemon process")
            ("instance", po::value<std::string>(&InstanceName), 
                    "Instance name for procmap")
            ;

    po::variables_map vm;
    po::command_line_parser parser(argc, argv);
    parser.options(OptionsDesc);
    po::parsed_options parsedOpts = parser.run();
    po::store(parsedOpts, vm);
    po::notify(vm);
    
    if (vm.count("help")) {
        usage(argv[0]);
        exit(0);
    }
    
    // Retain only the unparsed args in argv, adjusting argc and argv
    std::vector<std::string> unparsed = 
            po::collect_unrecognized(parsedOpts.options, po::include_positional);
    argc = 1 + unparsed.size();
    for (unsigned int i = 0; i < unparsed.size(); i++) {
        argv[i + 1] = strdup(unparsed[i].c_str());
    }
}


int
main(int argc, char *argv[]) {
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);
    
    // Get our local options
    parseOptions(argc, argv);
    
    // We need a QCoreApplication
    QCoreApplication app(argc, argv);

    // Append our log to the recent history
    log4cpp::Category::getRoot().addAppender(RecentLogHistory);

    // Remaining args should just be serial device for the transmitter and
    // port number we should use.
    if (argc != 3) {
        std::cout << "remaining args: ";
        for (int i = 0; i < argc; i++) {
            std::cout << argv[i] << " ";
        }
        std::cout << std::endl;
        usage(argv[0]);
        exit(1);
    }
    
    // Normally we fork off a background process and run as a daemon
    if (! Foreground) {
        pid_t pid = fork();
        if (pid < 0) {
            ELOG << "Error forking: " << strerror(errno);
            exit(1);
        } else if (pid > 0) {
            exit(0);    // parent process exits now, leaving the child in background
        }
    }
    
    // Initialize registration with procmap if instance is specified
    if (InstanceName.size() > 0) {
        PMU_auto_init("hcr_xmitd", InstanceName.c_str(), PROCMAP_REGISTER_INTERVAL);
        ILOG << "Initializing procmap registration as instance '" << 
                InstanceName << "'";
    }

    ILOG << "hcr_xmitd (" << getpid() << ") started";

    // Instantiate and start our transmitter thread, communicating over the
    // given serial port
    PMU_auto_register("instantiating HcrXmitter");
    Xmitter = new HcrXmitter(argv[1]);
    Xmitter->start();
    
    // Initialize our RPC server
    PMU_auto_register("starting XML-RPC server");
    RpcServer.bindAndListen(atoi(argv[2]));
    RpcServer.enableIntrospection(true);
    
    // catch a control-C or kill to shut down cleanly
    signal(SIGINT, sigHandler);
    signal(SIGTERM, sigHandler);

    /*
     * Process Qt events. Listen briefly for XML-RPC commands. Repeat.
     */
    while (true) {
        // Exit when we're told to
        if (Terminate) {
            break;
        }

        // Register with procmap
        PMU_auto_register("running");

        // Process pending Qt events
        app.processEvents();

        // Listen for XML-RPC commands.
        // Note that work() mostly goes for 2x the given time, but sometimes
        // goes for 1x the given time. Who knows why?
        RpcServer.work(0.01);
    }
    
    delete(Xmitter);
    ILOG << "hcr_xmitd (" << getpid() << ") exiting";
    return 0;
} 
