/*
 * XmitStatus.h
 *
 *  Created on: Aug 31, 2012
 *      Author: burghart
 */

#ifndef XMITSTATUS_H_
#define XMITSTATUS_H_

#include <exception>
#include <string>
#include <stdint.h>
#include <XmlRpc.h>

using namespace XmlRpc;

/// @brief Class to represent HCR transmitter status.
class XmitStatus {
public:
    /// @brief This is a subclass of std::exception thrown when there is a
    /// problem in XmitStatus construction.
    ///
    /// Use what() to get a description of the thrown exception.
    class ConstructError : public std::exception {
    public:
        ConstructError(std::string msg) throw() : std::exception(), _msg(msg) {}
        virtual ~ConstructError() throw() {}
        /// @brief Returns a null terminated character sequence containing a
        /// generic description of the exception.
        /// @return a null terminated character sequence containing a
        /// description of the exception.
        virtual const char* what() const throw() { return(_msg.c_str()); }
    private:
        std::string _msg;
    };

    /// @brief Construct from a 20-byte status packet returned by the
    /// transmitter.
    /// @param xmitterPkt a 20-byte status packet returned by the transmitter
    /// @throws ConstructError if there is a problem with the status packet
    /// from the transmitter.
    XmitStatus(const uint8_t xmitterPkt[20]) throw(ConstructError);

    /// @brief Construct from an XmlRpcValue dictionary as returned by a call
    /// to the XmitStatus::toXmlRpcValue() method.
    /// @param statusDict an XmlRpcValue dictionary as returned by call to the
    /// XmitStatus::toXmlRpcValue() method.
    /// @throws ContructError if there is a problem unpacking the given
    /// XmlRpcValue into an XmitStatus.
    XmitStatus(XmlRpcValue & statusDict) throw(ConstructError);

    /// @brief destructor
    virtual ~XmitStatus();

    /// @brief Return an external representation of the object's state as
    /// an XmlRpcValue dictionary.
    ///
    /// The returned value can be used on the other side of an XML-RPC
    /// connection to create an identical object via the
    /// XmitStatus(const XmlRpcValue &) constructor.
    /// @return an external representation of the object's state as
    /// an XmlRpcValue dictionary.
    XmlRpcValue toXmlRpcValue() const;

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

    /// @brief Return the control source selected on the CMU front panel.
    /// @return the control source selected on the CMU front panel.
    ControlSource controlSource() const { return(_controlSource); }

    /// @brief return true iff the EIK filament is on.
    /// @return true iff the EIK filament is on.
    bool filamentOn() const { return(_filamentOn); }

    /// @brief return true iff the EIK high voltage is on.
    /// @return true iff the EIK high voltage is on.
    bool highVoltageOn() const { return(_highVoltageOn); }

    /// @brief return true iff the CMU reports RF is on.
    /// @return true iff the CMU reports RF is on.
    bool rfOn() const { return(_rfOn); }

    /// @brief Return true iff external modulation pulse selected.
    /// @return true iff external modulation pulse selected.
    bool modPulseExternal() const { return(_modPulseExternal); }

    /// @brief Return true iff external sync pulse selected.
    /// @return true iff external sync pulse selected.
    bool syncPulseExternal() const { return(_syncPulseExternal); }

    /// @brief Return true iff the EIK filament delay is active. I.e., is the
    /// filament not yet warm?
    ///
    /// This will be true until the filament has been turned on for at least
    /// 150 seconds. High voltage cannot be applied until the delay is no
    /// longer active.
    /// @return True iff EIK filament delay is active.
    bool filamentDelayActive() const { return(_filamentDelayActive); }

    /// @brief Return true iff PSM power if on.
    /// @return true iff PSM power is on.
    bool psmPowerOn() const { return(_psmPowerOn); }

    /// @brief Return true iff there is a summary fault.
    /// @return true iff there is a summary fault.
    bool summaryFault() const { return(_summaryFault); }

    /// @brief Return true iff there is a modulator fault.
    /// @return true iff there is a modulator fault.
    bool modulatorFault() const { return(_modulatorFault); }

    /// @brief Return true iff there is a sync fault.
    /// @return true iff there is a sync fault.
    bool syncFault() const { return(_syncFault); }

