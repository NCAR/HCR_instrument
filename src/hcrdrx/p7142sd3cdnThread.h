#ifndef P7142DNTHREAD_H_
#define P7142DNTHREAD_H_

#include <QThread>
#include <p7142sd3c.h>
#include <TSWriter.h>
#include "HcrDrxConfig.h"

class p7142sd3cdnThread: public QThread, public Pentek::p7142sd3cdn {
	Q_OBJECT
	public:
        /**
         * Constructor.
         * @param config HcrDrxConfig defining the desired configuration.
         * @param tsWriter the time series DDS writer to be used.
         * @param publish should we publish data via DDS?
         * @param tsLength the number of time series pulses to be sent when
         *     we publish
         * @param devName the root device name (e.g., "/dev/pentek/p7140/0")
         * @param chanId the receiver channel of this downconverter
         * @param gaussianFile Name of the file containing the Gaussian
         *     filter parameters
         * @param kaiserFile Name of the file containing the Kaiser
         *     filter parameters
         * @param bypassdiv_gates the bypass divider factor, measured in gates
         * @param simulate generate simulated data? (no Pentek card is used
         *     if simulate is true)
         * @param simPauseMS The number of milliseconds to wait before returning
         *     simulated data when calling read()
         */
        p7142sd3cdnThread(
                const HcrDrxConfig& config,
                TSWriter* tsWriter,
                bool publish,
                int tsLength,
                std::string devName,
                int chanId,
                std::string gaussianFile,
                std::string kaiserFile,
                bool simulate,
                int simPauseMS);
        
        /**
         * Constructor.
         * @deprecated This constructor requires that the user know some
         *     internal info, like the Pentek's ADC clock rate, to use it.
         *     The new constructor which takes a HcrDrxConfig object is now
         *     preferred.
         * @param tsWriter the time series DDS writer to be used.
         * @param publish should we publish data via DDS?
         * @param tsLength the number of time series pulses to be sent when
         *     we publish
         * @param devName the root device name (e.g., "/dev/pentek/p7140/0")
         * @param chanId the receiver channel of this downconverter
         * @param gates the number of gates to sample
         * @param nsum the number of pulses to sum for coherent integration
         * @param delay the delay time between the start of the transmit pulse
         *     and the beginning of receiver sampling, in units of (adc_clock / 2)
         * @param prt the first PRT, in units of (adc_clock / 2)
         * @param prt2 the second PRT, if using staggered PRTs, in units of
         *     (adc_clock / 2)
         * @param pulse_width the receiver pulse width, in units of (adc_clock / 2)
         * @param stgr_prt are we using staggered PRTs?
         * @param freeRun are we using free running mode?
         * @param gaussianFile Name of the file containing the Gaussian
         *     filter parameters
         * @param kaiserFile Name of the file containing the Kaiser
         *     filter parameters
         * @param decimateType the DDC type of the card's firmware, either
         *     p7142dn::DDC4DECIMATE or p7142dn::DDC8DECIMATE
         * @param bypassdivrate the bypass divider factor
         * @param simulate generate simulated data? (no Pentek card is used
         *     if simulate is true)
         * @param simPauseMS The number of milliseconds to wait before returning
         *     simulated data when calling read()
         * @param internalClock use the Pentek card's internal clock?
         */
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
        /**
         * Return true iff the current configuration is valid.
         * @return true iff the current configuration is valid.
         */
        bool _configIsValid() const;
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
		/// Base DDS housekeeping with values that remain fixed for this
		/// downconverter.
		RadarDDS::SysHousekeeping _baseDdsHskp;
		
};

#endif /*P7142DNTHREAD_H_*/
