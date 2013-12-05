/*
 * DataMapperStatusThread.cpp
 *
 *  Created on: Sep 24, 2013
 *      Author: burghart
 */

#include "DataMapperStatusThread.h"
#include <cstring>
#include <iomanip>
#include <sstream>
#include <QDateTime>
#include <QMetaType>
#include <QTimer>
#include <logx/Logging.h>

LOGGING("DataMapperStatusThread")

static const std::string DATA_TYPE = "iwrf_ts";
static const std::string DATA_DIR = "time_series/wband/save";

DataMapperStatusThread::DataMapperStatusThread(std::string dmapHost) :
    _dmapHost(dmapHost),
    _dmapAccess(),
    _responsive(false) {
    // We need to register DataMapper as a metatype, since we'll be passing
    // it as an argument in a signal.
    qRegisterMetaType<DMAP_info_t>("DMAP_info_t");
    // Change thread affinity to self instead of our parent's thread.
    // This makes the calls to _getStatus() execute in *this* thread, which is
    // what we want.
    moveToThread(this);
}

DataMapperStatusThread::~DataMapperStatusThread() {
}

DMAP_info_t
DataMapperStatusThread::badStatus() const {
    DMAP_info_t status;
    memset(&status, 0, sizeof(status));
    strncpy(status.hostname, _dmapHost.c_str(), sizeof(status.hostname));
    strncpy(status.datatype, DATA_TYPE.c_str(), sizeof(status.datatype));
    strncpy(status.dir, DATA_TYPE.c_str(), sizeof(status.dir));
    return(status);
}

void
DataMapperStatusThread::run() {
    // Set up a 1 s timer to call _getStatus()
    QTimer timer;
    connect(&timer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    timer.start(1000);
    // Start the event loop
    exec();
    return;
}

void
DataMapperStatusThread::_getStatus() {
    bool fail = _dmapAccess.reqSelectedInfo(DATA_TYPE, DATA_DIR, _dmapHost);
                    
    // On failure, mark the server as unresponsive and return. That's the best 
    // we can do, since we cannot determine the specific reason for failure.
    if (fail) {
        if (_responsive) {
            _responsive = false;
            std::ostringstream oss;
            oss << "Bad (or no) response from DataMapper @ " << _dmapHost;
            emit serverResponsive(false, QString(oss.str().c_str()));
        }
        return;
    }
    
    // We got a good reply from DataMapper. Emit a signal if DataMapper just 
    // became responsive.
    if (! _responsive) {
        _responsive = true;
        emit serverResponsive(true, QString("DataMapper is responding"));
    }

    // Extract the status we just requested, or build a "nothing written" status
    // if zero entries were returned.
    DMAP_info_t status;
    int nInfo = _dmapAccess.getNInfo();
    switch (nInfo) {
    case 0:
        // Nobody has registered to write our DATA_TYPE to DATA_DIR. Build
        // a status with zero data written.
        status = badStatus();
        break;
    case 1:
        // This should generally be the case.
        status = _dmapAccess.getInfo(0);
        break;
    default:
        WLOG << "Got " << nInfo << " info entries when expecting 1. " <<
            "Using first entry.";
        status = _dmapAccess.getInfo(0);
        break;
    }
    
    // Emit the new status.
    int GiB = 1024 * 1024 * 1024;
    QDateTime latestDataTime = QDateTime::fromTime_t(status.latest_time).toTimeSpec(Qt::UTC);
    DLOG << "Time series as of " << 
            latestDataTime.toString("yyyy/MM/dd hh:mm:ss: ").toStdString() << 
            status.nfiles << " files, " << 
            std::fixed << std::setprecision(3) << status.total_bytes / GiB << " GiB";
    emit newStatus(status);
}
