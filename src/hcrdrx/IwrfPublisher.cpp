// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
// ** Copyright UCAR (c) 1990 - 2018
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
#include <IwrfPublisher.h>
#include <logx/Logging.h>
#include <sys/timeb.h>
#include <cmath>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <iostream>
#include <memory>
#include <sstream>
#include <unistd.h>
#include <radar/iwrf_functions.hh>
#include <radar/IwrfCalib.hh>
#include <toolsa/pmu.h>
#include <toolsa/TaXml.hh>
#include <toolsa/toolsa_macros.h>

#include <QtCore/QCoreApplication>
#include <QtCore/QTimer>
#include <QtCore/QWriteLocker>

LOGGING("IwrfPublisher")

IwrfPublisher::IwrfPublisher(PulseType pulseType, const HCR_Config & config) :
    QObject(),
    _pulseType(pulseType),
    _config(config),
    _name((pulseType == PULSE_SHORT) ? "short" : "long"),
    _lastPublishedPulse(0),
    _pulsesInProgress(),
    _pulsesToPublish(),
    _pulsesLock(QReadWriteLock::Recursive),
    _packetSeqNum(0),
    _fmqMsg(),
    _radarInfo(),
    _radarGeoref(),
    _tsProc(),
    _prevScanMode(IWRF_SCAN_MODE_NOT_SET),
    _calib(),
    _pubCount(0),
    _pubThread(),
    _pubWorker(new PublishWorker(*this))
{
    // Open our output FMQ for IWRF time series data
    _openFmq();

    // Initialize IWRF calibration struct from the calibration file defined in
    // the config
    std::string errStr;
    if (pulseType == PULSE_LONG) {
      if (_calib.readFromXmlFile(_config.calib_file_long_pulse(), errStr) != 0) {
        ELOG << _name << ": Error reading calib_file_long_pulse '" <<
          _config.calib_file_long_pulse() << "': " << errStr;
        abort();
      }
    } else {
      if (_calib.readFromXmlFile(_config.calib_file_short_pulse(), errStr) != 0) {
        ELOG << _name << ": Error reading calib_file_short_pulse '" <<
          _config.calib_file_short_pulse() << "': " << errStr;
        abort();
      }
    }

    // Initialize IWRF radar_info struct from HCR_Pentek and config
    iwrf_radar_info_init(_radarInfo);
    _radarInfo.latitude_deg =_config.latitude();
    _radarInfo.longitude_deg =_config.longitude();
    _radarInfo.altitude_m =_config.altitude();
    _radarInfo.platform_type = IWRF_RADAR_PLATFORM_FIXED;
    _radarInfo.beamwidth_deg_h = _calib.getBeamWidthDegH();
    _radarInfo.beamwidth_deg_v = _calib.getBeamWidthDegV();
    _radarInfo.wavelength_cm = _calib.getWavelengthCm();
    _radarInfo.nominal_gain_ant_db_h = _calib.getAntGainDbH();
    _radarInfo.nominal_gain_ant_db_v = _calib.getAntGainDbV();
    strncpy(_radarInfo.radar_name, _config.radar_id().c_str(),
            IWRF_MAX_RADAR_NAME - 1);

    // Initialize IWRF ts_processing struct from config
    iwrf_ts_processing_init(_tsProc);

    switch (_config.polarization_mode()) {
    case HCR_Config::MODE_HH:
    case HCR_Config::MODE_VV:
        _tsProc.xmit_rcv_mode = IWRF_SINGLE_POL;
        break;
    case HCR_Config::MODE_HH_VV:
        _tsProc.xmit_rcv_mode = IWRF_ALT_HV_CO_ONLY;
        break;
    default:
        _tsProc.xmit_rcv_mode = IWRF_XMIT_RCV_MODE_NOT_SET;
    }

    _tsProc.xmit_phase_mode = IWRF_XMIT_PHASE_MODE_FIXED;
    _tsProc.prf_mode = IWRF_PRF_MODE_FIXED;
    _tsProc.pulse_type = IWRF_PULSE_TYPE_RECT;
    _tsProc.prt_usec = _config.prt() * 1.0e6;
    _tsProc.cal_type = IWRF_CAL_TYPE_NONE;
    _tsProc.burst_range_offset_m = 0.0;
    #warning some of these got are dynamic now
    _tsProc.pulse_width_us = 888;
    _tsProc.gate_spacing_m = 888;
    _tsProc.start_range_m = _config.range_to_gate0(); // center of gate 0
    _tsProc.pol_mode = IWRF_POL_MODE_NOT_SET;

    // Connect our newPulseReadyToPublish() signal to our PublishWorker's
    // publish() slot. That slot in turn will execute our
    // _publishCompletedPulses method INSIDE THE WORKER THREAD.
    connect(this, SIGNAL(_newPulseReadyToPublish()),
            _pubWorker, SLOT(publish()));

    // Set the name for our worker thread. This name will be displayed by
    // 'top' when showing threads.
    std::ostringstream os;
    os << "IwrfPub(" << _name << ")";
    _pubThread.setObjectName(os.str().c_str());

    // Finally, start _pubThread where the heavy lifting of publishing
    // pulses will occur.
    _pubThread.start();

    // Stop _pubThread when the application quits, and set up for clean
    // deletion of _pubWorker when _pubThread is finished.
    connect(QCoreApplication::instance(), SIGNAL(aboutToQuit()),
            &_pubThread, SLOT(quit()));
    connect(&_pubThread, SIGNAL(finished()), _pubWorker, SLOT(deleteLater()));
}

