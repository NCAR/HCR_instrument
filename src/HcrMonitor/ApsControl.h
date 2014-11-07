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
    friend class HcrMonitorStatus;
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
        VALVE_ALWAYS_CLOSED
    } ValveControlState;
    
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
    /// @brief The APS valve is opened when pressure vessel pressure drops
    /// below this value.
    static const double VALVE_OPEN_PRESSURE_PSI = 15.0;
    
    /// @brief The APS valve is closed when pressure vessel pressure exceeds
    /// this value.
    static const double VALVE_CLOSE_PRESSURE_PSI = 16.0;

    /// @brief Close the APS valve if high side pressure drops below this value.
    static const double HIGH_SIDE_MINIMUM_PSI = 100.0;
    
    /// @brief Command HcrPmc730Daemon to open the APS valve
    void _openApsValve();
    
    /// @brief Command HcrPmc730Daemon to close the APS valve
    void _closeApsValve();
     
    /// @brief Our client object for sending XML-RPC commands to HcrPmc730Daemon
    HcrPmc730Client _pmc730Client;
    
    /// Valve control: automatic, always open, or always closed
    ValveControlState _valveControlState;
};

#endif /* APSTHREAD_H_ */
