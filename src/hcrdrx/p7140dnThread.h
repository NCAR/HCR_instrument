#ifndef P7140DNTHREAD_H_
#define P7140DNTHREAD_H_

#include <QThread>
#include "p7140.h"
#include "TSWriter.h"

class p7140dnThread: public QThread, public Pentek::p7140dn {
	Q_OBJECT
	public:
		p7140dnThread(TSWriter* tsWriter, bool publish, 
		int gates, int tsLength,
		std::string devName, int chanId, int decrate=8,
			bool simulate=false, int simPauseMS=100);
		virtual ~p7140dnThread();
		void run();
	protected:
		double nowTime();
		void publish(char* buf, int n);
		int _gates;
		int _tsLength;
		bool _publish;
		TSWriter* _tsWriter;         ///< The time series writer.
		
};


#endif /*P7140DNTHREAD_H_*/
