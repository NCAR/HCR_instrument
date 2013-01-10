/*
 * CmigitsSharedMemory.cpp
 *
 *  Created on: Dec 19, 2012
 *      Author: burghart
 */

#include <sstream>
#include <iostream>
#include <unistd.h>
#include <cassert>
#include "CmigitsSharedMemory.h"
#include <logx/Logging.h>

LOGGING("CmigitsSharedMemory")

const QString CmigitsSharedMemory::CMIGITS_SHM_KEY("CmigitsSharedMemory");

CmigitsSharedMemory::CmigitsSharedMemory(bool writeAccess) throw(Exception) :
    _qShm(CMIGITS_SHM_KEY),
    _writeAccess(writeAccess),
    _shmContents(0) {
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
    // If write access has been requested, establish this instance as the 
    // writer instance if possible.
    if (_writeAccess) {
        pid_t writerPid = getWriterPid();
        if (writerPid != 0) {
            _qShm.detach();
            std::ostringstream msgStream;
            msgStream << "An object in pid " << writerPid <<
                    " already claims write access to shared memory";
            throw(Exception(msgStream.str()));
        }
        // Set our process id as the writer id
        _qShm.lock();
        _shmContents->writerPid = getpid();
        _qShm.unlock();
    }
}

CmigitsSharedMemory::~CmigitsSharedMemory() {
    // If this is the writer, clear the writer PID now
    if (_writeAccess) {
        // Remove this object as writer (set the writer pid to zero)
        _qShm.lock();
        _shmContents->writerPid = 0;
        _qShm.unlock();
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
CmigitsSharedMemory::setLatestStatus(uint64_t dataTime, uint16_t currentMode,
            bool insAvailable, bool gpsAvailable, uint16_t nSats,
            uint16_t positionFOM, uint16_t velocityFOM,
            uint16_t headingFOM, uint16_t timeFOM,
            float expectedHPosError, float expectedVPosError,
            float expectedVelocityError) throw(Exception) {
    if (! _writeAccess) {
        throw(Exception("Attempt to write shared memory with ReadOnly access"));
    }
    _qShm.lock();
    _shmContents->statusTime = dataTime;
    _shmContents->currentMode = currentMode;
    _shmContents->insAvailable = insAvailable;
    _shmContents->gpsAvailable = gpsAvailable;
    _shmContents->nSats = nSats;
    _shmContents->positionFOM = positionFOM;
    _shmContents->velocityFOM = velocityFOM;
    _shmContents->headingFOM = headingFOM;
    _shmContents->timeFOM = timeFOM;
    _shmContents->hPosError = expectedHPosError;
    _shmContents->vPosError = expectedVPosError;
    _shmContents->velocityError = expectedVelocityError;
    _qShm.unlock();
}

void
CmigitsSharedMemory::getLatestStatus(uint64_t & dataTime, uint16_t & currentMode,
            bool & insAvailable, bool & gpsAvailable, uint16_t & nSats,
            uint16_t & positionFOM, uint16_t & velocityFOM,
            uint16_t & headingFOM, uint16_t & timeFOM,
            float & expectedHPosError, float & expectedVPosError,
            float & expectedVelocityError) const {
    _qShm.lock();
    dataTime = _shmContents->statusTime;
    currentMode = _shmContents->currentMode;
    insAvailable = _shmContents->insAvailable;
    gpsAvailable = _shmContents->gpsAvailable;
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
CmigitsSharedMemory::setLatestNavSolution(uint64_t dataTime, float latitude,
        float longitude, float altitude, float velNorth, float velEast,
        float velUp) throw(Exception) {
    if (! _writeAccess) {
        throw(Exception("Attempt to write shared memory with ReadOnly access"));
    }
    _qShm.lock();
    _shmContents->navSolutionTime = dataTime;
    _shmContents->latitude = latitude;
    _shmContents->longitude = longitude;
    _shmContents->altitude = altitude;
    _shmContents->velNorth = velNorth;
    _shmContents->velEast = velEast;
    _shmContents->velUp = velUp;
    _qShm.unlock();
    return;
}

void
CmigitsSharedMemory::getLatestNavSolution(uint64_t & dataTime, float & latitude,
        float & longitude, float & altitude, float & velNorth, float & velEast,
        float & velUp) const {
    _qShm.lock();
    dataTime = _shmContents->navSolutionTime;
    latitude = _shmContents->latitude;
    longitude = _shmContents->longitude;
    altitude = _shmContents->altitude;
    velNorth = _shmContents->velNorth;
    velEast = _shmContents->velEast;
    velUp = _shmContents->velUp;
    _qShm.unlock();
    return;
}

void
CmigitsSharedMemory::setLatestAttitude(uint64_t dataTime, float pitch,
        float roll, float heading) throw(Exception) {
    if (! _writeAccess) {
        throw(Exception("Attempt to write shared memory with ReadOnly access"));
    }
    _qShm.lock();
    _shmContents->attitudeTime = dataTime;
    _shmContents->pitch = pitch;
    _shmContents->roll = roll;
    _shmContents->heading = heading;
    _qShm.unlock();
    return;
}

void
CmigitsSharedMemory::getLatestAttitude(uint64_t & dataTime, float & pitch,
        float & roll, float & heading) const {
    _qShm.lock();
    dataTime = _shmContents->attitudeTime;
    pitch = _shmContents->pitch;
    roll = _shmContents->roll;
    heading = _shmContents->heading;
    _qShm.unlock();
    return;
}
