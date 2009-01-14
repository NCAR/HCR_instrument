#ifndef TSREADER_H_
#define TSREADER_H_

#include "DDSReader.h"

#include "TimeSeriesTypeSupportC.h"
#include "TimeSeriesTypeSupportImpl.h"

/// A DDSReader for the TS data type.
typedef DDSReader<READERSIG(HcrDDS::TimeSeries)> TSReader;

#endif /*TSREADER_H_*/
