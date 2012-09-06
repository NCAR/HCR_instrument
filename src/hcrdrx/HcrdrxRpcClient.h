/*
 * HcrdrxRpcClient.h
 *
 *  Created on: August 13, 2012
 *      Author: burghart
 */

#ifndef HCRDRXRPCCLIENT_H_
#define HCRDRXRPCCLIENT_H_

#include <XmlRpc.h>
#include <string>

/**
 * HcrdrxRpcClient encapsulates an XML-RPC connection to an hcrdrx
 * process.
 */
class HcrdrxRpcClient : private XmlRpc::XmlRpcClient {
public:
    /**
     * Instantiate HcrdrxRpcClient to communicate with an hcrdrx process running
     * on host hcrdrxHost and using port hcrdrxPort.
     * @param hcrdrxHost the name of the host on which hcrdrx is running
     * @param hcrdrxPort the port number being used by hcrdrx
     */
    HcrdrxRpcClient(std::string hcrdrxHost, int hcrdrxPort);
    virtual ~HcrdrxRpcClient();
    
    /// Status is a class encapsulating all status values available from hcrdrx.
    class Status {
    public:
        /**
         * @brief Default constructor creates an instance with all boolean 
         * members set to false, int members set to -1, and double members 
         * set to -9999.9.
         */
        Status();
        /**
         * @brief Construct using status values extracted from the given 
         * XmlRpc::XmlRpcValue dictionary, which should come from an XML-RPC
         * getStatus() call to hcrdrx.
         */
        Status(XmlRpc::XmlRpcValue & statusDict);
        /**
         * Destructor
         */
        virtual ~Status();

