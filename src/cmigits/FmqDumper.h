/*
 * FmqDumper.h
 *
 *  Created on: Dec 31, 2014
 *      Author: hcr
 */

#ifndef FMQDUMPER_H_
#define FMQDUMPER_H_

#include <QObject>
#include "CmigitsFmqWatcher.h"

/// Simple object which instantiates a CmigitsFmqWatcher and logs times for all 
/// C-MIGITS data which show up on the Fmq.
class FmqDumper: public QObject {
    Q_OBJECT
public:
    FmqDumper();
    virtual ~FmqDumper();
private slots:
    void _logData(CmigitsFmq::MsgStruct data);
    void _logDataTimeout();
private:
    CmigitsFmqWatcher _fmqWatcher;
};

#endif /* FMQDUMPER_H_ */
