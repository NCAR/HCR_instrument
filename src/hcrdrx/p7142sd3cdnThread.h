#ifndef P7142DNTHREAD_H_
#define P7142DNTHREAD_H_

#include <QThread>
#include "p7142sd3c.h"
#include "TSWriter.h"

class p7142sd3cdnThread: public QThread, public Pentek::p7142sd3cdn {
	Q_OBJECT
	public:
		p7142sd3cdnThread(
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
				bool freeRun,
				std::string gaussianFile,
				std::string kaiserFile,
				Pentek::p7142sd3cdn::DDCDECIMATETYPE decimateType,
				int bypassdivrate=8,
				bool simulate=false,
				int simPauseMS=100,
				bool internalClock=false);
		virtual ~p7142sd3cdnThread();
		void run();
		/// @return The number of timeseries blocks that have been discarded
		/// since the last time this function was called.
		unsigned long tsDiscards();
		/// @return The cummulative number of dropped pulses
		unsigned long droppedPulses();
		/// @return the number of synchronization errors detected.
		unsigned long syncErrors();

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
        /// Decode the pulse number from tag information in a buffer.
        /// @param buf The raw buffer of data from the downconverter
        /// channel. It contains all Is and Qs, plus the tagging
        /// information.
		/// @return the pulse number, in range 0 to (2^30 - 1).  If 
		/// free-running, the pulse number is always zero.
        long unpackPulseNum(const char* buf) const;
        /// Decode the channel number from tag information in a buffer.
        /// @param buf The raw buffer of data from the downconverter
        /// channel. It contains all Is and Qs, plus the tagging
        /// information.
        /// @return the channel number, in range 0 to 3.  If free-running,
        /// the channel number is always zero.
        long unpackChannelNum(const char* buf) const;
		/// set true if coherent integrator is being used
		bool _doCI;
		/// Set true if we are going to publish the data
		bool _publish;
		/// The DDS time series writer
		TSWriter* _tsWriter;
		/// The number of unpublished blocks, due to no
		/// empty items being available from DDS. It is
		/// reset to zero whenever tsDiscards() is called.
		unsigned long _tsDiscards;
		/// The last pulse sequence number that we received. Used to keep
		/// track of dropped pulses. Only used in coherent
		/// integration mode.
		int _lastPulseSeq;
		/// An estimate of dropped pulses. It may be in error
		/// if the pulse tag rolls over by more than the 14 bit
		/// total that it can hold. This test is only made if the
		/// channel number passes the validity test.
		unsigned long _droppedPulses;
		/// The number of times that an incorrect channel number was received,
		/// which indicates a synchronization error. If there is a sync error,
		/// then the sequence number check is not performed.
		unsigned long _syncErrors;
		/// Set true at startup, false after the first pulse
		/// has been received.
		bool _firstPulse;
		/// The DDS sample number; increment when a sample is published.
		long _sampleNumber;
		
};

#endif /*P7142DNTHREAD_H_*/
