/*
 * hcr_xmitd.cpp
 *
 *  Created on: Jan 5, 2011
 *      Author: burghart
 */

#include <string>
#include <cerrno>
#include <csignal>
#include <cstring>
#include <cstdlib>
#include <ctime>
#include <deque>
#include <vector>
#include <unistd.h>
#include <sys/time.h>
#include <sys/types.h>
#include <boost/program_options.hpp>

#include <toolsa/pmu.h>
#include <logx/Logging.h>
#include <log4cpp/SyslogAppender.hh>
#include <RecentHistoryAppender.h>

#include <XmlRpc.h>

#include "HcrXmitter.h"
#include "../hcrdrx/HcrPmc730.h"

namespace po = boost::program_options;

LOGGING("hcr_xmitd")

/// Our transmitter
HcrXmitter *Xmitter = 0;
/// Current transmitter status
HcrXmitter::Status XmitStatus;

/// Our RPC server
using namespace XmlRpc;
XmlRpcServer RpcServer;

/// XML-RPC struct (dictionary) with last values received from the transmitter
/// (see documentation for GetStatusMethod below)
XmlRpcValue StatusDict;

/// What was the last time we saw the transmitter in "operate" mode?
time_t LastOperateTime = 0;

// Fault counters
int ModulatorFaultCount = 0;
int SyncFaultCount = 0;
int XmitterTempFaultCount = 0;
int WgArcFaultCount = 0;
int CollectorCurrFaultCount = 0;
int BodyCurrFaultCount = 0;
int FilamentLorFaultCount = 0;
int FocusElectrodeLorFaultCount = 0;
int CathodeLorFaultCount = 0;
int InverterOverloadFaultCount = 0;
int ExtInterlockFaultCount = 0;
int EikInterlockFaultCount = 0;

// Latest fault times
time_t ModulatorFaultTime = -1;
time_t SyncFaultTime = -1;
time_t XmitterTempFaultTime = -1;
time_t WgArcFaultTime = -1;
time_t CollectorCurrFaultTime = -1;
time_t BodyCurrFaultTime = -1;
time_t FilamentLorFaultTime = -1;
time_t FocusElectrodeLorFaultTime = -1;
time_t CathodeLorFaultTime = -1;
time_t InverterOverloadFaultTime = -1;
time_t ExtInterlockFaultTime = -1;
time_t EikInterlockFaultTime = -1;

// log4cpp Appender which keeps around the 50 most recent log messages. 
logx::RecentHistoryAppender RecentLogHistory("RecentHistoryAppender", 50);

// Description of command line options
po::options_description OptionsDesc("Options");

/// Run in foreground?
bool Foreground = false;

/// Instance name for procmap
std::string InstanceName = "";

/// Host and port for XMLRPC comminucation with the hcrdrx process
std::string HcrdrxHost = "localhost";
int HcrdrxPort = 8081;

