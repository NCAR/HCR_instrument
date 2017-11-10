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
#include "IwrfExport.h"
#include <logx/Logging.h>
#include <sys/timeb.h>
#include <cmath>
#include <cstdlib>
#include <cstring>
#include <sstream>
#include <unistd.h>
#include <iostream>
#include <iomanip>
#include <radar/iwrf_functions.hh>
#include <radar/IwrfCalib.hh>
#include <toolsa/pmu.h>
#include <toolsa/uusleep.h>
#include <toolsa/TaXml.hh>
#include <toolsa/toolsa_macros.h>

#include <QCoreApplication>
#include <QDateTime>
#include <QWriteLocker>

LOGGING("IwrfExport")

///////////////////////////////////////////////////////////////////////////

IwrfExport::IwrfExport(const HcrDrxConfig& config, const StatusGrabber& monitor) :
        QThread(),
        _hAccessLock(QReadWriteLock::NonRecursive),
        _vAccessLock(QReadWriteLock::NonRecursive),
        _insAccessLock(QReadWriteLock::NonRecursive),
        _logAccessLock(QReadWriteLock::NonRecursive),
        _config(config),
        _monitor(monitor),
        _hmcMode(HcrPmc730::HMC_MODE_INVALID),
        _ins1WatchThread(*this, 1),
        _ins2WatchThread(*this, 2),
        _ins1Deque(),
        _ins2Deque(),
        _latestIns1Data(),
        _latestIns2Data(),
        _ins1DataDelayed(false),
        _ins2DataDelayed(false),
        _statusTimer(NULL),
        _hPulseCount(0),
        _vPulseCount(0),
        _ins1Count(0),
        _ins2Count(0),
        _lastGeorefTime(0)
{

  // initialize

  _queueSize = _config.merge_queue_size();
  _iwrfServerTcpPort = _config.iwrf_server_tcp_port();

  // queues

  _qH = new CircBuffer<PulseData>(_queueSize);
  _qV = new CircBuffer<PulseData>(_queueSize);

  // pulse and burst data for reading from queues

  _pulseH = new PulseData;
  _pulseV = new PulseData;

  // iq data

  _nGates = 0;
  _pulseBuf = NULL;
  _iq = NULL;
  _pulseIntervalPerIwrfMetaData = config.pulse_interval_per_iwrf_meta_data();
  _pulseBufLen = 0;
  _pulseMsgLen = 0;

  // status xml

  _xmlLen = 0;
  _statusBuf = NULL;
  _statusBufLen = 0;
  _statusMsgLen = 0;
  
  // I and Q count scaling factor to get power in mW easily:
  // mW = (I_count / _iqScaleForMw)^2 + (Q_count / _iqScaleForMw)^2
  _iqScaleForMw = _config.iqcount_scale_for_mw();

  // pulse seq num and times

  _pulseSeqNum = -1;
  _timeSecs = 0;
  _nanoSecs = 0;

  _prevPulseSeqNum = 0;
  _prevTimeSecs = 0;
  _prevNanoSecs = 0;

  // initialize IWRF calibration struct from the calibration file defined in
  // the config

  std::string errStr;
  if (_calib.readFromXmlFile(_config.calibration_file(), errStr) != 0) {
      ELOG << "Error reading calibration file '" <<
              _config.calibration_file() << "': " << errStr;
      abort();
  }

  // initialize IWRF radar_info struct from config

  _packetSeqNum = 0;

  iwrf_radar_info_init(_radarInfo);
  _radarInfo.latitude_deg = _config.latitude();
  _radarInfo.longitude_deg = _config.longitude();
  _radarInfo.altitude_m = _config.altitude();
  _radarInfo.platform_type = IWRF_RADAR_PLATFORM_FIXED;
  _radarInfo.beamwidth_deg_h = _calib.getBeamWidthDegH();
  _radarInfo.beamwidth_deg_v = _calib.getBeamWidthDegV();
  _radarInfo.wavelength_cm = _calib.getWavelengthCm();
  _radarInfo.nominal_gain_ant_db_h = _calib.getAntGainDbH();
  _radarInfo.nominal_gain_ant_db_v = _calib.getAntGainDbV();
  strncpy(_radarInfo.radar_name, _config.radar_id().c_str(),
          IWRF_MAX_RADAR_NAME - 1);

  // initialize IWRF ts_processing struct from config

  iwrf_ts_processing_init(_tsProc);
  _tsProc.xmit_rcv_mode = IWRF_XMIT_RCV_MODE_NOT_SET;
  _tsProc.xmit_phase_mode = IWRF_XMIT_PHASE_MODE_FIXED;
  _tsProc.prf_mode = IWRF_PRF_MODE_FIXED;
  _tsProc.pulse_type = IWRF_PULSE_TYPE_RECT;
  _tsProc.prt_usec = _config.prt1() * 1.0e6;
  _tsProc.prt2_usec = _config.prt2() * 1.0e6;
  _tsProc.cal_type = IWRF_CAL_TYPE_NOT_SET;
  _tsProc.burst_range_offset_m = 0.0;
  //   _tsProc.burst_range_offset_m =
  //     _config.burst_sample_delay() * lightSpeedMps / 2.0;
  _tsProc.pulse_width_us = _config.tx_pulse_width() * 1.0e6;
  const double SpeedOfLight = 2.99792458e8; // m/s
  _tsProc.gate_spacing_m = _config.digitizer_sample_width() * SpeedOfLight / 2;
  _tsProc.start_range_m = _config.range_to_gate0(); // center of gate 0
  _tsProc.pol_mode = IWRF_POL_MODE_NOT_SET;

  // initialize IWRF scan segment for simulation angles

  iwrf_scan_segment_init(_simScan);
  _simScan.scan_mode = IWRF_SCAN_MODE_AZ_SUR_360;

  // initialize pulse header

  iwrf_pulse_header_init(_pulseHdr);

  /// PRT mode

  _staggeredPrt = false;
  if (_config.staggered_prt() != HcrDrxConfig::UNSET_BOOL) {
    _staggeredPrt = _config.staggered_prt();
  }
  _prt1 = 1.0e-3;
  if (_config.prt1() != HcrDrxConfig::UNSET_DOUBLE) {
    _prt1 = _config.prt1();
  }
  
  /// beam angles
  
  _azimuthDeg = 0.0;
  _elevationDeg = 0.0;

  /// angle corrections

  _rollCorr = 0.0;
  _pitchCorr = 0.0;
  _headingCorr = 0.0;
  _driftCorr = 0.0;
  _tiltCorr = 0.0;
  _rotationCorr = 0.0;

  /// simulation of antenna angles

  _simAntennaAngles = false;
  _simNElev = 10;
  _simStartElev = 0.5;
  _simDeltaElev = 1.0;
  _simAzRate = 10.0;
  if (_config.simulate_antenna_angles() != HcrDrxConfig::UNSET_BOOL) {
    _simAntennaAngles = _config.simulate_antenna_angles();
  }
  if (_config.sim_n_elev() != HcrDrxConfig::UNSET_INT) {
    _simNElev = _config.sim_n_elev();
  }
  if (_config.sim_start_elev() != HcrDrxConfig::UNSET_DOUBLE) {
    _simStartElev = _config.sim_start_elev();
  }
  if (_config.sim_delta_elev() != HcrDrxConfig::UNSET_DOUBLE) {
    _simDeltaElev = _config.sim_delta_elev();
  }
  if (_config.sim_az_rate() != HcrDrxConfig::UNSET_DOUBLE) {
    _simAzRate = _config.sim_az_rate();
  }
  _simElev = _simStartElev;
  _simAz = 0.0;
  _simVolNum = 0;
  _simSweepNum = 0;

  // server

  _serverIsOpen = false;
  _sock = NULL;
  _newClient = false;

  // Start INS watch threads after this thread is started
  connect(this, SIGNAL(started()), &_ins1WatchThread, SLOT(start()));
  connect(this, SIGNAL(started()), &_ins2WatchThread, SLOT(start()));

  // Create a timer to print some status information on a regular basis, and
  // start it when our thread is started.
  _statusTimer = new QTimer();
  _statusTimer->setInterval(10000);    // 10 s
  connect(_statusTimer, SIGNAL(timeout()), this, SLOT(_logStatus()));
  connect(this, SIGNAL(started()), _statusTimer, SLOT(start()));
}

