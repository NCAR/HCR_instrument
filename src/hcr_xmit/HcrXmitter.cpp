/*
 * HcrXmitter.cpp
 *
 *  Created on: Jan 7, 2011
 *      Author: burghart
 */

#include "HcrXmitter.h"

#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <cstring>
#include <cerrno>
#include <unistd.h>
#include <stdint.h>
#include <termios.h>
#include <fcntl.h>

#include <logx/Logging.h>

LOGGING("HcrXmitter")

// device name to use for simulated transmitter
const std::string HcrXmitter::SIM_DEVICE = "SimulatedHcrXmitter";


HcrXmitter::HcrXmitter(std::string ttyDev) :
        _simulate(ttyDev == SIM_DEVICE),
        _aliveCounter(0),
        _ttyDev(ttyDev),
        _fd(-1),
        _intendedState(0) {
    ILOG << "HcrXmitter on device " << ttyDev;
    // Open the serial port
    if (! _simulate) {
        _openTty();
    }
    // Initialize our simulated status
    _initSimStatus();
}

HcrXmitter::~HcrXmitter() {
}

void
HcrXmitter::faultReset() {
    WLOG << "faultReset() not implemented!";
//    ILOG << "Fault Reset";
//    if (! _simulate) {
//        _sendCommand(_RESET_COMMAND);
//    } else {
//        if (! _simStatus.unitOn)
//            return;
//        
//        _simStatus.faultSummary = false;
//        _simStatus.blowerFault = false;
//        _simStatus.hvpsCurrentFault = false;
//        _simStatus.hvpsOverVoltage = false;
//        _simStatus.hvpsUnderVoltage = false;
//        _simStatus.magnetronCurrentFault = false;
//        _simStatus.pulseInputFault = false;
//        _simStatus.reversePowerFault = false;
//        _simStatus.safetyInterlock = false;
//    }
    return;
}

void
HcrXmitter::standby() {
    _intendedState ^= _FILAMENT_ON_BIT;	// toggle the "filament on" bit
    ILOG << "Commanding filament " << ((_intendedState & _FILAMENT_ON_BIT) ? "on" : "off");
    _sendCommand(_intendedState);
//    ILOG << "Standby";
//    if (! _simulate) {
//        _sendCommand(_STANDBY_COMMAND);
//    } else {
//        if (! _simStatus.unitOn)
//            return;
//        
//        _simStatus.hvpsOn = false;
//        _simStatus.hvpsRunup = false;
//        _simStatus.hvpsVoltage = 0.0;
//        _simStatus.standby = true;
//    }
    return;
}

void
HcrXmitter::operate() {
    WLOG << "operate() not implemented!";
//    ILOG << "Operate";
//    if (! _simulate) {
//        _sendCommand(_OPERATE_COMMAND);
//    } else {
//        if (! _simStatus.unitOn)
//            return;
//        
//        _simStatus.hvpsOn = true;
//        _simStatus.hvpsRunup = true;
//        _simStatus.hvpsVoltage = 20.0;
//        _simStatus.standby = false;
//    }
    return;
}
#define MAX_GET_STATUS_TRIES 2

