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

#include <HmcModeChange.h>
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
    _mutex(QMutex::Recursive),
    _hmcModeChangeSocket(NULL) {
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

    // Open the UDP socket to receive Operation mode change broadcasts, which we
    // use to force an update of _pmc730Status separate from the 1 Hz timer
    // above.
    _hmcModeChangeSocket = new QUdpSocket();
    _hmcModeChangeSocket->bind(HMC_MODE_BROADCAST_PORT, QUdpSocket::ShareAddress);
    connect(_hmcModeChangeSocket, SIGNAL(readyRead()),
            this, SLOT(_readHmcModeChangeSocket()));

    // Now just start our event loop
    exec();

    _hmcModeChangeSocket->close();
    delete(_hmcModeChangeSocket);
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

    // If the 730 is reporting a new mode, then we have to set ourselves up to match it.
    if (_pmc730Status.operationMode() != status.operationMode()) {
        uint32_t scheduleStartIndex = status.operationMode().scheduleStartIndex();
        uint32_t scheduleStopIndex = status.operationMode().scheduleStopIndex();

        ILOG << "Changing controller schedule to " << scheduleStartIndex << ":" << scheduleStopIndex;
        _pentek.changeControllerSchedule(scheduleStartIndex, scheduleStopIndex);

        _pmc730Status = status;
    }
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

void
StatusGrabber::_readHmcModeChangeSocket() {

    auto result = ListenForModeChange(*_hmcModeChangeSocket);
    //auto mode = result.first;
    auto modeChangeTime = result.second;

    if (modeChangeTime == 0.0) {
        WLOG << "_readHmcModeChangeSocket() called, but no good mode change " <<
                "packet was seen.";
        return;
    }

    // OK, now just get full current status from HcrPmc730 via XML-RPC. This
    // may cost us a handful of milliseconds, but gets complete and self-
    // consistent HcrPmc730Status with the new Operation mode.
    _getPmc730Status();

    struct timeval tvNow;
    gettimeofday(&tvNow, NULL);
    ILOG << "New ops mode '" <<
            _pmc730Status.operationMode().name() << "' " <<
            "with start time " << QDateTime::fromTime_t(time_t(modeChangeTime))
                .addMSecs(int(fmod(modeChangeTime, 1.0) * 1000))
                .toString("yyyyMMdd hh:mm:ss.zzz").toStdString() <<
            " is being noted at " <<
            QDateTime::fromTime_t(tvNow.tv_sec).addMSecs(tvNow.tv_usec / 1000)
                .toString("yyyyMMdd hh:mm:ss.zzz").toStdString();

}