/////////////////////////////////////////////////////////////////////////////
IwrfExport::~IwrfExport()

{
  // First terminate the thread
  terminate();

  // Clean up allocated memory
  delete(_statusTimer);
  
  if (_sock && _sock->isOpen()) {
    _sock->close();
  }
  delete(_sock);

  delete _qH;
  delete _qV;

  delete _pulseH;
  delete _pulseV;

  if (_pulseBuf) {
    delete[] _pulseBuf;
  }

}

/////////////////////////////////////////////////////////////////////////////
//
// Thread run method

void IwrfExport::run()

{
  // Since we have no event loop,
  // allow thread termination via the terminate() method.

  setTerminationEnabled(true);
  
  // start the loop

  bool metaDataInitialized = false;
  while (true) {

    // Process pending Qt events for this thread
      
    QCoreApplication::processEvents();

    // read in next pulse

    _readNextPulse();

    // check that we have a client
    
    if (_checkClient()) {
      continue;
    }

    // determine number of gates

    int nGates = _pulseH->getNGates();
    
    // should we send meta-data?
    
    bool sendMeta = false;
    if (_newClient) {
      sendMeta = true;
      metaDataInitialized = false;
    }
    if (nGates != _nGates) {
      sendMeta = true;
      _nGates = nGates;
    }
    if (_monitor.pmc730Status().hmcMode() != _hmcMode) {
      sendMeta = true;
      _hmcMode = static_cast<HcrPmc730::HmcOperationMode>(_monitor.pmc730Status().hmcMode());
    }
    if (_pulseSeqNum % _pulseIntervalPerIwrfMetaData == 0) {
      sendMeta = true;
    }

    // Send a metadata packet if requested
    if (sendMeta) {
      _sendIwrfMetaData();
      metaDataInitialized = true;
    }
    
    // Generate any IWRF georef packet(s) with times before this pulse, waiting
    // for new INS data for a while if necessary.
    _doIwrfGeorefsBeforePulse();

    // assemble and send out the IWRF pulse packet
    
    if (metaDataInitialized) {
      _assembleIwrfPulsePacket();
      _sendIwrfPulsePacket();
    }
    
    // If it's been long enough since our last status packet, generate a new
    // one now.

    if (metaDataInitialized) {
      if (sendMeta) {
        _assembleStatusPacket();
        _sendIwrfStatusXmlPacket();
      }
    }
    
  } // while

}

/////////////////////////////////////////////////////////////////////////////
// read the next set of pulse data

void IwrfExport::_readNextPulse()
{

  PMU_auto_register("reading pulses");

  // read next pulse data for each channel

  _readNextH();
  _readNextV();
  
  // synchronize the pulses and burst to have same sequence number,
  // reading extra pulses as required
  
  _syncPulses();

  if (_pulseSeqNum < 0) {
    // first time
    _prevPulseSeqNum = _pulseH->getPulseSeqNum() - 1;
    _prevTimeSecs = _pulseH->getTimeSecs();
    _prevNanoSecs = _pulseH->getNanoSecs();
  } else {
    _prevPulseSeqNum = _pulseSeqNum;
    _prevTimeSecs = _timeSecs;
    _prevNanoSecs = _nanoSecs;
  }

  _pulseSeqNum = _pulseH->getPulseSeqNum();
  _timeSecs = _pulseH->getTimeSecs();
  _nanoSecs = _pulseH->getNanoSecs();
  
  if (! (_pulseSeqNum % 10000)) {
    DLOG << "got 10000 pulses, seqNum, secs, nanoSecs: "
         << _pulseSeqNum << ", " << _timeSecs << ", " << _nanoSecs;
  }

  if (_pulseSeqNum != _prevPulseSeqNum + 1) {
    int nMissing = _pulseSeqNum - _prevPulseSeqNum - 1;
    WLOG << "Missing pulses - nmiss, prevNum, thisNum: "
         << nMissing << ", "
         << _prevPulseSeqNum << ", "
         << _pulseSeqNum;
  }

}

/////////////////////////////////////////////////////////////////////////////
// synchronize the pulses and burst to have same sequence number,
// reading extra pulses as required

void IwrfExport::_syncPulses()
{
  
  // compute the max pulse seq num
  
  int64_t seqNumH = _pulseH->getPulseSeqNum();
  int64_t seqNumV = _pulseV->getPulseSeqNum();
  int64_t maxSeqNum = seqNumH;
  if (maxSeqNum < seqNumV) {
    maxSeqNum = seqNumV;
  }

  // read until all sequence numbers match

  bool done = false;
  while (!done) {

    done = true;

    // H channel

    if (seqNumH < maxSeqNum) {
      _readNextH();
      seqNumH = _pulseH->getPulseSeqNum();
      if (maxSeqNum < seqNumH) {
        maxSeqNum = seqNumH;
        done = false;
      }
    }

    // V channel

    if (seqNumV < maxSeqNum) {
      _readNextV();
      seqNumV = _pulseV->getPulseSeqNum();
      if (maxSeqNum < seqNumV) {
        maxSeqNum = seqNumV;
        done = false;
      }
    }

  } // while

}

/////////////////////////////////////////////////////////////////////////////
// write data for next H pulse
// called by HcrDrxPub threads
// Returns pulse data object for recycling

