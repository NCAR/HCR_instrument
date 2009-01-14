#ifndef TSWRITER_H_
#define TSWRITER_H_

#include "DDSWriter.h"

#include "TimeSeriesTypeSupportC.h"
#include "TimeSeriesTypeSupportImpl.h"

/// A DDSWriter for the TS data type.
typedef DDSWriter<WRITERSIG(HcrDDS::TimeSeries)> TSWriter;

#endif /*TSWRITER_H_*/
