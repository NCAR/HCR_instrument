// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
// Copyright UCAR (c) 1990 - 2018
// University Corporation for Atmospheric Research (UCAR)
// National Center for Atmospheric Research (NCAR)
// Boulder, Colorado, USA
// BSD licence applies - redistribution and use in source and binary
// forms, with or without modification, are permitted provided that
// the following conditions are met:
// 1) If the software is modified to produce derivative works,
// such modified software should be clearly marked, so as not
// to confuse it with the version available from UCAR.
// 2) Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
// 3) Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
// 4) Neither the name of UCAR nor the names of its contributors,
// if any, may be used to endorse or promote products derived from
// this software without specific prior written permission.
// DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS
// OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
#ifndef IWRFPUBLISHER_H_
#define IWRFPUBLISHER_H_

#include "HCR_Config.h"
#include "ChannelPulseData.h"
#include "PublishWorker.h"
#include <ctime>
#include <map>
#include <memory>
#include <queue>
#include <QtCore/QThread>
#include <QtCore/QTimer>
#include <QtCore/QWriteLocker>

// LROSE headers
#include <didss/DsMessage.hh>
#include <Fmq/DsFmq.hh>
#include <radar/iwrf_data.h>
#include <radar/IwrfCalib.hh>

/// @brief IwrfPublisher accepts data and burst transmit sample data from
/// HCR_Pentek and publishes IWRF time series packets to an FMQ.
///
/// The bulk of the work done in this object is run in a separate thread.
class IwrfPublisher : public QObject {
    Q_OBJECT
public:
    /// @brief Enumerated type for the pulse type to be published
    typedef enum _PulseType {
        PULSE_SHORT,
        PULSE_LONG
    } PulseType;

    /// @brief Constructor
    /// @param type the pulse type to be published: PULSE_SHORT or PULSE_LONG
    /// @param config HCR_Config defining the desired configuration
    IwrfPublisher(PulseType type, const HCR_Config & config);

    /// @brief Destructor
    virtual ~IwrfPublisher();

    /// @brief Accept new pulse data from a normal receiver channel
    /// @param data a smart pointer to a ChannelPulseData instance with normal
    /// receiver channel data
    void addData(std::shared_ptr<ChannelPulseData> data);

    /// @brief Accept new pulse data from a burst transmit sample channel
    /// @param data smart pointer to a ChannelPulseData instance with burst
    /// transmit sample data
    void addXmitSampleData(std::shared_ptr<ChannelPulseData> data);

private slots:
    /// @brief Publish all pulses currently in _pulsesToPublish
    void _publishCompletedPulses();

signals:
    /// @brief Signal emitted when a new completed pulse is added to
    /// _pulsesToPublish
    ///
    /// Internally, this signal is connected to _pubWorker->publish(),
    /// which will then execute our _publishCompletedPulses() method in a
    /// separate thread.
    void _newPulseReadyToPublish();

private:
    /// @brief smart pointer to a ChannelPulseData object
    typedef std::shared_ptr<ChannelPulseData> _ChannelPulsePtr;

    /// @brief Internal class to hold per-pulse metadata and all data
    /// required for a pulse to be published
    ///
    /// The pulse is ready for publication when complete() returns true.
    class _MergedPulseData {
    public:
        /// @brief Constructor with pulse sequence number only (no data yet)
        _MergedPulseData(uint64_t pulseSeqNum);

        /// @brief Destructor
        ~_MergedPulseData();

        /// @brief Return true iff this instance is ready to publish (i.e.,
        /// has valid H channel and valid V channel data)
        /// @return true iff this instance has is ready to publish
        bool complete() const;

        /// @brief Return the pulse sequence number for this instance
        /// @return the pulse sequence number for this instance
        uint64_t seqNum() const { return(_pulseSeqNum); }

        /// @brief Return the data start time in full seconds since 1970-01-01
        /// 00:00:00 UTC
        /// @return the data start time in full seconds since 1970-01-01
        /// 00:00:00 UTC
        uint32_t dataStartSeconds() const;

        /// @brief Return the data start time in nanoseconds after
        /// dataStartSeconds()
        /// @return the data start time in nanoseconds after timeSeconds()
        uint32_t dataStartNanoseconds() const;

        /// @brief Return the burst start time in full seconds since 1970-01-01
        /// 00:00:00 UTC
        /// @return the burst start time in full seconds since 1970-01-01
        /// 00:00:00 UTC
        uint32_t burstStartSeconds() const;

        /// @brief Return the burst start time in nanoseconds after
        /// burstStartSeconds()
        /// @return the pulse time in nanoseconds after burstStartSeconds()
        uint32_t burstStartNanoseconds() const;

        /// @brief Return the transmit polarization
        /// @return the transmit polarization
        HCR_Beam::Polarization txPolarization() const;

        /// @brief Return the receive polarization
        /// @return the receive polarization
        HCR_Beam::Polarization rxPolarization() const;

        /// @brief Return the beam pointing azimuth w.r.t. the antenna face, in
        /// degrees
        /// @return the beam pointing azimuth w.r.t. the antenna face, in
        /// degrees
        double beamAzimuth() const;

        /// @brief Return the beam pointing elevation w.r.t. the antenna face, in
        /// degrees
        /// @return the beam pointing elevation w.r.t. the antenna face, in
        /// degrees
        double beamElevation() const;

        /// @brief Return the IWRF scan mode in effect at this beam
        /// @return the IWRF scan mode in effect at this beam
        iwrf_scan_mode_t scanMode() const;

        /// @brief Return the sweep number in effect at this beam
        /// @return the sweep number in effect at this beam
        int sweepNumber() const;

        /// @brief Return the volume number in effect at this beam
        /// @return the volume number in effect at this beam
        int volumeNumber() const;