IwrfPublisher::~IwrfPublisher() {
    // Wait briefly for our worker thread to finish if necessary
    if (! _pubThread.isFinished()) {
        ILOG << "Pausing for IwrfPublisher (" << _name <<
                ") _pubThread to finish...";
        if (_pubThread.wait(10)) {
            WLOG << "IwrfPublisher (" << _name <<
                    ") _pubThread did not finish. Exiting anyway.";
        } else {
            ILOG << "...done";
        }
    }
    DLOG << _name << ": exiting with " <<
            _pulsesInProgress.size() << " pulses in progress and " <<
            _pulsesToPublish.size() << " unpublished complete pulses";
}

IwrfPublisher::_MergedPulsePtr
IwrfPublisher::_getPulseInProgress(uint64_t pulseSeqNum) {
    QWriteLocker locker(&_pulsesLock);
    if (_pulsesInProgress.find(pulseSeqNum) == _pulsesInProgress.end()) {
        // Construct a new _Pulse for this sequence number
        _pulsesInProgress[pulseSeqNum] = std::make_shared<_MergedPulseData>(pulseSeqNum);
    }
    return(_pulsesInProgress[pulseSeqNum]);
}

void
IwrfPublisher::addData(std::shared_ptr<ChannelPulseData> data) {
    QWriteLocker locker(&_pulsesLock);
    uint64_t pulseSeqNum = data->pulseSeqNum();
    _getPulseInProgress(data->pulseSeqNum())->setData(data);
    _queueForPublishIfComplete(pulseSeqNum);
}

void
IwrfPublisher::addXmitSampleData(std::shared_ptr<ChannelPulseData> xmitSampleData) {
    QWriteLocker locker(&_pulsesLock);
    uint64_t pulseSeqNum = xmitSampleData->pulseSeqNum();
    _getPulseInProgress(pulseSeqNum)->setXmitSampleData(xmitSampleData);
    _queueForPublishIfComplete(pulseSeqNum);
}

void
IwrfPublisher::_queueForPublishIfComplete(uint64_t pulseSeqNum) {
    QWriteLocker locker(&_pulsesLock);

    // Get the pulse in progress for the given pulse number
    _MergedPulsePtr pip = _getPulseInProgress(pulseSeqNum);

    // If _pulsesInProgress is too big, clear all of it
    if (_pulsesInProgress.size() >= 10000) {
        ELOG << _name << ": Too many pulses in progress - deleting all " <<
                _pulsesInProgress.size() << " of them!";
        _pulsesInProgress.clear();
    }

    // If the pulse in progress is not complete, we're done here!
    if (! pip->complete()) {
        return;
    }

    // Erase pulses in _pulsesInProgress up to and including pip. We remove
    // the earlier ones since they will never get completed. These
    // incompletes are a result of getting a handful of data from one
    // channel at startup when the associated data from the other channel(s)
    // were already missed.
    uint32_t incompleteCount = 0;
    while (true) {
        // Extract the earliest entry from _pulsesInProgress and erase it
        // from _pulsesInProgress. NOTE: _pulsesInProgress is sorted by pulse
        // sequence number.
        _MergedPulsePtr p = _pulsesInProgress.begin()->second;
        _pulsesInProgress.erase(p->seqNum());

        // Stop after we've removed pip from _pulsesInProgress
        if (p == pip) {
            break;
        }

        // If it wasn't pip that was removed, it was an earlier incomplete
        // pulse, so go back and do the next one.
        incompleteCount++;
    }
    if (incompleteCount > 0) {
        DLOG << _name << ": " << incompleteCount <<
                " pulses with incomplete data were dropped before pulse " <<
                pip->seqNum();
    }

    // Push the completed pulse onto the _pulsesToPublish queue
    _pulsesToPublish.push(pip);
    emit(_newPulseReadyToPublish());
}

