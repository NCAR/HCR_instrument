/*
 * StatusGrabber.cpp
 *
 *  Created on: Oct 29, 2010
 *      Author: burghart
 */

#include "StatusGrabber.h"

#include <QDateTime>
#include <QTimer>
#include <QMutexLocker>

#include <iostream>
#include <string>
#include <vector>
#include <deque>

#include <logx/Logging.h>

LOGGING("StatusGrabber")

StatusGrabber::StatusGrabber(const Pentek::p7142sd3c * pentek,
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

StatusGrabber::~StatusGrabber() {
    // Exit the event loop to stop the thread
    quit();
    // Wait a bit for it to complete.
    if (! wait(1000)) {
        ELOG << "StatusGrabber thread failed to quit in destructor. Exiting anyway.";
    }
}

XmitStatus
StatusGrabber::transmitterStatus() const {
    QMutexLocker locker(&_mutex);
    return(_xmitStatus);
}

CmigitsStatus
StatusGrabber::cmigitsStatus() const {
    QMutexLocker locker(&_mutex);
    return(_cmigitsStatus);
}

DrxStatus
StatusGrabber::drxStatus() const {
    QMutexLocker locker(&_mutex);
    return(_drxStatus);
}

HcrPmc730Status
StatusGrabber::pmc730Status() const {
    QMutexLocker locker(&_mutex);
    return(_pmc730Status);
}

void
StatusGrabber::run() {
    // Set up a timer to call our _getStatus() method on a regular basis
    QTimer updateTimer;
    updateTimer.setInterval(1000);  // 1 Hz updates
    connect(&updateTimer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    updateTimer.start();
    
    // Now just start our event loop
    exec();
}

void
StatusGrabber::_getStatus() {
    _getPmc730Status();
    _getCmigitsStatus();
    _getDrxStatus();
    _getXmitStatus();
}

void
StatusGrabber::_getCmigitsStatus() {
    QMutexLocker locker(&_mutex);
    // Get a CmigitsStatus built from current values in CmigitsSharedMemory
    _cmigitsStatus = CmigitsStatus::StatusFromSharedMemory();
}

void
StatusGrabber::_getDrxStatus() {
    // Get the status first, then get the mutex and set our member variable.
    // This way, we don't have the mutex locked very long at all....
    DrxStatus drxStatus(*_pentek);

    QMutexLocker locker(&_mutex);
    _drxStatus = drxStatus;
}

void
StatusGrabber::_getPmc730Status() {
    // Get the status first, then get the mutex and set our member variable.
    // This way, we don't have the mutex locked very long at all....
    HcrPmc730Status status(true);
    try {
        status = _pmc730Client.getStatus();
    } catch (std::exception & e) {
        WLOG << "Error getting HcrPmc730Daemon status: " << e.what();
    }

    QMutexLocker locker(&_mutex);
    _pmc730Status = status;
}

void
StatusGrabber::_getXmitStatus() {
    // Get the status first, then get the mutex and set our member variable.
    // This way, we don't have the mutex locked very long at all....
    XmitStatus xmitStatus;
    _xmitClient.getStatus(xmitStatus);

    QMutexLocker locker(&_mutex);
    _xmitStatus = xmitStatus;
}
