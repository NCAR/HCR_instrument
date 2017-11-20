// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2016                                         
// ** University Corporation for Atmospheric Research (UCAR)                 
// ** National Center for Atmospheric Research (NCAR)                        
// ** Boulder, Colorado, USA                                                 
// ** BSD licence applies - redistribution and use in source and binary      
// ** forms, with or without modification, are permitted provided that       
// ** the following conditions are met:                                      
// ** 1) If the software is modified to produce derivative works,            
// ** such modified software should be clearly marked, so as not             
// ** to confuse it with the version available from UCAR.                    
// ** 2) Redistributions of source code must retain the above copyright      
// ** notice, this list of conditions and the following disclaimer.          
// ** 3) Redistributions in binary form must reproduce the above copyright   
// ** notice, this list of conditions and the following disclaimer in the    
// ** documentation and/or other materials provided with the distribution.   
// ** 4) Neither the name of UCAR nor the names of its contributors,         
// ** if any, may be used to endorse or promote products derived from        
// ** this software without specific prior written permission.               
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS  
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED      
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.    
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
/*
 * XmitStatus.h
 *
 *  Created on: Aug 31, 2012
 *      Author: burghart
 */

#ifndef XMITSTATUS_H_
#define XMITSTATUS_H_

#include <sstream>
#include <stdexcept>
#include <string>
#include <stdint.h>
#include <xmlrpc-c/base.hpp>
#include <boost/serialization/nvp.hpp>
#include <boost/serialization/version.hpp>

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

    /// @brief Default constructor. Boolean fields are set to false, integer
    /// fields are set to 0, and double fields are set to -99.9.
    XmitStatus();

    /// @brief Construct from a 20-byte status packet returned by the
    /// transmitter.
    /// @param xmitterPkt a 20-byte status packet returned by the transmitter
    /// @throws ConstructError if there is a problem with the status packet
    /// from the transmitter.
    XmitStatus(const uint8_t xmitterPkt[20]) throw(ConstructError);

    /// @brief Construct from an xmlrpc_c::value_struct dictionary as returned
    /// by a call to the XmitStatus::toXmlRpcValue() method.
    /// @param statusDict an xmlrpc_c::value_struct dictionary as returned by
    /// call to the XmitStatus::toXmlRpcValue() method.
    /// @throws ContructError if there is a problem unpacking the given
    /// xmlrpc_c::value_struct into an XmitStatus.
    XmitStatus(xmlrpc_c::value_struct & statusDict) throw(ConstructError);

    /// @brief destructor
    virtual ~XmitStatus();

    /// @brief Return an external representation of the object's state as
    /// an xmlrpc_c::value_struct dictionary.
    ///
    /// The returned value can be used on the other side of an XML-RPC
    /// connection to create an identical object via the
    /// XmitStatus(const xmlrpc_c::value_struct &) constructor.
    /// @return an external representation of the object's state as
    /// an xmlrpc_c::value_struct dictionary.
    xmlrpc_c::value_struct toXmlRpcValue() const;
    
    /// @brief Return a std::string representation of this object rendered as
    /// XML via the TaXml class, using the given indentation depth.
    /// @param depth the indentation depth to use in rendering the XML
    /// @return a std::string representation of this object rendered as
    /// XML via the TaXml class, using the given indentation depth.
    std::string toTaXmlString(int depth) const;

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
    ControlSource controlSource() const {
        return(static_cast<ControlSource>(_controlSource));
    }

    /// @brief Return true iff serial communication to the transmitter is connected
    /// @return true iff serial connection to the transmitter is connected
    bool serialConnected() const { return(_serialConnected); }
    
    /// @brief Return true iff the transmitter reported a bad checksum on the
    /// last communication it received.
    /// @return true iff the transmitter reported a bad checksum on the
    /// last communication it received.
    bool badChecksumReceived() const { return(_badChecksumReceived); }
    
    /// @brief Return true iff RS-232 control is enabled
    /// @return true iff RS-232 control is enabled
    bool rs232CtlEnabled() const { return(_controlSource == RS232Control); }

    /// @brief Return true iff front panel control is enabled
    /// @return true iff front panel control is enabled
    bool frontPanelCtlEnabled() const { return(_controlSource == FrontPanelControl); }

    /// @brief Return true iff RDS control is enabled
    /// @return true iff RDS control is enabled
    bool rdsCtlEnabled() const { return(_controlSource == RDSControl); }

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
     * @brief Unix time of last summary fault since hcr_xmitd startup.
     * @return the Unix time of the last summary fault since hcr_xmitd
     * startup.
     */
    static time_t summaryFaultTime() { return(_SummaryFaultTime); }
    /**
     * @brief Unix time of last modulator fault since hcr_xmitd startup.
     * @return the Unix time of the last modulator fault since hcr_xmitd
     * startup.
     */
    static time_t modulatorFaultTime() { return(_ModulatorFaultTime); }
    /**
     * @brief Unix time of last sync fault since hcr_xmitd startup.
     * @return the Unix time of the last sync fault since hcr_xmitd
     * startup.
     */
    static time_t syncFaultTime() { return(_SyncFaultTime); }
    /**
     * @brief Unix time of last transmitter temperature fault since hcr_xmitd
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
     * @brief Unix time of last collector current fault since hcr_xmitd startup.
     * @return the Unix time of the last collector current fault since
     * hcr_xmitd startup.
     */
    static time_t collectorCurrentFaultTime() { return(_CollectorCurrentFaultTime); }
    /**
     * @brief Unix time of last body current fault since hcr_xmitd startup.
     * @return the Unix time of the last body current fault since hcr_xmitd
     * startup.
     */
    static time_t bodyCurrentFaultTime() { return(_BodyCurrentFaultTime); }
    /**
     * @brief Unix time of last filament "loss of reference" fault since hcr_xmitd
     * startup.
     * @return the Unix time of the last filament "loss of reference" fault
     * since hcr_xmitd startup.
     */
    static time_t filamentLorFaultTime() { return(_FilamentLorFaultTime); }
    /**
     * @brief Unix time of last focus electrode "loss of reference" fault since
     * hcr_xmitd startup.
     * @return the Unix time of the last focus electrode "loss of reference"
     * fault since hcr_xmitd startup.
     */
    static time_t focusElectrodeLorFaultTime() {
        return(_FocusElectrodeLorFaultTime);
    }
    /**
     * @brief Unix time of last cathode "loss of reference" fault since hcr_xmitd
     * startup.
     * @return the Unix time of the last cathode "loss of reference" fault
     * since hcr_xmitd startup.
     */
    static time_t cathodeLorFaultTime() { return(_CathodeLorFaultTime); }
    /**
     * @brief Unix time of last inverter overload fault since hcr_xmitd startup.
     * @return the Unix time of the last inverter overload fault since
     * hcr_xmitd startup.
     */
    static time_t inverterOverloadFaultTime() {
        return(_InverterOverloadFaultTime);
    }
    /**
     * @brief Unix time of last external interlock fault since hcr_xmitd startup.
     * @return the Unix time of the last external interlock fault since
     * hcr_xmitd startup.
     */
    static time_t externalInterlockFaultTime() { return(_ExternalInterlockFaultTime); }
    /**
     * @brief Unix time of last EIK interlock fault since hcr_xmitd startup.
     * @return the Unix time of the last EIK interlock fault since hcr_xmitd
     * startup.
     */
    static time_t eikInterlockFaultTime() { return(_EikInterlockFaultTime); }

    /**
     * @brief Return a simulated status
     * @param filamentOn "filamentOn" state to use in the simulated status
     * @param highVoltageOn "highVoltageOn" state to use in the simulated status
     * @return a simulated status
     */
    static XmitStatus simulatedStatus(bool filamentOn, bool highVoltageOn);

    /// Current version of the XmitStatus class. This MUST be incremented if
    /// any change is made to contents handled by serialize() below.
    static const unsigned int STATUS_VERSION = 1;

