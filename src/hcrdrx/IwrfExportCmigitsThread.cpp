#include "IwrfExportCmigitsThread.h"
#include "IwrfExport.h"
#include <QTimer>
#include <logx/Logging.h>

LOGGING("IwrfExportCmigitsThread")

const std::string IwrfExportCmigitsThread::FMQ_PATH = "/tmp/cmigits_fmq/shmem_22000";

IwrfExportCmigitsThread::IwrfExportCmigitsThread(IwrfExport & iwrfExport) :
    _iwrfExport(iwrfExport),
    _cmigitsFmq() {
    ILOG << "Opening FMQ '" << FMQ_PATH << "' for reading";
    _cmigitsFmq.initReadBlocking(FMQ_PATH.c_str(), "hcrdrx", false, Fmq::END, 10);
}

IwrfExportCmigitsThread::~IwrfExportCmigitsThread() {
    DLOG << "destructor";
    if (isRunning()) {
        DLOG << "Stopping thread";
        quit();
    }
}

//
// Thread run method
void
IwrfExportCmigitsThread::run()
{
    while (true) {
//        QCoreApplication::processEvents();

        if (_cmigitsFmq.readMsgBlocking()) {
          ELOG << "ERROR - cannot read message from FMQ: " << _cmigitsFmq.getErrStr();
          return;
        }
        
        int msgLen = _cmigitsFmq.getMsgLen();
        if (msgLen != sizeof(CmigitsSharedMemory::ShmStruct)) {
            ELOG << "Got " << msgLen << "-byte message from FMQ, expected " << 
                    sizeof(CmigitsSharedMemory::ShmStruct);
            continue;
        }
        const void * msgPtr = _cmigitsFmq.getMsg();
        const CmigitsSharedMemory::ShmStruct * cmigitsDataStruct = 
                reinterpret_cast<const CmigitsSharedMemory::ShmStruct*>(msgPtr);
        _iwrfExport.acceptCmigitsData(*cmigitsDataStruct);
    }
}
