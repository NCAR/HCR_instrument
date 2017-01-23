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

#include <toolsa/pmu.h>
#include <logx/Logging.h>
#include <HcrPmc730.h>
#include <HcrPmc730Status.h>
#include <QCoreApplication>
#include <QTimer>
#include <QUdpSocket>
#include <QFunctionWrapper.h>

#include <xmlrpc-c/registry.hpp>
#include <QXmlRpcServerAbyss.h>

#include "HmcModeChange.h"
#include "../HcrSharedResources.h"

LOGGING("HcrPmc730Daemon")


/// Our Qt application
QCoreApplication *App = 0;

/// UDP socket on which we broadcast HMC operation mode changes.
QUdpSocket HmcModeBroadcastSocket;

/// Transmitter "HV on" requires a heartbeat signal. Time out if a new request
/// does not come in MAXIMUM_HVON_HEARTBEAT_INTERVAL_MS milliseconds. 
/// NOTE: MAXIMUM_HVON_HEARTBEAT_INTERVAL_MS needs to be greater than about
/// a second, due to latency in XML-RPC server request handling.
QTimer * HvOnHeartbeatTimer;
static const int MAXIMUM_HVON_HEARTBEAT_INTERVAL_MS = 1000;

void
hvOnHeartbeatTimeout() {
    WLOG << "'HV on' heartbeat timed out after " << 
            MAXIMUM_HVON_HEARTBEAT_INTERVAL_MS << " ms. Turning off HV.";
    HcrPmc730::setXmitterHvOn(false);
}

/// Application instance name, for procmap
std::string _instance = "ops";

// Handler for SIGINT and SIGTERM signals.
void
exitHandler(int signal) {
    ILOG << "Exiting on signal " << signal;
    App->quit();
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
        ILOG << "Executing XML-RPC call to xmitFilamentOn()";
        HcrPmc730::setXmitterFilamentOn(true);
        *retvalP = xmlrpc_c::value_nil();
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
        ILOG << "Executing XML-RPC call to xmitFilamentOff()";
        HcrPmc730::setXmitterFilamentOn(false);
        *retvalP = xmlrpc_c::value_nil();
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
        *retvalP = xmlrpc_c::value_nil();
        // Send the call to turn on HV if it isn't already on
        if (! HcrPmc730::xmitterHvOn()) {
            ILOG << "Executing XML-RPC call to xmitHvOn()";
            HcrPmc730::setXmitterHvOn(true);
        }
        /// Start or restart the "HV on" heartbeat timer
        DLOG << "Heartbeat seen";
        HvOnHeartbeatTimer->start();
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
        ILOG << "Executing XML-RPC call to xmitHvOff()";
        HcrPmc730::setXmitterHvOn(false);
        *retvalP = xmlrpc_c::value_nil();
        /// Stop the "HV on" heartbeat timer
        HvOnHeartbeatTimer->stop();
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
        // We get a single parameter: the integer form of the desired HMC
        // mode.
        ILOG << "Received XML-RPC call to setHmcMode()...";
        int iMode = paramList.getInt(0);
        paramList.verifyEnd(1);
        
        // Cast the int into HcrPmc730::HmcOperationMode
        HcrPmc730::HmcOperationMode hmcMode = 
                static_cast<HcrPmc730::HmcOperationMode>(iMode);
        ILOG << "...with requested HMC mode " << 
                "'" << HcrPmc730::HmcModeNames[hmcMode] << "'";
        *retvalP = xmlrpc_c::value_nil();
        
        // If requested mode is the current mode, just return now
        if (hmcMode == HcrPmc730::hmcMode()) {
            DLOG << "Requested HMC mode is same as current mode; returning now.";
            return;
        }
        
        // Change to the requested mode
        HcrPmc730::setHmcOperationMode(hmcMode);
        
        // Broadcast a datagram to indicate the new mode and the time of the
        // mode change (double precision seconds since 1970-01-01 00:00:00 UTC)
        struct timeval nowTimeval;
        gettimeofday(&nowTimeval, NULL);
        double modeChangeTime = 
                nowTimeval.tv_sec + 1.0e-6 * nowTimeval.tv_usec; // seconds since epoch
        HmcModeChangeStruct changeStruct = { hmcMode, modeChangeTime };
        int result = HmcModeBroadcastSocket.writeDatagram(
                reinterpret_cast<char*>(&changeStruct), 
                sizeof(changeStruct), QHostAddress::Broadcast, 
                HMC_MODE_BROADCAST_PORT);
        if (result == -1) {
            ELOG << "HMC mode change UDP write gave QAbstractSocket::SocketError " << 
                    HmcModeBroadcastSocket.error();
        }
    }
};

/// XML-RPC method to get current monitored values from the PMC-730. The
/// returned xmlrpc_c::value_struct can be used to construct an HcrPmc730Status
/// object.
class GetStatusMethod : public xmlrpc_c::method {
public:
    GetStatusMethod() {
        // Method takes no arguments, and returns an xmlrpc_c::value_struct
        // which can be used to construct an HcrPmc730Status object.
        this->_signature = "s:";
        this->_help = "This method returns current monitored values from the PMC-730.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        DLOG << "Executing XML-RPC call to getStatus()";
        paramList.verifyEnd(0);
        *retvalP = HcrPmc730Status().toXmlRpcValue();
    }
};

