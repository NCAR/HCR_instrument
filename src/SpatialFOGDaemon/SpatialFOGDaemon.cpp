/*
 * SpatialFOGDaemon.cpp
 *
 *  Created on: Jun 28, 2016
 *      Author: Chris Burghart
 */

#include <cerrno>
#include <cstdlib>
#include <fcntl.h>
#include <iostream>
#include <string>
#include <termios.h>
#include <sys/select.h>
#include <logx/Logging.h>

#include <SpatialFOGCore.h>

#include <QApplication>

#include "FDReader.h"
#include "SFDataHandler.h"

LOGGING("SpatialFOGDaemon")

// Serial port device name for connection to SpatialFOG
std::string DevName;

// File descriptor of connection to SpatialFOG
int Fd;

void
usage() {
    std::cerr << "Usage: SpatialFOGDaemon [(logx_argument)...] <tty_dev>" <<
            std::endl;
    logx::LogUsage(std::cerr);
}

std::string
BaudToText(speed_t baudValue) {
    std::string speedTxt("unknown");
    switch (baudValue) {
    case B9600:
        speedTxt = "B9600";
        break;
    case B19200:
        speedTxt = "B19200";
        break;
    case B38400:
        speedTxt = "B38400";
        break;
    case B57600:
        speedTxt = "B57600";
        break;
    case B115200:
        speedTxt = "B115200";
        break;
    }
    return(speedTxt);
}

void
setBaud(int fd, speed_t baudValue) {
    // Get current settings, change the port speed, and send the new settings.
    struct termios ios;
    if (tcgetattr(fd, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error getting " << DevName <<
                " attributes: " << strerror(errno);
        exit(1);
    }

    // Change speed if the current speed is not the same as the requested one
    if (cfgetispeed(&ios) == baudValue && cfgetospeed(&ios) == baudValue) {
        DLOG << __PRETTY_FUNCTION__ << ": requested baud rate matches current";
    } else {
        ILOG << "Changing speed on " << DevName << " to " << BaudToText(baudValue);
        cfsetspeed(&ios, baudValue);

        // Send new I/O settings
        if (tcsetattr(fd, TCSAFLUSH, &ios) == -1) {
            ELOG << __PRETTY_FUNCTION__ << ": error setting " << DevName <<
                    " attributes: " << strerror(errno);
            exit(1);
        }
    }
}

// Open and configure the given serial port
int
openDevice(const std::string devName) {
    DLOG << "Opening " << devName;
    int fd;
    if ((fd = open(devName.c_str(), O_RDWR)) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error opening " << devName << ": " <<
                strerror(errno);
        exit(1);
    }

    // Make the port 8 data bits, 1 stop bit, odd parity, "raw"
    struct termios ios;
    if (tcgetattr(fd, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error getting " << devName <<
                " attributes: " << strerror(errno);
        exit(1);
    }
    cfmakeraw(&ios);

    if (tcsetattr(fd, TCSAFLUSH, &ios) == -1) {
        ELOG << __PRETTY_FUNCTION__ << ": error setting " << devName <<
                " attributes: " << strerror(errno);
        exit(1);
    }

    // Start at 115200 baud
    setBaud(fd, B115200);

    DLOG << "Done configuring " << devName;

    return(fd);
}

int
main(int argc, char * argv[]) {
    // Initialize logx, letting it get and strip out its command line arguments
    logx::ParseLogArgs(argc, argv);

    // Create a non-GUI QApplication instance
    QApplication app(argc, argv, false);

    // We should have one remaining argument after the program name: the device
    // port to which the SpatialFOG is attached
    if (argc != 2) {
        usage();
        exit(1);
    }

    DevName = argv[1];

    // Open and set up the serial port
    Fd = openDevice(DevName);

    // Start a reader thread
    FDReader fdr(Fd);

    // Function wrapper to handle data
    SFDataHandler handler;

    app.connect(&fdr, SIGNAL(newData(QByteArray)),
                &handler, SLOT(handleData(QByteArray)));

    fdr.start();

    app.exec();
}
