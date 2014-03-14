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

/// @brief This QThread reads data from a list of IWRF time series files,
/// extracts the attitude and position metadata, and writes it into the
/// CmigitsSharedMemory segment at the same rate it was originally generated.
/// Data written into shared memory is tagged with current time rather than
/// the time from the data.

class Ts2CmigitsShmThread : public QThread {
    Q_OBJECT
public:
    /// @brief Construct using the given list of IWRF time-series files.
    /// @param fileList a vector containing a list of IWRF time-series files.
    Ts2CmigitsShmThread(std::vector<std::string> fileList);
    virtual ~Ts2CmigitsShmThread();

    void run();

private slots:
    /// @brief Slot called to read a pulse and handle it at the correct interval
    /// relative to the previous pulse.
    void _doNextPulse();

private:
    /// @brief Show statistics for reading, writing to shared memory, and
    /// timing.
    void _showStats();

    /// Reader for IWRF time-series files
    IwrfTsReaderFile _reader;

    /// Connection to the C-MIGITS shared memory segment
    CmigitsSharedMemory _shm;

    /// Timer to control pulse processing rate
    QTimer _processingTimer;

    /// The last pulse from the reader
    IwrfTsPulse * _pulse;

    /// Count of pulses processed
    int _pulseCount;

    /// Count of writes to CmigitsSharedMemory
    int _shmWriteCount;

    /// Total time slept waiting to deliver pulse data at the correct interval
    int _sleepSumUsecs;

    /// Count of delayed pulses
    int _delayedPulseCount;

    /// Sum of delay time for all delayed pulses
    int _delaySumUsecs;

    /// Data time from last pulse processed, seconds since 1970-01-01
    /// 00:00:00 UTC
    double _lastPulseDataTime;

    /// Georef info from the last pulse processed
    iwrf_platform_georef_t _lastPulseGeoref;

    /// Time at which last pulse was processed, seconds since 1970-01-01
    /// 00:00:00 UTC
    double _lastPulseProcessTime;
};

#endif /* TS2CMIGITSSHMTHREAD_H_ */
