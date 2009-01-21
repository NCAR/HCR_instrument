/*
 * SnifferTSReader.cpp
 *
 *  Created on: Jan 20, 2009
 *      Author: martinc
 */

#include "SnifferTSReader.h"

//////////////////////////////////////////////////////////////
SnifferTSReader::SnifferTSReader(DDSSubscriber& subscriber, std::string topicName):
TSReader(subscriber, topicName){
	pthread_mutex_init(&_seriesMutex, 0);
}

//////////////////////////////////////////////////////////////
SnifferTSReader::~SnifferTSReader() {

}

//////////////////////////////////////////////////////////////
TimeSeries*
SnifferTSReader::nextTS() {

	pthread_mutex_lock(&_seriesMutex);

	TimeSeries* ts = 0;
	if (_series.size()) {
		ts = _series[0];
		_series.pop_front();
	}

	pthread_mutex_unlock(&_seriesMutex);
	return ts;

}

//////////////////////////////////////////////////////////////
void
SnifferTSReader::notify() {
	TimeSeries* ts;
	while ((ts = getNextItem())) {
		pthread_mutex_lock(&_seriesMutex);
		_series.push_back(ts);
		pthread_mutex_unlock(&_seriesMutex);
	}
}
