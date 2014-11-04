#ifndef CMIGITS_SHM_WATCH_THREAD_H_
#define CMIGITS_SHM_WATCH_THREAD_H_

#include "CmigitsSharedMemory.h"
#include <stdint.h>
#include <QThread>

class QTimer;

/// CmigitsShmWatchThread polls CmigitsSharedMemory and emits newData() when new
/// data is seen in the shared memory.

class CmigitsShmWatchThread : public QThread {

    Q_OBJECT

public:
    /// @brief Constructor
    /// @param pollIntervalMs shared memory polling interval, ms. Note that
    /// this value cannot be set lower than 4, as the thread becomes a CPU hog
    /// at smaller polling intervals.
    /// @param dataTimeoutMs A dataTimeout() signal is emitted if the period
    /// between new data seen in the shared memory ever exceeds dataTimeoutMs
    /// milliseconds.
    CmigitsShmWatchThread(int pollIntervalMs = 4, int dataTimeoutMs = 250);
    
    /// Destructor
    virtual ~CmigitsShmWatchThread();

protected:
    void run();

signals:
    /// @brief Signal emitted when new C-MIGITS shared memory content is
    /// seen.
    void newData(CmigitsSharedMemory::ShmStruct cmigitsData);
    
    /// @brief Signal emitted if more than DATA_TIMEOUT_MS milliseconds pass 
    /// before new data are seen in the shared memory.
    void dataTimeout();

private slots:
    void _pollSharedMemory();

private:
    int _pollIntervalMs;                ///< shared memory polling interval, ms
    CmigitsSharedMemory _cmigitsShm;    ///< C-MIGITS shared memory connection
    uint64_t _last3512Time;             ///< time of last C-MIGITS 3512 message seen
    QTimer * _dataTimeoutTimer;         ///< timer used to note when data stop updating
    int _dataTimeoutMs;                 ///< data timeout period, milliseconds
};

#endif /* CMIGITS_WATCH_THREAD_H_ */