PulseData *IwrfExport::writePulseH(PulseData *val)
{
  // Get a write lock which will be released when we return
  QWriteLocker wLocker(&_hAccessLock);
  _hPulseCount++;
  return _qH->write(val);
}

/////////////////////////////////////////////////////////////////////////////
// write data for next V pulse
// called by HcrDrxPub threads
// Returns pulse data object for recycling

PulseData *IwrfExport::writePulseV(PulseData *val)
{
  // Get a write lock which will be released when we return
  QWriteLocker wLocker(&_vAccessLock);
  _vPulseCount++;
  return _qV->write(val);
}

/////////////////////////////////////////////////////////////////////////////
// read the next H data

void IwrfExport::_readNextH()
{
  // Get a write lock, since we modify members
  _hAccessLock.lockForWrite();

  // Our old pulse goes back for reuse
  PulseData *replacementElement = _pulseH;
  _pulseH = NULL;
  
  // Loop until we get a new pulse from the circular buffer
  for (int ntries = 0; _pulseH == NULL; ntries++) {
    if (ntries != 0) {
      // Sleep briefly between tries, releasing the lock while we sleep
      _hAccessLock.unlock();
      usleep(50);
      _hAccessLock.lockForWrite();
    }
    _pulseH = _qH->read(replacementElement);
  }

  _hAccessLock.unlock();
}

/////////////////////////////////////////////////////////////////////////////
// read the next V data

void IwrfExport::_readNextV()
{
  // Get a write lock, since we modify members
  _vAccessLock.lockForWrite();

  // Our old pulse goes back for reuse
  PulseData *replacementElement = _pulseV;
  _pulseV = NULL;

  // Loop until we get a new pulse from the circular buffer
  for (int ntries = 0; _pulseV == NULL; ntries++) {
      if (ntries != 0) {
          // Sleep briefly between tries, releasing the lock while we sleep
          _vAccessLock.unlock();
          usleep(50);
          _vAccessLock.lockForWrite();
      }
      _pulseV = _qV->read(replacementElement);
  }

  _vAccessLock.unlock();
}

/////////////////////////////////////////////////////////////////////////////
// send the IWRF meta data

int IwrfExport::_sendIwrfMetaData()
{

  // set seq num and time in packet headers

  _radarInfo.packet.seq_num = _packetSeqNum++;
  _radarInfo.packet.time_secs_utc = _timeSecs;
  _radarInfo.packet.time_nano_secs = _nanoSecs;

  _tsProc.packet.seq_num = _packetSeqNum++;
  _tsProc.packet.time_secs_utc = _timeSecs;
  _tsProc.packet.time_nano_secs = _nanoSecs;

  // set our polarization and calibration modes for processing
  
  switch (_hmcMode) {
    case HcrPmc730::HMC_MODE_V_HV:
    case HcrPmc730::HMC_MODE_V_HV_ATTENUATED:
    case HcrPmc730::HMC_MODE_BENCH_TEST:
    case HcrPmc730::HMC_MODE_UNUSED_7:
        _tsProc.xmit_rcv_mode = IWRF_V_ONLY_FIXED_HV;
        _tsProc.pol_mode = IWRF_POL_MODE_V;
        _tsProc.cal_type = IWRF_CAL_TYPE_NONE;
        break;
    case HcrPmc730::HMC_MODE_H_HV:
    case HcrPmc730::HMC_MODE_H_HV_ATTENUATED:
        _tsProc.xmit_rcv_mode = IWRF_H_ONLY_FIXED_HV;
        _tsProc.pol_mode = IWRF_POL_MODE_H;
        _tsProc.cal_type = IWRF_CAL_TYPE_NONE;
        break;
    case HcrPmc730::HMC_MODE_HV_HV:
        _tsProc.xmit_rcv_mode = IWRF_ALT_HV_FIXED_HV;
        _tsProc.pol_mode = IWRF_POL_MODE_HV_ALT;
        _tsProc.cal_type = IWRF_CAL_TYPE_NONE;
        break;
    case HcrPmc730::HMC_MODE_NOISE_SOURCE_CAL:
        _tsProc.xmit_rcv_mode = IWRF_V_ONLY_FIXED_HV;
        _tsProc.pol_mode = IWRF_POL_MODE_V;
        _tsProc.cal_type = IWRF_CAL_TYPE_NOISE_SOURCE_V;
        break;
    default:
        WLOG << "Unhandled/unknown _hmcMode: " << _hmcMode;
        _tsProc.xmit_rcv_mode = IWRF_XMIT_RCV_MODE_NOT_SET;
        _tsProc.pol_mode = IWRF_POL_MODE_NOT_SET;
        _tsProc.cal_type = IWRF_CAL_TYPE_NOT_SET;
        break;
  }

  iwrf_calibration_t calibStruct = _calib.getStruct();
  calibStruct.packet.seq_num = _packetSeqNum++;
  calibStruct.packet.time_secs_utc = _timeSecs;
  calibStruct.packet.time_nano_secs = _nanoSecs;

  // write individual messages for each struct

  bool closeSocket = false;
  
  if (_sock && _sock->writeBuffer(&_radarInfo, sizeof(_radarInfo))) {
    ELOG << "ERROR - IwrfExport::_sendIwrfMetaData()";
    ELOG << "  Writing IWRF_RADAR_INFO";
    ELOG << "  " << _sock->getErrStr();
    closeSocket = true;
  } else if (_sock && _sock->writeBuffer(&_tsProc, sizeof(_tsProc))) {
    ELOG << "ERROR - IwrfExport::_sendIwrfMetaData()";
    ELOG << "  Writing IWRF_TS_PROCESSING";
    ELOG << "  " << _sock->getErrStr();
    closeSocket = true;
  } else if (_sock && _sock->writeBuffer(&calibStruct, sizeof(calibStruct))) {
    ELOG << "ERROR - IwrfExport::_sendIwrfMetaData()";
    ELOG << "  Writing IWRF_CALIBRATION";
    ELOG << "  " << _sock->getErrStr();
    closeSocket = true;
  }
  
  if (closeSocket) {
    _closeSocketToClient();
    return -1;
  }

  return 0;

}

/////////////////////////////////////////////////////////////////////////////
// assemble IWRF pulse packet

