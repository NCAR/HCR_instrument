/*
 * CmigitsStatusThread.cpp
 *
 *  Created on: Sep 24, 2013
 *      Author: burghart
 */

#include "CmigitsStatusThread.h"
#include <sstream>
#include <QMetaType>
#include <QTimer>

CmigitsStatusThread::CmigitsStatusThread(std::string cmigitsHost, int cmigitsPort) :
    _responsive(false),
    _cmigitsHost(cmigitsHost),
    _cmigitsPort(cmigitsPort),
    _client(0) {
    // We need to register CmigitsStatus as a metatype, since we'll be passing
    // it as an argument in a signal.
    qRegisterMetaType<CmigitsStatus>("CmigitsStatus");
    // Change thread affinity to self instead of our parent's thread.
    // This makes the calls to _getStatus() execute in *this* thread, which is
    // what we want.
    moveToThread(this);
}

CmigitsStatusThread::~CmigitsStatusThread() {
}

void
CmigitsStatusThread::run() {
    // Instantiate the CmigitsDaemonRpcClient
    _client = new CmigitsDaemonRpcClient(_cmigitsHost, _cmigitsPort);
    // Set up a 1 s timer to call _getStatus()
    QTimer timer;
    connect(&timer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    timer.start(1000);
    // Start the event loop
    exec();
    return;
}

void
CmigitsStatusThread::_getStatus() {
    CmigitsStatus status;
    try {
        status = _client->getStatus();
    } catch (std::exception & e) {
        // As a rule, exceptions just mean the server is not responding. Emit
        // serverResponsive(false) if the server had previously been responding.
        if (_responsive) {
            std::ostringstream oss;
            oss << "cmigitsDaemon failed to respond to getStatus(): " << e.what();
            _responsive = false;
            emit serverResponsive(false, oss.str());
        }
    }
    // We got a response, so emit serverResponsive(true) if the server was
    // not previously responding.
    if (! _responsive) {
        _responsive = true;
        emit serverResponsive(true, "cmigitsDaemon is responding");
    }
    // And emit the new status.
    emit newStatus(status);
}