// XML-RPC method to open the Active Pressurization System (APS) valve.
class OpenApsValveMethod : public xmlrpc_c::method {
public:
    OpenApsValveMethod() {
        // Method takes no arguments, returns nil
        this->_signature = "n:";
        this->_help = "This method opens the Active Pressurization System valve.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        ILOG << "Executing XML-RPC call to openApsValve()";
        HcrPmc730::setApsValveOpen(true);
        *retvalP = xmlrpc_c::value_nil();
    }
};

// XML-RPC method to close the Active Pressurization System (APS) valve.
class CloseApsValveMethod : public xmlrpc_c::method {
public:
    CloseApsValveMethod() {
        // Method takes no arguments, returns nil
        this->_signature = "n:";
        this->_help = "This method closes the Active Pressurization System valve.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        ILOG << "Executing XML-RPC call to closeApsValve()";
        HcrPmc730::setApsValveOpen(false);
        *retvalP = xmlrpc_c::value_nil();
    }
};

void
updatePMURegistration() {
    // Make sure we remain registered with PMU, so it knows we're alive
    PMU_auto_register("running");
}

int
main(int argc, char * argv[]) {
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);
    ILOG << "HcrPmc730Daemon started";

    App = new QCoreApplication(argc, argv);
    App->setApplicationName("HcrPmc730Daemon");
    
    // Instantiate and configure our heartbeat timer for "HV on" requests.
    // The timer is started/restarted every time "HV on" is requested, and
    // stopped on any "HV off" request.
    HvOnHeartbeatTimer = new QTimer();
    HvOnHeartbeatTimer->setInterval(MAXIMUM_HVON_HEARTBEAT_INTERVAL_MS);
    HvOnHeartbeatTimer->setSingleShot(true);
    QFunctionWrapper heartbeatTimeoutWrapper(hvOnHeartbeatTimeout);
    QObject::connect(HvOnHeartbeatTimer, SIGNAL(timeout()), 
            &heartbeatTimeoutWrapper, SLOT(callFunction()));
    
    
    // Check for --simulate in the arg list
    bool simulate = false;
    if (argc > 2) {
        ELOG << "Bad arg(s). Only '--simulate' is allowed.";
        exit(1);
    } else if (argc == 2) {
        if (! strcmp(argv[1], "--simulate")) {
            simulate = true;
        } else {
            ELOG << "Bad arg. Only '--simulate' is allowed.";
            exit(1);
        }
    }

    // Make sure the HcrPmc730 gets instantiated in simulation mode if requested
    HcrPmc730::doSimulate(simulate);

    // Just refer to theHcrPmc730() to instantiate the singleton.
    HcrPmc730::theHcrPmc730();

    // Initialize output lines: Active Pressurization System valve closed,
    // transmitter filament off, transmitter HV off, HMC in
    // "txV rxHV (attenuated)" mode.
    HcrPmc730::setApsValveOpen(false);
    HcrPmc730::setXmitterFilamentOn(false);
    HcrPmc730::setXmitterHvOn(false);
    HcrPmc730::setHmcOperationMode(HcrPmc730::HMC_MODE_V_HV_ATTENUATED);

    // Create our XML-RPC method registry and server instance
    PMU_auto_register("instantiating XML-RPC server");
    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("xmitFilamentOn", new XmitFilamentOnMethod);
    myRegistry.addMethod("xmitFilamentOff", new XmitFilamentOffMethod);
    myRegistry.addMethod("xmitHvOn", new XmitHvOnMethod);
    myRegistry.addMethod("xmitHvOff", new XmitHvOffMethod);
    myRegistry.addMethod("setHmcMode", new SetHmcModeMethod);
    myRegistry.addMethod("getStatus", new GetStatusMethod);
    myRegistry.addMethod("openApsValve", new OpenApsValveMethod);
    myRegistry.addMethod("closeApsValve", new CloseApsValveMethod);
    QXmlRpcServerAbyss xmlrpcServer(&myRegistry, HCRPMC730DAEMON_PORT);

    // Catch SIGINT and SIGTERM to arrange for clean shutdown
    signal(SIGINT, exitHandler);
    signal(SIGTERM, exitHandler);

    // Initialize registration with procmap, and set up a periodic timer to
    // send a registration on a regular basis.
    PMU_auto_init("HcrPmc730Daemon", _instance.c_str(), PROCMAP_REGISTER_INTERVAL);
    ILOG << "HcrPmc730Daemon will register with procmap as instance: " << _instance;

    QFunctionWrapper registrationWrapper(updatePMURegistration);
    QTimer registrationTimer;
    registrationTimer.setInterval(10000);   // 10000 ms -> 10 s
    QObject::connect(&registrationTimer, SIGNAL(timeout()),
            &registrationWrapper, SLOT(callFunction()));
    registrationTimer.start();

    // Start the app, which also starts our XML-RPC server. The app runs until
    // stopped via INT or TERM signal caught by our exitHandler(), or an 
    // exception is raised.
    try {
        App->exec();
    } catch (std::exception & e) {
        ELOG << "Exiting on exception: " << e.what();
    } catch (...) {
        ELOG << "Exiting on unknown exception";
    }

    // Explicitly set things to a safe state when we exit
    HcrPmc730::setXmitterHvOn(false);
    HcrPmc730::setXmitterFilamentOn(false);
    HcrPmc730::setApsValveOpen(false);
   
    delete(App);
    PMU_auto_unregister();
    
    ILOG << "HcrPmc730Daemon stopped";

    return 0;
}
