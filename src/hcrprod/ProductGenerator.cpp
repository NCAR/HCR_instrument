/*
 * ProductGenerator.cpp
 *
 *  Created on: Oct 14, 2009
 *      Author: burghart
 */

#include "ProductGenerator.h"

#include <iostream>

const int ProductGenerator::PRODGEN_MAX_GATES = 2048;

ProductGenerator::ProductGenerator(QtTSReader *source, int nSamples) : 
    _source(source),
    _nSamples(nSamples),
    _momentsCalc(PRODGEN_MAX_GATES, false, false),
    _samplesInDwell(0) {
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
    connect(_source, SIGNAL(newItem(ProfilerDDS::TimeSeries*)), 
            this, SLOT(handleItem(ProfilerDDS::TimeSeries*)));
    connect(this, SIGNAL(returnItem(ProfilerDDS::TimeSeries*)),
            _source, SLOT(returnItemSlot(ProfilerDDS::TimeSeries*)));
    exec();
}


static unsigned int ItemCount = 0;
static unsigned int DwellCount = 0;

void 
ProductGenerator::handleItem(ProfilerDDS::TimeSeries* tsItem) {
    ProfilerDDS::Housekeeping *hskp = &(tsItem->hskp);
    int nGates = hskp->gates;
    bool ok = true;
    
    if (!(ItemCount++ % 100)) {
        std::cerr << ItemCount << " tsItem-s received, " << DwellCount <<
            " product rays published" << std::endl;
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
            _dwell[gate][_samplesInDwell].re = 
                tsItem->tsdata[offset] / 32768.0; // real part = I / 32768.0
            _dwell[gate][_samplesInDwell].im = 
                tsItem->tsdata[offset + 1] / 32768.0; // imaginary part = Q / 32768.0
        }
        _samplesInDwell++;
        
        if (_samplesInDwell == _nSamples) {
            DwellCount++;
            
            MomentsFields fields;
            // Calculate products for our dwell, gate by gate
            for (int gate = 0; gate < hskp->gates; gate++)
                _momentsCalc.singlePol(_dwell[gate], gate, false, fields);
            // TODO publish the dwell
            // Start a new dwell-in-progress
            _samplesInDwell = 0;
        }
    }
    
done:
    // Tell our source we're done with this item
    returnItem(tsItem);
    
    if (ok)
        return;
    else
        exit(1);
}
