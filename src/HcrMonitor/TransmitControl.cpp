/*
 * TransmitControl.cpp
 *
 *  Created on: Oct 10, 2014
 *      Author: burghart
 */

#include "TransmitControl.h"
#include "MaxPowerClient.h"

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
        MotionControlStatusThread & mcStatusThread,
        MaxPowerClient & maxPowerThread) :
    _xmlrpcClient(),
    _hcrPmc730Client(hcrPmc730StatusThread.rpcClient()),
    _hcrPmc730Responsive(false),
    _hcrPmc730Status(true),
    _motionControlResponsive(false),
    _motionControlStatus(),
    _maxPowerResponsive(false),
    _maxPowerDataTime(0.0),
    _maxPower(99.9),
    _rangeToMaxPower(0.0),
    _cmigitsWatchThread(_CMIGITS_POLL_INTERVAL_MS, _CMIGITS_DATA_TIMEOUT_MS),
    _cmigitsResponsive(false),
    _terrainHtServerResponsive(false),
    _aglAltitude(0.0),
    _overWater(false),
    _hvRequested(false),
    _requestedHmcMode(HcrPmc730::HMC_MODE_BENCH_TEST),
    _xmitTestStatus(NOXMIT_UNSPECIFIED),
    _attenuatedModeStartTime(0)
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
    
    // Call _updateMaxPower when new max powers arrive from the TsPrint max
    // power server
    connect(&maxPowerThread, SIGNAL(newMaxPower(double, double, double)),
            this, SLOT(_updateMaxPower(double, double, double)));
    
    // Call _setMaxPowerResponding when we get a responsiveness change signal
    connect(&maxPowerThread, SIGNAL(serverResponsive(bool, QString)),
            this, SLOT(_updateMaxPowerResponsive(bool, QString)));
    
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
    _updateControlState();
}

TransmitControl::~TransmitControl() {
    ILOG << "TransmitControl destructor setting HMC mode to Bench Test";
    try {
        _hcrPmc730Client.setHmcMode(HcrPmc730::HMC_MODE_BENCH_TEST);
    } catch (std::exception & e) {
        ELOG << "HcrPmc730Daemon failed to respond to setHmcMode(): " <<
                e.what();
    }
    _cmigitsWatchThread.quit();
}

void
TransmitControl::_updateHcrPmc730Status(HcrPmc730Status status) {
    _hcrPmc730Status = status;
    _updateControlState();
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
    _updateControlState();
}

void
TransmitControl::_updateMotionControlStatus(MotionControl::Status status) {
    _motionControlStatus = status;
    _updateControlState();
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
    _updateControlState();
}

void
TransmitControl::_updateMaxPower(double dataTime, double maxPower, 
        double rangeToMax) {
    // Note the latency for the max power data
    struct timeval tvNow;
    gettimeofday(&tvNow, NULL);
    double doubleNow = tvNow.tv_sec + 1.0e-6 * tvNow.tv_usec;
    QDateTime qNow = QDateTime::fromTime_t(tvNow.tv_sec).addMSecs(tvNow.tv_usec / 1000);
    ILOG << "Max power latency at " << 
            qNow.toString("yyyyMMdd hh:mm:ss.zzz").toStdString() << ": " <<
            doubleNow - dataTime << " s";
    
    // Store the max power information and update control state
    _maxPowerDataTime = dataTime;
    _maxPower = maxPower;
    _rangeToMaxPower = rangeToMax;
    _updateControlState();
}

void
TransmitControl::_updateMaxPowerResponsive(bool responding, QString msg) {
    _maxPowerResponsive = responding;
    if (_maxPowerResponsive) {
        ILOG << "Got a response from TsPrint max power server";
    } else {
        WLOG << "TsPrint max power server is not responding: " << msg.toStdString();
    }
    // Redo the monitoring tests
    _updateControlState();
}

void
TransmitControl::_markCmigitsUnresponsive() {
    _cmigitsResponsive = false;
    _updateControlState();
}

