/*
 * HcrdrxStatusThread.cpp
 *
 *  Created on: Sep 10, 2012
 *      Author: hcr
 */

#include "HcrdrxStatusThread.h"
#include <logx/Logging.h>
#include <QMetaType>
#include <QTimer>

LOGGING("HcrdrxStatusThread")

HcrdrxStatusThread::HcrdrxStatusThread(std::string drxHost, int drxPort) :
    _responsive(false),
    _drxHost(drxHost),
    _drxPort(drxPort),
    _client(0) {
    // We need to register DrxStatus as a metatype, since we'll be passing it
    // as an argument in a signal.
    qRegisterMetaType<DrxStatus>("DrxStatus");
    // Set thread affinity to self, so that signals connected to our slot(s)
    // will execute the slots in this thread, and not our parent's.
    moveToThread(this);
}

HcrdrxStatusThread::~HcrdrxStatusThread() {
    quit();
    // Wait up to a second for thread completion
    if (! wait(1000)) {
        WLOG << "HcrdrxStatusThread did not stop. Exiting anyway.";
    }
}

void
HcrdrxStatusThread::run() {
    // Instantiate the HcrdrxRpcClient
    _client = new HcrdrxRpcClient(_drxHost, _drxPort);
    // Set up a 1 Hz timer to call _getStatus()
    QTimer timer;
    connect(&timer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    timer.start(1000);
    // Start the event loop
    exec();
    return;
}

void
HcrdrxStatusThread::_getStatus() {
    DrxStatus status;
    bool gotResponse = _client->getStatus(status);
    if (gotResponse != _responsive) {
        _responsive = gotResponse;
        emit serverResponsive(gotResponse);
    }
    emit newStatus(status);
}
