#ifndef DDSREADER_H_
#define DDSREADER_H_

#include <dds/DdsDcpsSubscriptionS.h>
#include <ace/Task.h>
#include <ace/Synch.h>
#include <dds/DCPS/Service_Participant.h>
#include <ace/streams.h>

#include "DDSSubscriber.h"
#include "DDSTemplateSigs.h"

typedef ACE_Thread_Mutex mutex_t;
typedef ACE_Condition_Thread_Mutex condition_t;
typedef ACE_Guard<mutex_t> guard_t;

using namespace DDS;
using namespace CORBA;

/// A generic data reader class which is templated on the DDS data type. Instantiate
/// this class with the desired data type to create a reader for a particular
/// topic. It requires and works with an existing DDSSubscriber. 
///
/// Newly arrived data are placed on a queue. They are removed from the
/// queue with getNextItem(). The item must be returned when no longer 
/// needed with returnItem().
///
/// New data can be detected either by polling or by a notification scheme.
/// For polling, use itemsAvailable() to ask how many items are available, 
/// or just verify that getNextItem() returns a non-null. To use the notification
/// scheme, derive from this class and subclass the notify() method. It
/// will be called whenever new data arrives and is placed on the queue,
/// which can tehn be retrieved with getNextItem().
/// 
/// This class is actually derived from a DDS::DataReaderListener, so that it
/// can receive the asynchronous notifications via the on_data_available()
/// function. The class creates and contains a DDS:DataReader for accessing
/// the delivered data.
template<READERSIG1>
class DDSReader: public virtual OpenDDS::DCPS::LocalObject<DDS::DataReaderListener> 
{
	
 public:
  /// Constructor
  /// @param subscriber The subscriber that this reader will use.
  /// @param topicName The name of the topic that this reader will
  /// subscribe to.
  DDSReader(DDSSubscriber& ddsSubscriber, std::string topicName):
    _numSamples(0),
    _droppedSamples(0),
    _topicName(topicName)
      {

	// reserve the space in the queues
	for (int i = 0; i < 100; i++) {
	  DDSTYPE* pItem = new DDSTYPE;
	  _inQueue.push_back(pItem);
	}

	Subscriber_var& subscriber = ddsSubscriber.getSubscriber();

	DomainParticipant_var& participant = ddsSubscriber.getParticipant();

	try {
	  // register our type
	  DDSTYPESUPPORT_VAR typeSupport = new DDSTYPESUPPORTIMPL();
	  if (RETCODE_OK != typeSupport->register_type(participant.in(), "")) {
	    cerr << "failed to register type" << endl;
	    abort();
	  }

	  // get the type name
	  String_var type_name = typeSupport->get_type_name();

	  // get the default quality of service
	  TopicQos topic_qos;
	  participant->get_default_topic_qos(topic_qos);
	  // specify reliable reliability. What a concept.
	  topic_qos.reliability.kind = DDS::RELIABLE_RELIABILITY_QOS;

	  // create our topic, using our type name and the default qos. 
	  std::cout << "Creating topic " << _topicName << ", for type name " << 
	    type_name << std::endl;
	  Topic_var topic =
	    participant->create_topic(_topicName.c_str(),
				      type_name.in(),
				      topic_qos,
				      DDS::TopicListener::_nil());
	  if (is_nil (topic.in())) {
	    cerr << "create_topic failed for topic " << _topicName << ", "
		 << " for type name ,  " << type_name << std::endl;
	    exit(1);
	  }

	  // activate the listener  (compatible with DDS1.1 API)
	  DDS::DataReaderListener_var listener(this);
	  if (CORBA::is_nil (listener.in())) {
	    cerr << "listener is nil for " << _topicName << endl;
	    exit(1);
	  }

	  // Create the generic datareader for our topic
	  DataReaderQos dw_qos;
	  subscriber->get_default_datareader_qos (dw_qos);
	  _genericReader = subscriber->create_datareader(topic.in(),
							 dw_qos,
							 listener.in());

	  if (is_nil (_genericReader.in())) {
	    cerr << "create_datareader failed for topic " << _topicName << ", "
		 << " for type name ,  " << type_name << std::endl;
	    exit(1);
	  }

	}
	catch (Exception& e)
	  {
	    cerr << "Exception caught for topic " << _topicName << ", " << e
		 << " " <<__FILE__ << " line:,  " <<__LINE__ << e << endl;
	    exit(1);
	  }
    };

    ////////////////////////////////////////////////////////////
    /// Destructor
    virtual ~DDSReader(void) {
      std::cout << __FUNCTION__ << " destructor\n";
    };

    ////////////////////////////////////////////////////////////
    // @return The number of full items available
    /// on the _outQueue.
    int itemsAvailable()
    {
      guard_t guard(_queueMutex);
      return _outQueue.size();
    };	
	
    ////////////////////////////////////////////////////////////
    /// Get the next full item from the _outQueue. If
    /// nothing is available, a null is returned.
    DDSTYPE* getNextItem() {
      guard_t guard(_queueMutex);
      DDSTYPE* pItem;
      if (_outQueue.size()) {
	pItem = _outQueue[0];
	_outQueue.erase(_outQueue.begin());
      } else {
	pItem = 0;
      }
	
      return pItem;
    };
	
    ////////////////////////////////////////////////////////////
    /// Return an item to be placed back on the _inQueue.
    /// @param pItem The item to be returned.
    void returnItem(DDSTYPE* pItem) {
      guard_t guard(_queueMutex);
      if (pItem)
	_inQueue.push_back(pItem);
    };
	
    ////////////////////////////////////////////////////////////
    /// This function will be called after each on_data_available()
    /// notification, when samples have been added to the queue.
    /// Subclass DDSReader and implement notify() in order to
    /// respond to new data. Call getNextItem() to fetch new data.
    ////////////////////////////////////////////////////////////
    virtual void notify() {
      return;
    };
	
