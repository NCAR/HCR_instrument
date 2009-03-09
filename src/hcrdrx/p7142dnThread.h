#ifndef P7142DNTHREAD_H_
#define P7142DNTHREAD_H_

#include <QThread>
#include "p7142.h"

class p7142dnThread: public QThread, public Pentek::p7142dn {
	Q_OBJECT
	public:
		p7142dnThread(int gates, int tsLength,
		std::string devName, int chanId, int decrate=8,
			bool simulate=false, int simPauseMS=100);
		virtual ~p7142dnThread();
		void run();
	protected:
		double nowTime();
		int _gates;
		int _tsLength;
		
};

#endif /*P7142DNTHREAD_H_*/