void
IwrfPublisher::_publishCompletedPulses() {
    QWriteLocker locker(&_pulsesLock);

    // This method should only be executing from within _pubThread
    assert(QThread::currentThread() == &_pubThread);

    // Publish as long as there are pulses in the queue
    while (! _pulsesToPublish.empty()) {
        // Get the front element from _pulsesToPublish, then pop it from
        // the queue
        _MergedPulsePtr pulse = _pulsesToPublish.front();
        _pulsesToPublish.pop();

        // Free our lock now, since we're done with _pulsesToPublish and we
        // don't want to hold the lock while we're busy publishing the pulse.
        locker.unlock();

        // Publish the pulse
        _publishPulse(pulse);

        // Get our lock back before starting the loop again
        locker.relock();
    }
}

void
IwrfPublisher::_publishPulse(_MergedPulsePtr pulse) {
    // This method should only be executing from within _pubThread
    assert(QThread::currentThread() == &_pubThread);

    _publishIwrfPulse(pulse);
    _pubCount++;
    if ((_pubCount % 10000) == 0) {
        ILOG << _name << ": " << _pubCount << " pulses published";
    }
    // At this point, we hold the last reference to the given _MergedPulsePtr,
    // so it should be deleted automatically on exit from this method.
}


///////////////////////////////////////////////////////////////////////////////
//// send the IWRF meta data
//
//int IwrfPublisher::_sendIwrfMetaData()
//{
//
//    // set seq num and time in packet headers
//
//    _radarInfo.packet.seq_num = _packetSeqNum++;
//    _radarInfo.packet.time_secs_utc = _timeSecs;
//    _radarInfo.packet.time_nano_secs = _nanoSecs;
//
//    _tsProc.packet.seq_num = _packetSeqNum++;
//    _tsProc.packet.time_secs_utc = _timeSecs;
//    _tsProc.packet.time_nano_secs = _nanoSecs;
//
//    // set our polarization and calibration modes for processing
//
//    switch (_hmcMode) {
//    case HcrPmc730::HMC_MODE_V_HV:
//    case HcrPmc730::HMC_MODE_V_HV_ATTENUATED:
//    case HcrPmc730::HMC_MODE_BENCH_TEST:
//    case HcrPmc730::HMC_MODE_UNUSED_7:
//        _tsProc.xmit_rcv_mode = IWRF_V_ONLY_FIXED_HV;
//        _tsProc.pol_mode = IWRF_POL_MODE_V;
//        _tsProc.cal_type = IWRF_CAL_TYPE_NONE;
//        break;
//    case HcrPmc730::HMC_MODE_H_HV:
//    case HcrPmc730::HMC_MODE_H_HV_ATTENUATED:
//        _tsProc.xmit_rcv_mode = IWRF_H_ONLY_FIXED_HV;
//        _tsProc.pol_mode = IWRF_POL_MODE_H;
//        _tsProc.cal_type = IWRF_CAL_TYPE_NONE;
//        break;
//    case HcrPmc730::HMC_MODE_HV_HV:
//        _tsProc.xmit_rcv_mode = IWRF_ALT_HV_FIXED_HV;
//        _tsProc.pol_mode = IWRF_POL_MODE_HV_ALT;
//        _tsProc.cal_type = IWRF_CAL_TYPE_NONE;
//        break;
//    case HcrPmc730::HMC_MODE_NOISE_SOURCE_CAL:
//        _tsProc.xmit_rcv_mode = IWRF_V_ONLY_FIXED_HV;
//        _tsProc.pol_mode = IWRF_POL_MODE_V;
//        _tsProc.cal_type = IWRF_CAL_TYPE_NOISE_SOURCE_V;
//        break;
//    default:
//        WLOG << _name << ": Unhandled/unknown _hmcMode: " << _hmcMode;
//        _tsProc.xmit_rcv_mode = IWRF_XMIT_RCV_MODE_NOT_SET;
//        _tsProc.pol_mode = IWRF_POL_MODE_NOT_SET;
//        _tsProc.cal_type = IWRF_CAL_TYPE_NOT_SET;
//        break;
//    }
//
//    iwrf_calibration_t calibStruct = _calib.getStruct();
//    calibStruct.packet.seq_num = _packetSeqNum++;
//    calibStruct.packet.time_secs_utc = _timeSecs;
//    calibStruct.packet.time_nano_secs = _nanoSecs;
//
//    // write individual messages for each struct
//
//    bool closeSocket = false;
//
//    if (_sock && _sock->writeBuffer(&_radarInfo, sizeof(_radarInfo))) {
//        ELOG << _name << ": ERROR - IwrfPublisher::_sendIwrfMetaData()";
//        ELOG << _name << ":   Writing IWRF_RADAR_INFO";
//        ELOG << _name << ":   " << _sock->getErrStr();
//        closeSocket = true;
//    } else if (_sock && _sock->writeBuffer(&_tsProc, sizeof(_tsProc))) {
//        ELOG << _name << ": ERROR - IwrfPublisher::_sendIwrfMetaData()";
//        ELOG << _name << ":   Writing IWRF_TS_PROCESSING";
//        ELOG << _name << ":   " << _sock->getErrStr();
//        closeSocket = true;
//    } else if (_sock && _sock->writeBuffer(&calibStruct, sizeof(calibStruct))) {
//        ELOG << _name << ": ERROR - IwrfPublisher::_sendIwrfMetaData()";
//        ELOG << _name << ":   Writing IWRF_CALIBRATION";
//        ELOG << _name << ":   " << _sock->getErrStr();
//        closeSocket = true;
//    }
//
//    if (closeSocket) {
//        _closeSocketToClient();
//        return -1;
//    }
//
//    return 0;
//
//}

