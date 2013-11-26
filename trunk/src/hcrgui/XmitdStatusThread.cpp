/*
 * XmitdStatusThread.cpp
 *
 *  Created on: Sep 10, 2012
 *      Author: hcr
 */

#include "XmitdStatusThread.h"
#include <QMetaType>
#include <QTimer>

XmitdStatusThread::XmitdStatusThread(std::string xmitdHost, int xmitdPort) :
    _responsive(false),
    _xmitdHost(xmitdHost),
    _xmitdPort(xmitdPort),
    _client(0) {
    // We need to register XmitStatus as a metatype, since we'll be passing it
    // as an argument in a signal.
    qRegisterMetaType<XmitStatus>("XmitStatus");
    // Change thread affinity to self instead of our parent's thread.
    // This makes the calls to _getStatus() execute in *this* thread, which is
    // what we want.
    moveToThread(this);
}

XmitdStatusThread::~XmitdStatusThread() {
}

void
XmitdStatusThread::run() {
    _client = new XmitdRpcClient(_xmitdHost, _xmitdPort);
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