        /**
         * @brief Return the transmit pulse power from the Mi-Wave 950W RF
         * detector, dBm
         * @return the transmit pulse power from the Mi-Wave 950W RF
         * detector, dBm
         */
        double detectedRfPower() const { return(_detectedRfPower); }
        /**
         * @brief Return the pressure in the fore end of the pressure vessel, hPa
         * @return the pressure in the fore end of the pressure vessel, hPa
         */
        double pvForePressure() const { return(_pvForePressure); }
        /**
         * @brief Return the pressure in the aft end of the pressure vessel, hPa
         * @return the pressure in the aft end of the pressure vessel, hPa
         */
        double pvAftPressure() const { return(_pvAftPressure); }
        /**
         * @brief Return the temperature of the 93 GHz phase-locked oscillator,
         * deg C
         * @return the temperature of the 93 GHz phase-locked oscillator,
         * deg C
         */
        double ploTemp() const { return(_ploTemp); }
        /**
         * @brief Return the temperature of the Extended Interaction Klystron
         * (EIK), deg C
         * @return the temperature of the Extended Interaction Klystron
         * (EIK), deg C
         */
        double eikTemp() const { return(_eikTemp); }
        /**
         * @brief Return the temperature of the vertical channel LNA, deg C
         * @return the temperature of the vertical channel LNA, deg C
         */
        double vLnaTemp() const { return(_vLnaTemp); }
        /**
         * @brief Return the temperature of the horizontal channel LNA, deg C
         * @return the temperature of the horizontal channel LNA, deg C
         */
        double hLnaTemp() const { return(_hLnaTemp); }
        /**
         * @brief Return the temperature of the polarization switch, deg C
         * @return the temperature of the polarization switch, deg C
         */
        double polarizationSwitchTemp() const { return(_polarizationSwitchTemp); }
        /**
         * @brief Return the temperature of the Mi-Wave 950W RF detector, deg C
         * @return the temperature of the Mi-Wave 950W RF detector, deg C
         */
        double rfDetectorTemp() const { return(_rfDetectorTemp); }
        /**
         * @brief Return the temperature of the noise source, deg C
         * @return the temperature of the noise source, deg C
         */
        double noiseSourceTemp() const { return(_noiseSourceTemp); }
        /**
         * @brief Return the temperature of the 28 V power supply, deg C
         * @return the temperature of the 28 V power supply, deg C
         */
        double ps28VTemp() const { return(_ps28VTemp); }
        /**
         * @brief Return the temperature at the input air duct for the remote
         * data system (RDS), deg C
         * @return the temperature at the input air duct for the remote data
         * system (RDS), deg C
         */
        double rdsInDuctTemp() const { return(_rdsInDuctTemp); }
        /**
         * @brief Return the temperature of the reflector rotation motor, deg C
         * @return the temperature of the reflector rotation motor, deg C
         */
        double rotationMotorTemp() const { return(_rotationMotorTemp); }
        /**
         * @brief Return the temperature of the reflector tilt motor, deg C
         * @return the temperature of the reflector tilt motor, deg C
         */
        double tiltMotorTemp() const { return(_tiltMotorTemp); }
        /**
         * @brief Return the temperature of the C-MIGITS inertial navigation
         * system, deg C
         * @return the temperature of the C-MIGITS inertial navigation system,
         * deg C
         */
        double cmigitsTemp() const { return(_cmigitsTemp); }
        /**
         * @brief Return the ambient temperature in the tailcone, deg C
         * @return the ambient temperature in the tailcone, deg C
         */
        double tailconeTemp() const { return(_tailconeTemp); }
        /**
         * @brief Return the measured voltage from the 5V power supply, V
         * @return the measured voltage from the 5V power supply, V
         */
        double psVoltage() const { return(_psVoltage); }
        /**
         * @brief Return the temperature of the Pentek signal processing FPGA,
         * deg C
         * @return the temperature of the Pentek signal processing FPGA, deg C
         */
        double pentekFpgaTemp() const { return(_pentekFpgaTemp); }
        /**
         * @brief Return the temperature of the Pentek PCB, deg C
         * @return the temperature of the Pentek PCB, deg C
         */
        double pentekBoardTemp() const { return(_pentekBoardTemp); }
        /**
         * @brief Return true iff waveguide switch A is in the "noise source"
         * position
         * @return true iff waveguide switch A is in the "noise source" position
         */
        bool noiseSourceSelected() const { return(_noiseSourceSelected); }
        /**
         * @brief Return true iff waveguide switch B is in "termination" position
         * @return true iff waveguide switch B is in "termination" position
         */
        bool terminationSelected() const { return(_terminationSelected); }
        /**
         * @brief Return true iff 15.5 GHz PLO is phase locked
         * @return true iff 15.5 GHz PLO is phase locked
         */
        bool locked15_5GHzPLO();
        /**
         * @brief Return true iff 1250 MHz PLO is phase locked
         * @return true iff 1250 MHz PLO is phase locked
         */
        bool locked1250MHzPLO() const { return(_locked1250MHzPLO); }
        /**
         * @brief Return true iff modulation pulses are being stopped at the HMC
         * and not passed through to the transmitter
         * @return true iff modulation pulses are being stopped at the HMC and
         * not passed through to the transmitter
         */
        bool modPulseDisabled() const { return(_modPulseDisabled); }
        /**
         * @brief Return true iff we are currently commanding "filament on" via
         * the RDS filament control line going to the transmitter
         * @return true iff we are currently commanding "filament on" via
         * the RDS filament control line going to the transmitter
         */
        bool rdsXmitterFilamentOn() const { return(_rdsXmitterFilamentOn); }
        /**
         * @brief Return true iff we are currently commanding "high voltage on"
         * via the RDS filament control line going to the transmitter
         * @return true iff we are currently commanding "high voltage on" via
         * the RDS filament control line going to the transmitter
         */
        bool rdsXmitterHvOn() const { return(_rdsXmitterHvOn); }
        /**
         * @brief The status value from the Health Monitoring and Control (HMC)
         * card.
        *         The values are: 0 = no errors, 1 = EMS power below threshold,
        *         2 = receiver protector switching error,
        *         3 = polarization switching error
        *  @return The status value from the Health Monitoring and Control (HMC)
        *  card.
        */
        int hmcStatus() const { return(_hmcStatus); }


    private:
        static bool _StatusBool(XmlRpc::XmlRpcValue statusDict, std::string key);
        static int _StatusInt(XmlRpc::XmlRpcValue statusDict, std::string key);
        static double _StatusDouble(XmlRpc::XmlRpcValue statusDict, std::string key);

