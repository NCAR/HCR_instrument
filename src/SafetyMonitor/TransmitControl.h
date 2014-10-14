/*
 * TransmitControl.h
 *
 *  Created on: Oct 10, 2014
 *      Author: burghart
 */

#ifndef TRANSMITCONTROL_H_
#define TRANSMITCONTROL_H_

#include <HcrPmc730Client.h>
#include <QObject>
#include <QTimer>
#include <vector>

class HcrPmc730StatusThread;

/// Class providing implementation for handling transmitter control lines
/// (filament and high voltage), including monitoring for whether conditions
/// allow for safe transmission.
class TransmitControl : public QObject {
    Q_OBJECT
public:
    /// @brief Instantiate using the given HcrPmc730StatusThread as the source 
    /// of status from HcrPmc730Daemon.
    /// @param hcrPmc730StatusThread the HcrPmc730StatusThread which will 
    /// provide status from HcrPmc730Daemon
    TransmitControl(HcrPmc730StatusThread & hcrPmc730StatusThread);
    virtual ~TransmitControl();
private slots:
    /// @brief Accept a new status from HcrPmc730Daemon and react if necessary
    /// @param status the new status from HcrPmc730Daemon
    void _updateHcrPmc730Status(HcrPmc730Status status);
    
    /// @brief Note a responsiveness change for HcrPmc730Daemon
    /// @param responding true if the daemon is now responsive, false if it's
    /// now unresponsive
    /// @param msg a string describing the responsiveness change
    void _onHcrPmc730ResponsivenessChange(bool responding, QString msg);
    
private:
    /// @brief Clear any existing status from HcrPmc730Daemon
    void _clearHcrPmc730Status();
    
    /// @brief Perform monitoring tests based on latest status and react 
    /// appropriately.
    void _performMonitorTests();
    
    /// Latest status received from HcrPmc730Daemon.
    HcrPmc730Status * _hcrPmc730Status;
    
    /// Reasons transmit may be disallowed
    enum _NoXmitReasonBit {
        _NOXMIT_NO_HCRPMC730DAEMON      = 1 << 0,
        _NOXMIT_PV_GOOD_PRESSURE_WAIT   = 1 << 1,
        _NOXMIT_PV_PRESSURE_LOW         = 1 << 2,
        _NOXMIT_NO_MOTIONCONTROLDAEMON  = 1 << 3,
        _NOXMIT_DRIVES_NOT_HOMED        = 1 << 4
    };
    /// Mask of reasons transmit is currently disallowed
    uint32_t _noXmitReasons;
    
    /// Minimum pressure vessel pressure for allowing high voltage in the
    /// transmitter.
    static const float _PV_MINIMUM_PRESSURE_PSI;
    
    /// Minimum time of acceptable pressure in the pressure vessel before
    /// turning on transmitter high voltage is allowed.
    static const int _PV_GOOD_PRESSURE_WAIT_SECONDS;
    
    /// Value used to mark a bad start time
    static const time_t _START_TIME_BAD;
    
    /// Start time of continuous good pressure in the pressure vessel. This is
    /// reset to _START_TIME_BAD whenever a bad pressure is seen.
    int _pvGoodPressureStartTime;
};

#endif /* TRANSMITCONTROL_H_ */
