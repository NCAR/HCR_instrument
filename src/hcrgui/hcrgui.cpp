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
    ELOG << "Usage: " << appName <<
            " <xmitd_host>:<xmitd_port> <hcrdrx_host>:<hcrdrx_port>";
    exit(1);
}

int
main(int argc, char *argv[]) {
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);
    
    QApplication* app = new QApplication(argc, argv);
    
    if (argc != 3) {
        usage(argv[0]);
    }

    char xmitdHost[80];
    int xmitdPort;
    char hcrdrxHost[80];
    int hcrdrxPort;
    if (sscanf(argv[1], "%[^:]:%d", xmitdHost, &xmitdPort) != 2) {
        usage(argv[0]);
    }
    if (sscanf(argv[2], "%[^:]:%d", hcrdrxHost, &hcrdrxPort) != 2) {
        usage(argv[0]);
    }

    QMainWindow* mainWindow = new HcrGuiMainWindow(xmitdHost, xmitdPort,
            hcrdrxHost, hcrdrxPort);
    mainWindow->show();
    
    return app->exec();
}
