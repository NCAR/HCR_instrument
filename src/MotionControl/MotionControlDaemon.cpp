/*
 * MotionControlDaemon.cpp
 *
 *  Created on: May 30, 2013
 *      Author: avaps
 */

#include <csignal>
#include <iostream>
#include <QtGui>
#include "svnInfo.h"
#include <toolsa/pmu.h>
#include <logx/Logging.h>

#include <xmlrpc-c/base.hpp>
#include <xmlrpc-c/registry.hpp>
#include <xmlrpc-c/server_abyss.hpp>

#include "MotionControl.h"

LOGGING("MotionControlDaemon")

quint16 ServerPort = 8080;

// QApplication instance
QCoreApplication * App = 0;

// MotionControl instance
MotionControl * Control = 0;

// PMU application instance name
std::string PmuInstance = "ops";   ///< application instance

// Set to true when it's time to terminate
bool Terminate = false;

/////////////////////////////////////////////////////////////////////
// Shutdown handler for for SIGINT and SIGTERM signals.
void
shutdownHandler(int signal) {
    ILOG << "Shutting down!";
    Terminate = true;
}

/////////////////////////////////////////////////////////////////////
// Handler for SIGALRM signals.
void
alarmHandler(int signal) {
    // Do nothing. This handler just assures that arrival of the signal doesn't
    // terminate our process. The intention of the signal is to force the
    // XML-RPC server runOnce() method to return occasionally, even if no
    // request comes in.
}

/////////////////////////////////////////////////////////////////////
// Create a periodic ALRM signal to break us out of
// xmlrpc_c::serverAbyss::runOnce() so we can process Qt stuff.
void
startXmlrpcWorkAlarm() {
    //    const struct timeval tv = { 0, 500000 }; // 0.5s (2Hz)
    //    const struct timeval tv = { 0, 100000 }; // 0.1s (10Hz)
    const struct timeval tv = { 0, 50000 }; // 0.05s (20Hz)
    //    const struct timeval tv = { 0, 10000 }; // 0.01s (100Hz)
    //    const struct timeval tv = { 0, 6667 }; // 0.0067s (150Hz)
    const struct itimerval iv = { tv, tv };
    setitimer(ITIMER_REAL, &iv, 0);
}

/////////////////////////////////////////////////////////////////////
// Stop the alarm which breaks us out of xmlrpc_c::serverAbyss::runOnce()
// while our server is actually processing an XML-RPC command.
void
stopXmlrpcWorkAlarm() {
    // Stop the periodic timer.
    const struct timeval tv = { 0, 0 }; // zero time stops the timer
    const struct itimerval iv = { tv, tv };
    setitimer(ITIMER_REAL, &iv, 0);
}

/////////////////////////////////////////////////////////////////////
class DriveHomeMethod : public xmlrpc_c::method
{
public:
    DriveHomeMethod() {
        // The method has integer result and no argument
        this->_signature = "i:";
        this->_help = "This method takes drive to home position";
    }

    void
    execute(xmlrpc_c::paramList const& paramList, xmlrpc_c::value* const retvalP)
    {
        // Stop the work alarm while we're working.
        stopXmlrpcWorkAlarm();

        paramList.verifyEnd(0);

        Control->homeDrive();

        *retvalP = xmlrpc_c::value_int(0);

        // Restart the work alarm.
        startXmlrpcWorkAlarm();
    }
};

/////////////////////////////////////////////////////////////////////
class DrivePointMethod : public xmlrpc_c::method
{
public:
    DrivePointMethod() {
        // The method has integer result and double argument
        this->_signature = "i:d";
        this->_help = "This method takes drive point angle from client";
    }

    void
    execute(xmlrpc_c::paramList const& paramList, xmlrpc_c::value* const retvalP)
    {
        // Stop the work alarm while we're working.
        stopXmlrpcWorkAlarm();

        double const angle(paramList.getDouble(0));
        paramList.verifyEnd(1);

        Control->point(angle);

        *retvalP = xmlrpc_c::value_int(0);

        // Restart the work alarm.
        startXmlrpcWorkAlarm();
    }
};