    /// @brief Return true iff there is a transmitter temperature fault.
    /// @return true iff there is a transmitter temperature fault.
    bool xmitterTempFault() const { return(_xmitterTempFault); }

    /// @brief Return true iff there is a waveguide arc fault.
    /// @return true iff there is a waveguide arc fault.
    bool waveguideArcFault() const { return(_waveguideArcFault); }

    /// @brief Return true iff there is a collector current fault.
    /// @return true iff there is a collector current fault.
    bool collectorCurrentFault() const { return(_collectorCurrentFault); }

    /// @brief Return true iff there is a body current fault.
    /// @return true iff there is a body current fault.
    bool bodyCurrentFault() const { return(_bodyCurrentFault); }

    /// @brief Return true iff there is a filament "loss of reference" fault.
    /// @return true iff there is a filament "loss of reference" fault.
    bool filamentLorFault() const { return(_filamentLorFault); }

    /// @brief Return true iff there is a focus electrode "loss of reference" fault.
    /// @return true iff there is a focus electrode "loss of reference" fault.
    bool focusElectrodeLorFault() const { return(_focusElectrodeLorFault); }

    /// @brief Return true iff there is a cathode "loss of reference" fault.
    /// @return true iff there is a cathode "loss of reference" fault.
    bool cathodeLorFault() const { return(_cathodeLorFault); }

    /// @brief Return true iff there is an inverter overload fault.
    /// @return true iff there is an inverter overload fault.
    bool inverterOverloadFault() const { return(_inverterOverloadFault); }

    /// @brief Return true iff there is an external interlock fault.
    /// @return true iff there is an external interlock fault.
    bool externalInterlockFault() const { return(_externalInterlockFault); }

    /// @brief Return true iff there is an EIK interlock fault.
    /// @return true iff there is an EIK interlock fault.
    bool eikInterlockFault() const { return(_eikInterlockFault); }

    /// @brief Return cathode voltage, kV
    /// @return cathode voltage, kV
    double cathodeVoltage() const { return(_cathodeVoltage); }

    /// @brief return body current, mA
    /// @return body current, mA
    double bodyCurrent() const { return(_bodyCurrent); }

    /// @brief return collector current, mA
    /// @return collector current, mA
    double collectorCurrent() const { return(_collectorCurrent); }

    /// @brief return transmitter temperature, deg C
    /// @return transmitter temperature, deg C
    double xmitterTemp() const { return(_xmitterTemp); }

    /// @brief Return front panel pulsewidth selector value (0-15)
    /// @return front panel pulsewidth selector value (0-15)
    uint16_t pulsewidthSelector() const { return(_pulsewidthSelector); }

    /// @brief return front panel PRF selector value (0-15)
    /// @return front panel PRF selector value (0-15)
    uint16_t prfSelector() const { return(_prfSelector); }

