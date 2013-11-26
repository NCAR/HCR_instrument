/*
 * HcrXmitter.h
 *
 *  Created on: Jan 7, 2011
 *      Author: burghart
 */

#ifndef HCRXMITTER_H_
#define HCRXMITTER_H_

#include <string>
#include <stdint.h>
#include "XmitStatus.h"

class HcrXmitter {
public:
    /**
     * @brief Construct a HcrXmitter providing access to the HCR transmitter's
     * Control and Monitor Unit (CMU) on the given serial port.
     * 
     * If special serial port name HcrXmitter::SIM_DEVICE
     * is used, existence of the transmitter will be simulated.
     * @param ttyDev the name of the serial port connected to the transmitter.
     */
    HcrXmitter(std::string ttyDev);
    virtual ~HcrXmitter();
    
    /**
     * Control methods: front panel, RS-232, or RDS. Exactly one of the three
     * control bits is supposed to be set, but occasionally that is not true
     * and we then use UnknownControl.
     */
    typedef enum {
        /// @brief unknown control source
        UnknownControl = 0,
        /// @brief front panel control selected
        FrontPanelControl = 1,
        /// @brief RS-232 control selected
        RS232Control = 2,
        /// @brief RDS control selected
        RDSControl = 4,
        /// @brief A mask with all of the control bits
        AllControlSources = 7
    } ControlSource;
            
    /**
     * @brief Get current status values from the transmitter.
     */
    XmitStatus getStatus();
    
    /**
     * @brief Set filament state.
     * @param state boolean state: true to turn on filament, false to turn off
     * filament.
     */
    void setFilamentState(bool state);
    
    /**
     * @brief Set high voltage state.
     * @param state boolean state: true to turn on HV, false to turn off
     * HV.
     */
    void setHvState(bool state);
    
    /**
     * Reopen our serial port talking to the transmitter. Generally this should
     * be called any time the serial port on the transmitter has been reset.
     */
    void reopenTty();
    
    /**
     * Device name to use when creating a simulation HcrXmitter.
     */
    static const std::string SIM_DEVICE;

private:
    /**
     * Open and configure our tty connection to the transmitter
     */
    void _openTty();
    
    /**
     * Send a command to the transmitter.
     */
    void _sendCommand(uint8_t desiredState);
    
    /**
     * Wait for input on our file descriptor, with a timeout specified in
     * milliseconds. 
     * @return 0 when input is ready, -1 if the select timed out, -2 on
     *      select error
     */
    int _readSelect(unsigned int timeoutMsecs);
    
    /// Command byte 3: Filament on?
    static const uint8_t _FILAMENT_ON_BIT 		= 0x01;
    /// Command byte 3: HV on?
    static const uint8_t _HV_ON_BIT				= 0x02;
    /// Command byte 3: RF on?
    static const uint8_t _RF_ON_BIT				= 0x04;
    /// Command byte 3: External modulation pulse?
    static const uint8_t _EXT_MOD_PULSE_BIT		= 0x08;
    /// Command byte 3: External sync pulse?
    static const uint8_t _EXT_SYNC_PULSE_BIT	= 0x10;

    /// Are we simulating?
    bool _simulate;
    bool _simFilamentOn;
    bool _simHvOn;
    
    /**
     *  Counter which is incremented every time we send a command to the
     * transmitter.
     */
    uint8_t _aliveCounter;
    
    /// Our serial port device name (may be SIM_DEVICE)
    std::string _ttyDev;
    
    /// File descriptor for the open serial port
    int _fd;

    /// Intended transmitter state
    uint8_t _intendedState;
};

#endif /* HCRXMITTER_H_ */
