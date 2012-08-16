/*
 * XmitdRpcClient.h
 *
 *  Created on: Mar 11, 2011
 *      Author: burghart
 */

#ifndef XMITDRPCCLIENT_H_
#define XMITDRPCCLIENT_H_

#include <XmlRpc.h>
#include <string>

/**
 * XmitdRpcClient encapsulates an XML-RPC connection to a hcr_xmitd daemon 
 * process which is controlling the HCR transmitter.
 */
class XmitdRpcClient : private XmlRpc::XmlRpcClient {
public:
    /**
     * Instantiate XmitdRpcClient to communicate with a hcr_xmitd process running
     * on host xmitdHost and using port xmitdPort.
     * @param xmitdHost the name of the host on which hcr_xmitd is running
     * @param xmitdPort the port number being used by hcr_xmitd
     */
    XmitdRpcClient(std::string xmitdHost, int xmitdPort);
    virtual ~XmitdRpcClient();
    
    /// XmitStatus is a class encapsulating all status values available from the
    /// HCR transmitter.
    class XmitStatus {
    public:
        /**
         * @brief Default constructor creates an instance with all boolean 
         * members set to false, int members set to -1, and double members 
         * set to -9999.9.
         */
        XmitStatus();
        /**
         * @brief Construct using status values extracted from the given 
         * XmlRpc::XmlRpcValue dictionary, which should come from an XML-RPC
         * getStatus() call to hcr_xmitd.
         */
        XmitStatus(XmlRpc::XmlRpcValue & statusDict);
        /**
         * Destructor
         */
        virtual ~XmitStatus();

        /**
         * @brief Does hcr_xmitd have a serial connection to the transmitter?
         * @return true iff hcr_xmitd has a serial connection to the transmitter.
         */
        bool serialConnected() const { return(_serialConnected); }
        /**
         * @brief Is the Extended Interaction Klystron (EIK) filament on?
         * @return true iff the EIK filament is on.
         */
        bool filamentOn() const { return (_filamentOn); }
        /**
         * @brief Is high voltage on?
         * @return true iff high voltage is on.
         */
        bool highVoltageOn() const { return (_highVoltageOn); }
        /**
         * @brief Is RF enabled?
         * @return true iff RF is enabled.
         */
        bool rfOn() const { return (_rfOn); }
        /**
         * @brief Is an external modulator pulse being used?
         * @return true iff an external modulator pulse is being used.
         */
        bool modPulseExternal() const { return (_modPulseExternal); }
        /**
         * @brief Is an external sync pulse being used?
         * @return true iff an external sync pulse is being used.
         */
        bool syncPulseExternal() const { return (_syncPulseExternal); }
        /**
         * @brief Is filament delay active? Filament delay, disabling 
         * application of high voltage, is active until filament power has
         * been applied for 150 seconds or more.
         * @return true iff filament delay is active.
         */
        bool filamentDelayActive() const { return (_filamentDelayActive); }
        /**
         * @brief Is power to the transmitter valid?
         * @return true iff power to the transmitter is valid.
         */
        bool powerValid() const { return (_powerValid); }
        /**
         * @brief Is the transmitter reporting any faults?
         * @return true iff the transmitter is reporting one or more faults.
         */
        bool faultSummary() const { return (_faultSummary); }
        /**
         * @brief Is control via front panel enabled?
         * @return true iff control via front panel is enabled.
         */
        bool frontPanelCtlEnabled() const { return(_frontPanelCtlEnabled); }
        /**
         * @brief Is control via the RS-232 interface enabled?
         * @return true iff control via the RS-232 interface is enabled.
         */
        bool rs232CtlEnabled() const { return(_rs232CtlEnabled); }
        /**
         * @brief Is control via RDS enabled?
         * @return true iff control via RDS is enabled.
         */
        bool rdsCtlEnabled() const { return(_rdsCtlEnabled); }

        
        /**
         * @brief Modulator fault state.
         * @return true iff a modulator fault is detected.
         */
        bool modulatorFault() const { return (_modulatorFault); }
        /**
         * @brief Sync fault state.
         * @return true iff a sync fault is detected.
         */
        bool syncFault() const { return (_syncFault); }
        /**
         * @brief Transmitter temperature fault state.
         * @return true iff a transmitter temperature fault is detected.
         */
        bool xmitterTempFault() const { return (_xmitterTempFault); }
        /**
         * @brief Waveguide arc fault state.
         * @return true iff a waveguide arc fault is detected.
         */
        bool wgArcFault() const { return (_wgArcFault); }
        /**
         * @brief Collector current fault state.
         * @return true iff a collector current fault is detected.
         */
        bool collectorCurrFault() const { return (_collectorCurrFault); }
        /**
         * @brief Body current fault state.
         * @return true iff a body current fault is detected.
         */
        bool bodyCurrFault() const { return (_bodyCurrFault); }
        /**
         * @brief Filament "loss of reference" fault state.
         * @return true iff a filament "loss of reference" fault is detected.
         */
        bool filamentLorFault() const { return (_filamentLorFault); }
        /**
         * @brief Focus electrode "loss of reference" fault state.
         * @return true iff a focus electrode "loss of reference" fault is detected.
         */
        bool focusElectrodeLorFault() const { return (_focusElectrodeLorFault); }
        /**
         * @brief Cathode "loss of reference" fault state.
         * @return true iff a cathode "loss of reference" fault is detected.
         */
        bool cathodeLorFault() const { return (_cathodeLorFault); }
        /**
         * @brief Inverter overload fault state.
         * @return true iff an inverter overload fault is detected.
         */
        bool inverterOverloadFault() const { return (_inverterOverloadFault); }
        /**
         * @brief External interlock fault state.
         * @return true iff an external interlock fault is detected.
         */
        bool extInterlockFault() const { return (_extInterlockFault); }
        /**
         * @brief EIK interlock fault state.
         * @return true iff an EIK interlock fault is detected.
         */
        bool eikInterlockFault() const { return (_eikInterlockFault); }



