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

static const double SPEED_OF_LIGHT = 2.99792458e8; // m s-1

ProductGenerator::ProductGenerator(QtTSReader *source, ProductWriter *sink,
        float rfRcvrGain, float pentek7142Gain, float rcvrNoise, 
        float wavelength, int nSamples) :
    _reader(source),
    _writer(sink),
    _momentsCalc(PRODGEN_MAX_GATES, false, false),
    _rfRcvrGain(rfRcvrGain),
    _pentek7142Gain(pentek7142Gain),
    _rcvrNoise(rcvrNoise),
    _wavelength(wavelength),
    _nSamples(nSamples),
    _fft(nSamples),
    _regFilter(),
    _nGates(0),
    _prt(0),
    _rangeToFirstGate(0.0),
    _gateSpacing(0.0),
    _samplesCached(0),
    _itemCount(0),
    _wrongChannelCount(0),
    _dwellCount(0),
    _dwellDiscardCount(0) {
    // Fixed bogus calibration (for now)
    // @todo supply real calibration info
    DsRadarCalib calib;
    float rcvrGain = _rfRcvrGain + _pentek7142Gain;
    float noisedbm = _rcvrNoise + rcvrGain - 13.35;
    calib.setReceiverGainDbHc(rcvrGain);
    calib.setNoiseDbmHc(noisedbm); // noise power at output of DRX including processing gain!
    std::cout << "noise pwr is " <<  noisedbm << " dBm" << std::endl;
//    calib.setBaseDbz1kmHc(-102.6 + 71.0); // MDS (0 db SNR) @ 1km
     calib.setBaseDbz1kmHc(_rcvrNoise + 68.6); // MDS (0 db SNR) @ 1km
    _momentsCalc.setCalib(calib);
    // Set the number of samples per dwell
    _momentsCalc.setNSamples(int(_nSamples));
    // Set the number of samples for the regression filter
    _regFilter.setup(_nSamples);
    //
    // Allocate our dwell-in-progress: _dwellIQ[PRODGEN_MAX_GATES][_nSamples]
    //
    _dwellIQ = new RadarComplex_t*[PRODGEN_MAX_GATES];
    for (int g = 0; g < PRODGEN_MAX_GATES; g++) {
        _dwellIQ[g] = new RadarComplex_t[_nSamples];
    }
    // Work space to hold a dwell of filtered IQ data for one gate
    _filteredGateIQ = new RadarComplex_t[_nSamples];
}

ProductGenerator::~ProductGenerator() {
    for (int gate = 0; gate < PRODGEN_MAX_GATES; gate++) {
        delete _dwellIQ[gate];
    }
    delete _dwellIQ;
    delete _filteredGateIQ;
}

void
ProductGenerator::run() {
    // Set an ongoing timer so that we print info on a regular basis.
    QTimer timer(this);
    connect(&timer, SIGNAL(timeout()), this, SLOT(showInfo()));
    timer.start(5000);  // every 5 seconds
    // Accept data via newItem() signals from our source, and free the
    // data pointers by sending returnItem() signals back.
    connect(_reader, SIGNAL(newItem(ProfilerDDS::TimeSeriesSequence*)),
            this, SLOT(handleItem(ProfilerDDS::TimeSeriesSequence*)));
    connect(this, SIGNAL(returnItem(ProfilerDDS::TimeSeriesSequence*)),
            _reader, SLOT(returnItemSlot(ProfilerDDS::TimeSeriesSequence*)));
    exec();
}

void
ProductGenerator::showInfo() {
    std::cerr << "showInfo(): " << _itemCount << " tsSequence-s received, " <<
        _wrongChannelCount << " were wrong channel. " <<
        _dwellCount << " product rays generated and " <<
        _dwellDiscardCount << " could not be published" << std::endl;
}

