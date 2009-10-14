/*
 * ProductGenerator.cpp
 *
 *  Created on: Oct 14, 2009
 *      Author: burghart
 */

#include "ProductGenerator.h"
#include <iostream>

ProductGenerator::ProductGenerator(QtTSReader *source) : 
    _source(source),
    _count(0) {
}

ProductGenerator::~ProductGenerator() {
    // nothing yet...
}

void 
ProductGenerator::run() {
    connect(_source, SIGNAL(newItem(ProfilerDDS::TimeSeries*)), 
            this, SLOT(handleItem(ProfilerDDS::TimeSeries*)));
    connect(this, SIGNAL(returnItem(ProfilerDDS::TimeSeries*)),
            _source, SLOT(returnItemSlot(ProfilerDDS::TimeSeries*)));
    exec();
}

void 
ProductGenerator::handleItem(ProfilerDDS::TimeSeries* tsItem) {
    if (!(_count++ % 100)) {
        std::cerr << "I've gotten " << _count << " TS items!" << std::endl;
    }
    emit returnItem(tsItem);
}
