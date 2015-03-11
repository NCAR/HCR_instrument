/*
 * CmigitsFmq.cpp
 *
 *  Created on: Jan 2, 2015
 *      Author: burghart
 */

#include <exception>
#include <sstream>
#include <iostream>
#include <unistd.h>
#include <cmath>
#include <sys/time.h>
#include <QDateTime>
#include "CmigitsFmq.h"
#include <logx/Logging.h>

LOGGING("CmigitsFmq")

const std::string CmigitsFmq::FMQ_URL = "/tmp/cmigits_fmq/shmem_22000";

// All-zero CmigitsFmq::MsgStruct (from the default constructor)
static const CmigitsFmq::MsgStruct ALL_ZERO_MESSAGE = CmigitsFmq::MsgStruct();

inline double DegToRad(double deg) { return(M_PI * deg / 180.0); }
inline double RadToDeg(double rad) { return(180.0 * rad / M_PI); }

CmigitsFmq::CmigitsFmq(bool writeAccess) :
    _fmq(),
    _writeAccess(writeAccess),
    _3500TimeoutTimer(),
    _3501TimeoutTimer(),
    _3512TimeoutTimer(),
    _currentMsg() {
    // Initialize the FMQ over which MsgStruct-s are delivered. As writer, we 
    // need to get access immediately. Readers may fail now, but will try again 
    // on each access attempt until a writer has created the FMQ and the reader
    // can connect.
    if (_writeAccess) {
        // Create the FMQ with write access.
        const int NSLOTS = 1000;    // number of message slots in the FMQ
        if (_fmq.initReadWrite(FMQ_URL.c_str(), "CmigitsFmq",
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
        _3500TimeoutTimer.setInterval(2500);    // allow up to 2.5 s
        _3500TimeoutTimer.setSingleShot(true);
        connect(&_3500TimeoutTimer, SIGNAL(timeout()), this, SLOT(_zero3500Data()));
        
        _3501TimeoutTimer.setInterval(500);     // allow up to 0.5 s
        _3501TimeoutTimer.setSingleShot(true);
        connect(&_3501TimeoutTimer, SIGNAL(timeout()), this, SLOT(_zero3501Data()));
        
        _3512TimeoutTimer.setInterval(500);      // allow up to 0.5 s
        _3512TimeoutTimer.setSingleShot(true);
        connect(&_3512TimeoutTimer, SIGNAL(timeout()), this, SLOT(_zero3512Data()));
    } else {
        _fmqInitializeForRead();
    }
}

CmigitsFmq::~CmigitsFmq() {
    // If we're the writer, finish up with an all-zero message
    if (_writeAccess) {
        _currentMsg = ALL_ZERO_MESSAGE;  // all-zero message
        _writeCurrentMsg();
    }
    _fmq.closeMsgQueue();
}

bool
CmigitsFmq::_fmqInitializeForRead() {
    // Immediate success if the FMQ is already open
    if (_fmq.isOpen()) {
        return(true);
    }
    
    // Try to initialize the FMQ for reading and return the result.
    if (_fmq.initReadOnly(FMQ_URL.c_str(), "CmigitsFmq", false, 
                          Fmq::END, 0) == 0) {
        ILOG << "C-MIGITS FMQ '" << CmigitsFmq::FMQ_URL << "' opened for reading";
    } else {
        DLOG << "No FMQ yet";
    }
    return(_fmq.isOpen());
}

CmigitsFmq::MsgStruct
CmigitsFmq::getLatestMsg() {
    // If we're the writer, just return _currentMsg
    if (_writeAccess) {
        return(_currentMsg);
    }
    
    // Return an empty message if we can't read the FMQ
    if (!_fmqInitializeForRead()) {
        return(ALL_ZERO_MESSAGE);
    }
    
    // Seek to the last entry in the FMQ
    if (_fmq.seek(DsFmq::FMQ_SEEK_LAST) != 0) {
        WLOG << "Error seeking to last CmigitsFmq entry: " << _fmq.getErrStr();
        return(ALL_ZERO_MESSAGE);
    }
    
    // Read the last message
    bool gotOne;
    _fmq.readMsg(&gotOne, -1, 0);
    if (gotOne) {
        int msgLen = _fmq.getMsgLen();
        if (msgLen != sizeof(MsgStruct)) {
            ELOG << "Got " << msgLen << "-byte message when expecting " <<
                    sizeof(MsgStruct) << " bytes";
            return(ALL_ZERO_MESSAGE);
        }
        
        // Cast the FMQ message pointer into a pointer to our MsgStruct type
        const MsgStruct * msg = reinterpret_cast<const MsgStruct*>(_fmq.getMsg());
        
        // We should be getting data at 100 Hz, so latest data should be no
        // older than (10 ms + C-MIGITS data latency). Generate a warning if 
        // the latest message is more than 100 ms old.
        struct timeval tvNow;
        gettimeofday(&tvNow, 0);
        uint64_t nowMs = 1000LL * tvNow.tv_sec + tvNow.tv_usec / 1000;
        uint32_t ageMs = nowMs - msg->time3512;
        if (msg->time3512 != 0 && ageMs > 100) {
            time_t secs = msg->time3512 / 1000;
            uint32_t msecs = msg->time3512 % 1000;
            QDateTime qCmigitsTime = QDateTime::fromTime_t(secs).addMSecs(msecs);
            QDateTime qNow = QDateTime::fromTime_t(tvNow.tv_sec).addMSecs(tvNow.tv_usec / 1000);
            WLOG << "Latest C-MIGITS message has time " << 
                    qCmigitsTime.toString("hh:mm:ss.zzz").toStdString() <<
                    " and current time is " << 
                    qNow.toString("hh:mm:ss.zzz").toStdString() << 
                    " (age " << ageMs << " ms)";
        }
        
        // Return the message
        return(*msg);
    } else {
        WLOG << "CmigitsFmq is empty!";
        return(ALL_ZERO_MESSAGE);
    }
}

pid_t
CmigitsFmq::getWriterPid() {
    return(getLatestMsg().writerPid);
}

void
CmigitsFmq::_setWriterPid(pid_t pid) {
    _currentMsg.writerPid = pid;
    _writeCurrentMsg();
}

void
CmigitsFmq::storeLatest3500Data(uint64_t time3500, uint16_t currentMode,
            bool insAvailable, bool gpsAvailable, bool doingCoarseAlignment,
            uint16_t nSats, uint16_t positionFOM, uint16_t velocityFOM,
            uint16_t headingFOM, uint16_t timeFOM,
            double expectedHPosError, double expectedVPosError,
            double expectedVelocityError) {
    _currentMsg.time3500 = time3500;
    _currentMsg.currentMode = currentMode;
    _currentMsg.insAvailable = insAvailable;
    _currentMsg.gpsAvailable = gpsAvailable;
    _currentMsg.doingCoarseAlignment = doingCoarseAlignment;
    _currentMsg.nSats = nSats;
    _currentMsg.positionFOM = positionFOM;
    _currentMsg.velocityFOM = velocityFOM;
    _currentMsg.headingFOM = headingFOM;
    _currentMsg.timeFOM = timeFOM;
    _currentMsg.hPosError = expectedHPosError;
    _currentMsg.vPosError = expectedVPosError;
    _currentMsg.velocityError = expectedVelocityError;
    _writeCurrentMsg();

    // Time out the new data after a second
    _3500TimeoutTimer.start();
}

void
CmigitsFmq::getLatest3500Data(uint64_t & time3500, uint16_t & currentMode,
            bool & insAvailable, bool & gpsAvailable, bool & doingCoarseAlignment,
            uint16_t & nSats, uint16_t & positionFOM, uint16_t & velocityFOM,
            uint16_t & headingFOM, uint16_t & timeFOM,
            double & expectedHPosError, double & expectedVPosError,
            double & expectedVelocityError) {
    MsgStruct msg = getLatestMsg();
    time3500 = msg.time3500;
    currentMode = msg.currentMode;
    insAvailable = msg.insAvailable;
    gpsAvailable = msg.gpsAvailable;
    doingCoarseAlignment = msg.doingCoarseAlignment;
    nSats = msg.nSats;
    positionFOM = msg.positionFOM;
    velocityFOM = msg.velocityFOM;
    headingFOM = msg.headingFOM;
    timeFOM = msg.timeFOM;
    expectedHPosError = msg.hPosError;
    expectedVPosError = msg.vPosError;
    expectedVelocityError = msg.velocityError;
}

void
CmigitsFmq::storeLatest3501Data(uint64_t time3501, double latitude,
        double longitude, double altitude) {
    _currentMsg.time3501 = time3501;
    _currentMsg.latitude = latitude;
    _currentMsg.longitude = longitude;
    _currentMsg.altitude = altitude;
    _writeCurrentMsg();

    // Time out the new data after a second
    _3501TimeoutTimer.start();
}

void
CmigitsFmq::getLatest3501Data(uint64_t & time3501, double & latitude,
        double & longitude, double & altitude) {
    MsgStruct msg = getLatestMsg();
    time3501 = msg.time3501;
    latitude = msg.latitude;
    longitude = msg.longitude;
    altitude = msg.altitude;
    return;
}

void
CmigitsFmq::storeLatest3512Data(uint64_t time3512, double pitch,
        double roll, double heading, double velNorth, double velEast,
        double velUp) {
    _currentMsg.time3512 = time3512;
    _currentMsg.pitch = pitch;
    _currentMsg.roll = roll;
    _currentMsg.heading = heading;
    _currentMsg.velNorth = velNorth;
    _currentMsg.velEast = velEast;
    _currentMsg.velUp = velUp;
    _writeCurrentMsg();

    // Time out the new data after a second
    _3512TimeoutTimer.start();
}

void
CmigitsFmq::getLatest3512Data(uint64_t & time3512, double & pitch,
        double & roll, double & heading, double & velNorth, double & velEast,
        double & velUp) {
    MsgStruct msg = getLatestMsg();
    time3512 = msg.time3512;
    pitch = msg.pitch;
    roll = msg.roll;
    heading = msg.heading;
    velNorth = msg.velNorth;
    velEast = msg.velEast;
    velUp = msg.velUp;
    return;
}

double
CmigitsFmq::getEstimatedDriftAngle() {
    return(GetEstimatedDriftAngle(getLatestMsg()));
}

double
CmigitsFmq::GetEstimatedDriftAngle(const MsgStruct msg) {
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
CmigitsFmq::_zero3500Data() {
    _currentMsg.time3500 = 0;
    _currentMsg.currentMode = 0;
    _currentMsg.insAvailable = 0;
    _currentMsg.gpsAvailable = 0;
    _currentMsg.doingCoarseAlignment = 0;
    _currentMsg.nSats = 0;
    _currentMsg.positionFOM = 0;
    _currentMsg.velocityFOM = 0;
    _currentMsg.headingFOM = 0;
    _currentMsg.timeFOM = 0;
    _currentMsg.hPosError = 0.0;
    _currentMsg.vPosError = 0.0;
    _currentMsg.velocityError = 0.0;
    _writeCurrentMsg();
}

void
CmigitsFmq::_zero3501Data() {
    _currentMsg.time3501 = 0;
    _currentMsg.latitude = 0.0;
    _currentMsg.longitude = 0.0;
    _currentMsg.altitude = 0.0;
    _currentMsg.velNorth = 0.0;
    _currentMsg.velEast = 0.0;
    _currentMsg.velUp = 0.0;
    _writeCurrentMsg();
}

void
CmigitsFmq::_zero3512Data() {
    _currentMsg.time3512 = 0;
    _currentMsg.pitch = 0.0;
    _currentMsg.roll = 0.0;
    _currentMsg.heading = 0.0;
    _writeCurrentMsg();
}

void
CmigitsFmq::_writeCurrentMsg() {
    if (! _writeAccess) {
        throw(std::runtime_error("Attempt to write shared memory with ReadOnly access"));
    }
    // Log anything with a lag > 100 ms
    struct timeval tvNow;
    gettimeofday(&tvNow, 0);
    uint64_t nowMs = 1000LL * tvNow.tv_sec + tvNow.tv_usec / 1000;
    uint32_t lagMs = nowMs - _currentMsg.time3512;
    if (_currentMsg.time3512 != 0 && lagMs > 100) {
        time_t secs = _currentMsg.time3512 / 1000;
        uint32_t msecs = _currentMsg.time3512 % 1000;
        QDateTime qCmigitsTime = QDateTime::fromTime_t(secs).addMSecs(msecs);
        QDateTime qNow = QDateTime::fromTime_t(tvNow.tv_sec).addMSecs(tvNow.tv_usec / 1000);
        WLOG << "C-MIGITS " << 
                qCmigitsTime.toString("hh:mm:ss.zzz").toStdString() <<
                " arrived " << qNow.toString("hh:mm:ss.zzz").toStdString() << 
                " (lag " << lagMs << " ms)";
    }
    
    _fmq.writeMsg(0, 0, &_currentMsg, sizeof(_currentMsg));
}
