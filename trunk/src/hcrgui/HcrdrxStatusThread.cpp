/*
 * HcrdrxStatusThread.cpp
 *
 *  Created on: Sep 10, 2012
 *      Author: hcr
 */

#include "HcrdrxStatusThread.h"
#include <QMetaType>
#include <QTimer>

HcrdrxStatusThread::HcrdrxStatusThread(std::string drxHost, int drxPort) :
    _responsive(false),
    _drxHost(drxHost),
    _drxPort(drxPort),
    _client(0) {
    // We need to register DrxStatus as a metatype, since we'll be passing it
    // as an argument in a signal.
    qRegisterMetaType<DrxStatus>("DrxStatus");
    // Change thread affinity to self instead of our parent's thread.
    // This makes the calls to _getStatus() execute in *this* thread, which is
    // what we want.
    moveToThread(this);
}

HcrdrxStatusThread::~HcrdrxStatusThread() {
}

void
HcrdrxStatusThread::run() {
    // Instantiate the HcrdrxRpcClient
    _client = new HcrdrxRpcClient(_drxHost, _drxPort);
    // Set up a 1 s timer to call _getStatus()
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
