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
// hcrdrx host and port.
const char * DefaultXmitdHostAndPort = "archiver:8000";
const char * DefaultHcrdrxHostAndPort = "rds:8081";
const int DefaultCmigitsPort = 8002;
const int DefaultMotionControlPort = 8080;

void
usage(const char* appName) {
    ELOG << "Usage: " << appName <<
            " [<xmitd_host>:<xmitd_port> <hcrdrx_host>:<hcrdrx_port>]";
    exit(1);
}

int
main(int argc, char *argv[]) {
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);
    
    QApplication* app = new QApplication(argc, argv);
    
    if (argc != 3 && argc != 1) {
        usage(argv[0]);
    }
    // Start with default host/port values, but replace these with argv[1] and
    // argv[2] if they are given.
    const char * xmitdHostAndPort = DefaultXmitdHostAndPort;
    const char * hcrdrxHostAndPort = DefaultHcrdrxHostAndPort;
    if (argc == 3) {
        xmitdHostAndPort = argv[1];
        hcrdrxHostAndPort = argv[2];
    }

    char xmitdHost[80];
    int xmitdPort;
    char rdsHost[80];
    int hcrdrxPort;
    int cmigitsPort = DefaultCmigitsPort;
    int motionControlPort = DefaultMotionControlPort;
    if (sscanf(xmitdHostAndPort, "%[^:]:%d", xmitdHost, &xmitdPort) != 2) {
        usage(argv[0]);
    }
    if (sscanf(hcrdrxHostAndPort, "%[^:]:%d", rdsHost, &hcrdrxPort) != 2) {
        usage(argv[0]);
    }

    QMainWindow* mainWindow = new HcrGuiMainWindow(xmitdHost, xmitdPort,
            rdsHost, hcrdrxPort, cmigitsPort, motionControlPort);
    mainWindow->show();
    
    return app->exec();
}
