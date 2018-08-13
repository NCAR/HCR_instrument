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
 * ApsControl.h
 *
 *  Created on: Oct 9, 2014
 *      Author: burghart
 */

#ifndef APSTHREAD_H_
#define APSTHREAD_H_

#include <HcrPmc730Client.h>
#include <QObject>

class HcrPmc730StatusThread;

/// Class which provides implementation for HCR's Active Pressurization
/// System (APS).
class ApsControl : public QObject {
    Q_OBJECT
    friend class HcrExecutiveStatus;
public:
    /// @brief Instantiate using the given HcrPmc730StatusThread as the source
    /// of status from HcrPmc730Daemon.
    /// @param hcrPmc730StatusThread the HcrPmc730StatusThread which will
    /// provide status from HcrPmc730Daemon
    ApsControl(HcrPmc730StatusThread & hcrPmc730StatusThread);
    virtual ~ApsControl();

    /// @brief Enumerated type for valve control state
    typedef enum {
        VALVE_AUTOMATIC,
        VALVE_ALWAYS_OPEN,
        VALVE_ALWAYS_CLOSED,
        VALVE_CONTROL_NSTATES   // count of valid control states
    } ValveControlState;

    /**
     * Strings mapped to the ValveControlState enum
     */
    static const std::string ValveControlStateNames[];

    /// @brief Set the control state for the APS solenoid valve.
    /// @param state the desired value for valve control
    void setValveControl(ValveControlState state);

private slots:
    /// @brief Slot which checks pressure vessel pressure and commands opening
    /// or closing of the Active Pressurization System (APS) solenoid valve if
    /// required.
    /// @param status the new HcrPmc730Status
    void _checkPvPressure(HcrPmc730Status status);
private:
    /// @brief
    /// @brief Log and save the given status.
    /// @param statusText a string describing the status.
    void _logAndSaveStatus(std::string statusText);

    /// @brief The APS valve is opened when pressure vessel pressure drops
    /// below this value.
    static constexpr double VALVE_OPEN_PRESSURE_PSI = 15.0;

    /// @brief The APS valve is closed when pressure vessel pressure exceeds
    /// this value.
    static constexpr double VALVE_CLOSE_PRESSURE_PSI = 16.0;

    /// @brief Close the APS valve if high side pressure drops below this value.
    static constexpr double HIGH_SIDE_MINIMUM_PSI = 100.0;

    /// @brief Command HcrPmc730Daemon to open the APS valve
    void _openApsValve();

    /// @brief Command HcrPmc730Daemon to close the APS valve
    void _closeApsValve();

    /// @brief Our client object for sending XML-RPC commands to HcrPmc730Daemon
    HcrPmc730Client _pmc730Client;

    /// Valve control: automatic, always open, or always closed
    ValveControlState _valveControlState;

    /// Status text
    std::string _statusText;
};

#endif /* APSTHREAD_H_ */
