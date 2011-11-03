#include "HcrDrxPub.h"
#include <sys/timeb.h>
#include <cstdlib>
#include <iostream>
#include <iomanip>

using namespace boost::posix_time;

//////////////////////////////////////////////////////////////////////////////////
HcrDrxPub::HcrDrxPub(
                Pentek::p7142sd3c& sd3c,
                int chanId,
                const HcrDrxConfig& config,
                TSWriter* tsWriter,
                bool publish,
                int tsLength,
                std::string gaussianFile,
                std::string kaiserFile,
                double simPauseMS,
                int simWavelength) :
     QThread(),
     _sd3c(sd3c),
     _chanId(chanId),
     _down(0),
     _gates(sd3c.gates()),
     _publish(publish),
     _tsWriter(tsWriter),
     _tsDiscards(0),
     _ddsSamplePulses(tsLength),    // for now, set to the # of pulses we get from the 7142
     _ddsSeqInProgress(0),
     _ndxInDdsSample(0)
{
    // Bail out if we're not configured legally.
    if (! _configIsValid())
        abort();

    // scaling between A2D counts and volts

    _iqScaleForMw = _config.iqcount_scale_for_mw();

    // Create our associated downconverter.
    _down = sd3c.addDownconverter(_chanId, false, tsLength,
        config.rcvr_gate0_delay(), config.rcvr_pulse_width(), gaussianFile, 
        kaiserFile, simPauseMS, simWavelength);

    // Fill our DDS base housekeeping values from the configuration
    config.fillDdsSysHousekeeping(_baseDdsHskp);
}

//////////////////////////////////////////////////////////////////////////////////
HcrDrxPub::~HcrDrxPub() {

}

//////////////////////////////////////////////////////////////////////////////////
void HcrDrxPub::run() {
  int bl = _down->beamLength();
  
  std::cout << "Channel " << _chanId << " beam length is " << bl <<
    ", waiting for data..." << std::endl;

  // start the loop. The thread will block on getBeam()
  while (1) {
	int64_t pulsenum;
	char* buf = _down->getBeam(pulsenum);
    publishDDS(buf, pulsenum);
  }
}

///////////////////////////////////////////////////////////
double HcrDrxPub::_nowTime() {
  struct timeb timeB;
  ftime(&timeB);
  return timeB.time + timeB.millitm/1000.0;
}

///////////////////////////////////////////////////////////

// 1970-01-01 00:00:00 UTC
static const ptime Epoch1970(boost::gregorian::date(1970, 1, 1), time_duration(0, 0, 0));

///////////////////////////////////////////////////////////
void
HcrDrxPub::publishDDS(char* buf, int64_t pulsenum) {
    

	// bufPos is now pointing to the pulse data
	// data length in bytes: 2-byte I and 2-byte Q for each gate
	int datalen = 4 * _gates;

	// If we're publishing, copy this pulse into our DDS sample-in-progress,
	// and publish it when it's full.
	if (_publish) {
		// Make sure we have a DDS sample to fill
		if (! _ddsSeqInProgress) {
			// Get a free sample
			_ddsSeqInProgress = _tsWriter->getEmptyItem();
			// If no sample was available, discard everything we have and
			// return.
			if (! _ddsSeqInProgress) {
				std::cerr << "Channel " << _chanId <<
					" dropped data with no DDS samples available!" << std::endl;
				_tsDiscards++;
				return;
			}
			_ddsSeqInProgress->sampleNumber = _sampleNumber++;
			_ddsSeqInProgress->chanId = _chanId;
			_ddsSeqInProgress->tsList.length(_ddsSamplePulses);
			_ndxInDdsSample = 0;
		}

		//
		// Copy this pulse into our DDS sample in progress
		//
		RadarDDS::TimeSeries & ts = _ddsSeqInProgress->tsList[_ndxInDdsSample++];
		// Copy our fixed metadata into this pulse
		ts.hskp = _baseDdsHskp;
		// Then fill the non-fixed metadata
		ts.data.length(_gates * 2);   // I and Q for each gate, length is count of shorts
		ts.hskp.chanId = _chanId;
		ts.prt_seq_num = 1;   // single-PRT only for now
		ts.pulseNum = pulsenum;
		time_duration timeFromEpoch = _sd3c.timeOfPulse(pulsenum) - Epoch1970;
		// Calculate the timetag, which is usecs since 1970-01-01 00:00:00 UTC
		ts.hskp.timetag = timeFromEpoch.total_seconds() * 1000000LL +
				(timeFromEpoch.fractional_seconds() * 1000000LL) /
				time_duration::ticks_per_second();
		// Copy the per-gate data from the incoming buffer to the DDS
		// sample data space.
		memmove(ts.data.get_buffer(), buf, datalen);

		// Publish _ddsSeqInProgress if it's full
		if (_ndxInDdsSample == _ddsSamplePulses) {
			// publish it
			_tsWriter->publishItem(_ddsSeqInProgress);
			_ddsSeqInProgress = 0;
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////
unsigned long
HcrDrxPub::tsDiscards() {
	unsigned long retval = _tsDiscards;
	_tsDiscards = 0;
	return retval;
}

//////////////////////////////////////////////////////////////////////////////////
bool
HcrDrxPub::_configIsValid() const {
    bool valid = true;
    // gate count must be in the interval [1,511]
    if (_gates < 1 || _gates > 511) {
        std::cerr << "gates is " << _gates <<
            "; it must be greater than 0 and less than 512." << std::endl;
        valid = false;
    }
    // PRT must be a multiple of the pulse width
    if (_sd3c.prtCounts() % _sd3c.txPulseWidthCounts()) {
        std::cerr << "PRT is " << _sd3c.prt() << " (" << 
            _sd3c.prtCounts() << ") and pulse width is " << 
            _sd3c.txPulseWidth() << 
            " (" << _sd3c.txPulseWidthCounts() << 
            "): PRT must be an integral number of pulse widths." << std::endl;
        valid = false;
    }
    // PRT must be longer than (gates + 1) * pulse width
    if (_sd3c.prtCounts() <= ((_gates + 1) * _sd3c.txPulseWidthCounts())) {
        std::cerr << "PRT must be greater than (gates+1)*(pulse width)." <<
                std::endl;
        valid = false;
    }
    // DDC type must be 8
    if (_sd3c.ddcType() != Pentek::p7142sd3c::DDC8DECIMATE) {
        std::cerr << "The Pentek FPGA is using DDC type " << 
                _sd3c.ddcTypeName() << 
                ", but HCR requires that it be DDC8DECIMATE." << std::endl;
        valid = false;
    }
    return valid;
}
