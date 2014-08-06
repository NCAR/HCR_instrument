#ifndef PULSE_DATA_H_
#define PULSE_DATA_H_

/// PulseData objects hold the IQ data for one pulse and one channel.
/// 
/// These are used to transfer data from a KaDrxPub object to the
/// KaMerge object.

#include <sys/time.h>
#include <sys/types.h>

class PulseData {

public:
    
  /**
   * Constructor.
   */

  PulseData();
  
  /// Destructor

  virtual ~PulseData();

  /// Transmit polarization enumeration
  typedef enum {
      XMIT_POL_VERTICAL,
      XMIT_POL_HORIZONTAL,
  } XmitPolarization_t;

  /// @brief Set the data in the object.
  /// @param pulseSeqNum the pulse sequence number
  /// @param timeSecs pulse time, full seconds since the Epoch
  /// @param nanoSecs pulse time, nanoseconds after timeSecs
  /// @param channelId the channel ID
  /// @param rotMotorAngle angle of the rotation motor, deg
  /// @param tiltMotorAngle angle of the tilt motor, deg
  /// @param xmitPol transmit polarization for the pulse
  /// @param nGates number of gates in the pulse data
  /// @param iq I and Q data array for the pulse: I[0], Q[0], I[1], Q[1], ..., Q[nGates -1]
  void set(int64_t pulseSeqNum,
           time_t timeSecs,
           int nanoSecs,
           int channelId,
           float rotMotorAngle,
           float tiltMotorAngle,
           XmitPolarization_t xmitPol,
           int nGates,
           const int16_t *iq);

  // combine every second gate in the IQ data
  // to reduce the number of gates to half

  void combineEverySecondGate();

  // get methods

  inline int64_t getPulseSeqNum() const { return _pulseSeqNum; }
  inline time_t getTimeSecs() const { return _timeSecs; }
  inline int getNanoSecs() const { return _nanoSecs; }
  inline int getChannelId() const { return _channelId; }
  inline float getRotMotorAngle() const { return _rotMotorAngle; }
  inline float getTiltMotorAngle() const { return _tiltMotorAngle; }
  inline XmitPolarization_t getXmitPolarization() const { return _xmitPolarization; }
  inline int getNGates() const { return _nGates; }
  inline const int16_t *getIq() const { return _iq; }
  inline int16_t *getIq() { return _iq; }
  
private:

  /**
   * pulse sequence number since start of ops
   */
  
  int64_t _pulseSeqNum;
  
  /**
   * time of pulse - seconds and nano-secs
   */

  time_t _timeSecs;
  int _nanoSecs;
  
  /**
   * channel number
   */

  int _channelId;
  
  /**
   * number of gates
   */

  int _nGates;
  int _nGatesAlloc;

  /// rotation motor angle
  float _rotMotorAngle;

  /// tilt motor angle
  float _tiltMotorAngle;

  /// transmit polarization for the pulse
  XmitPolarization_t _xmitPolarization;

  /**
   * IQ data
   */

  int16_t *_iq;

  // functions

  void _allocIq();
  
};

#endif /*KADRXPUB_H_*/
