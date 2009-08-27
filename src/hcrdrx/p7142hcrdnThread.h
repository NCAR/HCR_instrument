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
				Pentek::p7142hcrdn::DDCDECIMATETYPE decimateType,
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
		/// Publish the data to the dds. A complete timeseries, of
		/// length _tsLength, with all gates, is packed into
		/// a DDS buffer and published to the dds.
		/// @param buf The raw buffer of data from the downconverter
		/// channel. It contains all Is and Qs, plus the tagging
		/// information.
		/// @param n The length of the buffer. This is redundant
		/// information, since the buffer size better match the required
		/// size based on _gates, _tsLength, and whether coherent integration
		/// is in effect or not.
		void publish(char* buf, int n);
		/// Decode the tag information in a buffer.
		/// @param buf The raw buffer of data from the downconverter
		/// channel. It contains all Is and Qs, plus the tagging
		/// information.
		/// @param n The length of the buffer. This is redundant
		/// information, since the buffer size better match the required
		/// size based on _gates, _tsLength, and whether coherent integration
		/// is in effect or not.
		void decodeBuf(char* buf, int n);
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
