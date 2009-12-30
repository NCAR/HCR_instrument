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
    ProductGenerator(QtTSReader *source, ProductWriter *sink, int nSamples);
    virtual ~ProductGenerator();
    void run();
    /**
     * Maximum number of gates which can be handled
     */
    static const int PRODGEN_MAX_GATES;
protected slots:
    /**
     * Handle one TimeSeries item from our source.  If a complete ray of
     * products becomes available after handling, it will be published.
     * @param item pointer to the new ProfilerDDS::TimeSeries item
     */
    virtual void handleItem(ProfilerDDS::TimeSeriesSequence *item);
    
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
    void publish_(const MomentsFields *moments);
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
     * Number of samples to integrate when generating products
     */
    int _nSamples;
    /**
     * The RAP radar moments calculator
     */
    RadarMoments _momentsCalc;
    /**
     * Accumulated time series IQ data for a dwell in progress.
     * This is sized to hold _nSamples * _nGates sets of I and Q.
     * The ordering is _dwell[gate][sample], which allows easy use
     * of RadarMoments methods.
     */
    RadarComplex_t **_dwell;
    long long _dwellStart;  // dwell start time in us since 1970-01-01 00:00 UTC
    int _dwellGates;        // gate count for the dwell
    float _dwellPrf;        // PRF from the first sample of the dwell
    int _samplesCached;     // samples in the dwell so far
    /**
     * Keep track of how many product rays we are unable to publish.
     */
    int _itemCount;         // TimeSeriesSequence-s received
    int _wrongChannelCount; // TSS-s with the wrong channel
    int _dwellCount;        // dwells built
    int _dwellDiscardCount;   // dwells that could not be published
};

#endif /* PRODUCTGENERATOR_H_ */
