/*
 * ReaderThread.cpp
 *
 *  Created on: May 21, 2012
 *      Author: burghart
 */

#include "ReaderThread.h"
#include <QTimer>
#include <iostream>
#include <typeinfo>

ReaderThread::ReaderThread(IwrfMomReader & reader,
        const RadxBscanRaySource & radxBscanRaySource) :
        QThread(),
        _reader(reader),
        _radxBscanRaySource(radxBscanRaySource),
        _stopNow(false) {
}

ReaderThread::~ReaderThread() {
    // A quit() will stop the event loop if we're reading from files.
    quit();
    // Setting _stopNow and wait up to 1s for thread termination. This
    // stops things if we're reading from a real-time source.
    _stopNow = true;
    wait(1000);
}

void
ReaderThread::run() {
    bool readingFromFiles = (typeid(_reader) == typeid(IwrfMomReaderFile));
    if (readingFromFiles) {
        // Set up a timer to call _makeNextBscanRay() on a regular basis.
        QTimer rayTimer;
        connect(&rayTimer, SIGNAL(timeout()), this, SLOT(_makeNextBscanRay()));
        rayTimer.start(50);
        // Now just run the normal event loop
        exec();
    } else {
        // Use non-blocking reads from our real-time data stream, waiting up
        // to 200 ms for each ray.
        _reader.setNonBlocking(200);
        // Loop forever, reading RadxRay-s and making BscanRay-s.
        while (1) {
            RadxRay * radxRay = _reader.readNextRay();
            if (! radxRay) {
                if (_reader.getTimedOut()) {
                    // If it was a timeout, just go back and try the read again...
                    continue;
                } else {
                    std::cerr << "IwrfMomReader.readNextRay() error!" << std::endl;
                    return;
                }
            }

            _radxBscanRaySource.makeBscanRay(*radxRay);
            delete(radxRay);
            // Return now if _stopNow is true.
            if (_stopNow) {
                return;
            }
        }
    }
}

void
ReaderThread::_makeNextBscanRay() {
        RadxRay * radxRay = _reader.readNextRay();
        if (! radxRay) {
            exit(0);    // this is QThread::exit()!
            return;
        }
        _radxBscanRaySource.makeBscanRay(*radxRay);
        delete(radxRay);
    }
