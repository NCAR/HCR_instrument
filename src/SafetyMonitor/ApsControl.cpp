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
    _holdOpen(false) {
    // Call _checkPvPressure() when new status from HcrPmc730Daemon arrives
    connect(& hcrPmc730StatusThread, SIGNAL(newStatus(HcrPmc730Status)),
            this, SLOT(_checkPvPressure(HcrPmc730Status)));
}

ApsControl::~ApsControl() {
}

void
ApsControl::_checkPvPressure(HcrPmc730Status status730) {
    // Active pressurization system high side pressure, PSI
    double apsHighPresPsi = status730.apsHighSidePressurePsi();
    
    // Close the APS solenoid valve if high side pressure drops below 50 PSI.
    // XXX (This check should become unnecessary when we have a check valve 
    // to prevent backflow from the pressure vessel into the APS.)
    if (apsHighPresPsi < 50 && status730.apsValveOpen()) {
        ILOG << "Closing APS valve because high side pressure " <<
                "has dropped to " << apsHighPresPsi << " PSI";
        _closeApsValve();

        // Skip all other tests
        return;
    }
    
    // Open the solenoid valve if we've gotten an explicit command to do so
    if (_holdOpen && ! status730.apsValveOpen()) {
        _openApsValve();
        // Skip all other tests
        return;
    }
    
    // Pressure vessel pressure is reported in hPa; convert it to PSI.
    double pvPresPsi = HpaToPsi(status730.pvForePressure());
    ILOG << "PV pressure " << pvPresPsi << " PSI";
    
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
ApsControl::setHoldOpen(bool holdOpen) {
    _holdOpen = holdOpen;
    ILOG << "Setting 'hold open' to " << (_holdOpen ? "true" : "false") <<
            " and " << (_holdOpen ? "opening" : "closing") << " the APS valve";
    
    // Explicitly open or close the valve now based on the given choice.
    // If _holdOpen is now false, normal control will resume on the next call
    // to _checkPvPressure().
    if (_holdOpen) {
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
