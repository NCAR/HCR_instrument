/*
 * SpatialFogDaemon.cpp
 *
 *  Created on: Jun 28, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#include <csignal>
#include <cstring>
#include <string>
#include <QFunctionWrapper.h>
#include <logx/Logging.h>

#include <QApplication>
#include <QTimer>

#include "HcrSpatialFog.h"

LOGGING("SpatialFogDaemon")

// QApplication instance
QApplication * App;

void
usage() {
    std::cerr << "Usage: SpatialFogDaemon [(logx_argument)...] <tty_dev>" <<
            std::endl;
    logx::LogUsage(std::cerr);
}

void stopApp(int sig) {
    if (App) {
        ILOG << "Stopping app; received '" << strsignal(sig) << "' signal";
        App->quit();
    }
}

int
main(int argc, char * argv[]) {
    // Initialize logx, letting it get and strip out its command line arguments
    logx::ParseLogArgs(argc, argv);
    ILOG << "======================";
    ILOG << "SpatialFogDaemon start";

    // Set up to exit on INT or TERM signals sent to the process
    signal(SIGINT, stopApp);
    signal(SIGTERM, stopApp);

    // Create a non-GUI QApplication instance
    App = new QApplication(argc, argv, false);

    // We should have one remaining argument after the program name: the device
    // port to which the Spatial FOG is attached
    if (argc != 2) {
        usage();
        exit(1);
    }

    std::string devName(argv[1]);

    // Create an HcrSpatialFog instance, which will open and read the given
    // device and publish data from the device on a shared memory file message
    // queue (FMQ).
    HcrSpatialFog * spatialFog = new HcrSpatialFog(devName);

    // Start the app
    App->exec();

    delete(spatialFog);
    delete(App);
    
    ILOG << "SpatialFogDaemon exit";
    ILOG << "======================";
}
