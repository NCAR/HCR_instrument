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
#ifndef PULSE_DATA_H_
#define PULSE_DATA_H_

/// PulseData objects hold the IQ data for one pulse and one channel.
///
/// These are used to transfer data from a HCRPentek to IwrfExport

#include <sys/time.h>
#include <sys/types.h>
#include <complex>

class PulseData {

public:

    // Used by HCRPentek and IwrfExport to set data size
    typedef std::complex<int32_t> IQData; 

    /// Constructor.
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
    /// @param prt1 first pulse repetition time (PRT), seconds
    /// @param prt2 second PRT (if using two PRTs), seconds
    /// @param currentPrt PRT in use for this pulse
    /// @param txPulseWidth transmit pulse width, seconds
    /// @param sampleWidth sample width, seconds
    /// @param nGates number of gates in the pulse data
    /// @param iq I and Q data array for the pulse: I[0], Q[0], I[1], Q[1], ..., Q[nGates -1]
    void set(int64_t pulseSeqNum,
             time_t timeSecs,
             int nanoSecs,
             int channelId,
             float rotMotorAngle,
             float tiltMotorAngle,
             XmitPolarization_t xmitPol,
             double prt1,
             double prt2,
             double currentPrt,
             double txPulseWidth,
             double sampleWidth,
             int nGates,
             const IQData *iq);

    // get methods

    inline int64_t getPulseSeqNum() const { return _pulseSeqNum; }
    inline time_t getTimeSecs() const { return _timeSecs; }
    inline int getNanoSecs() const { return _nanoSecs; }
    inline int getChannelId() const { return _channelId; }
    inline float getRotMotorAngle() const { return _rotMotorAngle; }
    inline float getTiltMotorAngle() const { return _tiltMotorAngle; }
    inline XmitPolarization_t getXmitPolarization() const { return _xmitPolarization; }
    inline int getNGates() const { return _nGates; }
    inline const IQData *getIq() const { return _iq; }
    inline IQData *getIq() { return _iq; }
    inline double getPrt1() const { return _prt1; }
    inline double getPrt2() const { return _prt2; }
    inline double getCurrentPrt() const { return _currentPrt; }
    inline double getTxPulseWidth() const { return _txPulseWidth; }
    inline double getSampleWidth() const { return _sampleWidth; }

private:

    /// pulse sequence number since start of ops
    int64_t _pulseSeqNum;
    /// time of pulse - seconds and nano-secs
    time_t _timeSecs;
    int _nanoSecs;
    /// channel number
    int _channelId;
    /// number of gates
    int _nGates;
    int _nGatesAlloc;
    /// rotation motor angle
    float _rotMotorAngle;
    /// tilt motor angle
    float _tiltMotorAngle;
    /// transmit polarization for the pulse
    XmitPolarization_t _xmitPolarization;
    /// First or only PRT
    double _prt1;
    /// Second PRT or zero
    double _prt2;
    /// Length of current pulse
    double _currentPrt;
    /// Transmit pulse width
    double _txPulseWidth;
    /// Sample width
    double _sampleWidth;

    /// IQ data
    IQData *_iq;

    // functions

    void _allocIq();

};

#endif /*PULSE_DATA_H_*/
