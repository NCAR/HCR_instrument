/*
 * HcrXmitter.h
 *
 *  Created on: Jan 7, 2011
 *      Author: burghart
 */

#ifndef HCRXMITTER_H_
#define HCRXMITTER_H_

#include <string>

struct HcrXmitStatus {
    bool serialConnected;

    bool filamentOn;
    bool highVoltageOn;
    bool rfOn;
    bool modPulseExternal;
    bool syncPulseExternal;
    bool filamentDelayActive;
    bool powerValid;
    bool faultSummary;
    bool frontPanelControl;
    bool rs232Control;
    bool rdsControl;
    bool modulatorFault;
    bool syncFault;
    bool xmitterTempFault;
    bool waveguideArcFault;
    bool collectorCurrentFault;
    bool bodyCurrentFault;
    bool filamentLorFault;
    bool focusElectrodeLorFault;
    bool cathodeLorFault;
    bool inverterOverloadFault;
    bool externalInterlockFault;
    bool eikInterlockFault;
    bool badChecksumReceived;
    
    double cathodeVoltage;
    double bodyCurrent;
    double collectorCurrent;
    double xmitterTemp;
    
    int panelPulsewidth;    // 0-15
    int panelPrf;           // 0-15
};

class HcrXmitter {
public:
    /**
     * @brief Construct a HcrXmitter providing access to the HCR transmitter on
     * the given serial port. If special serial port name HcrXmitter::SIM_DEVICE
     * is used, existence of the transmitter will be simulated.
     * @param ttyDev the name of the serial port connected to the transmitter.
     */
    HcrXmitter(std::string ttyDev);
    virtual ~HcrXmitter();
    
    /**
     * @brief Get current status values from the transmitter.
     */
    HcrXmitStatus getStatus(unsigned int recursion = 0);
    
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
    void setRfState(bool state);
    
    /**
     * Turn on the transmitter unit (does not enable high voltage and actual
     * transmission). A warmup period is required before high voltage can be
     * enabled.
     */
    void powerOn();
    
    /**
     * Turn off the transmitter unit. After power is turned off, the unit will
     * stay up in a cooldown mode for three minutes before all power is 
     * removed.
     */
    void powerOff();
    
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
    void _sendCommand(std::string cmd);
    
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
    void _clearStatus(HcrXmitStatus & status);
    
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
    
    // Keep a local status struct to use when simulating.
    HcrXmitStatus _simStatus;
    
    // Our serial port device name (may be SIM_DEVICE)
    std::string _ttyDev;
    
    // File descriptor for the open serial port
    int _fd;
};

#endif /* HCRXMITTER_H_ */
