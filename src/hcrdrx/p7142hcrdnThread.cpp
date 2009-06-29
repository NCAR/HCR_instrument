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
				   std::string gaussianFile,
				   std::string kaiserFile,
				   int bypassdivrate,
				   bool simulate,
				   int simPauseMS,
				   bool internalClock):
  p7142hcrdn(devName,
	     chanId,
	     gates,
	     nsum,
	     delay,
	     prt,
	     prt2,
	     pulse_width,
	     stgr_prt,
	     gaussianFile,
	     kaiserFile,
	     bypassdivrate,
	     simulate,
	     simPauseMS,
	     internalClock),
  _doCI(nsum > 1),
  _nsum(nsum),
  _tsLength(tsLength),
  _publish(publish),
  _tsWriter(tsWriter)
{
std::cout << "_doCI is " << _doCI << " _nsum is " << _nsum << std::endl;
}

//////////////////////////////////////////////////////////////////////////////////
p7142hcrdnThread::~p7142hcrdnThread() {

}

//////////////////////////////////////////////////////////////////////////////////
void p7142hcrdnThread::run() {

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
    if (n <= 0) {
      std::cerr << "read returned " << n << " ";
      if (n < 0)
    	  perror("");
      std::cerr << "\n";
    }

    if (n != _bufferSize && n != 0) {
    	std::cerr << "read returned incorrect number of bytes" << std::endl;
    }

    // convert to ints and print
    /**
    unsigned int* datai = (unsigned int*)buf;
    for (int i = 0; i < n/4; i++) {
      std::cout << std::dec << i
		<< std::hex << "  0x" << datai[i] << std::endl;
    }
    **/

    if (_publish) {
      publish(buf, n);
    }
  }
}

///////////////////////////////////////////////////////////
void p7142hcrdnThread::startFilters() {
  p7142hcrdn::startFilters();
  p7142hcrdn::startInternalTimer();  // this is a hack to test the timers, move to independent function later!

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

  ProfilerDDS::TimeSeries* ts = _tsWriter->getEmptyItem();

  if (!ts) {
    return;
  }

  int len = n;

  ts->tsdata.length(len/2);

  ts->hskp.gates = _gates;
  ts->hskp.chanId = _chanId;
  ts->hskp.tsLength = _tsLength;

   if (!_doCI) {
	   // if the coherent integrator is not used, then we receive
	   // a straight stream of IQ pairs, as 2 byte shorts.
	   // convert to shorts
	   short* data = (short*)buf;
	   for (int i = 0; i < n/2; i++)
		   ts->tsdata[i] = data[i];
   } else {
	   // decode data from coherent integrator
	   int in = 0;
	   int out = 0;
	   int* data = (int*)buf;
	   for (int t = 0; t < _tsLength; t++) {
		   for (int tag = 0; tag < 4; tag++) {
//			   int format = (data[in] >> 28) & 0xf;
//			   int key = (data[in] >> 24) & 0xf;
//			   int sumNum = data[in] & 0xffffff;
//			   std::cout << std::dec << format << " 0x" << std::hex <<  key << " " << std::dec << sumNum << "   ";
			   in++;
		   }
		   //std::cout << std::dec << std::endl;
		   for (int g = 0; g < _gates; g++) {
			   for (int iq = 0; iq < 2; iq++) {
				   // for now, just add even and odd
				   double sum = data[in] + data[in+2*_gates];
				   double result = (sum/_nsum);
				   ts->tsdata[out] = (short)result;
				   in++;
				   out++;
			   }
		   }
		   // space past the odd I and Qs.
		   in += 2*_gates;
	   }
   }

  _tsWriter->publishItem(ts);
}