    /**
     * @brief Number of summary faults since hcr_xmitd startup.
     * @return the number of summary faults since hcr_xmitd startup.
     */
    static int summaryFaultCount() { return (_SummaryFaultCount); }
    /**
     * @brief Number of modulator faults since hcr_xmitd startup.
     * @return the number of modulator faults since hcr_xmitd startup.
     */
    static int modulatorFaultCount() { return (_ModulatorFaultCount); }
    /**
     * @brief Number of sync faults since hcr_xmitd startup.
     * @return the number of sync faults since hcr_xmitd startup.
     */
    static int syncFaultCount() { return (_SyncFaultCount); }
    /**
     * @brief Number of transmitter temperature faults since hcr_xmitd
     * startup.
     * @return the number of transmitter temperature faults since hcr_xmitd
     * startup.
     */
    static int xmitterTempFaultCount() { return (_XmitterTempFaultCount); }
    /**
     * @brief Number of waveguide arc faults since hcr_xmitd startup.
     * @return the number of waveguide arc faults since hcr_xmitd startup.
     */
    static int waveguideArcFaultCount() { return (_WaveguideArcFaultCount); }
    /**
     * @brief Number of collector current faults since hcr_xmitd startup.
     * @return the number of collector current faults since hcr_xmitd startup.
     */
    static int collectorCurrentFaultCount() { return (_CollectorCurrentFaultCount); }
    /**
     * @brief Number of body current faults since hcr_xmitd startup.
     * @return the number of body current faults since hcr_xmitd startup.
     */
    static int bodyCurrentFaultCount() { return (_BodyCurrentFaultCount); }
    /**
     * @brief Number of filament "loss of reference" faults since hcr_xmitd
     * startup.
     * @return the number of filament "loss of reference" faults since
     * hcr_xmitd startup.
     */
    static int filamentLorFaultCount() { return (_FilamentLorFaultCount); }
    /**
     * @brief Number of focus electrode "loss of reference" faults since
     * hcr_xmitd startup.
     * @return the number of focus electrode "loss of reference" faults
     * since hcr_xmitd startup.
     */
    static int focusElectrodeLorFaultCount() { return (_FocusElectrodeLorFaultCount); }
    /**
     * @brief Number of cathode "loss of reference" faults since hcr_xmitd
     * startup.
     * @return the number of cathode "loss of reference" faults since
     * hcr_xmitd startup.
     */
    static int cathodeLorFaultCount() { return (_CathodeLorFaultCount); }
    /**
     * @brief Number of inverter overload faults since hcr_xmitd startup.
     * @return the number of inverter overload faults since hcr_xmitd startup.
     */
    static int inverterOverloadFaultCount() { return (_InverterOverloadFaultCount); }
    /**
     * @brief Number of external interlock faults since hcr_xmitd startup.
     * @return the number of external interlock faults since hcr_xmitd
     * startup.
     */
    static int externalInterlockFaultCount() { return (_ExternalInterlockFaultCount); }
    /**
     * @brief Number of EIK interlock faults since hcr_xmitd startup.
     * @return the number of EIK interlock faults since hcr_xmitd startup.
     */
    static int eikInterlockFaultCount() { return (_EikInterlockFaultCount); }



    /**
     * Unix time of last summary fault since hcr_xmitd startup.
     * @return the Unix time of the last summary fault since hcr_xmitd
     * startup.
     */
    static time_t summaryFaultTime() { return(_SummaryFaultTime); }
    /**
     * Unix time of last modulator fault since hcr_xmitd startup.
     * @return the Unix time of the last modulator fault since hcr_xmitd
     * startup.
     */
    static time_t modulatorFaultTime() { return(_ModulatorFaultTime); }
    /**
     * Unix time of last sync fault since hcr_xmitd startup.
     * @return the Unix time of the last sync fault since hcr_xmitd
     * startup.
     */
    static time_t syncFaultTime() { return(_SyncFaultTime); }
    /**
     * Unix time of last transmitter temperature fault since hcr_xmitd
     * startup.
     * @return the Unix time of the last transmitter temperature fault since
     * hcr_xmitd startup.
     */
    static time_t xmitterTempFaultTime() { return(_XmitterTempFaultTime); }
    /**
     * Unix time of last waveguide arc fault since hcr_xmitd startup.
     * @return the Unix time of the last waveguide arc fault since hcr_xmitd
     * startup.
     */
    static time_t waveguideArcFaultTime() { return(_WaveguideArcFaultTime); }
    /**
     * Unix time of last collector current fault since hcr_xmitd startup.
     * @return the Unix time of the last collector current fault since
     * hcr_xmitd startup.
     */
    static time_t collectorCurrentFaultTime() { return(_CollectorCurrentFaultTime); }
    /**
     * Unix time of last body current fault since hcr_xmitd startup.
     * @return the Unix time of the last body current fault since hcr_xmitd
     * startup.
     */
    static time_t bodyCurrentFaultTime() { return(_BodyCurrentFaultTime); }
    /**
     * Unix time of last filament "loss of reference" fault since hcr_xmitd
     * startup.
     * @return the Unix time of the last filament "loss of reference" fault
     * since hcr_xmitd startup.
     */
    static time_t filamentLorFaultTime() { return(_FilamentLorFaultTime); }
    /**
     * Unix time of last focus electrode "loss of reference" fault since
     * hcr_xmitd startup.
     * @return the Unix time of the last focus electrode "loss of reference"
     * fault since hcr_xmitd startup.
     */
    static time_t focusElectrodeLorFaultTime() {
        return(_FocusElectrodeLorFaultTime);
    }
    /**
     * Unix time of last cathode "loss of reference" fault since hcr_xmitd
     * startup.
     * @return the Unix time of the last cathode "loss of reference" fault
     * since hcr_xmitd startup.
     */
    static time_t cathodeLorFaultTime() { return(_CathodeLorFaultTime); }
    /**
     * Unix time of last inverter overload fault since hcr_xmitd startup.
     * @return the Unix time of the last inverter overload fault since
     * hcr_xmitd startup.
     */
    static time_t inverterOverloadFaultTime() {
        return(_InverterOverloadFaultTime);
    }
    /**
     * Unix time of last external interlock fault since hcr_xmitd startup.
     * @return the Unix time of the last external interlock fault since
     * hcr_xmitd startup.
     */
    static time_t externalInterlockFaultTime() { return(_ExternalInterlockFaultTime); }
    /**
     * Unix time of last EIK interlock fault since hcr_xmitd startup.
     * @return the Unix time of the last EIK interlock fault since hcr_xmitd
     * startup.
     */
    static time_t eikInterlockFaultTime() { return(_EikInterlockFaultTime); }
private:
    /// @brief Return the boolean value associated with statusDict[key]
    /// @param statusDict the XmlRpcValue status dictionary
    /// @param key the key for the desired value
    /// @return the boolean value associated with statusDict[key]
    /// @throws ConstructError if the key does not exist in the dictionary or
    /// there is another problem with the XmlRpcValue
    static bool _StatusBool(XmlRpcValue & statusDict,
            std::string key) throw(ConstructError);

