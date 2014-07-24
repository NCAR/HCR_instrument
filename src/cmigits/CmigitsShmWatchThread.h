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
    /// Destructor
    virtual ~CmigitsShmWatchThread();

    /// @brief Return a reference to the singleton instance, instantiating it
    /// and starting it on first use.
    static CmigitsShmWatchThread & GetInstance() {
        static CmigitsShmWatchThread instance;
        instance.start();
        return(instance);
    }

    /// @brief The quit() method for CmigitsShmWatchThread does nothing but print
    /// a warning, since stopping the thread would affect others using the
    /// singleton instance.
    void quit();

signals:
    /// @brief Signal emitted when new C-MIGITS shared memory content is
    /// seen.
    void newData(CmigitsSharedMemory::ShmStruct cmigitsData);

private slots:
    void _pollSharedMemory();

private:
    /// @brief The constructor is private since this class creates a singleton.
    /// @see GetInstance().
    CmigitsShmWatchThread();

    CmigitsShmWatchThread(const CmigitsShmWatchThread &); // Don't implement for singleton
    void operator=(const CmigitsShmWatchThread &);     // Don't implement for singleton

    /// thread run method
    void run();

    CmigitsSharedMemory _cmigitsShm;    ///< C-MIGITS shared memory connection
    uint64_t _last3512Time; ///< time of last C-MIGITS 3512 message seen
};

#endif /* CMIGITS_WATCH_THREAD_H_ */
