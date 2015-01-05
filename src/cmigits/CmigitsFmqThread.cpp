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
    // Create our worker and connect its signals to generate our signals.
    CmigitsFmqThreadWorker worker(_minDataIntervalMs, _dataTimeoutMs);
    connect(&worker, SIGNAL(newData(CmigitsFmq::MsgStruct)),
            this, SIGNAL(newData(CmigitsFmq::MsgStruct)));
    connect(&worker, SIGNAL(dataTimeout()), this, SIGNAL(dataTimeout()));

    // Now just fire up the event loop.
    exec();
}
