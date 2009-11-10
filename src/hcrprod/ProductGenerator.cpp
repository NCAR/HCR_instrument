/*
 * ProductGenerator.cpp
 *
 *  Created on: Oct 14, 2009
 *      Author: burghart
 */

#include "ProductGenerator.h"

#include <iostream>
#include <ctime>

const int ProductGenerator::PRODGEN_MAX_GATES = 4096;

ProductGenerator::ProductGenerator(QtTSReader *source, ProductWriter *sink,
        int nSamples) : 
    _reader(source),
    _writer(sink),
    _nSamples(nSamples),
    _momentsCalc(PRODGEN_MAX_GATES, false, false),
    _samplesCached(0),
    _productDiscards(0) {
    // Fake radar parameters for now
    // @todo put in real radar parameters
    double prtSeconds = 1.0e-3;
    double wavelengthMeters = 3.0e-3;
    double startRangeKm = 0.0;
    double gateSpacingKm = 0.015;
    _momentsCalc.init(prtSeconds, wavelengthMeters, startRangeKm,
            gateSpacingKm);
    // Fixed bogus calibration (for now)
    // @todo supply real calibration info
    DsRadarCalib calib;
    calib.setReceiverGainDbHc(30.0);
    calib.setNoiseDbmHc(-100.0);
    calib.setBaseDbz1kmHc(-20.0);
    _momentsCalc.setCalib(calib);
    // Set the number of samples per dwell
    _momentsCalc.setNSamples(int(_nSamples));
    //
    // Allocate our dwell-in-progress: _dwell[PRODGEN_MAX_GATES][_nSamples]
    //
    _dwell = new RadarComplex_t*[PRODGEN_MAX_GATES];
    for (int g = 0; g < PRODGEN_MAX_GATES; g++)
        _dwell[g] = new RadarComplex_t[_nSamples];
}

ProductGenerator::~ProductGenerator() {
    for (int gate = 0; gate < PRODGEN_MAX_GATES; gate++)
        delete _dwell[gate];
    delete _dwell;
}

void 
ProductGenerator::run() {
    // Accept data via newItem() signals from our source, and free the
    // data pointers by sending returnItem() signals back.
    connect(_reader, SIGNAL(newItem(ProfilerDDS::TimeSeries*)), 
            this, SLOT(handleItem(ProfilerDDS::TimeSeries*)));
    connect(this, SIGNAL(returnItem(ProfilerDDS::TimeSeries*)),
            _reader, SLOT(returnItemSlot(ProfilerDDS::TimeSeries*)));
    exec();
}


static unsigned int ItemCount = 0;
static unsigned int DwellCount = 0;

void 
ProductGenerator::handleItem(ProfilerDDS::TimeSeries* tsItem) {
    ProfilerDDS::TSHousekeeping *hskp = &(tsItem->hskp);
    int nGates = hskp->gates;
    bool ok = true;
    
    if (!(ItemCount++ % 100)) {
        std::cerr << ItemCount << " tsItem-s received, " << DwellCount <<
            " product rays published, " << _productDiscards <<
            " discarded" << std::endl;
    }

    // Channel number sanity check
    if (hskp->chanId > 0) {
        std::cerr << "ProductGenerator::handleItem: Got data for channel " <<
            tsItem->chanId << "; only one channel was expected!" << std::endl;
        ok = false;
        goto done;
    }
    // Gate count sanity check
    if (nGates > PRODGEN_MAX_GATES) {
        std::cerr << "ProductGenerator::handleItem: Got " << hskp->gates << 
            " gates; PRODGEN_MAX_GATES is " << PRODGEN_MAX_GATES << std::endl;
        ok = false;
        goto done;
    }
    // Run through the samples in the item
    for (int samp = 0; samp < hskp->tsLength; samp++) {
        for (int gate = 0; gate < hskp->gates; gate++) {
            // Calculate the offset in the item's tsdata to this 
            // (sample/gate)'s I and Q data values
            int offset = 2 * (samp * nGates + gate);
            // Put the I and Q into the dwell-in-progress
            _dwell[gate][_samplesCached].re = 
                tsItem->data[offset] / 32768.0; // real part = I / 32768.0
            _dwell[gate][_samplesCached].im = 
                tsItem->data[offset + 1] / 32768.0; // imaginary part = Q / 32768.0
        }
        _samplesCached++;
        /*
         * If this sample created a complete dwell, publish it
         */
        if (_samplesCached == _nSamples) {
            DwellCount++;
            
            MomentsFields moments[hskp->gates];
            // Calculate products for our dwell, gate by gate
            for (int gate = 0; gate < hskp->gates; gate++)
                _momentsCalc.singlePol(_dwell[gate], gate, false, moments[gate]);
            publish(moments, hskp->timetag, hskp->gates);
            // Stuff the resulting products into 
            // @todo actually publish the dwell here...
            // Start a new dwell-in-progress
            _samplesCached = 0;
        }
    }
    
done:
    // Tell our source we're done with this item
    emit returnItem(tsItem);
    
    if (ok)
        return;
    else
        exit(1);
}