void IwrfPublisher::_publishIwrfPulse(_MergedPulsePtr & pulse)
{
    // Assemble an IWRF burst packet (header + data) from the given merged
    // pulse and append it to the FMQ output message
    std::vector<char> pktBuf;
    _assembleIwrfBurstPacket(pulse, pktBuf);
    _appendPacketForFmq(IWRF_BURST_HEADER_ID, pktBuf);

    // Assemble an IWRF pulse packet (header + data) from the given merged
    // pulse and append it to the FMQ output message
    pktBuf.clear();
    _assembleIwrfPulsePacket(pulse, pktBuf);
    _appendPacketForFmq(IWRF_PULSE_HEADER_ID, pktBuf);

    // Add radar_info, ts_processing and iwrf_calibration packets at the
    // configured metadata interval.
    //
    // We also re-register with PMU at this interval
    bool do_metadata = (pulse->seqNum() % _config.pulse_interval_per_iwrf_meta_data()) == 0;
    if (do_metadata) {
        PMU_auto_register("IwrfPublisher::_publishIwrfPulse()");

        // Append a radar_info packet to the FMQ output message
        _radarInfo.packet.seq_num = _packetSeqNum++;
        _radarInfo.packet.time_secs_utc = pulse->dataStartSeconds();
        _radarInfo.packet.time_nano_secs = pulse->dataStartNanoseconds();
        auto raw = reinterpret_cast<const char *>(&_radarInfo);
        _appendPacketForFmq(IWRF_RADAR_INFO_ID, raw, sizeof(_radarInfo));

        // Append a ts_proc packet to the FMQ output message
        _tsProc.packet.seq_num = _packetSeqNum++;
        _tsProc.packet.time_secs_utc = pulse->dataStartSeconds();
        _tsProc.packet.time_nano_secs = pulse->dataStartNanoseconds();
        raw = reinterpret_cast<const char *>(&_tsProc);
        _appendPacketForFmq(IWRF_TS_PROCESSING_ID, raw, sizeof(_tsProc));

        // Assemble and append an iwrf_calibration packet to the FMQ output
        // message
        iwrf_calibration_t calibStruct = _calib.getStruct();
        calibStruct.packet.seq_num = _packetSeqNum++;
        calibStruct.packet.time_secs_utc = pulse->dataStartSeconds();
        calibStruct.packet.time_nano_secs = pulse->dataStartNanoseconds();
        raw = reinterpret_cast<const char *>(&calibStruct);
        _appendPacketForFmq(IWRF_CALIBRATION_ID, raw, sizeof(calibStruct));

    }

    // Publish a scan_segment packet each time scan mode changes and at each
    // configured metadata interval
    iwrf_scan_mode_t scanMode = pulse->scanMode();
    if (do_metadata || (scanMode != _prevScanMode)) {
        iwrf_scan_segment_t scanSegment;
        iwrf_scan_segment_init(scanSegment);

        scanSegment.packet.seq_num = _packetSeqNum++;
        scanSegment.packet.time_secs_utc = pulse->dataStartSeconds();
        scanSegment.packet.time_nano_secs = pulse->dataStartNanoseconds();

        // Set the needed elements based on the current scan mode
        scanSegment.scan_mode = scanMode;
        switch (scanMode) {
        case IWRF_SCAN_MODE_POINTING:
            scanSegment.az_manual = pulse->beamAzimuth();
            scanSegment.el_manual = pulse->beamElevation();
            break;
        case IWRF_SCAN_MODE_SECTOR:
            scanSegment.left_limit = HCR_Beam::AZ_SCAN_MIN;
            scanSegment.right_limit = HCR_Beam::AZ_SCAN_MAX;
            scanSegment.current_fixed_angle = pulse->beamElevation();
            break;
        case IWRF_SCAN_MODE_RHI:
            scanSegment.down_limit = HCR_Beam::EL_SCAN_MIN;
            scanSegment.up_limit = HCR_Beam::EL_SCAN_MAX;
            scanSegment.current_fixed_angle = pulse->beamAzimuth();
            break;
        default:
            ELOG << "No scan_segment handling for scan mode " << scanMode;
        }

        // We use the polarization mode name as the segment name for ease in
        // configuring HawkEye displays
        strncpy(scanSegment.segment_name,
                HCR_Config::PolarizationModeName(_config.polarization_mode()).c_str(),
                IWRF_MAX_SEGMENT_NAME - 1);

        // Append the packet contents to the FMQ output message
        auto raw = reinterpret_cast<const char *>(&scanSegment);
        _appendPacketForFmq(IWRF_SCAN_SEGMENT_ID, raw, sizeof(scanSegment));
    }
    _prevScanMode = scanMode;
}

