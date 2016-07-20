/*
 * SpatialFogDaemon.cpp
 *
 *  Created on: Jun 28, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#include <cerrno>
#include <cstdlib>
#include <fcntl.h>
#include <iostream>
#include <string>
#include <termios.h>
#include <unistd.h>
#include <QFunctionWrapper.h>
#include <RequestPacket.h>
#include <sys/select.h>
#include <logx/Logging.h>
#include "QAnppPacketFactory.h"

#include <QApplication>
#include <QTimer>

#include "FDReader.h"

LOGGING("SpatialFogDaemon")

// Serial port device name for connection to Spatial FOG
std::string DevName;

// QApplication instance
QApplication * App;

// File descriptor of connection to Spatial FOG
int Fd;

// Reader thread
FDReader * Fdr = NULL;

void
usage() {
    std::cerr << "Usage: SpatialFogDaemon [(logx_argument)...] <tty_dev>" <<
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

void
sendPacket(const ANPPPacket & packet) {
    std::vector<uint8_t> raw(packet.rawBytes());
    int nwritten = 0;
    while (nwritten < int(raw.size())) {
        int wrote = write(Fd, &raw[nwritten], raw.size() - nwritten);
        if (wrote < 0) {
            ELOG << "error writing packet: " << strerror(errno);
            return;
        }
        nwritten += wrote;
    }
}

void
sendRequestPacket() {
    std::vector<uint8_t> pktIds;
    pktIds.push_back(45);
    pktIds.push_back(47);
    pktIds.push_back(48);
    sendPacket(RequestPacket(pktIds));
}

void stopApp() {
    if (App) {
        ILOG << "Closing QApplication";
        App->quit();
    }
}
int
main(int argc, char * argv[]) {
    // Initialize logx, letting it get and strip out its command line arguments
    logx::ParseLogArgs(argc, argv);
    ILOG << "======================";
    ILOG << "SpatialFogDaemon start";
    ILOG << "======================";

    // Create a non-GUI QApplication instance
    App = new QApplication(argc, argv, false);

    // We should have one remaining argument after the program name: the device
    // port to which the Spatial FOG is attached
    if (argc != 2) {
        usage();
        exit(1);
    }

    DevName = argv[1];

    // Open and set up the serial port
    Fd = openDevice(DevName);

    // Start a reader thread
    Fdr = new FDReader(Fd);

    // Function wrapper to handle data
    QAnppPacketFactory handler;

    App->connect(Fdr, SIGNAL(newData(QByteArray)),
                 &handler, SLOT(handleData(QByteArray)));

    // Wrap our sendRequestPacket() function, so it can be treated as a Qt slot
    QFunctionWrapper fWrapper(sendRequestPacket);

    // Set up a timer to call sendRequestPacket on a regular basis
    QTimer requestTimer;
    App->connect(&requestTimer, SIGNAL(timeout()),
                 &fWrapper, SLOT(callFunction()));

    // Set up a timer to shut down after a fixed time
    QFunctionWrapper stopWrapper(stopApp);
    QTimer::singleShot(20000, &stopWrapper, SLOT(callFunction()));

    requestTimer.start(500);

    App->exec();

    delete(Fdr);
    delete(App);
}