    /// @brief Return the int value associated with statusDict[key]
    /// @param statusDict the XmlRpcValue status dictionary
    /// @param key the key for the desired value
    /// @return the int value associated with statusDict[key]
    /// @throws ConstructError if the key does not exist in the dictionary or
    /// there is another problem with the XmlRpcValue
    static int _StatusInt(XmlRpcValue & statusDict,
            std::string key) throw(ConstructError);

    /// @brief Return the double value associated with statusDict[key]
    /// @param statusDict the XmlRpcValue status dictionary
    /// @param key the key for the desired value
    /// @return the double value associated with statusDict[key]
    /// @throws ConstructError if the key does not exist in the dictionary or
    /// there is another problem with the XmlRpcValue
    static double _StatusDouble(XmlRpcValue & statusDict,
            std::string key) throw(ConstructError);

    /// Status byte 3: Filament on?
    static const uint8_t _FILAMENT_ON_BIT       = 0x01;
    /// Status byte 3: HV on?
    static const uint8_t _HV_ON_BIT             = 0x02;
    /// Status byte 3: RF on?
    static const uint8_t _RF_ON_BIT             = 0x04;
    /// Status byte 3: External modulation pulse?
    static const uint8_t _EXT_MOD_PULSE_BIT     = 0x08;
    /// Status byte 3: External sync pulse?
    static const uint8_t _EXT_SYNC_PULSE_BIT    = 0x10;
    /// Status byte 3: Is filament delay active?
    static const uint8_t _FILAMENT_DELAY_BIT    = 0x20;
    /// Status byte 3: Is power valid?
    static const uint8_t _POWER_VALID_BIT       = 0x40;
    /// Status byte 3: Are any faults active?
    static const uint8_t _FAULT_SUMMARY_BIT     = 0x80;

    /// Status byte 5: Modulator fault?
    static const uint8_t _MODULATOR_FAULT_BIT           = 0x01;
    /// Status byte 5: Sync fault?
    static const uint8_t _SYNC_FAULT_BIT                = 0x02;
    /// Status byte 5: Transmitter temperature fault?
    static const uint8_t _XMITTER_TEMP_FAULT_BIT        = 0x04;
    /// Status byte 5: Waveguide arc fault?
    static const uint8_t _WG_ARC_FAULT_BIT              = 0x08;
    /// Status byte 5: Collector current fault?
    static const uint8_t _COLLECTOR_CURRENT_FAULT_BIT   = 0x10;
    /// Status byte 5: Body current fault?
    static const uint8_t _BODY_CURRENT_FAULT_BIT        = 0x20;
    /// Status byte 5: Filament "loss of reference" fault?
    static const uint8_t _FILAMENT_LOR_FAULT_BIT        = 0x40;
    /// Status byte 5: Focus electrode "loss of reference" fault?
    static const uint8_t _FOCUS_ELECTRODE_LOR_FAULT_BIT = 0x80;

