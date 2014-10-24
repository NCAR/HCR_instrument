/*
 * TransmitControl.cpp
 *
 *  Created on: Oct 10, 2014
 *      Author: burghart
 */

#include "TransmitControl.h"

#include <iomanip>
#include <limits>
#include <sstream>

#include <logx/Logging.h>
#include <HcrPmc730StatusThread.h>

LOGGING("TransmitControl")

// Convert pressure in hPa to PSI
static inline double HpaToPsi(double pres_hpa) {
    return(0.0145037738 * pres_hpa);
}

// TerrainHtServer XML-RPC URL
const std::string TERRAIN_HT_SERVER_URL = "http://archiver:9090/RPC2";


TransmitControl::TransmitControl(HcrPmc730StatusThread & hcrPmc730StatusThread,
        MotionControlStatusThread & mcStatusThread) :
    _xmlrpcClient(),
    _hcrPmc730Responsive(false),
    _hcrPmc730Status(true),
    _motionControlResponsive(false),
    _motionControlStatus(),
    _cmigitsWatchThread(_CMIGITS_POLL_INTERVAL_MS, _CMIGITS_DATA_TIMEOUT_MS),
    _cmigitsResponsive(false),
    _terrainHtServerResponsive(false),
    _aglAltitude(0.0),
    _overWater(false),
    _hvRequested(false),
    _noXmitReason(NOXMIT_UNSPECIFIED)
{
    // Call _updateHcrPmc730Status when new status from HcrPmc730Daemon arrives
    connect(&hcrPmc730StatusThread, SIGNAL(newStatus(HcrPmc730Status)),
            this, SLOT(_updateHcrPmc730Status(HcrPmc730Status)));
    
    // Call _updateHcrPmc730Responsive when we get a responsiveness change signal
    connect(&hcrPmc730StatusThread, SIGNAL(serverResponsive(bool, QString)),
            this, SLOT(_updateHcrPmc730Responsive(bool, QString)));
    
    // Call _updateMotionControlStatus when new status from MotionControlDaemon 
    // arrives
    connect(&mcStatusThread, SIGNAL(newStatus(MotionControl::Status)),
            this, SLOT(_updateMotionControlStatus(MotionControl::Status)));
    
    // Call _setMotionControlResponding when we get a responsiveness change signal
    connect(&mcStatusThread, SIGNAL(serverResponsive(bool, QString)),
            this, SLOT(_updateMotionControlResponsive(bool, QString)));
    
    // Call _updateCmigitsData when we get new C-MIGITS data
    connect(&_cmigitsWatchThread, SIGNAL(newData(CmigitsSharedMemory::ShmStruct)),
            this, SLOT(_updateAglAltitude(CmigitsSharedMemory::ShmStruct)));
    
    // Mark cmigitsDaemon as unresponsive when the watch thread emits its
    // dataTimeout() signal.
    connect(&_cmigitsWatchThread, SIGNAL(dataTimeout()),
            this, SLOT(_markCmigitsUnresponsive()));
    
    // Start the CmigitsShmWatchThread
    _cmigitsWatchThread.start();
    
    // Finally, do our checks
    _handleNewStatus();
}

TransmitControl::~TransmitControl() {
    _cmigitsWatchThread.quit();
}

void
TransmitControl::_updateHcrPmc730Status(HcrPmc730Status status) {
    _hcrPmc730Status = status;
    _handleNewStatus();
}

void
TransmitControl::_updateHcrPmc730Responsive(bool responding, QString msg) {
    _hcrPmc730Responsive = responding;
    if (_hcrPmc730Responsive) {
        ILOG << "Got a response from HcrPmc730Daemon";
    } else {
        WLOG << "HcrPmc730Daemon is not responding: " << msg.toStdString();
    }
    // Redo the monitoring tests
    _handleNewStatus();
}

void
TransmitControl::_updateMotionControlStatus(MotionControl::Status status) {
    _motionControlStatus = status;
    _handleNewStatus();
}

