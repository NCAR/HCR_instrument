// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2016                                         
// ** University Corporation for Atmospheric Research (UCAR)                 
// ** National Center for Atmospheric Research (NCAR)                        
// ** Boulder, Colorado, USA                                                 
// ** BSD licence applies - redistribution and use in source and binary      
// ** forms, with or without modification, are permitted provided that       
// ** the following conditions are met:                                      
// ** 1) If the software is modified to produce derivative works,            
// ** such modified software should be clearly marked, so as not             
// ** to confuse it with the version available from UCAR.                    
// ** 2) Redistributions of source code must retain the above copyright      
// ** notice, this list of conditions and the following disclaimer.          
// ** 3) Redistributions in binary form must reproduce the above copyright   
// ** notice, this list of conditions and the following disclaimer in the    
// ** documentation and/or other materials provided with the distribution.   
// ** 4) Neither the name of UCAR nor the names of its contributors,         
// ** if any, may be used to endorse or promote products derived from        
// ** this software without specific prior written permission.               
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS  
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED      
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.    
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
/*
 * TransmitControl.cpp
 *
 *  Created on: Oct 10, 2014
 *      Author: burghart
 */

#include "TransmitControl.h"
#include "MaxPowerFmqClient.h"

#include <iomanip>
#include <limits>
#include <sstream>

#include <logx/Logging.h>
#include <HcrSharedResources.h>
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
        MaxPowerFmqClient & maxPowerClient) :
    _xmlrpcClient(),
    _hcrPmc730Client(hcrPmc730StatusThread.rpcClient()),
    _hcrPmc730Responsive(false),
    _hcrPmc730Status(),
    _motionControlResponsive(false),
    _motionControlStatus(),
    _maxPowerResponsive(false),
    _insInUse(1),
    _insWatcher(INS1_FMQ_URL, _INS_POLL_INTERVAL_MS, _INS_DATA_TIMEOUT_MS),
    _insResponsive(false),
    _terrainHtServerResponsive(false),
    _aglAltitude(0.0),
    _overWater(false),
    _hvRequested(false),
    _requestedHmcMode(),
    _xmitTestStatus(NOXMIT_UNSPECIFIED),
    _hmcModeMap(),
    _timeOfLastHvOffForHighPower(0),
    _detailsForLastHvOffForHighPower("")
{
    // Start with clean map of HMC mode change time -> HMC mode
    _clearHmcModeMap();

    // Call _updateHcrPmc730Status when new status from HcrPmc730Daemon arrives
    connect(&hcrPmc730StatusThread, SIGNAL(newStatus(HcrPmc730Status)),
            this, SLOT(_updateHcrPmc730Status(HcrPmc730Status)));
    
    // Call _updateHcrPmc730Responsive when we get a responsiveness change signal
    connect(&hcrPmc730StatusThread, SIGNAL(serverResponsive(bool, QString)),
            this, SLOT(_updateHcrPmc730Responsive(bool, QString)));
    
    // Call _recordHmcModeChange when we get a mode change signal
    connect(&hcrPmc730StatusThread, 
            SIGNAL(hmcModeChange(HcrPmc730::OperationMode, double)),
            this, 
            SLOT(_recordHmcModeChange(HcrPmc730::OperationMode, double)));
    
    // Call _updateMotionControlStatus when new status from MotionControlDaemon 
    // arrives
    connect(&mcStatusThread, SIGNAL(newStatus(MotionControl::Status)),
            this, SLOT(_updateMotionControlStatus(MotionControl::Status)));
    
    // Call _setMotionControlResponding when we get a responsiveness change signal
    connect(&mcStatusThread, SIGNAL(serverResponsive(bool, QString)),
            this, SLOT(_updateMotionControlResponsive(bool, QString)));
    
    // Call _updateMaxPower when new max powers arrive from the TsPrint max
    // power server
    connect(&maxPowerClient, SIGNAL(newMaxPower(double, double, double, double, double)),
            this, SLOT(_updateMaxPower(double, double, double, double, double)));
    
    // Call _setMaxPowerResponding when we get a responsiveness change signal
    connect(&maxPowerClient, SIGNAL(serverResponsive(bool, QString)),
            this, SLOT(_updateMaxPowerResponsive(bool, QString)));
    
    // Call _updateAglAltitude and mark the INS as responsive when we get new
    // INS data
    connect(&_insWatcher, SIGNAL(newData(CmigitsFmq::MsgStruct)),
            this, SLOT(_updateAglAltitude(CmigitsFmq::MsgStruct)));
    connect(&_insWatcher, SIGNAL(newData(CmigitsFmq::MsgStruct)),
            this, SLOT(_markInsResponsive()));
    
    // Mark INS reader daemon as unresponsive when the watch thread emits its
    // dataTimeout() signal.
    connect(&_insWatcher, SIGNAL(dataTimeout()),
            this, SLOT(_markInsUnresponsive()));
    
    // Finally, do our checks
    _updateControlState();
}

