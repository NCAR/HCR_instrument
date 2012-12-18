/*
 * cmigitsDaemon.cpp
 *
 *  Created on: Oct 31, 2012
 *      Author: burghart
 */
#include <iostream>
#include <unistd.h>
#include <QApplication>
#include <logx/Logging.h>

LOGGING("cmigitsDaemon")

#include "Cmigits.h"

quint16 ServerPort = 8001;

int
main(int argc, char *argv[]) {
    QCoreApplication app(argc, argv);
    
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);

    ILOG << "cmigitsDaemon starting";

    if (argc != 2) {
    	std::cerr << "Usage: " << argv[0] << " <tty_dev>" << std::endl;
    	exit(1);
    }
    std::string devName(argv[1]);
    Cmigits cm(devName);

    app.exec();
    return 0;
}