void IwrfExport::_assembleIwrfPulsePacket()
{

  // allocate space for IQ data
  
  _allocPulseBuf();

  // load up IQ data

  memcpy(_iq, _pulseH->getIq(), _pulseH->getNGates() * 2 * sizeof(int16_t));

  memcpy(_iq + (_nGates * 2),
         _pulseV->getIq(), _pulseV->getNGates() * 2 * sizeof(int16_t));
  
  // pulse header
  
  _pulseHdr.packet.len_bytes = _pulseMsgLen;
  _pulseHdr.packet.seq_num = _packetSeqNum++;
  _pulseHdr.packet.time_secs_utc = _timeSecs;
  _pulseHdr.packet.time_nano_secs = _nanoSecs;

  _pulseHdr.pulse_seq_num = _pulseSeqNum;

  if (_staggeredPrt) {
     _pulseHdr.prt =
       (double) (_timeSecs - _prevTimeSecs) +
       (double) (_nanoSecs - _prevNanoSecs) * 1.0e-9;
  } else {
    _pulseHdr.prt = _prt1;
  }

  _pulseHdr.pulse_width_us = _tsProc.pulse_width_us;
  _pulseHdr.n_gates = _nGates;
  _pulseHdr.n_channels = NCHANNELS;
  _pulseHdr.iq_encoding = IWRF_IQ_ENCODING_SCALED_SI16;
  // Pulse transmit polarization should be the same in both the H and V
  // receiver data. We just get it from _pulseH receiver data.
  _pulseHdr.hv_flag =
          (_pulseH->getXmitPolarization() == PulseData::XMIT_POL_HORIZONTAL) ? 1 : 0;
  _pulseHdr.phase_cohered = true;
  _pulseHdr.n_data = _nGates * NCHANNELS * 2;
  _pulseHdr.iq_offset[0] = 0;
  _pulseHdr.iq_offset[1] = _nGates * 2;
  _pulseHdr.iq_offset[2] = _nGates * 4;
  _pulseHdr.scale = 1.0 / _iqScaleForMw;
  _pulseHdr.offset = 0.0;
  _pulseHdr.n_gates_burst = 0;
  _pulseHdr.start_range_m = _tsProc.start_range_m;
  _pulseHdr.gate_spacing_m = _tsProc.gate_spacing_m;

  if (_simAntennaAngles) {
    double dAz = _pulseHdr.prt * _simAzRate;
    _simAz += dAz;
    if (_simAz >= 360.0) {
      _simAz = 0.0;
      _simSweepNum++;
      _simElev += _simDeltaElev;
      if (_simSweepNum == 10) {
        _simElev = _simStartElev;
        _simSweepNum = 0;
        _simVolNum++;
      }
    }
    // _pulseHdr.scan_mode = IWRF_SCAN_MODE_VERT;
    _pulseHdr.scan_mode = IWRF_SCAN_MODE_AZ_SUR_360;
    _pulseHdr.volume_num = _simVolNum;
    _pulseHdr.sweep_num = _simSweepNum;
    _pulseHdr.fixed_el = _simElev;
    _pulseHdr.elevation = _simElev;
    _pulseHdr.azimuth = _simAz;
  } else {
    _pulseHdr.elevation = _elevationDeg;
    _pulseHdr.azimuth = _azimuthDeg;
  }
  
  memcpy(_pulseBuf, &_pulseHdr, sizeof(_pulseHdr));
  
}

/////////////////////////////////////////////////////////////////////////////
// send out the IWRF pulse packet

int IwrfExport::_sendIwrfPulsePacket()
{

  bool closeSocket = false;
  if (_sock && _sock->writeBuffer(_pulseBuf, _pulseMsgLen)) {
    ELOG << "ERROR - IwrfExport::_sendIwrfPulsePacket()";
    ELOG << "  Writing pulse packet";
    ELOG << "  " << _sock->getErrStr();
    closeSocket = true;
  }

  if (closeSocket) {
    _closeSocketToClient();
    return -1; 
  }
  
  return 0;

}

/////////////////////////////////////////////////////////////////////////////
// allocate pulse buffer

void IwrfExport::_allocPulseBuf()
{

  _pulseMsgLen =
    sizeof(iwrf_pulse_header) + (_nGates * NCHANNELS * 2 * sizeof(int16_t));

  if (_pulseMsgLen > _pulseBufLen) {
    
    if (_pulseBuf) {
      delete[] _pulseBuf;
    }

    _pulseBufLen = _pulseMsgLen;
    _pulseBuf = new char[_pulseBufLen];
    _iq = reinterpret_cast<int16_t *>(_pulseBuf + sizeof(iwrf_pulse_header));

  }

  memset(_iq, 0, _nGates * NCHANNELS * 2 * sizeof(int16_t));

}

/////////////////////////////////////////////////////////////////////////////
// assemble IWRF status packet

void IwrfExport::_assembleStatusPacket()

{

  // assemble the xml

  string xmlStr = _assembleStatusXml();
  _xmlLen = ((xmlStr.size() + 7) / 8) * 8; // round up to 8-bytes
  
  // allocate buffer

  _allocStatusBuf();

  // set header

  iwrf_status_xml_t hdr;
  iwrf_status_xml_init(hdr);
  hdr.xml_len = _xmlLen;
  hdr.packet.len_bytes = _statusMsgLen;
  hdr.packet.seq_num = _packetSeqNum++;

  // copy data into buffer
  
  memset(_statusBuf, 0, _statusBufLen);
  memcpy(_statusBuf, &hdr, sizeof(iwrf_status_xml_t));
  memcpy(_statusBuf + sizeof(iwrf_status_xml_t),
         xmlStr.c_str(), xmlStr.size());
  
}

/////////////////////////////////////////////////////////////////////////////
// assemble status XML
// returns the XML string

string IwrfExport::_assembleStatusXml()

