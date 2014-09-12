/*
 * FireflydStatusThread.cpp
 *
 *  Created on: April 1, 2014
 *      Author: burghart
 */

#include "FireflydStatusThread.h"
#include <logx/Logging.h>
#include <QMetaType>
#include <QTimer>

LOGGING("FireFlyStatusThread")

FireflydStatusThread::FireflydStatusThread(std::string fireflydHost,
        int fireflydPort) :
    _responsive(false),
    _fireflydHost(fireflydHost),
    _fireflydPort(fireflydPort),
    _client(0) {
    // We need to register FireFlyStatus as a metatype, since we'll be passing
    // it as an argument in a signal.
    qRegisterMetaType<FireFlyStatus>("FireFlyStatus");
}

FireflydStatusThread::~FireflydStatusThread() {
    quit();
    // Wait up to a second for thread completion
    if (! wait(1000)) {
        WLOG << "FireFlyStatusThread did not stop. Exiting anyway.";
    }
}

void
FireflydStatusThread::run() {
    // Instantiate the fireflydRpcClient
    _client = new fireflydRpcClient(_fireflydHost, _fireflydPort);

    // Set up a 1 Hz timer to call _getStatus()
    QTimer timer;
    connect(&timer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    timer.start(1000);
    // Start the event loop
    exec();
    return;
}

void
FireflydStatusThread::_getStatus() {
    FireFlyStatus status;
    bool gotResponse = _client->getStatus(status);
    if (gotResponse != _responsive) {
        _responsive = gotResponse;
        emit serverResponsive(gotResponse);
    }
    emit newStatus(status);
}
