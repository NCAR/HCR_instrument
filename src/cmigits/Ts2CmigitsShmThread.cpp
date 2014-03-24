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
    _workThread(this),
    _fake3500Timer(),
    _reader(fileList, IWRF_DEBUG_OFF),
    _shm(true), // open CmigitsSharedMemory with write access
    _pulseCount(0),
    _shmWriteCount(0),
    _sleepSumUsecs(0),
    _delayedPulseCount(0),
    _delaySumUsecs(0),
    _prevPulseDataTime(0.0),
    _prevPulseProcessTime(0.0) {
    // Change our thread affinity to the work thread.
    moveToThread(&_workThread);

    // Fill the previous pulse georef with zeros
    memset(&_prevPulseGeoref, 0, sizeof(_prevPulseGeoref));

    // Read a pulse before the first call to _doNextPulse().
    _pulse = _reader.getNextPulse();
    if (! _pulse) {
        ELOG << "Unable to read first pulse!";
        exit(1);
    }
    
    // Execute _doNextPulse() when the worker thread starts
    connect(&_workThread, SIGNAL(started()), this, SLOT(_doNextPulse()));
    
    // Execute _onThreadExit() and perform cleanup via deleteLater() when
    // the work thread is finished.
    connect(&_workThread, SIGNAL(finished()), this, SLOT(deleteLater()));
    
    // Start up the periodic timer for generating fake 3500 messages. The
    // real C-MIGITS generates them a 1 Hz, so we'll do that, too.
    _fake3500Timer.setInterval(1000);   // 1000 ms -> 1 s
    connect(&_fake3500Timer, SIGNAL(timeout()), this, SLOT(_generateFake3500Msg()));
    _fake3500Timer.start();
}

Ts2CmigitsShmThread::~Ts2CmigitsShmThread() {
    // Show our processing statistics
    _showStats();
    
    // Shut down the work thread
    if (_workThread.isRunning()) {
        DLOG << "Stopping work thread";
        _workThread.quit();
        if (! _workThread.wait(500)) {
            WLOG << "Work thread not finished after 500 ms!";
        }
    } else {
        DLOG << "Work thread is already stopped";
    }
}

void
Ts2CmigitsShmThread::start() {
    _workThread.start();
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
    // Increment our count of processed pulses
    _pulseCount++;
    if (! (_pulseCount % 10000)) {
        DLOG << "_doNextPulse running in thread " << 
                QThread::currentThread();
    }

    // Get the pulse time
    double pulseDataTime = _pulse->getFTime();
    
    // If georef updates are not active, there's nothing we can write
    // to CmigitsSharedMemory, so just bail out now.
    if (! _pulse->getGeorefActive()) {
        std::cerr << "No active georef at pulse " << _pulseCount <<
                ", so there's nothing to write to CmigitsSharedMemory!" <<
                std::endl;
        emit(finished());
        return;
    }

    struct timespec nowTimeSpec;
    clock_gettime(CLOCK_REALTIME, &nowTimeSpec);
    double nowTime = nowTimeSpec.tv_sec + 1.0e-9 * nowTimeSpec.tv_nsec;

    if (! _prevPulseProcessTime) {
        _prevPulseProcessTime = nowTime;
        _prevPulseDataTime = pulseDataTime;
    }

    // Sleep long enough to get the inter-pulse period right.
    double pulseInterval = pulseDataTime - _prevPulseDataTime;
    static const double MAX_PULSE_INTERVAL = 1.0;
    double pulseProcessTime = _prevPulseProcessTime + pulseInterval;

    if (pulseInterval < 0.0) {
        WLOG << "Pulse time went backwards by " << pulseInterval << " s " <<
                "at pulse " << _pulseCount;
        pulseProcessTime = _prevPulseProcessTime;
    } else if (pulseInterval > MAX_PULSE_INTERVAL) {
        WLOG << pulseInterval << " s gap between pulses collapsed to zero " <<
                "at pulse" << _pulseCount;
        pulseProcessTime = _prevPulseProcessTime;
    } else {
        int sleepTimeUsecs = 1000000 * (pulseProcessTime - nowTime);

        if (sleepTimeUsecs > 0) {
            // Sleep until it's time to deliver this pulse
            _sleepSumUsecs += sleepTimeUsecs;
            usleep(sleepTimeUsecs);
        } else if (sleepTimeUsecs < 0) {
            // Negative sleep implies we've fallen behind. Keep track of
            // delayed pulses and total delay time.
            _delayedPulseCount++;
            _delaySumUsecs += -sleepTimeUsecs;
        }
    }

    // Keep the processing time for this pulse and its data time
    _prevPulseProcessTime = pulseProcessTime;
    _prevPulseDataTime = pulseDataTime;

    // If any georef data changes, put the data from the pulse into
    // CmigitsSharedMemory
    iwrf_platform_georef_t georef = _pulse->getPlatformGeoref();

    bool doWrite = (georef.pitch_deg != _prevPulseGeoref.pitch_deg)
            || (georef.roll_deg != _prevPulseGeoref.roll_deg)
            || (georef.heading_deg != _prevPulseGeoref.heading_deg)
            || (georef.ns_velocity_mps != _prevPulseGeoref.ns_velocity_mps)
            || (georef.ew_velocity_mps != _prevPulseGeoref.ew_velocity_mps)
            || (georef.vert_velocity_mps != _prevPulseGeoref.vert_velocity_mps);
    _prevPulseGeoref = georef;

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
        // Out of data. We're done!
        emit(finished());
    } else {
        // Set a single-shot zero-interval timer to call this method again when
        // the thread is not otherwise busy.
        QTimer::singleShot(0, this, SLOT(_doNextPulse()));
    }
}

void
Ts2CmigitsShmThread::_generateFake3500Msg() {
    DLOG << "_generateFake3500Msg()";
    
    // Tag the data going to CmigitsSharedMemory with current time
    struct timespec nowTimeSpec;
    clock_gettime(CLOCK_REALTIME, &nowTimeSpec);
    double nowTime = nowTimeSpec.tv_sec + 1.0e-9 * nowTimeSpec.tv_nsec;
    uint64_t tagMsecsSinceEpoch(1000 * nowTime);
    
    // Build a fake 3500 message saying that GPS and INS are available and
    // using our own special mode 10 to indicate data playback.
    bool gpsAvailable = true;
    bool insAvailable = true;
    int mode = 10;
    _shm.storeLatest3500Data(tagMsecsSinceEpoch, mode, insAvailable, 
            gpsAvailable, false, 0, 0, 0, 0, 0, 0.0, 0.0, 0.0);
    
}
