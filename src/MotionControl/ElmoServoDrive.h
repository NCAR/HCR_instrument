/*
 * ElmoServoDrive.h
 *
 *  Created on: Jun 26, 2013
 *      Author: burghart
 */

#ifndef ELMOSERVODRIVE_H_
#define ELMOSERVODRIVE_H_
#include "ElmoConnection.h"
#include <queue>
#include <string>
#include <climits>
#include <cmath>
#include <cstring>
#include <stdint.h>
#include <vector>
#include <sys/time.h>
#include <QObject>
#include <QTimer>

/// @brief Class to control one of HCR's Elmo servo drives.
class ElmoServoDrive : public QObject {
    Q_OBJECT
public:

    /// @brief Instantiate a connection to an Elmo servo drive on the named 
    /// serial device. The drive is also given a nickname (e.g., "rotation"
    /// or "tilt"), to make log messages more descriptive.
    /// @param ttyDev the name serial port device connected to the Elmo drive
    /// @param driveName nickname used for the drive in log messages
    ElmoServoDrive(std::string ttyDev, std::string driveName);

    /// @brief Instantiate a connection to the Elmo servo drive at the given
    /// CANopen node ID. The drive is also given a nickname (e.g., "rotation"
    /// or "tilt"), to make log messages more descriptive.
    /// @param nodeId the CANopen node ID of the Elmo drive
    /// @param driveName nickname used for the drive in log messages
    ElmoServoDrive(uint8_t nodeId, std::string driveName);
    
    virtual ~ElmoServoDrive();

    /// The Elmo drives have a 32-bit status register
    typedef int32_t StatusReg;

    /// @brief Tell the drive to find where home is, and assign the given count
    /// number to that location.
    /// @param homeCounts the count value to be assigned at the home location
    void homeDrive(int homeCounts = 0);

    /// @brief Move the drive to the given angle (deg)
    /// @param angle the desired drive angle, deg
    void moveTo(float angle);

    /// @brief Initialize table for scanning using PT mode.
    /// @param p vector of positions, deg
    /// @param scanRate scan rate in deg/s
    void initScan(std::vector<int> p, float scanRate);

    /// @brief Initialize table for scanning using PT mode.
    /// @param ccwLimit counterclockwise limit, deg
    /// @param cwLimit clockwise limit, deg
    /// @param scanRate scan rate in deg/s
    void initScan(float ccwLimit, float cwLimit, float scanRate);

    /// @brief Put the drive to scanning according to the PVT table
    void scan();

    /// @brief Return the nickname of the drive
    /// @return the nickname of the drive
    std::string driveName() const { return(_driveConn->driveName()); }
    
    /// @brief Return the drive responding state. We count the drive as 
    /// responding if the connection is accepting execElmoCmd() calls.
    /// @return the drive responding state
    bool driveResponding() const { return _driveConn->readyToExec(); }

    /// @brief Return true iff the drive is inhibited via external signal.
    /// @return true iff the drive is inhibited via external signal.
    bool inhibitActive() const { return _inhibitActive; }

    /// @brief Return true iff the drive parameter initialization has been executed
    /// successfully.
    /// @return true iff the drive parameter initialization has been executed
    /// successfully.
    bool driveInitialized() const { return _driveInitialized; }

    /// @brief Return true iff the drive homing has been executed successfully.
    /// @return true iff the drive homing has been executed successfully.
    bool driveHomed() const { return _driveHomed; }

    /// @brief Return true iff drive homing is currently in progress.
    /// @return true iff drive homing is currently in progress.
    bool homingInProgress() const { return _homingInProgress; }
    
    /// @brief Set the target radius for the drive, in drive counts. See ELMO
    /// documentation for the TR command to see the effects of the target
    /// radius.
    /// @param targetRadius the desired target radius, deg
    void setTargetRadius(uint32_t targetRadius);
    
    /// @brief Return the target radius for the drive, in drive counts.
    /// @return the target radius for the drive, in drive counts, or zero if 
    /// the target radius is not known.
    uint32_t targetRadius() {
        if (_driveParamsGood()) {
            return(_targetRadius);
        } else {
            return(0);
        }
    }
    
