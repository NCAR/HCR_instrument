#include "CmigitsWatchThread.h"
#include <QMetaType>
#include <QTimer>
#include <logx/Logging.h>

LOGGING("CmigitsWatchThread")

CmigitsWatchThread::CmigitsWatchThread() :
    _cmigitsShm(),
    _last3512Time(0) {
    // We need to register CmigitsSharedMemory::ShmStruct as a metatype,
    // since we'll be passing it as an argument in a signal.
    qRegisterMetaType<CmigitsSharedMemory::ShmStruct>("CmigitsSharedMemory::ShmStruct");
}

CmigitsWatchThread::~CmigitsWatchThread() {
    DLOG << "destructor";
    if (isRunning()) {
        DLOG << "Stopping thread";
        QThread::quit();
    }
}

//
// Thread run method
void
CmigitsWatchThread::run()
{
    // Poll shared memory on a frequent basis to look for (and act
    // on) new C-MIGITS data. The C-MIGITS data come at up to 100 Hz, so
    // we poll at a 4 ms interval to catch all changes quickly.
    // (Beware setting the timer interval lower, as this thread becomes
    // a CPU hog with the interval set at 1-2 ms).
    QTimer pollTimer;
    pollTimer.setInterval(4);
    connect(& pollTimer, SIGNAL(timeout()), this, SLOT(_pollSharedMemory()));
    pollTimer.start();
    // The poll timer is running, so just fire up the event loop.
    exec();
}

void
CmigitsWatchThread::_pollSharedMemory() {
    CmigitsSharedMemory::ShmStruct cmigitsData = _cmigitsShm.getContents();
    // Since 3512 messages come in most frequently, we use the time of the
    // latest 3512 message to see if new content is in the shared memory.
    if (cmigitsData.time3512 > _last3512Time) {
        _last3512Time = cmigitsData.time3512;
        emit newData(cmigitsData);
    }
}

void
CmigitsWatchThread::quit() {
    WLOG << "Singleton CmigitsWatchThread() not quitting, as others may be using it.";
}