void
TransmitControl::_updateMotionControlResponsive(bool responding, QString msg) {
    _motionControlResponsive = responding;
    if (_motionControlResponsive) {
        ILOG << "Got a response from MotionControlDaemon";
    } else {
        WLOG << "MotionControlDaemon is not responding: " << msg.toStdString();
    }
    // Redo the monitoring tests
    _handleNewStatus();
}

void
TransmitControl::_markCmigitsUnresponsive() {
    _cmigitsResponsive = false;
    _handleNewStatus();
}

TransmitControl::NoXmitReasonCode
TransmitControl::_testIfTransmitIsAllowed() {
    if (! _hcrPmc730Responsive) {
        return(NOXMIT_NO_HCRPMC730_DATA);
    }
    
    if (! _cmigitsResponsive) {
        return(NOXMIT_NO_CMIGITS_DATA);
    }
    
    if (! _terrainHtServerResponsive) {
        return(NOXMIT_NO_TERRAINHTSERVER_DATA);
    }
    
    if (! _motionControlResponsive) {
        return(NOXMIT_NO_MOTIONCONTROL_DATA);
    }
    
    // Convert pressure vessel pressure from hPa to PSI and test if it 
    // does not meet our minimum pressure criterion.
    double pvPressurePsi = HpaToPsi(_hcrPmc730Status.pvForePressure());
    if (pvPressurePsi < _PV_MINIMUM_PRESSURE_PSI) {
        return(NOXMIT_PV_PRESSURE_LOW);
    }
    
    // No transmit allowed if altitude is below _XMIT_NONZENITH_AGL_LIMIT and 
    // not scanning/pointing near zenith.
    if (_aglAltitude < _XMIT_NONZENITH_AGL_LIMIT && ! _allNearZenithPointing()) {
        return(NOXMIT_TOO_LOW_FOR_NONZENITH);
    }

    // Test for AGL altitude below our nadir limit if we're nadir pointing
    if (_anyNearNadirPointing() && _aglAltitude < _xmitNadirAglMinimum()) {
        return(NOXMIT_TOO_LOW_FOR_NADIR_POINTING);
    }
    
    // All tests passed, transmit is allowed!
    return(XMIT_ALLOWED);
}

std::string
TransmitControl::_noXmitReasonText() {
    std::ostringstream oss;
    switch (_noXmitReason) {
    case XMIT_ALLOWED:
        return("Transmit allowed: All tests passed");
    case NOXMIT_NO_HCRPMC730_DATA:
        return("Transmit not allowed: No data from HcrPmc730Daemon");
    case NOXMIT_NO_CMIGITS_DATA:
        return("Transmit not allowed: No data from cmigitsDaemon");
    case NOXMIT_NO_TERRAINHTSERVER_DATA:
        return("Transmit not allowed: TerrainHtServer not responding or returned an error");
    case NOXMIT_NO_MOTIONCONTROL_DATA:
        return("Transmit not allowed: No data from MotionControlDaemon");
    case NOXMIT_PV_PRESSURE_LOW:
        oss << "Transmit not allowed: PV pressure is below minimum " <<
            "operating pressure of " << _PV_MINIMUM_PRESSURE_PSI << " PSI";
        return(oss.str());
    case NOXMIT_TOO_LOW_FOR_NONZENITH:
        oss << "Transmit not allowed: Non-zenith pointing/scanning and AGL " <<
                "altitude < " << _XMIT_NONZENITH_AGL_LIMIT << " m";
        return(oss.str());
    case NOXMIT_TOO_LOW_FOR_NADIR_POINTING:
        oss << "Transmit not allowed: Near-nadir pointing/scanning and AGL " << 
            "altitude over " << (_overWater ? "water" : "land") << " < " << 
            _xmitNadirAglMinimum() << " m";
        return(oss.str());
    default:
        std::ostringstream oss;
        oss << "Oops, no text for NoXmitReasonCode " << _noXmitReason;
        return(oss.str());
    }
}

