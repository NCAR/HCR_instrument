#include "CmigitsShmWatchThread.h"
#include <QMetaType>
#include <QTimer>
#include <logx/Logging.h>

LOGGING("CmigitsShmWatchThread")

CmigitsShmWatchThread::CmigitsShmWatchThread(int pollIntervalMs) :
    _pollIntervalMs(pollIntervalMs),
    _cmigitsShm(),
    _last3512Time(0) {
    // Don't allow a polling interval less than 4 ms, since faster polling
    // makes our thread a significant CPU hog, and 4 ms is fast enough to 
    // catch all all new C-MIGITS data even at its maximum rate of 100 Hz
    // (or 10 ms update interval).
    if (_pollIntervalMs < 4) {
        WLOG << "Polling interval was changed to minimum value of 4 ms";
        _pollIntervalMs = 4;
    }
    // We need to register CmigitsSharedMemory::ShmStruct as a metatype,
    // since we'll be passing it as an argument in a signal.
    qRegisterMetaType<CmigitsSharedMemory::ShmStruct>("CmigitsSharedMemory::ShmStruct");
}

CmigitsShmWatchThread::~CmigitsShmWatchThread() {
    DLOG << "destructor";
    if (isRunning()) {
        DLOG << "Stopping thread";
        QThread::quit();
    }
}

//
// Thread run method
void
CmigitsShmWatchThread::run()
{
    // Set up and start our timer for polling shared memory.
    QTimer pollTimer;
    pollTimer.setInterval(_pollIntervalMs);
    connect(& pollTimer, SIGNAL(timeout()), this, SLOT(_pollSharedMemory()));
    pollTimer.start();
    // The poll timer is running, so just fire up the event loop.
    exec();
}

void
CmigitsShmWatchThread::_pollSharedMemory() {
    CmigitsSharedMemory::ShmStruct cmigitsData = _cmigitsShm.getContents();
    // Since 3512 messages come in most frequently, we use the time of the
    // latest 3512 message to see if new content is in the shared memory.
    if (cmigitsData.time3512 > _last3512Time) {
        _last3512Time = cmigitsData.time3512;
        emit newData(cmigitsData);
    }
}