{

  string xml;

  // main block

  xml += TaXml::writeStartTag("HcrStatus", 0);

  ///////////////////////////////////////////////////////
  // transmit block
  
  xml += TaXml::writeStartTag("HcrTransmitterStatus", 1);

  const XmitStatus &xs = _monitor.transmitterStatus();
  xml += xs.toTaXmlString(2);

  xml += TaXml::writeEndTag("HcrTransmitterStatus", 1);

  ///////////////////////////////////////////////////////
  // receive block

  xml += TaXml::writeStartTag("HcrReceiverStatus", 1);

  // Start with status from the PMC-730 card
  const HcrPmc730Status pmc730Status = _monitor.pmc730Status();
  
  // ints
  
  xml += TaXml::writeInt
    ("HmcMode", 2, pmc730Status.hmcMode());

  xml += TaXml::writeInt
    ("EmsErrorCount", 2, pmc730Status.emsErrorCount());

  // floats

  xml += TaXml::writeDouble
    ("DetectedRfPower", 2, pmc730Status.detectedRfPower());

  xml += TaXml::writeDouble
    ("PvForePressure", 2, pmc730Status.pvForePressure());

  xml += TaXml::writeDouble
    ("PvAftPressure", 2, pmc730Status.pvAftPressure());

  xml += TaXml::writeDouble
    ("ApsLowSidePressure", 2, pmc730Status.apsLowSidePressure());

  xml += TaXml::writeDouble
    ("ApsHighSidePressure", 2, pmc730Status.apsHighSidePressure());

  xml += TaXml::writeDouble
    ("PloTemp", 2, pmc730Status.ploTemp());

  xml += TaXml::writeDouble
    ("EikTemp", 2, pmc730Status.eikTemp());

  xml += TaXml::writeDouble
    ("VLnaTemp", 2, pmc730Status.vLnaTemp());

  xml += TaXml::writeDouble
    ("HLnaTemp", 2, pmc730Status.hLnaTemp());

  xml += TaXml::writeDouble
    ("PolarizationSwitchTemp", 2, pmc730Status.polarizationSwitchTemp());

  xml += TaXml::writeDouble
    ("RfDetectorTemp", 2, pmc730Status.rfDetectorTemp());

  xml += TaXml::writeDouble
    ("NoiseSourceTemp", 2, pmc730Status.noiseSourceTemp());

  xml += TaXml::writeDouble
    ("Ps28VTemp", 2, pmc730Status.ps28VTemp());

  xml += TaXml::writeDouble
    ("RdsInDuctTemp", 2, pmc730Status.rdsInDuctTemp());

  xml += TaXml::writeDouble
    ("RotationMotorTemp", 2, pmc730Status.rotationMotorTemp());

  xml += TaXml::writeDouble
    ("TiltMotorTemp", 2, pmc730Status.tiltMotorTemp());

  xml += TaXml::writeDouble
    ("InsTemp", 2, pmc730Status.insTemp());

  xml += TaXml::writeDouble
    ("TailconeTemp", 2, pmc730Status.tailconeTemp());

  xml += TaXml::writeDouble
    ("PsVoltage", 2, pmc730Status.psVoltage());

  // booleans

  xml += TaXml::writeBoolean
    ("ApsValveOpen", 2, pmc730Status.apsValveOpen());

  xml += TaXml::writeBoolean
    ("Locked15_5GHzPLO", 2, pmc730Status.locked15_5GHzPLO());

  xml += TaXml::writeBoolean
    ("Locked1250MHzPLO", 2, pmc730Status.locked1250MHzPLO());

  xml += TaXml::writeBoolean
    ("Locked125MHzPLO", 2, pmc730Status.locked125MHzPLO());

  xml += TaXml::writeBoolean
    ("ModPulseDisabled", 2, pmc730Status.modPulseDisabled());
  
  xml += TaXml::writeBoolean
    ("RdsXmitterFilamentOn", 2, pmc730Status.rdsXmitterFilamentOn());

  xml += TaXml::writeBoolean
    ("RdsXmitterHvOn", 2, pmc730Status.rdsXmitterHvOn());

  xml += TaXml::writeBoolean
    ("RadarPowerError", 2, pmc730Status.radarPowerError());
  
  xml += TaXml::writeBoolean
    ("EmsError1", 2, pmc730Status.emsError1());

  xml += TaXml::writeBoolean
    ("EmsError2", 2, pmc730Status.emsError2());

  xml += TaXml::writeBoolean
    ("EmsError3", 2, pmc730Status.emsError3());

  xml += TaXml::writeBoolean
    ("EmsError4Or5", 2, pmc730Status.emsError4Or5());

  xml += TaXml::writeBoolean
    ("EmsError6Or7", 2, pmc730Status.emsError6Or7());

  xml += TaXml::writeBoolean
    ("EmsPowerError", 2, pmc730Status.emsPowerError());

  xml += TaXml::writeBoolean
    ("WaveguideSwitchError", 2, pmc730Status.waveguideSwitchError());

  // Status from hcrdrx
  const DrxStatus drxStatus = _monitor.drxStatus();

  xml += TaXml::writeDouble
    ("PentekFpgaTemp", 2, drxStatus.pentekFpgaTemp());

  xml += TaXml::writeDouble
    ("PentekBoardTemp", 2, drxStatus.pentekBoardTemp());

  // end receive status

  xml += TaXml::writeEndTag("HcrReceiverStatus", 1);

  ///////////////////////////////////////////////////////
  // HcrIns1Data and HcrIns2Data blocks
  for (int insNum = 1; insNum <= 2; insNum++) {

    std::ostringstream oss;
    oss << "HcrIns" << insNum << "Data";
    std::string blockName(oss.str());    // "HcrIns1Data" or "HcrIns2Data"
    xml += TaXml::writeStartTag(blockName, 1);

    // Get latest data we got from this INS (if any).
    CmigitsFmq::MsgStruct insData = (insNum == 1) ? _latestIns1Data : _latestIns2Data;

    // C-MIGITS status info (latest 3500 message from C-MIGITS)
    xml += TaXml::writeDouble("Cmigits3500Time", 2, 0.001 * insData.time3500);
    xml += TaXml::writeInt("Cmigits3500CurrentMode", 2, insData.currentMode);
    xml += TaXml::writeBoolean("Cmigits3500InsAvailable", 2, insData.insAvailable);
    xml += TaXml::writeBoolean("Cmigits3500GpsAvailable", 2, insData.gpsAvailable);
    xml += TaXml::writeInt("Cmigits3500NSats", 2, insData.nSats);
    xml += TaXml::writeInt("Cmigits3500PositionFOM", 2, insData.positionFOM);
    xml += TaXml::writeInt("Cmigits3500VelocityFOM", 2, insData.velocityFOM);
    xml += TaXml::writeInt("Cmigits3500HeadingFOM", 2, insData.headingFOM);
    xml += TaXml::writeInt("Cmigits3500TimeFOM", 2, insData.timeFOM);
    xml += TaXml::writeDouble("Cmigits3500HPosError", 2, insData.hPosError);
    xml += TaXml::writeDouble("Cmigits3500VPosError", 2, insData.vPosError);
    xml += TaXml::writeDouble("Cmigits3500VelocityError", 2, insData.velocityError);

    // current position/velocity (latest 3501 message from C-MIGITS)
    xml += TaXml::writeDouble("Cmigits3501Time", 2, 0.001 * insData.time3501);
    xml += TaXml::writeDouble("Cmigits3501Latitude", 2, insData.latitude);
    xml += TaXml::writeDouble("Cmigits3501Longitude", 2, insData.longitude);
    xml += TaXml::writeDouble("Cmigits3501Altitude", 2, insData.altitude);

    // current attitude (latest 3512 message from C-MIGITS)
    xml += TaXml::writeDouble("Cmigits3512Time", 2, 0.001 * insData.time3512);
    xml += TaXml::writeDouble("Cmigits3512Pitch", 2, insData.pitch);
    xml += TaXml::writeDouble("Cmigits3512Roll", 2, insData.roll);
    xml += TaXml::writeDouble("Cmigits3512Heading", 2, insData.heading);
    xml += TaXml::writeDouble("Cmigits3512VelNorth", 2, insData.velNorth);
    xml += TaXml::writeDouble("Cmigits3512VelEast", 2, insData.velEast);
    xml += TaXml::writeDouble("Cmigits3512VelUp", 2, insData.velUp);

    // end the block
    xml += TaXml::writeEndTag(blockName, 1);
  }


  ////////////////////////////////////////////////
  // close

  xml += TaXml::writeEndTag("HcrStatus", 0);

  return xml;

}

