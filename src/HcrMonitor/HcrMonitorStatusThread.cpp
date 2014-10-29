/*
 * HcrMonitorStatusThread.cpp
 *
 *  Created on: Oct 28, 2014
 *      Author: burghart
 */

#include "HcrMonitorStatusThread.h"
#include <QMetaType>
#include <QTimer>
#include <logx/Logging.h>

LOGGING("HcrMonitorStatusThread")

HcrMonitorStatusThread::HcrMonitorStatusThread(std::string daemonHost, 
        int daemonPort) :
    _responsive(false),
    _daemonHost(daemonHost),
    _daemonPort(daemonPort),
    _client(0) {
    // We need to register HcrMonitorStatus as a metatype, since we'll be 
    // passing it as an argument in a signal.
    qRegisterMetaType<HcrMonitorStatus>("HcrMonitorStatus");
    // Set thread affinity to self, so that signals connected to our slot(s)
    // will execute the slots in this thread, and not our parent's.
    moveToThread(this);
}

HcrMonitorStatusThread::~HcrMonitorStatusThread() {
}

void
HcrMonitorStatusThread::run() {
    // Instantiate the HcrMonitorRpcClient
    _client = new HcrMonitorRpcClient(_daemonHost, _daemonPort);
    // Set up a 1 s timer to call _getStatus()
    QTimer timer;
    connect(&timer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    timer.start(1000);
    // Start the event loop
    exec();
    return;
}

void
HcrMonitorStatusThread::_getStatus() {
    try {
        HcrMonitorStatus status = _client->status();
        // We got a response, so emit serverResponsive(true) if the server was
        // not previously responding.
        if (! _responsive) {
            std::ostringstream oss;
            _responsive = true;
            std::string msg = "HcrMonitor is responding";
            ILOG << msg;
            emit serverResponsive(true, QString(msg.c_str()));
        }
        // Emit the new status.
        emit newStatus(status);
    } catch (std::exception & e) {
        // As a rule, exceptions just mean the server is not responding. Emit
        // serverResponsive(false) if the server had previously been responding.
        if (_responsive) {
            _responsive = false;
            std::ostringstream oss;
            oss << "HcrMonitor failed to respond to getStatus(): " << e.what();
            WLOG << oss.str();
            emit serverResponsive(false, QString(oss.str().c_str()));
        }
    }
}
