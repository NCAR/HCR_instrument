#ifndef IWRF_EXPORT_H_
#define IWRF_EXPORT_H_

#include "CircBuffer.h"
#include "HcrDrxConfig.h"
#include "StatusGrabber.h"
#include "PulseData.h"
#include <CmigitsShmWatchThread.h>
#include <HcrPmc730.h>
#include <deque>
#include <radar/iwrf_data.h>
#include <radar/IwrfCalib.hh>
#include <toolsa/ServerSocket.hh>
#include <QReadWriteLock>
#include <QThread>
#include <QTimer>

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
///
/// Since IwrfExport does not use a Qt event loop at this point, the thread
/// should be stopped by calling its terminate() method.

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

private slots:
  /// @brief This slot will be called each time a new set of data is available
  /// from the C-MIGITS shared memory.
  void _acceptCmigitsData(CmigitsSharedMemory::ShmStruct cmigitsData);

private:
  /// Lock for thread-safe member access
  
  QReadWriteLock _accessLock;

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

  /// Server

  int _iwrfServerTcpPort;
  ServerSocket _server;
  bool _serverIsOpen;
  Socket *_sock;
  bool _newClient;

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

  /// Thread which polls the CmigitsSharedMemory segment and emits a signal
  /// when new data are available
  CmigitsShmWatchThread _cmigitsWatchThread;
  
  /// deque of C-MIGITS data
  std::deque<CmigitsSharedMemory::ShmStruct> _cmigitsDeque;

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
  int _hPulseCount;
  int _vPulseCount;
  int _cmigitsCount;

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
  
  bool _assembleIwrfGeorefPacket();
  int _sendIwrfGeorefPacket();
  void _computeRadarAngles();

  int _openServer();
  int _checkClient();
  void _closeSocketToClient();

  void _logStatus();

};

#endif /* IWRF_EXPORT_H_ */
