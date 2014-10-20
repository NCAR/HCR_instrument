#ifndef CMIGITS_SHM_WATCH_THREAD_H_
#define CMIGITS_SHM_WATCH_THREAD_H_

#include "CmigitsSharedMemory.h"
#include <stdint.h>
#include <QThread>

/// CmigitsShmWatchThread polls CmigitsSharedMemory and emits newData() when new
/// data is seen in the shared memory.

class CmigitsShmWatchThread : public QThread {

    Q_OBJECT

public:
    /// @brief Constructor
    /// @param pollIntervalMs shared memory polling interval, ms. Note that
    /// this value cannot be set lower than 4, as the thread becomes a CPU hog
    /// at smaller polling intervals.
    CmigitsShmWatchThread(int pollIntervalMs = 4);
    
    /// Destructor
    virtual ~CmigitsShmWatchThread();

//    /// @brief Return a reference to the singleton instance, instantiating it
//    /// and starting it on first use.
//    static CmigitsShmWatchThread & GetInstance() {
//        static CmigitsShmWatchThread instance;
//        instance.start();
//        return(instance);
//    }

    /// @brief The quit() method for CmigitsShmWatchThread does nothing but print
    /// a warning, since stopping the thread would affect others using the
    /// singleton instance.
    void quit();
    
protected:
    void run();

signals:
    /// @brief Signal emitted when new C-MIGITS shared memory content is
    /// seen.
    void newData(CmigitsSharedMemory::ShmStruct cmigitsData);

private slots:
    void _pollSharedMemory();

private:
    int _pollIntervalMs;    ///< shared memory polling interval, ms
    CmigitsSharedMemory _cmigitsShm;    ///< C-MIGITS shared memory connection
    uint64_t _last3512Time; ///< time of last C-MIGITS 3512 message seen
};

#endif /* CMIGITS_WATCH_THREAD_H_ */