/**
 * @brief Xmlrpc++ method to get transmitter status from hcr_xmitd. 
 *
 * The method returns a XmlRpc::XmlRpcValue struct (dictionary) mapping 
 * std::string keys to XmlRpc::XmlRpcValue values. The dictionary will 
 * contain:
 * <table border>
 *   <tr>
 *     <td><b>key</b></td>
 *     <td><b>value type</b></td>
 *     <td><b>value</b></td>
 *   </tr>
 *   <tr>
 *     <td>serial_connected</td>
 *     <td>bool</td>
 *     <td>Is the transmitter serial port connected and responding?</td>
 *   </tr>
 *   <tr>
 *     <td>filament_on</td>
 *     <td>bool</td>
 *     <td>EIK filament on?</td>
 *   </tr>
 *   <tr>
 *     <td>high_voltage_on</td>
 *     <td>bool</td>
 *     <td>High voltage on?</td>
 *   </tr>
 *   <tr>
 *     <td>rf_on</td>
 *     <td>bool</td>
 *     <td>RF on?</td>
 *   </tr>
 *   <tr>
 *     <td>mod_pulse_external</td>
 *     <td>bool</td>
 *     <td>Is external modulation pulse selected?</td>
 *   </tr>
 *   <tr>
 *     <td>sync_pulse_external</td>
 *     <td>bool</td>
 *     <td>Is external sync pulse selected?</td>
 *   </tr>
 *   <tr>
 *     <td>filament_delay_active</td>
 *     <td>bool</td>
 *     <td>Is the EIK filament delay active? I.e., is the filament not yet warm?</td>
 *   </tr>
 *   <tr>
 *     <td>power_valid</td>
 *     <td>bool</td>
 *     <td>Is power valid?</td>
 *   </tr>
 *   <tr>
 *     <td>fault_summary</td>
 *     <td>bool</td>
 *     <td>This is true if any fault is currently active.</td>
 *   </tr>
 *   <tr>
 *     <td>front_panel_control_enabled</td>
 *     <td>bool</td>
 *     <td>Is control via the front panel enabled?</td>
 *   </tr>
 *   <tr>
 *     <td>rs232_control_enabled</td>
 *     <td>bool</td>
 *     <td>Is control via the RS-232 serial port enabled?</td>
 *   </tr>
 *   <tr>
 *     <td>rds_control_enabled</td>
 *     <td>bool</td>
 *     <td>Is control via the Radar Data System (RDS) enabled?</td>
 *   </tr>
 *   <tr>
 *     <td>modulator_fault</td>
 *     <td>bool</td>
 *     <td>Is there a modulator fault?</td>
 *   </tr>
 *   <tr>
 *     <td>sync_fault</td>
 *     <td>bool</td>
 *     <td>Is there a sync fault?</td>
 *   </tr>
 *   <tr>
 *     <td>xmitter_temp_fault</td>
 *     <td>bool</td>
 *     <td>Is there a transmitter temperature fault?</td>
 *   </tr>
 *   <tr>
 *     <td>waveguide_arc_fault</td>
 *     <td>bool</td>
 *     <td>Is there a waveguide arc fault?</td>
 *   </tr>
 *   <tr>
 *     <td>collector_current_fault</td>
 *     <td>bool</td>
 *     <td>Is there a collector current fault?</td>
 *   </tr>
 *   <tr>
 *     <td>body_current_fault</td>
 *     <td>bool</td>
 *     <td>Is there a body current fault?</td>
 *   </tr>
 *   <tr>
 *     <td>filament_lor_fault</td>
 *     <td>bool</td>
 *     <td>Is there a filament "loss of reference" fault?</td>
 *   </tr>
 *   <tr>
 *     <td>focus_electrode_lor_fault</td>
 *     <td>bool</td>
 *     <td>Is there a focus electrode "loss of reference" fault?</td>
 *   </tr>
 *   <tr>
 *     <td>cathode_lor_fault</td>
 *     <td>bool</td>
 *     <td>Is there a cathode "loss of reference" fault?</td>
 *   </tr>
 *   <tr>
 *     <td>inverter_overload_fault</td>
 *     <td>bool</td>
 *     <td>Is there an inverter overload fault?</td>
 *   </tr>
 *   <tr>
 *     <td>external_interlock_fault</td>
 *     <td>bool</td>
 *     <td>Is there an external interlock fault?</td>
 *   </tr>
 *   <tr>
 *     <td>eik_interlock_fault</td>
 *     <td>bool</td>
 *     <td>Is there an EIK interlock fault?</td>
 *   </tr>
 *   <tr>
 *     <td>cathode_voltage</td>
 *     <td>double</td>
 *     <td>cathode voltage, kV</td>
 *   </tr>
 *   <tr>
 *     <td>body_current</td>
 *     <td>double</td>
 *     <td>body current, mA</td>
 *   </tr>
 *   <tr>
 *     <td>collector_current</td>
 *     <td>double</td>
 *     <td>collector current, mA</td>
 *   </tr>
 *   <tr>
 *     <td>xmitter_temp</td>
 *     <td>double</td>
 *     <td>transmitter temperature, degrees C</td>
 *   </tr>
 *   <tr>
 *     <td>modulator_fault_count</td>
 *     <td>int</td>
 *     <td>Count of modulator faults since startup</td>
 *   </tr>
 *   <tr>
 *     <td>sync_fault_count</td>
 *     <td>int</td>
 *     <td>Count of sync faults since startup</td>
 *   </tr>
 *   <tr>
 *     <td>xmitter_temp_fault_count</td>
 *     <td>int</td>
 *     <td>Count of transmitter temperature faults since startup</td>
 *   </tr>
 *   <tr>
 *     <td>waveguide_arc_fault_count</td>
 *     <td>int</td>
 *     <td>Count of waveguide arc faults since startup</td>
 *   </tr>
 *   <tr>
 *     <td>collector_current_fault_count</td>
 *     <td>int</td>
 *     <td>Count of collector current faults since startup</td>
 *   </tr>
 *   <tr>
 *     <td>body_current_fault_count</td>
 *     <td>int</td>
 *     <td>Count of body current faults since startup</td>
 *   </tr>
 *   <tr>
 *     <td>filament_lor_fault_count</td>
 *     <td>int</td>
 *     <td>Count of filament "loss of reference" faults since startup</td>
 *   </tr>
 *   <tr>
 *     <td>focus_electrode_lor_fault_count</td>
 *     <td>int</td>
 *     <td>Count of focus electrod "loss of reference" faults since startup</td>
 *   </tr>
 *   <tr>
 *     <td>cathode_lor_fault_count</td>
 *     <td>int</td>
 *     <td>Count of cathode "loss of reference" faults since startup</td>
 *   </tr>
 *   <tr>
 *     <td>inverter_overload_fault_count</td>
 *     <td>int</td>
 *     <td>Count of inverter overload faults since startup</td>
 *   </tr>
 *   <tr>
 *     <td>external_interlock_fault_count</td>
 *     <td>int</td>
 *     <td>Count of external interlock faults since startup</td>
 *   </tr>
 *   <tr>
 *     <td>eik_interlock_fault_count</td>
 *     <td>int</td>
 *     <td>Count of EIK interlock faults since startup</td>
 *   </tr>
 *   <tr>
 *     <td>modulator_fault_time</td>
 *     <td>int</td>
 *     <td>Unix time of last modulator fault seen</td>
 *   </tr>
 *   <tr>
 *     <td>sync_fault_time</td>
 *     <td>int</td>
 *     <td>Unix time of last sync fault seen</td>
 *   </tr>
 *   <tr>
 *     <td>xmitter_temp_fault_time</td>
 *     <td>int</td>
 *     <td>Unix time of last transmitter temperature fault seen</td>
 *   </tr>
 *   <tr>
 *     <td>waveguide_arc_fault_time</td>
 *     <td>int</td>
 *     <td>Unix time of last waveguide arc fault seen</td>
 *   </tr>
 *   <tr>
 *     <td>collector_current_fault_time</td>
 *     <td>int</td>
 *     <td>Unix time of last collector current fault seen</td>
 *   </tr>
 *   <tr>
 *     <td>body_current_fault_time</td>
 *     <td>int</td>
 *     <td>Unix time of last body current fault seen</td>
 *   </tr>
 *   <tr>
 *     <td>filament_lor_fault_time</td>
 *     <td>int</td>
 *     <td>Unix time of last filament "loss of reference" fault seen</td>
 *   </tr>
 *   <tr>
 *     <td>focus_electrode_lor_fault_time</td>
 *     <td>int</td>
 *     <td>Unix time of last focus electrode "loss of reference" fault seen</td>
 *   </tr>
 *   <tr>
 *     <td>cathode_lor_fault_time</td>
 *     <td>int</td>
 *     <td>Unix time of last cathode "loss of reference" fault seen</td>
 *   </tr>
 *   <tr>
 *     <td>inverter_overload_fault_time</td>
 *     <td>int</td>
 *     <td>Unix time of last inverter overload fault seen</td>
 *   </tr>
 *   <tr>
 *     <td>external_interlock_fault_time</td>
 *     <td>int</td>
 *     <td>Unix time of last external interlock fault seen</td>
 *   </tr>
 *   <tr>
 *     <td>eik_interlock_fault_time</td>
 *     <td>int</td>
 *     <td>Unix time of last EIK interlock fault seen</td>
 *   </tr>
 * </table>
 * Example client usage, where hcr_xmitd is running on machine `xmitserver`:
 * @code
 *     #include <XmlRpc.h>
 *     ...
 *
 *     // Get the transmitter status from hcr_xmitd on xmitserver.local.net on port 8080
 *     XmlRpc::XmlRpcClient client("xmitserver.local.net", 8080);
 *     const XmlRpc::XmlRpcValue nullParams;
 *     XmlRpc::XmlRpcValue statusDict;
 *     client.execute("getStatus", nullParams, statusDict);
 *
 *     // extract a couple of values from the dictionary
 *     bool filamentOn = bool(statusDict["filament_on"]));
 *     double cathodeVoltage = double(statusDict["cathode_voltage"]));
 * @endcode
 */
