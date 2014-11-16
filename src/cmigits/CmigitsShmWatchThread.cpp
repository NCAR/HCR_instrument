#include "CmigitsShmWatchThread.h"
#include <QMetaType>
#include <QTimer>
#include <logx/Logging.h>

LOGGING("CmigitsShmWatchThread")

CmigitsShmWatchThread::CmigitsShmWatchThread(int pollIntervalMs,
        int dataTimeoutMs) :
    _pollIntervalMs(pollIntervalMs),
    _cmigitsShm(),
    _last3512Time(0),
    _dataTimeoutTimer(NULL),
    _dataTimeoutMs(dataTimeoutMs),
    _newDataCount(0) {
    // Don't allow a polling interval less than 4 ms, since faster polling
    // makes our thread a significant CPU hog, and 4 ms is fast enough to 
    // catch all all new C-MIGITS data even at its maximum rate of 100 Hz
    // (or 10 ms update interval).
    if (_pollIntervalMs < 4) {
        WLOG << "Polling interval was changed to minimum value of 4 ms";
        _pollIntervalMs = 4;
    }
    // Don't allow a data timeout period less than 10 ms, since maximum
    // data rate from the C-MIGITS is 100 Hz (i.e., every 10 ms)
    if (_dataTimeoutMs < 10) {
        WLOG << "Data timeout period was changed to minimum value of 10 ms";
        _dataTimeoutMs = 10;
    }
    // We need to register CmigitsSharedMemory::ShmStruct as a metatype,
    // since we'll be passing it as an argument in a signal.
    qRegisterMetaType<CmigitsSharedMemory::ShmStruct>("CmigitsSharedMemory::ShmStruct");
}

CmigitsShmWatchThread::~CmigitsShmWatchThread() {
    DLOG << "destructor";
    if (isRunning()) {
        DLOG << "Stopping thread";
        quit();
    }
}

//
// Thread run method
void
CmigitsShmWatchThread::run()
{
    // Set up and start the data timeout timer
    _dataTimeoutTimer = new QTimer();
    _dataTimeoutTimer->setInterval(_dataTimeoutMs);
    _dataTimeoutTimer->setSingleShot(true);
    connect(_dataTimeoutTimer, SIGNAL(timeout()), 
            this, SIGNAL(dataTimeout()));   // emit our dataTimeout() signal
    _dataTimeoutTimer->start();
    
    // Set up and start our timer for polling shared memory.
    QTimer pollTimer;
    pollTimer.setInterval(_pollIntervalMs);
    connect(& pollTimer, SIGNAL(timeout()), this, SLOT(_pollSharedMemory()));
    pollTimer.start();
    
    // Set up and start a timer to log status on a periodic basis
    QTimer statusTimer;
    statusTimer.setInterval(10000); // 10 s
    connect(& statusTimer, SIGNAL(timeout()), this, SLOT(_logStatus()));
    statusTimer.start();

    // The timers are running, so just fire up the event loop.
    exec();
}

void
CmigitsShmWatchThread::_pollSharedMemory() {
    CmigitsSharedMemory::ShmStruct cmigitsData = _cmigitsShm.getContents();
    // Since 3512 messages come in most frequently, we use the time of the
    // latest 3512 message to see if new content is in the shared memory.
    if (cmigitsData.time3512 > _last3512Time) {
        // (re)start the data timeout timer
        _dataTimeoutTimer->start();
        
        // Mark the new time and emit the data
        _last3512Time = cmigitsData.time3512;
        _newDataCount++;
        emit newData(cmigitsData);
    }
}

void
CmigitsShmWatchThread::_logStatus() {
    ILOG << _newDataCount << " newData() signals emitted";
    _newDataCount = 0;
}
