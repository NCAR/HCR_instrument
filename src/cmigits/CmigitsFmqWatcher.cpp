/*
 * CmigitsFmqWatcher.cpp
 *
 *  Created on: Dec 31, 2014
 *      Author: burghart
 */

#include "CmigitsFmqWatcher.h"
#include <unistd.h>
#include <sys/time.h>
#include <QDateTime>
#include <QMetaType>
#include <logx/Logging.h>

LOGGING("CmigitsFmqWatcher")

const std::string CmigitsFmqWatcher::FMQ_PATH = "/tmp/cmigits_fmq/shmem_22000";


CmigitsFmqWatcher::CmigitsFmqWatcher(uint32_t minDataIntervalMs,
        uint32_t dataTimeoutMs) :
    _myThread(),
    _cmigitsFmq(),
    _minDataIntervalMs(minDataIntervalMs),
    _dataTimeoutMs(dataTimeoutMs),
    _pollTimer(NULL),
    _dataTimeoutTimer(NULL),
    _logTimer(NULL),
    _lastSignalTime(0),
    _fmqMsgCount(0) {
    // Change thread affinity to the thread where we'll do the real work
    moveToThread(&_myThread);
    
    // Don't allow a data timeout period less than 10 ms, since maximum
    // data rate from the C-MIGITS is 100 Hz (i.e., every 10 ms)
    if (dataTimeoutMs < 10) {
        WLOG << "Data timeout period was changed to minimum value of 10 ms";
        dataTimeoutMs = 10;
    }
    
    // We need to register CmigitsFmq::MsgStruct as a metatype,
    // since we'll be passing it as an argument in a signal.
    qRegisterMetaType<CmigitsFmq::MsgStruct>("CmigitsFmq::MsgStruct");
    
    // Do the rest of our initialization from within our thread
    connect(&_myThread, SIGNAL(started()), this, SLOT(_startWatching()));
    _myThread.start();
}

CmigitsFmqWatcher::~CmigitsFmqWatcher() {
    _myThread.quit();
    _myThread.wait(250);
    delete(_logTimer);
    delete(_dataTimeoutTimer);
    delete(_pollTimer);
}

void
CmigitsFmqWatcher::_startWatching() {
    // Use a zero-interval timer to poll the FMQ whenever _myThread is not 
    // otherwise busy.
    _pollTimer = new QTimer();
    _pollTimer->setInterval(0);
    connect(_pollTimer, SIGNAL(timeout()), this, SLOT(_pollFmq()));
    _pollTimer->start();
    
    // Emit dataTimeout() signals if we don't see new data for dataTimeoutMs
    // milliseconds.
    _dataTimeoutTimer = new QTimer();
    _dataTimeoutTimer->setInterval(_dataTimeoutMs);
    connect(_dataTimeoutTimer, SIGNAL(timeout()), this, SIGNAL(dataTimeout()));
    _dataTimeoutTimer->start();
    
    // Log some info occasionally
    _logTimer = new QTimer();
    _logTimer->setInterval(10000);
    connect(_logTimer, SIGNAL(timeout()), this, SLOT(_logStatus()));
    _logTimer->start();
}

void
CmigitsFmqWatcher::_pollFmq() {
    static const int WAIT_MSECS = 5;
    
    // Try to open the FMQ if it is not yet opened
    if (! _cmigitsFmq.isOpen()) {
        if (_cmigitsFmq.initReadOnly(FMQ_PATH.c_str(), "CmigitsFmqThread", 
                                     false, Fmq::END, 0)) {
            DLOG << "No FMQ";
            // Sleep briefly if we can't open the FMQ, since our zero-interval
            // timer will otherwise put us in a tight CPU-hogging loop until 
            // we *can* open it.
            usleep(WAIT_MSECS * 1000);
            return;
        } else {
            ILOG << "C-MIGITS FMQ opened for reading!";
        }
    }
    
    // Execute a read which waits up to WAIT_MSECS ms for a new message.
    bool gotOne = false;
    _cmigitsFmq.readMsg(&gotOne, -1, WAIT_MSECS);
    if (gotOne) {
        _fmqMsgCount++;
    } else {
        return;
    }
    
    // Validate the message size
    int msgLen = _cmigitsFmq.getMsgLen();
    if (msgLen != sizeof(CmigitsFmq::MsgStruct)) {
        ELOG << "Got " << msgLen << "-byte message from FMQ, when expecting " << 
                sizeof(CmigitsFmq::MsgStruct) << " bytes";
        return;
    }

    // Cast the message into a CmigitsFmq::MsgStruct
    const void * msgPtr = _cmigitsFmq.getMsg();
    const CmigitsFmq::MsgStruct cmigitsData = 
            *(reinterpret_cast<const CmigitsFmq::MsgStruct*>(msgPtr));

    // restart the data timeout timer
    _dataTimeoutTimer->start();

    // Log anything with a lag > 30 ms
    struct timeval tvNow;
    gettimeofday(&tvNow, 0);
    uint64_t nowMs = 1000LL * tvNow.tv_sec + tvNow.tv_usec / 1000;
    uint32_t lagMs = nowMs - cmigitsData.time3512;
    if (lagMs > 30) {
        time_t secs = cmigitsData.time3512 / 1000;
        uint32_t msecs = cmigitsData.time3512 % 1000;
        QDateTime qCmigitsTime = QDateTime::fromTime_t(secs).addMSecs(msecs);
        QDateTime qNow = QDateTime::fromTime_t(tvNow.tv_sec).addMSecs(tvNow.tv_usec / 1000);
        DLOG << "C-MIGITS " << 
                qCmigitsTime.toString("hh:mm:ss.zzz").toStdString() <<
                " arrived " << qNow.toString("hh:mm:ss.zzz").toStdString() << 
                " (lag " << lagMs << " ms)";
    }
    
    // Emit newData() signal if the change in data time is big enough
    uint64_t dataTime = cmigitsData.time3512 ? 
            cmigitsData.time3512 : cmigitsData.time3500;
    if (dataTime >= (_lastSignalTime + _minDataIntervalMs)) {
        _lastSignalTime = dataTime;
        DLOG << "emitting newData() for " << dataTime;
        emit newData(cmigitsData);
    }
}

void
CmigitsFmqWatcher::_logStatus() {
    ILOG << "Saw " << _fmqMsgCount << " FMQ messages in " << 
            _logTimer->interval() * 0.001 << " s";
    _fmqMsgCount = 0;
}
