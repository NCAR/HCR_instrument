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
    void _onHcrPmc730ResponsivenessChange(bool responding);
    
    /// @brief Slot to be called when PV pressure has been good long 
    /// enough to allow for transmitter high voltage.
    void _pvPressureWaitExpired();
private:
    /// @brief Clear any existing status from HcrPmc730Daemon
    void _clearHcrPmc730Status();
    
    /// @brief Perform monitoring tests based on latest status and react 
    /// appropriately.
    void _performMonitoringTests();
    
    /// Latest status received from HcrPmc730Daemon.
    HcrPmc730Status * _hcrPmc730Status;
    
    /// List of reasons high voltage is currently disallowed
    std::vector<std::string> _hvDisallowedReasons;
    
    /// Minimum pressure vessel pressure for allowing high voltage in the
    /// transmitter.
    static const float PV_MINIMUM_PRESSURE_PSI = 11.0;
    
    /// Minimum time of acceptable pressure in the pressure vessel before
    /// turning on transmitter high voltage is allowed.
    static const int PV_PRESSURE_WAIT_SECONDS = 60;
    
    /// Timer to allow transmitter high voltage only after pressure vessel
    /// pressure has been acceptably high for PV_PRESSURE_WAIT seconds.
    QTimer _pvGoodPressureWaitTimer;
    
    /// Is pressure vessel pressure high enough to allow high voltage on the
    /// transmitter?
    bool _pvPressureOK;
};

#endif /* TRANSMITCONTROL_H_ */
