/*
 * Copyright (c) 1990-2016, University Corporation for Atmospheric Research
 * All rights reserved.
 *
 * SpatialFogFmq.cpp
 *
 *  Created on: Jul 21, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#include "SpatialFogFmq.h"

#include <exception>
#include <sstream>
#include <iostream>
#include <unistd.h>
#include <cmath>
#include <sys/time.h>
#include <QDateTime>
#include <logx/Logging.h>

LOGGING("SpatialFogFmq")

const std::string SpatialFogFmq::FMQ_URL = "/tmp/spatialfog_fmq/shmem_22002";

// All-zero SpatialFogFmq::MsgStruct (from the default constructor)
static const SpatialFogFmq::MsgStruct ALL_ZERO_MESSAGE = SpatialFogFmq::MsgStruct();

inline double DegToRad(double deg) { return(M_PI * deg / 180.0); }
inline double RadToDeg(double rad) { return(180.0 * rad / M_PI); }

SpatialFogFmq::SpatialFogFmq(bool writeAccess) :
    _fmq(),
    _writeAccess(writeAccess),
    _statusTimeoutTimer(),
    _positionTimeoutTimer(),
    _attitudeTimeoutTimer(),
    _velocityTimeoutTimer(),
    _currentMsg() {
    // Initialize the FMQ over which MsgStruct-s are delivered. As writer, we 
    // need to get access immediately. Readers may fail now, but will try again 
    // on each access attempt until a writer has created the FMQ and the reader
    // can connect.
    if (_writeAccess) {
        // Create the FMQ with write access.
        const int NSLOTS = 1000;    // number of message slots in the FMQ
        if (_fmq.initReadWrite(FMQ_URL.c_str(), "SpatialFogFmq",
                               false,      // set debug?
                               Fmq::END,   // start position
                               false,      // compression
                               NSLOTS,     // number of message slots
                               NSLOTS * sizeof(MsgStruct),   // buffer size
                               0)         // 0 ms wait -> non-blocking
            ) {
            std::ostringstream msgStream;
            msgStream << "Cannot initialize FMQ '" << FMQ_URL << "': " << 
                    _fmq.getErrStr();
            ELOG << msgStream.str();
            throw(std::runtime_error(msgStream.str()));
        }
        _fmq.setSingleWriter();
        
        // Set our process id as the writer id
        _setWriterPid(getpid());
        
        // Set up timeout timers which will clear pieces of the shared memory
        // if new messages don't arrive within a reasonable span after previous
        // ones. The timers are started/restarted upon arrival of their 
        // associated message types.
        _statusTimeoutTimer.setInterval(2000);    // allow up to 2.0 s
        _statusTimeoutTimer.setSingleShot(true);
        connect(&_statusTimeoutTimer, SIGNAL(timeout()),
                this, SLOT(_zeroStatusData()));
        
        _positionTimeoutTimer.setInterval(2000);     // allow up to 2.0 s
        _positionTimeoutTimer.setSingleShot(true);
        connect(&_positionTimeoutTimer, SIGNAL(timeout()),
                this, SLOT(_zeroPositionData()));
        
        _attitudeTimeoutTimer.setInterval(500);      // allow up to 0.5 s
        _attitudeTimeoutTimer.setSingleShot(true);
        connect(&_attitudeTimeoutTimer, SIGNAL(timeout()),
                this, SLOT(_zeroAttitudeData()));

        _velocityTimeoutTimer.setInterval(1000);      // allow up to 1.0 s
        _velocityTimeoutTimer.setSingleShot(true);
        connect(&_velocityTimeoutTimer, SIGNAL(timeout()),
                this, SLOT(_zeroVelocityData()));
    } else {
        _fmqInitializeForRead();
    }
}

SpatialFogFmq::~SpatialFogFmq() {
    // If we're the writer, finish up with an all-zero message
    if (_writeAccess) {
        _currentMsg = ALL_ZERO_MESSAGE;  // all-zero message
        _writeCurrentMsg();
    }
    _fmq.closeMsgQueue();
}

bool
SpatialFogFmq::_fmqInitializeForRead() {
    // Immediate success if the FMQ is already open
    if (_fmq.isOpen()) {
        return(true);
    }
    
    // Try to initialize the FMQ for reading and return the result.
    if (_fmq.initReadOnly(FMQ_URL.c_str(), "SpatialFogFmq", false,
                          Fmq::END, 0) == 0) {
        ILOG << "Spatial FOG FMQ '" << SpatialFogFmq::FMQ_URL << "' opened for reading";
    } else {
        DLOG << "No FMQ yet";
    }
    return(_fmq.isOpen());
}

SpatialFogFmq::MsgStruct
SpatialFogFmq::getLatestMsg() {
    // If we're the writer, _currentMsg is always the latest
    if (_writeAccess) {
        return(_currentMsg);
    }
    
    // Return an empty message if we can't read the FMQ
    if (!_fmqInitializeForRead()) {
        return(ALL_ZERO_MESSAGE);
    }
        
    // Read until we get the last message in the FMQ. It would be easier to
    // use _fmq.seek(DsFmq::FMQ_SEEK_LAST), but FMQ_SEEK_LAST appears to be
    // broken right now.
    bool gotOne;
    while (_fmq.readMsg(&gotOne, -1, 0) == 0 && gotOne) {
        int msgLen = _fmq.getMsgLen();
        if (msgLen == sizeof(MsgStruct)) {
            // Cast the FMQ message pointer into a pointer to our MsgStruct type, 
            // then save the result in _currentMsg
            _currentMsg = *(reinterpret_cast<const MsgStruct*>(_fmq.getMsg()));
        } else {
            ELOG << "Got " << msgLen << "-byte message when expecting " <<
                    sizeof(MsgStruct) << " bytes";
            _currentMsg = ALL_ZERO_MESSAGE;
        }
    }
    
    // We should be getting data at 100 Hz, so latest data should be no
    // older than (10 ms + Spatial data latency). Generate a warning if
    // the latest message is more than 100 ms old.
    struct timeval tvNow;
    gettimeofday(&tvNow, 0);
    uint64_t nowMs = 1000LL * tvNow.tv_sec + tvNow.tv_usec / 1000;
    int32_t ageMs = nowMs - _currentMsg.attitudeTime;
    if (_currentMsg.attitudeTime != 0 && ageMs > 100) {
        time_t secs = _currentMsg.attitudeTime / 1000;
        uint32_t msecs = _currentMsg.attitudeTime % 1000;
        QDateTime qSpatialTime = QDateTime::fromTime_t(secs).addMSecs(msecs);
        QDateTime qNow = QDateTime::fromTime_t(tvNow.tv_sec).addMSecs(tvNow.tv_usec / 1000);
        WLOG << "Latest Spatial message has time " <<
                qSpatialTime.toString("hh:mm:ss.zzz").toStdString() <<
                " and current time is " << 
                qNow.toString("hh:mm:ss.zzz").toStdString() << 
                " (age " << ageMs << " ms)";
    }
    
    // Return the latest message
    return(_currentMsg);
}

pid_t
SpatialFogFmq::getWriterPid() {
    return(getLatestMsg().writerPid);
}

void
SpatialFogFmq::_setWriterPid(pid_t pid) {
    _currentMsg.writerPid = pid;
    _writeCurrentMsg();
}

void
SpatialFogFmq::storeInsResponsiveness(bool responsive) {
    if (responsive != _currentMsg.insResponsive) {
        _currentMsg.insResponsive = responsive;
        _writeCurrentMsg();
    }
}

void
SpatialFogFmq::storeLatestStatusData(uint64_t statusTime, uint16_t statusBits,
            uint16_t filterBits) {
    _currentMsg.statusTime = statusTime;
    _currentMsg.statusBits = statusBits;
    _currentMsg.filterBits = filterBits;
    _writeCurrentMsg();

    // Restart the status timeout timer
    _statusTimeoutTimer.start();
}

void
SpatialFogFmq::getLatestStatusData(uint64_t & statusTime, uint16_t & statusBits,
            uint16_t & filterBits) {
    MsgStruct msg = getLatestMsg();
    statusTime = msg.statusTime;
    statusBits = msg.statusBits;
    filterBits = msg.filterBits;
}

void
SpatialFogFmq::storeLatestPositionData(uint64_t dataTime, double latitude,
        double longitude, double altitude) {
    _currentMsg.positionTime = dataTime;
    _currentMsg.latitude = latitude;
    _currentMsg.longitude = longitude;
    _currentMsg.altitude = altitude;
    _writeCurrentMsg();

    // Restart the position timeout timer
    _positionTimeoutTimer.start();
}

void
SpatialFogFmq::getLatestPositionData(uint64_t & dataTime, double & latitude,
        double & longitude, double & altitude) {
    MsgStruct msg = getLatestMsg();
    dataTime = msg.positionTime;
    latitude = msg.latitude;
    longitude = msg.longitude;
    altitude = msg.altitude;
    return;
}

void
SpatialFogFmq::storeLatestAttitudeData(uint64_t dataTime, double pitch,
        double roll, double heading) {
    _currentMsg.attitudeTime = dataTime;
    _currentMsg.pitch = pitch;
    _currentMsg.roll = roll;
    _currentMsg.heading = heading;
    _writeCurrentMsg();

    // Restart the attitude timeout timer
    _attitudeTimeoutTimer.start();
}

void
SpatialFogFmq::getLatestAttitudeData(uint64_t & dataTime, double & pitch,
        double & roll, double & heading) {
    MsgStruct msg = getLatestMsg();
    dataTime = msg.attitudeTime;
    pitch = msg.pitch;
    roll = msg.roll;
    heading = msg.heading;
    return;
}

void
SpatialFogFmq::storeLatestVelocityData(uint64_t dataTime, double velNorth,
        double velEast, double velUp) {
    _currentMsg.velTime = dataTime;
    _currentMsg.velNorth = velNorth;
    _currentMsg.velEast = velEast;
    _currentMsg.velUp = velUp;
    _writeCurrentMsg();

    // Restart the velocity timeout timer
    _velocityTimeoutTimer.start();
}

void
SpatialFogFmq::getLatestVelocityData(uint64_t & dataTime, double & velNorth,
        double & velEast, double & velUp) {
    MsgStruct msg = getLatestMsg();
    dataTime = msg.attitudeTime;
    velNorth = msg.velNorth;
    velEast = msg.velEast;
    velUp = msg.velUp;
    return;
}

double
SpatialFogFmq::getEstimatedDriftAngle() {
    return(GetEstimatedDriftAngle(getLatestMsg()));
}

double
SpatialFogFmq::GetEstimatedDriftAngle(const MsgStruct msg) {
    double heading = msg.heading;
    double velNorth = msg.velNorth;
    double velEast = msg.velEast;

    // Drift angle defaults to 0
    double drift = 0.0;

    // Only calculate drift angle if ground velocity is a non-zero value.
    // We (arbitrarily) use 10 m/s as the threshold.
    double groundSpd = sqrt(velNorth * velNorth + velEast * velEast);
    if (groundSpd > 10.0) {
        double groundTrk = 90 - RadToDeg(atan2(velNorth, velEast));
        drift = groundTrk - heading;

        // Normalize to range [-180,180]
        drift = fmodf(drift, 360.0);    // this gets us to range [-360.0,360.0]
        if (drift < -180.0) {
            drift += 360.0;
        } else if (drift > 180.0) {
            drift -= 360.0;
        }
    }

    return(drift);
}

void
SpatialFogFmq::_zeroStatusData() {
    _currentMsg.statusTime = 0;
    _currentMsg.statusBits = 0;
    _currentMsg.filterBits = 0;
    _writeCurrentMsg();
}

void
SpatialFogFmq::_zeroPositionData() {
    _currentMsg.positionTime = 0;
    _currentMsg.latitude = 0.0;
    _currentMsg.longitude = 0.0;
    _currentMsg.altitude = 0.0;
    _writeCurrentMsg();
}

void
SpatialFogFmq::_zeroAttitudeData() {
    _currentMsg.attitudeTime = 0;
    _currentMsg.pitch = 0.0;
    _currentMsg.roll = 0.0;
    _currentMsg.heading = 0.0;
    _writeCurrentMsg();
}

void
SpatialFogFmq::_zeroVelocityData() {
    _currentMsg.velTime = 0;
    _currentMsg.velNorth = 0.0;
    _currentMsg.velEast = 0.0;
    _currentMsg.velUp = 0.0;
    _writeCurrentMsg();
}

void
SpatialFogFmq::_writeCurrentMsg() {
    if (! _writeAccess) {
        throw(std::runtime_error("Attempt to write shared memory with ReadOnly access"));
    }
    // Log anything with a lag < 0 ms or lag > 100 ms
    struct timeval tvNow;
    gettimeofday(&tvNow, 0);
    uint64_t nowMs = 1000LL * tvNow.tv_sec + tvNow.tv_usec / 1000;
    int32_t lagMs = nowMs - _currentMsg.attitudeTime;
    if (_currentMsg.attitudeTime != 0 && (lagMs < 0 || lagMs > 100)) {
        time_t secs = _currentMsg.attitudeTime / 1000;
        uint32_t msecs = _currentMsg.attitudeTime % 1000;
        QDateTime qSpatialTime = QDateTime::fromTime_t(secs).addMSecs(msecs);
        QDateTime qNow = QDateTime::fromTime_t(tvNow.tv_sec).addMSecs(tvNow.tv_usec / 1000);
        WLOG << "Datum for " <<
                qSpatialTime.toString("hh:mm:ss.zzz").toStdString() <<
                " arrived at " << qNow.toString("hh:mm:ss.zzz").toStdString() << 
                " (lag " << lagMs << " ms)";
    }
    
    _fmq.writeMsg(0, 0, &_currentMsg, sizeof(_currentMsg));
}
