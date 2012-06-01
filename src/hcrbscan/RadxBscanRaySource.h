/*
 * RadxBscanRaySource.h
 *
 *  Created on: May 2, 2012
 *      Author: burghart
 */

#ifndef RADXBSCANRAYSOURCE_H_
#define RADXBSCANRAYSOURCE_H_

#include <QObject>

class BscanRay;
class RadxRay;

/**
 * @brief Class to accept incoming RadxRay objects, convert them to BscanRay-s,
 * and deliver the BscanRay-s via a newBscanRay() Qt signal.
 */
class RadxBscanRaySource : public QObject {
    Q_OBJECT
public:
    RadxBscanRaySource();
    virtual ~RadxBscanRaySource();
signals:
    /**
     * @brief The newBscanRay signal is emitted when a new BscanRay has been
     * generated.
     * @param ray the newly generated BscanRay
     */
    void newBscanRay(const BscanRay & ray) const;
public slots:
    /**
     * Make a BscanRay from an incoming RadxRay and emit a newBscanRay() signal 
     * for the new ray.
     * @param item the RadxRay to be converted to a BscanRay
     */
    void makeBscanRay(RadxRay & radxRay) const;
};

#endif /* RADXBSCANRAYSOURCE_H_ */