void
IwrfPublisher::_assembleIwrfPulsePacket(const _MergedPulsePtr & pulse,
                                        std::vector<char> & pktBuf) {
    const std::vector<int32_t> & data = pulse->data();
    uint16_t nGates = data.size() / 2;  // data contains I + Q for each gate
    uint32_t dataSizeBytes = data.size() * sizeof(data[0]);

    int pulseMsgLen = sizeof(iwrf_pulse_header) + dataSizeBytes;

    // Build the IWRF pulse header struct
    iwrf_pulse_header pulseHdr;

    iwrf_pulse_header_init(pulseHdr);

    pulseHdr.packet.len_bytes = pulseMsgLen;
    pulseHdr.packet.seq_num = _packetSeqNum++;
    pulseHdr.packet.time_secs_utc = pulse->dataStartSeconds();
    pulseHdr.packet.time_nano_secs = pulse->dataStartNanoseconds();

    pulseHdr.pulse_seq_num = pulse->seqNum();
    pulseHdr.prt = _config.prt();
    pulseHdr.pulse_width_us = _tsProc.pulse_width_us;
    pulseHdr.n_gates = nGates;
    pulseHdr.n_channels = 1;
    pulseHdr.iq_encoding = IWRF_IQ_ENCODING_SCALED_SI32;
    pulseHdr.hv_flag =
            (pulse->txPolarization() == HCR_Beam::POL_HORIZONTAL) ? 1 : 0;
    pulseHdr.phase_cohered = true;
    pulseHdr.n_data = nGates * 2;
    pulseHdr.iq_offset[0] = 0;         // just the one channel...
    double ddcCountScale = (_pulseType == PULSE_LONG) ?
            _config.iqcount_scale_for_mw(0) : _config.iqcount_scale_for_mw(1);
    pulseHdr.scale = 1.0 / ddcCountScale;
    pulseHdr.offset = 0.0;
    pulseHdr.n_gates_burst = 0;
    pulseHdr.start_range_m = _tsProc.start_range_m;
    pulseHdr.gate_spacing_m = _tsProc.gate_spacing_m;

    pulseHdr.scan_mode = pulse->scanMode();
    pulseHdr.sweep_num = pulse->sweepNumber();
    pulseHdr.volume_num = pulse->volumeNumber();
    pulseHdr.elevation = pulse->beamElevation();
    pulseHdr.azimuth = pulse->beamAzimuth();

    switch (pulse->scanMode()) {
      case IWRF_SCAN_MODE_POINTING:
        pulseHdr.fixed_el = pulse->beamElevation();
        pulseHdr.fixed_az = pulse->beamAzimuth();
        break;
      case IWRF_SCAN_MODE_RHI:
        pulseHdr.fixed_az = pulse->beamAzimuth();
        break;
      case IWRF_SCAN_MODE_SECTOR:
      default:
        pulseHdr.fixed_el = pulse->beamElevation();
    }

    // Stuff header + data into the buffer
    auto raw = reinterpret_cast<const char *>(&pulseHdr);
    pktBuf.assign(raw, raw + sizeof(pulseHdr));

    raw = reinterpret_cast<const char *>(data.data());
    pktBuf.insert(pktBuf.end(), raw, raw + dataSizeBytes);
}

