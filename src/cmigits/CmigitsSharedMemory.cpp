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

const QString CmigitsSharedMemory::CMIGITS_SHM_KEY("CmigitsSharedMemory");

CmigitsSharedMemory::CmigitsSharedMemory(AccessMode mode) throw(Exception) :
    QSharedMemory(CMIGITS_SHM_KEY),
    _mode(mode),
    _shmContents(0) {
    // Create and attach to the shared memory segment, which will hold our
    // private type struct _ShmContents
    int segsize = sizeof(struct _ShmContents);
    // Try to create the shared memory segment
    if (create(segsize, ReadWrite)) {
        std::cout << "Created shared memory segment '" << CMIGITS_SHM_KEY.toStdString() << "'" << std::endl;
        lock();
        // Zero the segment.
        memset(data(), 0, segsize);
        unlock();
        // This bit is bogus, but necessary to re-attach ReadOnly if we just
        // created the shared memory segment.
        // Create a temporary QSharedMemory object and attach it to the
        // shared memory segment so that we can detach momentarily and
        // re-attach ReadOnly without the segment being destroyed.
        if (_mode == ReadOnly) {
            QSharedMemory tempShmObj(CMIGITS_SHM_KEY);
            tempShmObj.attach();
            detach();           // detach ourselves
            attach(ReadOnly);   // re-attach with ReadOnly access
        }
    } else {
        // Anything other than AlreadyExists is a problem...
        if (error() != AlreadyExists) {
            std::ostringstream msgStream;
            msgStream << "Shared memory create failed: " << errorString().toStdString();
            throw(Exception(msgStream.str()));
        }
    }
    // If we didn't create and attach above, attach to the shared memory with
    // the desired access mode.
    if (! isAttached() && ! attach(_mode)) {
        std::ostringstream msgStream;
        msgStream << "Shared memory attach error: " <<
                errorString().toStdString() << " (" << error() << ")";
        throw(Exception(msgStream.str()));
    }
    // Contents of the shared memory data are defined by our private
    // struct _ShmContents
    if (size() != sizeof(struct _ShmContents)) {
        std::ostringstream msgStream;
        msgStream << "Actual shared memory size of " << size() <<
                "bytes does not match the expected size of " <<
                sizeof(struct _ShmContents) << " bytes!";
        throw(Exception(msgStream.str()));
    }
    _shmContents = static_cast<struct _ShmContents *>(data());
    // If write access has been requested, verify that there is not a
    // writer already.
    if (_mode == ReadWrite) {
        pid_t writerPid = getWriterPid();
        if (writerPid != 0) {
            detach();
            std::ostringstream msgStream;
            msgStream << "An object in pid " << writerPid <<
                    " already claims write access to shared memory";
            throw(Exception(msgStream.str()));
        }
        // Set our process id as the writer id
        lock();
        _shmContents->writerPid = getpid();
        unlock();
    }
}

CmigitsSharedMemory::~CmigitsSharedMemory() {
    // If this is the writer, clear the writer PID now
    if (_mode == ReadWrite) {
        // Remove this object as writer (set the writer pid to zero)
        lock();
        _shmContents->writerPid = 0;
        unlock();
    }
    detach();
}

pid_t
CmigitsSharedMemory::getWriterPid() {
    lock();
    pid_t writerPid = _shmContents->writerPid;
    unlock();
    return(writerPid);
}

void
CmigitsSharedMemory::setLatestStatus(int64_t dataTime, uint16_t currentMode,
            bool insAvailable, bool gpsAvailable, uint16_t positionFOM,
            uint16_t velocityFOM, uint16_t headingFOM, uint16_t timeFOM,
            float expectedHPosError, float expectedVPosError,
            float expectedVelocityError) throw(Exception) {
    if (_mode != ReadWrite) {
        throw(Exception("Attempt to write shared memory with ReadOnly access"));
    }
    lock();
    _shmContents->statusTime = dataTime;
    _shmContents->currentMode = currentMode;
    _shmContents->insAvailable = insAvailable;
    _shmContents->gpsAvailable = gpsAvailable;
    _shmContents->positionFOM = positionFOM;
    _shmContents->velocityFOM = velocityFOM;
    _shmContents->headingFOM = headingFOM;
    _shmContents->timeFOM = timeFOM;
    _shmContents->hPosError = expectedHPosError;
    _shmContents->vPosError = expectedVPosError;
    _shmContents->velocityError = expectedVelocityError;
    unlock();
}

void
CmigitsSharedMemory::getLatestStatus(int64_t & dataTime, uint16_t & currentMode,
            bool & insAvailable, bool & gpsAvailable, uint16_t & positionFOM,
            uint16_t & velocityFOM, uint16_t & headingFOM, uint16_t & timeFOM,
            float & expectedHPosError, float & expectedVPosError,
            float & expectedVelocityError) {
    lock();
    dataTime = _shmContents->statusTime;
    currentMode = _shmContents->currentMode;
    insAvailable = _shmContents->insAvailable;
    gpsAvailable = _shmContents->gpsAvailable;
    positionFOM = _shmContents->positionFOM;
    velocityFOM = _shmContents->velocityFOM;
    headingFOM = _shmContents->headingFOM;
    timeFOM = _shmContents->timeFOM;
    expectedHPosError = _shmContents->hPosError;
    expectedVPosError = _shmContents->vPosError;
    expectedVelocityError = _shmContents->velocityError;
    unlock();
}

void
CmigitsSharedMemory::setLatestNavSolution(int64_t dataTime, float latitude,
        float longitude, float altitude, float velNorth, float velEast,
        float velUp) throw(Exception) {
    if (_mode != ReadWrite) {
        throw(Exception("Attempt to write shared memory with ReadOnly access"));
    }
    lock();
    _shmContents->navSolutionTime = dataTime;
    _shmContents->latitude = latitude;
    _shmContents->longitude = longitude;
    _shmContents->altitude = altitude;
    _shmContents->velNorth = velNorth;
    _shmContents->velEast = velEast;
    _shmContents->velUp = velUp;
    unlock();
    return;
}

void
CmigitsSharedMemory::getLatestNavSolution(int64_t & dataTime, float & latitude,
        float & longitude, float & altitude, float & velNorth, float & velEast,
        float & velUp) {
    lock();
    dataTime = _shmContents->navSolutionTime;
    latitude = _shmContents->latitude;
    longitude = _shmContents->longitude;
    altitude = _shmContents->altitude;
    velNorth = _shmContents->velNorth;
    velEast = _shmContents->velEast;
    velUp = _shmContents->velUp;
    unlock();
    return;
}

void
CmigitsSharedMemory::setLatestAttitude(int64_t dataTime, float pitch,
        float roll, float heading) throw(Exception) {
    if (_mode != ReadWrite) {
        throw(Exception("Attempt to write shared memory with ReadOnly access"));
    }
    lock();
    _shmContents->attitudeTime = dataTime;
    _shmContents->pitch = pitch;
    _shmContents->roll = roll;
    _shmContents->heading = heading;
    unlock();
    return;
}

void
CmigitsSharedMemory::getLatestAttitude(int64_t & dataTime, float & pitch,
        float & roll, float & heading) {
    lock();
    dataTime = _shmContents->attitudeTime;
    pitch = _shmContents->pitch;
    roll = _shmContents->roll;
    heading = _shmContents->heading;
    unlock();
    return;
}