        /// @brief Get the IQ data for this pulse
        /// @return the IQ data for this pulse
        const std::vector<int32_t> & data() const {
            return(_data->iqVector());
        }

        /// @brief Get the burst transmit sample IQ data for this pulse
        /// @return the burst transmit sample IQ data for this pulse
        const std::vector<int32_t> & xmitSampleData() const {
            return(_xmitSampleData->iqVector());
        }

        /// @brief Add the data for this pulse
        /// @param data a pointer to a PulseData instance with horizontal channel
        /// data
        void setData(std::shared_ptr<ChannelPulseData> data);

        /// @brief Add the burst data sampled during transmit
        /// @param xmitSampleData a pointer to a PulseData instance with burst
        /// data sampled during transmit
        void setXmitSampleData(std::shared_ptr<ChannelPulseData> xmitSampleData);

    private:
        uint64_t _pulseSeqNum;
        _ChannelPulsePtr _data;
        _ChannelPulsePtr _xmitSampleData;
    };

    /// @brief smart pointer to a _MergedPulseData object
    typedef std::shared_ptr<_MergedPulseData> _MergedPulsePtr;

    /// @brief Open and initialize our output FMQ for time series IWRF data
    void _openFmq();

    /// @brief Return the _MergedPulseData for the given pulse sequence
    /// number. A new _MergedPulseData is created if one does not yet exist
    /// for the pulse sequence number.
    /// @return the _MergedPulsePtr for the given pulse sequence number
    _MergedPulsePtr _getPulseInProgress(uint64_t pulseSeqNum);

    /// @brief If the given _MergedPulseData has all of its data and is ready
    /// for publishing, move it from _pulsesInProgress to _pulsesToPublish
    void _queueForPublishIfComplete(uint64_t pulseSeqNum);

    /// @brief Publish the pulse contained in the given _MergedPulsePtr
    void _publishPulse(_MergedPulsePtr pulse);

    /// @brief Assemble an IWRF pulse packet (header + data) into the given
    /// vector buffer
    /// @param pulse shared pointer to the merged pulse
    /// @param buf the buffer to hold the pulse packet
    void _assembleIwrfPulsePacket(const _MergedPulsePtr & pulse,
                                  std::vector<char> & pktBuf);

    /// @brief Assemble an IWRF burst packet (header + data) into the given
    /// vector buffer
    /// @param pulse shared pointer to the merged pulse
    /// @param buf the buffer to hold the pulse packet
    void _assembleIwrfBurstPacket(const _MergedPulsePtr & pulse,
                                  std::vector<char> & pktBuf);

    /// @brief Publish an IWRF pulse packet and IWRF burst packet generated
    /// from the given merged pulse data.
    ///
    /// This method will also periodically insert IWRF metadata packets
    /// (radar_info, ts_processing) into the stream
    /// @param pulse a _MergedPulsePtr with the pulse to be published
    void _publishIwrfPulse(_MergedPulsePtr & pulse);

    /// @brief Append IWRF packet content to the stream to be put on the FMQ,
    /// and send to the FMQ if enough packets have been accrued.
    /// @param packetType the IWRF packet type
    /// @param buf pointer to byte array containing the packet contents
    /// @param bufLen size of the packet byte array
    void _appendPacketForFmq(int32_t pktType, const void * buf, ssize_t bufLen);

    /// @brief Append IWRF packet content to the stream to be put on the FMQ,
    /// and send to the FMQ if enough packets have been accrued.
    /// @param packetType the IWRF packet type
    /// @param pktBuf vector containing the packet contents
    void _appendPacketForFmq(int32_t pktType, const std::vector<char> & pktBuf);

    /// @brief Pulse type we're publishing
    PulseType _pulseType;

    /// @brief HCR configuration
    const HCR_Config & _config;

    /// @brief Name to identify this IwrfPublisher instance
    std::string _name;

    /// @brief Sequence number of the last published pulse
    int64_t _lastPublishedPulse;

    /// @brief Map from pulse sequence numbers to _MergedPulsePtr objects
    /// being assembled
    std::map<uint64_t, _MergedPulsePtr> _pulsesInProgress;

    /// @brief Queue of _MergedPulsePtr instances ready to be published
    std::queue<_MergedPulsePtr> _pulsesToPublish;

    /// @brief Lock for thread protection of _pulsesInProgress and
    /// _pulsesToPublish
    QReadWriteLock _pulsesLock;

    /// @brief Sequence number the next IWRF packet we publish
    int64_t _packetSeqNum;

    /// @brief Buffer used to assemble IWRF packets
    std::vector<char> _packetBuffer;

    /// @brief Output FMQ
    DsFmq _fmq;

    /// @brief FMQ output message
    DsMessage _fmqMsg;

    // @brief IWRF radar information packet
    iwrf_radar_info_t _radarInfo;

    /// @brief IWRF georeference packet
    iwrf_platform_georef_t _radarGeoref;

    /// @brief IWRF time-series processing packet
    iwrf_ts_processing_t _tsProc;

    /// @brief Scan mode for the last published beam
    iwrf_scan_mode_t _prevScanMode;

    /// @brief IWRF calibration object
    IwrfCalib _calib;

    /// @brief How many pulses have we published?
    int _pubCount;

    /// @brief Separate thread in which the heavy lifting of actual publishing
    /// is done.
    QThread _pubThread;

    /// @brief Worker object used to make intensive publishing operations
    /// execute within _pubThread.
    ///
    /// Note that the PublishWorker class must be declared as a friend, since
    /// it will directly execute our _publishCompletedPulses() method.
    PublishWorker * _pubWorker;
    friend class PublishWorker;
};

#endif /* IWRFPUBLISHER_H_ */
