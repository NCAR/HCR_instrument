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
#include "StatusGrabber.h"
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

#include <QtCore>

LOGGING("IwrfExport")

///////////////////////////////////////////////////////////////////////////
IwrfExport::IwrfExport(const HcrDrxConfig& config, const StatusGrabber& monitor) :
        QThread(),
        _insAccessLock(QReadWriteLock::NonRecursive),
        _fmqAccessLock(QReadWriteLock::NonRecursive),
        _config(config),
        _monitor(monitor),
        _hmcMode(),
        _antennaMode(MotionControl::MODE_UNDEFINED),
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
        _lastGeorefTime(0),
        _polMode(IWRF_POL_MODE_NOT_SET),
        _xmitRcvMode(IWRF_XMIT_RCV_MODE_NOT_SET)
{

  // initialize
  _queueSize = _config.merge_queue_size();
  _iwrfServerTcpPort = _config.iwrf_server_tcp_port();

  // queues
  _qH = new CircBuffer<PulseData>(_queueSize);
  _qV = new CircBuffer<PulseData>(_queueSize);

  // received H and V data for a given pulse
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
  _tsProc.cal_type = IWRF_CAL_TYPE_NOT_SET;
  _tsProc.burst_range_offset_m = 0.0;
  //   _tsProc.burst_range_offset_m =
  //     _config.burst_sample_delay() * lightSpeedMps / 2.0;
  _tsProc.start_range_m = _config.range_to_gate0_m(); // center of gate 0 in meters
  _tsProc.pol_mode = IWRF_POL_MODE_NOT_SET;

  // these are variable, so can't be set to anything sensible here
  _tsProc.prt_usec = NAN;
  _tsProc.prt2_usec = NAN;
  _tsProc.pulse_width_us = NAN;
  _tsProc.gate_spacing_m = NAN;

  // initialize pulse header
  iwrf_pulse_header_init(_pulseHdr);

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
  _simAntennaAngles = _config.simulate_antenna_angles();
  _simNElev = _config.sim_n_elev();
  _simStartElev = _config.sim_start_elev();
  _simDeltaElev = _config.sim_delta_elev();
  _simAzRate = _config.sim_az_rate();
  _simElev = _simStartElev;
  _simAz = 0.0;
  _simVolNum = 0;
  _simSweepNum = 0;

  // IWRF EXPORT
  // server
  _serverIsOpen = false;
  _sock = NULL;
  _newClient = false;

  // output fmq
  _fmqPath = _config.iwrf_fmq_path();
  _fmqOpen = false;
  _firstFmqMessage = false;
  if (_config.export_iwrf_via_fmq()) {
    if (_openOutputFmq() == 0) {
      _fmqOpen = true;
      _firstFmqMessage = true;
      DLOG << "==>> Opened FMQ for time series: " << _fmqPath;
    } else {
      ELOG << "ERROR: Cannot initialize FMQ: " << _fmqPath;
      ELOG << "  Will open TCP server instead";
    }
  }

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
  // First terminate our run() method
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

    if (!_config.export_iwrf_via_fmq()) {
      // check that we have a client
      if (_checkClient()) {
        continue;
      }
    }

    // determine number of gates
    int nGates = _pulseH->getNGates();

    // should we send meta-data?
    bool sendMeta = false;
    if (_newClient || _firstFmqMessage) {
      sendMeta = true;
      metaDataInitialized = false;
      _firstFmqMessage = false;
    }
    if (nGates != _nGates) {
      sendMeta = true;
      _nGates = nGates;
    }
    if (_monitor.pmc730Status().hmcMode() != _hmcMode) {
      sendMeta = true;
      _hmcMode = _monitor.pmc730Status().hmcMode();
    }
    if (_pulseH->getPolMode() != _polMode || _pulseH->getXmitRcvMode() != _xmitRcvMode) {
      sendMeta = true;
      _polMode =_pulseH->getPolMode();
      _xmitRcvMode = _pulseH->getXmitRcvMode();
    }
    if (_monitor.motionControlStatus().antennaMode != _antennaMode) {
      sendMeta = true;
      _antennaMode = _monitor.motionControlStatus().antennaMode;
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
  _hPulseCount++;
  return _qH->write(val);
}

/////////////////////////////////////////////////////////////////////////////
// write data for next V pulse
// called by HcrDrxPub threads
// Returns pulse data object for recycling
PulseData *IwrfExport::writePulseV(PulseData *val)
{
  _vPulseCount++;
  return _qV->write(val);
}

/////////////////////////////////////////////////////////////////////////////
// read the next H data
void IwrfExport::_readNextH()
{
  // Our old pulse goes back for reuse
  PulseData *replacementElement = _pulseH;
  _pulseH = NULL;

  // Loop until we get a new pulse from the circular buffer
  for (int ntries = 0; _pulseH == NULL; ntries++) {
    if (ntries != 0) {
      usleep(50);
    }
    _pulseH = _qH->read(replacementElement);
  }
}

/////////////////////////////////////////////////////////////////////////////
// read the next V data
void IwrfExport::_readNextV()
{
  // Our old pulse goes back for reuse
  PulseData *replacementElement = _pulseV;
  _pulseV = NULL;

  // Loop until we get a new pulse from the circular buffer
  for (int ntries = 0; _pulseV == NULL; ntries++) {
      if (ntries != 0) {
          usleep(50);
      }
      _pulseV = _qV->read(replacementElement);
  }
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
    case HmcMode::TRANSMIT:
    case HmcMode::TRANSMIT_ATTENUATED:
        _tsProc.xmit_rcv_mode = _xmitRcvMode;
        _tsProc.pol_mode = _polMode;
        _tsProc.cal_type = IWRF_CAL_TYPE_NONE;
        break;
    case HmcMode::BENCH_TEST:
    case HmcMode::V_HV_ISOL_NOISE:
        _tsProc.xmit_rcv_mode = IWRF_V_ONLY_FIXED_HV;
        _tsProc.pol_mode = IWRF_POL_MODE_V;
        _tsProc.cal_type = IWRF_CAL_TYPE_NONE;
        break;
    case HmcMode::NOISE_SOURCE_CAL:
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

  // assemble the calibration struct
  iwrf_calibration_t calibStruct = _calib.getStruct();
  calibStruct.packet.seq_num = _packetSeqNum++;
  calibStruct.packet.time_secs_utc = _timeSecs;
  calibStruct.packet.time_nano_secs = _nanoSecs;

  // Assemble our iwrf_scan_segment_t describing current scanning/pointing
  _assembleIwrfScanSegment();


  if (_fmqOpen) {

    // Write the IWRF packets to our FMQ
    _outputMsg.addPart(IWRF_RADAR_INFO_ID, sizeof(_radarInfo), &_radarInfo);
    _outputMsg.addPart(IWRF_TS_PROCESSING_ID, sizeof(_tsProc), &_tsProc);
    _outputMsg.addPart(IWRF_CALIBRATION_ID, sizeof(calibStruct), &calibStruct);
    _outputMsg.addPart(IWRF_SCAN_SEGMENT_ID, sizeof(_scanSegment), &_scanSegment);

  } else {

    // publish individual messages for each struct to our socket
    bool closeSocket = false;

    if (_sock && _sock->writeBuffer(&_radarInfo, sizeof(_radarInfo))) {
      ELOG << "_sendIwrfMetaData() writing IWRF_RADAR_INFO: " << _sock->getErrStr();
      closeSocket = true;
    } else if (_sock && _sock->writeBuffer(&_tsProc, sizeof(_tsProc))) {
      ELOG << "_sendIwrfMetaData() writing IWRF_TS_PROCESSING: " << _sock->getErrStr();
      closeSocket = true;
    } else if (_sock && _sock->writeBuffer(&calibStruct, sizeof(calibStruct))) {
      ELOG << "_sendIwrfMetaData() writing IWRF_CALIBRATION: " << _sock->getErrStr();
      closeSocket = true;
    } else if (_sock && _sock->writeBuffer(&_scanSegment, sizeof(_scanSegment))) {
      ELOG << "_sendIwrfMetaData() writing IWRF_SCAN_SEGMENT: " << _sock->getErrStr();
      closeSocket = true;
    }

    if (closeSocket) {
      _closeSocketToClient();
      return -1;
    }

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
  memcpy(_iq, _pulseH->getIq(), _pulseH->getNGates() * sizeof(IQData));

  memcpy(_iq + _nGates, _pulseV->getIq(), _pulseV->getNGates() * sizeof(IQData));

  // pulse header
  _pulseHdr.packet.len_bytes = _pulseMsgLen;
  _pulseHdr.packet.seq_num = _packetSeqNum++;
  _pulseHdr.packet.time_secs_utc = _timeSecs;
  _pulseHdr.packet.time_nano_secs = _nanoSecs;

  _pulseHdr.pulse_seq_num = _pulseSeqNum;
  _pulseHdr.prt = _pulseH->getCurrentPrt();

  _pulseHdr.n_gates = _nGates;
  _pulseHdr.n_channels = NCHANNELS;
  _pulseHdr.iq_encoding = _pulseH->getEncoding();
  // Pulse transmit polarization should be the same in both the H and V
  // receiver data. We just get it from _pulseH receiver data.
  _pulseHdr.hv_flag =
          (_pulseH->getXmitPolarization() == PulseData::XMIT_POL_HORIZONTAL) ? 1 : 0;
  _pulseHdr.phase_cohered = true;
  _pulseHdr.n_data = _nGates * NCHANNELS * 2;
  _pulseHdr.iq_offset[0] = 0;
  _pulseHdr.iq_offset[1] = _nGates * 2;
  _pulseHdr.iq_offset[2] = _nGates * 4;
  _pulseHdr.scale = _pulseH->getScale();
  _pulseHdr.offset = _pulseH->getOffset();
  _pulseHdr.n_gates_burst = 0;
  _pulseHdr.start_range_m = _tsProc.start_range_m;
  const double SpeedOfLight = 2.99792458e8; // m/s
  _pulseHdr.gate_spacing_m = _pulseH->getSampleWidth() * SpeedOfLight / 2.0;
  _pulseHdr.pulse_width_us = _pulseH->getTxPulseWidth() * 1.0e6;

  _tsProc.gate_spacing_m = _pulseHdr.gate_spacing_m;
  _tsProc.pulse_width_us =_pulseHdr.pulse_width_us;
  _tsProc.prt_usec = _pulseH->getPrt1() * 1.0e6;
  _tsProc.prt2_usec = _pulseH->getPrt2() * 1.0e6;

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

  if (_fmqOpen) {

    _outputMsg.addPart(IWRF_PULSE_HEADER_ID, _pulseMsgLen, _pulseBuf);
    _writeToOutputFmq();

  } else {

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

  }

  return 0;

}

/////////////////////////////////////////////////////////////////////////////
// allocate pulse buffer
void IwrfExport::_allocPulseBuf()
{

  _pulseMsgLen =
    sizeof(iwrf_pulse_header) + (_nGates * NCHANNELS * sizeof(IQData));

  if (_pulseMsgLen > _pulseBufLen) {

    if (_pulseBuf) {
      delete[] _pulseBuf;
    }

    _pulseBufLen = _pulseMsgLen;
    _pulseBuf = new char[_pulseBufLen];
    _iq = reinterpret_cast<IQData *>(_pulseBuf + sizeof(iwrf_pulse_header));

  }

  memset(_iq, 0, _nGates * NCHANNELS * sizeof(IQData));

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

  static const double HPA_PER_PSI = 68.94785;
  xml += TaXml::writeDouble
    ("PvForePressure", 2, pmc730Status.pvForePressure() / HPA_PER_PSI);

  xml += TaXml::writeDouble
    ("PvAftPressure", 2, pmc730Status.pvAftPressure() / HPA_PER_PSI);

  xml += TaXml::writeDouble
    ("ApsLowSidePressure", 2, pmc730Status.apsLowSidePressure() / HPA_PER_PSI);

  xml += TaXml::writeDouble
    ("ApsHighSidePressure", 2, pmc730Status.apsHighSidePressure() / HPA_PER_PSI);

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

    // serial number
    xml += TaXml::writeInt("CmigitsSerialNum", 2, insData.insSerialNum);

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

  // differences between INSs
  double insDeltaTime = fabs(_latestIns1Data.time3500 - _latestIns2Data.time3500);
  if (insDeltaTime > 9999) {
    insDeltaTime = 9999;
  }
  double insDeltaLatitude = fabs(_latestIns1Data.latitude - _latestIns2Data.latitude);
  double insDeltaLongitude = fabs(_latestIns1Data.longitude - _latestIns2Data.longitude);
  double insDeltaAltitude = fabs(_latestIns1Data.altitude - _latestIns2Data.altitude);
  double insDeltaPitch = fabs(_latestIns1Data.pitch - _latestIns2Data.pitch);
  double insDeltaRoll = fabs(_latestIns1Data.roll - _latestIns2Data.roll);
  double insDeltaHeading = fabs(_latestIns1Data.heading - _latestIns2Data.heading);

  xml += TaXml::writeStartTag("HcrInsDelta", 1);
  xml += TaXml::writeDouble("CmigitsDeltaTime", 2, insDeltaTime);
  xml += TaXml::writeDouble("CmigitsDeltaLatitude", 2, insDeltaLatitude);
  xml += TaXml::writeDouble("CmigitsDeltaLongitude", 2, insDeltaLongitude);
  xml += TaXml::writeDouble("CmigitsDeltaAltitude", 2, insDeltaAltitude);
  xml += TaXml::writeDouble("CmigitsDeltaPitch", 2, insDeltaPitch);
  xml += TaXml::writeDouble("CmigitsDeltaRoll", 2, insDeltaRoll);
  xml += TaXml::writeDouble("CmigitsDeltaHeading", 2, insDeltaHeading);
  xml += TaXml::writeEndTag("HcrInsDelta", 1);

  ////////////////////////////////////////////////
  // close
  xml += TaXml::writeEndTag("HcrStatus", 0);

  return xml;

}

/////////////////////////////////////////////////////////////////////////////
// send out the IWRF status packet
int IwrfExport::_sendIwrfStatusXmlPacket()

{

  if (_fmqOpen) {

    _outputMsg.addPart(IWRF_STATUS_XML_ID, _statusMsgLen, _statusBuf);

  } else {

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
  // Get the read lock for INS data
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
  // number small, since tests using 1000 us caused system instability with
  // Pentek data sync errors and DMA overruns.
  static const uint32_t SLEEP_US = 100;

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
              }
              waitForIns1 = false;
          }
          // Stop waiting for INS2 if we got something
          if (waitForIns2 && ! _ins2Deque.empty()) {
              // We were waiting, but now have something
              if (total_wait_us > 30000) {
                  ILOG << "Waited " << 0.001 * total_wait_us <<
                          " ms for INS2 data";
              }
              waitForIns2 = false;
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
  for (writeCount = 0; true; writeCount++) {
      // Find the INS deque with the earliest entry time
      // Get the number of the INS (1 or 2) with the earliest deque entry
      int insWithEarliest = 0;

      if (_ins1Deque.empty() && _ins2Deque.empty()) {
          // No entries available, so we're done
          _insAccessLock.unlock();  // drop read lock before exiting the loop
          break;
      } else if (! _ins1Deque.empty() && ! _ins2Deque.empty()) {
          // Both deques have something, find the the earliest entry between
          // them
          uint64_t ins1Time = _ins1Deque.front().time3512;
          uint64_t ins2Time = _ins2Deque.front().time3512;
          if (ins1Time <= ins2Time) {
              insWithEarliest = 1;
          } else {
              insWithEarliest = 2;
          }
      } else if (! _ins1Deque.empty()) {
          insWithEarliest = 1;
      } else {
          insWithEarliest = 2;
      }

      // Get a reference to the deque with the earliest entry and get a copy of
      // the actual entry
      std::deque<CmigitsFmq::MsgStruct> & insDeque =
              (insWithEarliest == 1) ? _ins1Deque : _ins2Deque;
      CmigitsFmq::MsgStruct earliest = insDeque.front();

      // If the earliest entry is later than the current pulse time, we're
      // done here.
      if (earliest.time3512 > pulseTime) {
          _insAccessLock.unlock();  // drop read lock before exiting the loop
          break;
      }

      // We're going to write a packet for this entry, so remove it from its
      // source deque. Once we've popped the entry, we don't need read or write
      // access to the INS deque-s for a bit.
      _insAccessLock.unlock();  // drop read lock
      _insAccessLock.lockForWrite();
      insDeque.pop_front();
      _insAccessLock.unlock();  // drop write lock

      // Initialize the georef packet
      iwrf_platform_georef_init(_radarGeoref);

      // Time tag the georef packet with the C-MIGITS 3512 message time
      if (fmod(earliest.time3512, 1000) / 10 == 0) {
          DLOG << "New georef tagged " << fmod(earliest.time3512 / 1000, 60) <<
                  "." << std::setw(3) << std::setfill('0') <<
                  fmod(earliest.time3512, 1000) << " for pulse tagged " <<
                  _timeSecs % 60 << std::setw(3) << std::setfill('0') <<
                  _nanoSecs / 1000000;
      }
      _radarGeoref.packet.time_secs_utc = earliest.time3512 / 1000;
      _radarGeoref.packet.time_nano_secs = fmod(earliest.time3512, 1000) * 1000000;

      // The unit_num member is kind of funky: unit_num = 0 indicates that this
      // is the "primary" INS (i.e., the one used by MotionControlDaemon), and
      // unit_num = 1 indicates the other INS.
      _radarGeoref.unit_num =
              (_monitor.motionControlStatus().insInUse == insWithEarliest) ? 0 : 1;

      // The unit_id member should be a consistent unique identifier for the
      // INS, e.g. a serial number
      _radarGeoref.unit_id = earliest.insSerialNum;
      _radarGeoref.altitude_agl_km = IWRF_MISSING_FLOAT;
      _radarGeoref.altitude_msl_km = earliest.altitude * 0.001; // m -> km
      _radarGeoref.drift_angle_deg = CmigitsFmq::GetEstimatedDriftAngle(earliest);
      _radarGeoref.ew_horiz_wind_mps = IWRF_MISSING_FLOAT;
      _radarGeoref.ew_velocity_mps = earliest.velEast;
      _radarGeoref.heading_deg = earliest.heading;
      _radarGeoref.heading_rate_dps = IWRF_MISSING_FLOAT;
      _radarGeoref.latitude = earliest.latitude;
      _radarGeoref.longitude = earliest.longitude;
      _radarGeoref.ns_horiz_wind_mps = IWRF_MISSING_FLOAT;
      _radarGeoref.ns_velocity_mps = earliest.velNorth;
      _radarGeoref.pitch_deg = earliest.pitch;
      _radarGeoref.pitch_rate_dps = IWRF_MISSING_FLOAT;
      _radarGeoref.roll_deg = earliest.roll;
      _radarGeoref.vert_velocity_mps = earliest.velUp;
      _radarGeoref.vert_wind_mps = IWRF_MISSING_FLOAT;

      _radarInfo.latitude_deg = earliest.latitude;
      _radarInfo.longitude_deg = earliest.longitude;
      _radarInfo.altitude_m = earliest.altitude;

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
      uint64_t thisGeorefTime = earliest.time3512;
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

      // compute elevation and azimuth
      _computeRadarAngles();

      // send the packet
      _sendIwrfGeorefPacket();

      // get the read lock before looking at the INS deque-s again
      _insAccessLock.lockForRead();
  }

  // Log a warning if we wrote more than one georef packet per INS and we are
  // not on the first pulse.
  if (writeCount > 2) {
      WLOG << "Wrote " << writeCount <<
              " consecutive georef packets before pulse " << _pulseSeqNum;
  }
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
  if (_fmqOpen) {

    _outputMsg.addPart(IWRF_PLATFORM_GEOREF_ID,
                       sizeof(_radarGeoref), &_radarGeoref);

  } else {

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
          WLOG << "INS" << insNum << " data latency (" << insLagMs <<
                  " ms) > pulse latency (" << pulseLagMs << " ms)";
      }
  }

  // Log gaps in the INS data
  uint64_t lastTime = prevData.time3512;
  uint64_t thisTime = data.time3512;
  int64_t deltaMs = lastTime ? thisTime - lastTime : 0;
  QDateTime qLastTime = QDateTime::fromTime_t(lastTime / 1000).addMSecs(lastTime % 1000);
  if (deltaMs < 0) {
      WLOG << "INS" << insNum << " time went backwards by " << -deltaMs <<
              " ms after " << qLastTime.toString("hh:mm:ss.zzz").toStdString();
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
      DLOG << "Overwriting INS" << insNum << " entry for " << data.time3512;
      insDeque.back() = data;
  } else {
      insDeque.push_back(data);
  }
}

//////////////////////////////////////////////////
// Log status
void IwrfExport::_logStatus() {
  ILOG << "new count for INS1: " << _ins1Count << ", INS2: " << _ins2Count;
  _hPulseCount = 0;
  _vPulseCount = 0;
  _ins1Count = 0;
  _ins2Count = 0;
}

///////////////////////////////////////
// open the output FMQ
// returns 0 on success, -1 on failure
int IwrfExport::_openOutputFmq()

{

  // initialize the output FMQ
  if (_outputFmq.initReadWrite
      (_fmqPath.c_str(), "dowdrx",
       false, // set debug?
       Fmq::END, // start position
       false,    // compression
       _config.iwrf_fmq_nslots(),
       _config.iwrf_fmq_bufsize())) {
    ELOG << "ERROR: IwrfExport::_openOutputFmq()";
    ELOG << "  Cannot initialize FMQ: " << _fmqPath;
    ELOG << "  nSlots: " << _config.iwrf_fmq_nslots();
    ELOG << "  nBytes: " << _config.iwrf_fmq_bufsize();
    ELOG << _outputFmq.getErrStr();
    return -1;
  }
  _outputFmq.setSingleWriter();
  if (_config.iwrf_fmq_report_interval() > 0) {
    QWriteLocker wLocker(&_fmqAccessLock);
    _outputFmq.setRegisterWithDmap(true, _config.iwrf_fmq_report_interval());
  }

  // initialize message
  _outputMsg.clearAll();
  _outputMsg.setType(0);

  return 0;

}

///////////////////////////////////////
// write to output FMQ if ready
// returns 0 on success, -1 on failure
int IwrfExport::_writeToOutputFmq(bool force)

{

  // if the message is large enough, write to the FMQ
  uint nParts = _outputMsg.getNParts();
  // DLOG << "==>> WriteToOutputFmq, nparts: " << nParts;
  if (!force && nParts < _config.iwrf_fmq_npackets_per_message()) {
    return 0;
  }

  PMU_auto_register("writeToFmq");

  void *buf = _outputMsg.assemble();
  int len = _outputMsg.lengthAssembled();
  QWriteLocker wLocker(&_fmqAccessLock);
  if (_outputFmq.writeMsg(0, 0, buf, len)) {
    ELOG << "ERROR - IwrfExport";
    ELOG << "  Cannot write FMQ: " << _fmqPath;
    _outputMsg.clearParts();
    return -1;
  }

  _outputMsg.clearParts();

  return 0;

}

///////////////////////////////////////
// Assemble our iwrf_scan_segment_t packet with current scanning/pointing mode
void IwrfExport::_assembleIwrfScanSegment()

{
    // Start with a clean iwrf_scan_segment_t struct
    iwrf_scan_segment_init(_scanSegment);

    _scanSegment.packet.seq_num = _packetSeqNum++;
    _scanSegment.packet.time_secs_utc = _timeSecs;
    _scanSegment.packet.time_nano_secs = _nanoSecs;

    // Populate _scanSegment using current information from the MotionControl
    // daemon
    auto scanStatus = _monitor.motionControlStatus();
    switch (scanStatus.antennaMode) {
    case MotionControl::MODE_POINTING:
        // Build an iwrf_scan_segment for fixed pointing
        // We abuse the definitions a bit, mapping our rotation fixed angle
        // into the az_manual member and our beam tilt (0.0 as a rule) into the
        // el_manual member.
        _scanSegment.scan_mode = IWRF_SCAN_MODE_POINTING;
        _scanSegment.az_manual = scanStatus.fixedPointingAngle;
        _scanSegment.el_manual = scanStatus.scanBeamTilt;
        break;
    case MotionControl::MODE_SCANNING:
        // Build an iwrf_scan_segment for scanning
        // We map our rotation CCW limit into the left_limit member,
        // rotation CW limit into the right_limit member, and scan beam tilt
        // (0.0 as a rule) into the current_fixed_angle member.
        _scanSegment.scan_mode = IWRF_SCAN_MODE_SECTOR;
        _scanSegment.left_limit = scanStatus.scanCcwLimit;
        _scanSegment.right_limit = scanStatus.scanCwLimit;
        _scanSegment.current_fixed_angle = scanStatus.scanBeamTilt;
        break;
    default:
        ELOG << "Unhandled MotionControl::AntennaMode " <<
                scanStatus.antennaMode << " in _sendIwrfScanSegment!";
        _scanSegment.scan_mode = IWRF_SCAN_MODE_NOT_SET;
//        ELOG << "Raising SIGINT to exit the program";
//        raise(SIGINT);
    }

}
