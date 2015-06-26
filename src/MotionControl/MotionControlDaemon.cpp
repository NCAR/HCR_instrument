/*
 * MotionControlDaemon.cpp
 *
 *  Created on: May 30, 2013
 *      Author: avaps
 */

#include <csignal>
#include <iostream>
#include <QCoreApplication>
#include <QTimer>
#include "svnInfo.h"
#include <toolsa/pmu.h>
#include <logx/Logging.h>

#include <xmlrpc-c/registry.hpp>
#include <QFunctionWrapper.h>
#include <QXmlRpcServerAbyss.h>

#include "MotionControl.h"

LOGGING("MotionControlDaemon")

quint16 ServerPort = 8080;

// QApplication instance
QCoreApplication * App = 0;

// MotionControl instance
MotionControl * Control = 0;

// PMU application instance name
std::string PmuInstance = "ops";   ///< application instance

// Count values to be assigned to the "home position" for each of the drives.
// Optimally, these are set so that putting both drives at their zero positions
// will cause the radar beam to be pointing exactly at zenith when the C-MIGITS
// is reporting zero roll and zero pitch.

static const int ROT_DRIVE_HOME_COUNTS = 3377;  // from CSET TF01 (offset measured w/stabilization on)
static const int TILT_DRIVE_HOME_COUNTS = -386; // from CSET TF01 (offset measured w/stabilization on)

/////////////////////////////////////////////////////////////////////
// Shutdown handler for for SIGINT and SIGTERM signals.
void
shutdownHandler(int signal) {
    ILOG << "Shutting down!";
    App->quit();
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
        paramList.verifyEnd(0);

        Control->homeDrive(ROT_DRIVE_HOME_COUNTS, TILT_DRIVE_HOME_COUNTS);

        *retvalP = xmlrpc_c::value_int(0);
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
        double const angle(paramList.getDouble(0));
        paramList.verifyEnd(1);

        Control->point(angle);

        *retvalP = xmlrpc_c::value_int(0);
    }
};

/////////////////////////////////////////////////////////////////////
class DriveScanMethod : public xmlrpc_c::method
{
public:
    DriveScanMethod() {
        // The method has integer result and double arguments
        this->_signature = "i:dddd";
        this->_help = "This method takes drive scan between given limits, "
                "at the given scan rate and beam tilt angle";
    }

    void
    execute(xmlrpc_c::paramList const& paramList, xmlrpc_c::value* const retvalP)
    {
        double const ccwLimit(paramList.getDouble(0));
        double const cwLimit(paramList.getDouble(1));
        double const scanRate(paramList.getDouble(2));
        double const beamTilt(paramList.getDouble(3));
        paramList.verifyEnd(4);

        try {
            Control->scan(ccwLimit, cwLimit, scanRate, beamTilt);
            *retvalP = xmlrpc_c::value_int(0);
        } catch (const std::runtime_error & e) {
            ELOG << "XML-RPC 'scan' method failed: " << e.what();
            *retvalP = xmlrpc_c::value_int(1);
        }
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
        paramList.verifyEnd(0);

        // Get current status of our MotionControl, pack it into an
        // xmlrpc_c::value_struct, and return the struct.
        xmlrpc_c::value_struct dict = Control->status().to_value_struct();
        *retvalP = dict;
    }
};

/////////////////////////////////////////////////////////////////////
class SetCorrectionEnabledMethod : public xmlrpc_c::method
{
public:
    SetCorrectionEnabledMethod() {
        // The method takes a boolean argument, and returns 0 on success
        this->_signature = "i:b";
        this->_help = "This method enables/disables attitude correction";
    }

    void
    execute(xmlrpc_c::paramList const& paramList, xmlrpc_c::value* const retvalP)
    {
        bool const enabled(paramList.getBoolean(0));
        paramList.verifyEnd(1);

        Control->setCorrectionEnabled(enabled);

        *retvalP = xmlrpc_c::value_int(0);
    }
};

/////////////////////////////////////////////////////////////////////
class HomingInProgressMethod : public xmlrpc_c::method
{
public:
    HomingInProgressMethod() {
        // The method takes no arguments, and returns a bool
        this->_signature = "b:";
        this->_help = "This method returns true iff drive homing is in progress";
    }

    void
    execute(xmlrpc_c::paramList const& paramList, xmlrpc_c::value* const retvalP)
    {
        paramList.verifyEnd(0);

        // Get current status of our MotionControl, pack it into an
        // xmlrpc_c::value_struct, and return the struct.
        *retvalP = xmlrpc_c::value_boolean(Control->homingInProgress());
    }
};

/////////////////////////////////////////////////////////////////////
void
updatePMURegistration() {
    // Make sure we remain registered with PMU, so it knows we're alive
    PMU_auto_register("running");
}

/////////////////////////////////////////////////////////////////////
int
main(int argc, char** argv)
{
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);

    // set up registration with procmap if instance is specified
    if (PmuInstance.size() > 0) {
        PMU_auto_init("MotionControlDaemon", PmuInstance.c_str(), PROCMAP_REGISTER_INTERVAL);
        ILOG << "will register with procmap, instance: " << PmuInstance;
    }

    // Create the Qt application and our drive connection
    App = new QCoreApplication(argc, argv);
    Control = new MotionControl();

    // Create a periodic timer to apply attitude corrections on a regular basis
    QTimer correctionTimer;
    correctionTimer.setInterval(50);    // 50 ms -> 20 Hz
    QObject::connect(&correctionTimer, SIGNAL(timeout()), Control, SLOT(correctForAttitude()));
    correctionTimer.start();

    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("Home", new DriveHomeMethod);
    myRegistry.addMethod("Point", new DrivePointMethod);
    myRegistry.addMethod("Scan", new DriveScanMethod);
    myRegistry.addMethod("Status", new StatusMethod);
    myRegistry.addMethod("SetCorrectionEnabled", new SetCorrectionEnabledMethod);
    myRegistry.addMethod("HomingInProgress", new HomingInProgressMethod);
    QXmlRpcServerAbyss xmlrpcServer(&myRegistry, ServerPort);

    // Create a QFunctionWrapper around the updatePMURegistration() function,
    // and and create a timer to call it periodically.
    QFunctionWrapper registrationWrapper(&updatePMURegistration);
    QTimer registrationTimer;
    registrationTimer.setInterval(15000);   // 15000 ms -> 15 s
    QObject::connect(&registrationTimer, SIGNAL(timeout()),
            &registrationWrapper, SLOT(callFunction()));
    registrationTimer.start();

    // catch a control-C or kill to shut down cleanly
    signal(SIGINT, shutdownHandler);
    signal(SIGTERM, shutdownHandler);

    // Run the event loop until it's stopped, generally via a "kill" command
    // or ^C
    App->exec();

    // Unregister with procmap
    PMU_auto_unregister();

    delete(Control);
    delete(App);
    return 0;
}
