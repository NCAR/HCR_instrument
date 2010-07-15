#include "p7142sd3cdnThread.h"
#include <sys/timeb.h>
#include <cstdlib>
#include <iostream>
#include <iomanip>

using namespace boost::posix_time;

//////////////////////////////////////////////////////////////////////////////////
p7142sd3cdnThread::p7142sd3cdnThread(
                const HcrDrxConfig& config,
                TSWriter* tsWriter,
                bool publish,
                int tsLength,
                std::string devName,
                int chanId,
                std::string gaussianFile,
                std::string kaiserFile,
                bool simulate,
                int simPauseMS) :
    p7142sd3cdn(devName,
             chanId,
             config.gates(),
             1,
             tsLength,
             config.rcvr_gate0_delay(),
             config.prt1(),
             config.prt2(),
             config.rcvr_pulse_width(),
             (config.staggered_prt() == HcrDrxConfig::UNSET_BOOL) ? false : config.staggered_prt(),
             false,
             gaussianFile,
             kaiserFile,
             simulate,
             simPauseMS,
             false),
     _doCI(false),
     _publish(publish),
     _tsWriter(tsWriter),
     _tsDiscards(0),
     _lastPulseSeq(0),
     _droppedPulses(0),
     _syncErrors(0),
     _firstPulse(true)
{
    // Bail out if we're not configured legally.
    if (! _configIsValid())
        abort();
    /// HCR Pentek firmware requires that bypass divider value be set to
    /// 2 * (pulse width in adc_frequency counts).
    setBypassDivider(2 * _pulseWidth);
    std::cout << "p7142sd3cdnThread decimation:    " << bypassDivider()      << " adc_clock counts"     << std::endl;

    // Fill our DDS base housekeeping values from the configuration
    config.fillDdsSysHousekeeping(_baseDdsHskp);
}

//////////////////////////////////////////////////////////////////////////////////
p7142sd3cdnThread::p7142sd3cdnThread(
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
				   int bypassdivrate,
				   bool simulate,
				   int simPauseMS,
				   bool internalClock):
  p7142sd3cdn(devName,
	     chanId,
	     gates,
	     nsum,
	     tsLength,
	     delay,
	     prt,
	     prt2,
	     pulse_width,
	     stgr_prt,
	     freeRun,
	     gaussianFile,
	     kaiserFile,
	     decimateType,
	     bypassdivrate,
	     simulate,
	     simPauseMS,
	     internalClock),
  _doCI(_nsum > 1), // check against _nsum, since nsum may be tweaked by p7142sd3cdn
  _publish(publish),
  _tsWriter(tsWriter),
  _tsDiscards(0),
  _lastPulseSeq(0),
  _droppedPulses(0),
  _syncErrors(0),
  _firstPulse(true),
  _sampleNumber(0)
{
    // Bail out if we're not configured legally.
    if (! _configIsValid())
        abort();
        
    // Put the values we were given into our base housekeeping.
    _baseDdsHskp.gates = _gates;
    _baseDdsHskp.rcvr_gate0_delay = _delay * 2 / adcFrequency();
    _baseDdsHskp.prt1 = _prt * 2 / adcFrequency();
    _baseDdsHskp.prt2 = _prt2 * 2 / adcFrequency();
    _baseDdsHskp.rcvr_pulse_width = pulse_width * 2 / adcFrequency();
    _baseDdsHskp.staggered_prt = _staggeredPrt;
    
    // Add the fixed values for HCR, ca. 5/2010. That's why this 
    // constructor is deprecated...
    _baseDdsHskp.radar_id = "HCR";
    _baseDdsHskp.ant_gain = 46.2;
    _baseDdsHskp.ant_hbeam_width = 0.75;
    _baseDdsHskp.ant_vbeam_width = 0.68;
    _baseDdsHskp.rcvr_digital_gain = -2.67;
    _baseDdsHskp.rcvr_filter_mismatch = 1.1;
    _baseDdsHskp.rcvr_gate0_delay = 0.0;
    _baseDdsHskp.rcvr_noise_figure = 8.9;
    _baseDdsHskp.rcvr_pulse_width = 5.0e-7;
    _baseDdsHskp.rcvr_rf_gain = 39.48;
    _baseDdsHskp.tx_cntr_freq = 9.37e10;
    _baseDdsHskp.tx_peak_power = 58.78;
    _baseDdsHskp.tx_pulse_width = 1.0e-6;
}

