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
     _exporter(exporter),
     _pulseData(NULL)
{
    // Bail out if we're not configured legally.
    if (! _configIsValid())
        abort();

    // scaling between A2D counts and volts

    _iqScaleForMw = config.iqcount_scale_for_mw();

    // Create our associated downconverter.
    bool useInternalClock = false;
    _down = sd3c.addDownconverter(_chanId, 4 * 512 * 1024, false, tsLength,
        config.digitizer_gate0_delay(), config.digitizer_sample_width(),
        gaussianFile, kaiserFile, simWavelength, useInternalClock);
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

//////////////////////////////////////////////////////////////////////////////////
bool
HcrDrxPub::_configIsValid() const {
    bool valid = true;
    // gate count must be in the interval [1,2047]
    if (_nGates < 1 || _nGates > 2047) {
      ELOG << "gates is " << _nGates <<
        "; it must be greater than 0 and less than 2048.";
      valid = false;
    }
    // DDC type must be 8
    if (_sd3c.ddcType() != Pentek::p7142sd3c::DDC8DECIMATE) {
      ELOG << "The Pentek FPGA is using DDC type " << 
        _sd3c.ddcTypeName() << 
        ", but HCR requires that it be DDC8DECIMATE.";
      valid = false;
    }
    return(valid);
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
