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
public:
    /// @brief Instantiate using the given HcrPmc730StatusThread as the source 
    /// of status from HcrPmc730Daemon.
    /// @param hcrPmc730StatusThread the HcrPmc730StatusThread which will 
    /// provide status from HcrPmc730Daemon
    ApsControl(HcrPmc730StatusThread & hcrPmc730StatusThread);
    virtual ~ApsControl();
    
    /// @brief Enable or disable forced opening of the APS solenoid valve.
    /// @param holdOpen true if the APS valve should be held in an open 
    /// state, false to resume normal control of the valve.
    void setHoldOpen(bool holdOpen);
private slots:
    /// @brief Slot which checks pressure vessel pressure and commands opening 
    /// or closing of the Active Pressurization System (APS) solenoid valve if 
    /// required. 
    /// @param status the new HcrPmc730Status
    void _checkPvPressure(HcrPmc730Status status);
private:
    /// @brief Command HcrPmc730Daemon to open the APS valve
    void _openApsValve();
    
    /// @brief Command HcrPmc730Daemon to close the APS valve
    void _closeApsValve();
     
    /// Our client object for sending XML-RPC commands to HcrPmc730Daemon
    HcrPmc730Client _pmc730Client;
    
    /// Should we force the APS solenoid valve to be held open?
    bool _holdOpen;
};

#endif /* APSTHREAD_H_ */
