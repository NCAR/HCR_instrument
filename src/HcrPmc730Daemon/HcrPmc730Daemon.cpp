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
#include <HcrPmc730Status.h>
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

// Generate a periodic ALRM signal to break us out of
// xmlrpc_c::serverAbyss::runOnce() so we can process Qt stuff.
void
startXmlrpcWorkAlarm() {
    const struct timeval tv = { 0, 100000 }; // 0.1 s
    const struct itimerval iv = { tv, tv };
    setitimer(ITIMER_REAL, &iv, 0);
}

// While our server is actually processing an XML-RPC command, disable the alarm
// which breaks us out of xmlrpc_c::serverAbyss::runOnce().
void
stopXmlrpcWorkAlarm() {
    // Stop the periodic timer.
    const struct timeval tv = { 0, 0 }; // zero time stops the timer
    const struct itimerval iv = { tv, tv };
    setitimer(ITIMER_REAL, &iv, 0);
}

// XML-RPC method to turn on transmitter filament
class XmitFilamentOnMethod : public xmlrpc_c::method {
public:
    XmitFilamentOnMethod() {
        // Method takes no arguments, returns nil
        this->_signature = "n:";
        this->_help = "This method turns on the transmitter filament.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        // Stop the work alarm while we're working.
        stopXmlrpcWorkAlarm();

        ILOG << "Executing XML-RPC call to xmitFilamentOn()";
        HcrPmc730::setXmitterFilamentOn(true);

        // Restart the work alarm.
        startXmlrpcWorkAlarm();
    }
};

// XML-RPC method to turn off transmitter filament
class XmitFilamentOffMethod : public xmlrpc_c::method {
public:
    XmitFilamentOffMethod() {
        // Method takes no arguments, returns nil
        this->_signature = "n:";
        this->_help = "This method turns off the transmitter filament.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        // Stop the work alarm while we're working.
        stopXmlrpcWorkAlarm();

        ILOG << "Executing XML-RPC call to xmitFilamentOff()";
        HcrPmc730::setXmitterFilamentOn(false);

        // Restart the work alarm.
        startXmlrpcWorkAlarm();
    }
};

// XML-RPC method to turn on transmitter high voltage
class XmitHvOnMethod : public xmlrpc_c::method {
public:
    XmitHvOnMethod() {
        // Method takes no arguments, returns nil
        this->_signature = "n:";
        this->_help = "This method turns on the transmitter high voltage.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        // Stop the work alarm while we're working.
        stopXmlrpcWorkAlarm();

        ILOG << "Executing XML-RPC call to xmitHvOn()";
        HcrPmc730::setXmitterHvOn(true);

        // Restart the work alarm.
        startXmlrpcWorkAlarm();
    }
};

// XML-RPC method to turn off transmitter high voltage
class XmitHvOffMethod : public xmlrpc_c::method {
public:
    XmitHvOffMethod() {
        // Method takes no arguments, returns nil
        this->_signature = "n:";
        this->_help = "This method turns off the transmitter high voltage.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        // Stop the work alarm while we're working.
        stopXmlrpcWorkAlarm();

        ILOG << "Executing XML-RPC call to xmitHvOff()";
        HcrPmc730::setXmitterHvOn(false);

        // Restart the work alarm.
        startXmlrpcWorkAlarm();
    }
};

// XML-RPC method to set HMC mode
class SetHmcModeMethod : public xmlrpc_c::method {
public:
    SetHmcModeMethod() {
        // Method take an integer argument (the mode), and returns nil
        this->_signature = "n:i";
        this->_help = "This method sets HMC mode.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        // Stop the work alarm while we're working.
        stopXmlrpcWorkAlarm();

        ILOG << "Executing XML-RPC call to setHmcMode()";
        int mode = paramList.getInt(0);
        paramList.verifyEnd(1);

        HcrPmc730::setHmcOperationMode(static_cast<HcrPmc730::HmcOperationMode>(mode));

        // Restart the work alarm.
        startXmlrpcWorkAlarm();
    }
};

/// XML-RPC method to get current monitored values from the PMC-730. The
/// returned xmlrpc_c::value_struct can be used to construct an HcrPmc730Status
/// object.
class GetHcrPmc730StatusMethod : public xmlrpc_c::method {
public:
    GetHcrPmc730StatusMethod() {
        // Method takes no arguments, and returns an xmlrpc_c::value_struct
        // which can be used to construct an HcrPmc730Status object.
        this->_signature = "s:";
        this->_help = "This method returns current monitored values from the PMC-730.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        // Stop the work alarm while we're working.
        stopXmlrpcWorkAlarm();

        ILOG << "Executing XML-RPC call to getHcrPmc730Status()";
        paramList.verifyEnd(0);
        *retvalP = HcrPmc730Status().toXmlRpcValue();

        // Restart the work alarm.
        startXmlrpcWorkAlarm();
    }
};

int
main(int argc, char * argv[]) {
    QCoreApplication app(argc, argv);
    app.setApplicationName("HcrPmc730Daemon");

    // Make sure the HcrPmc730 gets instantiated in simulation mode if requested
//    HcrPmc730::doSimulate(hcrConfig.simulate_pmc730());
    HcrPmc730::doSimulate(false);

    // Just refer to theHcrPmc730() to instantiate the singleton.
    HcrPmc730::theHcrPmc730();

    // Initialize output lines: transmitter filament off, transmitter HV off,
    // HMC in "corner reflector calibration" mode.
    HcrPmc730::setXmitterFilamentOn(false);
    HcrPmc730::setXmitterHvOn(false);
    HcrPmc730::setHmcOperationMode(HcrPmc730::HMC_CORNER_REFLECTOR_CAL);

    // Create our XML-RPC method registry and server instance
    PMU_auto_register("instantiating XML-RPC server");
    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("xmitFilamentOn", new XmitFilamentOnMethod);
    myRegistry.addMethod("xmitFilamentOff", new XmitFilamentOffMethod);
    myRegistry.addMethod("xmitHvOn", new XmitHvOnMethod);
    myRegistry.addMethod("xmitHvOff", new XmitHvOffMethod);
    myRegistry.addMethod("setHmcMode", new SetHmcModeMethod);
    myRegistry.addMethod("getHcrPmc730Status", new GetHcrPmc730StatusMethod);
    // We listen on port 8003 for XML-RPC calls
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

    return 0;
}
