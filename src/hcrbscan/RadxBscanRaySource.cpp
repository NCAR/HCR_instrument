// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2016                                         
// ** University Corporation for Atmospheric Research (UCAR)                 
// ** National Center for Atmospheric Research (NCAR)                        
// ** Boulder, Colorado, USA                                                 
// ** BSD licence applies - redistribution and use in source and binary      
// ** forms, with or without modification, are permitted provided that       
// ** the following conditions are met:                                      
// ** 1) If the software is modified to produce derivative works,            
// ** such modified software should be clearly marked, so as not             
// ** to confuse it with the version available from UCAR.                    
// ** 2) Redistributions of source code must retain the above copyright      
// ** notice, this list of conditions and the following disclaimer.          
// ** 3) Redistributions in binary form must reproduce the above copyright   
// ** notice, this list of conditions and the following disclaimer in the    
// ** documentation and/or other materials provided with the distribution.   
// ** 4) Neither the name of UCAR nor the names of its contributors,         
// ** if any, may be used to endorse or promote products derived from        
// ** this software without specific prior written permission.               
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS  
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED      
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.    
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
/*
 * RadxBscanRaySource.cpp
 *
 *  Created on: May 2, 2012
 *      Author: burghart
 */

#include "RadxBscanRaySource.h"
#include <BscanRay.h>
#include <Radx/RadxRay.hh>
#include <Radx/RadxGeoref.hh>
#include <cassert>

RadxBscanRaySource::RadxBscanRaySource() {
}

RadxBscanRaySource::~RadxBscanRaySource() {
}

void
RadxBscanRaySource::makeBscanRay(RadxRay & radxRay) const {
    // In the BscanRay constructor below, we only calculate dwell time correctly
    // for single PRT operation. Make sure that's what we have here.
    assert(radxRay.getPrtMode() == Radx::PRT_MODE_FIXED);
    
    // Set lat, lon, alt to zeros unless we have a georef.
    float lat(0.0);
    float lon(0.0);
    float alt(0.0);
    const RadxGeoref * georef = radxRay.getGeoreference();
    if (georef) {
        lat = georef->getLatitude();
        lon = georef->getLongitude();
        alt = georef->getAltitudeKmMsl() * 1.0e3;   // km -> m
    }

    // Construct an equivalent BscanRay, but with no data yet.
    BscanRay bscanRay(1.0e6 * radxRay.getTimeDouble(), 
            lat,
            lon,
            alt,
            radxRay.getAzimuthDeg(),
            radxRay.getElevationDeg(),
            radxRay.getNSamples() * radxRay.getPrtSec(),
            radxRay.getNGates(),
            radxRay.getGateSpacingKm() * 1.0e3);
    
    // We need 32-bit float data
    radxRay.convertToFl32();

    // Copy all fields from the RadxRay into the BscanRay
    for (size_t f = 0; f < radxRay.getNFields(); f++) {
        const RadxField & radxField = *radxRay.getField(f);
        size_t nPoints = radxField.getNPoints();
        
        // Copy the data for this field into a std::vector<float>
        assert(radxField.getDataType() == Radx::FL32);
        const float * flData = radxField.getDataFl32();
        std::vector<float> vecData(flData, flData + nPoints);
        
        // Add the new product to the BscanRay.
        bscanRay.addProduct(radxField.getName(), radxField.getUnits(), 
                radxField.getMissingFl32(), vecData) ;       
    }
    
    // Finally, emit the newBscanRay signal with our new BscanRay
    emit newBscanRay(bscanRay);
}

