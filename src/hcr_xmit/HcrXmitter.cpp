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
HcrXmitter::setFilamentState(bool filamentState) {
    // Tweak the filament bit in the intended state
    if (filamentState) {
        _intendedState |= _FILAMENT_ON_BIT;     // set bit
    } else {
        _intendedState &= ~_FILAMENT_ON_BIT;    // clear bit
    }

    ILOG << "Commanding filament " << (filamentState ? "on" : "off");
    if (! _simulate) {
        _sendCommand(_intendedState);
    } else {
        _simStatus.filamentOn = filamentState;
    }
    return;
}

void
HcrXmitter::setHvState(bool hvState) {
    // Tweak the HV bit in the intended state
    if (hvState) {
        _intendedState |= _HV_ON_BIT;     // set bit
    } else {
        _intendedState &= ~_HV_ON_BIT;    // clear bit
    }

    ILOG << "Commanding high voltage " << (hvState ? "on" : "off");
    if (! _simulate) {
        _sendCommand(_intendedState);
    } else {
        _simStatus.highVoltageOn = hvState;
    }
    return;
}

HcrXmitter::Status
HcrXmitter::getStatus() {
    // Special handling if we're simulating...
    if (_simulate) {
    	_simStatus.powerValid = true;
    	_simStatus.serialConnected = true;
    	_simStatus.cathodeVoltage = 14.9 + (0.2 * random()) / RAND_MAX;
    	_simStatus.collectorCurrent = 390. + (20.0 * random()) / RAND_MAX;
    	_simStatus.bodyCurrent = 49.0 + (2.0 * random()) / RAND_MAX;
    	_simStatus.xmitterTemp = 39.5 + (1.0 * random()) / RAND_MAX;
        return(_simStatus);
    }
    
    // This must be the real thing, so get status from the transmitter
    
    // Status struct which we will return
    Status status;
	_clearStatus(status);

	// Reply from the transmitter, which will be parsed to build the Status
	// struct.
	static const int REPLYSIZE = 20;
	uint8_t reply[REPLYSIZE];

	// Max number of times to attempt to get good status from the transmitter
    unsigned int MAX_ATTEMPTS = 3;

    unsigned int attempt = 0;
    unsigned int nReplies = 0;

	// Loop until we either get a usable status reply or we hit our maximum 
	// number of attempts.
    for (attempt = 0; attempt < MAX_ATTEMPTS; attempt++) {
    	// Get rid of any unread input
    	tcflush(_fd, TCIFLUSH);

    	// Send the currently desired state to elicit a status response
    	_sendCommand(_intendedState);

    	// Wait up to a second for reply to arrive
    	if (_readSelect(1000) < 0) {
    		DLOG << "Error or timeout waiting for status reply";
    		// Try again
    		continue;
    	}

    	if (attempt > 0 && nReplies == 0) {
    		ILOG << "Got a status reply after " << attempt + 1 <<
    				" attempts";
    	}

    	// Read the 20-byte status reply
    	DLOG << "Reading status reply";
    	int nBytesRead = 0;
    	int nReads = 0;
    	while (nBytesRead < REPLYSIZE && nReads < 5) {
    		int result = read(_fd, reply + nBytesRead, REPLYSIZE - nBytesRead);
    		nReads++;
    		if (result == 0) {
    			// wait 5 ms for more data
    			ILOG << "Sleeping for more status data...";
    			usleep(5000);
    		} else if (result < 0) {
    			ELOG << "Status reply read error: " << strerror(errno);
    			return(status);
    		} else {
    			nBytesRead += result;
    		}
    	}
    	if (nBytesRead == REPLYSIZE) {
    		// We got a reply
    		nReplies++;
    	} else {
    		// Incomplete reply, so try again
    		WLOG << "Incomplete reply";
    		continue;
    	}

    	// Byte 17 is non-zero if the transmitter received a bad communication.
    	// If this byte indicates an error, the rest of the returned status can't
    	// be trusted, so go back and try again.
    	if (reply[17] != 0) {
    		ELOG << "'Bad communication' reply from transmitter";
    		// Try again
    		continue;
    	}

    	// It appears we have a good reply, so break out and parse it.
    	break;
    }
    
    // If we used up our tries, we just return the empty status
    if (attempt == MAX_ATTEMPTS) {
    	if (nReplies == 0) {
    		WLOG << "No status reply in " << MAX_ATTEMPTS <<
    				" tries; Is the transmitter plugged in?";
    	} else {
    		WLOG << "Only 'bad communication' replies in " << MAX_ATTEMPTS <<
    				" attempts to get status";
    	}
    	return(status);
    }

	// Parse the status reply
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
    
    // Construct the 8-byte packet containing the desired command byte
    std::vector<uint8_t> cmd;

    cmd.push_back(uint8_t(0xf0));		// byte 0: command start byte 0xf0
    cmd.push_back(6);               	// byte 1: byte count (without start and end)
    cmd.push_back(_aliveCounter++);		// byte 2: alive counter
    cmd.push_back(desiredState);		// byte 3: transmitter state
    cmd.push_back(0);					// byte 4: always zero
    cmd.push_back(0);					// byte 5: always zero
  
    // Compute and append XOR checksum of bytes 1-5
    uint8_t chksum = 0;
    for (unsigned int i = 1; i < 6; i++) {
        chksum ^= cmd[i];
    }
    cmd.push_back(chksum);				// byte 6: checksum
    
    cmd.push_back(uint8_t(0xff));		// byte 7: command end byte 0xff
    
    // Try up to five times to send all of the chars out
    int nSent = 0;
    int nToSend = cmd.size();
    for (int attempt = 0; attempt < 5; attempt++) {
        if (attempt > 0) {
            ILOG << __PRETTY_FUNCTION__ << ": Attempt " << attempt + 1 << 
                    " to send xmitter state 0x" << 
                    std::hex << uint16_t(desiredState) << std::dec;
        }
        int result = write(_fd, cmd.data() + nSent, nToSend);
        if (result == -1) {
            WLOG << __PRETTY_FUNCTION__ << ": Error (" << strerror(errno) <<
                    ") sending xmitter state 0x" << 
                    std::hex << uint16_t(desiredState) << std::dec;
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
                    ") sending xmitter state 0x" << std::setfill('0') <<
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
    _simStatus.powerValid = true;
    _simStatus.controlSource = RS232Control;
}
