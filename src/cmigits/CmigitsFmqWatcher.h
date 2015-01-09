/*
 * CmigitsFmqWatcher.h
 *
 *  Created on: Dec 31, 2014
 *      Author: burghart
 */

#ifndef CMIGITSFMQWATCHER_H_
#define CMIGITSFMQWATCHER_H_

#include <QObject>
#include <QThread>
#include <Fmq/DsFmq.hh>
#include "CmigitsFmq.h"

/// This worker object loops forever reading the CmigitsFmq and emits 
/// newData() signals when new C-MIGITS data are seen. However, if the 
/// minimum data interval is non-zero, the interval between data times in 
/// consecutive newData() signals will be >= the minimum data interval.
/// If 
class CmigitsFmqWatcher: public QObject {
    Q_OBJECT
public:
    /// Constructor. 
    /// @param minDataIntervalMs The object will emit newData() signals when
    /// new C-MIGITS data are available, but no more often than this time 
    /// interval, ms.
    /// @param dataTimeoutMs The object will emit a dataTimeout() signal if
    /// the interval since the last new data it saw exceeds this time interval, 
    /// ms.
    CmigitsFmqWatcher(uint32_t minDataIntervalMs = 0, 
            uint32_t dataTimeoutMs = 250);
    virtual ~CmigitsFmqWatcher();
    
signals:
    /// @brief Signal emitted if more than _dataTimeoutMs milliseconds pass 
    /// before new data are seen in the FMQ.
    void dataTimeout();
    
    /// @brief Signal emitted when new C-MIGITS data are available, and the
    /// data time is at least the specified minimum data interval later than
    /// the last newData() signal.
    void newData(CmigitsFmq::MsgStruct cmigitsData);
    
private slots:
    void _startWatching();
    
    void _pollFmq();
    
    void _logStatus();
    
private:
    static const std::string FMQ_PATH;
    
    QThread _myThread;              ///< The thread in which this object will 
                                    ///< perform its work
    
    DsFmq _cmigitsFmq;              ///< shared memory FMQ providing C-MIGITS data
    
    uint32_t _minDataIntervalMs;    ///< minimum data time interval between 
                                    ///< newData() signals, ms
    
    uint32_t _dataTimeoutMs;        ///< a dataTimeout() signal will be emitted 
                                    ///< if no new data are seen for this period,
                                    ///< ms
    
    QTimer * _pollTimer;            ///< Zero-interval timer used to call 
                                    ///< _pollFmq() when our parent thread is 
                                    ///< not busy
    
    QTimer * _dataTimeoutTimer;     ///< Timer which goes off if data do not
                                    ///< arrive in the specified time interval
    
    QTimer * _logTimer;             ///< Timer used to do periodic status logging
    
    uint64_t _lastSignalTime;       ///< Data time tag of the last newData()
                                    ///< signal emitted.
    
    uint32_t _fmqMsgCount;
};

#endif /* CMIGITSFMQTHREADWORKER_H_ */