class GetStatusMethod : public XmlRpcServerMethod {
public:
    GetStatusMethod(XmlRpcServer *s) : XmlRpcServerMethod("getStatus", s) {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        retvalP = StatusDict;
    }
} getStatusMethod(&RpcServer);

/// Xmlrpc++ method to enter "standby" state (warmed up, but high voltage off)
class StandbyMethod : public XmlRpcServerMethod {
public:
    StandbyMethod(XmlRpcServer *s) : XmlRpcServerMethod("standby", s) {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        DLOG << "standby command received";
        Xmitter->standby();
    }
} standbyMethod(&RpcServer);

/// Xmlrpc++ method to enter "operate" state (high voltage on, ready to transmit)
class OperateMethod : public XmlRpcServerMethod {
public:
    OperateMethod(XmlRpcServer *s) : XmlRpcServerMethod("operate", s) {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        DLOG << "operate command received";
        Xmitter->operate();
    }
} operateMethod(&RpcServer);

/// Xmlrpc++ method to get a string containing all available xmitd log 
/// messages at or later than the given index. If the index is zero, all 
/// available messages are returned. The method returns a XmlRpc::XmlRpcValue 
/// struct (dictionary) mapping std::string keys to XmlRpc::XmlRpcValue values.
/// The dictionary will contain:
/// <table border>
///   <tr>
///     <td><b>key</b></td>
///     <td><b>value type</b></td>
///     <td><b>value</b></td>
///   </tr>
///   <tr>
///     <td>logMessages</td>
///     <td>string</td>
///     <td>A string holding all of the requested log messages</td>
///   </tr>
///   <tr>
///     <td>nextIndex</td>
///     <td>int</td>
///     <td>The index of the next log message following the returned messages</td>
///   </tr>
class GetLogMessagesMethod : public XmlRpcServerMethod {
public:
    GetLogMessagesMethod(XmlRpcServer *s) : XmlRpcServerMethod("getLogMessages", s) {}
    void execute(XmlRpcValue & paramList, XmlRpcValue & retvalP) {
        DLOG << "getLogMessages command received";
        if (paramList[0].getType() != XmlRpcValue::TypeInt) {
            ELOG << "getLogMessages got non-integer param[0]!";
        }
        unsigned int startIndex = int(paramList[0]);
        // Note that the parameter to getMessages() is in/out, and on return
        // it will contain the next index to get.
        std::vector<std::string> msgs = RecentLogHistory.getMessages(startIndex);
        std::string appendedMsgs("");
        for (unsigned int i = 0; i < msgs.size(); i++) {
            appendedMsgs.append(msgs[i]);
        }
        // Trim a trailing newline
        if (appendedMsgs[appendedMsgs.size() - 1] == '\n')
            appendedMsgs.resize(appendedMsgs.size() - 1);
        
        XmlRpcValue dict;
        dict["logMessages"] = appendedMsgs;
        dict["nextIndex"] = int(startIndex);
        retvalP = dict;
    }
} getLogMessagesMethod(&RpcServer);

