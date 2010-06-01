/*
 * ProductGenerator.h
 *
 *  Created on: Oct 14, 2009
 *      Author: burghart
 */

#ifndef PRODUCTGENERATOR_H_
#define PRODUCTGENERATOR_H_

#include <vector>
#include <QThread>
#include <QtTSReader.h>
#include <ProductWriter.h>
#include <radar/RadarMoments.hh>

class ProductGenerator : public QThread {
    
    Q_OBJECT
    
public:
	/**
	 * Constructor.
	 * @param source the QtTSReader source for time series data
	 * @param sink the ProductWriter sink for resulting products
	 * @param rfRcvrGain the gain of the RF receiver, in dB
	 * @param pentek7142Gain the gain in the Pentek card, in dB
	 * @param rcvrNoise the noise value for the receiver, in dBm
	 * @param wavelength radar wavelength, m
	 * int nSamples the number of pulses to use per dwell
	 */
    ProductGenerator(QtTSReader *source, ProductWriter *sink, float rfRcvrGain, 
    		float pentek7142Gain, float rcvrNoise, float wavelength, 
    		int nSamples);
    virtual ~ProductGenerator();
    void run();
    /**
     * Maximum number of gates which can be handled
     */
    static const int PRODGEN_MAX_GATES;
    
    /**
     * Bad value flag
     */
    static const short PRODUCT_BAD_VALUE = -32768;
    
protected slots:
    /**
     * Handle one TimeSeries item from our source.  If a complete ray of
     * products becomes available after handling, it will be published.
     * @param item pointer to the new ProfilerDDS::TimeSeries item
     */
    virtual void handleItem(ProfilerDDS::TimeSeriesSequence *item);
    /**
     * Show information.
     */
    void showInfo();
    
signals:
    /**
     * This signal is emitted when we are finished with an item received
     * from our source.
     * @param item pointer to the ProfilerDDS::TimeSeries item being returned
     */
    void returnItem(ProfilerDDS::TimeSeriesSequence *item);
    
private:
    /**
     * Publish a ray of data
     */
    void publish_(const MomentsFields *moments, const MomentsFields *filteredMoments);
    void addProductHousekeeping_(RadarDDS::Product & p);
            
    /**
     * QtTSReader source of time series data
     */
    QtTSReader *_reader;
    /**
     * ProductWriter sink for our products
     */
    ProductWriter *_writer;
    /**
     * The RAP radar moments calculator
     */
    RadarMoments _momentsCalc;
    /**
     * Receiver gain from LNA to input of Pentek 7142, in dB
     */
    float _rfRcvrGain;
    /**
     * Gain input of Pentek 7142 to output of DDC, in dB
     */
    float _pentek7142Gain;
    /**
     * Receiver noise power, in dBm
     */
    float _rcvrNoise;
    /**
     * Radar wavelength, m
     */
    float _wavelength;
    /**
     * Number of samples to integrate when generating products
     */
    int _nSamples;
    /**
     * RadarFft object to be used in filtering.
     */
    RadarFft _fft;
    /**
     * RegressionFilter object to be used in filtering.
     */
    RegressionFilter _regFilter;
    /**
     * Accumulated time series IQ data for a dwell in progress.
     * This is sized to hold _nSamples * _nGates sets of I and Q.
     * The ordering is _dwell[gate][sample], which allows easy use
     * of RadarMoments methods.
     */
    RadarComplex_t **_dwellIQ;
    RadarComplex_t *_filteredGateIQ;    // work space to hold filtered IQ data for one gate
    long long _dwellStart;      // dwell start time in us since 1970-01-01 00:00 UTC
    int _nGates;                // gate count for the dwell
    float _prt;                 // PRT for the dwell
    float _rangeToFirstGate;    // range to leading edge of first gate, m
    float _gateSpacing;         // gate spacing, m
    int _samplesCached;         // samples in the dwell so far
    int _itemCount;         	// TimeSeriesSequence-s received
    int _wrongChannelCount; 	// TSS-s with the wrong channel
    int _dwellCount;        	// dwells built
    int _dwellDiscardCount;		// dwells that could not be published
    long _lastPulseRcvd;		// last pulse number we received
    int _ddsDrops;				// how many DDS packets have we lost?
};

#endif /* PRODUCTGENERATOR_H_ */
