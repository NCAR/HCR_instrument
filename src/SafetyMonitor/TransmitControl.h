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

/// Class providing implementation for handling transmitter control lines
/// (filament and high voltage), including monitoring for whether conditions
/// allow for safe transmission.
class TransmitControl : public QObject {
    Q_OBJECT
public:
    /// @brief Instantiate using the given HcrPmc730StatusThread as the source 
    /// of status from HcrPmc730Daemon.
    /// @param hcrPmc730StatusThread the HcrPmc730StatusThread which will 
    /// provide status from HcrPmc730Daemon
    /// @param mcStatusThread the MotionControlStatusThread which will provide
    /// status from MotionControlDaemon
    TransmitControl(HcrPmc730StatusThread & hcrPmc730StatusThread,
            MotionControlStatusThread & mcStatusThread);
    virtual ~TransmitControl();
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

    /// @brief Mark the cmigitsDaemon as unresponsive
    void _markCmigitsUnresponsive();
    
    /// @brief Update AGL altitude using new location from C-MIGITS data
    void _updateAglAltitude(CmigitsSharedMemory::ShmStruct cmigitsData);
    
private:
    /// @brief How frequently will we poll CmigitsSharedMemory for new data?
    static const int CMIGITS_POLL_INTERVAL_MS = 1000;
    
    /// @brief After what period do we consider C-MIGITS data too old?
    static const int CMIGITS_DATA_TIMEOUT_MS = 1100;
    
    /// @brief Minimum pressure vessel pressure for allowing high voltage in the
    /// transmitter.
    static const float _PV_MINIMUM_PRESSURE_PSI = 11.0;
    
    /// @brief Minimum altitude AGL for near-nadir transmit over land
    static const int _XMIT_AGL_ALT_LIMIT_LAND = 1000;   // meters
    
    /// @brief Minimum altitude AGL for near-nadir transmit over land
    static const int _XMIT_AGL_ALT_LIMIT_WATER = 1500;  // meters
    
    /// @brief AGL altitude below which we should attenuate receive if over water
    static const int _ATTENUATED_AGL_ALT_LIMIT_LAND = 1800; // meters
    
    /// @brief AGL altitude below which we should attenuate receive if over water
    static const int _ATTENUATED_AGL_ALT_LIMIT_WATER = 4800; // meters
    
    /// @brief Disable transmit
    /// @param reason a string describing the reason transmit is disabled
    void _disableTransmit(std::string reason);
    
    /// @brief Perform monitoring tests based on latest status and react 
    /// appropriately.
    void _doChecks();
    
    /// @brief Basic XML-RPC client instance
    xmlrpc_c::clientSimple _xmlrpcClient;
    
    /// @brief Is HcrPmc730Daemon currently responsive?
    bool _hcrPmc730Responsive;
    
    /// @brief Latest status received from HcrPmc730Daemon.
    HcrPmc730Status _hcrPmc730Status;
    
    /// @brief Is MotionControlDaemon currently responsive?
    bool _motionControlResponsive;
    
    /// @brief Latest status received from HcrPmc730Daemon.
    MotionControl::Status _motionControlStatus;
    
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
};

#endif /* TRANSMITCONTROL_H_ */