        double _detectedRfPower;
        double _pvForePressure;
        double _pvAftPressure;
        double _ploTemp;
        double _eikTemp;
        double _vLnaTemp;
        double _hLnaTemp;
        double _polarizationSwitchTemp;
        double _rfDetectorTemp;
        double _noiseSourceTemp;
        double _ps28VTemp;
        double _rdsInDuctTemp;
        double _rotationMotorTemp;
        double _tiltMotorTemp;
        double _cmigitsTemp;
        double _tailconeTemp;
        double _psVoltage;
        double _pentekFpgaTemp;
        double _pentekBoardTemp;

        bool _noiseSourceSelected;
        bool _terminationSelected;
        bool _locked15_5GHzPLO;
        bool _locked1250MHzPLO;
        bool _modPulseDisabled;
        bool _rdsXmitterFilamentOn;
        bool _rdsXmitterHvOn;

        int _hmcStatus;
    };
    
    /**
     * @brief Return the current ClientConnectionState connection state, which
     * can be: NO_CONNECTION, CONNECTING, WRITE_REQUEST, READ_HEADER,
     * READ_RESPONSE, or IDLE.
     * @return the current ClientConnectionState connection state, which
     * can be: NO_CONNECTION, CONNECTING, WRITE_REQUEST, READ_HEADER,
     * READ_RESPONSE, or IDLE.
     */
    ClientConnectionState connectionState() const { return(_connectionState); }

    /// @brief Send an "xmitFilamentOn" command to hcrdrx
    void xmitFilamentOn();
    
    /// @brief Send a "xmitFilamentOff" command to hcrdrx
    void xmitFilamentOff();
    
    /// @brief Send an "xmitHvOn" command to hcrdrx
    void xmitHvOn();
    
    /// @brief Send a "xmitHvOff" command to hcrdrx
    void xmitHvOff();
    
    /// @brief Send "setHmcMode" command to hcrdrx
    /// @param mode integer mode number for the HMC, 0-3
    void setHmcMode(int mode);

    /**
     * @brief Send a "getStatus" command, filling a HcrdrxRpcClient::Status
     * object if
     * we get status from the hcrdrx.
     * @param status the HcrdrxRpcClient::Status object to be filled
     * @return true and fill the status object if status is obtained from
     * hcrdrx, otherwise return false and leave the status object
     * unmodified.
     */
    bool getStatus(HcrdrxRpcClient::Status & status);
    
    /**
     * Get the port number of the associated hcrdrx.
     * @return the port number of the associated hcrdrx.
     */
    int getHcrdrxPort() { return(_hcrdrxPort); }
    
    /**
     * Get the name of the host on which the associated hcrdrx is running.
     * @return the name of the host on which the associated hcrdrx is running.
     */
    std::string getHcrdrxHost() { return(_hcrdrxHost); }
    
    /**
     * Get log messages from the associated hcrdrx at and after a selected
     * index.
     * @param firstIndex[in] the first message index to include in the returned
     * log messages
     * @param msgs[out] all log messages at or later than the selected start index
     * will be appended to msgs
     * @param nextLogIndex[out] the index of the next log message after the last
     * available message is returned in nextLogIndex
     */
    void getLogMessages(unsigned int firstIndex, std::string & msgs, 
            unsigned int  & nextLogIndex);
private:
    /**
     * Execute an XML-RPC command in hcrdrx and get the result.
     * @param cmd the XML-RPC command to execute
     * @param params XmlRpc::XmlRpcValue list of parameters for the command
     * @param result reference to XmlRpc::XmlRpcValue to hold the command result
     * @return true iff the command was executed successfully
     */
    bool _executeXmlRpcCommand(const std::string cmd, 
        const XmlRpc::XmlRpcValue & params, XmlRpc::XmlRpcValue & result);
    
    std::string _hcrdrxHost;
    int _hcrdrxPort;
};

#endif /* HCRDRXRPCCLIENT_H_ */
