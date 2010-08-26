
#include "AScopeReader.h"
#include <QMetaType>

Q_DECLARE_METATYPE(AScope::TimeSeries)

AScopeReader::AScopeReader(DDSSubscriber& subscriber,
		std::string topicName):
		QtTSReader(subscriber, topicName, 0)
{
	// this are required in order to send structured data types
	// via a qt signal
	qRegisterMetaType<AScope::TimeSeries>();
}

AScopeReader::~AScopeReader() {

}

//////////////////////////////////////////////////////////////////////////////
void
AScopeReader::returnItemSlot(AScope::TimeSeries pItem) {
	
	RadarDDS::TimeSeriesSequence* ddsItem = static_cast<RadarDDS::TimeSeriesSequence*>(pItem.handle);
	assert(ddsItem);
	
	TSReader::returnItem(ddsItem);
}

////////////////////////////////////////////////////////////////////////
/// Implement DDSReader::notify(), which will be called
/// whenever new samples are added to the DDSReader available
/// queue. Send the sample to clients via a signal.
/// The clients must release the sample via returnItem()
/// when they are finished with it.
void AScopeReader::notify(){
	// a DDS data notification has been received.
	bool sentOne = false;
	while (RadarDDS::TimeSeriesSequence* ddsItem = getNextItem()) {
		// send the sample to our clients
		if (! sentOne && _capture) {
			AScope::ShortTimeSeries pItem;
			pItem.gates    = ddsItem->tsList[0].hskp.gates;
			pItem.chanId   = ddsItem->chanId;
			int tsLength   = ddsItem->tsList.length();
			pItem.IQbeams.resize(tsLength);
			for (int i = 0; i < tsLength; i++) {
				pItem.IQbeams[i] = &ddsItem->tsList[i].data[0];
			}
			pItem.handle     = (void*) ddsItem;
			emit newItem(pItem);
			sentOne = true;
		} else {
			returnItem(ddsItem);
		}
		// tell timers that we have processed a sample
		clearCapture();
	}
}