        /**
         * @brief Cathode voltage
         * @return cathode voltage, in kV
         */
        double cathodeVoltage() const { return (_cathodeVoltage); }
        /**
         * @brief Body current
         * @return body current, in mA
         */
        double bodyCurrent() const { return (_bodyCurrent); }
        /**
         * @brief Collector current
         * @return collector current, in mA
         */
        double collectorCurrent() const { return (_collectorCurrent); }
        /**
         * @brief Transmitter temperature
         * @return transmitter temperature, in deg C
         */
        double xmitterTemperature() const { return (_xmitterTemp); }



        /**
         * @brief Number of modulator faults since hcr_xmitd startup.
         * @return the number of modulator faults since hcr_xmitd startup.
         */
        int modulatorFaultCount() const { return (_modulatorFaultCount); }
        /**
         * @brief Number of sync faults since hcr_xmitd startup.
         * @return the number of sync faults since hcr_xmitd startup.
         */
        int syncFaultCount() const { return (_syncFaultCount); }
        /**
         * @brief Number of transmitter temperature faults since hcr_xmitd 
         * startup.
         * @return the number of transmitter temperature faults since hcr_xmitd 
         * startup.
         */
        int xmitterTempFaultCount() const { return (_xmitterTempFaultCount); }
        /**
         * @brief Number of waveguide arc faults since hcr_xmitd startup.
         * @return the number of waveguide arc faults since hcr_xmitd startup.
         */
        int wgArcFaultCount() const { return (_wgArcFaultCount); }
        /**
         * @brief Number of collector current faults since hcr_xmitd startup.
         * @return the number of collector current faults since hcr_xmitd startup.
         */
        int collectorCurrFaultCount() const { return (_collectorCurrFaultCount); }
        /**
         * @brief Number of body current faults since hcr_xmitd startup.
         * @return the number of body current faults since hcr_xmitd startup.
         */
        int bodyCurrFaultCount() const { return (_bodyCurrFaultCount); }
        /**
         * @brief Number of filament "loss of reference" faults since hcr_xmitd 
         * startup.
         * @return the number of filament "loss of reference" faults since 
         * hcr_xmitd startup.
         */
        int filamentLorFaultCount() const { return (_filamentLorFaultCount); }
        /**
         * @brief Number of focus electrode "loss of reference" faults since 
         * hcr_xmitd startup.
         * @return the number of focus electrode "loss of reference" faults 
         * since hcr_xmitd startup.
         */
        int focusElectrodeLorFaultCount() const { return (_focusElectrodeLorFaultCount); }
        /**
         * @brief Number of cathode "loss of reference" faults since hcr_xmitd 
         * startup.
         * @return the number of cathode "loss of reference" faults since 
         * hcr_xmitd startup.
         */
        int cathodeLorFaultCount() const { return (_cathodeLorFaultCount); }
        /**
         * @brief Number of inverter overload faults since hcr_xmitd startup.
         * @return the number of inverter overload faults since hcr_xmitd startup.
         */
        int inverterOverloadFaultCount() const { return (_inverterOverloadFaultCount); }
        /**
         * @brief Number of external interlock faults since hcr_xmitd startup.
         * @return the number of external interlock faults since hcr_xmitd 
         * startup.
         */
        int extInterlockFaultCount() const { return (_extInterlockFaultCount); }
        /**
         * @brief Number of EIK interlock faults since hcr_xmitd startup.
         * @return the number of EIK interlock faults since hcr_xmitd startup.
         */
        int eikInterlockFaultCount() const { return (_eikInterlockFaultCount); }



