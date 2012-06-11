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
    Status getStatus(unsigned int recursion = 0);
    
    /**
     * @brief Set filament state.
     * @param state boolean state: true to turn on filament, false to turn off
     * filament.
     */
    void setFilamentEnabled(bool state);
    
    /**
     * @brief Set high voltage state.
     * @param state boolean state: true to turn on HV, false to turn off
     * HV.
     */
    void setHvEnabled(bool state);
    
    /**
     * @brief Set RF state.
     * @param state boolean state: true to enable RF transmit, false to
     * disable RF transmit.
     */
    void setRfEnabled(bool state);
    
    /**
     * Reset all fault conditions.
     */
    void faultReset();
    
    /**
     * Enter "standby" state (ready to operate, but high voltage disabled).
     */
    void standby();
    
    /**
     * Enter "operate" state, with high voltage enabled and ready to transmit
     * when triggered.
     */
    void operate();
    
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
     * Is the argument string (command or reply) valid?
     * @return true iff the argument string is valid, including its checksum
     */
    bool _argValid(std::string arg);
    
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
    
    // Command strings for the transmitter
    static const std::string _OPERATE_COMMAND;
    static const std::string _STANDBY_COMMAND;
    static const std::string _RESET_COMMAND;
    static const std::string _POWERON_COMMAND;
    static const std::string _POWEROFF_COMMAND;
    static const std::string _STATUS_COMMAND;
    
    // Are we simulating?
    bool _simulate;
    
    // Counter which is incremented every time we send a command to the
    // transmitter.
    uint8_t _aliveCounter;
    
    // Keep a local status struct to use when simulating.
    Status _simStatus;
    
    // Our serial port device name (may be SIM_DEVICE)
    std::string _ttyDev;
    
    // File descriptor for the open serial port
    int _fd;
};

#endif /* HCRXMITTER_H_ */
