/*
 * TransmitControl.cpp
 *
 *  Created on: Oct 10, 2014
 *      Author: burghart
 */

#include "TransmitControl.h"

#include <logx/Logging.h>
#include <HcrPmc730StatusThread.h>
#include <limits>
#include <sstream>

LOGGING("TransmitControl")

// Convert pressure in hPa to PSI
static inline double HpaToPsi(double pres_hpa) {
    return(0.0145037738 * pres_hpa);
}

const time_t TransmitControl::START_TIME_BAD = std::numeric_limits<time_t>::max();

TransmitControl::TransmitControl(HcrPmc730StatusThread & hcrPmc730StatusThread) :
    _hcrPmc730Status(NULL),
    _xmitDisallowedReasons(0),
    _pvGoodPressureStartTime(START_TIME_BAD) {
    // Call _updateHcrPmc730Status when new status from HcrPmc730Daemon arrives
    connect(&hcrPmc730StatusThread, SIGNAL(newStatus(HcrPmc730Status)),
            this, SLOT(_updateHcrPmc730Status(HcrPmc730Status)));
    // Call _setHcrPmc730Responding when we get a responsiveness change signal
    connect(&hcrPmc730StatusThread, SIGNAL(serverResponsive(bool)),
            this, SLOT(_setHcrPmc730DaemonResponding(bool)));
}

TransmitControl::~TransmitControl() {
}

void
TransmitControl::_updateHcrPmc730Status(HcrPmc730Status status) {
    // If we have already allocated our _hcrPmc730Status member, copy the
    // incoming status into the already allocated space, otherwise allocate a 
    // new HcrPmc730Status using the copy constructor.
    if (_hcrPmc730Status) {
        *_hcrPmc730Status = status;
    } else {
        _hcrPmc730Status = new HcrPmc730Status(status);
    }

    _performMonitorTests();
}

void
TransmitControl::_onHcrPmc730ResponsivenessChange(bool responding) {
    if (responding) {
        ILOG << "Got a response from HcrPmc730Daemon";
    } else {
        WLOG << "HcrPmc730Daemon is not responding!";
        // Remove old status
        delete(_hcrPmc730Status);
        _hcrPmc730Status = NULL;
        // Redo the monitoring tests
        _performMonitorTests();
    }
}

void
TransmitControl::_performMonitorTests() {
    // Test if the pressure vessel has been above minimum operating pressure
    // for long enough.
    if (_hcrPmc730Status) {
        // Convert pressure vessel pressure from hPa to PSI
        double pvPressurePsi = HpaToPsi(_hcrPmc730Status->pvForePressure());

        // Evaluate the pressure vessel pressure
        if (pvPressurePsi > _PV_MINIMUM_PRESSURE_PSI) {
            // Pressure is high enough. Remove the low pressure disallowance.
            _xmitDisallowedReasons &= ~DISALLOW_FOR_PV_PRESSURE_LOW;
            
            // If we don't have a good pressure start time yet, set it to now
            time_t now = time(0);
            if (_pvGoodPressureStartTime == START_TIME_BAD) {
                _pvGoodPressureStartTime = now;
            }
            
            // Test if we've had good pressure for a long enough period
            time_t goodPressureTime = now - _pvGoodPressureStartTime;
            if (goodPressureTime >= _PV_PRESSURE_WAIT_SECONDS) {
                // We've had good pressure for a long enough period
                if (_xmitDisallowedReasons & DISALLOW_FOR_PV_GOOD_PRESSURE_WAIT) {
                    ILOG << "PV pressure has maintained " << _PV_MINIMUM_PRESSURE_PSI <<
                            " PSI for for more than " << _PV_PRESSURE_WAIT_SECONDS << 
                            " seconds, so transmit is allowed.";
                    // Remove the pressure wait disallowance
                    _xmitDisallowedReasons &= ~DISALLOW_FOR_PV_GOOD_PRESSURE_WAIT;
                }
            } else {
                // Disallow transmit while we're waiting for a long enough 
                // period of good pressure
                _xmitDisallowedReasons |= DISALLOW_FOR_PV_GOOD_PRESSURE_WAIT;
            }
        } else {
            // PV pressure is too low
            if (! (_xmitDisallowedReasons & DISALLOW_FOR_PV_PRESSURE_LOW)) {
                WLOG << "PV pressure is lower than " << 
                        _PV_MINIMUM_PRESSURE_PSI << " PSI";
                // Disallow transmit because of low pressure
                _xmitDisallowedReasons |= DISALLOW_FOR_PV_PRESSURE_LOW;
                // No longer in the good pressure waiting period
                _xmitDisallowedReasons &= ~DISALLOW_FOR_PV_GOOD_PRESSURE_WAIT;
            }
        }
    } else /* _hcrPmc730Status is NULL */ {
        // Erase knowledge of any good pressures
        _pvGoodPressureStartTime = START_TIME_BAD;
        
        // Disallow transmit if we have no status from HcrPmc730Daemon
        _xmitDisallowedReasons |= DISALLOW_FOR_NO_HCRPMC730DAEMON;
        _xmitDisallowedReasons &= ~DISALLOW_FOR_PV_PRESSURE_LOW;
        _xmitDisallowedReasons &= ~DISALLOW_FOR_PV_GOOD_PRESSURE_WAIT;
    }
    
    // TODO: test MotionControlDaemon status for any reasons to disallow HV
    
    // If high voltage is disallowed for any reason, turn it off now
    if (_xmitDisallowedReasons != 0) {
        // Log all reasons for disallowing transmit
        WLOG << "Transmit disallowed because: ";
        int disallowCount = 0;
        if (_xmitDisallowedReasons & DISALLOW_FOR_NO_HCRPMC730DAEMON) {
            WLOG << ++disallowCount << ") no status available from HcrPmc730Daemon";
        }
        if (_xmitDisallowedReasons & DISALLOW_FOR_PV_PRESSURE_LOW) {
            WLOG << ++disallowCount << ") PV pressure is too low";
        }
        if (_xmitDisallowedReasons & DISALLOW_FOR_PV_GOOD_PRESSURE_WAIT) {
            WLOG << ++disallowCount << ") waiting for good PV pressure " <<
                    "period > " << _PV_PRESSURE_WAIT_SECONDS << " seconds";
        }
        if (_xmitDisallowedReasons & DISALLOW_FOR_NO_MOTIONCONTROLDAEMON) {
            WLOG << ++disallowCount << ") no status available from MotionControlDaemon";
        }
        if (_xmitDisallowedReasons & DISALLOW_FOR_DRIVES_NOT_HOMED) {
            WLOG << ++disallowCount << ") drives not homed; motor positions are unknown";
        }
        
        // Disable transmit
        // TODO: actually disable transmit!
    }
}
