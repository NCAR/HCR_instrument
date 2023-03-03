// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2016                                         
// ** University Corporation for Atmospheric Research (UCAR)                 
// ** National Center for Atmospheric Research (NCAR)                        
// ** Boulder, Colorado, USA                                                 
// ** BSD licence applies - redistribution and use in source and binary      
// ** forms, with or without modification, are permitted provided that       
// ** the following conditions are met:                                      
// ** 1) If the software is modified to produce derivative works,            
// ** such modified software should be clearly marked, so as not             
// ** to confuse it with the version available from UCAR.                    
// ** 2) Redistributions of source code must retain the above copyright      
// ** notice, this list of conditions and the following disclaimer.          
// ** 3) Redistributions in binary form must reproduce the above copyright   
// ** notice, this list of conditions and the following disclaimer in the    
// ** documentation and/or other materials provided with the distribution.   
// ** 4) Neither the name of UCAR nor the names of its contributors,         
// ** if any, may be used to endorse or promote products derived from        
// ** this software without specific prior written permission.               
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS  
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED      
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.    
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
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
#include <boost/program_options.hpp>
#include <toolsa/pmu.h>
#include <logx/Logging.h>

#include <xmlrpc-c/registry.hpp>
#include <QFunctionWrapper.h>
#include <QXmlRpcServerAbyss.h>

#include "MotionControl.h"
#include "../HcrSharedResources.h"

namespace po = boost::program_options;

LOGGING("MotionControlDaemon")

// QApplication instance
QCoreApplication * App = 0;

// MotionControl instance
MotionControl * Control = 0;

// PMU application instance name
std::string PmuInstance = "ops";   ///< application instance

// Description of command line options
po::options_description OptionsDesc("Options");

// Rotation *beam* angle correction in degrees, which can be set on the command
// line, is used to set the home count value for the rotation drive. If beam is
// commanded to point nadir (straight down, or desired true rotation angle 180
// degrees) and the beam actually points left of the aircraft, then set this
// angle more negative. If the beam actually points right of the aircraft, set
// it more positive.
float RotBeamAngleCorrection = 0.0;

// Tilt *beam* angle correction in degrees, which can be set on the command
// line, is used to set the home count value for the tilt drive. If beam is
// commanded to point nadir (straight down, rotation angle 180 degrees) and the
// beam actually points forward of the aircraft, then set this angle more
// negative. If the beam actually points aft of the aircraft, set it more
// positive.
float TiltBeamAngleCorrection = 0.0;

bool DoNothing = false;

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

        // Calculate the home position count for the rotation drive from the
        // beam angle correction.
        int rotDriveHomeCounts = int(-RotBeamAngleCorrection / 360.0 *
            RotServoDrive::COUNTS_PER_CIRCLE);
        ILOG << "Rotation drive home counts: " << rotDriveHomeCounts;
        // Calculate the home position count for the tilt drive from the
        // beam angle correction. NOTE: For tilt, there's an extra factor of
        // 0.5 applied because of reflection, i.e., delta(reflectorAngle) =
        // 0.5 * delta(beamAngle).
        int tiltDriveHomeCounts = int((TiltBeamAngleCorrection * 0.5) / 360.0 *
            TiltServoDrive::COUNTS_PER_CIRCLE);
        ILOG << "Tilt drive home counts: " << tiltDriveHomeCounts;

        // Home the drives and set the appropriate count values for
        // their home positions.
        if(Control) Control->homeDrive(rotDriveHomeCounts, tiltDriveHomeCounts);

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

        if(Control) Control->point(angle);

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
            if(Control) Control->scan(ccwLimit, cwLimit, scanRate, beamTilt);
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
        this->_help = "This method returns MotionControlDaemon status";
    }

    void
    execute(xmlrpc_c::paramList const& paramList, xmlrpc_c::value* const retvalP)
    {
        paramList.verifyEnd(0);

        if(Control) {
            // Return current status of our MotionControl an xmlrpc_c::value which
            // can be used to construct MotionControl::Status again on the other
            // side.            
            *retvalP = Control->status().toXmlRpcValue();
        }
        else {
            // Return empty status
            MotionControl::Status s;
            *retvalP = s.toXmlRpcValue();
        }
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

        if(Control) Control->setCorrectionEnabled(enabled);

        *retvalP = xmlrpc_c::value_int(0);
    }
};

