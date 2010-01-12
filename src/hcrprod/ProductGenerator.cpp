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
    _itemCount(0),
    _wrongChannelCount(0),
    _dwellCount(0),
    _dwellDiscardCount(0) {
    // Fake radar parameters for now
    // @todo put in real radar parameters
    double prtSeconds = 2.0e-4;
    double wavelengthMeters = 3.2e-4;
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
    connect(_reader, SIGNAL(newItem(ProfilerDDS::TimeSeriesSequence*)), 
            this, SLOT(handleItem(ProfilerDDS::TimeSeriesSequence*)));
    connect(this, SIGNAL(returnItem(ProfilerDDS::TimeSeriesSequence*)),
            _reader, SLOT(returnItemSlot(ProfilerDDS::TimeSeriesSequence*)));
    exec();
}


void 
ProductGenerator::handleItem(ProfilerDDS::TimeSeriesSequence* tsSequence) {
    bool ok = true;
    
    // Report occasionally
    if (!(_itemCount % 100)) {
        std::cerr << _itemCount << " tsSequence-s received, " << 
            _wrongChannelCount << " were wrong channel, " <<
            _dwellCount << " product rays generated, " << 
            _dwellDiscardCount << " rays could not be published" << std::endl;
    }
    _itemCount++;
    
    // We currently generate products only for channel zero
    if (tsSequence->chanId != 0) {
        _wrongChannelCount++;
        goto done;
    }

    // Run through the samples in the item
    for (unsigned int samp = 0; samp < tsSequence->tsList.length(); samp++) {
        ProfilerDDS::TimeSeries &ts = tsSequence->tsList[samp];
        /*
         * Keep the dwell start time, gates, & PRF
         */
        if (_samplesCached == 0) {
            _dwellStart = ts.hskp.timetag;
            _dwellPrf = ts.hskp.prf;
            _dwellGates = ts.hskp.gates;
        }
        
        // Gate count sanity check
        if (_dwellGates > PRODGEN_MAX_GATES) {
            std::cerr << "ProductGenerator::handleItem: Got " << _dwellGates << 
                " gates; PRODGEN_MAX_GATES is " << PRODGEN_MAX_GATES << std::endl;
            ok = false;
        }
        if (_dwellGates != ts.hskp.gates) {
            // Gate count changed.  Forget the dwell in progress and start 
            // a new dwell.
            std::cerr << "ProductGenerator::handleItem: Gate count changed " <<
                "from " << _dwellGates << " to " << ts.hskp.gates << 
                " in the middle of a dwell. Dwell-in-progress abandoned." << 
                std::endl;
            _samplesCached = 0;
        }
        
        // Put the Is and Qs for this sample into the dwell-in-progress
        for (int gate = 0; gate < _dwellGates; gate++) {
            _dwell[gate][_samplesCached].re = 
                ts.data[2 * gate] / 32768.0; // real part = I / 32768.0
            _dwell[gate][_samplesCached].im = 
                ts.data[2 * gate + 1] / 32768.0; // imaginary part = Q / 32768.0
        }
        _samplesCached++;     
        /*
         * If this sample created a complete dwell, publish it
         */
        if (_samplesCached == _nSamples) {
            _dwellCount++;
            MomentsFields moments[_dwellGates];
            // Calculate products for our dwell, gate by gate
            for (int gate = 0; gate < _dwellGates; gate++)
                _momentsCalc.singlePol(_dwell[gate], gate, false, moments[gate]);
            // Publish the dwell
            publish_(moments);
            // Start a new dwell-in-progress
            _samplesCached = 0;
        }
    }
    
done:
    // Tell our source we're done with this item
    emit returnItem(tsSequence);
    
    if (ok)
        return;
    else
        exit(1);
}

void
ProductGenerator::publish_(const MomentsFields *moments) {
    RadarDDS::ProductSet *productSet;

    productSet = _writer->getEmptyItem();
    if (! productSet) {
        _dwellDiscardCount++;
        return;
    }

    productSet->radarId = 0;
    
    productSet->products.length(5);
    RadarDDS::Product *product = productSet->products.get_buffer();
    
    addProductHousekeeping_(*product);
    product->name = "DM";
    product->description = "coherent power";
    product->units = "dBm";
    product->offset = -50.0;
    product->scale = 100.0 / 32768;
    product->data.length(_dwellGates);
    for (int g = 0; g < _dwellGates; g++) {
        product->data[g] = 
            short((moments[g].dbm - product->offset) / product->scale);
    }
    
    product++;
    addProductHousekeeping_(*product);
    product->name = "DZ";
    product->description = "reflectivity";
    product->units = "dBZ";
    product->offset = 0.0;
    product->scale = 100.0 / 32768;
    product->data.length(_dwellGates);
    for (int g = 0; g < _dwellGates; g++) {
        product->data[g] = 
            short((moments[g].dbz - product->offset) / product->scale);
    }
    
    product++;
    addProductHousekeeping_(*product);
    product->name = "VE";
    product->description = "radial velocity";
    product->units = "m s-1";
    product->offset = 0.0;
    product->scale = 100.0 / 32768;
    product->data.length(_dwellGates);
    for (int g = 0; g < _dwellGates; g++) {
        product->data[g] = 
            short((moments[g].vel - product->offset) / product->scale);
    }
    
    product++;
    addProductHousekeeping_(*product);
    product->name = "SW";
    product->description = "spectrum width";
    product->units = "m s-1";
    product->offset = 0.0;
    product->scale = 50.0 / 32768;
    product->data.length(_dwellGates);
    for (int g = 0; g < _dwellGates; g++) {
        product->data[g] = 
            short((moments[g].width - product->offset) / product->scale);
    }
    
    product++;
    addProductHousekeeping_(*product);
    product->name = "SNR";
    product->description = "signal-to-noise ratio";
    product->units = "dB";
    product->offset = 0.0;
    product->scale = 100.0 / 32768;
    product->data.length(_dwellGates);
    for (int g = 0; g < _dwellGates; g++) {
        product->data[g] = 
            short((moments[g].snr - product->offset) / product->scale);
    }
    
    // publish it
   _writer->publishItem(productSet);
}

void
ProductGenerator::addProductHousekeeping_(RadarDDS::Product & p) {
    p.hskp.timetag = _dwellStart;
    p.hskp.prf = _dwellPrf;
    p.hskp.samples = _nSamples;
    p.hskp.dwellPeriod = _nSamples / _dwellPrf;
}
