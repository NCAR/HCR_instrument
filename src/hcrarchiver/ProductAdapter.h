/*
 * ProductAdapter.h
 * 
 * Adapter class for RadarDDS::ProductSet <-> RadxRay translations.
 *
 *  Created on: June 7, 2010
 *      Author: burghart
 */

#ifndef PRODUCTADAPTER_H_
#define PRODUCTADAPTER_H_

// RadarrDDS::ProductSet class
#include "hcrddsTypeSupportImpl.h"

// RAL RadxRay class
#include <Radx/RadxRay.hh>


class ProductAdapter {
public:
    /**
     * Convert from RadxRay (+ RadxVol) to a RadarDDS::ProductSet ray.
     * @param radxRay the RadxRay to be converted
     * @param productSet the destination RadarDDS::ProductSet
     * @param txFrequency the transmit center frequency, in Hz, to be assigned
     *    to productSet
     */
    static void RadxRayToDDS(const RadxRay& radxRay, 
            RadarDDS::ProductSet& productSet, float txFrequency);
    /**
     * Convert a RadarDDS::ProductSet ray to a RadxRay.
     * @param productSet the RadarDDS::ProductSet ray to be converted
     * @param radxRay the destination RadxRay
     * @param volNum the volume number to assign to the new RadxRay.
     */
    static void DDSToRadxRay(const RadarDDS::ProductSet& productSet,
            RadxRay& radxRay, int volNum);
};

#endif /* PRODUCTADAPTER_H_ */