/////////////////////////////////////////////////////////////////////////////
// send out the IWRF status packet

int IwrfExport::_sendIwrfStatusXmlPacket()

{
    
  bool closeSocket = false;

  if (_sock && _sock->writeBuffer(_statusBuf, _statusMsgLen)) {
    ELOG << "ERROR - IwrfExport::_sendIwrfStatusXmlPacket()";
    ELOG << "  Writing status xml packet";
    ELOG << "  " << _sock->getErrStr();
    closeSocket = true;
  }
  
  if (closeSocket) {
    _closeSocketToClient();
    return -1; 
  }

  return 0;

}

/////////////////////////////////////////////////////////////////////////////
// allocate status buffer

void IwrfExport::_allocStatusBuf()
{

  _statusMsgLen = _xmlLen + sizeof(iwrf_status_xml);
  if (_statusMsgLen > _statusBufLen) {
    if (_statusBuf) {
      delete[] _statusBuf;
    }
    _statusBufLen = _statusMsgLen;
    _statusBuf = new char[_statusBufLen];
  }
  
}

//////////////////////////////////////////////////
// Write georef packet(s) for all INS deque entries up to the current
// pulse time. If necessary, we will wait up to 1/2 second for data to show
// up in the deque.
void IwrfExport::_doIwrfGeorefsBeforePulse() {
  // Get the read lock
  _insAccessLock.lockForRead();

  // If INS deque is empty and we haven't already marked INS data as
  // delayed, busy wait for a bit to see if more will come in. We need to do 
  // this to allow for occasional times when INS data arrive later than the 
  // associated pulse data.
  bool waitForIns1 = (_ins1Deque.empty() && ! _ins1DataDelayed);
  bool waitForIns2 = (_ins2Deque.empty() && ! _ins2DataDelayed);

  // If waiting, we'll wait up to 1/2 second for more INS data to arrive.
  static const int MAX_WAIT_US = 500000;

  // Period of sleep between tests for new INS data. Leave this
  // number small, since tests using 1 ms caused system instability with
  // Pentek data sync errors and DMA overruns.
  static const int SLEEP_US = 100;

  int total_wait_us = 0;
  while (waitForIns1 || waitForIns2) {
      // Release our lock and sleep briefly
      _insAccessLock.unlock();
      usleep(SLEEP_US);
      total_wait_us += SLEEP_US;

      // Get the read lock again
      _insAccessLock.lockForRead();
      
      // If we've waited MAX_WAIT_US, mark INS data as delayed so that
      // we don't wait again until new data show up in the deque.
      if (total_wait_us >= MAX_WAIT_US) {
          if (waitForIns1 && _ins1Deque.empty()) {
              WLOG << "INS1 data too delayed after " <<
                      0.001 * total_wait_us << " ms";
          }
          if (waitForIns2 && _ins2Deque.empty()) {
              WLOG << "INS2 data too delayed after " <<
                      0.001 * total_wait_us << " ms";
          }
          // Stop waiting
          waitForIns1 = false;
          waitForIns2 = false;
      } else {
          // Stop waiting for INS1 if we got something
          if (waitForIns1 && ! _ins1Deque.empty()) {
              // We were waiting, but now have something
              if (total_wait_us > 30000) {
                  ILOG << "Waited " << 0.001 * total_wait_us <<
                          " ms for INS1 data";
                  waitForIns1 = false;
              }
          }
          // Stop waiting for INS2 if we got something
          if (waitForIns2 && ! _ins2Deque.empty()) {
              // We were waiting, but now have something
              if (total_wait_us > 30000) {
                  ILOG << "Waited " << 0.001 * total_wait_us <<
                          " ms for INS2 data";
                  waitForIns2 = false;
              }
          }
      }
  }
  
  // If we get here and an INS deque is empty mark the INS data as delayed
  // so that we don't wait again until new data show up in the deque.
  _ins1DataDelayed = _ins1Deque.empty();
  _ins2DataDelayed = _ins2Deque.empty();

  // Get pulse time in milliseconds since the Epoch
  uint64_t pulseTime = uint64_t(_timeSecs) * 1000 + _nanoSecs / 1000000;

  // Write a georef packet for all entries in the deques up to and including
  // the current pulse time.
  int writeCount;
  for (writeCount = 0; ! true; writeCount++) {
      // Find the INS deque with the earliest entry time
      std::deque<CmigitsFmq::MsgStruct> * insDequePtr(NULL);

      if (_ins1Deque.empty() && _ins2Deque.empty()) {
          // No entries available, so we're done
          break;
      } else if (! _ins1Deque.empty() && ! _ins2Deque.empty()) {
          // Both deques have something, find the the earliest entry between
          // them
          uint64_t ins1Time = _ins1Deque.front().time3512;
          uint64_t ins2Time = _ins2Deque.front().time3512;
          insDequePtr = (ins1Time <= ins2Time) ?  &_ins1Deque : &_ins2Deque;
      } else if (! _ins1Deque.empty()) {
          insDequePtr = &_ins1Deque;
      } else {
          insDequePtr = &_ins2Deque;
      }

      // Get the earliest entry
      CmigitsFmq::MsgStruct entry = insDequePtr->front();

      // If the earliest entry is later than the current pulse time, we're
      // done here.
      if (entry.time3512 > pulseTime) {
          break;
      }

      // Get the write lock
      _insAccessLock.unlock();
      _insAccessLock.lockForWrite();

      // We're going to use this entry, so remove it from its source deque.
      //
      // If we get here, insDequePtr must point to the deque which provided
      // the earliest entry.
      if (! insDequePtr) {
          ELOG << "BUG - insDequePtr is NULL when writing a georef packet";
          abort();
      }
      insDequePtr->pop_front();
      
      // Initialize the georef packet
      iwrf_platform_georef_init(_radarGeoref);
      
      // Time tag the georef packet with the C-MIGITS 3512 message time
      if ((entry.time3512 % 1000) / 10 == 0) {
          DLOG << "New georef tagged " << (entry.time3512 / 1000) % 60 <<
                  "." << std::setw(3) << std::setfill('0') <<
                  entry.time3512 % 1000 << " for pulse tagged " <<
                  _timeSecs % 60 << std::setw(3) << std::setfill('0') <<
                  _nanoSecs / 1000000;
      }
      _radarGeoref.packet.time_secs_utc = entry.time3512 / 1000;
      _radarGeoref.packet.time_nano_secs = (entry.time3512 % 1000) * 1000000;

      _radarGeoref.altitude_agl_km = IWRF_MISSING_FLOAT;
      _radarGeoref.altitude_msl_km = entry.altitude * 0.001; // m -> km
      _radarGeoref.drift_angle_deg = CmigitsFmq::GetEstimatedDriftAngle(entry);
      _radarGeoref.ew_horiz_wind_mps = IWRF_MISSING_FLOAT;
      _radarGeoref.ew_velocity_mps = entry.velEast;
      _radarGeoref.heading_deg = entry.heading;
      _radarGeoref.heading_rate_dps = IWRF_MISSING_FLOAT;
      _radarGeoref.latitude = entry.latitude;
      _radarGeoref.longitude = entry.longitude;
      _radarGeoref.ns_horiz_wind_mps = IWRF_MISSING_FLOAT;
      _radarGeoref.ns_velocity_mps = entry.velNorth;
      _radarGeoref.pitch_deg = entry.pitch;
      _radarGeoref.pitch_rate_dps = IWRF_MISSING_FLOAT;
      _radarGeoref.roll_deg = entry.roll;
      _radarGeoref.vert_velocity_mps = entry.velUp;
      _radarGeoref.vert_wind_mps = IWRF_MISSING_FLOAT;

      _radarInfo.latitude_deg = entry.latitude;
      _radarInfo.longitude_deg = entry.longitude;
      _radarInfo.altitude_m = entry.altitude;

      // Angles of the reflector rotation and tilt motors.
      float rotMotorAngle = _pulseH->getRotMotorAngle();
      float tiltMotorAngle = _pulseH->getTiltMotorAngle();
      _radarGeoref.drive_angle_1_deg = rotMotorAngle;
      _radarGeoref.drive_angle_2_deg = tiltMotorAngle;

      // Rotation and tilt of the radar *beam* w.r.t. the pod's longitudinal axis.
      // Zero rotation means the beam points through the top of the pod and
      // positive rotation moves clockwise as viewed looking from the back
      // of the pod toward the front. Zero tilt means the beam points normal to
      // the longitudinal axis, and positive tilt means the beam points
      // forward.
      //
      // Beware of "rotation" and "tilt" terms here; the angles of the rotation
      // motor and tilt motor do not map directly to rotation_angle_deg and
      // tilt_deg! In HCR, the axis of the tilt motor is fixed w.r.t. the pod and
      // corresponds with the pod's INS pitch axis. The axis of the rotation
      // motor is moved by the tilt motor, and is only parallel to the pod's
      // longitudinal axis when the tilt motor angle is zero.
      _radarGeoref.rotation_angle_deg = rotMotorAngle;
      _radarGeoref.tilt_deg = ((2.0 * tiltMotorAngle) // x2 for reflection
              * cos(rotMotorAngle * DEG_TO_RAD));

      int nUnused = sizeof(_radarGeoref.unused) / sizeof(_radarGeoref.unused[0]);
      for (int i = 0; i < nUnused; i++) {
          _radarGeoref.unused[i] = IWRF_MISSING_FLOAT;
      }
      
      // Log unexpected time differences between georef packets
      uint64_t thisGeorefTime = entry.time3512;
      int64_t deltaMs = _lastGeorefTime ? thisGeorefTime - _lastGeorefTime : 0;
      if (deltaMs < 0) {
          QDateTime qLastTime = 
                  QDateTime::fromTime_t(_lastGeorefTime / 1000).addMSecs(_lastGeorefTime % 1000);
          ELOG << "Georef time went backward " << -deltaMs << " ms after " <<
                  qLastTime.toString("hh:mm:ss.zzz").toStdString();    
      } else if (deltaMs > 11) { // nominal 10 ms difference between 3512 
                                 // time tags is sometimes 9 or 11 ms.
          QDateTime qLastTime = 
                  QDateTime::fromTime_t(_lastGeorefTime / 1000).addMSecs(_lastGeorefTime % 1000);
          WLOG << "Georef time jumped forward " << deltaMs << " ms after " <<
                  qLastTime.toString("hh:mm:ss.zzz").toStdString();                  
      }
      
      _lastGeorefTime = thisGeorefTime;
      
      // Release our lock before calling methods which need it
      _insAccessLock.unlock();
      
      // compute elevation and azimuth
      _computeRadarAngles();
      
      // send the packet
      _sendIwrfGeorefPacket();
      
      // get the read lock again before testing _insDeque.empty()
      _insAccessLock.lockForRead();
  }
  
  // Log a warning if we wrote more than one georef packet and we are not on 
  // the first pulse.
  if (writeCount > 1) {
      WLOG << "Wrote " << writeCount << 
              " consecutive georef packets before pulse " << _pulseSeqNum;
  }
  
  // Release the lock before exiting
  _insAccessLock.unlock();
}

