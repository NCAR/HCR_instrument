/*
 * FDReader.cpp
 *
 *  Created on: Jun 29, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#include <cerrno>
#include <cstring>  // for strerror()
#include <iomanip>
#include <sstream>
#include <stdint.h>
#include <fcntl.h>
#include <unistd.h>
#include <logx/Logging.h>
#include <QtGui/QApplication>

#include "FDReader.h"


LOGGING("FDReader")

FDReader::FDReader(int inFd) :
    _fd(inFd),
    _exitRequested(false) {

}

FDReader::~FDReader() {
}

void
FDReader::run() {
    // Timeout period for our select() call, so that we can process Qt events
    // even when there's nothing to read.
    const struct timespec timeout = { 0, 200000000 };   // 0.2 s
    const double timeoutD = timeout.tv_sec + 1.0e-9 * timeout.tv_nsec;

    std::ostringstream oss;

    while (true) {
        // Handle any Qt events pending for this thread
        QApplication::instance()->processEvents();

        // Stop now if requested
        if (_exitRequested) {
            break;
        }

        // Select on our incoming file descriptor for up to the time period
        // specified by timeout above
        fd_set in_fds;
        FD_SET(_fd, &in_fds);
        int ready = pselect(_fd + 1, &in_fds, NULL, NULL, &timeout, NULL);

        // If there's no ready FD, then we timed out. Just try again.
        if (ready == 0) {
            DLOG << "Select timeout after " << std::setprecision(3) <<
                    timeoutD << " s";
            continue;
        }

        // On error...
        if (ready == -1) {
            switch (errno) {
            // If we were interrupted, just go back and try again
            case EINTR:
                ILOG << "Select was interrupted by a signal; trying again";
                continue;
            // EBADF means the file descriptor was closed. Return now, which
            // will stop the thread.
            case EBADF:
                ELOG << "Stopping because file descriptor " << _fd <<
                    " has been closed!";
                return;
            default:
                ELOG << "Stopping on unknown pselect() error " << errno;
                return;
            }
        }

        // The file descriptor has data. Read it now and emit newData().
        _readData();
    }
    ILOG << "Exiting FDReader thread for fd " << _fd;
}

void
FDReader::quit() {
    _exitRequested = true;
}

void
FDReader::_readData() {
    uint8_t readBuffer[1000];
    // Read up to sizeof(readBuffer) bytes and emit a newData() signal
    // carrying the read data.
    int nread = read(_fd, readBuffer, sizeof(readBuffer));

    if (nread == 0) {
        WLOG << "_readData(): Unexpected empty read";
        return;
    } else if (nread == -1) {
        // Report the error and return
        ELOG << "_readData(): " << strerror(errno);
        return;
    }

//    // Log the received bytes
//    std::ostringstream oss;
//    oss << "Read 0x";
//    for (int i = 0; i < nread; i++) {
//        oss << std::setw(2) << std::setfill('0') << std::hex <<
//                uint(readBuffer[i]);
//    }
//    DLOG << oss.str();

    // We have data. Emit newData() to ship it off.
    emit newData(QByteArray(reinterpret_cast<char*>(&readBuffer), nread));
}

//FDReaderThreadWorker::FDReaderThreadWorker(int fd) : _fd(fd) {
//
//}
