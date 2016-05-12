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
#ifndef P7142DNTHREAD_H_
#define P7142DNTHREAD_H_

#include <QThread>
#include <p7142sd3c.h>
#include "HcrDrxConfig.h"

class IwrfExport;
class PulseData;

/// @brief HcrDrxPub publishes data from a p7142sd3c receive channel via an
/// IwrfExport object.
///
/// HcrDrxPub moves data from a downconverter to a data publisher. The 
/// downconverter is created for one receive channel via the associated 
/// p7142sd3c object. An IwrfExport object is instantiated and is used for
/// data publishing.
///
/// HcrDrxPub provides a separate thread for performing
/// the data processing. It is initiated by calling the start() method,
/// which then invokes the run() method. run() simply loops, reading beams
/// from p7142sd3cDn and publishing them via the IwrfExport object.
///
/// Since HcrDrxPub does not use a Qt event loop at this point, the thread
/// should be stopped by calling its terminate() method.
class HcrDrxPub : public QThread {
  Q_OBJECT
public:

  /**
   * Enumerated data types for the HCR receive channels.
   * H_CHANNEL is the horizontal data channel
   * V_CHANNEL is the vertical data channel
   * N_CHANNELS provides the total count of HCR channels
   */
    typedef enum {
      H_CHANNEL,
      V_CHANNEL,
      N_CHANNELS
    } DataChannelType;
        
  /**
   * @brief Constructor.
   * @param sd3c reference to the p7142sd3c object for our P7142 card
   * @param pentekChanNum the P7142 channel this thread will read
   * @param chanType the data type to be delivered on this channel
   * @param config HcrDrxConfig defining the desired configuration.
   * @param exporter the IwrfExport object to be used for merging and publishing
   *     data
   * @param tsLength the timeseries length to be used by our downconverter
   * @param gaussianFile Name of the file containing the Gaussian
   *     filter parameters
   * @param kaiserFile Name of the file containing the Kaiser
   *     filter parameters
   * @param simWavelength The wavelength of a simulated signal. The wavelength
   *     is in sample counts.
   */
  HcrDrxPub(
          Pentek::p7142sd3c & sd3c,
          int pentekChanNum,
          DataChannelType chanType,
          const HcrDrxConfig& config,
          IwrfExport *exporter,
          int tsLength,
          std::string gaussianFile,
          std::string kaiserFile,
          int simWavelength);
        
  /// Destructor
  virtual ~HcrDrxPub();
  void run();

  /// @brief Return the number of timeseries blocks that have been discarded
  /// since the last time this function was called.
  /// @return The number of timeseries blocks that have been discarded
  /// since the last time this function was called.
  unsigned long tsDiscards();

  /// @brief Return a pointer to our downconverter object
  /// @return a pointer to our downconverter object
  Pentek::p7142sd3cDn* downconverter() { return _down; }
  
Q_SIGNALS:
  /// @brief Signal emitted when the first data is seen from the downconverter.
  /// @param pentekChanNum the Pentek channel from which data was read
  void firstDataSeen(int pentekChanNum);

private:
  /// @brief Static array of instance pointers for each type, to make sure we 
  /// only create one instance per channel type.
  static HcrDrxPub * InstanceForType[N_CHANNELS];
  
  const HcrDrxConfig &_config;

  /// @brief Return the current time in seconds since 1970/01/01 00:00:00 UTC.
  /// Returned value has 1 ms precision.
  /// @return the current time in seconds since 1970/01/01 00:00:00 UTC
  double _nowTime();

  /// @brief Add data to the IWRF export object
  /// @param iq The raw buffer of data from the downconverter
  /// channel. It contains all Is and Qs
  /// @param pulseSeqNum The pulse number (will be zero for raw data).
  /// @param rotMotorAngle The angle of the rotation motor, deg.
  /// @param tiltMotorAngle The angle of the tilt motor, deg.
  /// @param xmitPolHorizontal True if transmit polarization is horizontal,
  ///    false if vertical.
  void _addToExport(const int16_t *iq, int64_t pulseSeqNum, float rotMotorAngle,
          float tiltMotorAngle, bool xmitPolHorizontal);
        
  /**
   * @brief Return true iff the current configuration is valid.
   * @return true iff the current configuration is valid.
   */
  bool _configIsValid() const;
        
  /// Our associated p7142sd3c
  Pentek::p7142sd3c& _sd3c;

  /// Receiver channel number
  unsigned int _pentekChanNum;
        
  /// Data channel type
  DataChannelType _chanType;
  
  /// Our associated Pentek downconverter
  Pentek::p7142sd3cDn* _down;

  /**
   * I and Q count scaling factor to get power in mW easily:
   * mW = (I_count / _iqScaleForMw)^2 + (Q_count / _iqScaleForMw)^2
   */
  double _iqScaleForMw;

  /**
   * The number of gates being collected by the downconverter
   */
  unsigned int _nGates;
        
  /// The DDS sample number; increment when a sample is published.
  long _sampleNumber;

  /**
   * Our IWRF exporter, which merges time series data and publishes via a
   * TCP socket
   */
  IwrfExport *_exporter;
  
  /// PulseData instance to be filled and passed to our exporter
  PulseData *_pulseData;

  /// Have we seen data from our downconverter yet?
  bool _dataSeen;
};

#endif /*P7142DNTHREAD_H_*/
