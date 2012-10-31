/*
 * Cmigits.h
 *
 *  Created on: Jan 7, 2011
 *      Author: burghart
 */

#ifndef CMIGITS_H_
#define CMIGITS_H_

#include <string>
#include <stdint.h>

class Cmigits {
public:
    /**
     * @brief Construct a Cmigits providing access to the C-MIGITS III on the 
     * given serial port.
     * 
     * If special serial port name Cmigits::SIM_DEVICE
     * is used, existence of the C-MIGITS will be simulated.
     * @param ttyDev the name of the serial port connected to the C-MIGITS.
     */
    Cmigits(std::string ttyDev);
    virtual ~Cmigits();
    
    /**
     * Device name to use when creating a simulation Cmigits.
     */
    static const std::string SIM_DEVICE;

private:
    /**
     * C-MIGITS III message sync word
     */
    static const uint16_t MESSAGE_SYNC_WORD = 0x81ff;

    /**
     * Open and configure our tty connection to the C-MIGITS
     */
    void _openTty();
    
    /**
     * Send a command to the C-MIGITS.
     */
    void _sendCommand(uint8_t desiredState);
    
    /**
     * Wait for input on our file descriptor, with a timeout specified in
     * milliseconds. 
     * @return 0 when input is ready, -1 if the select timed out, -2 on
     *      select error
     */
    int _readSelect(unsigned int timeoutMsecs);
    
    /// Are we simulating?
    bool _simulate;
    
    /// Our serial port device name (may be SIM_DEVICE)
    std::string _ttyDev;
    
    /// File descriptor for the open serial port
    int _fd;
    
    /// Private thread to which this object's thread affinity is assigned
    QThread _myThread;
};

#endif /* CMIGITS_H_ */
