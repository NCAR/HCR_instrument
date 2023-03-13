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
/*
 * TransmitControl.h
 *
 *  Created on: Oct 10, 2014
 *      Author: burghart
 */

#ifndef TRANSMITCONTROL_H_
#define TRANSMITCONTROL_H_

#include <vector>

#include <CmigitsFmqWatcher.h>
#include <HcrPmc730Client.h>
#include <MotionControlStatusWorker.h>
#include <QDateTime>
#include <QObject>
#include <QTimer>
#include <xmlrpc-c/client_simple.hpp>

class HcrPmc730StatusWorker;
class MaxPowerFmqClient;

/// Class providing implementation for handling the transmitter high voltage
/// enable line, monitoring for whether conditions allow for safe
/// transmission.
class TransmitControl : public QObject {
    Q_OBJECT

    // Give HcrExecutiveStatus direct access to our members
    friend class HcrExecutiveStatus;
public:
    /// @brief Instantiate using the given HcrPmc730StatusWorker as the source
    /// of status from HcrPmc730Daemon.
    /// @param hcrPmc730StatusWorker the HcrPmc730StatusWorker which will
    /// provide status from HcrPmc730Daemon
    /// @param mcStatusWorker the MotionControlStatusWorker which will provide
    /// status from MotionControlDaemon
    /// @param maxPowerClient the MaxPowerFmqClient which will provide
    /// updates on maximum received power
    TransmitControl(HcrPmc730StatusWorker & hcrPmc730StatusWorker,
                    MotionControlStatusWorker & mcStatusWorker,
                    MaxPowerFmqClient & maxPowerClient);
    virtual ~TransmitControl();

    /// @brief Enum for status of tests of whether we can transmit
    typedef enum {
        XMIT_ALLOWED,                   ///< OK to transmit

        BEGIN_ATTENUATE_MODES,  // Modes which require attenuation MUST be between
                                // BEGIN_ATTENUATE_MODES and BEGIN_NOXMIT_MODES

        ATTENUATE_TOO_LOW_FOR_NADIR_POINTING,   ///< AGL altitude is too low for nadir pointing
        ATTENUATE_RCVD_POWER_TOO_HIGH,          ///< max received power is too high

        BEGIN_NOXMIT_MODES,    // ALL NO TRANSMIT MODES *MUST* BE BELOW THIS LINE!

        NOXMIT_UNSPECIFIED,             ///< Unspecified reason, used as initial state for _xmitTestStatus
        NOXMIT_NO_HCRPMC730_DATA,       ///< HcrPmc730Daemon is not providing data
        NOXMIT_NO_INS_DATA,             ///< INS reader daemon is not providing data
        NOXMIT_NO_TERRAINHTSERVER_DATA, ///< TerrainHtServer is not providing data
        NOXMIT_NO_MOTIONCONTROL_DATA,   ///< MotionControlDaemon is not providing data
        NOXMIT_NO_MAXPOWER_DATA,        ///< TsPrint max power server is not providing data
        NOXMIT_FILAMENT_OFF,            ///< Transmitter filament is off
        NOXMIT_PV_PRESSURE_LOW,         ///< Pressure vessel pressure is too low
        NOXMIT_TOO_LOW_FOR_NONZENITH,   ///< AGL altitude too low for non-zenith pointing
        NOXMIT_TOO_LOW_FOR_NADIR_POINTING,  ///< AGL altitude too low for near-nadir pointing
        NOXMIT_DRIVES_NOT_HOMED,        ///< MotionControl drives not homed, so pointing angle is unknown
        NOXMIT_RCVD_POWER_TOO_HIGH,     ///< Received power is too high
        NOXMIT_ATTENUATE_BUG,           ///< Bug in TransmitControl
    } XmitTestStatus;

    /// @brief Return true iff transmit is currently allowed
    /// @return true iff transmit is currently allowed
    bool transmitAllowed() const {
        return(_xmitTestStatus < BEGIN_NOXMIT_MODES);
    }

    /// @brief Return true iff attenuated receive mode is required
    /// @return true iff attenuated receive mode is required
    bool attenuationRequired() const {
        return(_xmitTestStatus > BEGIN_ATTENUATE_MODES &&
                _xmitTestStatus < BEGIN_NOXMIT_MODES);
    }

    /// @brief Set the requested Operation mode
    /// @param mode the requested Operation mode
    void setRequestedOperationMode(OperationMode& mode);

    /// @brief Set the requested high voltage on state
    /// @param hvRequested true if HV on is desired, false if HV off is desired
    void setHvRequested(bool hvRequested);

