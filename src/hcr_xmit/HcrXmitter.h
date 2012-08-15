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
     * Struct for status information returned by getStatus()
     */
    struct Status {
        /// Is the serial line connected?
        bool serialConnected;

        /**
         *  @brief Which control source is selected on the front panel?
         *  
         *  As documented, this 
         */
        ControlSource controlSource;

        /// EIK filament on?
        bool filamentOn;
        /// High voltage on?
        bool highVoltageOn;
        /// RF on?
        bool rfOn;
        /// Is external modulation pulse selected?
        bool modPulseExternal;
        /// Is external sync pulse selected?
        bool syncPulseExternal;
        /**
         * @brief Is the EIK filament delay active? I.e., is the filament not
         * yet warm?
         * 
         * This will be true until the filament has been turned on for at least
         * 150 seconds. High voltage cannot be applied until the delay is no
         * longer active.
         */
        bool filamentDelayActive;
        /// Is power valid?
        bool powerValid;
        /// This is true if any fault is currently active.
        bool faultSummary;
        /// Is there a modulator fault?
        bool modulatorFault;
        /// Is there a sync fault?
        bool syncFault;
        /// Is there a transmitter temperature fault?
        bool xmitterTempFault;
        /// Is there a waveguide arc fault?
        bool waveguideArcFault;
        /// Is there a collector current fault?
        bool collectorCurrentFault;
        /// Is there a body current fault?
        bool bodyCurrentFault;
        /// Is there a filament "loss of reference" fault?
        bool filamentLorFault;
        /// Is there a focus electrode "loss of reference" fault?
        bool focusElectrodeLorFault;
        /// Is there a cathode "loss of reference" fault?
        bool cathodeLorFault;
        /// Is there an inverter overload fault?
        bool inverterOverloadFault;
        /// Is there an external interlock fault?
        bool externalInterlockFault;
        /// Is there an EIK interlock fault?
        bool eikInterlockFault;
        /// Was there a bad checksum on the last communication to the 
        /// transmitter?
        bool badChecksumReceived;
        
        /// Cathode voltage, kV
        double cathodeVoltage;
        /// Body current, mA
        double bodyCurrent;
        /// Collector current, mA
        double collectorCurrent;
        /// Transmitter temperature, °C
        double xmitterTemp;
        
        /// Front panel pulsewidth selector value (0-15)
        uint16_t pulsewidthSelector;
        /// Front panel PRF selector value (0-15)
        uint16_t prfSelector;
    };

    /**
     * @brief Get current status values from the transmitter.
     */
    Status getStatus();
    
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
    
    /**
     * Fill a HcrXmitStatus struct with 0.0/false values.
     * @param status the HcrXmitStatus to be cleared
     */
    void _clearStatus(Status & status);
    
    /**
     * Initialize the simulated status struct.
     */
    void _initSimStatus();
    
    /// Command byte 3 & status byte 3: Filament on?
    static const uint8_t _FILAMENT_ON_BIT 		= 0x01;
    /// Command byte 3 & status byte 3: HV on?
    static const uint8_t _HV_ON_BIT				= 0x02;
    /// Command byte 3 & status byte 3: RF on?
    static const uint8_t _RF_ON_BIT				= 0x04;
    /// Command byte 3 & status byte 3: External modulation pulse?
    static const uint8_t _EXT_MOD_PULSE_BIT		= 0x08;
    /// Command byte 3 & status byte 3: External sync pulse?
    static const uint8_t _EXT_SYNC_PULSE_BIT	= 0x10;
    /// Status byte 3: Is filament delay active?
    static const uint8_t _FILAMENT_DELAY_BIT	= 0x20;
    /// Status byte 3: Is power valid?
    static const uint8_t _POWER_VALID_BIT		= 0x40;
    /// Status byte 3: Are any faults active?
    static const uint8_t _FAULT_SUMMARY_BIT		= 0x80;
    
    /// Status byte 5: Modulator fault?
    static const uint8_t _MODULATOR_FAULT_BIT			= 0x01;
    /// Status byte 5: Sync fault?
    static const uint8_t _SYNC_FAULT_BIT				= 0x02;
    /// Status byte 5: Transmitter temperature fault?
    static const uint8_t _XMITTER_TEMP_FAULT_BIT		= 0x04;
    /// Status byte 5: Waveguide arc fault?
    static const uint8_t _WG_ARC_FAULT_BIT				= 0x08;
    /// Status byte 5: Collector current fault?
    static const uint8_t _COLLECTOR_CURRENT_FAULT_BIT	= 0x10;
    /// Status byte 5: Body current fault?
    static const uint8_t _BODY_CURRENT_FAULT_BIT		= 0x20;
    /// Status byte 5: Filament "loss of reference" fault?
    static const uint8_t _FILAMENT_LOR_FAULT_BIT		= 0x40;
    /// Status byte 5: Focus electrode "loss of reference" fault?
    static const uint8_t _FOCUS_ELECTRODE_LOR_FAULT_BIT	= 0x80;

    /// Status byte 6: Cathode "loss of reference" fault?
    static const uint8_t _CATHODE_LOR_FAULT_BIT			= 0x01;
    /// Status byte 6: Inverter overload fault?
    static const uint8_t _INVERTER_OVERLOAD_FAULT_BIT	= 0x02;
    /// Status byte 6: External interlock fault?
    static const uint8_t _EXT_INTERLOCK_FAULT_BIT		= 0x04;
    /// Status byte 6: EIK interlock fault?
    static const uint8_t _EIK_INTERLOCK_FAULT_BIT		= 0x08;

    /// Are we simulating?
    bool _simulate;
    
    /**
     *  Counter which is incremented every time we send a command to the
     * transmitter.
     */
    uint8_t _aliveCounter;
    
    /// Keep a local status struct to use when simulating.
    Status _simStatus;
    
    /// Our serial port device name (may be SIM_DEVICE)
    std::string _ttyDev;
    
    /// File descriptor for the open serial port
    int _fd;

    /// Intended transmitter state
    uint8_t _intendedState;
};

#endif /* HCRXMITTER_H_ */
