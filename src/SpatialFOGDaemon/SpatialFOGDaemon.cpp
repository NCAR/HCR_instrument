/*
 * SpatialFOGDaemon.cpp
 *
 *  Created on: Jun 28, 2016
 *      Author: Chris Burghart
 */

#include <SpatialFOGCore.h>
#include <QApplication>
#include <sys/select.h>
#include <logx/Logging.h>

#include "FDReader.h"

LOGGING("SpatialFOGDaemon")

int
main(int argc, char * argv[]) {
    // Initialize logx, letting it get and strip out its command line arguments
    logx::ParseLogArgs(argc, argv);

    ILOG << "I'm alive";

    // Create a non-GUI QApplication instance
    QApplication app(argc, argv, false);

    // Start a reader thread
    int inFd = 0;     // Read from stdin for now
    FDReader fdr(inFd);
    fdr.start();

    app.exec();
}