        /**
         * Unix time of last modulator fault since hcr_xmitd startup.
         * @return the Unix time of the last modulator fault since hcr_xmitd 
         * startup.
         */
        time_t modulatorFaultTime() const { return(_modulatorFaultTime); }
        /**
         * Unix time of last sync fault since hcr_xmitd startup.
         * @return the Unix time of the last sync fault since hcr_xmitd 
         * startup.
         */
        time_t syncFaultTime() const { return(_syncFaultTime); }
        /**
         * Unix time of last transmitter temperature fault since hcr_xmitd 
         * startup.
         * @return the Unix time of the last transmitter temperature fault since
         * hcr_xmitd startup.
         */
        time_t xmitterTempFaultTime() const { return(_xmitterTempFaultTime); }
        /**
         * Unix time of last waveguide arc fault since hcr_xmitd startup.
         * @return the Unix time of the last waveguide arc fault since hcr_xmitd 
         * startup.
         */
        time_t wgArcFaultTime() const { return(_wgArcFaultTime); }
        /**
         * Unix time of last collector current fault since hcr_xmitd startup.
         * @return the Unix time of the last collector current fault since 
         * hcr_xmitd startup.
         */
        time_t collectorCurrFaultTime() const { return(_collectorCurrFaultTime); }
        /**
         * Unix time of last body current fault since hcr_xmitd startup.
         * @return the Unix time of the last body current fault since hcr_xmitd 
         * startup.
         */
        time_t bodyCurrFaultTime() const { return(_bodyCurrFaultTime); }
        /**
         * Unix time of last filament "loss of reference" fault since hcr_xmitd 
         * startup.
         * @return the Unix time of the last filament "loss of reference" fault
         * since hcr_xmitd startup.
         */
        time_t filamentLorFaultTime() const { return(_filamentLorFaultTime); }
        /**
         * Unix time of last focus electrode "loss of reference" fault since 
         * hcr_xmitd startup.
         * @return the Unix time of the last focus electrode "loss of reference"
         * fault since hcr_xmitd startup.
         */
        time_t focusElectrodeLorFaultTime() const { 
            return(_focusElectrodeLorFaultTime);
        }
        /**
         * Unix time of last cathode "loss of reference" fault since hcr_xmitd 
         * startup.
         * @return the Unix time of the last cathode "loss of reference" fault 
         * since hcr_xmitd startup.
         */
        time_t cathodeLorFaultTime() const { return(_cathodeLorFaultTime); }
        /**
         * Unix time of last inverter overload fault since hcr_xmitd startup.
         * @return the Unix time of the last inverter overload fault since 
         * hcr_xmitd startup.
         */
        time_t inverterOverloadFaultTime() const {
            return(_inverterOverloadFaultTime);
        }
        /**
         * Unix time of last external interlock fault since hcr_xmitd startup.
         * @return the Unix time of the last external interlock fault since 
         * hcr_xmitd startup.
         */
        time_t extInterlockFaultTime() const { return(_extInterlockFaultTime); }
        /**
         * Unix time of last EIK interlock fault since hcr_xmitd startup.
         * @return the Unix time of the last EIK interlock fault since hcr_xmitd 
         * startup.
         */
        time_t eikInterlockFaultTime() const { return(_eikInterlockFaultTime); }

    private:
        static bool _StatusBool(XmlRpc::XmlRpcValue statusDict, std::string key);
        static int _StatusInt(XmlRpc::XmlRpcValue statusDict, std::string key);
        static double _StatusDouble(XmlRpc::XmlRpcValue statusDict, std::string key);

