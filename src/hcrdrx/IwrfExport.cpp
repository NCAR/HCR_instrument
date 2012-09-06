#include "IwrfExport.h"
#include <logx/Logging.h>
#include <sys/timeb.h>
#include <cmath>
#include <cstdlib>
#include <unistd.h>
#include <iostream>
#include <iomanip>
#include <radar/iwrf_functions.hh>
#include <toolsa/pmu.h>
#include <toolsa/uusleep.h>
#include <toolsa/TaXml.hh>

using namespace boost::posix_time;
using namespace std;

LOGGING("IwrfExport")

///////////////////////////////////////////////////////////////////////////

IwrfExport::IwrfExport(const HcrDrxConfig& config, const HcrMonitor& monitor) :
        QThread(),
        _config(config),
        _monitor(monitor)
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
  _pulseIntervalPerIwrfMetaData =
    config.pulse_interval_per_iwrf_meta_data();
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

  // initialize IWRF radar_info struct from config

  _packetSeqNum = 0;

  iwrf_radar_info_init(_radarInfo);
  _radarInfo.latitude_deg = _config.latitude();
  _radarInfo.longitude_deg = _config.longitude();
  _radarInfo.altitude_m = _config.altitude();
  _radarInfo.platform_type = IWRF_RADAR_PLATFORM_FIXED;
  _radarInfo.beamwidth_deg_h = _config.ant_hbeam_width();
  _radarInfo.beamwidth_deg_v = _config.ant_vbeam_width();
  double freqHz = _config.tx_cntr_freq();
  double lightSpeedMps = 2.99792458e8;
  double wavelengthM = lightSpeedMps / freqHz;
  _radarInfo.wavelength_cm = wavelengthM * 100.0;
  _radarInfo.nominal_gain_ant_db_h = _config.ant_gain();
  _radarInfo.nominal_gain_ant_db_v = _config.ant_gain();
  strncpy(_radarInfo.radar_name, _config.radar_id().c_str(),
          IWRF_MAX_RADAR_NAME - 1);

  // initialize IWRF ts_processing struct from config

  iwrf_ts_processing_init(_tsProc);
  _tsProc.xmit_rcv_mode = IWRF_SINGLE_POL;
  _tsProc.xmit_phase_mode = IWRF_XMIT_PHASE_MODE_FIXED;
  _tsProc.prf_mode = IWRF_PRF_MODE_FIXED;
  _tsProc.pulse_type = IWRF_PULSE_TYPE_RECT;
  _tsProc.prt_usec = _config.prt1() * 1.0e6;
  _tsProc.prt2_usec = _config.prt2() * 1.0e6;
  _tsProc.cal_type = IWRF_CAL_TYPE_CW_CAL;
  _tsProc.burst_range_offset_m = 0.0;
  //   _tsProc.burst_range_offset_m =
  //     _config.burst_sample_delay() * lightSpeedMps / 2.0;
  _tsProc.pulse_width_us = _config.tx_pulse_width() * 1.0e6;
  _tsProc.gate_spacing_m = _config.rcvr_pulse_width() * 1.5e8;
  _tsProc.start_range_m = _config.range_to_gate0(); // center of gate 0
  _tsProc.pol_mode = IWRF_POL_MODE_H;

  // initialize IWRF calibration struct from config

  iwrf_calibration_init(_calib);
  _calib.wavelength_cm = _radarInfo.wavelength_cm;
  _calib.beamwidth_deg_h = _radarInfo.beamwidth_deg_h;
  _calib.beamwidth_deg_v = _radarInfo.beamwidth_deg_v;
  _calib.gain_ant_db_h = _radarInfo.nominal_gain_ant_db_h;
  _calib.gain_ant_db_v = _radarInfo.nominal_gain_ant_db_v;
  _calib.pulse_width_us = _config.tx_pulse_width() * 1.0e6;
  _calib.xmit_power_dbm_h = _config.tx_peak_power();
  _calib.xmit_power_dbm_v = 0.0;
  _calib.two_way_waveguide_loss_db_h = _config.tx_waveguide_loss() + 3.0103;
  _calib.two_way_waveguide_loss_db_v = _config.tx_waveguide_loss() + 3.0103;
  _calib.power_meas_loss_db_h = _config.tx_peak_pwr_coupling();
  _calib.power_meas_loss_db_v = _config.tx_peak_pwr_coupling();

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
    if (_pulseSeqNum % _pulseIntervalPerIwrfMetaData == 0) {
      sendMeta = true;
    }
    
    if (sendMeta) {
      _sendIwrfMetaData();
      metaDataInitialized = true;
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

  _calib.packet.seq_num = _packetSeqNum++;
  _calib.packet.time_secs_utc = _timeSecs;
  _calib.packet.time_nano_secs = _nanoSecs;

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
  
  if (_sock && _sock->writeBuffer(&_calib, sizeof(_calib))) {
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

  const HcrMonitor &mon = _monitor;

  // floats

  xml += TaXml::writeDouble
    ("DetectedRfPower", 2, mon.detectedRfPower());

  xml += TaXml::writeDouble
    ("PvForePressure", 2, mon.pvForePressure());

  xml += TaXml::writeDouble
    ("PvAftPressure", 2, mon.pvAftPressure());

  xml += TaXml::writeDouble
    ("PloTemp", 2, mon.ploTemp());

  xml += TaXml::writeDouble
    ("EikTemp", 2, mon.eikTemp());

  xml += TaXml::writeDouble
    ("VLnaTemp", 2, mon.vLnaTemp());

  xml += TaXml::writeDouble
    ("HLnaTemp", 2, mon.hLnaTemp());

  xml += TaXml::writeDouble
    ("PolarizationSwitchTemp", 2, mon.polarizationSwitchTemp());

  xml += TaXml::writeDouble
    ("RfDetectorTemp", 2, mon.rfDetectorTemp());

  xml += TaXml::writeDouble
    ("NoiseSourceTemp", 2, mon.noiseSourceTemp());

  xml += TaXml::writeDouble
    ("Ps28VTemp", 2, mon.ps28VTemp());

  xml += TaXml::writeDouble
    ("RdsInDuctTemp", 2, mon.rdsInDuctTemp());

  xml += TaXml::writeDouble
    ("RotationMotorTemp", 2, mon.rotationMotorTemp());

  xml += TaXml::writeDouble
    ("TiltMotorTemp", 2, mon.tiltMotorTemp());

  xml += TaXml::writeDouble
    ("CmigitsTemp", 2, mon.cmigitsTemp());

  xml += TaXml::writeDouble
    ("TailconeTemp", 2, mon.tailconeTemp());

  xml += TaXml::writeDouble
    ("PsVoltage", 2, mon.psVoltage());

  xml += TaXml::writeDouble
    ("PentekFpgaTemp", 2, mon.pentekFpgaTemp());

  xml += TaXml::writeDouble
    ("PentekBoardTemp", 2, mon.pentekBoardTemp());

  // booleans

  xml += TaXml::writeBoolean
    ("NoiseSourceSelected", 2, mon.noiseSourceSelected());

  xml += TaXml::writeBoolean
    ("TerminationSelected", 2, mon.terminationSelected());

  xml += TaXml::writeBoolean
    ("Locked15_5GHzPLO", 2, mon.locked15_5GHzPLO());

  xml += TaXml::writeBoolean
    ("Locked1250MHzPLO", 2, mon.locked1250MHzPLO());

  xml += TaXml::writeBoolean
    ("ModPulseDisabled", 2, mon.modPulseDisabled());
  
  xml += TaXml::writeBoolean
    ("RdsXmitterFilamentOn", 2, mon.rdsXmitterFilamentOn());

  xml += TaXml::writeBoolean
    ("RdsXmitterHvOn", 2, mon.rdsXmitterHvOn());

  // ints

  xml += TaXml::writeInt
    ("HmcStatus", 2, mon.hmcStatus());

  // end receive status

  xml += TaXml::writeEndTag("HcrReceiverStatus", 1);

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
