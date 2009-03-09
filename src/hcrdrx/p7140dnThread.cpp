#include "p7140dnThread.h"
#include <sys/timeb.h>
#include <iostream>
#include <iomanip>

//////////////////////////////////////////////////////////////////////////////////
p7140dnThread::p7140dnThread(
	int gates, 
	int tsLength,
	std::string devName, 
	int chanId, int decrate,
	bool simulate, 
	int simPauseMS):
p7140dn(devName, chanId, decrate, simulate, simPauseMS),
_gates(gates),
_tsLength(tsLength) {
				
}

//////////////////////////////////////////////////////////////////////////////////
p7140dnThread::~p7140dnThread() {
	
}

//////////////////////////////////////////////////////////////////////////////////
void p7140dnThread::run() {
	
		// there will be an I and Q for each channel
	int _bufferSize   = _gates*_tsLength*2*sizeof(short);
	
	// create the read buffer
	char* buf = new char[_bufferSize];

	// start the loop
	double total = 0;

	double startTime = nowTime();

	int lastMb = 0;
	int samples = 0;
	int incompletes = 0;

	while (1) {
		int n = p7140dn::read(buf, _bufferSize);	
		if (n <= 0) {
			std::cerr << "read returned " << n << " ";
			if (n < 0)
				perror("");
			std::cerr << "\n";
		} else {
			total += n;
			
	    if (n!= _bufferSize) {
	    	incompletes++;
	    }

		samples++;

			int mb = (int)(total/1.0e6);
			if ((mb % 100) == 0 && mb > lastMb) {
				lastMb = mb;
				double elapsed = nowTime() - startTime;
				double bw = (total/elapsed)/1.0e6;

				int overruns = overUnderCount();
				std::cout 
				<< dnName() << ": "
				<< "total " << std::setw(5) << mb << " MB,  BW "
				<< std::setprecision(4) << std::setw(5) << bw
				<< " MB/s, "
				<< "   samples: " << samples
				<< "  overruns: " << overruns 
				<< "  incompletes: " << incompletes
				<< std::endl;
			}
		}
	}
}

///////////////////////////////////////////////////////////
double p7140dnThread::nowTime() {
	struct timeb timeB;
	ftime(&timeB);
	return timeB.time + timeB.millitm/1000.0;
}

