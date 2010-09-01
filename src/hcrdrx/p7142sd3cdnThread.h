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
         * @param freeRun Set true to operate the SD3c in free running mode
         * @param simulate generate simulated data? (no Pentek card is used
         *     if simulate is true)
         * @param simPauseMS The number of milliseconds to wait before returning
         *     simulated data when calling read()
         * @param simWavelength The wavelength of a simulated signal. The wavelength
         *     is in sample counts.
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
                bool freeRun,
                bool simulate,
                double simPauseMS,
                int simWavelength);
        
		/// Destructor
        virtual ~p7142sd3cdnThread();
		void run();
		/// @return The number of timeseries blocks that have been discarded
		/// since the last time this function was called.
		unsigned long tsDiscards();

	private:
		/// Return the current time in seconds since 1970/01/01 00:00:00 UTC.
		/// Returned value has 1 ms precision.
		/// @return the current time in seconds since 1970/01/01 00:00:00 UTC
		double _nowTime();
        /// Decode the information in a raw (no coherent integration) buffer 
        /// received from the P7142.   The number of unprocessed bytes (which 
        /// will be < _pentekPulseLen) is returned.
        /// @param buf The raw buffer of data from the downconverter
        /// channel. It contains all Is and Qs
		/// @param pulsenum The pulse number. Will be zero for raw data.
        void _decodeAndPublishRaw(char* buf, unsigned int pulsenum);
        /**
         * Return true iff the current configuration is valid.
         * @return true iff the current configuration is valid.
         */
        bool _configIsValid() const;
        /**
         * Search through buf to find the index of the next occurrence of 
         * the sync word. If not found, return -1.
         * @param buf the buffer to search for the sync word
         * @param buflen the number of bytes available in buf
         * @return the index of the next sync word in buf, or -1 if the sync
         * word is not found.
         */
        static int _indexOfNextSync(const char* buf, int buflen);
		/// set true if coherent integrator is being used
		bool _doCI;
		/// Set true if we are going to publish the data
		bool _publish;
		/// The DDS time series writer
		TSWriter* _tsWriter;
		/// The number of unpublished blocks or partial blocks, due to no
		/// empty items being available from DDS. It is reset to zero whenever 
		/// tsDiscards() is called.
		unsigned long _tsDiscards;
		/// How many pulses are we putting in each published sample?
		int _ddsSamplePulses;
        /// The DDS time series sequence we're filling. Once it has 
		/// _ddsSamplePulses pulses in it, we publish it.
        RadarDDS::TimeSeriesSequence *_ddsSampleInProgress;
        /// Where are we in _ddsSampleInProgress?
        int _ndxInDdsSample;
		/// The DDS sample number; increment when a sample is published.
		long _sampleNumber;
		/// Base DDS housekeeping with values that remain fixed for this
		/// downconverter.
		RadarDDS::SysHousekeeping _baseDdsHskp;
		
};

#endif /*P7142DNTHREAD_H_*/