void
IwrfPublisher::_assembleIwrfBurstPacket(const _MergedPulsePtr & pulse,
                                        std::vector<char> & pktBuf) {
    const std::vector<int32_t> & burstData = pulse->xmitSampleData();
    uint16_t nGates = burstData.size() / 2;  // data contains I + Q for each gate
    uint32_t dataSizeBytes = burstData.size() * sizeof(burstData[0]);

    int msgLen = sizeof(iwrf_burst_header) + dataSizeBytes;

    // Build the IWRF burst header struct
    iwrf_burst_header burstHdr;

    iwrf_burst_header_init(burstHdr);

    burstHdr.packet.len_bytes = msgLen;
    burstHdr.packet.seq_num = _packetSeqNum++;
    burstHdr.packet.time_secs_utc = pulse->dataStartSeconds();
    burstHdr.packet.time_nano_secs = pulse->dataStartNanoseconds();

    burstHdr.pulse_seq_num = pulse->seqNum();
    burstHdr.n_samples = nGates;
    burstHdr.channel_id = 0;
    burstHdr.iq_encoding = IWRF_IQ_ENCODING_SCALED_SI32;
    double ddcCountScale = (_pulseType == PULSE_LONG) ?
            _config.iqcount_scale_for_mw(2) : _config.iqcount_scale_for_mw(3);
    burstHdr.scale = 1.0 / ddcCountScale;
    burstHdr.offset = 0.0;              // TODO: fix this
    burstHdr.power_dbm = 20.0;          // TODO: fix this
    burstHdr.phase_deg = 0.0;           // TODO: fix this
    burstHdr.freq_hz = 6.0e9;           // TODO: fix this
    burstHdr.sampling_freq_hz = 10.0e6; // TODO: fix this
    burstHdr.pulse_width_sec = _config.tx_pulsewidth();

    // Stuff header + data into the raw buffer
    auto raw = reinterpret_cast<const char *>(&burstHdr);
    pktBuf.assign(raw, raw + sizeof(burstHdr));

    raw = reinterpret_cast<const char *>(burstData.data());
    pktBuf.insert(pktBuf.end(), raw, raw + dataSizeBytes);
}

void
IwrfPublisher::_openFmq() {
    // initialize the output FMQ
    std::string fmqPath = (_pulseType == PULSE_SHORT) ? 
            _config.fmq_path_short_pulse() : _config.fmq_path_long_pulse();
    uint32_t nSlots = _config.fmq_nslots();
    uint32_t slotSize = _config.fmq_slot_size();
    int status = _fmq.initReadWrite(fmqPath.c_str(), _name.c_str(),
                                    false,      // debug?
                                    Fmq::END,   // start position
                                    false,      // compression
                                    nSlots,
                                    nSlots * slotSize);
    if (status != 0) {
        std::ostringstream os;
        os << "Failed to initialize FMQ '" << fmqPath << "': " <<
               _fmq.getErrStr();
        throw(std::runtime_error(os.str()));
    }
    _fmq.setSingleWriter();

    // initialize message
    _fmqMsg.clearAll();
    _fmqMsg.setType(0);
}

