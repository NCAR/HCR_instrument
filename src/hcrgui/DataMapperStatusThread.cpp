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
    
    // We need to register DMAP_info_t as a metatype, since we'll be passing
    // it as an argument in a signal.
    qRegisterMetaType<DMAP_info_t>("DMAP_info_t");

    // Zero out _lastTsInfo
    memset(&_lastTsInfo, 0, sizeof(_lastTsInfo));
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
    DMAP_info_t info = _lastTsInfo;
    
    int nInfo = _dmapAccess.getNInfo();
    switch (nInfo) {
    case 0:
        // Nobody has registered to write our DATA_TYPE to DATA_DIR.
        // Continue using _lastTsInfo.
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
    
    // Save this info block
    _lastTsInfo = info;
    
    // Emit the new status.
    ptime tsTime = boost::posix_time::from_time_t(_lastTsInfo.latest_time);
    DLOG << "Latest time-series data time written: " <<
            boost::posix_time::to_simple_string(tsTime);
    emit newStatus(_lastTsInfo);
}
