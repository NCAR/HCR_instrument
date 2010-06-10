/*
 * ProductAdapter.cpp
 *
 *  Created on: Jun 7, 2010
 *      Author: burghart
 */
#include <iostream>
#include <iomanip>

#include "ProductAdapter.h"

static const double SPEED_OF_LIGHT = 2.99792458e8; // m s-1


void ProductAdapter::RadxRayToDDS(const RadxRay& radxRay, 
            RadarDDS::ProductSet& productSet, float txFrequency) {
    // Assemble needed metadata values
    long long timetagUsecs = radxRay.getTimeSecs() * 1000000LL +
        radxRay.getNanoSecs() / 1000;   // usecs since 1970-01-01 00:00:00 UTC
    float az = radxRay.getAzimuthDeg();
    float el = radxRay.getElevationDeg();
    float gateSpacing = radxRay.getGateSpacingKm() * 1000.0; // m
    float rcvrPulseWidth = (2.0 * gateSpacing) / SPEED_OF_LIGHT; // s
    float prt1 = radxRay.getPrtSec();
    float prt2 = radxRay.getPrt2Sec();
    int nSamples = radxRay.getNSamples();
    
    // We only handle single-PRF data for now. Exit on anything else.
    if (radxRay.getPrfMode() != Radx::PRF_MODE_FIXED) {
        std::cerr << __FUNCTION__ << ": at data time " << 
            std::setprecision(6) << 1.0e-6 * timetagUsecs << 
            ", PRF mode is not fixed!" << std::endl;
        exit(1);
    }
    
    // Build the RadarDDS::ProductSet product by product
    int nProducts = radxRay.getNFields();
    
    productSet.products.length(nProducts);
    RadarDDS::Product *product = productSet.products.get_buffer();
    
    for (int p = 0; p < nProducts; p++) {
        product[p].hskp.timetag = timetagUsecs;
        product[p].hskp.az = az;
        product[p].hskp.el = el;
        product[p].hskp.prt1 = prt1;
        product[p].hskp.prt2 = prt2;
        product[p].hskp.rcvr_pulse_width = rcvrPulseWidth;
        product[p].hskp.staggered_prt = false;  // single PRT for now!
        product[p].hskp.tx_cntr_freq = txFrequency;
        
        RadxField* radxField = radxRay.getField(p);
        // We can only handle SI16 (scaled 16-bit integer) data
        if (radxField->getDataType() != Radx::SI16) {
            std::cerr << __FUNCTION__ << ": at data time " << 
                std::setprecision(6) << 1.0e-6 * timetagUsecs << 
                ", field " << radxField->getName() << " data are not SI16!" << 
                std::endl;
            exit(1);
        }
        product[p].name = radxField->getName().c_str();
        product[p].description = radxField->getLongName().c_str();
        product[p].units = radxField->getUnits().c_str();
        product[p].offset = radxField->getOffset();
        product[p].scale = radxField->getScale();
        product[p].bad_value = radxField->getMissingSi16();
        product[p].samples = nSamples;
        
        // Copy the 16-bit data from radxField into this RadarDDS::Product
        int nGates = radxField->getNGates();
        product[p].data.allocbuf(radxField->getNGates());
        memcpy(product[p].data.get_buffer(), radxField->getDataSi16(), 2 * nGates);
    }
}

void ProductAdapter::DDSToRadxRay(const RadarDDS::ProductSet& productSet, 
        RadxRay& radxRay, int volNum) {
    // Get common housekeeping from the first product in the ProductSet
    const RadarDDS::Product &firstProduct = productSet.products[0];
    
    // get the time tag for the ray, in microseconds since 1970-01-01 00:00:00 UTC
    long long timetagUsecs = firstProduct.hskp.timetag;
    
    time_t rayTimeSecs = timetagUsecs / 1000000;
    int rayTimeNanos = (timetagUsecs % 1000000) * 1000;
    radxRay.setTime(rayTimeSecs, rayTimeNanos);
    int nGates = firstProduct.data.length();
    float gateSpacing = 0.5 * SPEED_OF_LIGHT * firstProduct.hskp.rcvr_pulse_width;  // m
    radxRay.setConstantGeom(nGates, 0.0, 1.0e-3 * gateSpacing);
    radxRay.setVolumeNumber(volNum);
    radxRay.setSweepNumber(0);
    radxRay.setCalibIndex(0);
    radxRay.setSweepMode(Radx::SWEEP_MODE_POINTING);   // HCR is pointing only for now
    radxRay.setPolarizationMode(Radx::POL_MODE_HORIZONTAL);
    radxRay.setPrfMode(Radx::PRF_MODE_FIXED);  // single PRT for now!
    radxRay.setFollowMode(Radx::FOLLOW_MODE_NONE);
    radxRay.setAzimuthDeg(firstProduct.hskp.az);
    radxRay.setElevationDeg(firstProduct.hskp.el);
    radxRay.setFixedAngleDeg(0.0); // @TODO
    radxRay.setIsIndexed(false);
    radxRay.setAntennaTransition(false);
    radxRay.setNSamples(firstProduct.samples);
    radxRay.setPrtSec(firstProduct.hskp.prt1);
    radxRay.setPrt2Sec(firstProduct.hskp.prt2);
    radxRay.setUnambigRange(); // calculate unambiguous range from PRT
    float wavelength = SPEED_OF_LIGHT / firstProduct.hskp.tx_cntr_freq;
    float prf = 1.0 / firstProduct.hskp.prt1;   // Hz
    float nyquist = (prf * wavelength) / 4;     // Nyquist max speed
    radxRay.setNyquistMps(nyquist);
    
    // Add each product in productSet as a new field in radxRay
    int nProducts = productSet.products.length();
    for (int p = 0; p < nProducts; p++) {
        const RadarDDS::Product& product = productSet.products[p];
        radxRay.addField(std::string(product.name), 
                std::string(product.units), product.data.length(), 
                (Radx::si16)product.bad_value, 
                (Radx::si16*)product.data.get_buffer(),
                product.scale, product.offset, true);
        // Long name has to be set separately
        radxRay.getField(p)->setLongName(std::string(product.description));
    }
}
