/*
 * HcrPmc730Daemon.cpp
 *
 * Application provided to open and provide access to HCR's PMC-730 multi-IO
 * card. Access to card functions and values is provided via XML-RPC methods.
 *
 *  Created on: Aug 9, 2013
 *      Author: hcr
 */
#include <csignal>
#include <sys/time.h>
#include <xmlrpc-c/registry.hpp>
#include <xmlrpc-c/server_abyss.hpp>

#include <toolsa/pmu.h>
#include <logx/Logging.h>
#include <HcrPmc730.h>
#include <QCoreApplication>

LOGGING("HcrPmc730Daemon")

/// Application instance name, for procmap
std::string _instance = "ops";

/// Global boolean set when exit from the application has been requested
bool ExitRequested = false;

// Handler for SIGINT and SIGTERM signals.
void
exitHandler(int signal) {
    ExitRequested = true;
}

// Handler for SIGALRM signals.
void
alarmHandler(int signal) {
    // Do nothing. This handler just assures that arrival of the signal doesn't
    // terminate our process. The intention of the signal is to force the
    // XML-RPC server runOnce() method to return occasionally, even if no
    // request comes in.
    DLOG << "Got itimer ALRM signal";
}

// Create a periodic ALRM signal to break us out of
// xmlrpc_c::serverAbyss::runOnce() so we can process Qt stuff.
void
startXmlrpcWorkAlarm() {
    const struct timeval tv = { 0, 100000 }; // 0.1 s
    const struct itimerval iv = { tv, tv };
    setitimer(ITIMER_REAL, &iv, 0);
}

// Stop the alarm which breaks us out of xmlrpc_c::serverAbyss::runOnce()
// while our server is actually processing an XML-RPC command.
void
stopXmlrpcWorkAlarm() {
    // Stop the periodic timer.
    const struct timeval tv = { 0, 0 }; // zero time stops the timer
    const struct itimerval iv = { tv, tv };
    setitimer(ITIMER_REAL, &iv, 0);
}

int
main(int argc, char * argv[]) {
    QCoreApplication app(argc, argv);
    app.setApplicationName("HcrPmc730Daemon");

    // Make sure the HcrPmc730 is instantiated in simulation mode if requested
//    HcrPmc730::doSimulate(hcrConfig.simulate_pmc730());
    HcrPmc730::doSimulate(false);

    // Just refer to theHcrPmc730() to instantiate the singleton.
    HcrPmc730::theHcrPmc730();

    // Initialize output lines.
    HcrPmc730::setXmitterFilamentOn(false);
    HcrPmc730::setXmitterHvOn(false);
    HcrPmc730::setHmcOperationMode(HcrPmc730::HMC_CORNER_REFLECTOR_CAL);

    // Create our XML-RPC method registry and server instance
    PMU_auto_register("instantiating XML-RPC server");
    xmlrpc_c::registry myRegistry;
//    myRegistry.addMethod("initializeUsingIwg1", new InitializeUsingIwg1Method);
    quint16 serverPort = 8003;
    xmlrpc_c::serverAbyss xmlrpcServer(myRegistry, serverPort);

    // Set up an interval timer to deliver SIGALRM every 0.01 s. The signal
    // arrival causes the XML-RPC server's runOnce() method to return so that
    // we can process Qt events on a regular basis.
    signal(SIGALRM, alarmHandler);
    startXmlrpcWorkAlarm();

    // set up registration with procmap
    PMU_auto_init("HcrPmc730Daemon", _instance.c_str(), PROCMAP_REGISTER_INTERVAL);
    ILOG << "HcrPmc730Daemon will register with procmap as instance: " << _instance;

}
