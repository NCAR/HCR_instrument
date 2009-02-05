/*
 * qttest.h
 *
 *  Created on: Jan 26, 2009
 *      Author: martinc
 */

#ifndef QTTSREADER_H_
#define QTTSREADER_H_

#include "DDSQtReader.h"
#include "TSReader.h"

class QtTSReader: public DDSQtReader, public TSReader {
	Q_OBJECT
public:

	/// Constructor
	/// @param subscriber The DDS subscriber
	/// @param topicName The DDS topic name
	/// @param outputRate The desired maximum sample output rate, in Hz
	QtTSReader(DDSSubscriber& subscriber,
			std::string topicName,
			double outputRate);

	/// Destructor
	virtual ~QtTSReader();

signals:
    /// This signal provides an item that falls within
    /// the desired bandwith specification.
    /// @param pItem A pointer to the item. It must be returned
    /// via returnItem().
	void newItem(HcrDDS::TimeSeries* pItem);

public slots:
    /// Use this slot to return an item
    /// @param pItem the item to be returned.
    void returnItemSlot(HcrDDS::TimeSeries* pItem);

protected:
	/// Re-implmented from super class. This function will be  called
	/// when new samples are available on the topic. If it is time to
	/// accept a new sample (_capture is true), then the newItem()
	/// signal will be emitted for one item. Any remaining availble items
	/// will be returned.
	virtual void notify();
};

#endif /* QTTSREADER_H_ */
