#ifndef IWRFEXPORTCMIGITS_THREAD_H_
#define IWRFEXPORTCMIGITS_THREAD_H_

#include <CmigitsSharedMemory.h>
#include <QThread>
#include <Fmq/DsFmq.hh>

class IwrfExport;

/// IwrfExportCmigitsThread polls CmigitsSharedMemory and emits newData() when new
/// data is seen in the shared memory.

class IwrfExportCmigitsThread : public QThread {

    Q_OBJECT

public:
    static const std::string FMQ_PATH;
    
    /// @brief Constructor
    IwrfExportCmigitsThread(IwrfExport & iwrfExport);
    
    /// Destructor
    virtual ~IwrfExportCmigitsThread();

protected:
    void run();

private:
    IwrfExport & _iwrfExport;
    DsFmq _cmigitsFmq;
};

#endif /* IWRFEXPORTCMIGITS_THREAD_H_ */
