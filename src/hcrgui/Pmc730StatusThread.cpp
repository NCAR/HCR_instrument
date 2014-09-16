/*
 * Pmc730StatusThread.cpp
 *
 *  Created on: Sep 10, 2012
 *      Author: hcr
 */

#include "Pmc730StatusThread.h"
#include <QMetaType>
#include <QTimer>
#include <logx/Logging.h>

LOGGING("Pmc730StatusThread")

Pmc730StatusThread::Pmc730StatusThread(std::string drxHost, int drxPort) :
    _responsive(false),
    _drxHost(drxHost),
    _drxPort(drxPort),
    _client(0) {
    // We need to register HcrPmc730Status as a metatype, since we'll be passing
    // it as an argument in a signal.
    qRegisterMetaType<HcrPmc730Status>("HcrPmc730Status");
    // Set thread affinity to self, so that signals connected to our slot(s)
    // will execute the slots in this thread, and not our parent's.
    moveToThread(this);
}

Pmc730StatusThread::~Pmc730StatusThread() {
}

void
Pmc730StatusThread::run() {
    // Instantiate the HcrPmc730Client
    _client = new HcrPmc730Client(_drxHost, _drxPort);
    // Set up a 1 s timer to call _getStatus()
    QTimer timer;
    connect(&timer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    timer.start(1000);
    // Start the event loop
    exec();
    return;
}

void
Pmc730StatusThread::_getStatus() {
    try {
        HcrPmc730Status status = _client->getStatus();
        // We got a response, so emit serverResponsive(true) if the server was
        // not previously responding.
        if (! _responsive) {
            _responsive = true;
            emit serverResponsive(true, QString("HcrPmc730Daemon is responding"));
        }
        // Emit the new status.
        emit newStatus(status);
    } catch (std::exception & e) {
        // As a rule, exceptions just mean the server is not responding. Emit
        // serverResponsive(false) if the server had previously been responding.
        if (_responsive) {
            std::ostringstream oss;
            oss << "HcrPmc730Daemon failed to respond to getStatus(): " << e.what();
            _responsive = false;
            emit serverResponsive(false, QString(oss.str().c_str()));
        }
    }
}
