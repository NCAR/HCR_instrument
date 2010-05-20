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
//#include "profilertypesTypeSupportC.h"
#include "profilertypesTypeSupportImpl.h"

// RAL IwrfTsPulse class
#include <radar/IwrfTsPulse.hh>


class TimeSeriesAdapter {
public:
    static void IwrfToDDS(const IwrfTsPulse& iwrfPulse, 
            ProfilerDDS::TimeSeries& ddsPulse);
    static void DDSToIwrf(const ProfilerDDS::TimeSeries& ddsPulse,
            IwrfTsPulse& iwrfPulse, si64 packetSequenceNum);
};

#endif /* TIMESERIESADAPTER_H_ */
