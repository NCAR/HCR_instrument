// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990-2018                                                
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
#ifndef CHANNEL_PULSE_DATA_H_
#define CHANNEL_PULSE_DATA_H_

/// @brief ChannelPulseData object holds one pulse of IQ data for one ADC/DDC
/// channel, along with the associated beam pointing and TX/RX polarization.

#include <cstdint>
#include <ctime>
#include <vector>

#include "HCR_Beam.h"

class ChannelPulseData {

public:
    /// @brief Constructor
    /// @param channelId the data source channel ID
    /// @param pulseSeqNum pulse sequence number since radar start
    /// @param timeSecs pulse start in full seconds elapsed since the Unix
    /// epoch (1970-01-01 00:00:00 UTC)
    /// @param timeNanosecs pulse start time nanoseconds elapsed into the
    /// current second
    /// @param volumeNumber volume number for the pulse
    /// @param beamConfig the beam pointing angle and TX/RX polarizations for
    /// the pulse
    /// @param nGates number of gates of IQ data
    /// @param iqarray pointer to the IQ data for the pulse: I[0], Q[0],
    /// I[1], Q[1], ..., I[nGates - 1], Q[nGates - 1]
    ChannelPulseData(int channelId,
              int64_t pulseSeqNum,
              uint32_t timeSecs,
              uint32_t timeNanosecs,
              int volumeNumber,
              HCR_Beam beamConfig,
              int nGates,
              const int32_t *iqarray) :
        _channelId(channelId),
        _pulseSeqNum(pulseSeqNum),
        _volumeNumber(volumeNumber),
        _beamConfig(beamConfig),
        _timeSecs(timeSecs),
        _timeNanosecs(timeNanosecs),
        _nGates(nGates),
        _iq(iqarray, iqarray + 2 * _nGates) {}

    /// Destructor
    virtual ~ChannelPulseData() {}

    /// @brief Return the pulse sequence number for this pulse
    /// @return the pulse sequence number for this pulse
    int64_t pulseSeqNum() const { return _pulseSeqNum; }

    /// @brief Return the beam configuration with pointing angle and TX/RX
    /// polarization.
    HCR_Beam beamConfig() const { return _beamConfig; }

    /// @brief Return the time of this pulse in integer seconds from the
    /// Unix epoch: 1970-01-01 00:00:00 UTC
    /// @return the time of this pulse in integer seconds from the
    /// Unix epoch: 1970-01-01 00:00:00 UTC
    time_t timeSecs() const { return _timeSecs; }

    /// @brief Return the subsecond time of this pulse in nanoseconds since
    /// timeSecs()
    /// @return the subsecond time of this pulse in nanoseconds since
    /// timeSecs()
    int timeNanosecs() const { return _timeNanosecs; }

    /// @brief Return the source channel id for the pulse data
    /// @return the source channel id for the pulse data
    int channelId() const { return _channelId; }

    /// @brief Return the current volume number
    /// @return the current volume number
    int volumeNumber() const { return _volumeNumber; }

    /// @brief Return the number of gates of I and Q data for this pulse
    /// @return the number of gates of I and Q data for this pulse
    int nGates() const { return _nGates; }

    /// @brief Return the transmit polarization
    /// @return the transmit polarization
    HCR_Beam::Polarization txPolarization() {
        return(_beamConfig.txPolarization());
    }

    /// @brief Return the receive polarization
    /// @return the receive polarization
    HCR_Beam::Polarization rxPolarization() {
        return(_beamConfig.rxPolarization());
    }

    /// @brief Return the beam pointing azimuth w.r.t. the antenna face, in
    /// degrees
    /// @return the beam pointing azimuth w.r.t. the antenna face, in
    /// degrees
    double beamAzimuth() {
        return(_beamConfig.beamAzimuth());
    }

    /// @brief Return the beam pointing elevation w.r.t. the antenna face, in
    /// degrees
    /// @return the beam pointing elevation w.r.t. the antenna face, in
    /// degrees
    double beamElevation() {
        return(_beamConfig.beamElevation());
    }

    /// @brief Return the vector containing the I and Q data: I[0], Q[0],
    /// I[1], Q[1], ..., I[nGates-1], Q[nGates-1]
    /// @return the vector containing the I and Q data: I[0], Q[0],
    /// I[1], Q[1], ..., I[nGates-1], Q[nGates-1]
    const std::vector<int32_t> & iqVector() const { return _iq; }

private:
    /// @brief source channel number
    int _channelId;

    /// @brief pulse sequence number since radar start
    int64_t _pulseSeqNum;

    /// @brief number of current volume
    int _volumeNumber;

    /// @brief the beam configuration with pointing angle and TX/RX polarization
    HCR_Beam _beamConfig;

    /// @brief pulse time, integer seconds since radar start
    time_t _timeSecs;

    /// @brief pulse time, nanoseconds into the current second
    int _timeNanosecs;

    /// @brief number of gates of IQ data
    int _nGates;

    /// @brief IQ data: I[0], Q[0], I[1], Q[1], ..., I[_nGates-1], Q[_nGates-1]
    std::vector<int32_t> _iq;

};

#endif // CHANNEL_PULSE_DATA_H_