///////////////////////////////////////////////////////////////////
// compute the true azimuth, elevation, etc. from platform
// parameters using Testud's equations with their different
// definitions of rotation angle, etc.
//
// see Wen-Chau Lee's paper
// "Mapping of the Airborne Doppler Radar Data"

void IwrfExport::_computeRadarAngles()
  
{

  double R = (_radarGeoref.roll_deg + _rollCorr) * DEG_TO_RAD;
  double P = (_radarGeoref.pitch_deg + _pitchCorr) * DEG_TO_RAD;
  double H = (_radarGeoref.heading_deg + _headingCorr) * DEG_TO_RAD;
  double D = (_radarGeoref.drift_angle_deg + _driftCorr) * DEG_TO_RAD;
  double T = H + D;
  
  double sinP = sin(P);
  double cosP = cos(P);
  double sinD = sin(D);
  double cosD = cos(D);
  
  double theta_a = 
    (_radarGeoref.rotation_angle_deg + _rotationCorr) * DEG_TO_RAD;
  double tau_a =
    (_radarGeoref.tilt_deg + _tiltCorr) * DEG_TO_RAD;
  double sin_tau_a = sin(tau_a);
  double cos_tau_a = cos(tau_a);
  double sin_theta_rc = sin(theta_a + R); /* roll corrected rotation angle */
  double cos_theta_rc = cos(theta_a + R); /* roll corrected rotation angle */
  
  double xsubt = (cos_theta_rc * sinD * cos_tau_a * sinP
                  + cosD * sin_theta_rc * cos_tau_a
                  -sinD * cosP * sin_tau_a);
  
  double ysubt = (-cos_theta_rc * cosD * cos_tau_a * sinP
                  + sinD * sin_theta_rc * cos_tau_a
                  + cosP * cosD * sin_tau_a);
  
  double zsubt = (cosP * cos_tau_a * cos_theta_rc
                  + sinP * sin_tau_a);
  
  // _radarGeoref.rotation_angle_deg = atan2(xsubt, zsubt) * RAD_TO_DEG;
  // _radarGeoref.tilt_deg = asin(ysubt) * RAD_TO_DEG;
  double lambda_t = atan2(xsubt, ysubt);
  double azimuthRad = fmod(lambda_t + T, M_PI * 2.0);
  double elevationRad = asin(zsubt);
  
  _elevationDeg = elevationRad * RAD_TO_DEG;
  _azimuthDeg = azimuthRad * RAD_TO_DEG;
  
}

