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
    _hcrPmc730Status(),
    _motionControlResponsive(false),
    _motionControlStatus(),
    _cmigitsWatchThread(CMIGITS_POLL_INTERVAL_MS, CMIGITS_DATA_TIMEOUT_MS),
    _cmigitsResponsive(false),
    _terrainHtServerResponsive(false),
    _aglAltitude(0.0),
    _overWater(false),
    _hvRequested(false)
{
    // Call _updateHcrPmc730Status when new status from HcrPmc730Daemon arrives
    connect(&hcrPmc730StatusThread, SIGNAL(newStatus(HcrPmc730Status)),
            this, SLOT(_updateHcrPmc730Status(HcrPmc730Status)));
    
    // Call _updateHcrPmc730Responsive when we get a responsiveness change signal
    connect(&hcrPmc730StatusThread, SIGNAL(serverResponsive(bool, QString)),
            this, SLOT(_updateHcrPmc730Responsive(bool, QString)));
    
    // Call _updateMotionControlStatus when new status from MotionControlDaemon 
    // arrives
    connect(&mcStatusThread, SIGNAL(newStatus(MotionControlStatus)),
            this, SLOT(_updateMotionControlStatus(MotionControlStatus)));
    
    // Call _setMotionControlResponding when we get a responsiveness change signal
    connect(&mcStatusThread, SIGNAL(serverResponsive(bool, QString)),
            this, SLOT(_updateMotionControlResponsive(bool, QString)));
    
    // Call _updateCmigitsData when we get new C-MIGITS data
    connect(&_cmigitsWatchThread, SIGNAL(newData(CmigitsSharedMemory::ShmStruct)),
            this, SLOT(_updateCmigitsData(CmigitsSharedMemory::ShmStruct)));
    
    // Mark cmigitsDaemon as unresponsive when the watch thread emits its
    // dataTimeout() signal.
    connect(&_cmigitsWatchThread, SIGNAL(dataTimeout()),
            this, SLOT(_markCmigitsUnresponsive()));
}

TransmitControl::~TransmitControl() {
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
TransmitControl::_disableTransmit(std::string reason) {
    ILOG << "Disabling transmit: " << reason;
    WLOG << "ACTUAL IMPLEMENTATION OF _disableTransmit() DOES NOT EXIST YET!";
}

void
TransmitControl::_doChecks() {
    if (! _hcrPmc730Responsive) {
        _disableTransmit("No data from HcrPmc730Daemon");
        return;
    }
    
    if (! _cmigitsResponsive) {
        _disableTransmit("No data from cmigitsDaemon");
        return;
    }
    
    if (! _terrainHtServerResponsive) {
        _disableTransmit("TerrainHtServer not responding or returned an error");
        return;
    }
    
    bool attenuate = false;
    std::string attenuateReason;
    
    // Convert pressure vessel pressure from hPa to PSI and make sure it 
    // exceeds our minimum pressure criterion.
    double pvPressurePsi = HpaToPsi(_hcrPmc730Status.pvForePressure());

    if (pvPressurePsi < _PV_MINIMUM_PRESSURE_PSI) {
        std::ostringstream oss;
        oss << "PV pressure is below minimum operating pressure of " <<
                _PV_MINIMUM_PRESSURE_PSI << " PSI";
        _disableTransmit(oss.str());
        return;
    }
    
    // Depending on beamDirection, altitude AGL, and surface cover, we may:
    //   1) transmit normally
    //   2) transmit normally, but use an attenuated receive mode
    //   3) not transmit
    std::string surfaceType = _overWater ? "water" : "land";
    int xmitLimitAlt = _overWater ? _XMIT_AGL_ALT_LIMIT_WATER : _XMIT_AGL_ALT_LIMIT_LAND;
    int attenuatedLimitAlt = _overWater ?
            _ATTENUATED_AGL_ALT_LIMIT_WATER : _ATTENUATED_AGL_ALT_LIMIT_LAND;
    
    if (_aglAltitude < xmitLimitAlt) {
        std::ostringstream oss;
        oss << "AGL altitude over " << surfaceType << " is less than " << 
                xmitLimitAlt << " m";
        _disableTransmit(oss.str());
        return;
    } else if (_aglAltitude < attenuatedLimitAlt) {
        // Note that we should attenuate if we pass other transmit tests
        std::ostringstream oss;
        oss << "AGL altitude over " << surfaceType << " is less than " << 
                attenuatedLimitAlt << " m";
        attenuate = true;
        attenuateReason = oss.str();
    }

    if (attenuate) {
        WLOG << "Attenuated receive required: " << attenuateReason;
        WLOG << "IMPLEMENTATION FOR ATTENUATED MODE IS NEEDED!";
    }
}

void
TransmitControl::_updateAglAltitude(CmigitsSharedMemory::ShmStruct cmigitsData) {
    _cmigitsResponsive = true;
    
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
