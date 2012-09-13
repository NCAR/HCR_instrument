/*
 * HcrdrxStatusThread.cpp
 *
 *  Created on: Sep 10, 2012
 *      Author: hcr
 */

#include "HcrdrxStatusThread.h"
#include <QTimer>

HcrdrxStatusThread::HcrdrxStatusThread(std::string drxHost, int drxPort) :
    _responsive(false),
    _drxHost(drxHost),
    _drxPort(drxPort),
    _client(0) {
}

HcrdrxStatusThread::~HcrdrxStatusThread() {
}

void
HcrdrxStatusThread::run() {
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