/// Get current status from the transmitter and update the XML-RPC status
/// dictionary.
void
updateStatus() {
    static HcrXmitter::Status PrevXmitStatus;
    
    PrevXmitStatus = XmitStatus;
    XmitStatus = Xmitter->getStatus();
    time_t now = time(0);
    
    // Increment fault counters and latest fault times
    if (XmitStatus.modulatorFault && ! PrevXmitStatus.modulatorFault) {
        WLOG << "modulator fault";
        ModulatorFaultCount++;
        ModulatorFaultTime = now;
    }
    if (XmitStatus.syncFault && ! PrevXmitStatus.syncFault) {
        WLOG << "sync fault";
        SyncFaultCount++;
        SyncFaultTime = now;
    }
    if (XmitStatus.xmitterTempFault && ! PrevXmitStatus.xmitterTempFault) {
        WLOG << "transmitter temperature fault";
        XmitterTempFaultCount++;
        XmitterTempFaultTime = now;
    }
    if (XmitStatus.waveguideArcFault && ! PrevXmitStatus.waveguideArcFault) {
        WLOG << "waveguide arc fault";
        WgArcFaultCount++;
        WgArcFaultTime = now;
    }
    if (XmitStatus.collectorCurrentFault && ! PrevXmitStatus.collectorCurrentFault) {
        WLOG << "collector current fault";
        CollectorCurrFaultCount++;
        CollectorCurrFaultTime = now;
    }
    if (XmitStatus.bodyCurrentFault && ! PrevXmitStatus.bodyCurrentFault) {
        WLOG << "body current fault";
        BodyCurrFaultCount++;
        BodyCurrFaultTime = now;
    }
    if (XmitStatus.filamentLorFault && ! PrevXmitStatus.filamentLorFault) {
        WLOG << "filament LOR fault";
        FilamentLorFaultCount++;
        FilamentLorFaultTime = now;
    }
    if (XmitStatus.focusElectrodeLorFault && ! PrevXmitStatus.focusElectrodeLorFault) {
        WLOG << "focus electrode LOR fault";
        FocusElectrodeLorFaultCount++;
        FocusElectrodeLorFaultTime = now;
    }
    if (XmitStatus.cathodeLorFault && ! PrevXmitStatus.cathodeLorFault) {
        WLOG << "cathode LOR fault";
        CathodeLorFaultCount++;
        CathodeLorFaultTime = now;
    }
    if (XmitStatus.inverterOverloadFault && ! PrevXmitStatus.inverterOverloadFault) {
        WLOG << "inverter overload fault";
        InverterOverloadFaultCount++;
        InverterOverloadFaultTime = now;
    }
    if (XmitStatus.externalInterlockFault && ! PrevXmitStatus.externalInterlockFault) {
        WLOG << "external interlock fault";
        ExtInterlockFaultCount++;
        ExtInterlockFaultTime = now;
    }
    if (XmitStatus.eikInterlockFault && ! PrevXmitStatus.eikInterlockFault) {
        WLOG << "EIK interlock fault";
        EikInterlockFaultCount++;
        EikInterlockFaultTime = now;
    }
    
    // Unpack the status from the transmitter into our XML-RPC StatusDict
    StatusDict["serial_connected"] = XmlRpcValue(XmitStatus.serialConnected);
    StatusDict["filament_on"] = XmlRpcValue(XmitStatus.filamentOn);
    StatusDict["high_voltage_on"] = XmlRpcValue(XmitStatus.highVoltageOn);
    StatusDict["rf_on"] = XmlRpcValue(XmitStatus.rfOn);
    StatusDict["mod_pulse_external"] = XmlRpcValue(XmitStatus.modPulseExternal);
    StatusDict["sync_pulse_external"] = XmlRpcValue(XmitStatus.syncPulseExternal);
    StatusDict["filament_delay_active"] = XmlRpcValue(XmitStatus.filamentDelayActive);
    StatusDict["power_valid"] = XmlRpcValue(XmitStatus.powerValid);
    StatusDict["fault_summary"] = XmlRpcValue(XmitStatus.faultSummary);
    StatusDict["front_panel_control_enabled"] = XmlRpcValue(XmitStatus.controlSource == HcrXmitter::FrontPanelControl);
    StatusDict["rs232_control_enabled"] = XmlRpcValue(XmitStatus.controlSource == HcrXmitter::RS232Control);
    StatusDict["rds_control_enabled"] = XmlRpcValue(XmitStatus.controlSource == HcrXmitter::RDSControl);
    StatusDict["modulator_fault"] = XmlRpcValue(XmitStatus.modulatorFault);
    StatusDict["sync_fault"] = XmlRpcValue(XmitStatus.syncFault);
    StatusDict["xmitter_temp_fault"] = XmlRpcValue(XmitStatus.xmitterTempFault);
    StatusDict["waveguide_arc_fault"] = XmlRpcValue(XmitStatus.waveguideArcFault);
    StatusDict["collector_current_fault"] = XmlRpcValue(XmitStatus.collectorCurrentFault);
    StatusDict["body_current_fault"] = XmlRpcValue(XmitStatus.bodyCurrentFault);
    StatusDict["filament_lor_fault"] = XmlRpcValue(XmitStatus.filamentLorFault);
    StatusDict["focus_electrode_lor_fault"] = XmlRpcValue(XmitStatus.focusElectrodeLorFault);
    StatusDict["cathode_lor_fault"] = XmlRpcValue(XmitStatus.cathodeLorFault);
    StatusDict["inverter_overload_fault"] = XmlRpcValue(XmitStatus.inverterOverloadFault);
    StatusDict["external_interlock_fault"] = XmlRpcValue(XmitStatus.externalInterlockFault);
    StatusDict["eik_interlock_fault"] = XmlRpcValue(XmitStatus.eikInterlockFault);
    StatusDict["cathode_voltage"] = XmlRpcValue(XmitStatus.cathodeVoltage);
    StatusDict["body_current"] = XmlRpcValue(XmitStatus.bodyCurrent);
    StatusDict["collector_current"] = XmlRpcValue(XmitStatus.collectorCurrent);
    StatusDict["xmitter_temp"] = XmlRpcValue(XmitStatus.xmitterTemp);
    
    // And add our fault history counts
    StatusDict["modulator_fault_count"] = XmlRpcValue(ModulatorFaultCount);
    StatusDict["sync_fault_count"] = XmlRpcValue(SyncFaultCount);
    StatusDict["xmitter_temp_fault_count"] = XmlRpcValue(XmitterTempFaultCount);
    StatusDict["waveguide_arc_fault_count"] = XmlRpcValue(WgArcFaultCount);
    StatusDict["collector_current_fault_count"] = XmlRpcValue(CollectorCurrFaultCount);
    StatusDict["body_current_fault_count"] = XmlRpcValue(BodyCurrFaultCount);
    StatusDict["filament_lor_fault_count"] = XmlRpcValue(FilamentLorFaultCount);
    StatusDict["focus_electrode_lor_fault_count"] = 
            XmlRpcValue(FocusElectrodeLorFaultCount);
    StatusDict["cathode_lor_fault_count"] = XmlRpcValue(CathodeLorFaultCount);
    StatusDict["inverter_overload_fault_count"] = XmlRpcValue(InverterOverloadFaultCount);
    StatusDict["external_interlock_fault_count"] = XmlRpcValue(ExtInterlockFaultCount);
    StatusDict["eik_interlock_fault_count"] = XmlRpcValue(EikInterlockFaultCount);
    
    // And latest fault times
    StatusDict["modulator_fault_time"] = XmlRpcValue(int(ModulatorFaultTime));
    StatusDict["sync_fault_time"] = XmlRpcValue(int(SyncFaultTime));
    StatusDict["xmitter_temp_fault_time"] = XmlRpcValue(int(XmitterTempFaultTime));
    StatusDict["waveguide_arc_fault_time"] = XmlRpcValue(int(WgArcFaultTime));
    StatusDict["collector_current_fault_time"] = XmlRpcValue(int(CollectorCurrFaultTime));
    StatusDict["body_current_fault_time"] = XmlRpcValue(int(BodyCurrFaultTime));
    StatusDict["filament_lor_fault_time"] = XmlRpcValue(int(FilamentLorFaultTime));
    StatusDict["focus_electrode_lor_fault_time"] = 
            XmlRpcValue(int(FocusElectrodeLorFaultTime));
    StatusDict["cathode_lor_fault_time"] = XmlRpcValue(int(CathodeLorFaultTime));
    StatusDict["inverter_overload_fault_time"] = XmlRpcValue(int(InverterOverloadFaultTime));
    StatusDict["external_interlock_fault_time"] = XmlRpcValue(int(ExtInterlockFaultTime));
    StatusDict["eik_interlock_fault_time"] = XmlRpcValue(int(EikInterlockFaultTime));
    
    // If we're operating (rfOn is true), update LastOperateTime to now
    if (XmitStatus.rfOn)
        LastOperateTime = time(0);
}

