/*
 * FmqDumper.cpp
 *
 *  Created on: Dec 31, 2014
 *      Author: hcr
 */
#include <logx/Logging.h>
#include "FmqDumper.h"

LOGGING("FmqDumper")

FmqDumper::FmqDumper() :
    _fmqWatcher(0) {
    connect(&_fmqWatcher, SIGNAL(newData(CmigitsFmq::MsgStruct)),
            this, SLOT(_logData(CmigitsFmq::MsgStruct)));
    connect(&_fmqWatcher, SIGNAL(dataTimeout()), this, SLOT(_logDataTimeout()));
}

FmqDumper::~FmqDumper() {
}

void
FmqDumper::_logData(CmigitsFmq::MsgStruct data) {
    ILOG << "data time " << (data.time3512 ? data.time3512 : data.time3500);
}

void
FmqDumper::_logDataTimeout() {
    ILOG << "C_MIGITS data timeout";
}
