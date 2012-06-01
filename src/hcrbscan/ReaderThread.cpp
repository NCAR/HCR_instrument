/*
 * ReaderThread.cpp
 *
 *  Created on: May 21, 2012
 *      Author: burghart
 */

#include "ReaderThread.h"

ReaderThread::ReaderThread(IwrfMomReader & reader,
        const RadxBscanRaySource & radxBscanRaySource) :
        QThread(),
        _reader(reader),
        _radxBscanRaySource(radxBscanRaySource),
        _rayTimer() {
    connect(&_rayTimer, SIGNAL(timeout()), this, SLOT(_makeNextBscanRay()));
    _rayTimer.start(200);
}

ReaderThread::~ReaderThread() {
    // TODO Auto-generated destructor stub
}

void
ReaderThread::_makeNextBscanRay() {
        RadxRay * radxRay = _reader.readNextRay();
        if (! radxRay) {
            std::cerr << "Out of data!" << std::endl;
            exit(1);
        }
        _radxBscanRaySource.makeBscanRay(*radxRay);
        delete(radxRay);
    }
