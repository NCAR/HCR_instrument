/*
 * TransmitControl.h
 *
 *  Created on: Oct 10, 2014
 *      Author: burghart
 */

#ifndef TRANSMITCONTROL_H_
#define TRANSMITCONTROL_H_

#include <vector>

#include <CmigitsShmWatchThread.h>
#include <HcrPmc730Client.h>
#include <MotionControlStatusThread.h>
#include <QObject>
#include <QTimer>
#include <xmlrpc-c/client_simple.hpp>

class HcrPmc730StatusThread;
class MaxPowerClient;

/// Class providing implementation for handling the transmitter high voltage 
/// enable line, monitoring for whether conditions allow for safe 
/// transmission.
class TransmitControl : public QObject {
    Q_OBJECT
    
    // Give HcrMonitorStatus direct access to our members
    friend class HcrMonitorStatus;
public:
    /// @brief Instantiate using the given HcrPmc730StatusThread as the source 
    /// of status from HcrPmc730Daemon.
    /// @param hcrPmc730StatusThread the HcrPmc730StatusThread which will 
    /// provide status from HcrPmc730Daemon
    /// @param mcStatusThread the MotionControlStatusThread which will provide
    /// status from MotionControlDaemon
    /// @param maxPowerThread the MaxPowerClient thread which will provide
    /// updates on maximum received power
    TransmitControl(HcrPmc730StatusThread & hcrPmc730StatusThread,
            MotionControlStatusThread & mcStatusThread, 
            MaxPowerClient & maxPowerThread);
    virtual ~TransmitControl();
    