private:
    friend class boost::serialization::access;
    /**
     * @brief Serialize our members to a boost save (output) archive or populate
     * our members from a boost load (input) archive.
     * @param ar the archive to load from or save to.
     * @param version the version
     */
    template<class Archive>
    void serialize(Archive & ar, const unsigned int version) {
        // We can only unmarshal if the source is using the same status version.
        if (version != STATUS_VERSION) {
            std::ostringstream oss;
            oss << "XmitStatus::serialize cannot handle version " << version <<
                   "; only version " << STATUS_VERSION << " is supported.";
            throw(std::runtime_error(oss.str()));
            abort();
        }

        // Map named entries to our member variables using serialization's
        // name/value pairs (nvp). If anything is changed in this section, be
        // sure to increment the version number in STATUS_VERSION above.
        using boost::serialization::make_nvp;
        ar & BOOST_SERIALIZATION_NVP(_serialConnected);
        ar & BOOST_SERIALIZATION_NVP(_badChecksumReceived);
        ar & BOOST_SERIALIZATION_NVP(_filamentOn);
        ar & BOOST_SERIALIZATION_NVP(_highVoltageOn);
        ar & BOOST_SERIALIZATION_NVP(_rfOn);
        ar & BOOST_SERIALIZATION_NVP(_modPulseExternal);
        ar & BOOST_SERIALIZATION_NVP(_syncPulseExternal);
        ar & BOOST_SERIALIZATION_NVP(_filamentDelayActive);
        ar & BOOST_SERIALIZATION_NVP(_psmPowerOn);
        ar & BOOST_SERIALIZATION_NVP(_controlSource);
        ar & BOOST_SERIALIZATION_NVP(_summaryFault);
        ar & BOOST_SERIALIZATION_NVP(_SummaryFaultCount);
        ar & BOOST_SERIALIZATION_NVP(_SummaryFaultTime);
        ar & BOOST_SERIALIZATION_NVP(_modulatorFault);
        ar & BOOST_SERIALIZATION_NVP(_ModulatorFaultCount);
        ar & BOOST_SERIALIZATION_NVP(_ModulatorFaultTime);
        ar & BOOST_SERIALIZATION_NVP(_syncFault);
        ar & BOOST_SERIALIZATION_NVP(_SyncFaultCount);
        ar & BOOST_SERIALIZATION_NVP(_SyncFaultTime);
        ar & BOOST_SERIALIZATION_NVP(_xmitterTempFault);
        ar & BOOST_SERIALIZATION_NVP(_XmitterTempFaultCount);
        ar & BOOST_SERIALIZATION_NVP(_XmitterTempFaultTime);
        ar & BOOST_SERIALIZATION_NVP(_waveguideArcFault);
        ar & BOOST_SERIALIZATION_NVP(_WaveguideArcFaultCount);
        ar & BOOST_SERIALIZATION_NVP(_WaveguideArcFaultTime);
        ar & BOOST_SERIALIZATION_NVP(_collectorCurrentFault);
        ar & BOOST_SERIALIZATION_NVP(_CollectorCurrentFaultCount);
        ar & BOOST_SERIALIZATION_NVP(_CollectorCurrentFaultTime);
        ar & BOOST_SERIALIZATION_NVP(_bodyCurrentFault);
        ar & BOOST_SERIALIZATION_NVP(_BodyCurrentFaultCount);
        ar & BOOST_SERIALIZATION_NVP(_BodyCurrentFaultTime);
        ar & BOOST_SERIALIZATION_NVP(_filamentLorFault);
        ar & BOOST_SERIALIZATION_NVP(_FilamentLorFaultCount);
        ar & BOOST_SERIALIZATION_NVP(_FilamentLorFaultTime);
        ar & BOOST_SERIALIZATION_NVP(_focusElectrodeLorFault);
        ar & BOOST_SERIALIZATION_NVP(_FocusElectrodeLorFaultCount);
        ar & BOOST_SERIALIZATION_NVP(_FocusElectrodeLorFaultTime);
        ar & BOOST_SERIALIZATION_NVP(_cathodeLorFault);
        ar & BOOST_SERIALIZATION_NVP(_CathodeLorFaultCount);
        ar & BOOST_SERIALIZATION_NVP(_CathodeLorFaultTime);
        ar & BOOST_SERIALIZATION_NVP(_inverterOverloadFault);
        ar & BOOST_SERIALIZATION_NVP(_InverterOverloadFaultCount);
        ar & BOOST_SERIALIZATION_NVP(_InverterOverloadFaultTime);
        ar & BOOST_SERIALIZATION_NVP(_externalInterlockFault);
        ar & BOOST_SERIALIZATION_NVP(_ExternalInterlockFaultCount);
        ar & BOOST_SERIALIZATION_NVP(_ExternalInterlockFaultTime);
        ar & BOOST_SERIALIZATION_NVP(_eikInterlockFault);
        ar & BOOST_SERIALIZATION_NVP(_EikInterlockFaultCount);
        ar & BOOST_SERIALIZATION_NVP(_EikInterlockFaultTime);
        ar & BOOST_SERIALIZATION_NVP(_cathodeVoltage);
        ar & BOOST_SERIALIZATION_NVP(_bodyCurrent);
        ar & BOOST_SERIALIZATION_NVP(_collectorCurrent);
        ar & BOOST_SERIALIZATION_NVP(_xmitterTemp);
    }

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
    static const uint8_t _SUMMARY_FAULT_BIT     = 0x80;

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
     * @brief Keep around a copy of the last XmitStatus created from a transmitter
     * reply packet.
     */
    static XmitStatus _PrevStatus;

    /// Is serial communication to the transmitter connected?
    bool _serialConnected;
    
    /// Was there a bad checksum on the last communication to the
    /// transmitter?
    bool _badChecksumReceived;

    /// Which control source is selected on the front panel?
    uint16_t _controlSource;

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

// Increment this class version number when member variables are changed.
BOOST_CLASS_VERSION(XmitStatus, XmitStatus::STATUS_VERSION)

#endif /* XMITSTATUS_H_ */
