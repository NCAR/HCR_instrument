/*
 * ProductArchiver.cpp
 *
 *  Created on: May 5, 2010
 *      Author: burghart
 */

#include "ProductArchiver.h"

#include <Radx/RadxRay.hh>

#include <dds/DCPS/Service_Participant.h>    // for TheServiceParticipant

// Pointer to our singleton instance
ProductArchiver* ProductArchiver::_theArchiver = 0;

static const double SPEED_OF_LIGHT = 2.99792458e8; // m s-1


ProductArchiver::ProductArchiver(DDSSubscriber& subscriber, 
        std::string topicName, std::string dataDir) :
            ProductReader(subscriber, topicName) {
}

ProductArchiver::~ProductArchiver() {
    // TODO Auto-generated destructor stub
}

void
ProductArchiver::notify() {
    while (RadarDDS::ProductSet* ps = getNextItem()) {
        // Get the ray housekeeping from the first product in the ProductSet
        RadarDDS::Product &firstProduct = ps->products[0];
        
        // get the time tag, in microseconds since 1970-01-01 00:00:00 UTC
        long long timetagUsecs = firstProduct.hskp.timetag;
        
        // Now build the RadxRay from the ProductSet
        RadxRay radxRay;
        
        time_t rayTimeSecs = timetagUsecs / 1000000;
        int rayTimeNanos = (timetagUsecs % 1000000) * 1000;
        radxRay.setTime(rayTimeSecs, rayTimeNanos);
        radxRay.setVolumeNumber(0);
        radxRay.setSweepNumber(0);
        radxRay.setCalibIndex(0);
        radxRay.setSweepMode(Radx::SWEEP_MODE_POINTING);    // HCR is pointing only (for now)
        radxRay.setPolarizationMode(Radx::POL_MODE_HORIZONTAL);
        radxRay.setPrfMode(Radx::PRF_MODE_FIXED);
        radxRay.setFollowMode(Radx::FOLLOW_MODE_NONE);
//        radxRay.setAzimuthDeg(az);
//        radxRay.setElevationDeg(el);
//        radxRay.setFixedAngleDeg(fixedAng);
        radxRay.setIsIndexed(false);
        radxRay.setAntennaTransition(false);
        radxRay.setNSamples(firstProduct.hskp.samples);
        // Receiver pulse width in seconds
        radxRay.setPulseWidthUsec(1.0e6 * firstProduct.hskp.rcvr_pulse_width);
        radxRay.setPrtSec(firstProduct.hskp.prt1);
        radxRay.setPrt2Sec(0.0);
        radxRay.setUnambigRange(); // calculate unambiguous range from PRT
        float wavelength = SPEED_OF_LIGHT / firstProduct.hskp.tx_cntr_freq;
        float prf = 1.0 / firstProduct.hskp.prt1;
        float nyquist = (prf * wavelength) / 4;    // Nyquist max speed
        radxRay.setNyquistMps(nyquist);
        
        // Return the item to the DDSReader
        returnItem(ps);
    }
}
