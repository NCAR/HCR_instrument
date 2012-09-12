/*
 * XmitdStatusThread.cpp
 *
 *  Created on: Sep 10, 2012
 *      Author: hcr
 */

#include "XmitdStatusThread.h"
#include <QTimer>

XmitdStatusThread::XmitdStatusThread(XmitdRpcClient & client) :
    _responsive(false),
    _client(client) {
}

XmitdStatusThread::~XmitdStatusThread() {
}

void
XmitdStatusThread::run() {
    // Set up a 1 s timer to call _getStatus()
    QTimer timer;
    connect(&timer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    timer.start(1000);
    // Start the event loop
    exec();
    return;
}

void
XmitdStatusThread::_getStatus() {
    XmitStatus status;
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
