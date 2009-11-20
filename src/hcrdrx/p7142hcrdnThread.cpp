#include "p7142hcrdnThread.h"
#include <sys/timeb.h>
#include <iostream>
#include <iomanip>

//////////////////////////////////////////////////////////////////////////////////
p7142hcrdnThread::p7142hcrdnThread(
		           TSWriter* tsWriter,
				   bool publish,
				   int tsLength,
				   std::string devName,
				   int chanId,
				   int gates,
				   int nsum,
				   int delay,
				   int prt,
				   int prt2,
				   int pulse_width,
				   bool stgr_prt,
				   bool freeRun,
				   std::string gaussianFile,
				   std::string kaiserFile,
				   Pentek::p7142hcrdn::DDCDECIMATETYPE decimateType,
				   int bypassdivrate,
				   bool simulate,
				   int simPauseMS,
				   bool internalClock):
  p7142hcrdn(devName,
	     chanId,
	     gates,
	     nsum,
	     tsLength,
	     delay,
	     prt,
	     prt2,
	     pulse_width,
	     stgr_prt,
	     freeRun,
	     gaussianFile,
	     kaiserFile,
	     decimateType,
	     bypassdivrate,
	     simulate,
	     simPauseMS,
	     internalClock),
  _doCI(nsum > 1),
  _nsum(nsum),
  _tsLength(tsLength),
  _publish(publish),
  _tsWriter(tsWriter),
  _tsDiscards(0)
{
	  // create the publish mutex
	  //_publishMutex.create();
}

//////////////////////////////////////////////////////////////////////////////////
p7142hcrdnThread::~p7142hcrdnThread() {

}

//////////////////////////////////////////////////////////////////////////////////
void p7142hcrdnThread::run() {

  static unsigned short int ttl_toggle = 0;

  // there will be an I and Q for each channel
  int _bufferSize;
  if (!_doCI) {
	  // non-integrated data simply has IQ pairs, as 2 byte shorts,
	  // for all gates.
	  _bufferSize = _tsLength*_gates*2*2;
  } else {
	  // coherently integrated data has:
	  // 4 tags followed by even IQ pairs followed by odd IQ pairs,
	  // for all gates. Tags, I and Q are 4 byte integers.
	  _bufferSize = _tsLength*(4 + _gates*2*2)*4;
  }

  // create the read buffer
  char* buf = new char[_bufferSize];

  // start the loop. The thread will block on the read()
  while (1) {
    int n = p7142dn::read(buf, _bufferSize);

    ttl_toggle = ~ttl_toggle;
    TTLOut(ttl_toggle);

    if (n <= 0) {
      std::cerr << "read returned " << n << " ";
      if (n < 0)
    	  perror("");
      std::cerr << "\n";
    }

    if (n != _bufferSize && n != 0) {
    	std::cerr << "read returned incorrect number of bytes" << std::endl;
    }

    // examine the tags
    decodeBuf(buf, n);

    // publish the data
    if (_publish) {
      publish(buf, n);
    }
  }
}

///////////////////////////////////////////////////////////
void p7142hcrdnThread::startFilters() {

  p7142hcrdn::startFilters();

  /// @todo This is a hack to test the timers, move to independent function later!
  p7142hcrdn::startTimers();

}
///////////////////////////////////////////////////////////
double p7142hcrdnThread::nowTime() {
  struct timeb timeB;
  ftime(&timeB);
  return timeB.time + timeB.millitm/1000.0;
}

