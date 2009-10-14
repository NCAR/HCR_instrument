/*
 * ProductGenerator.cpp
 *
 *  Created on: Oct 14, 2009
 *      Author: burghart
 */

#include "ProductGenerator.h"

ProductGenerator::ProductGenerator(QtTSReader *source) : 
    _source(source) {
}

ProductGenerator::~ProductGenerator() {
    // nothing yet...
}

void 
ProductGenerator::run() {
    connect(_source, SIGNAL(newTSItem(ProfilerDDS::TimeSeries*)), 
            this, SLOT(handleItem(ProfilerDDS::TimeSeries*)));
    connect(this, SIGNAL(returnItem(ProfilerDDS::TimeSeries*)),
            _source, SLOT(returnItemSlot(ProfilerDDS::TimeSeries*)));
    exec();
}

void 
ProductGenerator::handleItem(ProfilerDDS::TimeSeries* tsItem) {
    emit returnItem(tsItem);
}
