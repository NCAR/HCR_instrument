/*
 * CmigitsSharedMemory.cpp
 *
 *  Created on: Dec 19, 2012
 *      Author: burghart
 */

#include <sstream>
#include <iostream>
#include <unistd.h>
#include <cmath>
#include "CmigitsSharedMemory.h"
#include <logx/Logging.h>

LOGGING("CmigitsSharedMemory")

const QString CmigitsSharedMemory::CMIGITS_SHM_KEY("CmigitsSharedMemory");

inline double DegToRad(double deg) { return(M_PI * deg / 180.0); }
inline double RadToDeg(double rad) { return(180.0 * rad / M_PI); }

// Set RECORD_CSV to true to record a CSV text file of all 3500, 3501, and
// 3512 messages
static const bool RECORD_CSV = false;

CmigitsSharedMemory::CmigitsSharedMemory(bool writeAccess) throw(Exception) :
    _qShm(CMIGITS_SHM_KEY),
    _writeAccess(writeAccess),
    _3500TimeoutTimer(),
    _3501TimeoutTimer(),
    _3512TimeoutTimer(),
    _shmContents(0),
    _dataFile(0) {
    // Create and attach to the shared memory segment, which will hold our
    // private type struct _ShmContents
    int segsize = sizeof(struct _ShmContents);
    // Try to create the shared memory segment. Create the segment with
    // read/write access, even if this object will have read-only access.
    if (_qShm.create(segsize, QSharedMemory::ReadWrite)) {
        DLOG << "Created shared memory segment '" << CMIGITS_SHM_KEY.toStdString() << "'";
        _qShm.lock();
        // Zero the segment.
        memset(_qShm.data(), 0, segsize);
        _qShm.unlock();
        // This bit is bogus, but necessary to re-attach ReadOnly if we just
        // created the shared memory segment.
        // Create a temporary QSharedMemory object and attach it to the
        // shared memory segment so that we can detach momentarily and
        // re-attach ReadOnly without the segment being destroyed.
        if (! _writeAccess) {
            QSharedMemory tempShmObj(CMIGITS_SHM_KEY);
            tempShmObj.attach();
            _qShm.detach();           // detach ourselves
            _qShm.attach(QSharedMemory::ReadOnly);   // re-attach with ReadOnly access
        }
    } else {
        // AlreadyExists is OK, anything else is a problem...
        if (_qShm.error() != QSharedMemory::AlreadyExists) {
            std::ostringstream msgStream;
            msgStream << "Shared memory create failed: " << _qShm.errorString().toStdString();
            throw(Exception(msgStream.str()));
        }
    }
    // If we didn't create and attach above, attach to the shared memory with
    // the desired access mode.
    QSharedMemory::AccessMode accessMode = _writeAccess ?
            QSharedMemory::ReadWrite : QSharedMemory::ReadOnly;
    if (! _qShm.isAttached() && ! _qShm.attach(accessMode)) {
        std::ostringstream msgStream;
        msgStream << "Shared memory attach error: " <<
                _qShm.errorString().toStdString() << " (" << _qShm.error() << ")";
        throw(Exception(msgStream.str()));
    }
    // Contents of the shared memory data are defined by our private
    // struct _ShmContents
    if (_qShm.size() != sizeof(struct _ShmContents)) {
        std::ostringstream msgStream;
        msgStream << "Actual shared memory size of " << _qShm.size() <<
                "bytes does not match the expected size of " <<
                sizeof(struct _ShmContents) << " bytes!";
        throw(Exception(msgStream.str()));
    }
    _shmContents = static_cast<struct _ShmContents *>(_qShm.data());
    
    // Special setup for the writer
    if (_writeAccess) {
        // Establish this instance as the writer instance if possible.
        pid_t writerPid = getWriterPid();
        if (writerPid != 0) {
            _qShm.detach();
            std::ostringstream msgStream;
            msgStream << "An object in pid " << writerPid <<
                    " already claims write access to shared memory";
            throw(Exception(msgStream.str()));
        }
        // Set our process id as the writer id
        _setWriterPid(getpid());
        // Set up timeout timers which will clear the shared memory if new
        // data don't arrive within a second
        _3500TimeoutTimer.setInterval(1000);
        _3500TimeoutTimer.setSingleShot(true);
        connect(&_3500TimeoutTimer, SIGNAL(timeout()), this, SLOT(_zero3500Data()));
        
        _3501TimeoutTimer.setInterval(1000);
        _3501TimeoutTimer.setSingleShot(true);
        connect(&_3501TimeoutTimer, SIGNAL(timeout()), this, SLOT(_zero3501Data()));
        
        _3512TimeoutTimer.setInterval(1000);
        _3512TimeoutTimer.setSingleShot(true);
        connect(&_3512TimeoutTimer, SIGNAL(timeout()), this, SLOT(_zero3512Data()));
    }
    if (RECORD_CSV) {
        _dataFile = fopen("/tmp/cmigitsData", "w+");
    }
}

