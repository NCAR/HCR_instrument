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
    _workThread(),
    _fake3500Timer(NULL),
    _reader(fileList, IWRF_DEBUG_OFF),
    _shm(NULL),
    _pulseCount(0),
    _sleepSumUsecs(0),
    _delayedPulseCount(0),
    _delaySumUsecs(0),
    _prevPulseDataTime(0.0),
    _prevPulseProcessTime(0.0) {
    // Get a connection to CmigitsSharedMemory with write access
    _shm = new CmigitsSharedMemory(true);
    
    // Change our thread affinity to the work thread.
    moveToThread(&_workThread);

    // Perform initialization which must happen within the work thread on
    // a started() signal from the thread.
    connect(&_workThread, SIGNAL(started()), this, SLOT(_onThreadStart()));
    
    // Start the work thread
    _workThread.start();
}

Ts2CmigitsShmThread::~Ts2CmigitsShmThread() {
    // Show our processing statistics
    _showStats();
    
    // Shut down the work thread
    DLOG << "Stopping work thread";
    _workThread.quit();
    if (! _workThread.wait(500)) {
        WLOG << "Work thread did not finish within 500 ms!";
    }
    
    // Clean up dynamically allocated members
    delete(_shm);
    delete(_fake3500Timer);
}

void
Ts2CmigitsShmThread::_onThreadStart() {
    // Instantiate and start the periodic timer for generating fake 3500 
    // messages. The real C-MIGITS generates them a 1 Hz, so we'll do that, too.
    _fake3500Timer = new QTimer();
    _fake3500Timer->setInterval(1000);   // 1000 ms -> 1 s
    connect(_fake3500Timer, SIGNAL(timeout()), this, SLOT(_generateFake3500Msg()));
    _fake3500Timer->start();

    // We need a pulse before the first call to _doNextPulse().
    _pulse = _reader.getNextPulse();
    if (! _pulse) {
        ELOG << "Unable to read first pulse!";
        exit(1);
    }
    
    // Start the processing...
    _doNextPulse();
}

void
Ts2CmigitsShmThread::_showStats() {
    // Print information about what we processed.
    ILOG << "Processed " << _pulseCount << " pulses, with average sleep of " <<
            float(_sleepSumUsecs) / _pulseCount << " us per pulse";
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

    // Get the georef data (including C-MIGITS data) for this pulse
    iwrf_platform_georef_t georef = _pulse->getPlatformGeoref();

    // Tag the data going to CmigitsSharedMemory with current time
    // rather than the time from the data.
    uint64_t tagMsecsSinceEpoch(1000 * pulseProcessTime);
    
    // Pull out the 3501 and 3512 message data from the iwrf_platform_georef_t
    // and write it all into the shared memory.
    _shm->storeLatest3501Data(tagMsecsSinceEpoch,
            georef.latitude, georef.longitude,
            1000.0 * georef.altitude_msl_km);
    _shm->storeLatest3512Data(tagMsecsSinceEpoch,
            georef.pitch_deg, georef.roll_deg, georef.heading_deg,
            georef.ns_velocity_mps, georef.ew_velocity_mps,
            georef.vert_velocity_mps);

    // Delete the pulse
    delete(_pulse);

    // Try to get the next pulse. If we get one, schedule the next call here,
    // otherwise let the outside world we're done.
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
    // that the C-MIGITS is in "Air Navigation" mode.
    bool gpsAvailable = true;
    bool insAvailable = true;
    int mode = 7;   // Air Navigation mode
    _shm->storeLatest3500Data(tagMsecsSinceEpoch, mode, insAvailable, 
            gpsAvailable, false, 0, 0, 0, 0, 0, 0.0, 0.0, 0.0);
    
}