/// Print usage information
void
usage(const char* argv0) {
    std::cerr << "Usage: " << argv0 << 
            " [option]... <xmitter_ttydev> <server_port>" << std::endl;
    std::cerr << OptionsDesc << std::endl;
    logx::LogUsage(std::cerr);
    std::cerr << std::endl;
    std::cerr << "Use ""SimulatedHcrXmitter"" as <xmitter_ttydev> to " << 
            "simulate a transmitter" << std::endl;
}

/// Parse the command line options, removing the successfully parsed bits from
/// argc/argv.
void
parseOptions(int & argc, char** argv)
{
    // get the options
    OptionsDesc.add_options()
            ("help", "Describe options")
            ("foreground", po::bool_switch(&Foreground),
                    "Run in foreground, rather than as a daemon process")
            ("instance", po::value<std::string>(&InstanceName), 
                    "Instance name for procmap")
            ;

    po::variables_map vm;
    po::command_line_parser parser(argc, argv);
    parser.options(OptionsDesc);
    po::parsed_options parsedOpts = parser.run();
    po::store(parsedOpts, vm);
    po::notify(vm);
    
    if (vm.count("help")) {
        usage(argv[0]);
        exit(0);
    }
    
    // Retain only the unparsed args in argv, adjusting argc and argv
    std::vector<std::string> unparsed = 
            po::collect_unrecognized(parsedOpts.options, po::include_positional);
    argc = 1 + unparsed.size();
    for (unsigned int i = 0; i < unparsed.size(); i++) {
        argv[i + 1] = strdup(unparsed[i].c_str());
    }
}