CmigitsSharedMemory::~CmigitsSharedMemory() {
    // If this is the writer, clear the writer PID now
    if (_writeAccess) {
        // Zero the C-MIGITS data in the segment
        _zero3500Data();
        _zero3501Data();
        _zero3512Data();
        // Remove this object as writer (set the writer pid to zero)
        _setWriterPid(0);
    }
    _qShm.detach();
}

pid_t
CmigitsSharedMemory::getWriterPid() const {
    _qShm.lock();
    pid_t writerPid = _shmContents->writerPid;
    _qShm.unlock();
    return(writerPid);
}

void
CmigitsSharedMemory::_setWriterPid(pid_t pid) {
    _qShm.lock();
    _shmContents->writerPid = pid;
    _qShm.unlock();
}

void
CmigitsSharedMemory::storeLatest3500Data(uint64_t time3500, uint16_t currentMode,
            bool insAvailable, bool gpsAvailable, bool doingCoarseAlignment,
            uint16_t nSats, uint16_t positionFOM, uint16_t velocityFOM,
            uint16_t headingFOM, uint16_t timeFOM,
            double expectedHPosError, double expectedVPosError,
            double expectedVelocityError) throw(Exception) {
    if (! _writeAccess) {
        throw(Exception("Attempt to write shared memory with ReadOnly access"));
    }
    _qShm.lock();
    _shmContents->time3500 = time3500;
    _shmContents->currentMode = currentMode;
    _shmContents->insAvailable = insAvailable;
    _shmContents->gpsAvailable = gpsAvailable;
    _shmContents->doingCoarseAlignment = doingCoarseAlignment;
    _shmContents->nSats = nSats;
    _shmContents->positionFOM = positionFOM;
    _shmContents->velocityFOM = velocityFOM;
    _shmContents->headingFOM = headingFOM;
    _shmContents->timeFOM = timeFOM;
    _shmContents->hPosError = expectedHPosError;
    _shmContents->vPosError = expectedVPosError;
    _shmContents->velocityError = expectedVelocityError;
    _qShm.unlock();
    if (RECORD_CSV) {
        fprintf(_dataFile, "3500,%lld,%d,%d,%d,%d,%d,%d,%d,%d,%d,%f,%f,%f\n", 
                time3500, currentMode, insAvailable, gpsAvailable,
                doingCoarseAlignment, nSats, positionFOM, velocityFOM, 
                headingFOM, timeFOM, expectedHPosError, expectedVPosError,
                expectedVelocityError);
    }
    // Time out the new data after a second
    _3500TimeoutTimer.start();
}

void
CmigitsSharedMemory::getLatest3500Data(uint64_t & time3500, uint16_t & currentMode,
            bool & insAvailable, bool & gpsAvailable, bool & doingCoarseAlignment,
            uint16_t & nSats, uint16_t & positionFOM, uint16_t & velocityFOM,
            uint16_t & headingFOM, uint16_t & timeFOM,
            double & expectedHPosError, double & expectedVPosError,
            double & expectedVelocityError) const {
    _qShm.lock();
    time3500 = _shmContents->time3500;
    currentMode = _shmContents->currentMode;
    insAvailable = _shmContents->insAvailable;
    gpsAvailable = _shmContents->gpsAvailable;
    doingCoarseAlignment = _shmContents->doingCoarseAlignment;
    nSats = _shmContents->nSats;
    positionFOM = _shmContents->positionFOM;
    velocityFOM = _shmContents->velocityFOM;
    headingFOM = _shmContents->headingFOM;
    timeFOM = _shmContents->timeFOM;
    expectedHPosError = _shmContents->hPosError;
    expectedVPosError = _shmContents->vPosError;
    expectedVelocityError = _shmContents->velocityError;
    _qShm.unlock();
}

