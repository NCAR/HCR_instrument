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
#include <logx/Logging.h>

#include <xmlrpc-c/base.hpp>
#include <xmlrpc-c/registry.hpp>
#include <xmlrpc-c/server_abyss.hpp>

#include "DriveConnection.h"
#include "DriveStatus.h"

LOGGING("MotionControlDaemon")

quint16 ServerPort = 8080;

// QApplication instance
QApplication * App = 0;

// DriveConnection instance
DriveConnection * DriveConn = 0;

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
//    const struct timeval tv = { 0, 50000 }; // 0.05s (20Hz)
    const struct timeval tv = { 0, 10000 }; // 0.01s (100Hz)
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
class DrivePointMethod : public xmlrpc_c::method
{
public:
	DrivePointMethod() {
		// The method result and arguments are all integers
		this->_signature = "i:i";
		this->_help = "This method takes drive point angle from client";
	}

	void
	execute(xmlrpc_c::paramList const& paramList, xmlrpc_c::value* const retvalP)
	{
        // Stop the work alarm while we're working.
        stopXmlrpcWorkAlarm();

		int const angle(paramList.getInt(0));
		paramList.verifyEnd(1);

		DriveConn->point((double)angle);

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
		// The method result and arguments are all integers
		this->_signature = "i:ii";
		this->_help = "This method takes drive scan angle range from client";
	}

	void
	execute(xmlrpc_c::paramList const& paramList, xmlrpc_c::value* const retvalP)
	{
        // Stop the work alarm while we're working.
        stopXmlrpcWorkAlarm();

		int const angleA(paramList.getInt(0));
		int const angleB(paramList.getInt(1));
		paramList.verifyEnd(2);

		qDebug() << "Scan from" << angleA << "to" << angleB;

		*retvalP = xmlrpc_c::value_int(0);

        // Restart the work alarm.
        startXmlrpcWorkAlarm();
	}
};

/////////////////////////////////////////////////////////////////////
class DriveStatusMethod : public xmlrpc_c::method
{
public:
	DriveStatusMethod() {
		// The method result and arguments are all integers
		this->_signature = "S:";	// we return a struct
		this->_help = "This method returns servo drive status";
	}

	void
	execute(xmlrpc_c::paramList const& paramList, xmlrpc_c::value* const retvalP)
	{
        // Stop the work alarm while we're working.
        stopXmlrpcWorkAlarm();

		paramList.verifyEnd(0);

		DriveStatus status(DriveConn->rotationDrive(), DriveConn->tiltDrive());
		xmlrpc_c::value_struct dict = status.to_value_struct();
		*retvalP = dict;

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

	// Create the Qt application and our drive connection
	App = new QApplication(argc, argv);
	DriveConn = new DriveConnection();

    xmlrpc_c::registry myRegistry;
    myRegistry.addMethod("Point", new DrivePointMethod);
    myRegistry.addMethod("Scan", new DriveScanMethod);
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
    	if (Terminate)
    		break;

	    // Waits for the next connection, accepts it, reads the HTTP
	   	// request, executes the indicated RPC, and closes the connection.
	   	xmlrpcServer.runOnce();

	   	// update aircraft attitude
	   	DriveConn->updateAttitude();

        // Process Qt events
        App->processEvents();
    }

    delete(DriveConn);
    delete(App);
	return 0;
}