TransmitControl::~TransmitControl() {
    ILOG << "TransmitControl destructor setting HMC mode to Bench Test";
    #warning    _setHmcMode(HcrPmc730::HMC_MODE_BENCH_TEST, 0);
}

void
TransmitControl::_updateHcrPmc730Status(HcrPmc730Status status) {
    _hcrPmc730Status = status;
    // Our idea of current HMC mode may differ from what HcrPmc730Daemon
    // reports. This can happen on the first report we see from HcrPmc730Daemon,
    // or if the daemon goes away and we later regain contact. In this case,
    // get our state back in sync with HcrPmc730Daemon.
    if (_hcrPmc730Status.hmcMode() != _currentHmcMode()) {
        WLOG << "HcrPmc730Daemon reports HMC mode '" <<
                _hcrPmc730Status.hmcMode().name() <<
                "' instead of expected mode '" <<
                _currentHmcMode().name() << "'";
        // Log the unexpected mode change as having happened now
        struct timeval tv;
        gettimeofday(&tv, NULL);
        double now = tv.tv_sec + 1.0e-6 * tv.tv_usec;
        _recordHmcModeChange(status.hmcMode(), now);
    }
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
TransmitControl::_recordHmcModeChange(const HcrPmc730::OperationMode& mode,
                                       double modeChangeTime) {
    // Append this mode change to _hmcModeMap
    ILOG << "HMC mode changed to '" << mode.name() << 
            "' at " << QDateTime::fromTime_t(time_t(modeChangeTime))
                       .addMSecs(int(fmod(modeChangeTime, 1.0) * 1000))
                       .toString("yyyyMMdd hh:mm:ss.zzz").toStdString();
    _hmcModeMap[modeChangeTime] = mode;
}

void
TransmitControl::_updateMotionControlStatus(MotionControl::Status status) {
    _motionControlStatus = status;

    // Our _insInUse should track Motion Control's. Change the watcher's
    // URL if we change _insInUse.
    int mcInsInUse = _motionControlStatus.insInUse;
    if (_insInUse != mcInsInUse) {
        ILOG << "Switching 'INS in use' from " << _insInUse << " to " <<
                mcInsInUse << " to match MotionControl";
        _insInUse = mcInsInUse;
        std::string fmqUrl;
        switch (_insInUse) {
        case 1:
            fmqUrl = INS1_FMQ_URL;
            break;
        case 2:
            fmqUrl = INS2_FMQ_URL;
            break;
        default:
            ELOG << "BUG - bad 'INS in use' value: " << _insInUse;
            abort();
        }
        _insWatcher.setFmqUrl(fmqUrl);
    }

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
TransmitControl::_updateMaxPower(double centerTime, double dwellWidth, 
        double peakMaxPower, double rangeToPeakMax, double meanMaxPower) {
    // Figure out dwell start and end times
    double dwellStart = centerTime - 0.5 * dwellWidth;
    double dwellEnd = centerTime + 0.5 * dwellWidth;
    
    // Calculate the latency for the max power data, and complain if it's big
    struct timeval tvNow;
    gettimeofday(&tvNow, NULL);
    double doubleNow = tvNow.tv_sec + 1.0e-6 * tvNow.tv_usec;
    double latency = doubleNow - dwellEnd;
    if (latency > 0.3) {
        QDateTime qMaxPwrTime = QDateTime::fromTime_t(time_t(centerTime))
                .addMSecs(int(centerTime * 1000) % 1000);
        WLOG << "Latency for " <<
            qMaxPwrTime.toString("yyyyMMdd hh:mm:ss.zzz").toStdString() <<
            " max power report: " << doubleNow - centerTime << " s";
    }
    
    // Store the max power information and update control state
    _maxPowerReport.dataTime = centerTime;
    _maxPowerReport.peakMaxPower = peakMaxPower;
    _maxPowerReport.rangeToPeakMaxPower = rangeToPeakMax;
    _maxPowerReport.meanMaxPower = meanMaxPower;
    _maxPowerReport.attenuated = _timePeriodWasAttenuated(dwellStart, dwellEnd);
    _updateControlState();
}

void
TransmitControl::_updateMaxPowerResponsive(bool responding, QString msg) {
    _maxPowerResponsive = responding;
    if (_maxPowerResponsive) {
        ILOG << msg.toStdString();
    } else {
        WLOG << msg.toStdString();
    }
    // Redo the monitoring tests
    _updateControlState();
}

void
TransmitControl::_markInsResponsive() {
    if (_insResponsive) {
        return;
    }
    ILOG << "INS is responsive";
    _insResponsive = true;
    _updateControlState();
}

void
TransmitControl::_markInsUnresponsive() {
    if (!_insResponsive) {
        return;
    }
    ELOG << "INS is NOT responsive";
    _insResponsive = false;
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
    
    if (! _insResponsive) {
        return(NOXMIT_NO_INS_DATA);
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
    
//    // No transmit allowed if altitude is below _XMIT_NONZENITH_AGL_LIMIT and
//    // not scanning/pointing near zenith.
//    if (_aglAltitude < _XMIT_NONZENITH_AGL_LIMIT && ! _allNearZenithPointing()) {
//        return(NOXMIT_TOO_LOW_FOR_NONZENITH);
//    }
//
//    // Test for AGL altitude below our nadir limit if we're nadir pointing
//    if (_anyNearNadirPointing() && _aglAltitude < _xmitNadirAglMinimum()) {
//        return(NOXMIT_TOO_LOW_FOR_NADIR_POINTING);
//    }
//
//    // Test against AGL altitude limits for attenuated receive
//    if (_anyNearNadirPointing() && _aglAltitude < _unattenuatedNadirAglMinimum()) {
//        if (! _attenuatedModeAvailable()) {
//            // If there is not attenuated mode we can use, we have to disable
//            // transmit.
//            return(NOXMIT_TOO_LOW_FOR_NADIR_POINTING);
//        } else {
//            // Mark that we'll have to switch to an attenuated mode if we
//            // make it through remaining tests.
//            provisionalStatus = ATTENUATE_TOO_LOW_FOR_NADIR_POINTING;
//        }
//    }
    
    // If user has requested HV on and received power exceeds our safety 
    // threshold, attenuate if possible otherwise force _hvRequested to false 
    // to disable transmit until the user acts.
    if (_hvRequested && _maxPowerReport.meanMaxPower > _RECEIVED_POWER_THRESHOLD) {
        // Adding attenuation is a solution if 1) an attenuated mode is
        // available, and 2) the max power was not recorded in a period that
        // was already attenuated.
        if (_attenuatedModeAvailable() && ! _maxPowerReport.attenuated) {
            // Mark that we'll have to switch to an attenuated mode if we
            // make it through remaining tests.
            provisionalStatus = ATTENUATE_RCVD_POWER_TOO_HIGH;
        } else {
            // Change _hvRequested to false to disable transmit, and to force
            // user action before transmission will be resumed.
            std::ostringstream oss;
            oss << "Forcing high voltage request to OFF, to protect the " <<
                    "receiver after seeing " <<
                    (_maxPowerReport.attenuated ? "" : "un") << "attenuated " <<
                    "max power of " << _maxPowerReport.meanMaxPower <<
                    " dBm with current HMC mode: " <<
                    _currentHmcMode().name();
            WLOG << oss.str();
            _hvRequested = false;
            // Save time and details about the hard shutoff of high voltage
            struct timeval tv;
            gettimeofday(&tv, NULL);
            _timeOfLastHvOffForHighPower = tv.tv_sec + 1.0e-6 * tv.tv_usec;
            _detailsForLastHvOffForHighPower = oss.str();
            return(NOXMIT_RCVD_POWER_TOO_HIGH);
        }
    }
    
    // If we're currently in attenuated mode due to high received power, we
    // need to remain there until *unattenuated* max power drops to 6 dB or
    // more below our max power threshold.
    if (_xmitTestStatus == ATTENUATE_RCVD_POWER_TOO_HIGH) {
        double unattenuatedPower = _maxPowerReport.meanMaxPower + _SWITCH_ATTENUATION;
        if (unattenuatedPower > (_RECEIVED_POWER_THRESHOLD - 6)) {
            ILOG << "Waiting for max power to drop before removing attenuation";
            provisionalStatus = ATTENUATE_RCVD_POWER_TOO_HIGH;
        } else {
            // No longer forcing attenuation due to high power, although a
            // different reason for attenuating may have been set above.
            ILOG << "Max power now low enough to resume unattenuated receive";
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
    case NOXMIT_NO_INS_DATA:
        return("Transmit not allowed: No data from INS reader daemon");
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
        oss << "Forcing high voltage request to OFF, to protect the " <<
        "receiver after seeing " <<
        (_maxPowerReport.attenuated ? "" : "un") << "attenuated " <<
        "max power of " << _maxPowerReport.meanMaxPower <<
        " dBm with current HMC mode '" <<
        _currentHmcMode().name() << "'";
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
    HcrPmc730::OperationMode newHmcMode = attenuationRequired() ? 
            _requestedHmcMode.equivalentAttenuatedMode() : _requestedHmcMode;

    // We should have a valid HMC mode now. If not, it's a bug and
    // we'll have to disable transmit...
    if (newHmcMode.hmcMode == HcrPmc730::HMC_MODE_INVALID) {
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
    if (_currentHmcMode() != newHmcMode) {
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
TransmitControl::_updateAglAltitude(CmigitsFmq::MsgStruct cmigitsData) {
    if (! _insResponsive) {
        ILOG << "Got a response from INS reader daemon";
        _insResponsive = true;
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

    if (_motionControlStatus.antennaMode == MotionControl::MODE_POINTING) {
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

    if (_motionControlStatus.antennaMode == MotionControl::MODE_POINTING) {
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
TransmitControl::_attenuatedModeAvailable() {
    return _requestedHmcMode.equivalentAttenuatedMode().hmcMode != HcrPmc730::HMC_MODE_INVALID;
}

void
TransmitControl::setRequestedHmcMode(HcrPmc730::OperationMode& mode) {
    ILOG << "Setting requested HMC mode to " << mode.name();
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
TransmitControl::_setHmcMode(HcrPmc730::OperationMode& mode) {
    // Bail out now if we're not changing mode
    if (_currentHmcMode() == mode) {
        return;
    } else {
        ILOG << "Changing HMC mode to '" << mode.name() << "'";
    }
    try {
        _hcrPmc730Client.setHmcMode(mode);
    } catch (std::exception & e) {
        ELOG << "XML-RPC call to HcrPmc730Daemon setHmcMode(" << mode.name() << 
                ") failed: " << e.what();
    }
}

bool
TransmitControl::_timePeriodWasAttenuated(double startTime,
        double endTime) const {
    std::map<double, HcrPmc730::OperationMode>::const_reverse_iterator rit;
    // Loop backward through the map of HMC modes looking at all modes which
    // were used during the given period.
    for (rit = _hmcModeMap.rbegin(); rit != _hmcModeMap.rend(); rit++) {
        double modeStartTime = rit->first;
        HcrPmc730::OperationMode mode = rit->second;
        // If this mode started after the end time, move to the previous mode
        if (modeStartTime >= endTime)
            continue;
        // If we find any unattenuated mode was used during the period, return
        // false immediately
        if (! mode.isAttenuated()) {
            return(false);
        }
        // If this mode started before the start time, we're done
        if (modeStartTime <= startTime) {
            // We found only attenuated mode(s) during the period, so return true
            return(true);
        }
    }
    // If we get here, it means we do not know what the mode was at the start
    // of the period. For safety, we must report that attenuation was in effect
    // for the period, implying that actual max power received at the antenna
    // port is _SWITCH_ATTENUATION dB higher than the reported max power.
    int msecs = int(fmod(startTime, 1.0) * 1000);
    QDateTime qDateTime = QDateTime::fromTime_t(time_t(startTime)).addMSecs(msecs);
    ELOG << "BUG: HMC mode at " <<
            qDateTime.toString("yyyyMMdd hh:mm:ss.zzz").toStdString() <<
            " could not be found";
    return(true);
}

void
TransmitControl::_clearHmcModeMap() {
    _hmcModeMap.clear();
    // Initialize as having run in "Bench Test" mode since the beginning of time
    HcrPmc730::OperationMode m;
    m.hmcMode = HcrPmc730::HMC_MODE_BENCH_TEST;
    _hmcModeMap[0] = m;
}