///////////////////////////////////////////////////////////
void
p7142hcrdnThread::publish(char* buf, int n) {

  ProfilerDDS::TimeSeries* ts;
  ts = _tsWriter->getEmptyItem();
  if (!ts) {
	  _tsDiscards++;
	  return;
  }

  int len = n;

  ts->data.length(len/2);

  ts->hskp.gates = _gates;
  ts->hskp.chanId = _chanId;
  ts->hskp.tsLength = _tsLength;

   if (!_doCI) {
	   // if the coherent integrator is not used, then we receive
	   // a straight stream of IQ pairs, as 2 byte shorts.
	   // convert to shorts
	   short* data = (short*)buf;
	   for (int i = 0; i < n/2; i++) {
		   ts->data[i] = data[i];
		   //std::cout << i << "  " << ts->data[i] << std::endl;
	   }
   } else {
	   // decode data from coherent integrator
	   int in = 0;
	   int out = 0;
	   int* data = (int*)buf;
	   for (int t = 0; t < _tsLength; t++) {
		   // skip the tag
		   in += 4;
		   for (int g = 0; g < _gates; g++) {
			   for (int iq = 0; iq < 2; iq++) {
				   // for now, just add even and odd. The pulse
				   // decoding will eventually happen here.
				   double sum = data[in] + data[in+2*_gates];
				   double result = (sum/_nsum);
				   ts->data[out] = (short)result;
				   in++;
				   out++;
			   }
		   }
		   // space past the odd I and Qs.
		   in += 2*_gates;
	   }
   }

   // publish it
   //_publishMutex.lock();
  _tsWriter->publishItem(ts);
   //_publishMutex.unlock();
}

///////////////////////////////////////////////////////////
void
p7142hcrdnThread::decodeBuf(char* buf, int n) {

  /// @todo Make the decodeBuf routine do something useful, rather than just
  /// counting through the data arrays. Right now we use it by uncommenting
  /// diagnostic prints.

  // we assume that buf contains all of the data for a complete time series
  // of length _tsLength. If it doesn't, we are in trouble
  if (!_doCI) {
	   // if the coherent integrator is not used, then we receive
	   // a straight stream of IQ pairs, as 2 byte shorts.
	   // convert to shorts
	   short* data = (short*)buf;
	   for (int i = 0; i < n/2; i = i + 2) {
		   //std::cout << i << ": " << data[i] << " " << data[i+1] << std::endl;
	   }
   } else {
	   // decode data from coherent integrator. It is packed as follows:
	   // <TAG_I_EVEN><TAG_Q_EVEN><TAG_I_ODD><TAG_Q_ODD><IQpairs,even pulse><IQpairs,odd pulse>
	   //
	   // The tags are formatted as:
	   //   bits 31:28  Format number 0-256 (4 bits)
	   //   bits 27:26  Channel number  0-3 (2 bits)
	   //   bits    25  0=even, 1=odd   0-1 (1 bit)
	   //   bit     24  0=I, 1=Q        0-1 (1 bit)
	   //   bits 23:00  Sequence number     (24 bits)
	   int in = 0;
	   int out = 0;
	   int* data = (int*)buf;
	   for (int t = 0; t < _tsLength; t++) {
		   // decode the leading four tags
		   for (int tag = 0; tag < 4; tag++) {
			   int format = (data[in] >> 28) & 0xf;
			   int key = (data[in] >> 24) & 0xf;
			   int sumNum = data[in] & 0xffffff;
			   //std::cout << std::dec << format << " 0x" << std::hex <<  key << " " << std::dec << sumNum << "   ";
			   in++;
		   }
		   //std::cout << std::dec << std::endl;
		   for (int g = 0; g < _gates; g++) {
			   for (int iq = 0; iq < 2; iq++) {
				   // logic below just shows where even and odd Is and Qs are located
				   double even = data[in];
				   double odd = data[in+2*_gates];
				   in++;
				   out++;
			   }
		   }
		   // we have advanced the in pointer to the end of the even Is and Qs.
		   // Now space past the odd Is and Qs.
		   in += 2*_gates;
	   }
   }
}

//////////////////////////////////////////////////////////////////////////////////
unsigned long
p7142hcrdnThread::tsDiscards() {
	unsigned long retval = _tsDiscards;
	_tsDiscards = 0;
	return retval;
}