int
main(int argc, char *argv[]) {
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);
    
    // Get our local options
    parseOptions(argc, argv);
    
    // Append our log to local syslog
    log4cpp::SyslogAppender syslogAppender("SyslogAppender", "hcr_xmitd", LOG_DAEMON);
    log4cpp::Category::getRoot().addAppender(syslogAppender);
    
    // Append our log to the recent history
    log4cpp::Category::getRoot().addAppender(RecentLogHistory);

    // Remaining args should just be serial device for the transmitter and
    // port number we should use.
    if (argc != 3) {
        std::cout << "remaining args: ";
        for (int i = 0; i < argc; i++) {
            std::cout << argv[i] << " ";
        }
        std::cout << std::endl;
        usage(argv[0]);
        exit(1);
    }
    
    // Normally we fork off a background process and run as a daemon
    if (! Foreground) {
        pid_t pid = fork();
        if (pid < 0) {
            ELOG << "Error forking: " << strerror(errno);
            exit(1);
        } else if (pid > 0) {
            exit(0);    // parent process exits now, leaving the child in background
        }
    }
    
    // Initialize registration with procmap if instance is specified
    if (InstanceName.size() > 0) {
        PMU_auto_init("hcr_xmitd", InstanceName.c_str(), PROCMAP_REGISTER_INTERVAL);
        ILOG << "Initializing procmap registration as instance '" << 
                InstanceName << "'";
    }

    time_t now = time(0);
    char timestring[40];
    strftime(timestring, sizeof(timestring) - 1, "%F %T", gmtime(&now));
    ILOG << "hcr_xmitd (" << getpid() << ") started " << timestring;

    // start with all-zero status
    memset(&XmitStatus, 0, sizeof(XmitStatus));
    
    // Instantiate our transmitter, communicating over the given serial port
    PMU_auto_register("instantiating HcrXmitter");
    Xmitter = new HcrXmitter(argv[1]);
    
    // Initialize our RPC server
    PMU_auto_register("starting XML-RPC server");
    RpcServer.bindAndListen(atoi(argv[2]));
    RpcServer.enableIntrospection(true);
    
    /*
     * Get current status. Listen for XML-RPC commands for a while. Repeat.
     */
    while (true) {
        PMU_auto_register("running");
        // Get current transmitter status
        updateStatus();
        
        // Listen for XML-RPC commands.
        // Note that work() mostly goes for 2x the given time, but sometimes
        // goes for 1x the given time. Who knows why?
        RpcServer.work(0.2);
    }
    
    delete(Xmitter);
    return 0;
} 
