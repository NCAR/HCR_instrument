#ifndef P7142DNTHREAD_H_
#define P7142DNTHREAD_H_

#include <QThread>
#include "p7142hcr.h"
#include "TSWriter.h"

class p7142hcrdnThread: public QThread, public Pentek::p7142hcrdn {
	Q_OBJECT
	public:
		p7142hcrdnThread(
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
				int bypassdivrate=8,
				bool simulate=false,
				int simPauseMS=100,
				bool internalClock=false);
		virtual ~p7142hcrdnThread();
		void run();
		void startFilters();
		/// @return The number of timeseries blocks that have been discarded
		/// since the last time this function was called.
		unsigned long tsDiscards();

	protected:
		double nowTime();
		void publish(char* buf, int n);
		/// set true if coherent integrator is being used
		bool _doCI;
		/// the number of sums in the coherent integration
		int _nsum;
		/// The number of pulses in one time series block.
		/// If coherent integration is on, there will actually be
		/// 2 times this number of pulses in the block; one for even pulses
		/// and one for odd pulses.
		int _tsLength;
		/// Set true if we are going to publish the data
		bool _publish;
		/// The time series writer.
		TSWriter* _tsWriter;
		/// The number of unpublished blocks, due to no
		/// empty items being available from DDS. It is
		/// reset to zero whenever tsDiscards() is called.
		unsigned long _tsDiscards;

};

#endif /*P7142DNTHREAD_H_*/
