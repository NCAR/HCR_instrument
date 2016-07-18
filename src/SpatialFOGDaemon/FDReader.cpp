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
#include <QApplication>

#include "FDReader.h"


LOGGING("FDReader")

FDReader::FDReader(int inFd) : _workerThread() {
    FDReaderWorker * worker = new FDReaderWorker(inFd, &_workerThread);
    connect(&_workerThread, SIGNAL(finished()), worker, SLOT(deleteLater()));
    // Map the worker's newData() signal to our own newData() signal
    connect(worker, SIGNAL(newData(QByteArray)),
            this, SIGNAL(newData(QByteArray)));
    _workerThread.start();
}

FDReader::~FDReader() {
    _workerThread.quit();
    _workerThread.wait();
}

FDReaderWorker::FDReaderWorker(int fd, QThread * workerThread) :
        _fd(fd),
        _workerThread(workerThread),
        _runWhenFreeTimer(NULL) {
    // Move our affinity to the worker thread
    moveToThread(_workerThread);

    // When the worker thread is started, call _tryToRead()
    connect(_workerThread, SIGNAL(started()), this, SLOT(_tryToRead()));
}

void
FDReaderWorker::_tryToRead() {
    // On first call here, create a zero-length timer connected so that we
    // execute _tryToRead() whenever the thread is not otherwise busy.
    // IMPORTANT: This timer MUST be created within the worker thread to
    // function properly; that's why it doesn't get created in the constructor!
    if (! _runWhenFreeTimer) {
        // Verify that we're executing in the worker thread before creating the
        // zero-length timer.
        if (QThread::currentThread() != _workerThread) {
            ELOG << "Unexpected execution of  _tryToRead() " <<
                    "outside the worker thread";
            return;
        }
        // Create the timer
        _runWhenFreeTimer = new QTimer();
        // Queue execution of this method again upon timeout.
        connect(_runWhenFreeTimer, SIGNAL(timeout()), this, SLOT(_tryToRead()));
        // Stop the timer when the thread is finished.
        connect(_workerThread, SIGNAL(finished()), _runWhenFreeTimer, SLOT(stop()));
        // Zero-length timer emits timeout() whenever the thread is not
        // otherwise busy.
        _runWhenFreeTimer->start(0);
    }

    // Set a timeout period for our select() call below, so that we don't block
    // forever and hold up our Qt event loop.
    const struct timespec timeout = { 0, 200000000 };   // 0.2 s
    const double timeoutD = timeout.tv_sec + 1.0e-9 * timeout.tv_nsec;

    // Select on our incoming file descriptor for up to the time period
    // specified by timeout above
    fd_set in_fds;
    FD_SET(_fd, &in_fds);
    int ready = pselect(_fd + 1, &in_fds, NULL, NULL, &timeout, NULL);

    // If there's no ready FD, then we timed out. Just return.
    if (ready == 0) {
        DLOG << "Select timeout after " << std::setprecision(3) <<
                timeoutD << " s";
        return;
    }

    // On error...
    if (ready == -1) {
        switch (errno) {
        // If we were interrupted. Just return and we'll try again shortly.
        case EINTR:
            ILOG << "Select was interrupted by a signal; trying again";
            return;
        // EBADF means the file descriptor was closed. Return now, which
        // will stop the thread.
        case EBADF:
            ELOG << "Stopping because file descriptor " << _fd <<
                " has been closed!";
            _runWhenFreeTimer->stop();
            _workerThread->exit(1);
            break;
        default:
            ELOG << "Stopping on unknown pselect() error " << errno;
            _runWhenFreeTimer->stop();
            _workerThread->exit(1);
            break;
        }
    }

    // The file descriptor has data. Read it now and emit newData().
    _readData();
}

void
FDReaderWorker::_readData() {
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
