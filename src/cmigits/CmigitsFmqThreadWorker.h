/*
 * CmigitsFmqThreadWorker.h
 *
 *  Created on: Dec 31, 2014
 *      Author: burghart
 */

#ifndef CMIGITSFMQTHREADWORKER_H_
#define CMIGITSFMQTHREADWORKER_H_

#include <QObject>
#include <Fmq/DsFmq.hh>
#include "CmigitsFmq.h"

/// This worker object loops forever reading the CmigitsFmq and emits 
/// newData() signals when new C-MIGITS data are seen. However, if the 
/// minimum data interval is non-zero, the interval between data times in 
/// consecutive newData() signals will be >= the minimum data interval.
/// If 
class CmigitsFmqThreadWorker: public QObject {
    Q_OBJECT
public:
    /// Constructor. 
    /// @param minDataIntervalMs The object will emit newData() signals when
    /// new C-MIGITS data are available, but no more often than this time 
    /// interval, ms.
    /// @param dataTimeoutMs The object will emit a dataTimeout() signal if
    /// the interval since the last new data it saw exceeds this time interval, 
    /// ms.
    CmigitsFmqThreadWorker(uint32_t minDataIntervalMs = 0, 
            uint32_t dataTimeoutMs = 250);
    virtual ~CmigitsFmqThreadWorker();
    
signals:
    /// @brief Signal emitted if more than _dataTimeoutMs milliseconds pass 
    /// before new data are seen in the FMQ.
    void dataTimeout();
    
    /// @brief Signal emitted when new C-MIGITS data are available, and the
    /// data time is at least the specified minimum data interval later than
    /// the last newData() signal.
    void newData(CmigitsFmq::MsgStruct cmigitsData);
    
private slots:
    void _pollFmq();
    
    void _logStatus();
    
private:
    static const std::string FMQ_PATH;
    DsFmq _cmigitsFmq;              ///< shared memory FMQ providing C-MIGITS data
    
    uint32_t _minDataIntervalMs;    ///< minimum data time interval between 
                                    ///< newData() signals, ms
    
    QTimer _pollTimer;              ///< Zero-interval timer used to call 
                                    ///< _pollFmq() when our parent thread is 
                                    ///< not busy
    
    QTimer _dataTimeoutTimer;       ///< Timer which goes off if data do not
                                    ///< arrive in the specified time interval
    
    QTimer _logTimer;               ///< Timer used to do periodic status logging
    
    uint64_t _lastSignalTime;       ///< Data time tag of the last newData()
                                    ///< signal emitted.
    
    uint32_t _fmqMsgCount;
};

#endif /* CMIGITSFMQTHREADWORKER_H_ */

