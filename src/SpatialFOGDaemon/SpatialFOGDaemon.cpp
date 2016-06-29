/*
 * SpatialFOGDaemon.cpp
 *
 *  Created on: Jun 28, 2016
 *      Author: Chris Burghart
 */

#include <SpatialFOGCore.h>
#include <QApplication>
#include <logx/Logging.h>

LOGGING("SpatialFOGDaemon")

int
main(int argc, char * argv[]) {
    // Initialize logx, letting it get and strip out its command line arguments
    logx::ParseLogArgs(argc, argv);

    ILOG << "I'm alive";
}
