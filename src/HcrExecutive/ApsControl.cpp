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
 * ApsControl.cpp
 *
 *  Created on: Oct 9, 2014
 *      Author: burghart
 */

#include "ApsControl.h"
#include "../HcrSharedResources.h"
#include <HcrPmc730StatusWorker.h>
#include <logx/Logging.h>

LOGGING("ApsControl")

// Convert pressure in hPa to PSI
static inline double HpaToPsi(double pres_hpa) {
    return(0.0145037738 * pres_hpa);
}

// Valve control state names (mapped to the ValveControlState enum)
const std::string
ApsControl::ValveControlStateNames[] = {
        "Automatic",
        "Valve Always Open",
        "Valve Always Closed",
        "INVALID",
};


ApsControl::ApsControl(HcrPmc730StatusWorker & hcrPmc730StatusWorker) :
    _pmc730Client("localhost", HCRPMC730DAEMON_PORT),
    _valveControlState(VALVE_AUTOMATIC) {
    // Call _checkPvPressure() when new status from HcrPmc730Daemon arrives
    connect(& hcrPmc730StatusWorker, SIGNAL(newStatus(HcrPmc730Status)),
            this, SLOT(_checkPvPressure(HcrPmc730Status)));
}

ApsControl::~ApsControl() {
    ILOG << "ApsControl destructor closing APS valve";
    _closeApsValve();
}

void
ApsControl::_logAndSaveStatus(std::string statusText) {
    ILOG << statusText;
    _statusText = statusText;
}

void
ApsControl::_checkPvPressure(HcrPmc730Status status730) {
    // Active pressurization system high side pressure, PSI
    double apsHighPresPsi = HpaToPsi(status730.apsHighSidePressure());
    
    // Close the APS solenoid valve if high side pressure drops below 
    // HIGH_SIDE_MINIMUM_PSI.
    if (apsHighPresPsi < HIGH_SIDE_MINIMUM_PSI) {
        if (status730.apsValveOpen()) {
            _closeApsValve();
            
            std::ostringstream oss;
            oss << "Closed APS valve because high side pressure " <<
                    "has dropped to " << apsHighPresPsi << " PSI";
            _logAndSaveStatus(oss.str());
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
        _openApsValve();
        
        std::ostringstream oss;
        oss << "Opened APS valve with PV pressure = " << pvPresPsi << " PSI";
        _logAndSaveStatus(oss.str());
        
        return;
    } else if (pvPresPsi > VALVE_CLOSE_PRESSURE_PSI && 
            status730.apsValveOpen()) {
        _closeApsValve();

        std::ostringstream oss;
        oss << "Closed APS valve with PV pressure = " << pvPresPsi << " PSI";
        _logAndSaveStatus(oss.str());

        return;
    }
    
    // Everything's good!
    _statusText = "PV pressure is good";
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
    
    if (openValveNow) {
        _openApsValve();
    } else {
        _closeApsValve();
    }
    
    std::ostringstream oss;
    oss << "Set valve control state to '" << stateName <<
            "' and " << (openValveNow ? "opened" : "closed") << " the APS valve";
    _logAndSaveStatus(oss.str());
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
