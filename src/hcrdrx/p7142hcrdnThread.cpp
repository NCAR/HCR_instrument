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
		int delay,
		int prt,
		int prt2,
		int pulse_width,
		bool stgr_prt,
		std::string gaussianFile,
		std::string kaiserFile,
		int bypassdivrate,
		bool simulate,
		int simPauseMS):
p7142hcrdn(devName,
		chanId,
		gates,
		delay,
		prt,
		prt2,
		pulse_width,
		stgr_prt,
		gaussianFile,
		kaiserFile,
		bypassdivrate,
		simulate,
		simPauseMS),
_tsLength(tsLength),
_publish(publish),
_tsWriter(tsWriter)
{

}

//////////////////////////////////////////////////////////////////////////////////
p7142hcrdnThread::~p7142hcrdnThread() {

}

//////////////////////////////////////////////////////////////////////////////////
void p7142hcrdnThread::run() {

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
		int n = p7142dn::read(buf, _bufferSize);
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

		if (_publish)
			publish(buf, n);

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
void p7142hcrdnThread::startFilters() {
	this->startFilters();
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

	// convert to shorts
	short* data = (short*)buf;
	for (int i = 0; i < n/2; i++)
		ts->tsdata[i] = data[i];

	_tsWriter->publishItem(ts);
}

