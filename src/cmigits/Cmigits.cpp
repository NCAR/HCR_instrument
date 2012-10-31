/*
 * Cmigits.cpp
 *
 *  Created on: Oct 12, 2012
 *      Author: burghart
 */

#include "Cmigits.h"

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

LOGGING("Cmigits")

// device name to use for simulated C-MIGITS
const std::string Cmigits::SIM_DEVICE = "SimulatedCmigits";


Cmigits::Cmigits(std::string ttyDev) :
        _simulate(ttyDev == SIM_DEVICE),
        _ttyDev(ttyDev),
        _fd(-1) {
    ILOG << "Cmigits on device " << ttyDev;
    // Open the serial port
    if (! _simulate) {
        _openTty();
    }
}

Cmigits::~Cmigits() {
}

void
Cmigits::_openTty() {
    DLOG << "Opening " << _ttyDev;
    if ((_fd = open(_ttyDev.c_str(), O_RDWR)) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error opening " << _ttyDev << ": " <<
                strerror(errno);
        exit(1);
    }

    // Make the port 38400 8/1 odd parity, "raw"
    struct termios ios;
    if (tcgetattr(_fd, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error getting " << _ttyDev << 
                " attributes: " << strerror(errno);
        exit(1);
    }
    cfmakeraw(&ios);
    cfsetspeed(&ios, B38400);
    
    // Even parity
    ios.c_cflag |= PARENB;  // enable parity
    ios.c_cflag |= PARODD;  // use odd parity

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

int 
Cmigits::_readSelect(unsigned int waitMsecs)
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