HcrXmitter::Status
HcrXmitter::getStatus(unsigned int recursion) {
//    // Special handling if we're simulating...
//    if (_simulate) {
//        _simStatus.magnetronCurrent = 0.1 + (0.2 * random()) / RAND_MAX;
//        _simStatus.hvpsCurrent = 0.2 + (0.2 * random()) / RAND_MAX;
//        _simStatus.temperature = 30 + (2.0 * random()) / RAND_MAX;
//        
//        // If in operate mode, occasionally generate a pulse input fault
//        if (_simStatus.hvpsRunup && (random() / float(RAND_MAX)) < 0.05) {
//            _simStatus.pulseInputFault = true;
//        }
//
//        _simStatus.faultSummary = _simStatus.blowerFault ||
//                _simStatus.hvpsCurrentFault|| _simStatus.hvpsOverVoltage ||
//                _simStatus.hvpsUnderVoltage || _simStatus.magnetronCurrentFault ||
//                _simStatus.pulseInputFault || _simStatus.reversePowerFault ||
//                _simStatus.safetyInterlock;
//        
//        // If we simulated a fault, also simulate leaving operate mode
//        if (_simStatus.faultSummary) {
//            _simStatus.hvpsOn = false;
//            _simStatus.hvpsRunup = false;
//            _simStatus.hvpsVoltage = 0.0;
//            _simStatus.standby = true;
//        }
//        
//        return(_simStatus);
//    }
    
    // This must be the real thing, so get status from the transmitter
    Status status;
    _clearStatus(status);
    // don't recurse more than 'N' levels in retries
    if (recursion++ == MAX_GET_STATUS_TRIES) {
       ELOG << __PRETTY_FUNCTION__ << ": Too many getStatus() retries! (giving up)";
       return status;
    }
    if (recursion > 1) {
       WLOG << __PRETTY_FUNCTION__ << ": getStatus() retry - recursion = " << recursion;
    }
    
    // Get rid of any unread input
    tcflush(_fd, TCIFLUSH);
    
    // Try up to five times so send a status command and wait for *something*
    // to come back
    for (int attempt = 0; ; attempt++) {
        // Send the currently desired state to elicit a status response
        _sendCommand(_intendedState);
    
        // Wait up to a quarter second for reply to be ready
        if (_readSelect(250) == 0) {
            if (attempt > 0) {
                DLOG << "Took " << attempt + 1 << " tries to get status reply";
            }
            break;
        } else {
            if (attempt == 4) {
                WLOG << "No status reply in " << attempt + 1 << 
                    " tries; Is the transmitter plugged in?";
                return(status);
            }
        }
    }
    
    // Read the 20-byte status reply
    DLOG << "Reading status reply";
    static const int REPLYSIZE = 20;
    uint8_t reply[REPLYSIZE];
    int nRead = 0;
    while (nRead < REPLYSIZE) {
        int result = read(_fd, reply + nRead, REPLYSIZE - nRead);
        if (result == 0) {
            DLOG << "Status reply read timeout. Trying again.";
            return getStatus(recursion);
        } else if (result < 0) {
            ELOG << "Status reply read error: " << strerror(errno);
            return(status);
        } else {
            nRead += result;
        }
    }
    
    // Finally, parse the reply
    status.serialConnected = true;
    
    // 8 bits of boolean status in byte 3
    status.filamentOn =             reply[3] & _FILAMENT_ON_BIT;
    status.highVoltageOn =          reply[3] & _HV_ON_BIT;
    status.rfOn =                   reply[3] & _RF_ON_BIT;
    status.modPulseExternal =       reply[3] & _EXT_MOD_PULSE_BIT;
    status.syncPulseExternal =      reply[3] & _EXT_SYNC_PULSE_BIT;
    status.filamentDelayActive =    reply[3] & _FILAMENT_DELAY_BIT;
    status.powerValid =             reply[3] & _POWER_VALID_BIT;
    status.faultSummary =           reply[3] & _FAULT_SUMMARY_BIT;

    DLOG << "filament on " << status.filamentOn <<
            ", HV on " << status.highVoltageOn <<
            ", RF on " << status.rfOn <<
            ", external mod pulse " << status.modPulseExternal <<
            ", external sync pulse " << status.syncPulseExternal <<
            ", filament delay active " << status.filamentDelayActive <<
            ", power valid " << status.powerValid <<
            ", fault summary " << status.faultSummary;
    
    // Byte 4: Is control currently via front panel, RS-232, or RDS?
    uint8_t controlSource = reply[4] & AllControlSources;
    switch (controlSource) {
    case FrontPanelControl:
        status.controlSource = FrontPanelControl;
        break;
    case RS232Control:
        status.controlSource = RS232Control;
        break;
    case RDSControl:
        status.controlSource = RDSControl;
        break;
    default:
        ELOG << "Uh-oh, bad transmitter control source byte with value 0x" <<
            std::hex << uint16_t(reply[4]) << std::dec;
        status.controlSource = UnknownControl;
        break;
    }
    
    // 8 fault bits from byte 5
    status.modulatorFault =         reply[5] & _MODULATOR_FAULT_BIT;
    status.syncFault =              reply[5] & _SYNC_FAULT_BIT;
    status.xmitterTempFault =       reply[5] & _XMITTER_TEMP_FAULT_BIT;
    status.waveguideArcFault =      reply[5] & _WG_ARC_FAULT_BIT;
    status.collectorCurrentFault =  reply[5] & _COLLECTOR_CURRENT_FAULT_BIT;
    status.bodyCurrentFault =       reply[5] & _BODY_CURRENT_FAULT_BIT;
    status.filamentLorFault =       reply[5] & _FILAMENT_LOR_FAULT_BIT;
    status.focusElectrodeLorFault = reply[5] & _FOCUS_ELECTRODE_LOR_FAULT_BIT;
    
    // 4 fault bits from byte 6 (other 4 bits are unused)
    status.cathodeLorFault =        reply[6] & _CATHODE_LOR_FAULT_BIT;
    status.inverterOverloadFault =  reply[6] & _INVERTER_OVERLOAD_FAULT_BIT;
    status.externalInterlockFault = reply[6] & _EXT_INTERLOCK_FAULT_BIT;
    status.eikInterlockFault    =   reply[6] & _EIK_INTERLOCK_FAULT_BIT;

    
    // Bytes 7 and 8 contain whole and fractional cathode voltage
    status.cathodeVoltage = reply[7] + 0.1 * reply[8];
    DLOG << "Cathode voltage: " << status.cathodeVoltage;
    
    // Bytes 9 and 10 contain whole and fractional body current
    status.bodyCurrent = reply[9] + 0.1 * reply[10];
    DLOG << "Body current: " << status.bodyCurrent;
    
    // Bytes 11 and 12 contain whole and fractional collector current
    status.collectorCurrent = reply[11] + 0.1 * reply[12];
    DLOG << "Collector current: " << status.collectorCurrent;
    
    // Bytes 13 and 14 contain whole and fractional transmitter temperature
    status.xmitterTemp = reply[13] + 0.1 * reply[14];
    DLOG << "Temp: " << status.xmitterTemp;
    
    // Byte 15 contains panel pulsewidth selector setting (0-15)
    status.pulsewidthSelector = reply[15];
    
    // Byte 16 contains panel PRF selector setting (0-15)
    status.prfSelector = reply[16];
    
    // Byte 17 is 1 if the transmitter received a bad communication, 0 
    // otherwise
    if (reply[17]) {
        ELOG << std::setfill('0') << 
                "Transmitter received a bad command at alive counter 0x" <<
                std::setw(2) << std::hex << uint16_t(reply[2]) << std::dec;
    }
    
    return(status);
}