    /// @brief Return the latest HcrPmc730Status obtained
    /// @return the latest HcrPmc730Status obtained
    HcrPmc730Status hcrPmc730Status() const { return(_hcrPmc730Status); }

    /// @brief Return the latest MotionControl::Status obtained
    /// @return the latest MotionControl::Status obtained
    MotionControl::Status motionControlStatus() const { return(_motionControlStatus); }

private slots:
    /// @brief Accept a new status from HcrPmc730Daemon and react if necessary
    /// @param status the new status from HcrPmc730Daemon
    void _updateHcrPmc730Status(HcrPmc730Status status);

    /// @brief Note a responsiveness change for HcrPmc730Daemon
    /// @param responding true if the daemon is now responsive, false if it's
    /// now unresponsive
    /// @param msg a string describing the responsiveness change
    void _updateHcrPmc730Responsive(bool responding, QString msg);

    /// @brief Deal with a change in HMC operation mode.
    /// @param mode the new HMC operation mode
    /// @param modeChangeTime the time at which the mode was changed, double
    /// precision seconds since 1970-01-01 00:00:00 UTC
    void _recordOperationModeChange(const OperationMode& mode,
                               double modeChangeTime);

    /// @brief Accept a new status from MotionControlDaemon and react if necessary
    /// @param status the new status from MotionControlDaemon
    void _updateMotionControlStatus(MotionControl::Status status);

    /// @brief Note a responsiveness change for MotionControlDaemon
    /// @param responding true if the daemon is now responsive, false if it's
    /// now unresponsive
    /// @param msg a string describing the responsiveness change
    void _updateMotionControlResponsive(bool responding, QString msg);

    /// @brief Accept a new max power from the TsPrint max power server and
    /// react if necessary
    /// @param dataTime center time of the period sampled for this max power
    /// report, seconds since 1970-01-01 00:00:00 UTC
    /// @param dwellPeriod the length of time over which max power was
    ///    sampled, s
    /// @param peakMaxPower the maximum power measured, dBm
    /// @param rangeToPeakMax the range from the radar to the peak maximum power
    ///    return, m
    /// @param meanMaxPower mean maximum power, averaged over the max power
    ///    server's dwell time, dBm
    void _updateMaxPower(double dataTime, double dwellPeriod,
            double peakMaxPower, double rangeToPeakMax, double meanMaxPower);

    /// @brief Note a responsiveness change for the TsPrint max power server
    /// @param responding true if the server is now responsive, false if it's
    /// now unresponsive
    /// @param msg a string describing the responsiveness change
    void _updateMaxPowerResponsive(bool responding, QString msg);

    /// @brief Mark the INS daemon responsive
    void _markInsResponsive();

    /// @brief Mark the INS daemon unresponsive
    void _markInsUnresponsive();

    /// @brief Update AGL altitude using new location from INS data
    void _updateAglAltitude(CmigitsFmq::MsgStruct cmigitsData);

private:
    /// @brief Struct for details of max power data reports
    typedef struct {
        /// @brief center time of period sampled for max power, seconds since
        /// 1970-01-01 00:00:00 UTC
        double dataTime;
        /// @brief peak max received power, dBm
        double peakMaxPower;
        /// @brief range to peak max received power, m
        double rangeToPeakMaxPower;
        /// @brief time-averaged mean max power, over the max power server's
        /// dwell period, dBm
        double meanMaxPower;
        /// @brief true iff the whole period sampled for max power was collected
        /// in attenuated receive mode
        bool attenuated;
    } _MaxPowerStruct;

    /// @brief Normalize the given angle in degrees into the interval [0, 360)
    /// @param angle the angle in degrees to be normalized
    /// @return the given angle normalized into the interval [0, 360)
    static double _NormalizeAngle(double angle) {
        angle = fmod(angle, 360.0);
        return(angle < 0 ? (angle + 360.0) : angle);
    }

    /// @brief Return true iff the two given arcs on a circle overlap
    /// @param ccwLimit1 counterclockwise limit of the first arc
    /// @param cwLimit1 clockwise limit of the first arc
    /// @param ccwLimit2 counterclockwise limit of the second arc
    /// @param cwLimit2 clockwise limit of the second arc
    /// @return true iff the two arcs overlap
    static double _ArcsOverlap(double ccwLimit1, double cwLimit1,
            double ccwLimit2, double cwLimit2);

