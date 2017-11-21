// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2016                                         
// ** University Corporation for Atmospheric Research (UCAR)                 
// ** National Center for Atmospheric Research (NCAR)                        
// ** Boulder, Colorado, USA                                                 
// ** BSD licence applies - redistribution and use in source and binary      
// ** forms, with or without modification, are permitted provided that       
// ** the following conditions are met:                                      
// ** 1) If the software is modified to produce derivative works,            
// ** such modified software should be clearly marked, so as not             
// ** to confuse it with the version available from UCAR.                    
// ** 2) Redistributions of source code must retain the above copyright      
// ** notice, this list of conditions and the following disclaimer.          
// ** 3) Redistributions in binary form must reproduce the above copyright   
// ** notice, this list of conditions and the following disclaimer in the    
// ** documentation and/or other materials provided with the distribution.   
// ** 4) Neither the name of UCAR nor the names of its contributors,         
// ** if any, may be used to endorse or promote products derived from        
// ** this software without specific prior written permission.               
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS  
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED      
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.    
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
#include "IwrfExportInsThread.h"
#include "IwrfExport.h"
#include "../HcrSharedResources.h"

#include <QTimer>
#include <logx/Logging.h>

LOGGING("IwrfExportInsThread")


IwrfExportInsThread::IwrfExportInsThread(IwrfExport & iwrfExport, int insNum) :
    _iwrfExport(iwrfExport),
    _insNum(insNum),
    _insFmq() {
    // Since we don't have a proper Qt event loop, allow the terminate() 
    // method to stop us.
    setTerminationEnabled(true);
}

IwrfExportInsThread::~IwrfExportInsThread() {
    DLOG << "destructor";
    if (isRunning()) {
        DLOG << "Stopping thread";
        terminate();
        wait(1000);
    }
}

//
// Thread run method
void
IwrfExportInsThread::run()
{
    // Loop until the FMQ is initialized, sleeping briefly after each attempt
    // until initialization is successful. We issue a warning every 
    // FMQ_WARNING_INTERVAL_SECS seconds if we cannot open the FMQ (generally
    // because it has not yet been created by the writer).
    const int FMQ_WARNING_INTERVAL_SECS = 10;
    time_t fmqWarningTime = 0;
    std::string fmqUrl;
    switch (_insNum) {
    case 1:
        fmqUrl = INS1_FMQ_URL;
        break;
    case 2:
        fmqUrl = INS2_FMQ_URL;
        break;
    default:
        ELOG << "BUG - Unexpected INS number " << _insNum;
        abort();
    }

    // Loop until we open the FMQ successfully
    while (true) {
        _insFmq.initReadOnly(fmqUrl.c_str(), "hcrdrx", false, Fmq::END, 10);

        // If the FMQ is open, we're done in this loop
        if (_insFmq.isOpen()) {
            ILOG << "INS" << _insNum << " FMQ " << fmqUrl <<
                    " is now open for reading";
            // We're done. Break out of the loop.
            break;
        }
        
        // Warn every FMQ_WARNING_INTERVAL_SECS seconds if we cannot open the
        // INS FMQ.
        time_t now = time(0);
        if ((now - fmqWarningTime) > FMQ_WARNING_INTERVAL_SECS) {
            WLOG << "INS FMQ " << fmqUrl << " cannot yet be opened for reading";
            fmqWarningTime = now;
        }
        // Sleep for 0.1 s and try again
        usleep(100000);
    }
    
    // Now begin the reading loop
    while (true) {
        if (_insFmq.readMsgBlocking()) {
          ELOG << "ERROR - cannot read message from FMQ: " << _insFmq.getErrStr();
          return;
        }
        
        int msgLen = _insFmq.getMsgLen();
        if (msgLen != sizeof(CmigitsFmq::MsgStruct)) {
            ELOG << "Got " << msgLen << "-byte message from FMQ, expected " << 
                    sizeof(CmigitsFmq::MsgStruct);
            continue;
        }
        const void * msgPtr = _insFmq.getMsg();
        const CmigitsFmq::MsgStruct * cmigitsDataStruct = 
                reinterpret_cast<const CmigitsFmq::MsgStruct*>(msgPtr);
        _iwrfExport.queueInsData(*cmigitsDataStruct, _insNum);
    }
}