//////////////////////////////////////////////////////////////////////////////////
p7142sd3cdnThread::~p7142sd3cdnThread() {

}

//////////////////////////////////////////////////////////////////////////////////
void p7142sd3cdnThread::run() {

  static unsigned short int ttl_toggle = 0;

  // there will be an I and Q for each channel
  int _bufferSize;
  if (!_doCI) {
	  // non-integrated data simply has IQ pairs, as 2 byte shorts,
	  // for all gates. In free run mode, there is no tagging.
	  // In normal mode, there is pulse tagging.
	  if (_freeRun) {
		  _bufferSize = _tsLength*_gates*2*2;
	  } else {
		  // if not in free run mode, there will also be a four byte pulse tag
		  // at the beginning of each pulse which looks like an additional gate
		  _bufferSize = _tsLength*(4 + _gates*2*2);
	  }
  } else {
      // coherently integrated data has:
	// 4 tags followed by even IQ pairs followed by odd IQ pairs,
	// for all gates. Tags, I and Q are 4 byte integers.
	 _bufferSize = _tsLength*(4 + _gates*2*2)*4;
  }

  // create the read buffer
  char* buf = new char[_bufferSize];

  std::cout << "block size is " << _bufferSize << ", waiting for data..." << std::endl;

  // start the loop. The thread will block on the read()
  while (1) {

    int n = read(buf, _bufferSize);

    ttl_toggle = ~ttl_toggle;
    TTLOut(ttl_toggle);

    if (n <= 0) {
      std::cerr << "read returned " << n << " ";
      if (n < 0)
    	  perror("");
      std::cerr << "\n";
    }

    if (n != _bufferSize && n != 0) {
    	std::cerr << "read returned incorrect number of bytes" << std::endl;
    }

    // examine the tags
    decodeBuf(buf, n);

    // publish the data
    if (_publish) {
      publish(buf, n);
    }
  }
}

///////////////////////////////////////////////////////////
double p7142sd3cdnThread::nowTime() {
  struct timeb timeB;
  ftime(&timeB);
  return timeB.time + timeB.millitm/1000.0;
}

///////////////////////////////////////////////////////////

// 1970-01-01 00:00:00 UTC
static const ptime Epoch1970(boost::gregorian::date(1970, 1, 1), time_duration(0, 0, 0));

void
p7142sd3cdnThread::publish(char* buf, int n) {

  RadarDDS::TimeSeriesSequence* tss;
  tss = _tsWriter->getEmptyItem();
  if (!tss) {
	  _tsDiscards++;
	  return;
  }

  tss->sampleNumber = _sampleNumber++;
  tss->chanId = _chanId;
  tss->tsList.length(_tsLength);

  int in = 0;
  int* data = (int*)buf;
  short* sdata = (short*)buf;

  for (int t = 0; t < _tsLength; t++) {
      RadarDDS::TimeSeries &ts = tss->tsList[t];
      // Copy our fixed metadata into this pulse
      ts.hskp = _baseDdsHskp;
      // Then fill the non-fixed metadata
      ts.data.length(_gates * 2);   // I and Q for each gate
      ts.hskp.chanId = _chanId;
      ts.prt_seq_num = 1;   // single-PRT only for now
      if (!_doCI) {
          // if the coherent integrator is not used, then we receive
          // a straight stream of IQ pairs, as 2 byte shorts. If not
          // in free run mode, there will be a 4 byte pulse tag
          // at the beginning.
          long pulseNum = 0;
          unsigned long channel = 0;
          // Get stuff from the tag if we're not free-running
          if (!_freeRun) {
              pulseNum = unpackPulseNum((const char*)(sdata + in));
              channel = unpackChannelNum((const char*)(sdata + in));
              // skip past the tag
              in += 2;
          }

          ts.pulseNum = pulseNum;
          time_duration timeFromEpoch = timeOfPulse(pulseNum) - Epoch1970;
          // Calculate the timetag, which is usecs since 1970-01-01 00:00:00 UTC
          ts.hskp.timetag = timeFromEpoch.total_seconds() * 1000000LL +
              (timeFromEpoch.fractional_seconds() * 1000000LL) /
              time_duration::ticks_per_second();
          // Finally, pull the per-gate data
          for (int g = 0; g < _gates; g++) {
              // copy from read buffer to DDS array
              ts.data[2 * g] = sdata[in++];
              ts.data[2 * g + 1] = sdata[in++];
          }
      } else {
          // decode data from coherent integrator
          ts.pulseNum = 0;  // BOGUS
          // skip the tag
          in += 4;
          for (int g = 0; g < _gates; g++) {
              for (int iq = 0; iq < 2; iq++) {
                  // for now, just add even and odd. The pulse
                  // decoding will eventually happen here.
                  double sum = data[in] + data[in+2*_gates];
                  double result = (sum/_nsum);
                  ts.data[2*g+iq] = (short)result;
                  in++;
              }
          }
          // space past the odd I and Qs.
          in += 2*_gates;
      }
  }

   // publish it
  _tsWriter->publishItem(tss);
}

