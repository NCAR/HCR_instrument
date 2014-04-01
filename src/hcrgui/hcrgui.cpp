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

void
usage(const char* appName) {
    ELOG << "Usage: " << appName;
    exit(1);
}

int
main(int argc, char *argv[]) {
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);
    ILOG << "hcrgui started";
    
    QApplication* app = new QApplication(argc, argv);
    
    if (argc != 1) {
        usage(argv[0]);
    }

    // Hosts and ports for the daemons we'll be talking to
    char archiverHost[] = "archiver";
    int xmitdPort = 8000;
    int fireflydPort = 8001;

    char rdsHost[] = "rds";
    int cmigitsPort = 8002;
    int pmc730Port = 8003;
    int motionControlPort = 8080;
    int hcrdrxPort = 8081;

    QMainWindow* mainWindow = new HcrGuiMainWindow(archiverHost, xmitdPort,
            fireflydPort, rdsHost, hcrdrxPort, pmc730Port, cmigitsPort,
            motionControlPort);
    mainWindow->show();
    
    int retval = app->exec();
    ILOG << "hcrgui stopped";
    return(retval);
}
