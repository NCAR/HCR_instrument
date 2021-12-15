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
#include "IwrfExportInsPoller.h"
#include "IwrfExport.h"
#include "../HcrSharedResources.h"

#include <exception>
#include <sstream>
#include <QtCore/QTimer>
#include <logx/Logging.h>

LOGGING("IwrfExportInsPoller")


IwrfExportInsPoller::IwrfExportInsPoller(IwrfExport & iwrfExport, int insNum) :
    _workThread(NULL),
    _workTimer(NULL),
    _iwrfExport(iwrfExport),
    _insNum(insNum),
    _fmqUrl(),
    _insFmq(),
    _inNavMode(false),
    _lastFmqWarningTime(0) {
    // Get the URL for our INS's FMQ
    switch (_insNum) {
    case 1:
        _fmqUrl = INS1_FMQ_URL;
        break;
    case 2:
        _fmqUrl = INS2_FMQ_URL;
        break;
    default:
        std::ostringstream os;
        os << "IwrfExportInsPoller: Unexpected INS number " << _insNum;
        throw(std::runtime_error(os.str()));
    }

    // Set the name of our work thread, which will be displayed by 'top' and 'ps'
    _workThread.setObjectName("IwrfExportInsPoller");

    // Set thread affinity to our work thread, so that our slots will execute
    // in that thread.
    moveToThread(&_workThread);

    // Create and start our work timer from within our work thread after it
    // starts
    connect(&_workThread, SIGNAL(started()), this, SLOT(_initWorkTimer()));

    // Start the work thread
    _workThread.start();
}

IwrfExportInsPoller::~IwrfExportInsPoller() {
    DLOG << "destructor";
    if (_workThread.isRunning()) {
        DLOG << "Stopping thread";
        _workThread.quit();
        if (! _workThread.wait(1000)) {
            WLOG << "Work thread did not finish promptly in destructor.";
        }
    }
}

void
IwrfExportInsPoller::_initWorkTimer() {
    // Create and start a timer which will generate a call to
    // _handleNextFmqEntry() whenever the work thread is not otherwise busy.
    _workTimer = new QTimer();
    _workTimer->setInterval(0);
    connect(_workTimer, SIGNAL(timeout()), this, SLOT(_handleNextFmqEntry()));
    _workTimer->start();
}

void
IwrfExportInsPoller::_handleNextFmqEntry() {
    // If the FMQ is not opened for reading, try to do so now. We issue a
    // warning every FMQ_WARNING_INTERVAL_SECS seconds if we cannot open the
    // FMQ (generally because it has not yet been created by the writer).
    if (! _insFmq.isOpen()) {
        // Try to open the FMQ for reading
        _insFmq.initReadOnly(_fmqUrl.c_str(), "hcrdrx", false, Fmq::END, 10);

        // If the FMQ is now open, we're done in this block
        if (_insFmq.isOpen()) {
            ILOG << "INS" << _insNum << " FMQ " << _fmqUrl <<
                    " is now open for reading";
        } else {
            // Warn every FMQ_WARNING_INTERVAL_SECS seconds if we cannot open
            // the INS FMQ.
            time_t now = time(0);
            if ((now - _lastFmqWarningTime) > FMQ_WARNING_INTERVAL_SECS) {
                WLOG << "INS FMQ " << _fmqUrl << " cannot yet be opened for reading";
                _lastFmqWarningTime = now;
            }
            // Sleep briefly and return. We'll get called again really soon to try
            // again...
            usleep(1000 * FMQ_WAIT_TIMEOUT_MS);
            return;
        }
    }

    // Handle the next entry in the FMQ, waiting up to FMQ_WAIT_TIMEOUT_MS
    // ms for data to arrive
    bool gotData(false);
    if (_insFmq.readMsg(&gotData, -1, FMQ_WAIT_TIMEOUT_MS) != 0) {
      ELOG << "cannot read message from FMQ: " << _insFmq.getErrStr();
      return;
    } else if (! gotData) {
        // No data available in the allotted wait time. Return now.
        DLOG << "Timeout waiting for FMQ data from INS " << _insNum;
        return;
    }
    
    int msgLen = _insFmq.getMsgLen();
    if (msgLen != sizeof(CmigitsFmq::MsgStruct)) {
        ELOG << "Got " << msgLen << "-byte message from FMQ, expected " <<
                sizeof(CmigitsFmq::MsgStruct);
        return;
    }
    const void * msgPtr = _insFmq.getMsg();
    const CmigitsFmq::MsgStruct * cmigitsDataStruct =
            reinterpret_cast<const CmigitsFmq::MsgStruct*>(msgPtr);

    // Save the previous "in navigation mode" state of the INS
    bool prevInNavMode = _inNavMode;

    // Check the message to see if the INS is currently in a navigation mode
    // (7 = Air Navigation, 8 = Land Navigation)
    _inNavMode = cmigitsDataStruct->currentMode == 7 ||
            cmigitsDataStruct->currentMode == 8;

    // Log changes in the "in navigation mode" state
    if (prevInNavMode != _inNavMode) {
        if (_inNavMode) {
            ILOG << "INS" << _insNum << " is in a navigation mode. " <<
                    " Delivering data to IwrfExport";
        } else {
            WLOG << "INS" << _insNum <<  " left navigation mode. " <<
                    "Stopping data delivery to IwrfExport";
        }
    }

    // Queue the data to our IwrfExport instance if the INS is in a navigation mode
    if (_inNavMode) {
        _iwrfExport.queueInsData(*cmigitsDataStruct, _insNum);
    }
}