    /// @brief Return the latest sampled drive status register value.
    /// @return the latest sampled drive status register value.
    StatusReg driveStatusRegister() const { return _driveStatusRegister; }

    /// @brief Return the latest sampled drive system time, in microseconds.
    /// @return the latest sampled drive system time, in microseconds.
    uint32_t driveSystemTime() const { return _driveSystemTime; }

    /// @brief Return the latest sampled drive angle, in degrees.
    /// @return the latest sampled drive angle, in degrees.
    float angle() const {
        if (_driveParamsGood()) {
            return(_angleCounts / countsPerDegree());
        } else {
            return(0.0);
        }
    }

    /// @brief Return the latest sampled drive temperature, deg C.
    /// @return the latest sampled drive temperature, deg C.
    int driveTemperature() const { return _driveTemperature; }

    /// @brief Return the number of optical encoder counts per full circle.
    /// @return the number of optical encoder counts per full circle.
    uint32_t countsPerCircle() const { return(_positionMaxCnt - _positionMinCnt); }

    /// Optical encoder counts per degree
    float countsPerDegree() const { return(countsPerCircle() / 360.0); }

    // Static methods to unpack status register values

    /// @brief Return true iff status register reports drive OK.
    /// @return true iff status register reports drive OK.
    static bool SREG_driveProblem(StatusReg statusReg) {
    	return((statusReg >> 0) & 0x1);
    }

    /// @brief Return 3-bit status indication from status register.
    /// @return 3-bit status indication from status register.
    static int SREG_statusIndication(StatusReg statusReg) {
    	return((statusReg >> 1) & 0x7);
    }

    /// @brief Return true iff status register reports motor on.
    /// @return true iff status register reports motor on.
    static bool SREG_motorOn(StatusReg statusReg) {
    	return((statusReg >> 4) & 0x1);
    }

    /// @brief Return true iff status register reports motor failure.
    /// @return true iff status register reports motor failure.
    static bool SREG_motorFailure(StatusReg statusReg) {
    	return((statusReg >> 6) & 0x1);
    }

    /// @brief Return 3-bit unit mode from status register.
    /// @return 3-bit unit mode from status register.
    static int SREG_unitMode(StatusReg statusReg) {
    	return((statusReg >> 7) & 0x7);
    }

    /// @brief Return true iff status register reports main or auxiliary homing
    /// in process.
    /// @return true iff status register reports main or auxiliary homing
    /// in process.
    static bool SREG_homingInProcess(StatusReg statusReg) {
    	return((statusReg >> 11) & 0x1);
    }

    /// @brief Return true iff status register reports program running.
    /// @return true iff status register reports program running.
    static bool SREG_programRunning(StatusReg statusReg) {
    	return((statusReg >> 12) & 0x1);
    }

    /// @brief Return 2-bit motion status value from status register.
    /// @return 2-bit motion status value from status register.
    static int SREG_motionStatus(StatusReg statusReg) {
    	return((statusReg >> 14) & 0x3);
    }

    /// @brief Return true iff status register reports a CPU problem (stack
    /// overflow or CPU exception).
    /// @return true iff status register reports a CPU problem (stack
    /// overflow or CPU exception).
    static bool SREG_cpuProblem(StatusReg statusReg) {
    	return((statusReg >> 27) & 0x1);
    }

    /// @brief Return true iff status register reports the motor is stopped
    /// by a limit (RLS, FLS, stop switch, etc.)
    /// @return true iff status register reports the motor is stopped
    /// by a limit (RLS, FLS, stop switch, etc.)
    static bool SREG_stoppedByLimit(StatusReg statusReg) {
    	return((statusReg >> 28) & 0x1);
    }

    /// @brief Return true iff status register reports error in user program.
    /// @return true iff status register reports error in user program.
    static bool SREG_userProgramError(StatusReg statusReg) {
    	return((statusReg >> 29) & 0x1);
    }
    
private slots:
    /// @brief Slot called when we receive a readyToExecChanged() signal from 
    /// our ElmoConnection.
    void _onReadyToExecChanged(bool isReady);
    
