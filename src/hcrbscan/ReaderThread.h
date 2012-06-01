/*
 * ReaderThread.h
 *
 *  Created on: May 21, 2012
 *      Author: burghart
 */

#ifndef READERTHREAD_H_
#define READERTHREAD_H_

#include <QThread>
#include <QTimer>

#include "RadxBscanRaySource.h"
#include <radar/IwrfMomReader.hh>

class ReaderThread : public QThread {
    Q_OBJECT
public:
    ReaderThread(IwrfMomReader & reader, const RadxBscanRaySource & radxBscanRaySource);
    virtual ~ReaderThread();
private:
    IwrfMomReader & _reader;
    const RadxBscanRaySource & _radxBscanRaySource;
    QTimer _rayTimer;
private slots:
    void _makeNextBscanRay();
};

#endif /* READERTHREAD_H_ */
