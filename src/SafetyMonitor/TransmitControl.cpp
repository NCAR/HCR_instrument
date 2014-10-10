/*
 * TransmitControl.cpp
 *
 *  Created on: Oct 10, 2014
 *      Author: burghart
 */

#include "TransmitControl.h"

#include <HcrPmc730StatusThread.h>
#include <sstream>

// Convert pressure in hPa to PSI
static inline double HpaToPsi(double pres_hpa) {
    return(0.0145037738 * pres_hpa);
}

TransmitControl::TransmitControl(HcrPmc730StatusThread & hcrPmc730StatusThread) :
    _hcrPmc730Status(NULL),
    _hvDisallowedReasons(),
    _pvGoodPressureWaitTimer(this),
    _pvPressureOK(false) {
    // Call _updateHcrPmc730Status when new status from HcrPmc730Daemon arrives
    connect(&hcrPmc730StatusThread, SIGNAL(newStatus(HcrPmc730Status)),
            this, SLOT(_updateHcrPmc730Status(HcrPmc730Status)));
    // Call _setHcrPmc730Responding when we get a responsiveness change signal
    connect(&hcrPmc730StatusThread, SIGNAL(serverResponsive(bool)),
            this, SLOT(_setHcrPmc730DaemonResponding(bool)));
    
    // Set up the timer to allow transmitter high voltage only after pressure 
    // vessel pressure has been acceptably high for PV_PRESSURE_WAIT_SECONDS
    // seconds.
    _pvGoodPressureWaitTimer.setSingleShot(true);
    _pvGoodPressureWaitTimer.setInterval(1000 * PV_PRESSURE_WAIT_SECONDS);
    connect(&_pvGoodPressureWaitTimer, SIGNAL(timeout()),
            this, SLOT(_pvPressureWaitExpired()));
     
}

TransmitControl::~TransmitControl() {
}

void
TransmitControl::_updateHcrPmc730Status(HcrPmc730Status status) {
    // Allocate space for a copy of the status if necessary.
    if (! _hcrPmc730Status) {
        _hcrPmc730Status = new HcrPmc730Status(true);   // empty/bogus status
    }
    // Copy the incoming status.
    *_hcrPmc730Status = status;

    _performMonitoringTests();
}

void
TransmitControl::_clearHcrPmc730Status() {
    delete(_hcrPmc730Status);
    _hcrPmc730Status = NULL;
}

void
TransmitControl::_onHcrPmc730ResponsivenessChange(bool responding) {
    // If the daemon has become unresponsive, delete the old status and
    // redo the monitoring tests.
    if (! responding) {
        // Remove old status
        _clearHcrPmc730Status();
        // Stop the good pressure wait timer if it's running
        _pvGoodPressureWaitTimer.stop();
        
        _performMonitoringTests();
    }
}

void
TransmitControl::_pvPressureWaitExpired() {
    _pvPressureOK = true;
}

void
TransmitControl::_performMonitoringTests() {
    // Clear the list of reasons high voltage is disallowed
    _hvDisallowedReasons.clear();
    
    if (_hcrPmc730Status) {
        // Convert pressure vessel pressure from hPa to PSI
        double pvPressurePsi = HpaToPsi(_hcrPmc730Status->pvForePressure());

        // Evaluate the pressure vessel pressure
        if (pvPressurePsi > PV_MINIMUM_PRESSURE_PSI) {
            // Pressure is good. If our good pressure wait timer has not been 
            // started yet, start it now.
            if (! _pvGoodPressureWaitTimer.isActive()) {
                _pvGoodPressureWaitTimer.start();
            }
        } else {
            // Stop the timer if we were in a good pressure waiting period
            _pvGoodPressureWaitTimer.stop();
            // Pressure is too low
            _pvPressureOK = false;
        }
        
        // Disallow high voltage if pressure vessel pressure is too low or if
        // we're waiting for it to be high enough for sufficient time.
        if (! _pvPressureOK) {
            std::ostringstream oss;
            if (_pvGoodPressureWaitTimer.isActive()) {
                oss << "Waiting for PV pressure to be above " << 
                        PV_MINIMUM_PRESSURE_PSI << " PSI for more than " <<
                        PV_PRESSURE_WAIT_SECONDS << " seconds";
            } else {
                oss << "PV pressure is lower than " << PV_MINIMUM_PRESSURE_PSI <<
                        " PSI";
            }
            _hvDisallowedReasons.push_back(oss.str());
        }    
    } else /* _hcrPmc730Status is NULL */ {
        // Disallow high voltage if we have no status from HcrPmc730Daemon
        _hvDisallowedReasons.push_back("HcrPmc730Daemon is not responding");
        
        // With no status, treat pressure vessel pressure as bad
        _pvGoodPressureWaitTimer.stop();
        _pvPressureOK = false;
    }
}
