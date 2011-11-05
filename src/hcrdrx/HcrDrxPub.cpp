#include <sys/timeb.h>
#include <cstdlib>
#include <iostream>
#include <iomanip>
#include <logx/Logging.h>

#include "HcrDrxPub.h"
#include "IwrfExport.h"
#include "PulseData.h"
#include "BurstData.h"

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
                double simPauseMS,
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
     _pulseData(NULL),
     _burstData(NULL)
{
    // Bail out if we're not configured legally.
    if (! _configIsValid())
        abort();

    // scaling between A2D counts and volts

    _iqScaleForMw = config.iqcount_scale_for_mw();

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

  time_duration timeFromEpoch = _down->timeOfPulse(pulseSeqNum) - Epoch1970;
  time_t timeSecs = timeFromEpoch.total_seconds();
  int nanoSecs = timeFromEpoch.fractional_seconds() * 
          (1000000000 / time_duration::ticks_per_second());
  
  if (_chanId == HCR_BURST_CHANNEL) {

    // allocate on first time

    if (_burstData == NULL) {
      _burstData = new BurstData;
    }

    // set data in burst object

    _burstData->set(pulseSeqNum, timeSecs, nanoSecs,
                    _g0Magnitude, _g0PowerDbm, _g0PhaseDeg,
                    _g0IvalNorm, _g0QvalNorm,
                    _g0FreqHz, _g0FreqCorrHz,
                    _nGates, iq);

    // we write to the merge queue using one object,
    // and get back another for reuse

    _burstData = _exporter->writeBurst(_burstData);

  } else {

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

}
    
////////////////////////////////////////////////////////////////////////////////
void
HcrDrxPub::_handleBurst(const int16_t * iqData, int64_t pulseSeqNum) {
    // initialize variables
    const double DIS_WT = 0.01;

    // Separate I and Q data
    double i[_nGates];
    double q[_nGates];
    double num = 0;
    double den = 0;
    for (unsigned int g = 0; g < _nGates; g++) {
        i[g] = iqData[2 * g];
        q[g] = iqData[2 * g + 1];
    }

    // Frequency discriminator -- runs every hit
    // Compute cross product over middle 16 samples (frequency discriminator) 
    // using moving coherent average to reduce variance
    // i contains inphase samples; q contains quadrature samples
    for (unsigned int g = 2; g <= 17; g++) {
        double a = i[g] + i[g + 1];
        double b = q[g] + q[g + 1];
        double c = i[g + 2] + i[g + 1];
        double d = q[g + 2] + q[g + 1];

        num += a * d - b * c; // cross product
        den += a * c + b * d; // normalization factor proportional to G0 magnitude
    }
    
    // _numerator and _denominator are weighted averages over time, with
    // recent data weighted highest
    _numerator *= (1 - DIS_WT);
    _numerator += DIS_WT * num;
    
    _denominator *= (1 - DIS_WT);
    _denominator += DIS_WT * den;

    double normCrossProduct = _numerator / _denominator;  // normalized cross product proportional to frequency change
    double freqCorrection = 8.0e6 * normCrossProduct; // experimentally determined scale factor to convert correction to Hz

    double ival = i[9] / _iqScaleForMw;
    double qval = q[9] / _iqScaleForMw;
    double g0Power = ival * ival + qval * qval; // units of V^2
    double g0PowerDb = 10 * log10(g0Power);
    if (! (pulseSeqNum % 5000)) {
      DLOG << "At pulse " << pulseSeqNum << ": freq corr. " <<
        freqCorrection << " Hz, g0 power " << g0Power << " (" <<
        g0PowerDb << " dB)";
    }
    _g0Magnitude = sqrt(g0Power);
    _g0PowerDbm = g0PowerDb;
    _g0PhaseDeg = _argDeg(ival, qval);
    _g0IvalNorm = ival / _g0Magnitude;
    _g0QvalNorm = qval / _g0Magnitude;
    _g0FreqCorrHz = freqCorrection;
    _g0FreqHz = _config.rcvr_cntr_freq() + freqCorrection;
    
}

// compute arg in degrees

const double HcrDrxPub::_RAD_TO_DEG = 57.29577951308092;

double HcrDrxPub::_argDeg(double ival, double qval)
  
{
  double arg = atan2(qval, ival) * _RAD_TO_DEG;
  return arg;
}

