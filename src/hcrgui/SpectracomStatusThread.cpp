/*
 * SpectracomStatusThread.cpp
 *
 *  Created on: June 12, 2015
 *      Author: burghart
 */

#include "SpectracomStatusThread.h"
#include <logx/Logging.h>
#include <QMetaType>
#include <QTimer>

LOGGING("SpectracomStatusThread")

SpectracomStatusThread::SpectracomStatusThread(std::string daemonHost,
        int daemonPort) :
    _responsive(false),
    _daemonHost(daemonHost),
    _daemonPort(daemonPort),
    _client(0) {
    // We need to register SpectracomStatus as a metatype, since we'll be passing
    // it as an argument in a signal.
    qRegisterMetaType<SpectracomStatus>("SpectracomStatus");
    // Set thread affinity to self, so that signals connected to our slot(s)
    // will execute the slots in this thread, and not our parent's.
    moveToThread(this);
}

SpectracomStatusThread::~SpectracomStatusThread() {
    quit();
    // Wait up to a second for thread completion
    if (! wait(1000)) {
        WLOG << "SpectracomStatusThread did not stop. Exiting anyway.";
    }
}

void
SpectracomStatusThread::run() {
    // Instantiate the SpectracomRpcClient
    _client = new SpectracomRpcClient(_daemonHost, _daemonPort);

    // Set up a 1 Hz timer to call _getStatus()
    QTimer timer;
    connect(&timer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    timer.start(1000);
    // Start the event loop
    exec();
    return;
}

void
SpectracomStatusThread::_getStatus() {
    SpectracomStatus status;
    bool gotResponse = _client->getStatus(status);
    if (gotResponse != _responsive) {
        _responsive = gotResponse;
        emit serverResponsive(gotResponse);
    }
    emit newStatus(status);
}