void
IwrfPublisher::_appendPacketForFmq(int32_t pktType,
                                   const std::vector<char> & pktBuf) {
    // Cast the vector into a void* and call the overloaded method
    _appendPacketForFmq(pktType, reinterpret_cast<const void *>(&pktBuf[0]),
                        pktBuf.size());
}

void
IwrfPublisher::_appendPacketForFmq(int32_t pktType, const void * buf,
                                   ssize_t bufLen) {
    // Append this packet as the next part of the FMQ output message
    _fmqMsg.addPart(pktType, bufLen, buf);

    // If the output message contains enough parts, actually write to the FMQ
    static const int NPULSES_PER_MESSAGE = 16;
    if (_fmqMsg.getNParts() >= NPULSES_PER_MESSAGE) {
        void *buf = _fmqMsg.assemble();
        int len = _fmqMsg.lengthAssembled();
        if (_fmq.writeMsg(0, 0, buf, len)) {
            ELOG << "Failed to write " << _fmqMsg.getNParts() <<
                    " IWRF packets to FMQ '" << _fmq.getFmqPath() << "'";
        }

        // We're done with the current contents of _outputMsg
        _fmqMsg.clearParts();
    }
}

///////////////////////////////////////////////////////////////////////////////
//// assemble IWRF status packet
//
//void IwrfPublisher::_assembleStatusPacket()
//
//{
//
//    // assemble the xml
//
//    string xmlStr = _assembleStatusXml();
//    _xmlLen = ((xmlStr.size() + 7) / 8) * 8; // round up to 8-bytes
//
//    // allocate buffer
//
//    _allocStatusBuf();
//
//    // set header
//
//    iwrf_status_xml_t hdr;
//    iwrf_status_xml_init(hdr);
//    hdr.xml_len = _xmlLen;
//    hdr.packet.len_bytes = _statusMsgLen;
//    hdr.packet.seq_num = _packetSeqNum++;
//
//    // copy data into buffer
//
//    memset(_statusBuf, 0, _statusBufLen);
//    memcpy(_statusBuf, &hdr, sizeof(iwrf_status_xml_t));
//    memcpy(_statusBuf + sizeof(iwrf_status_xml_t),
//           xmlStr.c_str(), xmlStr.size());
//
//}

///////////////////////////////////////////////////////////////////////////////
//// assemble status XML
//// returns the XML string
//
//std::string IwrfPublisher::_assembleStatusXml()
//{
//
//    string xml;
//
//    // main block
//
//    xml += TaXml::writeStartTag("HcrStatus", 0);
//
//    ///////////////////////////////////////////////////////
//    // transmit block
//
//    xml += TaXml::writeStartTag("HcrTransmitterStatus", 1);
//
//    const XmitStatus &xs = _monitor.transmitterStatus();
//    xml += xs.toTaXmlString(2);
//
//    xml += TaXml::writeEndTag("HcrTransmitterStatus", 1);
//
//    ///////////////////////////////////////////////////////
//    // receive block
//
//    xml += TaXml::writeStartTag("HcrReceiverStatus", 1);
//
//    // Start with status from the PMC-730 card
//    const HcrPmc730Status pmc730Status = _monitor.pmc730Status();
//
//    // ints
//
//    xml += TaXml::writeInt
//            ("HmcMode", 2, pmc730Status.hmcMode());
//
//    // floats
//
//    xml += TaXml::writeDouble
//            ("DetectedRfPower", 2, pmc730Status.detectedRfPower());
//
//    // booleans
//
//    xml += TaXml::writeBoolean
//            ("ApsValveOpen", 2, pmc730Status.apsValveOpen());
//
//    // Status from hcrdrx
//    const DrxStatus drxStatus = _monitor.drxStatus();
//
//    xml += TaXml::writeDouble
//            ("PentekFpgaTemp", 2, drxStatus.pentekFpgaTemp());
//
//    xml += TaXml::writeDouble
//            ("PentekBoardTemp", 2, drxStatus.pentekBoardTemp());
//
//    // end receive status
//
//    xml += TaXml::writeEndTag("HcrReceiverStatus", 1);
//
//    ////////////////////////////////////////////////
//    // close
//
//    xml += TaXml::writeEndTag("HcrStatus", 0);
//
//    return xml;
//
//}

