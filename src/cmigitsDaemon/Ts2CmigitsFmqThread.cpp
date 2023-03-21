// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2016                                         
// ** University Corporation for Atmospheric Research (UCAR)                 
// ** National Center for Atmospheric Research (NCAR)                        
// ** Boulder, Colorado, USA                                                 
// ** BSD licence applies - redistribution and use in source and binary      
// ** forms, with or without modification, are permitted provided that       
// ** the following conditions are met:                                      
// ** 1) If the software is modified to produce derivative works,            
// ** such modified software should be clearly marked, so as not             
// ** to confuse it with the version available from UCAR.                    
// ** 2) Redistributions of source code must retain the above copyright      
// ** notice, this list of conditions and the following disclaimer.          
// ** 3) Redistributions in binary form must reproduce the above copyright   
// ** notice, this list of conditions and the following disclaimer in the    
// ** documentation and/or other materials provided with the distribution.   
// ** 4) Neither the name of UCAR nor the names of its contributors,         
// ** if any, may be used to endorse or promote products derived from        
// ** this software without specific prior written permission.               
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS  
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED      
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.    
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
/*
 * Ts2CmigitsFmqThread.cpp
 *
 *  Created on: Jan 9, 2015
 *      Author: burghart
 */

#include "Ts2CmigitsFmqThread.h"
#include <HcrSharedResources.h>
#include <cstring>
#include <iomanip>
#include <logx/Logging.h>

LOGGING("Ts2CmigitsFmqThread")

Ts2CmigitsFmqThread::Ts2CmigitsFmqThread(std::vector<std::string> fileList,
        const std::string & fmqUrl) :
    _fileList(fileList),
    _workThread(),
    _fake3500Timer(NULL),
    _reader(NULL),
    _fmq(NULL),
    _pulse(NULL),
    _pulseCount(0),
    _sleepSumUsecs(0),
    _delayedPulseCount(0),
    _delaySumUsecs(0),
    _prevPulseDataTime(0.0),
    _prevPulseProcessTime(0.0) {
    // Get a connection to CmigitsFmq with write access
    _fmq = new CmigitsFmq(fmqUrl, true);
    
    // Change our thread affinity to the work thread.
    moveToThread(&_workThread);

    // Perform initialization which must happen within the work thread on
    // a started() signal from the thread.
    connect(&_workThread, SIGNAL(started()), this, SLOT(_onThreadStart()));
    
    // Start the work thread
    _workThread.start();
}

Ts2CmigitsFmqThread::~Ts2CmigitsFmqThread() {
    // Show our processing statistics
    _showStats();
    
    // Shut down the work thread
    DLOG << "Stopping work thread";
    _workThread.quit();
    if (! _workThread.wait(500)) {
        WLOG << "Work thread did not finish within 500 ms!";
    }
    
    // Clean up dynamically allocated members
    delete(_fmq);
    delete(_fake3500Timer);
}

void
Ts2CmigitsFmqThread::_onThreadStart() {
    // Start the processing...
    _doNextPulse();
}

void
Ts2CmigitsFmqThread::_showStats() {
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
Ts2CmigitsFmqThread::_doNextPulse() {
    // If we have no pulse, instantiate a new reader with our list of
    // files and get the first pulse.
    if (! _pulse) {
        // Delete the previous reader, if any
        if (_reader) {
            delete(_reader);
        }
        
        // Instantiate a reader, using the list of files we were given
        _reader = new IwrfTsReaderFile(_fileList, IWRF_DEBUG_OFF);

        // Get the first pulse
        _pulse = _reader->getNextPulse();
        if (! _pulse) {
            ELOG << "Unable to read first pulse!";
            emit(finished());
            return;
        }
    }
    
    // Increment our count of processed pulses
    _pulseCount++;
    if (! (_pulseCount % 10000)) {
        DLOG << "_doNextPulse running in thread " << 
                QThread::currentThread();
    }

    // Get the pulse time
    double pulseDataTime = _pulse->getFTime();
    
    // If georef updates are not active, there's nothing we can write
    // to CmigitsFmq, so just bail out now.
    if (! _pulse->getGeorefActive()) {
        std::cerr << "No active georef at pulse " << _pulseCount <<
                ", so there's nothing to write to CmigitsFmq!" <<
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
    
    // Test if the integer seconds, tenths of seconds, or hundredths of seconds
    // changed from the last pulse.
    bool secondsChanged = 
            (int64_t(_prevPulseDataTime) % 10) != (int64_t(pulseDataTime) % 10);
    bool tenthsChanged =
            (int64_t(_prevPulseDataTime * 10) % 10) != (int64_t(pulseDataTime * 10) % 10);
    bool hundredthsChanged =
            (int64_t(_prevPulseDataTime * 100) % 10) != (int64_t(pulseDataTime * 100) % 10);

    // Keep the processing time for this pulse and its data time
    _prevPulseProcessTime = pulseProcessTime;
    _prevPulseDataTime = pulseDataTime;

    // Get the georef data (including C-MIGITS data) for this pulse
    iwrf_platform_georef_t georef = _pulse->getPlatformGeoref();

    // Tag the data going to CmigitsFmq with current time
    // rather than the time from the data.
    uint64_t tagMsecsSinceEpoch(1000 * pulseProcessTime);
    
    // 3500 messages go out at 1 Hz, so build and send them when the integer
    // seconds of pulse data time changes.
    if (secondsChanged) {
        // Build a fake 3500 message saying that GPS and INS are available and
        // that the C-MIGITS is in "Air Navigation" mode.
        bool gpsAvailable = true;
        bool insAvailable = true;
        int mode = 7;   // Air Navigation mode
        _fmq->storeLatest3500Data(tagMsecsSinceEpoch, mode, insAvailable, 
                gpsAvailable, false, 0, 0, 0, 0, 0, 0.0, 0.0, 0.0);        
    }
    
    // 3501 messages should go out at 10 Hz, so build and send them when the
    // integer tenths of seconds of pulse data time changes.
    if (tenthsChanged) {
        _fmq->storeLatest3501Data(tagMsecsSinceEpoch,
            georef.latitude, georef.longitude,
            1000.0 * georef.altitude_msl_km);
    }

    // 3512 messages should go out at 100 Hz, so build and send them when the
    // integer hundredths of seconds of pulse data time changes.
    if (hundredthsChanged) {
        _fmq->storeLatest3512Data(tagMsecsSinceEpoch,
            georef.pitch_deg, georef.roll_deg, georef.heading_deg,
            georef.ns_velocity_mps, georef.ew_velocity_mps,
            georef.vert_velocity_mps);
    }

    // Delete the pulse
    delete(_pulse);

    // Try to get the next pulse. If we get one, schedule the next call here,
    // otherwise let the outside world we're done.
    _pulse = _reader->getNextPulse();
    
    // Set a single-shot zero-interval timer to call this method again when
    // the thread is not otherwise busy.
    QTimer::singleShot(0, this, SLOT(_doNextPulse()));
}
