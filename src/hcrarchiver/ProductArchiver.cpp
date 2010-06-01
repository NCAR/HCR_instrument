/*
 * ProductArchiver.cpp
 *
 *  Created on: May 5, 2010
 *      Author: burghart
 */
#include "ProductArchiver.h"
#include <svnInfo.h>

#include <sstream>

#include <Radx/RadxRay.hh>

#include <dds/DCPS/Service_Participant.h>    // for TheServiceParticipant
#include <boost/date_time/posix_time/posix_time.hpp>

// Pointer to our singleton instance
ProductArchiver* ProductArchiver::_theArchiver = 0;

static const double SPEED_OF_LIGHT = 2.99792458e8; // m s-1


ProductArchiver::ProductArchiver(DDSSubscriber& subscriber, 
        std::string topicName, std::string dataDir) :
            ProductReader(subscriber, topicName),
            _volNum(-1),
            _radxFile(),
            _radxVol() {
    // Write files in CfRadial (netCDF) format, using the volume start time
    // to names files.
    _radxFile.setFileFormat(RadxFile::FILE_FORMAT_CFRADIAL);
    _radxFile.setWriteUsingEndTime(false);
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
        double timetag = 1.0e-6 * firstProduct.hskp.timetag;
        long long timetagUsecs = firstProduct.hskp.timetag;
        
        // Start a new volume after 1 minute
        if (_radxVol.getNRays() > 0 && (timetag - _volStartTime) > 60.0) {
            std::ostringstream history;
            history << boost::posix_time::microsec_clock::universal_time() <<
                ": written by ProductArchiver rev. " << SVNREVISION;
            _radxVol.setHistory(history.str());
            _radxVol.loadVolFieldsFromRays(false);
            
        	std::cerr << "writing a volume with " << _radxVol.getNRays() <<
                " rays" << std::endl;
            _radxFile.writeToPath(_radxVol, "/data_first");
            
            // clear out our RadxVol
            _radxVol.clear();
            // increment to the next volume number
            _volNum++;
        }
        
        // Now build the RadxRay from the ProductSet
        RadxRay* radxRay = new RadxRay();
        
        time_t rayTimeSecs = timetagUsecs / 1000000;
        int rayTimeNanos = (timetagUsecs % 1000000) * 1000;
        radxRay->setTime(rayTimeSecs, rayTimeNanos);
        radxRay->setVolumeNumber(_volNum);
        radxRay->setSweepNumber(0);
        radxRay->setCalibIndex(0);
        radxRay->setSweepMode(Radx::SWEEP_MODE_POINTING);    // HCR is pointing only (for now)
        radxRay->setPolarizationMode(Radx::POL_MODE_HORIZONTAL);
        radxRay->setPrfMode(Radx::PRF_MODE_FIXED);
        radxRay->setFollowMode(Radx::FOLLOW_MODE_NONE);
//        radxRay->setAzimuthDeg(az);
//        radxRay->setElevationDeg(el);
//        radxRay->setFixedAngleDeg(fixedAng);
        radxRay->setIsIndexed(false);
        radxRay->setAntennaTransition(false);
        radxRay->setNSamples(firstProduct.hskp.samples);
        radxRay->setPulseWidthUsec(1.0e6 * firstProduct.hskp.rcvr_pulse_width);
        radxRay->setPrtSec(firstProduct.hskp.prt1);
        radxRay->setPrt2Sec(0.0);
        radxRay->setUnambigRange(); // calculate unambiguous range from PRT
        float wavelength = SPEED_OF_LIGHT / firstProduct.hskp.tx_cntr_freq;
        float prf = 1.0 / firstProduct.hskp.prt1;   // Hz
        float nyquist = (prf * wavelength) / 4;     // Nyquist max speed
        radxRay->setNyquistMps(nyquist);
        
        int nProducts = ps->products.length();
        for (int p = 0; p < nProducts; p++) {
            RadarDDS::Product& product = ps->products[p];
            radxRay->addField(std::string(product.name), 
                    std::string(product.units), product.data.length(), 
                    (Radx::si16)product.bad_value, 
                    (Radx::si16*)product.data.get_buffer(),
                    product.scale, product.offset, true);
        }
        
        // save the start time of the new volume
        if (_radxVol.getNRays() == 0)
            _volStartTime = timetag;
        // Add the new ray to our current volume
        _radxVol.addRay(radxRay);
        
        // Return the item to the DDSReader
        returnItem(ps);
    }
}