    /// @brief Return true iff the given arc contains the given angle
    /// @param ccwLimit counterclockwise limit of the arc, deg
    /// @param cwLimit clockwise limit of the arc, deg
    /// @param angle the angle to be tested
    /// @return Return true iff the given arc contains the given angle
    static double _ArcContainsAngle(double ccwLimit, double cwLimit, double angle) {
        return(_ArcsOverlap(ccwLimit, cwLimit, angle, angle));
    }

    /// @brief Return true iff the first arc completely contains the
    /// second arc.
    /// @param ccwLimit1 counterclockwise limit of the first arc
    /// @param cwLimit1 clockwise limit of the first arc
    /// @param ccwLimit2 counterclockwise limit of the second arc
    /// @param cwLimit2 clockwise limit of the second arc
    /// @return true iff arc1 completely contains arc2
    static double _ArcContainsArc(double ccwLimit1, double cwLimit1,
            double ccwLimit2, double cwLimit2);

    /// @brief Test if transmit is currently allowed and return the appropriate
    /// XmitTestStatus.
    /// @return the currently appropriate XmitTestStatus
    XmitTestStatus _runTransmitTests();

    /// @brief Return a string describing the the current _xmitTestStatus
    /// @return a string describing the the current _xmitTestStatus
    std::string _xmitTestStatusText() const;

    /// @brief Set the _xmitTestStatus member with a log message if its
    /// value is changed.
    void _setXmitTestStatus(XmitTestStatus status);

    /// @brief Return true iff attenuated receive mode is currently required,
    /// and set the given message to describe the result of the test.
    /// @param[out] msg the returned message string describing the result of
    /// the test
    /// @return true iff attenuated receive mode is currently required
    bool _testIfAttenuationIsRequired(std::string & msg);

    /// @brief Return the minimum AGL altitude (m) for transmitting when
    /// pointing near nadir.
    /// @return the minimum AGL altitude (m) for transmitting when pointing
    /// near nadir.
    double _xmitNadirAglMinimum() const {
        return(_overWater ? _XMIT_NADIR_AGL_LIMIT_WATER : _XMIT_NADIR_AGL_LIMIT_LAND);
    }

    /// @brief Return the minimum AGL altitude (m) for unattenuated receive when
    /// pointing near nadir.
    /// @return the minimum AGL altitude (m) for unattenuated receive when
    /// pointing near nadir.
    double _unattenuatedNadirAglMinimum() const {
        return(_overWater ? _ATTENUATED_NADIR_AGL_LIMIT_WATER : _ATTENUATED_NADIR_AGL_LIMIT_LAND);
    }

    /// @brief Return true iff pointing near zenith or scanning strictly through
    /// near-zenith angles.
    /// @return true iff pointing near zenith or scanning strictly through
    /// near-zenith angles.
    bool _allNearZenithPointing();

    /// @brief Return true iff pointing near nadir or scanning through *any*
    /// near-nadir angles.
    /// @return true iff pointing near nadir or scanning through *any*
    /// near-nadir angles.
    bool _anyNearNadirPointing();

    /// @brief Return true iff the requested Operation mode is attenuated or has a
    /// matching attenuated mode.
    /// @return true iff the requested Operation mode is attenuated or has a
    /// matching attenuated mode.
    bool _attenuatedModeAvailable();

    /// @brief Return true iff the HMC was using attenuated receive mode during
    /// the entire period from startTime to endTime.
    /// @param startTime start time of the period of interest, seconds since
    /// 1970-01-01 00:00:00 UTC
    /// @param endTime end time of the period of interest, seconds since
    /// 1970-01-01 00:00:00 UTC
    bool _timePeriodWasAttenuated(double startTime, double endTime) const;

    /// @brief Tell HcrPmc730Daemon to turn on transmitter HV
    void _xmitHvOn();

    /// @brief Tell HcrPmc730Daemon to turn off transmitter HV
    void _xmitHvOff();

    /// @brief Set the Operation mode on HcrPmc730Daemon
    /// @param mode the Operation mode to use
    void _setOperationMode(const OperationMode& mode);

    /// @brief Return the current Operation mode. We return our local value for
    /// current mode rather than _hcrPmc730Status.operationMode() because we may
    /// have changed the mode but not yet gotten a new status from
    /// HcrPmc730Daemon.
    OperationMode _currentOperationMode() const {
        // Current mode is the last entry in our Operation mode map
        return(_operationModeMap.rbegin()->second);
    }

    /// @brief Clear the map of times to Operation modes
    void _clearOperationModeMap();

