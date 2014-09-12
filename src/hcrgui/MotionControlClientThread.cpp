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
    MotionControl::Status status = _client->status();
    if (_client->daemonResponding()) {
        if (! _responsive) {
            _responsive = true;
            emit serverResponsive(true);
        }
        emit newStatus(status);
    } else {
        if (_responsive) {
            _responsive = false;
            emit serverResponsive(false);
        }
    }
}
