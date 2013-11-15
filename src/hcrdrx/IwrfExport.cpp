#include "IwrfExport.h"
#include <logx/Logging.h>
#include <sys/timeb.h>
#include <cmath>
#include <cstdlib>
#include <cstring>
#include <unistd.h>
#include <iostream>
#include <iomanip>
#include <radar/iwrf_functions.hh>
#include <radar/IwrfCalib.hh>
#include <toolsa/pmu.h>
#include <toolsa/uusleep.h>
#include <toolsa/TaXml.hh>
#include <toolsa/toolsa_macros.h>

using namespace boost::posix_time;
using namespace std;

LOGGING("IwrfExport")

///////////////////////////////////////////////////////////////////////////

IwrfExport::IwrfExport(const HcrDrxConfig& config, const HcrMonitor& monitor) :
        QThread(),
        _config(config),
        _monitor(monitor),
        _cmigitsShm(false),
        _lastCmigits3512Time(0),
        _hmcMode(HcrPmc730::HMC_UNUSED_3)
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

}

/////////////////////////////////////////////////////////////////////////////
IwrfExport::~IwrfExport()

{

  _closeSocketToClient();

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
  // Time of the last status packet we generated
  time_t lastStatusTime = 0;
  
  // Interval between generating status packets, in seconds
  const int StatusInterval = 2;
  
  // Since we have no event loop,
  // allow thread termination via the terminate() method.

  setTerminationEnabled(true);
  
  // start the loop

  bool metaDataInitialized = false;
  while (true) {

    // read in next pulse

    _readNextPulse();

    // determine number of gates

    int nGates = _pulseH->getNGates();
    //     if (nGates < _pulseV->getNGates()) {
    //       nGates = _pulseV->getNGates();
    //     }
    
    // check that we have a client
    
    if (_checkClient()) {
      continue;
    }

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

    if (sendMeta) {
      _sendIwrfMetaData();
      metaDataInitialized = true;
    }
    
    // If C-MIGITS data are new, assemble a packet containing that information.
    // Test against the time of the C-MIGITS 3512 message, since that one
    // goes out at the highest rate (100 Hz).
    if (_assembleIwrfGeorefPacket()) {
        _sendIwrfGeorefPacket();
    }

    // assemble and send out the IWRF pulse packet
    
    if (metaDataInitialized) {
      _assembleIwrfPulsePacket();
      _sendIwrfPulsePacket();
    }
    
    // If it's been long enough since our last status packet, generate a new
    // one now.

    if (metaDataInitialized) {
      time_t now = time(0);
      if ((now - lastStatusTime) >= StatusInterval) {
        _assembleStatusPacket();
        _sendIwrfStatusXmlPacket();
        lastStatusTime = now;
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
  //   _readNextB();
  
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
    cerr << "Missing pulses - nmiss, prevNum, thisNum: "
         << nMissing << ", "
         << _prevPulseSeqNum << ", "
         << _pulseSeqNum << endl;
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
  return _qH->write(val);
}

/////////////////////////////////////////////////////////////////////////////
// write data for next V pulse
// called by HcrDrxPub threads
// Returns pulse data object for recycling

PulseData *IwrfExport::writePulseV(PulseData *val)
{
  return _qV->write(val);
}

/////////////////////////////////////////////////////////////////////////////
// read the next H data

void IwrfExport::_readNextH()
{
  
  PulseData *tmp = NULL;
  while (tmp == NULL) {
    tmp = _qH->read(_pulseH);
    if (tmp == NULL) {
      usleep(50);
    }
  }
  _pulseH = tmp;

}

/////////////////////////////////////////////////////////////////////////////
// read the next V data

void IwrfExport::_readNextV()
{

  PulseData *tmp = NULL;
  while (tmp == NULL) {
    tmp = _qV->read(_pulseV);
    if (tmp == NULL) {
      usleep(50);
    }
  }
  _pulseV = tmp;

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
    case HcrPmc730::HMC_TX_V_RX_HV:
    case HcrPmc730::HMC_CORNER_REFLECTOR_CAL:
    case HcrPmc730::HMC_BENCH_TEST:
        _tsProc.xmit_rcv_mode = IWRF_V_ONLY_FIXED_HV;
        _tsProc.pol_mode = IWRF_POL_MODE_V;
        _tsProc.cal_type = IWRF_CAL_TYPE_NONE;
        break;
    case HcrPmc730::HMC_TX_H_RX_HV:
        _tsProc.xmit_rcv_mode = IWRF_H_ONLY_FIXED_HV;
        _tsProc.pol_mode = IWRF_POL_MODE_H;
        _tsProc.cal_type = IWRF_CAL_TYPE_NONE;
        break;
    case HcrPmc730::HMC_TX_HV_RX_HV:
        _tsProc.xmit_rcv_mode = IWRF_ALT_HV_FIXED_HV;
        _tsProc.pol_mode = IWRF_POL_MODE_HV_ALT;
        break;
    case HcrPmc730::HMC_NOISE_SOURCE_CAL:
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

  if (_sock && _sock->writeBuffer(&_radarInfo, sizeof(_radarInfo))) {
    cerr << "ERROR - IwrfExport::_sendIwrfMetaData()" << endl;
    cerr << "  Writing IWRF_RADAR_INFO" << endl;
    cerr << "  " << _sock->getErrStr() << endl;
    _closeSocketToClient();
    return -1;
  }
  
  if (_sock && _sock->writeBuffer(&_tsProc, sizeof(_tsProc))) {
    cerr << "ERROR - IwrfExport::_sendIwrfMetaData()" << endl;
    cerr << "  Writing IWRF_TS_PROCESSING" << endl;
    cerr << "  " << _sock->getErrStr() << endl;
    _closeSocketToClient();
    return -1;
  }
  
  if (_sock && _sock->writeBuffer(&calibStruct, sizeof(calibStruct))) {
    cerr << "ERROR - IwrfExport::_sendIwrfMetaData()" << endl;
    cerr << "  Writing IWRF_CALIBRATION" << endl;
    cerr << "  " << _sock->getErrStr() << endl;
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
  _pulseHdr.hv_flag = 1;
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

  if (_sock && _sock->writeBuffer(_pulseBuf, _pulseMsgLen)) {
    cerr << "ERROR - IwrfExport::_sendIwrfPulsePacket()" << endl;
    cerr << "  Writing pulse packet" << endl;
    cerr << "  " << _sock->getErrStr() << endl;
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

  // floats

  xml += TaXml::writeDouble
    ("DetectedRfPower", 2, pmc730Status.detectedRfPower());

  xml += TaXml::writeDouble
    ("PvForePressure", 2, pmc730Status.pvForePressure());

  xml += TaXml::writeDouble
    ("PvAftPressure", 2, pmc730Status.pvAftPressure());

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
    ("CmigitsTemp", 2, pmc730Status.cmigitsTemp());

  xml += TaXml::writeDouble
    ("TailconeTemp", 2, pmc730Status.tailconeTemp());

  xml += TaXml::writeDouble
    ("PsVoltage", 2, pmc730Status.psVoltage());

  // booleans

  xml += TaXml::writeBoolean
    ("NoiseSourceSelected", 2, pmc730Status.noiseSourceSelected());

  xml += TaXml::writeBoolean
    ("TerminationSelected", 2, pmc730Status.terminationSelected());

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
  
  xml += TaXml::writeInt
    ("EmsErrorCount", 2, pmc730Status.emsErrorCount());

  xml += TaXml::writeBoolean
    ("EmsError1", 2, pmc730Status.emsError1());

  xml += TaXml::writeBoolean
    ("EmsError2", 2, pmc730Status.emsError2());

  xml += TaXml::writeBoolean
    ("EmsError3", 2, pmc730Status.emsError3());

  xml += TaXml::writeBoolean
    ("EmsError4Or5", 2, pmc730Status.emsError4Or5());

  xml += TaXml::writeBoolean
    ("EmsError16Or7", 2, pmc730Status.emsError6Or7());

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

  // Next is data from the C-MIGITS
  const CmigitsStatus cmigitsStatus = _monitor.cmigitsStatus();

  // C-MIGITS status info (latest 3500 message from C-MIGITS)
  double statusTime = 0.0;      // seconds since 1970-01-01 00:00:00 UTC
  uint16_t currentMode = 0;     // see info for C-MIGITS 3500 message
  bool insAvailable = false;
  bool gpsAvailable = false;
  bool doingCoarseAlignment = false;
  uint16_t nSats = 0;
  uint16_t positionFOM = 0;     // see info for C-MIGITS 3500 message
  uint16_t velocityFOM = 0;     // see info for C-MIGITS 3500 message
  uint16_t headingFOM = 0;      // see info for C-MIGITS 3500 message
  uint16_t timeFOM = 0;         // see info for C-MIGITS 3500 message
  double expectedHPosError = 0.0;      // m
  double expectedVPosError = 0.0;      // m
  double expectedVelocityError = 0.0;  // m/s

  cmigitsStatus.msg3500Data(statusTime, currentMode, insAvailable, gpsAvailable,
          doingCoarseAlignment, nSats, positionFOM, velocityFOM, headingFOM, 
          timeFOM, expectedHPosError, expectedVPosError, expectedVelocityError);

  xml += TaXml::writeUtime("Cmigits3500Time", 2, time_t(statusTime));
  xml += TaXml::writeInt("Cmigits3500CurrentMode", 2, currentMode);
  xml += TaXml::writeBoolean("Cmigits3500InsAvailable", 2, insAvailable);
  xml += TaXml::writeBoolean("Cmigits3500GpsAvailable", 2, gpsAvailable);
  xml += TaXml::writeInt("Cmigits3500NSats", 2, nSats);
  xml += TaXml::writeInt("Cmigits3500PositionFOM", 2, positionFOM);
  xml += TaXml::writeInt("Cmigits3500VelocityFOM", 2, velocityFOM);
  xml += TaXml::writeInt("Cmigits3500HeadingFOM", 2, headingFOM);
  xml += TaXml::writeInt("Cmigits3500TimeFOM", 2, timeFOM);
  xml += TaXml::writeDouble("Cmigits3500HPosError", 2, expectedHPosError);
  xml += TaXml::writeDouble("Cmigits3500VPosError", 2, expectedVPosError);
  xml += TaXml::writeDouble("Cmigits3500VelocityError", 2, expectedVelocityError);

  // current position/velocity (latest 3501 message from C-MIGITS)
  double navSolutionTime = 0.0; // seconds since 1970-01-01 00:00:00 UTC
  double latitude = 0.0;         // deg
  double longitude = 0.0;        // deg
  double altitude = 0.0;         // m above MSL
  double velNorth = 0.0;         // m/s
  double velEast = 0.0;          // m/s
  double velUp = 0.0;            // m/s

  cmigitsStatus.msg3501Data(navSolutionTime, latitude, longitude, altitude,
          velNorth, velEast, velUp);

  xml += TaXml::writeUtime("Cmigits3501Time", 2, time_t(navSolutionTime));
  xml += TaXml::writeDouble("Cmigits3501Latitude", 2, latitude);
  xml += TaXml::writeDouble("Cmigits3501Longitude", 2, longitude);
  xml += TaXml::writeDouble("Cmigits3501Altitude", 2, altitude);
  xml += TaXml::writeDouble("Cmigits3501VelNorth", 2, velNorth);
  xml += TaXml::writeDouble("Cmigits3501VelEast", 2, velEast);
  xml += TaXml::writeDouble("Cmigits3501VelUp", 2, velUp);

  // current attitude (latest 3512 message from C-MIGITS)
  double attitudeTime = 0.0;    // seconds since 1970-01-01 00:00:00 UTC
  double pitch = 0.0;            // deg
  double roll = 0.0;             // deg
  double heading = 0.0;          // deg clockwise from true north
  
  cmigitsStatus.msg3512Data(attitudeTime, pitch, roll, heading);

  xml += TaXml::writeUtime("Cmigits3512Time", 2, time_t(attitudeTime));
  xml += TaXml::writeDouble("Cmigits3512Pitch", 2, pitch);
  xml += TaXml::writeDouble("Cmigits3512Roll", 2, roll);
  xml += TaXml::writeDouble("Cmigits3512Heading", 2, heading);

  // end receive status

  xml += TaXml::writeEndTag("HcrReceiverStatus", 1);

  ///////////////////////////////////////////////////////
  // HCR C-MIGITS block

  xml += TaXml::writeStartTag("HcrCmigitsData", 1);

  // end C-MIGITS data

  xml += TaXml::writeEndTag("CmigitsData", 1);

  ////////////////////////////////////////////////
  // close

  xml += TaXml::writeEndTag("HcrStatus", 0);

  return xml;

}

/////////////////////////////////////////////////////////////////////////////
// send out the IWRF status packet

int IwrfExport::_sendIwrfStatusXmlPacket()

{

  if (_sock && _sock->writeBuffer(_statusBuf, _statusMsgLen)) {
    cerr << "ERROR - IwrfExport::_sendIwrfStatusXmlPacket()" << endl;
    cerr << "  Writing status xml packet" << endl;
    cerr << "  " << _sock->getErrStr() << endl;
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
// Assemble IWRF georef packet if we have new georef data available from
// the C-MIGITS. Return true iff we create a new georef packet.
bool IwrfExport::_assembleIwrfGeorefPacket() {
  // The 3512 message comes out at 100 Hz, so use we its time to determine if
  // new georef data are available.
  uint64_t time3512 = _cmigitsShm.getLatest3512Time();

  if (time3512 != _lastCmigits3512Time) {
    // Get data from the latest 3512 message, which contains attitude.
    double pitch, roll, heading;
    _cmigitsShm.getLatest3512Data(time3512, pitch, roll, heading);

    // Get data from the latest 3501 message, which contains location and
    // velocity.
    uint64_t time3501;
    double lat, lon, alt, velNorth, velEast, velUp;
    _cmigitsShm.getLatest3501Data(time3501, lat, lon, alt, velNorth, velEast, velUp);

    iwrf_platform_georef_init(_radarGeoref);

    _radarGeoref.altitude_agl_km = IWRF_MISSING_FLOAT;
    _radarGeoref.altitude_msl_km = alt * 0.001; // m -> km
    _radarGeoref.drift_angle_deg = _cmigitsShm.getEstimatedDriftAngle();
    _radarGeoref.ew_horiz_wind_mps = IWRF_MISSING_FLOAT;
    _radarGeoref.ew_velocity_mps = velEast;
    _radarGeoref.heading_deg = heading;
    _radarGeoref.heading_rate_dps = IWRF_MISSING_FLOAT;
    _radarGeoref.latitude = lat;
    _radarGeoref.longitude = lon;
    _radarGeoref.ns_horiz_wind_mps = IWRF_MISSING_FLOAT;
    _radarGeoref.ns_velocity_mps = velNorth;
    _radarGeoref.pitch_deg = pitch;
    _radarGeoref.pitch_rate_dps = IWRF_MISSING_FLOAT;
    _radarGeoref.roll_deg = roll;
    _radarGeoref.vert_velocity_mps = velUp;
    _radarGeoref.vert_wind_mps = IWRF_MISSING_FLOAT;

    _radarInfo.latitude_deg = lat;
    _radarInfo.longitude_deg = lon;
    _radarInfo.altitude_m = alt;

    // Angles of the reflector rotation and tilt motors.
    float rotMotorAngle = _pulseH->getRotMotorAngle();
    float tiltMotorAngle = _pulseH->getTiltMotorAngle();
    _radarGeoref.drive_angle_1_deg = rotMotorAngle;
    _radarGeoref.drive_angle_2_deg = tiltMotorAngle;

    // Rotation and tilt of the radar beam w.r.t. the pod's longitudinal axis.
    // Zero rotation means the beam points through the top of the pod and
    // positive rotation moves clockwise as viewed looking from the back
    // of the pod toward the front. Zero tilt means the beam points normal to
    // the longitudinal axis, and positive tilt means the beam points
    // forward.
    //
    // Beware of "rotation" and "tilt" terms here; the angles of the rotation
    // motor and tilt motor do not map directly to rotation_angle_deg and
    // tilt_deg! In HCR, the axis of the tilt motor is fixed w.r.t. the pod and
    // corresponds with the pod's C-MIGITS pitch axis. The axis of the rotation
    // motor is moved by the tilt motor, and is only parallel to the pod's
    // longitudinal axis when the tilt motor angle is zero.
    _radarGeoref.rotation_angle_deg = rotMotorAngle;
    _radarGeoref.tilt_deg = ((2.0 * tiltMotorAngle) // x2 for reflection
            * cos(rotMotorAngle * DEG_TO_RAD));
    
    int nUnused = sizeof(_radarGeoref.unused) / sizeof(_radarGeoref.unused[0]);
    for (int i = 0; i < nUnused; i++) {
      _radarGeoref.unused[i] = IWRF_MISSING_FLOAT;
    }

    // compute elevation and azimuth

    _computeRadarAngles();

    // Save the time of the latest data we have provided
    _lastCmigits3512Time = time3512;
    return(true);
  }
  return(false);
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

  // set seq num and time in packet header

  _radarGeoref.packet.seq_num = _packetSeqNum++;
  _radarGeoref.packet.time_secs_utc = _timeSecs;
  _radarGeoref.packet.time_nano_secs = _nanoSecs;

  // write the message

  if (_sock && _sock->writeBuffer(&_radarGeoref, sizeof(_radarGeoref))) {
    cerr << "ERROR - IwrfExport::_sendIwrfGeorefPacket()" << endl;
    cerr << "  Writing IWRF_RADAR_GEOREF" << endl;
    cerr << "  " << _sock->getErrStr() << endl;
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
    cerr << "ERROR - IwrfExport::_openServer" << endl;
    cerr << "  Cannot open server, port: " << _iwrfServerTcpPort << endl;
    cerr << "  " << _server.getErrStr() << endl;
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
