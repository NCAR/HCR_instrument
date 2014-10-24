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
    _doChecks();
}

TransmitControl::~TransmitControl() {
    _cmigitsWatchThread.quit();
}

void
TransmitControl::_updateHcrPmc730Status(HcrPmc730Status status) {
    _hcrPmc730Status = status;
    _doChecks();
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
    _doChecks();
}

void
TransmitControl::_updateMotionControlStatus(MotionControl::Status status) {
    _motionControlStatus = status;
    _doChecks();
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
    _doChecks();
}

void
TransmitControl::_markCmigitsUnresponsive() {
    _cmigitsResponsive = false;
    _doChecks();
}

void
TransmitControl::_doChecks() {
    // Allow transmit unless a test below fails.
    NoXmitReasonCode newNoXmitReason = XMIT_ALLOWED;
    std::string noXmitReasonMsg("Transmit tests all passed.");
    
    if (newNoXmitReason == XMIT_ALLOWED && ! _hcrPmc730Responsive) {
        newNoXmitReason = NOXMIT_NO_HCRPMC730_DATA;
        noXmitReasonMsg = "No data from HcrPmc730Daemon";
    }
    
    if (newNoXmitReason == XMIT_ALLOWED && ! _cmigitsResponsive) {
        newNoXmitReason = NOXMIT_NO_CMIGITS_DATA;
        noXmitReasonMsg = "No data from cmigitsDaemon";
    }
    
    if (newNoXmitReason == XMIT_ALLOWED && ! _terrainHtServerResponsive) {
        newNoXmitReason = NOXMIT_NO_TERRAINHTSERVER_DATA;
        noXmitReasonMsg = "TerrainHtServer not responding or returned an error";
    }
    
    if (newNoXmitReason == XMIT_ALLOWED && ! _motionControlResponsive) {
        newNoXmitReason = NOXMIT_NO_MOTIONCONTROL_DATA;
        noXmitReasonMsg = "No data from MotionControlDaemon";
    }
    
    bool attenuate = false;
    std::string attenuateReasonMsg;
    
    // Convert pressure vessel pressure from hPa to PSI and make sure it 
    // exceeds our minimum pressure criterion.
    double pvPressurePsi = HpaToPsi(_hcrPmc730Status.pvForePressure());

    if (newNoXmitReason == XMIT_ALLOWED && 
            pvPressurePsi < _PV_MINIMUM_PRESSURE_PSI) {
        std::ostringstream oss;
        oss << "PV pressure (" << pvPressurePsi << 
                " PSI) is below minimum operating pressure of " <<
                _PV_MINIMUM_PRESSURE_PSI << " PSI";
        newNoXmitReason = NOXMIT_PV_PRESSURE_LOW;
        noXmitReasonMsg = oss.str();
    }
    
    // Depending on beamDirection, altitude AGL, and surface cover, we may:
    //   1) transmit normally
    //   2) transmit normally, but use an attenuated receive mode
    //   3) not transmit
    std::string surfaceType = _overWater ? "water" : "land";
    int xmitNadirAglLimit = _overWater ? 
            _XMIT_NADIR_AGL_LIMIT_WATER : _XMIT_NADIR_AGL_LIMIT_LAND;
    int attenuatedNadirAglLimit = _overWater ?
            _ATTENUATED_NADIR_AGL_LIMIT_WATER : _ATTENUATED_NADIR_AGL_LIMIT_LAND;
    
    if (newNoXmitReason == XMIT_ALLOWED &&
            ! _allNearZenithPointing() && _aglAltitude < _XMIT_NONZENITH_AGL_LIMIT) {
        // No transmit allowed if below _XMIT_NONZENITH_AGL_LIMIT and not
        // always pointing near zenith.
        std::ostringstream oss;
        oss << "Non-zenith pointing and AGL altitude is less than " << 
                _XMIT_NONZENITH_AGL_LIMIT << " m";
        newNoXmitReason = NOXMIT_TOO_LOW_FOR_NONZENITH;
        noXmitReasonMsg = oss.str();
    }

    if (newNoXmitReason == XMIT_ALLOWED && 
            _anyNearNadirPointing() && _aglAltitude < xmitNadirAglLimit) {
        // No transmit allowed if below xmitNadirAglLimit and pointing near 
        // nadir at any time.
        std::ostringstream oss;
        oss << "Near-nadir pointing and AGL altitude over " << surfaceType << 
                " is less than " << xmitNadirAglLimit << " m";
        newNoXmitReason = NOXMIT_TOO_LOW_FOR_NADIR;
        noXmitReasonMsg = oss.str();
    } else if (_anyNearNadirPointing() && _aglAltitude < attenuatedNadirAglLimit) {
        // We need to attenuate the received signal
        std::ostringstream oss;
        oss << "Near-nadir pointing and AGL altitude over " << surfaceType << 
                " is less than " << attenuatedNadirAglLimit << " m";
        attenuate = true;
        attenuateReasonMsg = oss.str();
    }

    // If the result of our transmit tests changed from last time, log the 
    // change and save the new result.
    if (newNoXmitReason != _noXmitReason) {
        _noXmitReason = newNoXmitReason;
        ILOG << "Transmit is " << 
                ((_noXmitReason == XMIT_ALLOWED) ? "allowed" : "disallowed") <<
                noXmitReasonMsg;
    }
    
    // Disable transmit if a test above failed, otherwise we can turn on high 
    // voltage now if it's been requested.
    if (_noXmitReason != XMIT_ALLOWED) {
        // TODO: actually disable HV here!
    } else {
        if (_hvRequested){
            // If we need to attenuate received signal, set that up before we 
            // turn on high voltage
            if (attenuate) {
                // Change to an attenuated receive mode if required
                WLOG << "Attenuated receive required: " << attenuateReasonMsg;
                WLOG << "IMPLEMENTATION FOR ATTENUATED MODE IS NEEDED!";
            }
            // TODO: turn on HV here!
        }
        
        // TODO: actually attenuate receive here!
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
    _doChecks();
}

double
TransmitControl::_ArcOverlapsArc(double ccwLimit1, double cwLimit1, 
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
        return(_ArcOverlapsArc(nearNadirCcwLimit, nearNadirCwLimit,
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