/////////////////////////////////////////////////////////////////////
class DriveScanMethod : public xmlrpc_c::method
{
public:
    DriveScanMethod() {
        // The method has integer result and double arguments
        this->_signature = "i:ddd";
        this->_help = "This method takes drive scan between given limits, "
                "at the given scan rate";
    }

    void
    execute(xmlrpc_c::paramList const& paramList, xmlrpc_c::value* const retvalP)
    {
        // Stop the work alarm while we're working.
        stopXmlrpcWorkAlarm();

        double const ccwLimit(paramList.getDouble(0));
        double const cwLimit(paramList.getDouble(1));
        double const scanRate(paramList.getDouble(2));
        paramList.verifyEnd(3);

        Control->scan(ccwLimit, cwLimit, scanRate);

        *retvalP = xmlrpc_c::value_int(0);

        // Restart the work alarm.
        startXmlrpcWorkAlarm();
    }
};

/////////////////////////////////////////////////////////////////////
class StatusMethod : public xmlrpc_c::method
{
public:
    StatusMethod() {
        // The method takes no arguments, and returns a struct
        this->_signature = "S:";
        this->_help = "This method returns servo drive status";
    }

    void
    execute(xmlrpc_c::paramList const& paramList, xmlrpc_c::value* const retvalP)
    {
        // Stop the work alarm while we're working.
        stopXmlrpcWorkAlarm();

        paramList.verifyEnd(0);

        // Get current status of our MotionControl, pack it into an
        // xmlrpc_c::value_struct, and return the struct.
        xmlrpc_c::value_struct dict = Control->status().to_value_struct();
        *retvalP = dict;

        // Restart the work alarm.
        startXmlrpcWorkAlarm();
    }
};

/////////////////////////////////////////////////////////////////////
class SetCorrectionEnabledMethod : public xmlrpc_c::method
{
public:
    SetCorrectionEnabledMethod() {
        // The method takes a boolean argument, and returns nil
        this->_signature = "n:b";
        this->_help = "This method enables/disables attitude correction";
    }

    void
    execute(xmlrpc_c::paramList const& paramList, xmlrpc_c::value* const retvalP)
    {
        // Stop the work alarm while we're working.
        stopXmlrpcWorkAlarm();

        bool const enabled(paramList.getBoolean(0));
        paramList.verifyEnd(1);

        Control->setCorrectionEnabled(enabled);

        // Restart the work alarm.
        startXmlrpcWorkAlarm();
    }
};

/////////////////////////////////////////////////////////////////////
int
main(int argc, char** argv)
{
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);

    // set up registration with procmap if instance is specified
    if (PmuInstance.size() > 0) {
        PMU_auto_init("cmigitsDaemon", PmuInstance.c_str(), PROCMAP_REGISTER_INTERVAL);
        ILOG << "will register with procmap, instance: " << PmuInstance;
    }

    // Create the Qt application and our drive connection
    App = new QCoreApplication(argc, argv);
    Control = new MotionControl();

    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("Home", new DriveHomeMethod);
    myRegistry.addMethod("Point", new DrivePointMethod);
    myRegistry.addMethod("Scan", new DriveScanMethod);
    myRegistry.addMethod("Status", new StatusMethod);
    myRegistry.addMethod("SetCorrectionEnabled", new SetCorrectionEnabledMethod);
    xmlrpc_c::serverAbyss xmlrpcServer(myRegistry, ServerPort);

    // catch a control-C or kill to shut down cleanly
    signal(SIGINT, shutdownHandler);
    signal(SIGTERM, shutdownHandler);

    // Set up an interval timer to deliver SIGALRM every 0.01 s. The signal
    // arrival causes the XML-RPC server's runOnce() method to return so that
    // we can process Qt events on a regular basis.
    signal(SIGALRM, alarmHandler);
    startXmlrpcWorkAlarm();

    while (true) {
        PMU_auto_register("running");

        if (Terminate)
            break;

        // Waits for the next connection, accepts it, reads the HTTP
        // request, executes the indicated RPC, and closes the connection.
        xmlrpcServer.runOnce();

        // update aircraft attitude
        Control->correctForAttitude();

        // Process Qt events
        App->processEvents();
    }

    delete(Control);
    delete(App);
    return 0;
}
