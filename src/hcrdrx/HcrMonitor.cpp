/*
 * HcrMonitor.cpp
 *
 *  Created on: Oct 29, 2010
 *      Author: burghart
 */

#include "HcrMonitor.h"
#include "HcrPmc730.h"

#include <QDateTime>
#include <QTimer>
#include <QMutexLocker>

#include <iostream>
#include <string>
#include <vector>
#include <deque>

#include <logx/Logging.h>

LOGGING("HcrMonitor")

HcrMonitor::HcrMonitor(const Pentek::p7142 & pentek,
        std::string xmitdHost, int xmitdPort) :
    QThread(),
    _pentek(pentek),
    _drxStatus(_pentek),
    _xmitClient(xmitdHost, xmitdPort),
    _mutex(QMutex::Recursive) {
}

HcrMonitor::~HcrMonitor() {
    terminate();
    if (! wait(5000)) {
        ELOG << "HcrMonitor thread failed to stop in 5 seconds. Exiting anyway.";
    }
}

XmitStatus
HcrMonitor::transmitterStatus() const {
    QMutexLocker locker(&_mutex);
    return(_xmitStatus);
}

DrxStatus
HcrMonitor::drxStatus() const {
    QMutexLocker locker(&_mutex);
    return(_drxStatus);
}

void
HcrMonitor::run() {
    QDateTime lastUpdateTime(QDateTime::fromTime_t(0).toUTC());
    
    // Since we have no event loop, allow thread termination via the terminate()
    // method.
    setTerminationEnabled(true);

    while (true) {
        // Sleep if necessary to get ~1 second between updates
        QDateTime now = QDateTime::currentDateTime().toUTC();
        uint64_t msecsSinceUpdate = uint64_t(lastUpdateTime.daysTo(now)) * 1000 * 86400 + 
            lastUpdateTime.time().msecsTo(now.time());
        if (msecsSinceUpdate < 1000) {
            usleep((1000 - msecsSinceUpdate) * 1000);
        }
        
        // Get new values from the multi-IO card and Pentek
        _getDrxStatus();
        
        // Get transmitter status.
        _getXmitStatus();

        lastUpdateTime = QDateTime::currentDateTime().toUTC();
    }
}

void
HcrMonitor::_getDrxStatus() {
    // Get the status first, then get the mutex and set our member variable.
    // This way, we don't have the mutex locked very long at all....
    DrxStatus drxStatus(_pentek);

    QMutexLocker locker(&_mutex);
    _drxStatus = drxStatus;
}

void
HcrMonitor::_getXmitStatus() {
    // Get the status first, then get the mutex and set our member variable.
    // This way, we don't have the mutex locked very long at all....
    XmitStatus xmitStatus;
    _xmitClient.getStatus(xmitStatus);

    QMutexLocker locker(&_mutex);
    _xmitStatus = xmitStatus;
}

