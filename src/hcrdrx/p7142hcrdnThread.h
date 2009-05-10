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
				int simPauseMS=100);
		virtual ~p7142hcrdnThread();
		void run();
		void startFilters();

	protected:
		double nowTime();
		void publish(char* buf, int n);
		int _tsLength;
		bool _publish;
		TSWriter* _tsWriter;         ///< The time series writer.

};

#endif /*P7142DNTHREAD_H_*/
