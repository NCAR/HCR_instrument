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


ProductArchiver::ProductArchiver(DDSSubscriber& subscriber, 
        std::string topicName, std::string dataDir) :
            ProductReader(subscriber, topicName) {
}

ProductArchiver::~ProductArchiver() {
    // TODO Auto-generated destructor stub
}

void
ProductArchiver::notify() {
    RadxRay radxRay;
    
//    radxRay.setTime(secs, nanosecs);
    radxRay.setVolumeNumber(0);
    radxRay.setSweepNumber(0);
    radxRay.setCalibIndex(0);
    radxRay.setSweepMode(Radx::SWEEP_MODE_POINTING);    // HCR is pointing only (for now)
    radxRay.setPolarizationMode(Radx::POL_MODE_HORIZONTAL);
    radxRay.setPrfMode(Radx::PRF_MODE_FIXED);
    radxRay.setFollowMode(Radx::FOLLOW_MODE_NONE);
//    radxRay.setAzimuthDeg(az);
//    radxRay.setElevationDeg(el);
//    radxRay.setFixedAngleDeg(fixedAng);
    radxRay.setIsIndexed(false);
    radxRay.setAntennaTransition(false);
//    radxRay.setNSamples(nsamples);
//    radxRay.setPulseWidthUsec(pulsewidth);
//    radxRay.setPrtSec(prt);
    radxRay.setPrt2Sec(0.0);
    radxRay.setUnambigRange(); // calculate unambiguous range from PRT
//    radxRay.setNyquistMps(nyquist);
}
