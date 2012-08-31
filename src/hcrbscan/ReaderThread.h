/*
 * ReaderThread.h
 *
 *  Created on: May 21, 2012
 *      Author: burghart
 */

#ifndef READERTHREAD_H_
#define READERTHREAD_H_

#include <QThread>

#include "RadxBscanRaySource.h"
#include <radar/IwrfMomReader.hh>

class ReaderThread : public QThread {
    Q_OBJECT
public:
    ReaderThread(IwrfMomReader & reader, const RadxBscanRaySource & radxBscanRaySource);
    virtual ~ReaderThread();

    void run();
private:
    IwrfMomReader & _reader;
    const RadxBscanRaySource & _radxBscanRaySource;
    // Stop thread execution when _stopNow is true. Generally, this is set by
    // the destructor.
    bool _stopNow;
private slots:
    // Read one ray from the IwrfMomReader and generate a BscanRay from it.
    void _makeNextBscanRay();
};

#endif /* READERTHREAD_H_ */