void
ProductGenerator::handleItem(ProfilerDDS::TimeSeriesSequence* tsSequence) {
    bool ok = true;

    _itemCount++;

    // We currently generate products only for channel zero
    if (tsSequence->chanId != 0) {
        _wrongChannelCount++;
        goto done;
    }

    // Run through the samples in the item
    for (unsigned int samp = 0; samp < tsSequence->tsList.length(); samp++) {
        ProfilerDDS::TimeSeries &ts = tsSequence->tsList[samp];
        
        float prt = ts.hskp.prt1;   // s
        float gateSpacing = 0.5 * SPEED_OF_LIGHT * 
            ts.hskp.rcvr_pulse_width;   // m
        float rangeToFirstGate = 0.5 * SPEED_OF_LIGHT * 
            ts.hskp.rcvr_gate0_delay;   // m
            
       	/*
       	 * XXXXX REMOVE THIS SOME TIME SOON!
       	 * Temporary KLUGE for pre-2010/04/23 archived data without 
       	 * rcvr_pulse_width and rcvr_gate0_delay metadata...
       	 */
       	 if (gateSpacing == 0.0) {
       	 	gateSpacing = 150.0;
       	 	rangeToFirstGate = 0.0;
       	 }
        
        /*
         * At the start of a dwell, initialize the moments calculator.
         * 
         * Do the same (and complain) if PRF, gate spacing, range to first 
         * gate, or gate count change in mid-dwell.
         */
        if (_samplesCached == 0 ||
                _prt != prt || _gateSpacing != gateSpacing ||
                _rangeToFirstGate != rangeToFirstGate || 
                _nGates != ts.hskp.gates) {
            if (_samplesCached) {
                std::cerr << "ProductGenerator::handleItem: @ " << ts.hskp.timetag <<
                    std::endl;
                std::cerr << "Gate count, PRF, range to first gate, or gate " <<
                    "spacing changed in mid-dwell. Dwell-in-progress abandoned." << 
                    std::endl;
                _samplesCached = 0;
            }
            _momentsCalc.init(prt, _wavelength, 
                    rangeToFirstGate * 0.001 /* km */,
                    gateSpacing * 0.001 /* km */);
            
            _dwellStart = ts.hskp.timetag;
            _prt = prt;
            _gateSpacing = gateSpacing;
            _rangeToFirstGate = rangeToFirstGate;
            _nGates = ts.hskp.gates;
        }

        // Gate count sanity check
        if (_nGates > PRODGEN_MAX_GATES) {
            std::cerr << "ProductGenerator::handleItem: Got " << _nGates <<
                " gates; PRODGEN_MAX_GATES is " << PRODGEN_MAX_GATES << std::endl;
            ok = false;
        }
        
        // Make sure gate count and PRF haven't changed in the dwell..
        if (_prt != prt || _gateSpacing != gateSpacing ||
                _rangeToFirstGate != rangeToFirstGate || 
                _nGates != ts.hskp.gates) {
            std::cerr << "ProductGenerator::handleItem: @ " << ts.hskp.timetag <<
                std::endl;
            std::cerr << "Gate count, PRF, range to first gate, or gate " <<
                "spacing changed in mid-dwell. Dwell-in-progress abandoned." << 
                std::endl;
            _samplesCached = 0;
            _momentsCalc.init(prt, _wavelength, 
                    rangeToFirstGate * 0.001 /* km */,
                    gateSpacing * 0.001 /* km */);
        }

        // Put the Is and Qs for this sample into the dwell-in-progress.
        double sqrtTwo = sqrt(2.0);
        double vMax = 1.0;	// Max signal voltage for HCR.  @todo make this changeable!

        for (int gate = 0; gate < _nGates; gate++) {
        	// Real part I, in volts = (I      /32768) * vMax / sqrt(2)
        	//                           counts
            _dwellIQ[gate][_samplesCached].re =
                vMax * (ts.data[2 * gate] / 32768.0) / sqrtTwo;
        	// Imaginary part Q, in volts = (Q      /32768) * vMax / sqrt(2)
        	//                                counts
            _dwellIQ[gate][_samplesCached].im =
                vMax * (ts.data[2 * gate + 1] / 32768.0) / sqrtTwo;
        }
        _samplesCached++;
        /*
         * If this sample created a complete dwell, publish it
         */
        if (_samplesCached == _nSamples) {
            _dwellCount++;
            MomentsFields moments[_nGates];
            MomentsFields filteredMoments[_nGates];
            // Calculate products for our dwell, gate by gate
            for (int gate = 0; gate < _nGates; gate++) {
                // First calculate moments from the unfiltered IQ data
                _momentsCalc.singlePol(_dwellIQ[gate], gate, false, moments[gate]);
//                // Filter IQ data for this gate
//                double filterRatio;
//                double spectralNoise;
//                double spectralSnr;
//                _momentsCalc.applyRegressionFilter(_nSamples, _fft, _regFilter,
//                    _dwellIQ[gate], _rcvrNoise, true, _filteredGateIQ,
//                    filterRatio, spectralNoise, spectralSnr);
//                // Calculate moments from the filtered IQ
//                _momentsCalc.singlePol(_filteredGateIQ, gate, true,
//                    filteredMoments[gate]);
            }
            // Publish the dwell
            publish_(moments, filteredMoments);
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
ProductGenerator::publish_(const MomentsFields *moments,
        const MomentsFields *filteredMoments) {
    RadarDDS::ProductSet *productSet;

    productSet = _writer->getEmptyItem();
    if (! productSet) {
        _dwellDiscardCount++;
        return;
    }

    productSet->radarId = 0;
    // The number of products is currently fixed at 8: DM, DMRAW, DZ, VE,
    // SW, SNR, DZ_F, VE_F
    productSet->products.length(8);
    RadarDDS::Product *product = productSet->products.get_buffer();

    // RAP moments "dbm" is really:
    //
    //            ngates
    //            ----
    //             \   2    2
    //  1/ngates *  | I  + Q
    //             /   g    g
    //            ----
    //            g = 1
    //
    // To convert to units of dBm, we need to account for the input
    // impedance, and convert from dB(W) to dB(mW).
    double rcvrInputImpedance = 50.0;
    double dbmCorr = -10.0 * log10(rcvrInputImpedance);
    dbmCorr += 30.0; // dB(W) -> dB(mW)

    // DM: coherent power
    addProductHousekeeping_(*product);
    product->name = "DM";
    product->description = "coherent power";
    product->units = "dBm";
    product->offset = -50.0;
    product->scale = 100.0 / 32768;
    product->data.length(_nGates);
    for (int g = 0; g < _nGates; g++) {
    	double dbm = moments[g].dbm + dbmCorr;
        product->data[g] =
            short((dbm - product->offset) / product->scale);
    }
    // DMRAW: coherent power (including receiver gain)
    product++;
    addProductHousekeeping_(*product);
    product->name = "DMRAW";
    product->description = "coherent power (including rcvr gain)";
    product->units = "dBm";
    product->offset = 0.0;
    product->scale = 100.0 / 32768;
    product->data.length(_nGates);
    float rcvrGain = _rfRcvrGain + _pentek7142Gain;
    for (int g = 0; g < _nGates; g++) {
    	// add back in the receiver gain
    	double rawDbm = moments[g].dbm + dbmCorr + (rcvrGain - _pentek7142Gain);
        product->data[g] =
            short((rawDbm - product->offset) / product->scale);
    }
    // DZ: reflectivity
    product++;
    addProductHousekeeping_(*product);
    product->name = "DZ";
    product->description = "reflectivity";
    product->units = "dBZ";
    product->offset = 0.0;
    product->scale = 100.0 / 32768;
    product->data.length(_nGates);
    for (int g = 0; g < _nGates; g++) {
        product->data[g] =
            short((moments[g].dbz - product->offset) / product->scale);
    }
    // VE: radial velocity
    product++;
    addProductHousekeeping_(*product);
    product->name = "VE";
    product->description = "radial velocity";
    product->units = "m s-1";
    product->offset = 0.0;
    product->scale = 100.0 / 32768;
    product->data.length(_nGates);
    for (int g = 0; g < _nGates; g++) {
        product->data[g] =
            short((moments[g].vel - product->offset) / product->scale);
    }
    // SW: spectrum width
    product++;
    addProductHousekeeping_(*product);
    product->name = "SW";
    product->description = "spectrum width";
    product->units = "m s-1";
    product->offset = 0.0;
    product->scale = 50.0 / 32768;
    product->data.length(_nGates);
    for (int g = 0; g < _nGates; g++) {
        product->data[g] =
            short((moments[g].width - product->offset) / product->scale);
    }
    // SNR: signal-to-noise ratio
    product++;
    addProductHousekeeping_(*product);
    product->name = "SNR";
    product->description = "signal-to-noise ratio";
    product->units = "dB";
    product->offset = 0.0;
    product->scale = 100.0 / 32768;
    product->data.length(_nGates);
    for (int g = 0; g < _nGates; g++) {
        product->data[g] =
            short((moments[g].snr - product->offset) / product->scale);
    }
    // DZ_F: filtered reflectivity
    product++;
    addProductHousekeeping_(*product);
    product->name = "DZ_F";
    product->description = "filtered reflectivity";
    product->units = "dBZ";
    product->offset = 0.0;
    product->scale = 100.0 / 32768;
    product->data.length(_nGates);
    for (int g = 0; g < _nGates; g++) {
        product->data[g] =
            short((filteredMoments[g].dbz - product->offset) / product->scale);
    }
    // VE_F: filtered radial velocity
    product++;
    addProductHousekeeping_(*product);
    product->name = "VE_F";
    product->description = "filtered radial velocity";
    product->units = "m s-1";
    product->offset = 0.0;
    product->scale = 100.0 / 32768;
    product->data.length(_nGates);
    for (int g = 0; g < _nGates; g++) {
        product->data[g] =
            short((filteredMoments[g].vel - product->offset) / product->scale);
    }

    // publish it
   _writer->publishItem(productSet);
}

void
ProductGenerator::addProductHousekeeping_(RadarDDS::Product & p) {
    p.hskp.timetag = _dwellStart;
//    p.hskp.az = 0.0;
//    p.hskp.el = 0.0;
    p.hskp.samples = _nSamples;
    // Single-PRT at this point
    p.hskp.staggered_prt = false;
    p.hskp.prt1 = _prt;
    p.hskp.prt2 = 0.0;
    p.hskp.rcvr_pulse_width = (2 * _gateSpacing) / SPEED_OF_LIGHT;
    p.hskp.tx_cntr_freq = SPEED_OF_LIGHT / _wavelength;
}
