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

HcrMonitor::HcrMonitor(const Pentek::p7142 * pentek,
        std::string pmc730dHost, int pmc730dPort,
        std::string xmitdHost, int xmitdPort) :
    QThread(),
    _pentek(pentek),
    _drxStatus(*_pentek),
    _pmc730Status(true),	// empty status
    _pmc730Client(pmc730dHost, pmc730dPort),
    _xmitClient(xmitdHost, xmitdPort),
    _mutex(QMutex::Recursive) {
}

HcrMonitor::~HcrMonitor() {
    // Exit the event loop to stop the thread
    quit();
    // Wait a bit for it to complete.
    if (! wait(1000)) {
        ELOG << "HcrMonitor thread failed to quit in destructor. Exiting anyway.";
    }
}

XmitStatus
HcrMonitor::transmitterStatus() const {
    QMutexLocker locker(&_mutex);
    return(_xmitStatus);
}

CmigitsStatus
HcrMonitor::cmigitsStatus() const {
    QMutexLocker locker(&_mutex);
    return(_cmigitsStatus);
}

DrxStatus
HcrMonitor::drxStatus() const {
    QMutexLocker locker(&_mutex);
    return(_drxStatus);
}

HcrPmc730Status
HcrMonitor::pmc730Status() const {
    QMutexLocker locker(&_mutex);
    return(_pmc730Status);
}

void
HcrMonitor::run() {
    // Set up a timer to call our _getStatus() method on a regular basis
    QTimer updateTimer;
    updateTimer.setInterval(1000);  // 1 Hz updates
    connect(&updateTimer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    updateTimer.start();
    
    // Now just start our event loop
    exec();
}

void
HcrMonitor::_getStatus() {
    _getPmc730Status();
    _getCmigitsStatus();
    _getDrxStatus();
    _getXmitStatus();
}
void
HcrMonitor::_getCmigitsStatus() {
    QMutexLocker locker(&_mutex);
    // Get a CmigitsStatus built from current values in CmigitsSharedMemory
    _cmigitsStatus = CmigitsStatus::StatusFromSharedMemory();
}

void
HcrMonitor::_getDrxStatus() {
    // Get the status first, then get the mutex and set our member variable.
    // This way, we don't have the mutex locked very long at all....
    DrxStatus drxStatus(*_pentek);

    QMutexLocker locker(&_mutex);
    _drxStatus = drxStatus;
}

void
HcrMonitor::_getPmc730Status() {
    // Get the status first, then get the mutex and set our member variable.
    // This way, we don't have the mutex locked very long at all....
    HcrPmc730Status status(true);
    _pmc730Client.getStatus(status);

    QMutexLocker locker(&_mutex);
    _pmc730Status = status;
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

