#include "CmigitsFmqThread.h"

CmigitsFmqThread::CmigitsFmqThread(uint32_t minDataIntervalMs, 
        uint32_t dataTimeoutMs) :
    _minDataIntervalMs(minDataIntervalMs),
    _dataTimeoutMs(dataTimeoutMs) {
}

CmigitsFmqThread::~CmigitsFmqThread() {
    if (isRunning()) {
        quit();
        wait(500);
    }
}

// Thread run method
void
CmigitsFmqThread::run()
{
    // Create our worker
    CmigitsFmqThreadWorker worker(_minDataIntervalMs, _dataTimeoutMs);
    
    // Replicate the worker's signals as our own. Use DirectConnection so that 
    // our signals are emitted from *this* thread rather than from the thread
    // where this QThread instance has its affinity.
    connect(&worker, SIGNAL(newData(CmigitsFmq::MsgStruct)),
            this, SIGNAL(newData(CmigitsFmq::MsgStruct)),
            Qt::DirectConnection);
    connect(&worker, SIGNAL(dataTimeout()), this, SIGNAL(dataTimeout()),
            Qt::DirectConnection);

    // Now just fire up the event loop.
    exec();
}
