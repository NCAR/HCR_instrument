/*
 * HcrdrxStatusThread.cpp
 *
 *  Created on: Sep 10, 2012
 *      Author: hcr
 */

#include "HcrdrxStatusThread.h"
#include <QTimer>

HcrdrxStatusThread::HcrdrxStatusThread(HcrdrxRpcClient & client) :
    _responsive(false),
    _client(client) {
}

HcrdrxStatusThread::~HcrdrxStatusThread() {
}

void
HcrdrxStatusThread::run() {
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
    if (_client.getStatus(status)) {
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