TransmitControl::XmitTestStatus
TransmitControl::_runTransmitTests() {
    // Provisional test status, which may be XMIT_ALLOWED or one of the
    // "attenuation required" status values.
    XmitTestStatus provisionalStatus = XMIT_ALLOWED;
    
    // Perform all tests to see if transmit is allowed.
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
    
    if (! _maxPowerResponsive) {
        return(NOXMIT_NO_MAXPOWER_DATA);
    }

    // No transmit if the EIK filament is not on
    if (! _hcrPmc730Status.rdsXmitterFilamentOn()) {
        return(NOXMIT_FILAMENT_OFF);
    }
    
    // No transmit allowed if MotionControl does not know which way the
    // radar beam is pointing.
    if (! _motionControlStatus.rotDriveHomed ||
            ! _motionControlStatus.tiltDriveHomed) {
        return(NOXMIT_DRIVES_NOT_HOMED);
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
    
    // Test against AGL altitude limits for attenuated receive
    if (_anyNearNadirPointing() && _aglAltitude < _unattenuatedNadirAglMinimum()) {
        if (! _attenuatedModeAvailable()) {
            // If there is not attenuated mode we can use, we have to disable
            // transmit.
            return(NOXMIT_TOO_LOW_FOR_NADIR_POINTING);
        } else {
            // Mark that we'll have to switch to an attenuated mode if we
            // make it through remaining tests.
            if (provisionalStatus == XMIT_ALLOWED) {
                provisionalStatus = ATTENUATE_TOO_LOW_FOR_NADIR_POINTING;
            }
        }
    }
    
    // If user has requested HV on and received power exceeds our safety 
    // threshold, attenuate if possible otherwise force _hvRequested to false 
    // to disable transmit until the user acts.
    // TODO: After switching in attenuation, the next max power report we get
    // may still be of non-attenuated data. Maybe delay reaction to turn off
    // transmit completely in this case (NOT GREAT), or include info from
    // the max power server to indicate if data are attenuated (BETTER).
    if (_hvRequested && _maxPower > _RECEIVED_POWER_THRESHOLD) {
        // If there's no viable attenuated mode available, or if we're in 
        // attenuated mode and the time of the max power is after the start of 
        // attenuated mode, we have to disable transmit.
        if (_HmcModeIsAttenuated(_hcrPmc730Status.hmcMode()) &&
                _maxPowerDataTime < _attenuatedModeStartTime) {
            WLOG << "..another too big max power, but before attenuated mode kicked in";
        }
        if (! _attenuatedModeAvailable() ||
                (_HmcModeIsAttenuated(_hcrPmc730Status.hmcMode()) && 
                        _maxPowerDataTime > _attenuatedModeStartTime)) {
            // Change _hvRequested to false to disable transmit, and force the 
            // user to act to try transmitting again.
            WLOG << "Forcing high voltage request to OFF, to protect the " <<
                    "receiver after seeing max power of " << _maxPower << 
                    " dBm in HMC mode: " << 
                    HcrPmc730::HmcModeNames[_hcrPmc730Status.hmcMode()];
            _hvRequested = false;
            return(NOXMIT_RCVD_POWER_TOO_HIGH);
        } else {
            // Mark that we'll have to switch to an attenuated mode if we
            // make it through remaining tests.
            if (provisionalStatus == XMIT_ALLOWED) {
                provisionalStatus = ATTENUATE_RCVD_POWER_TOO_HIGH;
            }
        }
    }
    
    // If we made it here, transmit is allowed, although it may require 
    // attenuated receive.
    return(provisionalStatus);
}

void
TransmitControl::_setXmitTestStatus(XmitTestStatus status) {
    // If transmit status changed from previous testing, store the new value
    // and log the change
    if (status != _xmitTestStatus) {
        _xmitTestStatus = status;
        // Log the change
        ILOG << _xmitTestStatusText();
    }
}

std::string
TransmitControl::_xmitTestStatusText() const {
    std::ostringstream oss;
    switch (_xmitTestStatus) {
    case XMIT_ALLOWED:
        return("Transmit allowed: All tests passed");
       
    case ATTENUATE_TOO_LOW_FOR_NADIR_POINTING:
        oss << "Attenuation required: Nadir pointing and AGL altitude < " << 
                _unattenuatedNadirAglMinimum() << " m over " << 
                (_overWater ? "water" : "land");
        return(oss.str());
    case ATTENUATE_RCVD_POWER_TOO_HIGH:
        oss << "Attenuation required: Unattenuated max received power " <<
            "exceeded " << _RECEIVED_POWER_THRESHOLD << " dBm";
        return(oss.str());
    case NOXMIT_NO_HCRPMC730_DATA:
        return("Transmit not allowed: No data from HcrPmc730Daemon");
    case NOXMIT_NO_CMIGITS_DATA:
        return("Transmit not allowed: No data from cmigitsDaemon");
    case NOXMIT_NO_TERRAINHTSERVER_DATA:
        return("Transmit not allowed: TerrainHtServer not responding or returned an error");
    case NOXMIT_NO_MOTIONCONTROL_DATA:
        return("Transmit not allowed: No data from MotionControlDaemon");
    case NOXMIT_NO_MAXPOWER_DATA:
        return("Transmit not allowed: No data from TsPrint max power server");
    case NOXMIT_FILAMENT_OFF:
        return("Transmit not allowed: Filament is not on");
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
    case NOXMIT_DRIVES_NOT_HOMED:
        return("Transmit not allowed: drives not homed, reflector position unknown");
    case NOXMIT_RCVD_POWER_TOO_HIGH:
        oss << "Transmit not allowed: Received power in attenuated mode " <<
            "exceeded " << _RECEIVED_POWER_THRESHOLD << " dBm";
        return(oss.str());
    case NOXMIT_ATTENUATE_BUG:
        return("BUG: Attenuated mode is required but is not available.");
    default:
        oss << "Oops, no text for XmitTestStatus " << _xmitTestStatus;
        return(oss.str());
    }
}

void
TransmitControl::_updateControlState() {
    // Test if transmit is currently allowed and set _xmitTestStatus to the
    // result.
    _setXmitTestStatus(_runTransmitTests());
    
    // Figure out the HMC mode to use if attenuation is required and the 
    // requested HMC mode is not attenuated.
    HcrPmc730::HmcOperationMode newHmcMode = attenuationRequired() ? 
            _EquivalentAttenuatedMode(_requestedHmcMode) : _requestedHmcMode;

    // We should have a valid HMC mode now. If not, it's a bug and
    // we'll have to disable transmit...
    if (newHmcMode == HcrPmc730::HMC_MODE_INVALID) {
        newHmcMode = _requestedHmcMode;
        _setXmitTestStatus(NOXMIT_ATTENUATE_BUG);
        ELOG << _xmitTestStatusText();
    }

    // We'll be turning on high voltage if it's both requested and allowed
    bool enablingHv = _hvRequested && transmitAllowed();
    
    // If we're turning off HV, do it before we change HMC mode, since our
    // tests validated our chosen mode assuming HV is off.
    if (! enablingHv) {
        if (_hcrPmc730Status.rdsXmitterHvOn()) {
            _xmitHvOff();
        }
    }
    
    // Set HMC mode
    if (_hcrPmc730Status.hmcMode() != newHmcMode) {
        _setHmcMode(newHmcMode);
    }
    
    // If we're turning on HV, do it after we change HMC mode, since we only
    // validated that HV on is OK with our chosen mode, and not the previous 
    // one.
    if (enablingHv) {
        // Call _xmitHvOn() even if it's already on, since a HcrPmc730Daemon
        // requires a heartbeat to keep HV on.
        _xmitHvOn();
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
    _mslAltitude = cmigitsData.altitude;
    
    DLOG << cmigitsData.time3501 << ", lat: " << latitude << 
            ", lon: " << longitude << ", altMSL: " << _mslAltitude;

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
        _aglAltitude = _mslAltitude - surfaceAltMSL;

        // Over land or water?
        _overWater = xmlrpc_c::value_boolean(dict["isWater"]);

        // Log what we got
        DLOG << "Sensor height AGL " << _aglAltitude << " m (over " << 
                (_overWater ? "water" : "land") << ")";
    } while (false);    // do exactly once

    // Do checks using new state
    _updateControlState();
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

bool
TransmitControl::_HmcModeIsAttenuated(HcrPmc730::HmcOperationMode mode) {
    return(mode == HcrPmc730::HMC_MODE_H_HV_ATTENUATED ||
            mode == HcrPmc730::HMC_MODE_V_HV_ATTENUATED);
}

bool
TransmitControl::_attenuatedModeAvailable() {
    return(_EquivalentAttenuatedMode(_requestedHmcMode) != HcrPmc730::HMC_MODE_INVALID);
}

HcrPmc730::HmcOperationMode
TransmitControl::_EquivalentAttenuatedMode(HcrPmc730::HmcOperationMode mode) {
    switch (mode) {
    case HcrPmc730::HMC_MODE_H_HV:
    case HcrPmc730::HMC_MODE_H_HV_ATTENUATED:
        return(HcrPmc730::HMC_MODE_H_HV_ATTENUATED);
    case HcrPmc730::HMC_MODE_V_HV:
    case HcrPmc730::HMC_MODE_V_HV_ATTENUATED:
        return(HcrPmc730::HMC_MODE_V_HV_ATTENUATED);
    case HcrPmc730::HMC_MODE_BENCH_TEST:
        return(HcrPmc730::HMC_MODE_BENCH_TEST);
    case HcrPmc730::HMC_MODE_NOISE_SOURCE_CAL:
        return(HcrPmc730::HMC_MODE_NOISE_SOURCE_CAL);
    default:
        return(HcrPmc730::HMC_MODE_INVALID);
    }
}

void
TransmitControl::setRequestedHmcMode(HcrPmc730::HmcOperationMode mode) {
    ILOG << "Setting requested HMC mode to " << mode;
    _requestedHmcMode = mode;
    _updateControlState();
}

void
TransmitControl::setHvRequested(bool hvRequested) {
    ILOG << "Setting 'HV requested' to " << (hvRequested ? "true" : "false");
    _hvRequested = hvRequested;
    _updateControlState();
}

void
TransmitControl::_xmitHvOn() {
    // Log only if we're changing HV state
    if (! _hcrPmc730Status.rdsXmitterHvOn()) {
        ILOG << "Turning on transmitter high voltage";
    }
    // Send the command
    try {
        _hcrPmc730Client.xmitHvOn();
    } catch (std::exception & e) {
        ELOG << "XML-RPC call to HcrPmc730Daemon xmitHvOn() failed: " << e.what();
    }
}

void
TransmitControl::_xmitHvOff() {
    // Log only if we're changing HV state
    if (_hcrPmc730Status.rdsXmitterHvOn()) {
        ILOG << "Turning off transmitter high voltage";
    }
    // Send the command
    try {
        _hcrPmc730Client.xmitHvOff();
    } catch (std::exception & e) {
        ELOG << "XML-RPC call to HcrPmc730Daemon xmitHvOf() failed: " << e.what();
    }
}

void
TransmitControl::_setHmcMode(HcrPmc730::HmcOperationMode mode) {
    HcrPmc730::HmcOperationMode startingMode = _hcrPmc730Status.hmcMode();
    // Are we switching from an unattenuated mode to an attenuated mode?
    bool enablingAttenuation = ! _HmcModeIsAttenuated(startingMode) &&
            _HmcModeIsAttenuated(mode);
    
    // Log only if we're changing mode
    if (startingMode != mode) {
        ILOG << "Changing HMC mode to '" << HcrPmc730::HmcModeNames[mode] << "'";
    }
    try {
        _hcrPmc730Client.setHmcMode(mode);
        // Mark the start time of attenuated mode after the call above returns
        if (enablingAttenuation) {
            struct timeval tv;
            gettimeofday(&tv, NULL);
            _attenuatedModeStartTime = tv.tv_sec + 1.0e-6 * tv.tv_usec;
            QDateTime startTime = QDateTime::fromTime_t(tv.tv_sec);
            startTime = startTime.addMSecs(tv.tv_usec / 1000);
            ILOG << "Attenuated mode started at " << 
                    startTime.toString("yyyyMMdd hh:mm:ss.zzz").toStdString();
        }
    } catch (std::exception & e) {
        ELOG << "XML-RPC call to HcrPmc730Daemon setHmcMode(" << mode << 
                ") failed: " << e.what();
    }
}
