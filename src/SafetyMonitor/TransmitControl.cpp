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

const float TransmitControl::_PV_MINIMUM_PRESSURE_PSI = 11.0;
const int TransmitControl::_PV_GOOD_PRESSURE_WAIT_SECONDS = 60;
const time_t TransmitControl::_START_TIME_BAD = -1;

TransmitControl::TransmitControl(HcrPmc730StatusThread & hcrPmc730StatusThread) :
    _hcrPmc730Status(NULL),
    _noXmitReasons(0),
    _pvGoodPressureStartTime(_START_TIME_BAD) {
    // Call _updateHcrPmc730Status when new status from HcrPmc730Daemon arrives
    connect(&hcrPmc730StatusThread, SIGNAL(newStatus(HcrPmc730Status)),
            this, SLOT(_updateHcrPmc730Status(HcrPmc730Status)));
    // Call _setHcrPmc730Responding when we get a responsiveness change signal
    connect(&hcrPmc730StatusThread, SIGNAL(serverResponsive(bool, QString)),
            this, SLOT(_onHcrPmc730ResponsivenessChange(bool, QString)));
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
TransmitControl::_onHcrPmc730ResponsivenessChange(bool responding, QString msg) {
    if (responding) {
        ILOG << "Got a response from HcrPmc730Daemon";
    } else {
        WLOG << "HcrPmc730Daemon is not responding: " << msg.toStdString();
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
            _noXmitReasons &= ~_NOXMIT_PV_PRESSURE_LOW;
            
            // If we don't have a good pressure start time yet, set it to now
            time_t now = time(0);
            if (_pvGoodPressureStartTime == _START_TIME_BAD) {
                _pvGoodPressureStartTime = now;
            }
            
            // Test if we've had good pressure for a long enough period
            time_t goodPressureTime = now - _pvGoodPressureStartTime;
            if (goodPressureTime >= _PV_GOOD_PRESSURE_WAIT_SECONDS) {
                // We've had good pressure for a long enough period
                if (_noXmitReasons & _NOXMIT_PV_GOOD_PRESSURE_WAIT) {
                    ILOG << "PV pressure > " << _PV_MINIMUM_PRESSURE_PSI <<
                            " PSI for for over " << _PV_GOOD_PRESSURE_WAIT_SECONDS << 
                            " seconds. Transmit is allowed.";
                    // Remove the pressure wait disallowance
                    _noXmitReasons &= ~_NOXMIT_PV_GOOD_PRESSURE_WAIT;
                }
            } else {
                // Disallow transmit while we're waiting for a long enough 
                // period of good pressure
                _noXmitReasons |= _NOXMIT_PV_GOOD_PRESSURE_WAIT;
            }
        } else {
            // PV pressure is too low
            if (! (_noXmitReasons & _NOXMIT_PV_PRESSURE_LOW)) {
                WLOG << "PV pressure is lower than " << 
                        _PV_MINIMUM_PRESSURE_PSI << " PSI";
                // Disallow transmit because of low pressure
                _noXmitReasons |= _NOXMIT_PV_PRESSURE_LOW;
                // No longer in the good pressure waiting period
                _noXmitReasons &= ~_NOXMIT_PV_GOOD_PRESSURE_WAIT;
            }
        }
    } else /* _hcrPmc730Status is NULL */ {
        // Erase knowledge of any good pressures
        _pvGoodPressureStartTime = _START_TIME_BAD;
        
        // Disallow transmit if we have no status from HcrPmc730Daemon
        _noXmitReasons |= _NOXMIT_NO_HCRPMC730DAEMON;
        _noXmitReasons &= ~_NOXMIT_PV_PRESSURE_LOW;
        _noXmitReasons &= ~_NOXMIT_PV_GOOD_PRESSURE_WAIT;
    }
    
    // TODO: test MotionControlDaemon status for any reasons to disallow HV
    
    // If high voltage is disallowed for any reason, turn it off now
    if (_noXmitReasons != 0) {
        // Log all reasons for disallowing transmit
        WLOG << "Transmit disallowed because: ";
        int disallowCount = 0;
        if (_noXmitReasons & _NOXMIT_NO_HCRPMC730DAEMON) {
            WLOG << "  " << ++disallowCount << ") " << 
                    "no status available from HcrPmc730Daemon";
        }
        if (_noXmitReasons & _NOXMIT_PV_PRESSURE_LOW) {
            WLOG << "  " << ++disallowCount << ") " << 
                    "PV pressure is too low";
        }
        if (_noXmitReasons & _NOXMIT_PV_GOOD_PRESSURE_WAIT) {
            WLOG << "  " << ++disallowCount << ") " << 
                    "waiting for good PV pressure period > " << 
                    _PV_GOOD_PRESSURE_WAIT_SECONDS << " seconds";
        }
        if (_noXmitReasons & _NOXMIT_NO_MOTIONCONTROLDAEMON) {
            WLOG << "  " << ++disallowCount << ") " << 
                    "no status available from MotionControlDaemon";
        }
        if (_noXmitReasons & _NOXMIT_DRIVES_NOT_HOMED) {
            WLOG << "  " << ++disallowCount << ") " << 
                    "drives not homed; motor positions are unknown";
        }
        
        // Disable transmit
        // TODO: actually disable transmit!
    }
}
