/*
 * MotionControlStatusThread.cpp
 *
 *  Created on: Oct 22, 2014
 *      Author: burghart
 */

#include "MotionControlStatusThread.h"
#include <QMetaType>
#include <QTimer>
#include <logx/Logging.h>

LOGGING("MotionControlStatusThread")

MotionControlStatusThread::MotionControlStatusThread(std::string mcdHost, 
        int mcdPort) :
    _responsive(false),
    _mcdHost(mcdHost),
    _mcdPort(mcdPort),
    _client(0) {
    // We need to register MotionControl::Status as a metatype, since we'll be 
    // passing it as an argument in a signal.
    qRegisterMetaType<MotionControl::Status>("MotionControl::Status");
    // Set thread affinity to self, so that signals connected to our slot(s)
    // will execute the slots in this thread, and not our parent's.
    moveToThread(this);
}

MotionControlStatusThread::~MotionControlStatusThread() {
}

void
MotionControlStatusThread::run() {
    // Instantiate the MotionControlRpcClient
    _client = new MotionControlRpcClient(_mcdHost, _mcdPort);
    // Set up a 1 s timer to call _getStatus()
    QTimer timer;
    connect(&timer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    timer.start(1000);
    // Start the event loop
    exec();
    return;
}

void
MotionControlStatusThread::_getStatus() {
    try {
        MotionControl::Status status = _client->status();
        // We got a response, so emit serverResponsive(true) if the server was
        // not previously responding.
        if (! _responsive) {
            _responsive = true;
            emit serverResponsive(true, QString("MotionControlDaemon is responding"));
        }
        // Emit the new status.
        emit newStatus(status);
    } catch (std::exception & e) {
        // As a rule, exceptions just mean the server is not responding. Emit
        // serverResponsive(false) if the server had previously been responding.
        if (_responsive) {
            std::ostringstream oss;
            oss << "MotionControlDaemon failed to respond to getStatus(): " << e.what();
            _responsive = false;
            emit serverResponsive(false, QString(oss.str().c_str()));
        }
    }
}