    /// @brief Enum for status of tests of whether we can transmit
    typedef enum {
        XMIT_ALLOWED,                   ///< OK to transmit
        
        BEGIN_ATTENUATE_MODES,  // Modes which require attenuation between here
                                // and BEGIN_NOXMIT_MODES
        
        ATTENUATE_TOO_LOW_FOR_NADIR_POINTING,   ///< AGL altitude is too low for nadir pointing
        ATTENUATE_RCVD_POWER_TOO_HIGH,          ///< max received power is too high
        
        BEGIN_NOXMIT_MODES,    // ALL NO TRANSMIT MODES *MUST* BE BELOW THIS LINE!
        
        NOXMIT_UNSPECIFIED,             ///< Unspecified reason, used as initial state for _xmitTestStatus
        NOXMIT_NO_HCRPMC730_DATA,       ///< HcrPmc730Daemon is not providing data
        NOXMIT_NO_CMIGITS_DATA,         ///< cmigitsDaemon is not providing data
        NOXMIT_NO_TERRAINHTSERVER_DATA, ///< TerrainHtServer is not providing data
        NOXMIT_NO_MOTIONCONTROL_DATA,   ///< MotionControlDaemon is not providing data
        NOXMIT_NO_MAXPOWER_DATA,        ///< TsPrint max power server is not providing data
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
    
private slots:
    /// @brief Accept a new status from HcrPmc730Daemon and react if necessary
    /// @param status the new status from HcrPmc730Daemon
    void _updateHcrPmc730Status(HcrPmc730Status status);

    /// @brief Note a responsiveness change for HcrPmc730Daemon
    /// @param responding true if the daemon is now responsive, false if it's
    /// now unresponsive
    /// @param msg a string describing the responsiveness change
    void _updateHcrPmc730Responsive(bool responding, QString msg);

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
    /// @param dataTime the time for the max power report, seconds since
    /// 1970-01-01 00:00:00 UTC
    /// @param maxPower the maximum power received, dBm
    /// @param rangeToMax the range to the maximum received power, m
    void _updateMaxPower(double dataTime, double maxPower, double rangeToMax);

    /// @brief Note a responsiveness change for the TsPrint max power server
    /// @param responding true if the server is now responsive, false if it's
    /// now unresponsive
    /// @param msg a string describing the responsiveness change
    void _updateMaxPowerResponsive(bool responding, QString msg);

    /// @brief Mark the cmigitsDaemon as unresponsive
    void _markCmigitsUnresponsive();
    
    /// @brief Update AGL altitude using new location from C-MIGITS data
    void _updateAglAltitude(CmigitsSharedMemory::ShmStruct cmigitsData);
    
private:
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
    
    /// @brief Return true iff the given HMC mode is an attenuated mode.
    /// @param mode the mode to be tested
    /// @return true iff the given HMC mode is an attenuated mode.
    static bool _HmcModeIsAttenuated(HcrPmc730::HmcOperationMode mode);
    
    /// @brief Return true iff the requested HMC mode is attenuated or has a
    /// matching attenuated mode.
    /// @return true iff the requested HMC mode is attenuated or has a
    /// matching attenuated mode.
    bool _attenuatedModeAvailable();
    
    /// @brief Return the attenuated version of the given mode if it exists, 
    /// otherwise HcrPmc730::HMC_MODE_INVALID. If the given mode is already 
    /// attenuated, the same mode is returned.
    /// @param mode the mode to be tested
    /// @return the attenuated version of the given mode if it exists, 
    /// otherwise HcrPmc730::HMC_MODE_INVALID.
    static HcrPmc730::HmcOperationMode _EquivalentAttenuatedMode(HcrPmc730::HmcOperationMode mode);
    
    /// @brief How frequently will we poll CmigitsSharedMemory for new data?
    static const int _CMIGITS_POLL_INTERVAL_MS = 1000;
    
    /// @brief After what period do we consider C-MIGITS data too old?
    static const int _CMIGITS_DATA_TIMEOUT_MS = 1100;
    
    /// @brief Tolerance for near-zenith pointing, deg
    static const float _NEAR_ZENITH_TOLERANCE_DEG = 45.0;
    
    /// @brief Tolerance for near-nadir pointing, deg
    static const float _NEAR_NADIR_TOLERANCE_DEG = 45.0;
    
    /// @brief Minimum pressure vessel pressure for allowing high voltage in the
    /// transmitter.
    static const float _PV_MINIMUM_PRESSURE_PSI = 11.0;
    
    /// @brief Received power threshold at which we shift to attenuated mode
    /// or disallow transmit, dBm
    static const float _RECEIVED_POWER_THRESHOLD = -34.0;
    
    /// @brief Minimum altitude AGL for non-zenith transmit, m
    static const int _XMIT_NONZENITH_AGL_LIMIT = 1000;
    
    /// @brief Minimum altitude AGL for near-nadir transmit over land, m
    static const int _XMIT_NADIR_AGL_LIMIT_LAND = 1000;
    
    /// @brief Minimum altitude AGL for near-nadir transmit over land, m
    static const int _XMIT_NADIR_AGL_LIMIT_WATER = 1500;
    
    /// @brief AGL altitude below which we should attenuate receive for
    /// near-nadir pointing over land, m
    static const int _ATTENUATED_NADIR_AGL_LIMIT_LAND = 1500;
    
    /// @brief AGL altitude below which we should attenuate receive for
    /// near-nadir pointing over water, m
    static const int _ATTENUATED_NADIR_AGL_LIMIT_WATER = 4800;
    
    /// @brief Perform monitoring tests based on latest status and react 
    /// appropriately.
    void _handleNewStatus();
    
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
    
    /// @brief data time for max power values, seconds since 1970-01-01 00:00:00 UTC
    double _maxPowerDataTime;
    
    /// @brief latest max received power, dBm
    double _maxPower;
    
    /// @brief range to latest max received power, m
    double _rangeToMaxPower;
    
    /// @brief Thread which monitors the CmigitsSharedMemory segment
    CmigitsShmWatchThread _cmigitsWatchThread;

    /// @brief Is new data showing up in CmigitsSharedMemory?
    bool _cmigitsResponsive;
    
    /// @brief Is the TerrainHtServer responsive?
    bool _terrainHtServerResponsive;
    
    /// @brief last AGL altitude
    double _aglAltitude;
    
    /// @brief Are we over water?
    bool _overWater;
    
    /// @brief User's intended state for transmitter high voltage
    bool _hvRequested;
    
    /// @brief User's intended HMC mode
    HcrPmc730::HmcOperationMode _requestedHmcMode;
    
    /// @brief Current reason for disabling transmit (XMIT_ALLOWED if transmit
    /// is currently allowed)
    XmitTestStatus _xmitTestStatus;
};

#endif /* TRANSMITCONTROL_H_ */