    ////////////////////////////////////////////////////////////
    virtual void on_requested_deadline_missed(DDS::DataReader_ptr reader,
					      const DDS::RequestedDeadlineMissedStatus & status)
      throw (CORBA::SystemException) {
      cerr << "DDSReader: deadline missed for topic " << _topicName << endl;
    };
	
    ////////////////////////////////////////////////////////////
    virtual void on_requested_incompatible_qos(DDS::DataReader_ptr reader,
					       const DDS::RequestedIncompatibleQosStatus & status)
      throw (CORBA::SystemException) {
      cerr << "DDSReader: requested incompatible QoS for topic " << 
	_topicName << endl;
    };
	
    ////////////////////////////////////////////////////////////
    virtual void on_liveliness_changed(DDS::DataReader_ptr reader,
				       const DDS::LivelinessChangedStatus & status)
      throw (CORBA::SystemException) {
      cerr << "DDSReader: liveliness changed for topic " << _topicName << 
	": active_count_change: " << status.active_count_change << 
	", inactive_count_change: " << status.inactive_count_change << endl;
    };
	
    ////////////////////////////////////////////////////////////
    virtual void on_subscription_match(DDS::DataReader_ptr reader,
				       const DDS::SubscriptionMatchStatus & status)
      throw (CORBA::SystemException) {
      cerr << "DDSReader: got publisher id " << status.last_publication_handle <<
	" for topic " << _topicName << endl;
    };
	
    ////////////////////////////////////////////////////////////
    virtual void on_sample_rejected(DDS::DataReader_ptr reader,
				    const DDS::SampleRejectedStatus& status)
      throw (CORBA::SystemException) {
      cerr << "DDSReader: sample rejected for topic " << _topicName << endl;
    };

    ////////////////////////////////////////////////////////////
    virtual void on_data_available(DDS::DataReader_ptr reader)
      throw (CORBA::SystemException) {
      // this will be set true if we need to send a notify
      // after the mutex has been released.
      bool sendNotify = false;
      try {
	
	/// @todo Is it really necessary to narrow the reader on every entry
	/// to on_data_available? Could this be done once during the setup?
	_specificReader = DDSDATAREADER::_narrow(reader);
	if (CORBA::is_nil(_specificReader.in())) {
	  cerr << "read: _narrow failed in on_data_avaiable(), " << _topicName << ", " << endl;
	  exit(1);
	}
	
	// place the mutex capture inside of the try block so that the mutex 
	// is released before we send the a notify() which could lead to
	// the client trying to access the queus.
	guard_t guard(_queueMutex);
	
	DDS::SampleInfo si;
	DDS::ReturnCode_t status;
	
	if (_inQueue.size()) {
	  /// @todo we should read all available items
	  // we have an available item. read it and place
	  // on the queue
	  DDSTYPE* pItem = _inQueue[0];
	  _inQueue.erase(_inQueue.begin());
	  status = _specificReader->take_next_sample(*pItem, si);
	  _outQueue.push_back(pItem);
	  sendNotify = true;
	} else {
	  // no available items, so just read it
	  ///@todo There must be a call which throws a sample away.
	  DDSTYPE item;
	  status = _specificReader->take_next_sample(item, si);
	  _droppedSamples++;
	}
	// Alternate code to read directlty via the servant
	//EldoraReaderImpl* dr_servant =
	//  reference_to_servant<EldoraReaderImpl>(pulse_dr.in());
	//DDS::ReturnCode_t status = dr_servant->take_next_sample(pulse, si) ;
	
	if (status == DDS::RETCODE_OK) {
	  _numSamples++;
	} else {
	  if (status == DDS::RETCODE_NO_DATA) {
	
	    cerr << "ERROR: reader received DDS::RETCODE_NO_DATA!,  " << _topicName << ", " << endl;
	  } else {
	    cerr << "ERROR: read Message: Error: ,  " << _topicName << ", " << status << endl;
	  }
	}
      } catch (CORBA::Exception& e) {
	cerr << "Exception caught in read for " << _topicName << ", " << e << endl;
	exit(1);
      }
	
      if (sendNotify) {
	notify();
      }
    };

    ////////////////////////////////////////////////////////////
    virtual void on_sample_lost(DDS::DataReader_ptr reader,
				const DDS::SampleLostStatus& status) throw (CORBA::SystemException) {
      cerr << "DDSReader: sample lost for topic " << _topicName << endl;
    };
		
    ////////////////////////////////////////////////////////////
    /// @return The total number of samples received since the
    /// last call to numSamples()
    unsigned int numSamples() {
      unsigned int n = _numSamples;
      _numSamples = 0;
      return n;
    };
	
    ////////////////////////////////////////////////////////////
    /// @return The total number of samples dropped since the
    /// last call to droppedSamples()
    unsigned int droppedSamples() {
      unsigned int n = _droppedSamples;
      _droppedSamples = 0;
      return n;
    };

 private:

    DDS::DataReader_var _genericReader;
	
    DDSDATAREADER_VAR _specificReader;
	
    /// A queue of subscribed items, waiting to be consumed.
    std::vector<DDSTYPE*> _inQueue;

    /// A queue of empty items, available to receive new data.
    std::vector<DDSTYPE*> _outQueue;
	
    /// A mutex that protects acces to the queues
    mutex_t _queueMutex;
	
    /// Count of samples received. Zeroed after each call to numSamples();
    unsigned int _numSamples;
	
    /// number of dropped items. Zeroed when numDropped is called
    unsigned int _droppedSamples;
	
    /// The topic name
    std::string _topicName;
};

#endif /* DDSREADERINC_  */
