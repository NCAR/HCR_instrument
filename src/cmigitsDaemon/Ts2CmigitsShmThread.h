/*
 * Ts2CmigitsShmThread.h
 *
 *  Created on: Mar 12, 2014
 *      Author: burghart
 */

#ifndef TS2CMIGITSSHMTHREAD_H_
#define TS2CMIGITSSHMTHREAD_H_
#include <CmigitsSharedMemory.h>
#include <vector>
#include <radar/IwrfTsReader.hh>
#include <QThread>
#include <QTimer>

/// @brief This object creates its own thread, and within that thread reads 
/// data from a list of IWRF time series files, extracts the attitude and 
/// position metadata, and writes it into the CmigitsSharedMemory segment at 
/// the same rate it was originally generated. Data written into shared memory 
/// is tagged with current time rather than the time from the data.

class Ts2CmigitsShmThread : public QObject {
    Q_OBJECT
public:
    /// @brief Construct using the given list of IWRF time-series files.
    /// @param fileList a vector containing a list of IWRF time-series files.
    Ts2CmigitsShmThread(std::vector<std::string> fileList);
    virtual ~Ts2CmigitsShmThread();

signals:
    /// @ brief Signal emitted when our work is complete.
    void finished();
    
private slots:
    /// @brief Slot called to perform initialization which must must be executed
    /// in the work thread.
    void _onThreadStart();
    
    /// @brief Slot called to read a pulse and handle it at the correct interval
    /// relative to the previous pulse.
    void _doNextPulse();
    
    /// @brief Generate a fake C-MIGITS 3500 message and push it into the
    /// CmigitsSharedMemory.
    void _generateFake3500Msg();
    
private:
    
    /// @brief Show statistics for reading, writing to shared memory, and
    /// timing.
    void _showStats();

    /// Work thread where the heavy lifting will be done
    QThread _workThread;
    
    /// QTimer controlling generation of fake C-MIGITS 3500 messages
    QTimer * _fake3500Timer;
    
    /// Reader for IWRF time-series files
    IwrfTsReaderFile _reader;

    /// Connection to the C-MIGITS shared memory segment
    CmigitsSharedMemory * _shm;

    /// The last pulse from the reader
    IwrfTsPulse * _pulse;

    /// Count of pulses processed
    int _pulseCount;

    /// Total time slept waiting to deliver pulse data at the correct interval
    int _sleepSumUsecs;

    /// Count of delayed pulses
    int _delayedPulseCount;

    /// Sum of delay time for all delayed pulses
    int _delaySumUsecs;

    /// Data time from previous pulse processed, seconds since 1970-01-01
    /// 00:00:00 UTC
    double _prevPulseDataTime;

    /// Time at which previous pulse was processed, seconds since 1970-01-01
    /// 00:00:00 UTC
    double _prevPulseProcessTime;
};

#endif /* TS2CMIGITSSHMTHREAD_H_ */