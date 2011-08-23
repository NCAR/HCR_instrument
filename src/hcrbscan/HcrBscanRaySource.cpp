/*
 * HcrBscanRaySource.cpp
 *
 *  Created on: Aug 22, 2011
 *      Author: burghart
 */

#include <cassert>
#include <iostream>
#include <vector>
#include "HcrBscanRaySource.h"

static const float SPEED_OF_LIGHT = 2.99792458e8;   // m/s

HcrBscanRaySource::HcrBscanRaySource() {
}

HcrBscanRaySource::~HcrBscanRaySource() {
}

void
HcrBscanRaySource::makeBscanRay(RadarDDS::ProductSet item) const {
    RadarDDS::SysHousekeeping & hskp = item.products[0].hskp;

    // Make sure all products in the RadarDDS::ProductSet have the same
    // number of samples. Otherwise dwell period will be different for 
    // different products, and we can't have that...
    int nSamples = item.products[0].samples;
    for (unsigned int p = 1; p < item.products.length(); p++) {
        if (item.products[p].samples != nSamples) {
            std::cerr << __PRETTY_FUNCTION__ << 
                    ": # of samples differ for products - " <<
                    nSamples << " for " << item.products[0].name.in() <<
                    " and " << item.products[p].samples << " for " << 
                    item.products[p].name.in() << std::endl;
            exit(1);
        }
        assert(item.products[p].samples == nSamples);
    }
    // Dwell period. 
    // @TODO This currently only works for single PRT data!
    assert(hskp.staggered_prt == false);
    float dwellPeriod = hskp.prt1 * nSamples;
    // gate spacing
    float gateSpacing = 0.5 * hskp.rcvr_pulse_width * SPEED_OF_LIGHT;

    // Instantiate a BscanRay with no products
    BscanRay ray(hskp.timetag, hskp.latitude, hskp.longitude, 
            hskp.altitude, hskp.az, hskp.el, dwellPeriod, hskp.gates,
            gateSpacing);
    
    // Add all products from the RadarDDS::ProductSet
    for (unsigned int p = 0; p < item.products.length(); p++) {
        RadarDDS::Product & ddsProd = item.products[p];
        // Build the floating point data array for this product
        std::vector<float> data;
        for (int g = 0; g < hskp.gates; g++) {
            data.push_back(ddsProd.data[g] * ddsProd.scale + ddsProd.offset);
        }
        // Add this product to the BscanRay
        ray.addProduct(ddsProd.name.in(), ddsProd.units.in(), data);
    }
    // Finally, emit the newBscanRay signal with our new BscanRay
    emit newBscanRay(ray);
}