    /// @brief Append a mode to our mode map, starting at the current time
    void _appendToModeMap(OperationMode& mode);

    /// @brief How frequently will we poll the INS FMQ for new data?
    static constexpr int _INS_POLL_INTERVAL_MS = 1000;

    /// @brief After what period do we consider INS data too old?
    static constexpr int _INS_DATA_TIMEOUT_MS = 1100;

    /// @brief Tolerance for near-zenith pointing, deg
    static constexpr float _NEAR_ZENITH_TOLERANCE_DEG = 45.0;

    /// @brief Tolerance for near-nadir pointing, deg
    static constexpr float _NEAR_NADIR_TOLERANCE_DEG = 45.0;

    /// @brief Minimum pressure vessel pressure for allowing high voltage in the
    /// transmitter.
    static constexpr float _PV_MINIMUM_PRESSURE_PSI = 11.0;

    /// @brief Received power threshold at which we shift to attenuated mode
    /// or disallow transmit, dBm
    static constexpr float _RECEIVED_POWER_THRESHOLD = -30.0;

    /// @brief Attenuation applied when in attenuated receive mode, dB
    static constexpr float _SWITCH_ATTENUATION = 23.5;

    /// @brief Minimum altitude AGL for non-zenith transmit, m
    static constexpr int _XMIT_NONZENITH_AGL_LIMIT = 1000;

    /// @brief Minimum altitude AGL for near-nadir transmit over land, m
    static constexpr int _XMIT_NADIR_AGL_LIMIT_LAND = 1000;

    /// @brief Minimum altitude AGL for near-nadir transmit over land, m
    static constexpr int _XMIT_NADIR_AGL_LIMIT_WATER = 1500;

    /// @brief AGL altitude below which we should attenuate receive for
    /// near-nadir pointing over land, m
    static constexpr int _ATTENUATED_NADIR_AGL_LIMIT_LAND = 1500;

    /// @brief AGL altitude below which we should attenuate receive for
    /// near-nadir pointing over water, m
    static constexpr int _ATTENUATED_NADIR_AGL_LIMIT_WATER = 4800;

    /// @brief Perform monitoring tests based on latest status and react
    /// appropriately.
    void _updateControlState();

    /// @brief Basic XML-RPC client instance used for TerrainHtServer
    xmlrpc_c::clientSimple _xmlrpcClient;

    /// @brief HcrPmc730Client instance
    HcrPmc730Client & _hcrPmc730Client;

    /// @brief Is HcrPmc730Daemon currently responsive?
    bool _hcrPmc730Responsive;

    /// @brief Latest status received from HcrPmc730Daemon.
    HcrPmc730Status _hcrPmc730Status;

    /// @brief Is MotionControlDaemon currently responsive?
    bool _motionControlResponsive;

    /// @brief Latest status received from HcrPmc730Daemon.
    MotionControl::Status _motionControlStatus;

    /// @brief Is TsPrint max power server currently responsive?
    bool _maxPowerResponsive;

    /// @brief latest max power report
    _MaxPowerStruct _maxPowerReport;

    /// @brief The INS (1 or 2) currently in use to get location for determining
    /// AGL altitude
    int _insInUse;

    /// @brief FMQ watcher for INS data, to signal when new data are available
    CmigitsFmqWatcher _insWatcher;

    /// @brief Is new data showing up in the INS FMQ?
    bool _insResponsive;

    /// @brief Is the TerrainHtServer responsive?
    bool _terrainHtServerResponsive;

    /// @brief last MSL altitude, m
    double _mslAltitude;

    /// @brief last AGL altitude, m
    double _aglAltitude;

    /// @brief Are we over water?
    bool _overWater;

    /// @brief User's intended state for transmitter high voltage
    bool _hvRequested;

    /// @brief User's intended Operation mode
    OperationMode _requestedOperationMode;

    /// @brief Current reason for disabling transmit (XMIT_ALLOWED if transmit
    /// is currently allowed)
    XmitTestStatus _xmitTestStatus;

    /// @brief map of Operation mode change times (seconds since 1970-01-01 00:00:00
    /// UTC) to mode
    std::map<double, OperationMode> _operationModeMap;

    /// @brief Time high voltage was last forced off because of high max power,
    /// seconds since 1970-01-01 00:00:00 UTC, or zero if HV has not been forced off.
    double _timeOfLastHvOffForHighPower;

    /// @brief String describing details of the last time high voltage was
    /// forced off because of high max power.
    std::string _detailsForLastHvOffForHighPower;

};

#endif /* TRANSMITCONTROL_H_ */
