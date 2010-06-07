/*
 * TimeSeriesAdapter.h
 * 
 * Adapter class for ProfilerDDS::TimeSeries <-> IwrfTsPulse translations.
 *
 *  Created on: May 20, 2010
 *      Author: burghart
 */

#ifndef TIMESERIESADAPTER_H_
#define TIMESERIESADAPTER_H_

// ProfilerDDS::TimeSeries class
#include "profilertypesTypeSupportImpl.h"

// RAL IwrfTsPulse class
#include <radar/IwrfTsPulse.hh>


class TimeSeriesAdapter {
public:
    /**
     * Convert from IwrfTsPulse to ProfilerDDS::TimeSeries.
     * @param iwrfPulse the IwrfTsPulse to be converted
     * @param ddsPulse the destination ProfilerDDS::TimeSeries
     */
    static void IwrfToDDS(const IwrfTsPulse& iwrfPulse, 
            ProfilerDDS::TimeSeries& ddsPulse);
    /**
     * Convert from ProfilerDDS::TimeSeries to IwrfTsPulse.
     * @param ddsPulse the ProfilerDDS::TimeSeries to be converted
     * @param iwrfPulse the destination IwrfTsPulse
     * @param packetSequenceNum the packet sequence number to assign to the
     *     IwrfTsPulse
     */
    static void DDSToIwrf(const ProfilerDDS::TimeSeries& ddsPulse,
            IwrfTsPulse& iwrfPulse, si64 packetSequenceNum);
};

#endif /* TIMESERIESADAPTER_H_ */
