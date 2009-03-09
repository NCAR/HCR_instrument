#ifndef P7140DNTHREAD_H_
#define P7140DNTHREAD_H_

#include <QThread>
#include "p7140.h"

class p7140dnThread: public QThread, public Pentek::p7140dn {
	Q_OBJECT
	public:
		p7140dnThread(int gates, int tsLength,
		std::string devName, int chanId, int decrate=8,
			bool simulate=false, int simPauseMS=100);
		virtual ~p7140dnThread();
		void run();
	protected:
		double nowTime();
		int _gates;
		int _tsLength;
		
};


#endif /*P7140DNTHREAD_H_*/
