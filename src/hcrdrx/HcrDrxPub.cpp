#include <sys/timeb.h>
#include <cstdlib>
#include <iostream>
#include <iomanip>
#include <logx/Logging.h>

#include "HcrDrxPub.h"
#include "IwrfExport.h"
#include "PulseData.h"

using namespace boost::posix_time;

LOGGING("HcrDrxPub")

//////////////////////////////////////////////////////////////////////////////////
HcrDrxPub::HcrDrxPub(
                Pentek::p7142sd3c& sd3c,
                int chanId,
                const HcrDrxConfig& config,
                IwrfExport *exporter,
                TSWriter* tsWriter,
                bool publishDds,
                int tsLength,
                std::string gaussianFile,
                std::string kaiserFile,
                int simWavelength) :
     QThread(),
     _config(config),
     _sd3c(sd3c),
     _chanId(chanId),
     _down(0),
     _nGates(sd3c.gates()),
     _publishDDS(publishDds),
     _tsWriter(tsWriter),
     _tsDiscards(0),
     _ddsSamplePulses(tsLength),    // for now, set to the # of pulses we get from the 7142
     _ddsSeqInProgress(0),
     _ndxInDdsSample(0),
     _exporter(exporter),
     _pulseData(NULL)
{
    // Bail out if we're not configured legally.
    if (! _configIsValid())
        abort();

    // scaling between A2D counts and volts

    _iqScaleForMw = config.iqcount_scale_for_mw();

    // Create our associated downconverter.
    _down = sd3c.addDownconverter(_chanId, 4 * 512 * 1024, false, tsLength,
        config.rcvr_gate0_delay(), config.rcvr_pulse_width(), gaussianFile, 
        kaiserFile, simWavelength);

    // Fill our DDS base housekeeping values from the configuration
    config.fillDdsSysHousekeeping(_baseDdsHskp);
}

//////////////////////////////////////////////////////////////////////////////////
HcrDrxPub::~HcrDrxPub() {

}

//////////////////////////////////////////////////////////////////////////////////
void HcrDrxPub::run() {
  int bl = _down->beamLength();
  
  ILOG << "Channel " << _chanId << " beam length is " << bl <<
    ", waiting for data...";

  // start the loop. The thread will block on getBeam()
  while (1) {
    int64_t pulsenum;
    char* buf = _down->getBeam(pulsenum);
    publishDDS(buf, pulsenum);
    _addToExport(reinterpret_cast<const int16_t *>(buf), pulsenum);
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
	int datalen = 4 * _nGates;

	// If we're publishing, copy this pulse into our DDS sample-in-progress,
	// and publish it when it's full.
	if (_publishDDS) {
		// Make sure we have a DDS sample to fill
		if (! _ddsSeqInProgress) {
			// Get a free sample
			_ddsSeqInProgress = _tsWriter->getEmptyItem();
			// If no sample was available, discard everything we have and
			// return.
			if (! _ddsSeqInProgress) {
                          ELOG << "Channel " << _chanId <<
                            " dropped data with no DDS samples available!";
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
		ts.data.length(_nGates * 2);   // I and Q for each gate, length is count of shorts
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
    if (_nGates < 1 || _nGates > 511) {
      ELOG << "gates is " << _nGates <<
        "; it must be greater than 0 and less than 512.";
      valid = false;
    }
    // PRT must be a multiple of the pulse width
    if (_sd3c.prtCounts() % _sd3c.txPulseWidthCounts()) {
      ELOG  << "PRT is " << _sd3c.prt() << " (" << 
        _sd3c.prtCounts() << ") and pulse width is " << 
        _sd3c.txPulseWidth() << 
        " (" << _sd3c.txPulseWidthCounts() << 
        "): PRT must be an integral number of pulse widths.";
      valid = false;
    }
    // PRT must be longer than (gates + 1) * pulse width
    if (_sd3c.prtCounts() <= ((_nGates + 1) * _sd3c.txPulseWidthCounts())) {
      ELOG << "PRT must be greater than (gates+1)*(pulse width).";
      valid = false;
    }
    // DDC type must be 8
    if (_sd3c.ddcType() != Pentek::p7142sd3c::DDC8DECIMATE) {
      ELOG << "The Pentek FPGA is using DDC type " << 
        _sd3c.ddcTypeName() << 
        ", but HCR requires that it be DDC8DECIMATE.";
      valid = false;
    }
    return valid;
}

////////////////////////////////////////////////////////////////////////////////
void
  HcrDrxPub::_addToExport(const int16_t *iq, int64_t pulseSeqNum)
  
{

  time_duration timeFromEpoch = _sd3c.timeOfPulse(pulseSeqNum) - Epoch1970;
  time_t timeSecs = timeFromEpoch.total_seconds();
  int nanoSecs = timeFromEpoch.fractional_seconds() * 
          (1000000000 / time_duration::ticks_per_second());
  
  // allocate on first time

  if (_pulseData == NULL) {
      _pulseData = new PulseData;
  }

  // set data in pulse object

  _pulseData->set(pulseSeqNum, timeSecs, nanoSecs,
          _chanId,
          _nGates, iq);

  // we write to the merge queue using one object,
  // and get back another for reuse

  if (_chanId == HCR_H_CHANNEL) {
      _pulseData = _exporter->writePulseH(_pulseData);
  } else if (_chanId == HCR_V_CHANNEL) {
      _pulseData = _exporter->writePulseV(_pulseData);
  }

}
