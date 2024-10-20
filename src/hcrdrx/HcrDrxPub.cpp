// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2016                                         
// ** University Corporation for Atmospheric Research (UCAR)                 
// ** National Center for Atmospheric Research (NCAR)                        
// ** Boulder, Colorado, USA                                                 
// ** BSD licence applies - redistribution and use in source and binary      
// ** forms, with or without modification, are permitted provided that       
// ** the following conditions are met:                                      
// ** 1) If the software is modified to produce derivative works,            
// ** such modified software should be clearly marked, so as not             
// ** to confuse it with the version available from UCAR.                    
// ** 2) Redistributions of source code must retain the above copyright      
// ** notice, this list of conditions and the following disclaimer.          
// ** 3) Redistributions in binary form must reproduce the above copyright   
// ** notice, this list of conditions and the following disclaimer in the    
// ** documentation and/or other materials provided with the distribution.   
// ** 4) Neither the name of UCAR nor the names of its contributors,         
// ** if any, may be used to endorse or promote products derived from        
// ** this software without specific prior written permission.               
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS  
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED      
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.    
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
#include <sys/timeb.h>
#include <cstdlib>
#include <iostream>
#include <iomanip>
#include <QUdpSocket>
#include <logx/Logging.h>

#include "HcrDrxPub.h"
#include "IwrfExport.h"
#include "PulseData.h"

using namespace boost::posix_time;

LOGGING("HcrDrxPub")

HcrDrxPub * HcrDrxPub::InstanceForType[] = { NULL, NULL };

//////////////////////////////////////////////////////////////////////////////////
HcrDrxPub::HcrDrxPub(
                Pentek::p7142sd3c& sd3c,
                int pentekChanNum,
                DataChannelType chanType,
                const HcrDrxConfig& config,
                IwrfExport *exporter,
                int tsLength,
                std::string gaussianFile,
                std::string kaiserFile,
                int simWavelength) :
     QThread(),
     _config(config),
     _sd3c(sd3c),
     _pentekChanNum(pentekChanNum),
     _chanType(chanType),
     _down(0),
     _nGates(sd3c.gates()),
     _sampleNumber(0),
     _exporter(exporter),
     _pulseData(NULL),
     _dataSeen(false)
{
    // Bail out if we're not configured legally.
    if (! _configIsValid())
        abort();

    // If there's already an instance for this channel type, it's a problem...
    // Otherwise, we mark our spot as owner of this channel type.
    if (InstanceForType[_chanType]) {
        ELOG << "Attempt to instantiate multiple HcrDrxPub-s " << 
                "for channel type " << _chanType;
        exit(1);
    } else {
        InstanceForType[_chanType] = this;
    }
    
    // scaling between A2D counts and volts
    _iqScaleForMw = config.iqcount_scale_for_mw();

    // Create our associated downconverter.
    bool useInternalClock = false;
    _down = sd3c.addDownconverter(_pentekChanNum, 4 * 512 * 1024, false, tsLength,
        config.digitizer_gate0_delay(), config.digitizer_sample_width(),
        gaussianFile, kaiserFile, simWavelength, useInternalClock);
}

//////////////////////////////////////////////////////////////////////////////////
HcrDrxPub::~HcrDrxPub() {
    // Remove ourself as the single instance for our channel type
    InstanceForType[_chanType] = NULL;
}

//////////////////////////////////////////////////////////////////////////////////
void HcrDrxPub::run() {
  int bl = _down->beamLength();
  
  ILOG << "Channel " << _pentekChanNum << " beam length is " << bl <<
    ", waiting for data...";
  // Socket for broadcasting angles. This is only used by channel 0.
  QUdpSocket * angleSocket = (_pentekChanNum == 0) ? new QUdpSocket() : 0;

  // start the loop. The thread will block on getBeam()
  int count = 0;
  while (1) {
    int64_t pulsenum;
    float rotMotorAngle;
    float tiltMotorAngle;
    bool xmitPolHorizontal;
    char* buf = _down->getBeam(pulsenum, rotMotorAngle, tiltMotorAngle,
            xmitPolHorizontal);
    
    // Emit a signal when we first see data
    if (! _dataSeen) {
        _dataSeen = true;
        emit(firstDataSeen(_pentekChanNum));
    }
    
    // Publish angles from channel 0 every 100 pulses.
    if (angleSocket && ! (count++ % 100)) {
        // Put together a datagram containing rotation and tilt motor angles
        // as IEEE 4-byte floats.
        QByteArray datagram;
        datagram.append(reinterpret_cast<char*>(&rotMotorAngle), sizeof(float));
        datagram.append(reinterpret_cast<char*>(&tiltMotorAngle), sizeof(float));
        angleSocket->writeDatagram(datagram.data(), datagram.size(),
                QHostAddress::Broadcast, 45454);
    }

    _addToExport(reinterpret_cast<const int16_t *>(buf), pulsenum,
            rotMotorAngle, tiltMotorAngle, xmitPolHorizontal);
  }
  // Delete the angle socket before we exit
  delete(angleSocket);
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
HcrDrxPub::_addToExport(const int16_t *iq, int64_t pulseSeqNum,
        float rotMotorAngle, float tiltMotorAngle, bool xmitPolHorizontal)
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
  PulseData::XmitPolarization_t xmitPol =
          xmitPolHorizontal ? PulseData::XMIT_POL_HORIZONTAL : PulseData::XMIT_POL_VERTICAL;
  _pulseData->set(pulseSeqNum, timeSecs, nanoSecs,
          _pentekChanNum, rotMotorAngle, tiltMotorAngle, xmitPol,
          _nGates, iq);

  // Write our current object into the merge queue, and get back another to use
  switch (_chanType) {
  case H_CHANNEL:
      _pulseData = _exporter->writePulseH(_pulseData);
      break;
  case V_CHANNEL:
      _pulseData = _exporter->writePulseV(_pulseData);
      break;
  default:
      ELOG << "Dropping pulse for channel type " << _chanType;
  }
}
