#ifndef DDSWRITERINC_
#define DDSWRITERINC_

#include <ace/OS_NS_unistd.h>
#include <ace/streams.h>
#include <unistd.h>
#include <dds/DdsDcpsPublicationC.h>
#include <ace/Task.h>
#include <ace/Synch.h>
#include <vector>

#include "DDSPublisher.h"
#include "DDSTemplateSigs.h"

typedef ACE_Thread_Mutex mutex_t;
typedef ACE_Condition_Thread_Mutex condition_t;
typedef ACE_Guard<mutex_t> guard_t;

using namespace DDS;
using namespace CORBA;

/// A templatized writer for an arbitrary DDS datatype. A DDS
/// publisher must be provided; it will perform 
/// the data transfer on behalf of this writer.
/// The template parameters define the datatype which
/// will be written. Currently, five DDS class tye names 
/// must be provided as the template parameters. 
/// DDSWriter provides a queue of buffers. Clients
/// request an empty buffer via getEmptyItem(),
/// fill their data into the item, and return it to the 
/// writer to be publish. Clients can query the number of empty
/// items that are avaialable. Alternatively, they can be
/// suspended in getNextItem() until an empty item becomes
/// available. This blocking on the queue of empty items
/// is implemented using the ACE condition_t condition variables.
/// @todo Find a way to build all of the required class names
/// from a user supplied root. Simple CPP macros won't work here.
template <WRITERSIG1>
class DDSWriter : 
public ACE_Task_Base, 
  public virtual OpenDDS::DCPS::DataWriterListener {

 public:
  ///////////////////////////////////////////////////////////////////////////////
  /// Constructor
  /// @param publisher The publisher that this writer will use.
  /// @param topicName The name of the topic that this writer will
  /// publish to.
  /// @param queueSize The number of spaces in the queue of items, shared between
  /// the empty and full queues.
  DDSWriter(DDSPublisher& ddsPublisher,
	    std::string topicName, int queueSize=100) :
    finished_instances_(0), 
    timeout_writes_(0), 
    _condition(_mutex), 
    _topicName(topicName), 
    _queueSize(queueSize), 
    _terminate(false)
      {

	// reserve the space in the queues
	for (int i = 0; i < _queueSize; i++) {
	  DDSTYPE* pItem = new DDSTYPE;
	  _outQueue.push_back(pItem);
	}

	// get the DDS publisher, which we will need to create the writer.
	Publisher_var& publisher = ddsPublisher.getPublisher();

	// get the domain participant, which we register our type with
	DomainParticipant_var& participant = ddsPublisher.getParticipant();
    
	try {
	  // register our type
	  DDSTYPESUPPORT_VAR typeSupport = new DDSTYPESUPPORTIMPL();
	  if (RETCODE_OK != typeSupport->register_type(participant.in (), "")) {
            cerr << "register_type failed." << endl;
            exit(1);
	  }

	  // get the type name
	  String_var type_name = typeSupport->get_type_name ();
	  if (0 ==type_name.in()){
            cerr << "get_type_name failed for topic " << topicName.c_str() << std::endl;
            exit(1);
	  }

	  // Activate the listener so we can get notification of assorted
	  // state changes, e.g., publication matches and deleted connections.
	  OpenDDS::DCPS::DataWriterListener_var listener(this);
	  if (CORBA::is_nil (listener.in())) {
            cerr << "DataWriterListener is nil for " << _topicName << endl;
            exit(1);
	  }

	  // get the default quality of service
	  TopicQos topic_qos;
	  participant->get_default_topic_qos(topic_qos);
	  // specify reliable reliability. What a concept.
	  topic_qos.reliability.kind = DDS::RELIABLE_RELIABILITY_QOS;

	  // create our topic, using our type name and the default qos. 
	  // We will not be using a listener.
	  std::cout << "Creating topic " << topicName.c_str() << 
            " for type name " << type_name << std::endl;
	  Topic_var topic = participant->create_topic (topicName.c_str(),
						       type_name.in (),
						       topic_qos,
						       DDS::TopicListener::_nil());
	  if (is_nil (topic.in ())) {
            cerr << "create_topic failed for topic " << 
	      topicName.c_str() << " for type name " << type_name << std::endl;
            exit(1);
	  }

	  // Create the generic datawriter for our topic
	  DataWriterQos dw_qos;
	  publisher->get_default_datawriter_qos (dw_qos);
	  _genericWriter = publisher->create_datawriter(topic.in (),
							dw_qos, listener.in());
	  if (is_nil (_genericWriter.in ())) {
            cerr << "create_datawriter failed for topic " << topicName.c_str()
		 << " for type name " << type_name << std::endl;
            exit(1);
	  }
	}
	catch (Exception& e)
	  {
	    cerr << "Exception caught in " << __FILE__
		 << " line:" << __LINE__
		 << e << endl;
	    exit(1);
	  }

	// start the writer thread!
	ACE_DEBUG((LM_DEBUG, ACE_TEXT("(%P|%t) Writer::start \n")));
	if (activate(THR_NEW_LWP | THR_JOINABLE, 1) == -1) {
	  cerr << "Writer::start(): activate failed" << endl;
	  exit(1);
	}
  	};
	
    ///////////////////////////////////////////////////////////////////////////////
    /// Destructor
    virtual ~DDSWriter(){
      std::cout << __FUNCTION__ << " destructor\n";
    };

    ///////////////////////////////////////////////////////////////////////////////
    /// wait for the thread to terminate
    void end() {
      ACE_DEBUG((LM_DEBUG, ACE_TEXT("(%P|%t) Writer::end \n")));
      wait();
    };

    ///////////////////////////////////////////////////////////////////////////////
    /// The service that interacts with the publisher, feeding
    /// it items as they are provided by cleints in other threads.
    /// svc() responds to requests for our topic. When the request 
    /// has been received, then svc() will loop, removing items from
    /// _inQueue, sending them to the publisher, and placing the
    /// empty items back on the _outQueue. If no items are available
    /// on the _inQueue, the loop will block on a condition variable
    /// while waiting for new entried to appear in the _inQueue.
    ///
    /// svc() is the function called when the writer thread is started
    /// via activate().
    virtual int svc() {
      ACE_DEBUG((LM_DEBUG, ACE_TEXT("(%P|%t) Writer::svc begins.\n")));

      InstanceHandleSeq handles;
      try {

        while (1) {
            if (_terminate) {
		      cerr << __FUNCTION__ << " terminating" << endl;
		      return 0;
            }
                
            _genericWriter->get_matched_subscriptions(handles);
            if (handles.length() > 0)
		      break;
            else
	      ACE_OS::sleep(ACE_Time_Value(0,200000));
	  }

        _specificWriter = DDSDATAWRITER::_narrow(_genericWriter.in());
        if (is_nil (_specificWriter.in ())) {
		  cerr << "Data Writer could not be narrowed"<< endl;
		  exit(1);
        }

        DDSTYPE item;
        InstanceHandle_t handle = _specificWriter->_cxx_register (item);

        ACE_DEBUG((LM_DEBUG,
		   ACE_TEXT("%T (%P|%t) Writer::svc starting to write.\n")));

        // this is where it all happens
        while(1) {

	  if (_terminate)
            break;
	  // block until item(s) appears on the _inQueue.
	  waitForItem();

	  // publish the next items on the _inQueue.
	  // publish() returns non-zero if more items remain on _inQueue.
	  while(publish(handle)) {};
        }

      } catch (Exception& e) {
        cerr << "Exception caught in svc:" << endl
	     << e << endl;
      }

      ACE_DEBUG((LM_DEBUG, ACE_TEXT("(%P|%t) Writer::svc finished.\n")));

      finished_instances_ ++;

      return 0;
    };

    ///////////////////////////////////////////////////////////////////////////////
    bool
      is_finished() const {
      return finished_instances_ == 1;
    };

    ///////////////////////////////////////////////////////////////////////////////
    int get_timeout_writes() const {
      return timeout_writes_.value();
    };

    ///////////////////////////////////////////////////////////////////////////////
    /// Put the item on the _inQueue, where it will
    /// be consumed for publishing. Ownership
    /// of pItem is transferred to DDSWriter.
    void publishItem(
		     DDSTYPE* pItem) {

      guard_t guard(_mutex);

      _inQueue.push_back(pItem);

      _condition.broadcast();
    };
	
    ///////////////////////////////////////////////////////////////////////////////
    // @return The number of empty items available
    /// on the _outQueue.
    int itemsAvailable() {

      guard_t guard(_mutex);

      return _outQueue.size();

    };

    ///////////////////////////////////////////////////////////////////////////////
    /// Get the next empty item from the _outQueue. If the
    /// _outQueue is empty, block the calling process until 
    /// an item becomes available.
    DDSTYPE* getEmptyItem() {

      guard_t guard(_mutex);

      if (_outQueue.size() == 0)
	return 0;

      DDSTYPE* pItem = _outQueue[0];
      _outQueue.erase(_outQueue.begin());

      return pItem;

    };

    ///////////////////////////////////////////////////////////////////////////////
    /// Stop the writer task
    /// @todo why isn't there an implmentation for this function?
    void terminate();

    ///////////////////////////////////////////////////////////////////////////////
    void on_offered_deadline_missed(DDS::DataWriter_ptr writer, 
				    const DDS::OfferedDeadlineMissedStatus&)
      ACE_THROW_SPEC (( ::CORBA::SystemException )) {
      std::cout << "DDSWriter: offered deadline missed for topic " << 
        _topicName << std::endl;
    };

    ///////////////////////////////////////////////////////////////////////////////
    void on_offered_incompatible_qos(DDS::DataWriter_ptr writer,
				     const DDS::OfferedIncompatibleQosStatus& status)
      ACE_THROW_SPEC (( ::CORBA::SystemException ))
    {
      std::cout << "DDSWRiter: incompatible QoS was offered for topic " << 
        _topicName << std::endl;
    };

    ///////////////////////////////////////////////////////////////////////////////
    void on_liveliness_lost(DDS::DataWriter_ptr writer,
			    const DDS::LivelinessLostStatus& status)
      ACE_THROW_SPEC (( ::CORBA::SystemException )) {
      std::cout << "DDSWriter: liveliness lost for topic " << _topicName << 
        std::endl;
    };

    ///////////////////////////////////////////////////////////////////////////////
    void on_publication_match(DDS::DataWriter_ptr writer,
			      const DDS::PublicationMatchStatus& status)
      ACE_THROW_SPEC (( ::CORBA::SystemException )) {

      std::cout << "DDSWriter: Got new subscriber for topic " << _topicName <<
        " (id " << status.last_subscription_handle << ")" << std::endl;
    };

    ///////////////////////////////////////////////////////////////////////////////
    void on_publication_disconnected(DDS::DataWriter_ptr writer,
				     const ::OpenDDS::DCPS::PublicationDisconnectedStatus& status)
      ACE_THROW_SPEC (( ::CORBA::SystemException )) 
    {
      DDS::InstanceHandleSeq subscribers(status.subscription_handles);
      std::cout << "DDSWriter: subscriber disconnected from topic " << 
        _topicName << " (id ";
      if (subscribers.length() == 1)
        std::cout << subscribers[0];
      else
        std::cout << "[multiple ids]";
      std::cout << ")" << std::endl;
    };

    ///////////////////////////////////////////////////////////////////////////////
    void on_publication_reconnected(DDS::DataWriter_ptr writer,
				    const ::OpenDDS::DCPS::PublicationReconnectedStatus& status)
      ACE_THROW_SPEC (( ::CORBA::SystemException )) 
    {
      DDS::InstanceHandleSeq subscribers(status.subscription_handles);
      std::cout << "DDSWriter: subscriber reconnected to topic " << 
        _topicName << " (id ";
      if (subscribers.length() == 1)
        std::cout << subscribers[0];
      else
        std::cout << "[multiple ids]";
      std::cout << ")" << std::endl;
    };

    ///////////////////////////////////////////////////////////////////////////////
    void on_publication_lost(DDS::DataWriter_ptr writer,
			     const ::OpenDDS::DCPS::PublicationLostStatus& status)
      ACE_THROW_SPEC (( ::CORBA::SystemException )) 
    {
      DDS::InstanceHandleSeq subscribers(status.subscription_handles);
      std::cout << "DDSWriter: subscriber lost for topic " << _topicName << 
        " (id ";
      if (subscribers.length() == 1)
        std::cout << subscribers[0];
      else
        std::cout << "[multiple ids]";
      std::cout << ")" << std::endl;
    };

    ///////////////////////////////////////////////////////////////////////////////
    void  on_connection_deleted(DDS::DataWriter_ptr writer)
      ACE_THROW_SPEC (( ::CORBA::SystemException )) 
    {
      std::cout << "DDSWriter: a connection was deleted for topic " << 
        _topicName << std::endl;
    };

 private:
    ///////////////////////////////////////////////////////////////////////////////
    /// block on _condition until the _inQueue is not empty.
    void waitForItem() {

      guard_t guard(_mutex);

      while (_inQueue.size() == 0)
	_condition.wait();

    };

    ///////////////////////////////////////////////////////////////////////////////
    /// Take the next item on the _inQueue, send it to the 
    /// _publisher, and then return the item to the _outQueue.
    bool publish(
		 InstanceHandle_t handle) {

      guard_t guard(_mutex);

      if (_inQueue.size() == 0)
	return false;

      DDSTYPE* pItem = _inQueue[0];

      _inQueue.erase(_inQueue.begin());

      DDS::ReturnCode_t ret;

      ret = _specificWriter->write(*pItem, handle);

      if (ret != DDS::RETCODE_OK) {
        ACE_ERROR ((LM_ERROR,
		    ACE_TEXT("(%P|%t)ERROR  EldoraWriter::publish, ")
		    ACE_TEXT ("write() returned %d.\n"),
		    ret));
        if (ret == DDS::RETCODE_TIMEOUT) {
	  timeout_writes_ ++;
        }
      }

      // put the item back on the avalable queue
      _outQueue.push_back(pItem);

      return (_inQueue.size() != 0);
    };

    /// The initial writer, not specialized for a data type
    DDS::DataWriter_var _genericWriter;

    /// The data writer specialized for our specific data type.
    DDSDATAWRITER_VAR _specificWriter;

    ACE_Atomic_Op<ACE_SYNCH_MUTEX, int> finished_instances_;

    ACE_Atomic_Op<ACE_SYNCH_MUTEX, int> timeout_writes_;

    /// Mutex which protects access to _inQueue and _outQueue.
    mutex_t _mutex;

    /// Condition variable used to signal our task that 
    /// new data is available on _inQueue.
    condition_t _condition;
	
    /// Our topic name
    std::string _topicName;
	
    /// The total queue capacity (number of items)
    int _queueSize;

    /// A queue of incoming items, waiting to be published.
    std::vector<DDSTYPE*> _inQueue;

    /// A queue of empty items, available for clients to use.
    std::vector<DDSTYPE*> _outQueue;
	
    /// Set true to signal the svc() loop to terminate
    bool _terminate;

};

#endif /* DDSWRITERINC_  */