void
CmigitsSharedMemory::storeLatest3501Data(uint64_t time3501, double latitude,
        double longitude, double altitude) throw(Exception) {
    if (! _writeAccess) {
        throw(Exception("Attempt to write shared memory with ReadOnly access"));
    }
    _qShm.lock();
    _shmContents->time3501 = time3501;
    _shmContents->latitude = latitude;
    _shmContents->longitude = longitude;
    _shmContents->altitude = altitude;
    _qShm.unlock();
    if (RECORD_CSV) {
        fprintf(_dataFile, "3501,%lld,%f,%f,%f\n", time3501,
                latitude, longitude, altitude);
    }
    // Time out the new data after a second
    _3501TimeoutTimer.start();
}

void
CmigitsSharedMemory::getLatest3501Data(uint64_t & time3501, double & latitude,
        double & longitude, double & altitude) const {
    _qShm.lock();
    time3501 = _shmContents->time3501;
    latitude = _shmContents->latitude;
    longitude = _shmContents->longitude;
    altitude = _shmContents->altitude;
    _qShm.unlock();
    return;
}

void
CmigitsSharedMemory::storeLatest3512Data(uint64_t time3512, double pitch,
        double roll, double heading, double velNorth, double velEast,
        double velUp) throw(Exception) {
    if (! _writeAccess) {
        throw(Exception("Attempt to write shared memory with ReadOnly access"));
    }
    _qShm.lock();
    _shmContents->time3512 = time3512;
    _shmContents->pitch = pitch;
    _shmContents->roll = roll;
    _shmContents->heading = heading;
    _shmContents->velNorth = velNorth;
    _shmContents->velEast = velEast;
    _shmContents->velUp = velUp;
    _qShm.unlock();
    if (RECORD_CSV) {
        fprintf(_dataFile, "3512,%lld,%f,%f,%f,%f,%f,%f\n", time3512, pitch,
                roll, heading, velNorth, velEast, velUp);
    }
    // Time out the new data after a second
    _3512TimeoutTimer.start();
}

void
CmigitsSharedMemory::getLatest3512Data(uint64_t & time3512, double & pitch,
        double & roll, double & heading, double & velNorth, double & velEast,
        double & velUp) const {
    _qShm.lock();
    time3512 = _shmContents->time3512;
    pitch = _shmContents->pitch;
    roll = _shmContents->roll;
    heading = _shmContents->heading;
    velNorth = _shmContents->velNorth;
    velEast = _shmContents->velEast;
    velUp = _shmContents->velUp;
    _qShm.unlock();
    return;
}

double
CmigitsSharedMemory::getEstimatedDriftAngle() const {
    _qShm.lock();
    double heading = _shmContents->heading;
    double velNorth = _shmContents->velNorth;
    double velEast = _shmContents->velEast;
    _qShm.unlock();

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
CmigitsSharedMemory::_zero3500Data() {
    _qShm.lock();
    _shmContents->time3500 = 0;
    _shmContents->currentMode = 0;
    _shmContents->insAvailable = 0;
    _shmContents->gpsAvailable = 0;
    _shmContents->doingCoarseAlignment = 0;
    _shmContents->nSats = 0;
    _shmContents->positionFOM = 0;
    _shmContents->velocityFOM = 0;
    _shmContents->headingFOM = 0;
    _shmContents->timeFOM = 0;
    _shmContents->hPosError = 0.0;
    _shmContents->vPosError = 0.0;
    _shmContents->velocityError = 0.0;
    _qShm.unlock();
}

void
CmigitsSharedMemory::_zero3501Data() {
    _qShm.lock();
    _shmContents->time3501 = 0;
    _shmContents->latitude = 0.0;
    _shmContents->longitude = 0.0;
    _shmContents->altitude = 0.0;
    _shmContents->velNorth = 0.0;
    _shmContents->velEast = 0.0;
    _shmContents->velUp = 0.0;
    _qShm.unlock();
}

void
CmigitsSharedMemory::_zero3512Data() {
    _qShm.lock();
    _shmContents->time3512 = 0;
    _shmContents->pitch = 0.0;
    _shmContents->roll = 0.0;
    _shmContents->heading = 0.0;
    _qShm.unlock();
}