/////////////////////////////////////////////////////////////////////////////
// send the IWRF georef packet

int IwrfExport::_sendIwrfGeorefPacket()
{
    
  // set seq num in packet header

  _radarGeoref.packet.seq_num = _packetSeqNum++;

  // write the message
  bool closeSocket = false;

  if (_sock && _sock->writeBuffer(&_radarGeoref, sizeof(_radarGeoref))) {
    ELOG << "ERROR - IwrfExport::_sendIwrfGeorefPacket()";
    ELOG << "  Writing IWRF_RADAR_GEOREF";
    ELOG << "  " << _sock->getErrStr();
    closeSocket = true;
  }
  
  if (closeSocket) {
    _closeSocketToClient();
    return -1;
  }

  return 0;

}

//////////////////////////////////////////////////
// open server
// Returns 0 on success, -1 on failure

int IwrfExport::_openServer()

{

  if (_serverIsOpen) {
    return 0;
  }

  if (_server.openServer(_iwrfServerTcpPort)) {
    ELOG << "ERROR - IwrfExport::_openServer";
    ELOG << "  Cannot open server, port: " << _iwrfServerTcpPort;
    ELOG << "  " << _server.getErrStr();
    umsleep(1000);
    return -1;
  }

  DLOG << "====>> TCP server opened <<====";
  _serverIsOpen = true;
  _newClient = false;

  return 0;

}

//////////////////////////////////////////////////
// check we have an open socket to client
// Returns 0 on success, -1 on failure

int IwrfExport::_checkClient()

{

  if (_openServer()) {
    return -1;
  }

  // check status

  if (_sock && _sock->isOpen()) {
    _newClient = false;
    return 0;
  }

  // get a client if one is out there

  _sock = _server.getClient(0);

  if (_sock == NULL) {
    return -1;
  }
  _newClient = true;

  DLOG << "====>> Connected to client <<====";
  return 0;
  
}

//////////////////////////////////////////////////
// close socket to client

void IwrfExport::_closeSocketToClient()

{

  if (_sock == NULL) {
    return;
  }

  if (_sock->isOpen()) {
    _sock->close();
  }

  delete _sock;
  _sock = NULL;

}

//////////////////////////////////////////////////
// Accept incoming new C-MIGITS data

void IwrfExport::queueInsData(CmigitsFmq::MsgStruct data, int insNum) {

  // Hold a write lock until we return. This is safe because we make no calls
  // to self methods below here.

  QWriteLocker wLocker(&_insAccessLock);

  // Get the previous data, then store the new latest data for use in
  // assembling status XML
  CmigitsFmq::MsgStruct prevData;
  if (insNum == 1) {
      _ins1Count++;
      prevData = _latestIns1Data;
      _latestIns1Data = data;
  } else if (insNum == 2) {
      _ins2Count++;
      prevData = _latestIns2Data;
      _latestIns2Data = data;
  } else {
      ELOG << "BUG - Bad insNum " << insNum << " in queueInsData(). " <<
              "Expected 1 or 2!";
      abort();
  }
  
  // Log anything where INS latency is longer than current pulse latency
  struct timeval tvNow;
  gettimeofday(&tvNow, 0);
  uint64_t nowMs = 1000LL * tvNow.tv_sec + tvNow.tv_usec / 1000;
  int insLagMs = nowMs - data.time3512;
  uint64_t pulseMs = 1000LL * _timeSecs + _nanoSecs / 1000000;
  int pulseLagMs = nowMs - pulseMs;
  if (_timeSecs == 0) {
      pulseLagMs = 9999999;    // fake pulse lag if we have no pulse yet
  }
  if (insLagMs > pulseLagMs) {
      if (pulseLagMs < insLagMs) {
          WLOG << "INS data latency (" << insLagMs << 
                  " ms) > pulse latency (" << pulseLagMs << " ms)";
      }
  }
  
  // Log gaps in the INS data
  uint64_t lastTime = prevData.time3512;
  uint64_t thisTime = data.time3512;
  int64_t deltaMs = lastTime ? thisTime - lastTime : 0;
  QDateTime qLastTime = QDateTime::fromTime_t(lastTime / 1000).addMSecs(lastTime % 1000);
  if (deltaMs < 0) {
      WLOG << "INS time went backwards by " << -deltaMs << " ms after " <<
              qLastTime.toString("hh:mm:ss.zzz").toStdString();
  } else if (deltaMs > 11) {
      // Nominal time between 100 Hz data is 10 ms, but 1 ms resolution in 
      // time stamps means we sometimes see 9 or 11 ms. Anything over 11 ms 
      // is notable, though...
      WLOG << "INS data gap of " << deltaMs << " ms after " <<
              qLastTime.toString("hh:mm:ss.zzz").toStdString();
  }

  // Get a reference to our INS1 or INS2 deque
  std::deque<CmigitsFmq::MsgStruct> & insDeque =
          (insNum == 1) ? _ins1Deque : _ins2Deque;

  // If we have too many items in the deque, clear it now.
  if (insDeque.size() == 1000) {
      uint64_t earliest = insDeque.front().time3512;
      QDateTime qEarliest = QDateTime::fromTime_t(earliest / 1000).addMSecs(earliest % 1000);
      uint64_t latest = insDeque.back().time3512;
      QDateTime qLatest = QDateTime::fromTime_t(latest / 1000).addMSecs(latest % 1000);
      QDateTime qPulse = QDateTime::fromTime_t(pulseMs / 1000).addMSecs(pulseMs % 1000);
      ILOG << "clearing _ins" << insNum << "Deque because it's too big";
      ILOG << "Deque times: " << qEarliest.toString("hh:mm:ss.zzz").toStdString() <<
              "-" << qLatest.toString("hh:mm:ss.zzz").toStdString() <<
              ", pulse time " << qPulse.toString("hh:mm:ss.zzz").toStdString();
      insDeque.clear();
  }

  // Push the new item onto the deque (or replace the last item if its time
  // is the same as the incoming entry).
  if (! insDeque.empty() && lastTime == thisTime) {
      DLOG << "Overwriting INS entry for " << data.time3512;
      insDeque.back() = data;
  } else {
      insDeque.push_back(data);
  }
}

//////////////////////////////////////////////////
// Log status

void IwrfExport::_logStatus() {
  if (! _logAccessLock.tryLockForWrite(100)) {
      ELOG << "_logStatus(): unable to obtain lock";
      return;
  }

  ILOG << "new count for INS1: " << _ins1Count << ", INS2: " << _ins2Count;
  _hPulseCount = 0;
  _vPulseCount = 0;
  _ins1Count = 0;
  _ins2Count = 0;
  
  _logAccessLock.unlock();
}
