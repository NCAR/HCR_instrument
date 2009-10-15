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
#include <radar/RadarMoments.hh>

class ProductGenerator : public QThread {
    
    Q_OBJECT
    
public:
    ProductGenerator(QtTSReader *source, int nSamples);
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
    virtual void handleItem(ProfilerDDS::TimeSeries *item);
    
signals:
    /**
     * This signal is emitted when we are finished with an item received
     * from our source.
     * @param item pointer to the ProfilerDDS::TimeSeries item being returned
     */
    void returnItem(ProfilerDDS::TimeSeries *item);
    
private:
    /**
     * QtTSReader source of time series data
     */
    QtTSReader *_source;
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
     * This is sized to hold _nSamples x _nGates sets of I and Q.
     * The ordering is _dwell[gate][sample], which provides works
     * easily with RadarMoments methods.
     */
    RadarComplex_t **_dwell;
    int _samplesInDwell;
};

#endif /* PRODUCTGENERATOR_H_ */