void
ProductGenerator::publish(const MomentsFields *moments, long long timetag,
        int nGates) {
    RadarDDS::ProductSet *productSet;
    float dwellPeriod = 0.1;  // @todo get a real value here!
    
    productSet = _writer->getEmptyItem();
    if (!productSet) {
        _productDiscards++;
        return;
    }
    // We ignore the timetag for now, just stuffing in current system time
    // @todo use the given time (when it's good)
    struct timeval now;
    gettimeofday(&now, 0);
    timetag = 1000000LL * now.tv_sec + now.tv_usec; // usecs since epoch
    
    productSet->radarId = 0;
    
    productSet->products.length(5);
    RadarDDS::Product *product = productSet->products.get_buffer();
    
    product->hskp.timetag = timetag;
    product->hskp.dwellPeriod = dwellPeriod;
    product->name = "DM";
    product->description = "coherent power";
    product->units = "dBm";
    product->offset = -50.0;
    product->scale = 100.0 / 32768;
    product->data.length(nGates);
    for (int g = 0; g < nGates; g++) {
        product->data[g] = 
            short((moments[g].dbm - product->offset) / product->scale);
    }
    
    product++;
    product->hskp.timetag = timetag;
    product->hskp.dwellPeriod = dwellPeriod;
    product->name = "DZ";
    product->description = "reflectivity";
    product->units = "dBZ";
    product->offset = 0.0;
    product->scale = 100.0 / 32768;
    product->data.length(nGates);
    for (int g = 0; g < nGates; g++) {
        product->data[g] = 
            short((moments[g].dbz - product->offset) / product->scale);
    }
    
    product++;
    product->hskp.timetag = timetag;
    product->hskp.dwellPeriod = dwellPeriod;
    product->name = "VE";
    product->description = "radial velocity";
    product->units = "m s-1";
    product->offset = 0.0;
    product->scale = 100.0 / 32768;
    product->data.length(nGates);
    for (int g = 0; g < nGates; g++) {
        product->data[g] = 
            short((moments[g].vel - product->offset) / product->scale);
    }
    
    product++;
    product->hskp.timetag = timetag;
    product->hskp.dwellPeriod = dwellPeriod;
    product->name = "SW";
    product->description = "spectrum width";
    product->units = "m s-1";
    product->offset = 0.0;
    product->scale = 50.0 / 32768;
    product->data.length(nGates);
    for (int g = 0; g < nGates; g++) {
        product->data[g] = 
            short((moments[g].width - product->offset) / product->scale);
    }
    
    product++;
    product->hskp.timetag = timetag;
    product->hskp.dwellPeriod = dwellPeriod;
    product->name = "SNR";
    product->description = "signal-to-noise ratio";
    product->units = "dB";
    product->offset = 0.0;
    product->scale = 100.0 / 32768;
    product->data.length(nGates);
    for (int g = 0; g < nGates; g++) {
        product->data[g] = 
            short((moments[g].snr - product->offset) / product->scale);
    }
    
    // publish it
   _writer->publishItem(productSet);
}
