/*
 * Pmc730StatusThread.cpp
 *
 *  Created on: Sep 10, 2012
 *      Author: hcr
 */

#include "Pmc730StatusThread.h"
#include <QMetaType>
#include <QTimer>

Pmc730StatusThread::Pmc730StatusThread(std::string drxHost, int drxPort) :
    _responsive(false),
    _drxHost(drxHost),
    _drxPort(drxPort),
    _client(0) {
    // We need to register HcrPmc730Status as a metatype, since we'll be passing
    // it as an argument in a signal.
    qRegisterMetaType<HcrPmc730Status>("HcrPmc730Status");
    // Change thread affinity to self instead of our parent's thread.
    // This makes the calls to _getStatus() execute in *this* thread, which is
    // what we want.
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
    HcrPmc730Status status;
    if (_client->getStatus(status)) {
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