bool
TransmitControl::_testIfAttenuationIsRequired(std::string & msg) {
    int attenuatedNadirAglLimit = _overWater ?
            _ATTENUATED_NADIR_AGL_LIMIT_WATER : _ATTENUATED_NADIR_AGL_LIMIT_LAND;
    if (_anyNearNadirPointing() && _aglAltitude < attenuatedNadirAglLimit) {
        std::ostringstream oss;
        oss << "Attenuated receive required: " <<
                "Near-nadir pointing/scanning and AGL altitude over " << 
                (_overWater ? "water" : "land") << " < " << 
                attenuatedNadirAglLimit << " m";
        msg = oss.str();
        return(true);
    } else {
        msg = "Attenuated receive mode is not required";
        return(false);
    }
}

void
TransmitControl::_handleNewStatus() {
    // Test if transmit is currently allowed
    NoXmitReasonCode noXmitReason = _testIfTransmitIsAllowed();
    
    if (noXmitReason != _noXmitReason) {
        _noXmitReason = noXmitReason;
        ILOG << _noXmitReasonText();
    }
    
    // Test if attenuated receive is required
    std::string msg;
    bool attenuate = _testIfAttenuationIsRequired(msg);
    if (attenuate != _attenuate) {
        _attenuate = attenuate;
        ILOG << msg;
    }
    
    // Turn on HV if it's requested and allowed, otherwise turn it off
    if (_hvRequested && _noXmitReason == XMIT_ALLOWED) {
        // If we need to attenuate received signal, set that up before we 
        // turn on high voltage
        if (_attenuate) {
            // TODO: actually attenuate receive here!
            WLOG << "IMPLEMENTATION FOR ATTENUATED MODE IS NEEDED!";
        }
        // TODO: actually enable HV here!
        WLOG << "IMPLEMENTATION FOR HV ENABLE IS NEEDED";
    } else {
        // TODO: turn off HV here!
        WLOG << "IMPLEMENTATION FOR HV DISABLE IS NEEDED";
    }
}

void
TransmitControl::_updateAglAltitude(CmigitsSharedMemory::ShmStruct cmigitsData) {
    if (! _cmigitsResponsive) {
        ILOG << "Got a response from cmigitsDaemon";
        _cmigitsResponsive = true;
    }
    
    // Get instrument latitude, longitude, and MSL altitude from the 
    // C-MIGITS data
    double latitude = cmigitsData.latitude;
    double longitude = cmigitsData.longitude;
    double altitudeMSL = cmigitsData.altitude;
    
    DLOG << cmigitsData.time3501 << ", lat: " << latitude << 
            ", lon: " << longitude << ", altMSL: " << altitudeMSL;

    // Get terrain information from TerrainHtServer using current location and
    // calculate AGL altitude.
    // We do this within a "do {...} while(false);" block so that we can 
    // bail out quickly if necessary using "break" to get to the finishing 
    // code after the block.
    do {
        xmlrpc_c::value result;
        try {
            _xmlrpcClient.call(TERRAIN_HT_SERVER_URL, "get.height", "dd", 
                    &result, latitude, longitude); 
            _terrainHtServerResponsive = true;
        } catch (std::exception & e) {
            WLOG << "Error on TerrainHtServer get.height() call: " << e.what();
            // Disable transmit, since we can't determine AGL altitude
            _terrainHtServerResponsive = false;
            break;
        }

        // The value returned should be a dictionary
        std::map<std::string, xmlrpc_c::value> dict =
                static_cast<std::map<std::string, xmlrpc_c::value> >(xmlrpc_c::value_struct(result));

        // First see if TerrainHtServer reported an error
        if (xmlrpc_c::value_boolean(dict["isError"])) {
            WLOG << std::fixed << std::setprecision(4) << 
                    "TerrainHtServer returned an error for lat " << latitude << 
                    "/lon " << longitude;
            // Disable transmit, since we can't determine AGL altitude
            _terrainHtServerResponsive = false;
            break;
        }

        // Get the surface altitude above MSL then calculate aircraft altitude AGL
        double surfaceAltMSL = xmlrpc_c::value_double(dict["heightM"]);
        _aglAltitude = altitudeMSL - surfaceAltMSL;

        // Over land or water?
        _overWater = xmlrpc_c::value_boolean(dict["isWater"]);

        // Log what we got
        DLOG << "Sensor height AGL " << _aglAltitude << " m (over " << 
                (_overWater ? "water" : "land") << ")";
    } while (false);    // do exactly once

    // Do checks using new state
    _handleNewStatus();
}

