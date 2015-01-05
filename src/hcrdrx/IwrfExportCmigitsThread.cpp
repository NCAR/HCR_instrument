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
        if (msgLen != sizeof(CmigitsFmq::MsgStruct)) {
            ELOG << "Got " << msgLen << "-byte message from FMQ, expected " << 
                    sizeof(CmigitsFmq::MsgStruct);
            continue;
        }
        const void * msgPtr = _cmigitsFmq.getMsg();
        const CmigitsFmq::MsgStruct * cmigitsDataStruct = 
                reinterpret_cast<const CmigitsFmq::MsgStruct*>(msgPtr);
        _iwrfExport.acceptCmigitsData(*cmigitsDataStruct);
    }
}
