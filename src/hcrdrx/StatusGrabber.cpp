// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
// ** Copyright UCAR (c) 1990 - 2016
// ** University Corporation for Atmospheric Research (UCAR)
// ** National Center for Atmospheric Research (NCAR)
// ** Boulder, Colorado, USA
// ** BSD licence applies - redistribution and use in source and binary
// ** forms, with or without modification, are permitted provided that
// ** the following conditions are met:
// ** 1) If the software is modified to produce derivative works,
// ** such modified software should be clearly marked, so as not
// ** to confuse it with the version available from UCAR.
// ** 2) Redistributions of source code must retain the above copyright
// ** notice, this list of conditions and the following disclaimer.
// ** 3) Redistributions in binary form must reproduce the above copyright
// ** notice, this list of conditions and the following disclaimer in the
// ** documentation and/or other materials provided with the distribution.
// ** 4) Neither the name of UCAR nor the names of its contributors,
// ** if any, may be used to endorse or promote products derived from
// ** this software without specific prior written permission.
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
/*
 * StatusGrabber.cpp
 *
 *  Created on: Oct 29, 2010
 *      Author: burghart
 */

#include "StatusGrabber.h"
#include "HCR_Pentek.h"

#include <QDateTime>
#include <QMutexLocker>
#include <QTimer>
#include <QUdpSocket>

#include <ctime>
#include <iostream>
#include <string>
#include <vector>
#include <deque>

#include <logx/Logging.h>

LOGGING("StatusGrabber")

StatusGrabber::StatusGrabber(HCR_Pentek & pentek,
        std::string pmc730dHost, int pmc730dPort,
        std::string xmitdHost, int xmitdPort,
        std::string motionControlHost, int motionControlPort) :
    QThread(),
    _pentek(pentek),
    _drxStatus(),
    _pmc730Client(pmc730dHost, pmc730dPort),
    _pmc730Status(),	// empty/bad status
    _xmitClient(xmitdHost, xmitdPort),
    _xmitStatus(),
    _motionControlClient(motionControlHost, motionControlPort),
    _motionControlStatus(),
    _mutex(QMutex::Recursive) {
    moveToThread(this);
}

StatusGrabber::~StatusGrabber() {
    // Exit the event loop to stop the thread
    quit();
    if (! wait()) {
        ELOG << "StatusGrabber thread failed to quit in destructor. Exiting anyway.";
    }
}

XmitStatus
StatusGrabber::transmitterStatus() const {
    QMutexLocker locker(&_mutex);
    return(_xmitStatus);
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

MotionControl::Status
StatusGrabber::motionControlStatus() const {
    QMutexLocker locker(&_mutex);
    return(_motionControlStatus);
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
    _getDrxStatus();
    _getXmitStatus();
    _getMotionControlStatus();
}

void
StatusGrabber::_getDrxStatus() {
    // Get the status first, then get the mutex and set our member variable.
    // This way, we don't have the mutex locked very long at all....
    auto drxStatus = _pentek.status();

    QMutexLocker locker(&_mutex);
    _drxStatus = drxStatus;
}

void
StatusGrabber::_getPmc730Status() {
    // Get the status first, then get the mutex and set our member variable.
    // This way, we don't have the mutex locked very long at all....
    HcrPmc730Status status;
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

void
StatusGrabber::_getMotionControlStatus() {
    // Get the status first, then get the mutex and set our member variable.
    // This way, we don't have the mutex locked very long at all....
    MotionControl::Status mcStatus = _motionControlClient.status();

    QMutexLocker locker(&_mutex);
    _motionControlStatus = mcStatus;
}
