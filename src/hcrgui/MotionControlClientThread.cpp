/*
 * MotionControlClientThread.cpp
 *
 *  Created on: Sep 10, 2012
 *      Author: hcr
 */

#include "MotionControlClientThread.h"
#include <QMetaType>
#include <QTimer>

MotionControlClientThread::MotionControlClientThread(std::string mcHost, int mcPort) :
    _responsive(false),
    _mcHost(mcHost),
    _mcPort(mcPort),
    _client(0) {
    // We need to register MotionControl::Status as a metatype, since we'll be passing it
    // as an argument in a signal.
    qRegisterMetaType<MotionControl::Status>("MotionControl::Status");
    // Set thread affinity to self, so that signals connected to our slot(s)
    // will execute the slots in this thread, and not our parent's.
    moveToThread(this);
}

MotionControlClientThread::~MotionControlClientThread() {
}

void
MotionControlClientThread::run() {
    _client = new MotionControlRpcClient(_mcHost, _mcPort);
    // Set up a 1 s timer to call _getStatus()
    QTimer timer;
    connect(&timer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    timer.start(1000);
    // Start the event loop
    exec();
    return;
}

void
MotionControlClientThread::_getStatus() {
    // If we can get status, emit a newStatus() signal
    try {
        MotionControl::Status status = _client->status();
        emit newStatus(status);
    } catch (std::exception & e) {
        // do nothing
    }
    
    // If daemon responsiveness has changed, emit a new serverResponsive()
    // signal.
    bool daemonResponding = _client->daemonResponding();
    if (daemonResponding != _responsive) {
        _responsive = daemonResponding;
        emit serverResponsive(_responsive);
    }
}
