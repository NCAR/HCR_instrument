/*
 * cmigitsDaemon.cpp
 *
 *  Created on: Oct 31, 2012
 *      Author: burghart
 */
#include <iostream>
#include <unistd.h>
#include <csignal>
#include <QApplication>
#include <logx/Logging.h>

LOGGING("cmigitsDaemon")

#include "Cmigits.h"
#include "CmigitsSharedMemory.h"

quint16 ServerPort = 8001;

QCoreApplication * App = 0;
bool Interrupted = false;

void
sigHandler(int signal) {
    App->quit();
}


int
main(int argc, char *argv[]) {
    App = new QCoreApplication(argc, argv);

    // Catch interrupt signal to shut us down cleanly on ^C
    signal(SIGINT, sigHandler);
    
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);

    ILOG << "cmigitsDaemon starting";

    if (argc != 2) {
    	std::cerr << "Usage: " << argv[0] << " <tty_dev>" << std::endl;
    	exit(1);
    }
    std::string devName(argv[1]);
    Cmigits cm(devName);

    CmigitsSharedMemory shm(QSharedMemory::ReadWrite);
    // When new status arrives, stuff into shared memory.
    QObject::connect(
            &cm, SIGNAL(newStatusData(uint64_t, uint16_t, bool, bool, uint16_t, uint16_t, uint16_t, uint16_t, float, float, float)),
            &shm, SLOT(setLatestStatus(uint64_t, uint16_t, bool, bool, uint16_t, uint16_t, uint16_t, uint16_t, float, float, float)));
    // When new navigation solution arrives, stuff into shared memory.
    QObject::connect(
            &cm, SIGNAL(new3501Data(uint64_t, float, float, float, float, float, float)),
            &shm, SLOT(setLatestNavSolution(uint64_t, float, float, float, float, float, float)));
    // When new attitude arrives, stuff into shared memory.
    QObject::connect(
            &cm, SIGNAL(new3512Data(uint64_t, float, float, float)),
            &shm, SLOT(setLatestAttitudes(uint64_t, float, float, float)));

    App->exec();
    return 0;
}
