#ifndef P7142DNTHREAD_H_
#define P7142DNTHREAD_H_

#include <QThread>
#include "p7142.h"
#include "TSWriter.h"

class p7142dnThread: public QThread, public Pentek::p7142dn {
	Q_OBJECT
	public:
		p7142dnThread(TSWriter* tsWriter, bool publish, int gates, int tsLength,
		std::string devName, int chanId, int decrate=8,
			bool simulate=false, int simPauseMS=100);
		virtual ~p7142dnThread();
		void run();
	protected:
		double nowTime();
		void publish(char* buf, int n);
		int _gates;
		int _tsLength;
		bool _publish;
		TSWriter* _tsWriter;         ///< The time series writer.
		
};

#endif /*P7142DNTHREAD_H_*/
