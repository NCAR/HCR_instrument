/*
 * Ts2CmigitsShmThread.cpp
 *
 *  Created on: Mar 12, 2014
 *      Author: burghart
 */

#include "Ts2CmigitsShmThread.h"
#include <cstring>
#include <iomanip>
#include <logx/Logging.h>

LOGGING("Ts2CmigitsShmThread")

Ts2CmigitsShmThread::Ts2CmigitsShmThread(std::vector<std::string> fileList) :
    QThread(),
    _reader(fileList, IWRF_DEBUG_OFF),
    _shm(true), // open CmigitsSharedMemory with write access
    _processingTimer(),
    _pulseCount(0),
    _shmWriteCount(0),
    _sleepSumUsecs(0),
    _delayedPulseCount(0),
    _delaySumUsecs(0),
    _lastPulseDataTime(0.0),
    _lastPulseProcessTime(0.0) {
    // Fill the last pulse georef with zeros
    memset(&_lastPulseGeoref, 0, sizeof(_lastPulseGeoref));
}

Ts2CmigitsShmThread::~Ts2CmigitsShmThread() {
    quit();
}

void
Ts2CmigitsShmThread::run() {
    // Get the first pulse
    _pulse = _reader.getNextPulse();
    if (! _pulse) {
        return;
    }

    // We use a zero-interval timer to call _doNextPulse() whenever the thread
    // is not otherwise busy.
    _processingTimer.setInterval(0);
    connect(&_processingTimer, SIGNAL(timeout()), this, SLOT(_doNextPulse()));

    // Stop the processing timer when the thread exits
    connect(this, SIGNAL(finished()), &_processingTimer, SLOT(stop()));

    // Start the processing timer
    _processingTimer.start();

    // Start the thread
    exec();

    // Print stats at exit
    _showStats();
}

void
Ts2CmigitsShmThread::_showStats() {
    ILOG << "Processed " << _pulseCount << " pulses, with " <<
            _shmWriteCount << " CmigitsSharedMemory writes";
    ILOG << "Average sleep per pulse " <<
            float(_sleepSumUsecs) / _pulseCount << " us";
    ILOG << _delayedPulseCount << " pulses (" <<
            std::fixed << std::setprecision(2) <<
            100 * (float(_delayedPulseCount) / _pulseCount) <<
            "%) were delayed, with average delay of " <<
            std::setprecision(1) <<
            float(_delaySumUsecs) / _delayedPulseCount << " us";
}

void
Ts2CmigitsShmThread::_doNextPulse() {
    _pulseCount++;
    double pulseDataTime = _pulse->getFTime();

    // If georef updates are not active, there's nothing we can write
    // to CmigitsSharedMemory, so just bail out now.
    if (! _pulse->getGeorefActive()) {
        std::cerr << "No active georef at pulse " << _pulseCount <<
                ", so there's nothing to write to CmigitsSharedMemory!" <<
                std::endl;
        quit();
    }

    struct timespec nowTimeSpec;
    clock_gettime(CLOCK_REALTIME, &nowTimeSpec);
    double nowTime = nowTimeSpec.tv_sec + 1.0e-9 * nowTimeSpec.tv_nsec;

    if (! _lastPulseProcessTime) {
        _lastPulseProcessTime = nowTime;
        _lastPulseDataTime = pulseDataTime;
    }

    // Sleep long enough to get the inter-pulse period right.
    double pulseInterval = pulseDataTime - _lastPulseDataTime;
    static const double MAX_PULSE_INTERVAL = 1.0;
    double pulseProcessTime = _lastPulseProcessTime + pulseInterval;

    if (pulseInterval < 0.0) {
        WLOG << "Pulse time went backwards by " << pulseInterval << " s " <<
                "at pulse " << _pulseCount;
        pulseProcessTime = _lastPulseProcessTime;
    } else if (pulseInterval > MAX_PULSE_INTERVAL) {
        WLOG << pulseInterval << " s gap between pulses collapsed to zero " <<
                "at pulse" << _pulseCount;
        pulseProcessTime = _lastPulseProcessTime;
    } else {
        int sleepTimeUsecs = 1000000 * (pulseProcessTime - nowTime);

        if (sleepTimeUsecs > 0) {
            // Sleep until it's time to deliver this pulse
            _sleepSumUsecs += sleepTimeUsecs;
            QThread::usleep(sleepTimeUsecs);
        } else if (sleepTimeUsecs < 0) {
            // Negative sleep implies we've fallen behind. Keep track of
            // delayed pulses and total delay time.
            _delayedPulseCount++;
            _delaySumUsecs += -sleepTimeUsecs;
        }
    }

    // Keep the processing time for this pulse and its data time
    _lastPulseProcessTime = pulseProcessTime;
    _lastPulseDataTime = pulseDataTime;

    // If any georef data changes, put the data from the pulse into
    // CmigitsSharedMemory
    iwrf_platform_georef_t georef = _pulse->getPlatformGeoref();

    bool doWrite = (georef.pitch_deg != _lastPulseGeoref.pitch_deg)
            || (georef.roll_deg != _lastPulseGeoref.roll_deg)
            || (georef.heading_deg != _lastPulseGeoref.heading_deg)
            || (georef.ns_velocity_mps != _lastPulseGeoref.ns_velocity_mps)
            || (georef.ew_velocity_mps != _lastPulseGeoref.ew_velocity_mps)
            || (georef.vert_velocity_mps != _lastPulseGeoref.vert_velocity_mps);
    _lastPulseGeoref = georef;

    if (doWrite) {
        // Tag the data going to CmigitsSharedMemory with current time
        // rather than the time from the data.
        uint64_t tagMsecsSinceEpoch(1000 * pulseProcessTime);

        _shm.storeLatest3501Data(tagMsecsSinceEpoch,
                georef.latitude, georef.longitude,
                1000.0 * georef.altitude_msl_km);
        _shm.storeLatest3512Data(tagMsecsSinceEpoch,
                georef.pitch_deg, georef.roll_deg, georef.heading_deg,
                georef.ns_velocity_mps, georef.ew_velocity_mps,
                georef.vert_velocity_mps);

        _shmWriteCount++;
    }

    // Delete the pulse
    delete(_pulse);

    // Get the next pulse
    if ((_pulse = _reader.getNextPulse()) == NULL) {
        ILOG << "Hit end of data";
        // Stop this thread
        quit();
        if (! wait(500)) {
            WLOG << "Thread did not finish in 500 ms!";
        }
    }
}
