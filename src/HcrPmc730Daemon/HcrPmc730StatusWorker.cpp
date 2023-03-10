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
 * HcrPmc730StatusWorker.cpp
 *
 *  Created on: Sep 10, 2012
 *      Author: burghart
 */

#include "HcrPmc730StatusWorker.h"
#include "OperationModeChange.h"
#include <QDateTime>
#include <QMetaType>
#include <QTimer>
#include <QUdpSocket>
#include <logx/Logging.h>

LOGGING("HcrPmc730StatusWorker")

HcrPmc730StatusWorker::HcrPmc730StatusWorker(std::string daemonHost,
        int daemonPort, QThread* workThread) :
    _daemonHost(daemonHost),
    _daemonPort(daemonPort),
    _workThread(workThread),
    _responsive(false),
    _client(daemonHost, daemonPort),
    _hmcModeChangeSocket(NULL),
    _getStatusTimer(NULL)
{
    // We need to register HcrPmc730Status and HmcOperationMode as metatypes, 
    // since we'll be passing them as arguments in signals.
    qRegisterMetaType<HcrPmc730Status>("HcrPmc730Status");
    qRegisterMetaType<OperationMode>("OperationMode");

    // Initiate our work when the work thread is started, and continue until
    // the thread is stopped or destroyed.
    connect(workThread, &QThread::started, this, &HcrPmc730StatusWorker::_beginWork);
    connect(workThread, &QThread::finished, this, &QObject::deleteLater);
}

HcrPmc730StatusWorker::~HcrPmc730StatusWorker() {
    delete(_getStatusTimer);
    delete(_hmcModeChangeSocket);
}

void
HcrPmc730StatusWorker::_beginWork() {
    // Set our thread affinity to the work thread we were given at construction
    // time, so that signals/slots for this object will now execute in the work
    // thread.
    moveToThread(_workThread);

    // Instantiate and set up our periodic timer to call _getStatus()
    _getStatusTimer = new QTimer();
    connect(_getStatusTimer, &QTimer::timeout, this, &HcrPmc730StatusWorker::_getStatus);
    _getStatusTimer->start(1000);    /// 1000 ms
    
    // Open the UDP socket to receive HMC mode change broadcasts, and
    // connect it to our reader slot.
    _hmcModeChangeSocket = new QUdpSocket();
    _hmcModeChangeSocket->bind(OPERATION_MODE_BROADCAST_PORT, QUdpSocket::ShareAddress);
    connect(_hmcModeChangeSocket, &QUdpSocket::readyRead,
            this, &HcrPmc730StatusWorker::_readHmcModeChangeSocket);
}

void
HcrPmc730StatusWorker::_getStatus() {
    try {
        HcrPmc730Status status = _client.getStatus();
        // We got a response, so emit serverResponsive(true) if the server was
        // not previously responding.
        if (! _responsive) {
            _responsive = true;
            emit serverResponsive(true, QString("HcrPmc730Daemon is responding"));
        }
        // Emit the new status.
        emit newStatus(status);
    } catch (std::exception & e) {
        // As a rule, exceptions just mean the server is not responding. Emit
        // serverResponsive(false) if the server had previously been responding.
        if (_responsive) {
            std::ostringstream oss;
            oss << "HcrPmc730Daemon failed to respond to getStatus(): " << e.what();
            _responsive = false;
            emit serverResponsive(false, QString(oss.str().c_str()));
        }
    }
}

void
HcrPmc730StatusWorker::_readHmcModeChangeSocket() {
    auto result = ListenForModeChange(*_hmcModeChangeSocket);
    auto mode = result.first;
    auto modeChangeTime = result.second;

    if (modeChangeTime == 0.0) {
        WLOG << "_readHmcModeChangeSocket() called, but no good mode change " <<
                "packet was seen.";
        return;
    }

    // Emit our hmcModeChange() signal
    DLOG << "HMC mode changed to '" <<
            mode.name() << "' at " <<
            QDateTime::fromTime_t(time_t(modeChangeTime))
                .addMSecs(int(fmod(modeChangeTime, 1.0) * 1000))
                .toString("yyyyMMdd hh:mm:ss.zzz").toStdString();

    emit hmcModeChange(mode, modeChangeTime);

}