void
HcrXmitter::reopenTty() {
    ILOG << "Re-opening " << _ttyDev;
    close(_fd);
    _fd = -1;
    _openTty();
}

void
HcrXmitter::_openTty() {
    DLOG << "Opening " << _ttyDev;
    if ((_fd = open(_ttyDev.c_str(), O_RDWR)) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error opening " << _ttyDev << ": " <<
                strerror(errno);
        exit(1);
    }

    // Make the port 19200 8E1, "raw"
    struct termios ios;
    if (tcgetattr(_fd, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error getting " << _ttyDev << 
                " attributes: " << strerror(errno);
        exit(1);
    }
    cfmakeraw(&ios);
    cfsetspeed(&ios, B19200);
    
    // Even parity
    ios.c_cflag |= PARENB;  // enable parity
    ios.c_cflag &= ~PARODD; // use even parity

    // Set a 0.2 second timeout for reads
    ios.c_cc[VMIN] = 0;
    ios.c_cc[VTIME] = 2;    // 0.2 seconds

    if (tcsetattr(_fd, TCSAFLUSH, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error setting " << _ttyDev << 
                " attributes: " << strerror(errno);
        exit(1);
    }
    DLOG << "Done configuring " << _ttyDev;
}

void
HcrXmitter::_clearStatus(Status & status) {
    memset(&status, 0, sizeof(Status));
}

void
HcrXmitter::_sendCommand(uint8_t desiredState) {
    if (_simulate)
        return;
    
    // Build the actual command containing the desired state
    std::vector<uint8_t> cmd;
    cmd.push_back(uint8_t(0xf0));   // command start byte
    cmd.push_back(6);               // byte count (without start and end)
    cmd.push_back(_aliveCounter++); // alive counter
    cmd.push_back(desiredState);    // transmitter state
    cmd.push_back(0);
    cmd.push_back(0);
  
    // Checksum is XOR of everything after the start byte
    uint8_t chksum = 0;
    for (unsigned int i = 1; i < cmd.size(); i++) {
        chksum ^= cmd[i];
    }
    
    cmd.push_back(chksum);          // checksum
    cmd.push_back(uint8_t(0xff));   // end byte
    
    // Try up to five times to send all of the chars out
    int nSent = 0;
    int nToSend = cmd.size();
    for (int attempt = 0; attempt < 5; attempt++) {
        if (attempt > 0) {
            ILOG << __PRETTY_FUNCTION__ << ": Attempt " << attempt + 1 << 
                    " to send xmitter state 0x" << 
                    std::hex << uint16_t(cmd[3]) << std::dec;
        }
        int result = write(_fd, cmd.data() + nSent, nToSend);
        if (result == -1) {
            WLOG << __PRETTY_FUNCTION__ << ": Error (" << strerror(errno) <<
                    ") sending xmitter state 0x" << 
                    std::hex << uint16_t(cmd[3]) << std::dec;
        } else {
            nToSend -= result;
            nSent += result;
        }
        if (nToSend == 0)
            return;
        sleep(1);
    }
    // Exit if we fail to get the command through after many attempts...
    ELOG << __PRETTY_FUNCTION__ << ": Repeated Errors (" << strerror(errno) <<
                    ") sending xmitter state 0x" << 
                    std::hex << uint16_t(cmd[3]) << std::dec << ": exiting";
    exit(1);
}

int 
HcrXmitter::_readSelect(unsigned int waitMsecs)
{
    /*
     * check only on _fd file descriptor
     */
    fd_set readFds;
    FD_ZERO(&readFds);
    FD_SET(_fd, &readFds);

    while (true) {
        /*
         * set timeval structure
         */
        struct timeval wait;
        wait.tv_sec = waitMsecs / 1000;
        wait.tv_usec = (waitMsecs % 1000) * 1000;

        int nready = select(_fd + 1, &readFds, NULL, NULL, &wait);
        if (nready == 1) {
            return 0;
        } else if (nready == 0) {
            return -1;      // timeout
        } else {
            if (errno == EINTR) /* system call was interrupted */
                continue;

            ELOG << __PRETTY_FUNCTION__ << ": select error: " <<
                    strerror(errno);
            return -2; // select failed
        } 
    }
    // Oops, shouldn't get here!
    return -3;
}

void
HcrXmitter::_initSimStatus() {
    _clearStatus(_simStatus);
    _simStatus.serialConnected = true;
    _simStatus.controlSource = RS232Control;
}