///////////////////////////////////////////////////////////
void
p7142sd3cdnThread::decodeBuf(char* buf, int n) {

  /// @todo Make the decodeBuf routine do something useful, rather than just
  /// counting through the data arrays. Right now we use it by uncommenting
  /// diagnostic prints.
	//std::cout << "n is " << n << ", tsLength is " << _tsLength << std::endl;
	//int delta = _gates + 1;
	//for (int i = 0; i < n/4; i++) {
	//	if (!(i%delta)) {
	//		std::cout << std::endl << setw(10) << i << ":  ";
	//	}
	//	std::cout << setw(2) << (unsigned int)((unsigned int*)buf)[i] << " ";
	//}
	//if ((n-1) % delta) {
	//	std::cout << std::endl;
	//}

  // we assume that buf contains all of the data for a complete time series
  // of length _tsLength. If it doesn't, we are in trouble
  if (!_doCI) {
	   // if the coherent integrator is not used, then we receive
	   // a straight stream of IQ pairs, as 2 byte shorts.
	   // convert to shorts
	  //std::cout << "n is " << n << std::endl;
	   int in = 0;
	   int out = 0;
	   unsigned short* data = (unsigned short*)buf;
	   for (int t = 0; t < _tsLength; t++) {
	       if (!_freeRun) {
	           long chan = unpackChannelNum((const char*)(data + in));
	           long seq = unpackPulseNum((const char*)(data + in));
	           // Now that we've gotten stuff from the 4-byte tag, point
	           // past it.
	           in += 2;

	           if (chan != _chanId) {
	               _syncErrors++;
	           } else {
	               //std::cout << "pulse " << t << "  chan " << chan << "  seq " << seq << " " << _lastPulseSeq << std::endl;

	               // update the dropped pulse count
	               if (_firstPulse) {
	                   _lastPulseSeq = seq - 1;
	                   _firstPulse = false;
	               }

	               int delta = seq - _lastPulseSeq;
	               if (delta == 1) {
	                   /// cool!
	               } else if (delta > 1) {
	                   _droppedPulses++;
	               } else if (delta < 0) {
	                   // wrap around
	                   // sequence numbers are thirty bits
	                   _droppedPulses++;;
	               } else {
                       /// @todo Should this be a sync error, or something else?
                       _syncErrors++;
	               }
	               _lastPulseSeq = seq;
	           }
	       }

	       for (int g = 0; g < _gates; g++) {
			   for (int iq = 0; iq < 2; iq++) {
				   // do something here
				   in++;
				   out++;
			   }
		   }
	   }
   } else {
	   // decode data from coherent integrator. It is packed as follows:
	   // <TAG_I_EVEN><TAG_Q_EVEN><TAG_I_ODD><TAG_Q_ODD><IQpairs,even pulse><IQpairs,odd pulse>
	   //
	   // The tags are formatted as:
	   //   bits 31:28  Format number 0-256 (4 bits)
	   //   bits 27:26  Channel number  0-3 (2 bits)
	   //   bits    25  0=even, 1=odd   0-1 (1 bit)
	   //   bit     24  0=I, 1=Q        0-1 (1 bit)
	   //   bits 23:00  Sequence number     (24 bits)
	   int in = 0;
	   int out = 0;
	   int* data = (int*)buf;
	   for (int t = 0; t < _tsLength; t++) {
		   // decode the leading four tags
		   for (int tag = 0; tag < 4; tag++) {
			   //int format = (data[in] >> 28) & 0xf;
			   //int seq = data[in] & 0xffffff;
			   //std::cout << std::dec << format << " 0x" << std::hex <<  key << " " << std::dec << seq << "   ";
               int key = (data[in] >> 24) & 0xf;
			   if (key != ((_chanId << 2) + tag)) {
				   _syncErrors++;
			   }
			   in++;
		   }
		   //std::cout << std::dec << std::endl;
		   for (int g = 0; g < _gates; g++) {
			   for (int iq = 0; iq < 2; iq++) {
				   // logic below shows where even and odd Is and Qs are located:
				   //     double even = data[in];
				   //     double odd = data[in+2*_gates];
//				   std::cout << g << "  " << data[in] << "  " << data[in+2*_gates] << std::endl;
				   in++;
				   out++;
			   }
		   }
		   // we have advanced the in pointer to the end of the even Is and Qs.
		   // Now space past the odd Is and Qs.
		   in += 2*_gates;
	   }
   }
}