    /// Status byte 6: Cathode "loss of reference" fault?
    static const uint8_t _CATHODE_LOR_FAULT_BIT         = 0x01;
    /// Status byte 6: Inverter overload fault?
    static const uint8_t _INVERTER_OVERLOAD_FAULT_BIT   = 0x02;
    /// Status byte 6: External interlock fault?
    static const uint8_t _EXT_INTERLOCK_FAULT_BIT       = 0x04;
    /// Status byte 6: EIK interlock fault?
    static const uint8_t _EIK_INTERLOCK_FAULT_BIT       = 0x08;

    // Static fault counters. These are updated as new XmitStatus objects
    // are instantiated via the XmitStatus(uint8_t xmitterPkt[20])
    // constructor.
    static int _SummaryFaultCount;
    static int _ModulatorFaultCount;
    static int _SyncFaultCount;
    static int _XmitterTempFaultCount;
    static int _WaveguideArcFaultCount;
    static int _CollectorCurrentFaultCount;
    static int _BodyCurrentFaultCount;
    static int _FilamentLorFaultCount;
    static int _FocusElectrodeLorFaultCount;
    static int _CathodeLorFaultCount;
    static int _InverterOverloadFaultCount;
    static int _ExternalInterlockFaultCount;
    static int _EikInterlockFaultCount;

    // Latest fault times. These are updated as new XmitStatus objects
    // are instantiated via the XmitStatus(uint8_t xmitterPkt[20])
    // constructor.
    static time_t _SummaryFaultTime;
    static time_t _ModulatorFaultTime;
    static time_t _SyncFaultTime;
    static time_t _XmitterTempFaultTime;
    static time_t _WaveguideArcFaultTime;
    static time_t _CollectorCurrentFaultTime;
    static time_t _BodyCurrentFaultTime;
    static time_t _FilamentLorFaultTime;
    static time_t _FocusElectrodeLorFaultTime;
    static time_t _CathodeLorFaultTime;
    static time_t _InverterOverloadFaultTime;
    static time_t _ExternalInterlockFaultTime;
    static time_t _EikInterlockFaultTime;

    /**
     *  @brief Which control source is selected on the front panel?
     */
    ControlSource _controlSource;

    /// EIK filament on?
    bool _filamentOn;
    /// High voltage on?
    bool _highVoltageOn;
    /// RF on?
    bool _rfOn;
    /// Is external modulation pulse selected?
    bool _modPulseExternal;
    /// Is external sync pulse selected?
    bool _syncPulseExternal;
    /**
     * @brief Is the EIK filament delay active? I.e., is the filament not
     * yet warm?
     *
     * This will be true until the filament has been turned on for at least
     * 150 seconds. High voltage cannot be applied until the delay is no
     * longer active.
     */
    bool _filamentDelayActive;
    /// Is PSM power on?
    bool _psmPowerOn;
    /// Is there a summary fault?
    bool _summaryFault;
    /// Is there a modulator fault?
    bool _modulatorFault;
    /// Is there a sync fault?
    bool _syncFault;
    /// Is there a transmitter temperature fault?
    bool _xmitterTempFault;
    /// Is there a waveguide arc fault?
    bool _waveguideArcFault;
    /// Is there a collector current fault?
    bool _collectorCurrentFault;
    /// Is there a body current fault?
    bool _bodyCurrentFault;
    /// Is there a filament "loss of reference" fault?
    bool _filamentLorFault;
    /// Is there a focus electrode "loss of reference" fault?
    bool _focusElectrodeLorFault;
    /// Is there a cathode "loss of reference" fault?
    bool _cathodeLorFault;
    /// Is there an inverter overload fault?
    bool _inverterOverloadFault;
    /// Is there an external interlock fault?
    bool _externalInterlockFault;
    /// Is there an EIK interlock fault?
    bool _eikInterlockFault;
    /// Was there a bad checksum on the last communication to the
    /// transmitter?
    bool _badChecksumReceived;

    /// Cathode voltage, kV
    double _cathodeVoltage;
    /// Body current, mA
    double _bodyCurrent;
    /// Collector current, mA
    double _collectorCurrent;
    /// Transmitter temperature, deg C
    double _xmitterTemp;

    /// Front panel pulsewidth selector value (0-15)
    uint16_t _pulsewidthSelector;
    /// Front panel PRF selector value (0-15)
    uint16_t _prfSelector;
};

#endif /* XMITSTATUS_H_ */