double
TransmitControl::_ArcsOverlap(double ccwLimit1, double cwLimit1, 
        double ccwLimit2, double cwLimit2) {
    // Normalize all endpoints relative to the ccw side of the first arc
    double a = _NormalizeAngle(ccwLimit1);
    double b = _NormalizeAngle(cwLimit1 - a);
    double c = _NormalizeAngle(ccwLimit2 - a);
    double d = _NormalizeAngle(cwLimit2 - a);
    // Now it's a (mathematically) simple test...
    return((b >= c) || (d < c));
}

double
TransmitControl::_ArcContainsArc(double ccwLimit1, double cwLimit1, 
        double ccwLimit2, double cwLimit2) {
    // Normalize all endpoints relative to the ccw side of the first arc
    double a = _NormalizeAngle(ccwLimit1);
    double b = _NormalizeAngle(cwLimit1 - a);
    double c = _NormalizeAngle(ccwLimit2 - a);
    double d = _NormalizeAngle(cwLimit2 - a);
    // Now it's a (mathematically) simple test...
    return((b >= d) && (d >= c));
}

bool
TransmitControl::_anyNearNadirPointing() {
    // For pointing, return true if the pointing angle is contained in the arc 
    // defining "near-nadir". 
    //
    // For scanning, return true if the scanning arc overlaps the arc defining 
    // "near-nadir".
    //
    // We cheat and only look at the rotation angle, because tilt should 
    // remain small.
    double nearNadirCcwLimit = 180 - _NEAR_NADIR_TOLERANCE_DEG;
    double nearNadirCwLimit = 180 + _NEAR_NADIR_TOLERANCE_DEG;

    if (_motionControlStatus.antennaMode == MotionControl::POINTING) {
        // pointing
        return(_ArcContainsAngle(nearNadirCcwLimit, nearNadirCwLimit,
                _motionControlStatus.fixedPointingAngle));
    } else {
        // scanning
        double scanCcwLimit = _motionControlStatus.scanCcwLimit;
        double scanCwLimit = _motionControlStatus.scanCwLimit;
        return(_ArcsOverlap(nearNadirCcwLimit, nearNadirCwLimit,
                scanCcwLimit, scanCwLimit));
    }
}

bool
TransmitControl::_allNearZenithPointing() {
    // For pointing, return true if the pointing angle is contained in the arc 
    // defining "near-zenith". 
    //
    // For scanning, return true if the arc defining "near-zenith" completely 
    // contains the scanned arc.
    //
    // We cheat and only look at the rotation angle, because tilt should 
    // remain small.
    double nearZenithCcwLimit = -_NEAR_ZENITH_TOLERANCE_DEG;
    double nearZenithCwLimit = _NEAR_ZENITH_TOLERANCE_DEG;

    if (_motionControlStatus.antennaMode == MotionControl::POINTING) {
        // pointing
        return(_ArcContainsAngle(nearZenithCcwLimit, nearZenithCwLimit,
                _motionControlStatus.fixedPointingAngle));
    } else {
        // scanning
        double scanCcwLimit = _motionControlStatus.scanCcwLimit;
        double scanCwLimit = _motionControlStatus.scanCwLimit;
        return(_ArcContainsArc(nearZenithCcwLimit, nearZenithCwLimit,
                scanCcwLimit, scanCwLimit));
    }    
}
