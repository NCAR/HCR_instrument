#ifndef IWRF_EXPORT_H_
#define IWRF_EXPORT_H_

#include "HcrDrxConfig.h"
#include "CircBuffer.h"
#include "PulseData.h"
#include "BurstData.h"
#include "HcrMonitor.h"
#include <radar/iwrf_data.h>
#include <toolsa/ServerSocket.hh>
#include <QThread>
#include <boost/thread/mutex.hpp>

/// IwrfExport merges data from the H and V channels, and the burst channel,
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
   * @param monitor reference to a HcrMonitor thread which will be the source
   * of monitoring status information
   */

    IwrfExport(const HcrDrxConfig& config, const HcrMonitor& monitor);
  
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

  // write data for next burst
  // called by HcrDrxPub threads
  // Returns burst data object for recycling

  BurstData *writeBurst(BurstData *val);

  boost::mutex printMutex;

private:

  /// configuration

  const HcrDrxConfig &_config;
  
  /// HcrMonitor which will supply status information
  const HcrMonitor &_monitor;

  /// The queue size - for buffering IQ data

  size_t _queueSize;
  
  ///  Queues for data from channels
  
  CircBuffer<PulseData> *_qH;
  CircBuffer<PulseData> *_qV;
  CircBuffer<BurstData> *_qB;

  /// objects for reading the buffered data
  
  PulseData *_pulseH;
  PulseData *_pulseV;
  BurstData *_burst;

  /// IQ data

  static const int NCHANNELS = 1; // only H for now
  int _nGates;
  int _nGatesAlloc;
  int _pulseIntervalPerIwrfMetaData;
  int16_t *_iq;
  char *_pulseBuf;
  int _pulseBufLen;
  
  /// I and Q count scaling factor to get power in mW easily:
  /// mW = (I_count / _iqScaleForMw)^2 + (Q_count / _iqScaleForMw)^2
  double _iqScaleForMw;

  /// Burst IQ

  int _nSamplesBurst;
  int _nSamplesBurstAlloc;
  int16_t *_burstIq;
  char *_burstBuf;
  int _burstBufLen;
  double _burstSampleFreqHz;
  bool _cohereIqToBurst;

  /// Status XML

  char *_statusBuf;
  int _statusBufLen;

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
  iwrf_ts_processing_t _tsProc;
  iwrf_calibration_t _calib;
  iwrf_scan_segment_t _simScan;
  iwrf_pulse_header_t _pulseHdr;
  iwrf_burst_header_t _burstHdr;

  /// Server

  int _iwrfServerTcpPort;
  ServerSocket _server;
  bool _serverIsOpen;
  Socket *_sock;

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
  
  /// methods

  void _readNextPulse();
  void _syncPulsesAndBurst();
  void _readNextH();
  void _readNextV();
  void _readNextB();
  void _sendIwrfMetaData();
  void _cohereIqToBurstPhase();
  void _cohereIqToBurstPhase(PulseData &pulse,
                             const BurstData &burst);

  void _assembleIwrfPulsePacket();
  void _sendIwrfPulsePacket();
  void _allocPulseBuf();
  
  void _assembleIwrfBurstPacket();
  void _sendIwrfBurstPacket();
  void _allocBurstBuf();
  
  void _assembleStatusPacket();
  string _assembleStatusXml();
  void _sendIwrfStatusXmlPacket();
  void _allocStatusBuf(size_t xmlLen);
  
  int _openServer();
  int _openSocketToClient();
  void _closeSocketToClient();

};

#endif /* IWRF_EXPORT_H_ */