/////////////////////////////////////////////////////////////////////
class SetInsInUseMethod : public xmlrpc_c::method
{
public:
    SetInsInUseMethod() {
        // The method takes an integer argument (1 or 2), and returns 0 on
        // success
        this->_signature = "i:i";
        this->_help = "This method sets the INS in use for attitude correction";
    }

    void
    execute(xmlrpc_c::paramList const& paramList, xmlrpc_c::value* const retvalP)
    {
        int const newInsInUse(paramList.getInt(0));
        paramList.verifyEnd(1);

        if(Control) Control->setInsInUse(newInsInUse);

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
        if(Control) {
            *retvalP = xmlrpc_c::value_boolean(Control->homingInProgress());
        }
        else {
            *retvalP = xmlrpc_c::value_boolean(false);
        }
    }
};

/////////////////////////////////////////////////////////////////////
void
updatePMURegistration() {
    // Make sure we remain registered with PMU, so it knows we're alive
    PMU_auto_register("running");
}

/// Print usage information
void
usage(const char* argv0) {
    std::cerr << "Usage: " << argv0 << 
            " [option]" << std::endl;
    std::cerr << OptionsDesc << std::endl;
    logx::LogUsage(std::cerr);
}

/// Parse the command line options, removing the successfully parsed bits from
/// argc/argv.
void
parseOptions(int & argc, char** argv)
{
    // Description for our command line options
    OptionsDesc.add_options()
            ("help", "Describe options")
            ("rotBeamAngleCorrection", 
                po::value<float>(&RotBeamAngleCorrection),
                "Rotation beam angle correction, degrees")
            ("tiltBeamAngleCorrection",
                po::value<float>(&TiltBeamAngleCorrection), 
                "Tilt beam angle correction, degrees")
            ("doNothing",
                "respond to status requests but take no further action")                
            ;

    po::variables_map vm;
    po::command_line_parser parser(argc, argv);
    parser.options(OptionsDesc);
    try {
        po::parsed_options parsedOpts = parser.run();
        po::store(parsedOpts, vm);
        po::notify(vm);
        DoNothing = vm.count("doNothing");
    } catch (std::exception & ex) {
        usage(argv[0]);
        exit(1);
    }
    
    if (vm.count("help")) {
        usage(argv[0]);
        exit(0);
    }
}

/////////////////////////////////////////////////////////////////////
int
main(int argc, char** argv)
{
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);

    ILOG << "MotionControlDaemon start: " << 
        QDateTime::currentDateTimeUtc().toString("yyyyMMdd hh:mm:ss.zzz").toStdString();

    // Get our local options
    parseOptions(argc, argv);

    // Log the angle correction values
    ILOG << "Rotation beam angle correction: " << RotBeamAngleCorrection <<
        " deg";
    ILOG << "Tilt beam angle correction: " << TiltBeamAngleCorrection <<
        " deg";

    // set up registration with procmap
    if (PmuInstance.size() > 0) {
        PMU_auto_init("MotionControlDaemon", PmuInstance.c_str(), PROCMAP_REGISTER_INTERVAL);
        ILOG << "will register with procmap, instance: " << PmuInstance;
    }

    // Create the Qt application and our drive connection
    App = new QCoreApplication(argc, argv);

    QTimer correctionTimer;
    if (!DoNothing) {
        Control = new MotionControl();

        // Set up correctionTimer to apply attitude corrections on a regular basis
        correctionTimer.setInterval(50);    // 50 ms -> 20 Hz
        QObject::connect(&correctionTimer, SIGNAL(timeout()), Control, SLOT(correctForAttitude()));
        correctionTimer.start();
    }

    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("Home", new DriveHomeMethod);
    myRegistry.addMethod("Point", new DrivePointMethod);
    myRegistry.addMethod("Scan", new DriveScanMethod);
    myRegistry.addMethod("Status", new StatusMethod);
    myRegistry.addMethod("SetCorrectionEnabled", new SetCorrectionEnabledMethod);
    myRegistry.addMethod("SetInsInUse", new SetInsInUseMethod);
    myRegistry.addMethod("HomingInProgress", new HomingInProgressMethod);
    QXmlRpcServerAbyss xmlrpcServer(&myRegistry, MOTIONCONTROLDAEMON_PORT);

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
