/*
 * Copyright (c) 1990-2016, University Corporation for Atmospheric Research
 * All rights reserved.
 *
 * SpatialFogFmqWatcher.h
 *
 *  Created on: Jul 25, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#ifndef SPATIALFOGFMQWATCHER_H_
#define SPATIALFOGFMQWATCHER_H_

#include <QObject>
#include <QThread>
#include <Fmq/DsFmq.hh>
#include "SpatialFogFmq.h"

/// This worker object loops forever reading the SpatialFogFmq and emits 
/// newData() signals when new Spatial FOG INS data are seen. However, if the 
/// minimum data interval is non-zero, the interval between data times in 
/// consecutive newData() signals will be >= the minimum data interval.
class SpatialFogFmqWatcher: public QObject {
    Q_OBJECT
public:
    /// Constructor. 
    /// @param minDataIntervalMs The object will emit newData() signals when
    /// new Spatial FOG data are available, but no more often than this time 
    /// interval, ms.
    /// @param dataTimeoutMs The object will emit a dataTimeout() signal if
    /// the interval since the last new data it saw exceeds this time interval, 
    /// ms.
    SpatialFogFmqWatcher(uint32_t minDataIntervalMs = 0, 
            uint32_t dataTimeoutMs = 250);
    virtual ~SpatialFogFmqWatcher();
    
signals:
    /// @brief Signal emitted if more than _dataTimeoutMs milliseconds pass 
    /// before new data are seen in the FMQ.
    void dataTimeout();
    
    /// @brief Signal emitted when new Spatial FOG data are available, and the
    /// data time is at least the specified minimum data interval later than
    /// the last newData() signal.
    /// @param insData SpatialFogFmq::MsgStruct containing the latest data
    void newData(SpatialFogFmq::MsgStruct insData);
    
private slots:
    void _startWatching();
    
    void _pollFmq();
    
    void _logStatus();
    
private:
    static const std::string FMQ_PATH;
    
    QThread _myThread;              ///< The thread in which this object will 
                                    ///< perform its work
    
    DsFmq _spatialFogFmq;           ///< shared memory FMQ providing Spatial FOG data
    
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

#endif /* SPATIALFOGFMQWATCHER_H_ */

