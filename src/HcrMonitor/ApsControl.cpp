/*
 * ApsControl.cpp
 *
 *  Created on: Oct 9, 2014
 *      Author: burghart
 */

#include "ApsControl.h"
#include <HcrPmc730StatusThread.h>
#include <logx/Logging.h>

LOGGING("ApsControl")

// Convert pressure in hPa to PSI
static inline double HpaToPsi(double pres_hpa) {
    return(0.0145037738 * pres_hpa);
}

ApsControl::ApsControl(HcrPmc730StatusThread & hcrPmc730StatusThread) :
    _pmc730Client("localhost", 8003),
    _valveControlState(VALVE_AUTOMATIC) {
    // Call _checkPvPressure() when new status from HcrPmc730Daemon arrives
    connect(& hcrPmc730StatusThread, SIGNAL(newStatus(HcrPmc730Status)),
            this, SLOT(_checkPvPressure(HcrPmc730Status)));
}

ApsControl::~ApsControl() {
}

void
ApsControl::_checkPvPressure(HcrPmc730Status status730) {
    // Active pressurization system high side pressure, PSI
    double apsHighPresPsi = HpaToPsi(status730.apsHighSidePressure());
    
    // Close the APS solenoid valve if high side pressure drops below 50 PSI.
    // XXX (This check should become unnecessary when we have a check valve 
    // to prevent backflow from the pressure vessel into the APS.)
    if (apsHighPresPsi < 50) {
        if (status730.apsValveOpen()) {
            ILOG << "Closing APS valve because high side pressure " <<
                    "has dropped to " << apsHighPresPsi << " PSI";
            _closeApsValve();
        }

        // Skip all other tests
        return;
    }
    
    // If we're in a manual mode, make sure the solenoid valve is in the
    // manually commanded state
    if (_valveControlState != VALVE_AUTOMATIC) {
        bool valveOpen = status730.apsValveOpen();
        if (_valveControlState == VALVE_ALWAYS_OPEN && ! valveOpen) {
            WLOG << "APS valve got closed while in 'Hold Open' mode. Opening valve again.";
            _openApsValve();
        } else if (_valveControlState == VALVE_ALWAYS_CLOSED && valveOpen) {
            WLOG << "APS valve got opened while in 'Hold Closed' mode. Closing valve again.";
            _closeApsValve();
        }
        // Skip all other tests
        return;
    }
    
    // Vessel pressure is reported in hPa; convert it to PSI.
    double pvPresPsi = HpaToPsi(status730.pvForePressure());
    
    // Open the solenoid valve if the pressure vessel drops below 
    // VALVE_OPEN_PRESSURE_PSI and close the valve when it exceeds 
    // VALVE_CLOSE_PRESSURE_PSI
    if (pvPresPsi < VALVE_OPEN_PRESSURE_PSI && 
            ! status730.apsValveOpen()) {
        ILOG << "Opening APS valve with PV pressure = " << pvPresPsi << " PSI";
        _openApsValve();
    } else if (pvPresPsi > VALVE_CLOSE_PRESSURE_PSI && 
            status730.apsValveOpen()) {
        ILOG << "Closing APS valve with PV pressure = " << pvPresPsi << " PSI";
        _closeApsValve();
    }
}

void
ApsControl::setValveControl(ValveControlState state) {
    _valveControlState = state;
    std::string stateName;
    if (_valveControlState == VALVE_AUTOMATIC) {
        stateName = "automatic";
    } else if (_valveControlState == VALVE_ALWAYS_OPEN) {
        stateName = "always open";
    } else if (_valveControlState == VALVE_ALWAYS_CLOSED) {
        stateName = "always closed";
    } else {
        ELOG << "Unknown valve control state " << _valveControlState <<
            ", changing to 'automatic'";
        _valveControlState = VALVE_AUTOMATIC;
        stateName = "automatic";
    }
    
    // Explicitly open or close the valve now based on the given choice.
    // For VALVE_AUTOMATIC, we close the valve now, and normal control will 
    // resume on the next call to _checkPvPressure().
    bool openValveNow = (_valveControlState == VALVE_ALWAYS_OPEN);
    ILOG << "Setting valve control state to '" << stateName <<
            " and " << (openValveNow ? "opening" : "closing") << " the APS valve";
    
    if (openValveNow) {
        _openApsValve();
    } else {
        _closeApsValve();
    }
}

void
ApsControl::_openApsValve() {
    try {
        _pmc730Client.openApsValve();
    } catch (std::exception & e) {
        ELOG << "HcrPmc730Daemon failed to respond to openApsValve(): " <<
                e.what();
    }
}

void
ApsControl::_closeApsValve() {
    try {
        _pmc730Client.closeApsValve();
    } catch (std::exception & e) {
        ELOG << "HcrPmc730Daemon failed to respond to closeApsValve(): " <<
                e.what();
    }
}