    /// @brief Slot called when we receive a replyFromExec() signal from our
    /// ElmoConnection.
    void _onReplyFromExec(std::string cmd, ElmoConnection::ReplyType replyType,
            int iVal, float fVal);
    
    /**
     * Test for completion of drive parameter initialization
     */
    void _testForInitCompletion();

    /**
     * Test for completion of homing
     */
    void _testForHomingCompletion();

    /**
     * Slot called when it's time to collect status
     */
    void _collectStatus();

private:
    /**
     * Reset all status values to a "status unknown" state
     */
    void _resetStatus();

    /**
     * Initialize drive parameters.
     */
    void _initDrive();

    /**
     * @brief Start execution via XQ of a named function on the drive.
     * @param function the name of the function to execute via XQ
     */
    void _startXq(std::string function);

    /**
     * @brief Return true iff the last command via _startXq has completed
     * execution on the drive.
     * @return true iff the last command via _startXq has completed
     * execution on the drive.
     */
    bool _xqCompleted();

    /// @brief Set our queried values of the drive's count range and position 
    /// controller sample time to bad values.
    void _clearQueriedParams();

    /// @brief Return true iff drive's count range and position controller
    /// sample time have been obtained from the drive.
    static const int BAD_POSITION_CNT = INT_MAX;
    bool _driveParamsGood() const {
    	return(_positionMinCnt != BAD_POSITION_CNT &&
    			_positionMaxCnt != BAD_POSITION_CNT &&
    			_pcSampleTime != 0.0);
    }

    /// @brief Request needed drive parameters.
    ///
    /// This method sends commands to collect the drive parameters, and the
    /// replies will be parsed out in _readReply().
    void _collectDriveParams();

    /// @brief Convert an angle in degrees to drive counts.
    /// @param angleDeg angle to be converted, in degrees
    int _angleToCounts(float angleDeg);

    /// @brief Return the name of the drive-resident function to be called
    /// to initialize drive parameters.
    /// @return the name of the drive-resident function to be called
    /// to initialize drive parameters.
    virtual std::string _xqInitFunction() const = 0;

    /// @brief Return the name of the drive-resident function to be called
    /// to home the drive.
    /// @return the name of the drive-resident function to be called
    /// to home the drive.
    virtual std::string _xqHomingFunction() const = 0;

    /// Drive connection
    ElmoConnection * _driveConn;

    /// Boolean to tell if drive is inhibited via external signal
    bool _inhibitActive;

    /// Boolean to tell if drive has been initialized
    bool _driveInitialized;

    /// Boolean to tell if drive has been homed yet
    bool _driveHomed;

    /// Boolean to tell if homing is in progress.
    bool _homingInProgress;

    /// We allow up to this time (in ms) for replies to come back from the
    /// servo drive.
    static const int REPLY_TIMEOUT_MSECS = 500;

    /// Timer used to collect status information on a regular basis
    QTimer _statusTimer;

    /// We collect status information from the drive at this period, in ms
    static const int STATUS_PERIOD_MSECS = 200;

    /// General purpose timer used when waiting for command/reply
    /// synchronization and for completion of initialization.
    QTimer _gpTimer;

    /// drive temperature, deg C
    int _driveTemperature;

    /// drive angle, in counts
    int32_t _angleCounts;

    /// drive system time, microseconds
    uint32_t _driveSystemTime;

    /// time the last SR command was issued
    struct timeval _srRequestTime;

    /// drive status register
    StatusReg _driveStatusRegister;

    /// time of the current _driveStatusRegister (set to the value of
    /// _srRequestTime when the reply to the SR command is received)
    struct timeval _lastSrTime;

    /// minimum position count
    int _positionMinCnt;

    /// maximum position count
    int _positionMaxCnt;

    /// position controller sampling time, s
    float _pcSampleTime;
    
    /// target radius (see documentation for the TR command for details)
    uint32_t _targetRadius;

    /// When did we begin the initialization process?
    struct timeval _xqStartTime;

    /// Has there been an error from an XQ command used for initialization/
    /// homing?
    bool _xqError;
    
    /// Scan point vector
    std::vector<int> _scanPoints;
};

#endif /* ELMOSERVODRIVE_H_ */
