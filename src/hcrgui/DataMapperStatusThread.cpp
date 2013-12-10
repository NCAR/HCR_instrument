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
#include <boost/date_time/posix_time/posix_time.hpp>
#include <logx/Logging.h>

using namespace boost::posix_time;

LOGGING("DataMapperStatusThread")

static const std::string DATA_TYPE = "iwrf_ts";
static const std::string DATA_DIR = "time_series/wband/save";

DataMapperStatusThread::DataMapperStatusThread(std::string dmapHost) :
    _dmapHost(dmapHost),
    _dmapAccess(),
    _responsive(false){
    
    // Zero out _lastInfo
    memset(&_lastInfo, 0, sizeof(_lastInfo));
    
    // Change thread affinity to self instead of our parent's thread.
    // This makes the calls to _getStatus() execute in *this* thread, which is
    // what we want.
    moveToThread(this);
}

DataMapperStatusThread::~DataMapperStatusThread() {
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
    DMAP_info_t info = _lastInfo;
    
    int nInfo = _dmapAccess.getNInfo();
    switch (nInfo) {
    case 0:
        // Nobody has registered to write our DATA_TYPE to DATA_DIR.
        // Continue using _lastInfo.
        break;
    case 1:
        // This is the common case; we should almost always get 1 info block.
        // Get the block.
        info = _dmapAccess.getInfo(0);
        break;
    default:
        WLOG << "Got " << nInfo << " info entries from DataMapper, but " <<
            "expected 1. Using first entry.";
        info = _dmapAccess.getInfo(0);
        break;
    }
    
    // Calculate the write rate between this info block and the previous one.
    // Only calculate the rate if the delta time between the two blocks is
    // greater than zero and less than 1 minute. Otherwise report a 0 MiB/s
    // rate.
    double writeRate = 0.0; // MiB/s
    ptime lastTime = boost::posix_time::from_time_t(_lastInfo.latest_time);
    ptime infoTime = boost::posix_time::from_time_t(info.latest_time);
    time_duration delta = infoTime - lastTime;
    
    // If the time difference is less than a minute, calculate the data
    // rate between the two times. Otherwise return a rate of zero.
    if (delta.total_milliseconds() == 0) {
        DLOG << "Delta is ZERO";
        writeRate = 0.0;
    } else if (delta.total_milliseconds() > 60000) {
        WLOG << "Delta over 1 minute: " << delta.total_seconds() << " s";
        writeRate = 0.0;
    } else {
        ILOG << "Good delta of " << 0.001 * delta.total_milliseconds() << " ms";
        double wroteMiB = (info.total_bytes - _lastInfo.total_bytes) / 
                /* (1024 * 1024) */ 1.0;
        writeRate = wroteMiB / (delta.total_milliseconds() * 0.001);
    }
    
    // Save this info block
    _lastInfo = info;
    
    // Emit the new status.
    DLOG << boost::posix_time::to_simple_string(infoTime) << 
            ": writing time series at " << writeRate << " MiB/s";
    emit newStatus(writeRate);
}