///////////////////////////////////////////////////////////////////////////////
//// send out the IWRF status packet
//
//int IwrfPublisher::_sendIwrfStatusXmlPacket()
//{
//
//    bool closeSocket = false;
//
//    if (_sock && _sock->writeBuffer(_statusBuf, _statusMsgLen)) {
//        ELOG << _name << ": ERROR - IwrfPublisher::_sendIwrfStatusXmlPacket()";
//        ELOG << _name << ":   Writing status xml packet";
//        ELOG << _name << ":   " << _sock->getErrStr();
//        closeSocket = true;
//    }
//
//    if (closeSocket) {
//        _closeSocketToClient();
//        return -1;
//    }
//
//    return 0;
//
//}

//
// Implementation for inner class _MergedPulseData below
//

IwrfPublisher::_MergedPulseData::_MergedPulseData(uint64_t pulseSeqNum) :
            _pulseSeqNum(pulseSeqNum),
            _data(NULL),
            _xmitSampleData(NULL) {}

IwrfPublisher::_MergedPulseData::~_MergedPulseData() {}

uint32_t
IwrfPublisher::_MergedPulseData::dataStartSeconds() const {
    if (! complete()) {
        return(0);
    }
    return(_data->timeSecs());
}

uint32_t
IwrfPublisher::_MergedPulseData::dataStartNanoseconds() const {
    if (! complete()) {
        return(0);
    }
    return(_data->timeNanosecs());
}

uint32_t
IwrfPublisher::_MergedPulseData::burstStartSeconds() const {
    if (! complete()) {
        return(0);
    }
    return(_xmitSampleData->timeSecs());
}

uint32_t
IwrfPublisher::_MergedPulseData::burstStartNanoseconds() const {
    if (! complete()) {
        return(0);
    }
    return(_xmitSampleData->timeNanosecs());
}

HCR_Beam::Polarization
IwrfPublisher::_MergedPulseData::txPolarization() const {
    if (! complete()) {
        return(HCR_Beam::POL_UNKNOWN);
    }
    return(_data->beamConfig().txPolarization());
}

HCR_Beam::Polarization
IwrfPublisher::_MergedPulseData::rxPolarization() const {
    if (! complete()) {
        return(HCR_Beam::POL_UNKNOWN);
    }
    return(_data->beamConfig().rxPolarization());
}

double
IwrfPublisher::_MergedPulseData::beamAzimuth() const {
    if (! complete()) {
        return(0.0);
    }
    return(_data->beamConfig().beamAzimuth());
}

double
IwrfPublisher::_MergedPulseData::beamElevation() const {
    if (! complete()) {
        return(0.0);
    }
    return(_data->beamConfig().beamElevation());
}

iwrf_scan_mode_t
IwrfPublisher::_MergedPulseData::scanMode() const {
    return(_data->beamConfig().scanMode());
}

int
IwrfPublisher::_MergedPulseData::sweepNumber() const {
    return(_data->beamConfig().sweepNumber());
}

int
IwrfPublisher::_MergedPulseData::volumeNumber() const {
    return(_data->volumeNumber());
}

bool
IwrfPublisher::_MergedPulseData::complete() const {
    // The pulse is ready when we have both normal data and the burst transmit
    // sample data.
    return(_data && _xmitSampleData);
}

void
IwrfPublisher::_MergedPulseData::setData(_ChannelPulsePtr data) {
    if (_data) {
        WLOG << "Overwriting chan " << data->channelId() <<
                " data @ pulse number " << seqNum();
    }
    // Ensure that data and transmit sample data are from the same pulse and
    // carry the same beam configuration
    if (_xmitSampleData) {
        assert(_xmitSampleData->pulseSeqNum() == data->pulseSeqNum());
        assert(_xmitSampleData->beamConfig() == data->beamConfig());
    }
    _data = data;
}

void
IwrfPublisher::_MergedPulseData::setXmitSampleData(_ChannelPulsePtr xmitSampleData) {
    if (_xmitSampleData) {
        WLOG << "Overwriting chan " << xmitSampleData->channelId() <<
                " xmit sample data @ pulse number " << seqNum();
    }
    // Ensure that data and transmit sample data are from the same pulse and
    // carry the same beam configuration
    if (_data) {
        assert(_data->pulseSeqNum() == xmitSampleData->pulseSeqNum());
        assert(_data->beamConfig() == xmitSampleData->beamConfig());
    }
    _xmitSampleData = xmitSampleData;
}
