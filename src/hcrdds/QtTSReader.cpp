/*
 * qttest.cpp
 *
 *  Created on: Jan 26, 2009
 *      Author: martinc
 */

#include "QtTSReader.h"
#include <QMetaType>

Q_DECLARE_METATYPE(ProfilerDDS::TimeSeries*)

QtTSReader::QtTSReader(DDSSubscriber& subscriber,
		std::string topicName,
		double outputRate):
		DDSQtReader(outputRate),
		TSReader(subscriber, topicName)
			{
	// these are required in order to send structured data types
	// via a qt signal
	qRegisterMetaType<ProfilerDDS::TimeSeries*>();
}

QtTSReader::~QtTSReader() {

}

//////////////////////////////////////////////////////////////////////////////
void
QtTSReader::returnItemSlot(ProfilerDDS::TimeSeries* pItem) {
	TSReader::returnItem(pItem);
}

////////////////////////////////////////////////////////////////////////
/// Implement DDSReader::notify(), which will be called
/// whenever new samples are added to the DDSReader available
/// queue. Send the sample to clients via a signal.
/// The clients must release the sample via returnItem()
/// when they are finished with it.
void QtTSReader::notify(){
	// a DDS data notification has been received.
	bool sentOne = false;
	while (ProfilerDDS::TimeSeries* pItem = getNextItem()) {
		// send the sample to our clients
		if (! sentOne && _capture) {
			emit newItem(pItem);
			sentOne = true;
		} else {
			returnItem(pItem);
		}
		// tell timers that we have processed a sample
		clearCapture();
	}
}
