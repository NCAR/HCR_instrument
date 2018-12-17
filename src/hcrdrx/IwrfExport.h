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
#ifndef IWRF_EXPORT_H_
#define IWRF_EXPORT_H_

#include <atomic>
#include <deque>

#include "CircBuffer.h"
#include "HcrDrxConfig.h"
#include "StatusGrabber.h"
#include "PulseData.h"

#include <HcrPmc730.h>
#include <radar/iwrf_data.h>
#include <radar/IwrfCalib.hh>
#include <toolsa/ServerSocket.hh>
#include <Fmq/DsFmq.hh>

#include <QReadWriteLock>
#include <QThread>
#include <QTimer>

#include "IwrfExportInsPoller.h"

class IwrfExportInsPoller;

/// IwrfExport merges data from the H and V channels, 
/// converts to IWRF time series format and writes the IWRF data to a client
/// via TCP.
///
/// The bulk of the work done in this object is run in a separate thread.
///
/// Each instance of the HcrDrxPub class each write their data to this
/// object, inserting it into buffers (deques). The merge operation is
/// carried out by removing items from the queues, synchronizing on the
/// pulse numbers, and merging the data.
///
/// This thread acts as a server, listening for a client to connect. Only
/// a single client is supported, given the high bandwidth of the data
/// stream. If no client is connected, the data is discarded.

class IwrfExport : public QThread {

  Q_OBJECT

public:
    
  /**
   * Constructor.
   * @param config HcrDrxConfig defining the desired configuration.
   * @param monitor reference to a StatusGrabber thread which will be the source
   * of monitoring status information
   */

    IwrfExport(const HcrDrxConfig& config, const StatusGrabber& monitor);
  
  /// Destructor
  
  virtual ~IwrfExport();

  /// thread run method

  void run();

  // write data for next H pulse
  // called by HcrDrxPub threads
  // Returns pulse object for recycling
  
  PulseData *writePulseH(PulseData *val);

  // write data for next V pulse
  // called by HcrDrxPub threads
  // Returns pulse object for recycling
  
  PulseData *writePulseV(PulseData *val);
  
  /// @brief Method called to put new INS data in our queue.
  void queueInsData(CmigitsFmq::MsgStruct cmigitsData, int insNum = 1);

private slots:
  /// @brief Log some status information
  void _logStatus();
  
private:
  /// Lock for thread-safe member access
  
  QReadWriteLock _insAccessLock;
  QReadWriteLock _fmqAccessLock;

  /// configuration

  const HcrDrxConfig &_config;
  
  /// StatusGrabber which will supply status information

  const StatusGrabber &_monitor;

  /// The queue size - for buffering IQ data

  size_t _queueSize;
  
  ///  Queues for data from channels
  
  CircBuffer<PulseData> *_qH;
  CircBuffer<PulseData> *_qV;

  /// objects for reading the buffered data
  
  PulseData *_pulseH;
  PulseData *_pulseV;

  /// IQ data

  static const int NCHANNELS = 2;
  int _nGates;
  int _pulseIntervalPerIwrfMetaData;
  int16_t *_iq;
  char *_pulseBuf;
  int _pulseBufLen;
  int _pulseMsgLen;
  
  /// I and Q count scaling factor to get power in mW easily:
  /// mW = (I_count / _iqScaleForMw)^2 + (Q_count / _iqScaleForMw)^2
  double _iqScaleForMw;

  /// Status XML
  
  int _xmlLen;
  char *_statusBuf;
  int _statusBufLen;
  int _statusMsgLen;

  /// pulse sequence number and times
  
  int64_t _pulseSeqNum;
  time_t _timeSecs;
  int _nanoSecs;

  int64_t _prevPulseSeqNum;
  time_t _prevTimeSecs;
  int _prevNanoSecs;

  /// prt mode

  bool _staggeredPrt;
  double _prt1;
  
  /// IWRF data

  int64_t _packetSeqNum;
  iwrf_radar_info_t _radarInfo;
  iwrf_platform_georef_t _radarGeoref;
  iwrf_ts_processing_t _tsProc;
  IwrfCalib _calib;
  iwrf_scan_segment_t _simScan;
  iwrf_pulse_header_t _pulseHdr;

  /// Export via TCP

  int _iwrfServerTcpPort;
  ServerSocket _server;
  bool _serverIsOpen;
  Socket *_sock;
  bool _newClient;

  /// Export via FMQ
  /// we combine a number of packets into a message before
  /// writing to the FMQ

  string _fmqPath;
  DsFmq _outputFmq;
  bool _fmqOpen;
  DsMessage _outputMsg;
  bool _firstFmqMessage;
  
  /// current HMC operation mode
  HcrPmc730::HmcOperationMode _hmcMode;
  
  // elevation and azimuth from reflector rotation and tilt

  double _elevationDeg;
  double _azimuthDeg;

  /// angle corrections

  double _rollCorr;
  double _pitchCorr;
  double _headingCorr;
  double _driftCorr;
  double _tiltCorr;
  double _rotationCorr;

  /// Thread which reads data from the INS1 FMQ and puts it in our deque
  IwrfExportInsPoller _ins1WatchThread;

  /// Thread which reads data from the INS2 FMQ and puts it in our deque
  IwrfExportInsPoller _ins2WatchThread;

  /// deque of INS1 data for generating iwrf_platform_georef packets
  std::deque<CmigitsFmq::MsgStruct> _ins1Deque;
  
  /// deque of INS2 data for generating iwrf_platform_georef packets
  std::deque<CmigitsFmq::MsgStruct> _ins2Deque;
  
  /// Latest INS1 data, used for generating IWRF status XML packets
  CmigitsFmq::MsgStruct _latestIns1Data;

  /// Latest INS1 data, used for generating IWRF status XML packets
  CmigitsFmq::MsgStruct _latestIns2Data;
  
  /// Are INS1 data delayed longer than we want to wait for merging?
  bool _ins1DataDelayed;

  /// Are INS1 data delayed longer than we want to wait for merging?
  bool _ins2DataDelayed;

  /// simulation of antenna angles

  bool _simAntennaAngles;
  int _simNElev;
  double _simStartElev;
  double _simDeltaElev;
  double _simElev;
  double _simAzRate;
  double _simAz;
  int _simVolNum;
  int _simSweepNum;
  
  /// timer to generate regular calls to _logStatus()
  QTimer * _statusTimer;

  /// counts of events between calls to _logStatus()
  atomic<uint> _hPulseCount;
  atomic<uint> _vPulseCount;
  atomic<uint> _ins1Count;
  atomic<uint> _ins2Count;
  
  /// Time of the last georef packet we built, milliseconds since 1970-01-01
  /// 00:00:00 UTC
  uint64_t _lastGeorefTime;

  /// methods

  void _readNextPulse();
  void _syncPulses();
  void _readNextH();
  void _readNextV();
  int _sendIwrfMetaData();

  void _assembleIwrfPulsePacket();
  int _sendIwrfPulsePacket();
  void _allocPulseBuf();
  
  void _assembleStatusPacket();
  string _assembleStatusXml();
  int _sendIwrfStatusXmlPacket();
  void _allocStatusBuf();
  
  void _doIwrfGeorefsBeforePulse();
  int _sendIwrfGeorefPacket();
  void _computeRadarAngles();

  // export via TCP

  int _openServer();
  int _checkClient();
  void _closeSocketToClient();

  // write to FMQ

  int _openOutputFmq();
  int _writeToOutputFmq(bool force = false);
  int _writeEndOfVol();

};

#endif /* IWRF_EXPORT_H_ */
