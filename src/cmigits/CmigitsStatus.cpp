/*
 * CmigitsStatus.cpp
 *
 *  Created on: Aug 14, 2013
 *      Author: burghart
 */

#include <Archive_xmlrpc_c.h>
#include <logx/Logging.h>
#include "CmigitsStatus.h"

LOGGING("CmigitsStatus")

// Static connection to CmigitsSharedMemory
CmigitsSharedMemory * CmigitsStatus::_Shm = 0;

CmigitsStatus::CmigitsStatus() :
    _statusTime(0.0),
    _currentMode(0),
    _nSats(0),
    _insAvailable(false),
    _gpsAvailable(false),
    _doingCoarseAlignment(false),
    _positionFOM(0),
    _velocityFOM(0),
    _headingFOM(0),
    _timeFOM(0),
    _expectedHPosError(0.0),
    _expectedVPosError(0.0),
    _expectedVelocityError(0.0),
    _navSolutionTime(0.0),
    _latitude(0.0),
    _longitude(0.0),
    _altitude(0.0),
    _velNorth(0.0),
    _velEast(0.0),
    _velUp(0.0),
    _attitudeTime(0.0),
    _pitch(0.0),
    _roll(0.0),
    _heading(0.0) {}

CmigitsStatus::CmigitsStatus(const xmlrpc_c::value_struct & statusDict) {
    // Create an input archiver wrapper around the map from std::string to
    // xmlrpc_c::value, and use serialize() to populate our members from its
    // content.
    std::map<std::string, xmlrpc_c::value> statusMap(statusDict);
    Iarchive_xmlrpc_c iar(statusMap);
    iar >> *this;
}

CmigitsStatus::~CmigitsStatus() {
}

xmlrpc_c::value_struct
CmigitsStatus::toXmlRpcValue() const {
    std::map<std::string, xmlrpc_c::value> statusMap;
    // Clone ourself to a non-const instance. We take as a given that the
    // Oarchive_xmlrpc_c operator<<() will not modify us...
    CmigitsStatus clone(*this);
    // Stuff our content into the statusMap, i.e., _serialize() to an
    // output archiver wrapped around the statusDict.
    Oarchive_xmlrpc_c oar(statusMap);
    oar << clone;
    // Finally, return a value_struct constructed from the map
    return(xmlrpc_c::value_struct(statusMap));
}

CmigitsStatus
CmigitsStatus::StatusFromSharedMemory() {
    CmigitsStatus status;
    
    // If we have no static connection to the shared memory segment, create
    // it now.
    if (! _Shm) {
        _Shm = new CmigitsSharedMemory();
    }
    
    // If a process is writing to CmigitsSharedMemory, get latest status from
    // there. Set our members from the latest 3500, 3501, and 3512 messages
    // from the C-MIGITS.
    if (_Shm->getWriterPid()) {
        uint64_t iTime;
        // Get the latest 3500 message data
        _Shm->getLatest3500Data(iTime, status._currentMode, 
                status._insAvailable, status._gpsAvailable, 
                status._doingCoarseAlignment, status._nSats, 
                status._positionFOM, status._velocityFOM, status._headingFOM, 
                status._timeFOM, status._expectedHPosError,
                status._expectedVPosError, status._expectedVelocityError);
        status._statusTime = 0.001 * iTime;

        // Get the latest 3501 message data
        _Shm->getLatest3501Data(iTime, status._latitude, status._longitude,
                status._altitude);
        status._navSolutionTime = 0.001 * iTime;

        // Get the latest 3512 message data
        _Shm->getLatest3512Data(iTime, status._pitch, status._roll, 
                status._heading, status._velNorth, status._velEast, 
                status._velUp);
        status._attitudeTime = 0.001 * iTime;
    } else {
        // Nobody's writing to the shared memory, so complain and just
        // return the status from the default constructor.
        WLOG << __PRETTY_FUNCTION__ << ": No writer exists for CmigitsSharedMemory -";
        WLOG << "    This method should only be used on the machine " <<
                "running cmigitsDaemon.";

    }
    return(status);
}