//////////////////////////////////////////////////////////////////////////////////
unsigned long
p7142sd3cdnThread::tsDiscards() {
	unsigned long retval = _tsDiscards;
	_tsDiscards = 0;
	return retval;
}

//////////////////////////////////////////////////////////////////////////////////
unsigned long
p7142sd3cdnThread::droppedPulses() {
	unsigned long retval = _droppedPulses;
	return retval;
}

//////////////////////////////////////////////////////////////////////////////////
unsigned long
p7142sd3cdnThread::syncErrors() {
	unsigned long retval = _syncErrors;
	return retval;
}

//////////////////////////////////////////////////////////////////////////////////
long
p7142sd3cdnThread::unpackChannelNum(const char* buf) const {
    if (_freeRun)
        return 0;
    // Channel number is the upper two bits of the first 32-bit chunk, which
    // is stored in little-endian byte order
    const unsigned char *ubuf = (const unsigned char*)buf;
    unsigned int chan = (ubuf[3] >> 6) & 0x3;
    return chan;
}

//////////////////////////////////////////////////////////////////////////////////
long
p7142sd3cdnThread::unpackPulseNum(const char* buf) const {
    if (_freeRun)
        return 0;
    // Pulse number is the lower 30 bits of the first 32-bit chunk, which is
    // stored in little-endian byte order
    const unsigned char *ubuf = (const unsigned char*)buf;
    unsigned long pulseNum = (ubuf[3] & 0x3f) << 24 |
        ubuf[2] << 16 | ubuf[1] << 8 | ubuf[0];
    return pulseNum;
}

//////////////////////////////////////////////////////////////////////////////////
bool
p7142sd3cdnThread::_configIsValid() const {
    bool valid = true;
    // gate count must be in the interval [1,511]
    if (_gates < 1 || _gates > 511) {
        std::cerr << "gates is " << _gates <<
            "; it must be greater than 0 and less than 512." << std::endl;
        valid = false;
    }
    // PRT must be a multiple of the pulse width
    if (_prt % _pulseWidth) {
        std::cerr << "PRT is " << _prt * 2 / adcFrequency() << " (" << _prt <<
            ") and pulse width is " << _pulseWidth * 2 / adcFrequency() << 
            " (" << _pulseWidth << 
            "): PRT must be an integral number of pulse widths." << std::endl;
        valid = false;
    }
    // PRT must be longer than (gates + 1) * pulse width
    if (_prt <= ((_gates + 1) * _pulseWidth)) {
        std::cerr << 
            "PRT must be greater than (gates+1)*(pulse width)." << std::endl;
        valid = false;
    }
    return valid;
}