        bool _serialConnected;
        
        bool _filamentOn;
        bool _highVoltageOn;
        bool _rfOn;
        bool _modPulseExternal;
        bool _syncPulseExternal;
        bool _filamentDelayActive;
        bool _powerValid;
        bool _faultSummary;
        
        bool _frontPanelCtlEnabled;
        bool _rs232CtlEnabled;
        bool _rdsCtlEnabled;

        bool _modulatorFault;
        bool _syncFault;
        bool _xmitterTempFault;
        bool _wgArcFault;
        bool _collectorCurrFault;
        bool _bodyCurrFault;
        bool _filamentLorFault;
        bool _focusElectrodeLorFault;
        bool _cathodeLorFault;
        bool _inverterOverloadFault;
        bool _extInterlockFault;
        bool _eikInterlockFault;

        int _modulatorFaultCount;
        int _syncFaultCount;
        int _xmitterTempFaultCount;
        int _wgArcFaultCount;
        int _collectorCurrFaultCount;
        int _bodyCurrFaultCount;
        int _filamentLorFaultCount;
        int _focusElectrodeLorFaultCount;
        int _cathodeLorFaultCount;
        int _inverterOverloadFaultCount;
        int _extInterlockFaultCount;
        int _eikInterlockFaultCount;

        time_t _modulatorFaultTime;
        time_t _syncFaultTime;
        time_t _xmitterTempFaultTime;
        time_t _wgArcFaultTime;
        time_t _collectorCurrFaultTime;
        time_t _bodyCurrFaultTime;
        time_t _filamentLorFaultTime;
        time_t _focusElectrodeLorFaultTime;
        time_t _cathodeLorFaultTime;
        time_t _inverterOverloadFaultTime;
        time_t _extInterlockFaultTime;
        time_t _eikInterlockFaultTime;

        double _cathodeVoltage;
        double _bodyCurrent;
        double _collectorCurrent;
        double _xmitterTemp;
    };
    
    /**
     * @brief Return the current ClientConnectionState connection state, which
     * can be: NO_CONNECTION, CONNECTING, WRITE_REQUEST, READ_HEADER,
     * READ_RESPONSE, or IDLE.
     * @return the current ClientConnectionState connection state, which
     * can be: NO_CONNECTION, CONNECTING, WRITE_REQUEST, READ_HEADER,
     * READ_RESPONSE, or IDLE.
     */
    ClientConnectionState connectionState() const { return _connectionState; }

    /**
     * @brief Send a "getStatus" command, filling a XmitdRpcClient::XmitStatus
     * object if we get status from the hcr_xmitd.
     * @param status the XmitdRpcClient::XmitStatus object to be filled
     * @return true and fill the status object if status is obtained from
     * hcr_xmitd, otherwise return false and leave the status object
     * unmodified.
     */
    bool getStatus(XmitdRpcClient::XmitStatus & status);
    
    /**
     * Get the port number of the associated hcr_xmitd.
     * @return the port number of the associated hcr_xmitd.
     */
    int getXmitdPort() { return(_xmitdPort); }
    
    /**
     * Get the name of the host on which the associated hcr_xmitd is running.
     * @return the name of the host on which the associated hcr_xmitd is running.
     */
    std::string getXmitdHost() { return(_xmitdHost); }
    
    /**
     * @brief Turn on the klystron filament.
     */
    void xmitFilamentOn();

    /**
     * @brief Turn off the klystron filament.
     */
    void xmitFilamentOff();

    /**
     * @brief Turn on transmitter high voltage.
     */
    void xmitHvOn();

    /**
     * @brief Turn off the transmitter high voltage.
     */
    void xmitHvOff();

    /**
     * Get log messages from the associated hcr_xmitd at and after a selected
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
     * Execute an XML-RPC command in hcr_xmitd and get the result.
     * @param cmd the XML-RPC command to execute
     * @param params XmlRpc::XmlRpcValue list of parameters for the command
     * @param result reference to XmlRpc::XmlRpcValue to hold the command result
     * @return true iff the command was executed successfully
     */
    bool _executeXmlRpcCommand(const std::string cmd, 
        const XmlRpc::XmlRpcValue & params, XmlRpc::XmlRpcValue & result);
    
    std::string _xmitdHost;
    int _xmitdPort;
};

#endif /* XMITDRPCCLIENT_H_ */
