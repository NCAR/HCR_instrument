#ifndef CMIGITS_FMQ_THREAD_H_
#define CMIGITS_FMQ_THREAD_H_

#include <stdint.h>
#include <QThread>
#include "CmigitsFmqThreadWorker.h"

/// CmigitsFmqThread uses a worker to poll the CmigitsFmq and emits newData() 
/// when new data is seen.
class CmigitsFmqThread : public QThread {

    Q_OBJECT

public:
    /// @brief Constructor
    /// @param minDataIntervalMs Minimum data time interval between successive
    /// newData() signals, ms. Set to zero to get newData() signals for *all* new
    /// data.
    /// @param dataTimeoutMs A dataTimeout() signal is emitted if the period
    /// between new data seen in the shared memory ever exceeds dataTimeoutMs
    /// milliseconds.
    CmigitsFmqThread(uint32_t minimumDataIntervalMs, uint32_t dataTimeoutMs = 250);
    
    /// Destructor
    virtual ~CmigitsFmqThread();

    
protected:
    void run();

signals:
    /// @brief Signal emitted when new C-MIGITS shared memory content is
    /// seen.
    void newData(CmigitsSharedMemory::ShmStruct cmigitsData);
    
    /// @brief Signal emitted if more than _dataTimeoutMs milliseconds pass 
    /// before new data are seen in the shared memory.
    void dataTimeout();

private:
    uint32_t _minDataIntervalMs;   ///< minimum data time interval between newData() signals, ms
    int _dataTimeoutMs;         ///< data timeout period, milliseconds
};

#endif /* CMIGITS_FMQ_THREAD_H_ */
