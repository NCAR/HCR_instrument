/*
 * hcrgui.cpp
 *
 *  Created on: Jan 6, 2011
 *      Author: burghart
 */
 
#include <cstdlib>
#include <cstdio>
#include <QApplication>

#include <logx/Logging.h>

#include "HcrGuiMainWindow.h"

LOGGING("hcrgui")

// Default to archiver:8000 for xmitd host and port, and rds:8081 for the
// HcrPmc730Daemon host and port.
const char * DefaultXmitdHostAndPort = "archiver:8000";
const char * DefaultPmc730HostAndPort = "rds:8003";
const int DefaultCmigitsPort = 8002;
const int DefaultMotionControlPort = 8080;

void
usage(const char* appName) {
    ELOG << "Usage: " << appName <<
            " [<xmitd_host>:<xmitd_port> <pmc730_host>:<pmc730_port>]";
    exit(1);
}

int
main(int argc, char *argv[]) {
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);
    ILOG << "hcrgui started";
    
    QApplication* app = new QApplication(argc, argv);
    
    if (argc != 3 && argc != 1) {
        usage(argv[0]);
    }
    // Start with default host/port values, but replace these with argv[1] and
    // argv[2] if they are given.
    const char * xmitdHostAndPort = DefaultXmitdHostAndPort;
    const char * pmc730HostAndPort = DefaultPmc730HostAndPort;
    if (argc == 3) {
        xmitdHostAndPort = argv[1];
        pmc730HostAndPort = argv[2];
    }

    char xmitdHost[80];
    int xmitdPort;
    char rdsHost[80];
    int pmc730Port;
    int cmigitsPort = DefaultCmigitsPort;
    int motionControlPort = DefaultMotionControlPort;
    if (sscanf(xmitdHostAndPort, "%[^:]:%d", xmitdHost, &xmitdPort) != 2) {
        usage(argv[0]);
    }
    if (sscanf(pmc730HostAndPort, "%[^:]:%d", rdsHost, &pmc730Port) != 2) {
        usage(argv[0]);
    }

    QMainWindow* mainWindow = new HcrGuiMainWindow(xmitdHost, xmitdPort,
            rdsHost, pmc730Port, cmigitsPort, motionControlPort);
    mainWindow->show();
    
    int retval = app->exec();
    ILOG << "hcrgui stopped";
    return(retval);
}
