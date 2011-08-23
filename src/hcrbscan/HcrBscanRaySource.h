/*
 * HcrBscanRaySource.h
 *
 *  Created on: Aug 22, 2011
 *      Author: burghart
 */

#ifndef HCRBSCANRAYSOURCE_H_
#define HCRBSCANRAYSOURCE_H_

#include <QObject>
#include <BscanRay.h>
#include <hcrddsC.h>

/**
 * @brief This class accepts incoming instances of RadarDDS::ProductSet in
 * its makeBscanRay(RadarDDS::ProductSet) slot, converts them to BscanRay
 * objects, and emits newBscanRay(const BscanRay &) signals.
 */
class HcrBscanRaySource : public QObject {
    Q_OBJECT
public:
    HcrBscanRaySource();
    virtual ~HcrBscanRaySource();
signals:
    /**
     * @brief The newBscanRay signal is emitted when a new BscanRay has been
     * generated.
     * @param ray the newly generated BscanRay
     */
    void newBscanRay(const BscanRay & ray) const;
public slots:
    /**
     * Make a BscanRay from an incoming RadarDDS::ProductSet, and emit a
     * newBscanRay() signal for the new ray.
     * @param item the RadarDDS::ProductSet to be converted to a BscanRay
     */
    void makeBscanRay(RadarDDS::ProductSet item) const;
};

#endif /* HCRBSCANRAYSOURCE_H_ */
