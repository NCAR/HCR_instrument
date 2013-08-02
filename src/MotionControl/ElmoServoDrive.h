/*
 * ElmoServoDrive.h
 *
 *  Created on: Jun 26, 2013
 *      Author: burghart
 */

#ifndef ELMOSERVODRIVE_H_
#define ELMOSERVODRIVE_H_
#include <queue>
#include <string>
#include <cmath>
#include <cstring>
#include <stdint.h>
#include <termios.h>
#include <vector>
#include <sys/time.h>
#include <QObject>
#include <QSocketNotifier>
#include <QThread>
#include <QTimer>

/// @brief Class to connect to and control an Elmo servo drive on a given
/// serial port.
class ElmoServoDrive : public QObject {
    Q_OBJECT
public:
    /**
     * Instantiate a connection to an Elmo servo drive on the named serial
     * device. The drive can optionally be given a nickname (e.g., "rotation"
     * or "tilt"), to make log messages more descriptive.
     * @param ttyDev the name serial port device connected to the Elmo drive
     * @param driveName nickname used for the drive in log messages
     */
    ElmoServoDrive(const std::string ttyDev, const std::string driveName);
    virtual ~ElmoServoDrive();

    /// The Elmo drives have a 32-bit status register
    typedef int32_t StatusReg;

    /// Move the drive to the given angle (deg)
    /// @param angle the desired drive angle, deg
    void moveTo(float angle);

//    /// Set PVT table entry
//    /// @param p the position (counts)
//    /// @param v the velocity (counts/s)
//    /// @param t the time (milliseconds)
//    /// @param n the table index
//    void setPVT(int p, int v, int t, int n);

    /// Initialize table for scanning using PVT mode.
    /// @param p vector of positions, deg
    /// @param v vector of velocities, deg/s
    /// @param t vector of times, s
    void initScan(std::vector<float> p, std::vector<float> v, std::vector<float> t);

    /// Initialize table for scanning using PT mode.
    /// @param p vector of positions, deg
    /// @param scanRate scan rate in deg/s
    void initScan(std::vector<int> p, float scanRate);

    /// Initialize table for scanning using PT mode.
    /// @param ccwLimit counterclockwise limit, deg
    /// @param cwLimit clockwise limit, deg
    /// @param scanRate scan rate in deg/s
    void initScan(float ccwLimit, float cwLimit, float scanRate);

    /// @brief Put the drive to scanning according to the PVT table
    void scan();

    /// Return the drive responding state. The state is true as long as replies
    /// to commands are being received from the drive.
    /// @return the drive responding state
    bool driveResponding() const { return _driveResponding; }

    /// Return true iff the drive parameter initialization has been executed
    /// successfully.
    /// @return true iff the drive parameter initialization has been executed
    /// successfully.
    bool driveInitialized() const { return _driveInitialized; }

    /// Return true iff the drive homing has been executed successfully.
    /// @return true iff the drive homing has been executed successfully.
    bool driveHomed() const { return _driveHomed; }

    /// Get latest sampled drive status register value
    StatusReg driveStatusRegister() const { return _driveStatusRegister; }

    /// Get latest sampled drive system time, in microseconds
    uint32_t driveSystemTime() const { return _driveSystemTime; }

    /// Get latest sampled drive temperature, C
    int driveTemperature() const { return _driveTemperature; }

    /// Optical encoder counts per full circle.
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
    /**
     * Slot called when the Elmo sends serial data
     */
    void _readReply();

    /**
     * Slot called if the Elmo takes to long to reply to a command.
     */
    void _replyTimedOut();

    /**
     * Slot called when our sync wait timer expires.
     */
    void _syncWaitExpired();

    /**
     * Slot called when it's time to collect status
     */
    void _collectStatus();

    /**
     * Reset all status values to a "status unknown" state
     */
    void _resetStatus();

    /**
     * Tell the drive to find where home is.
     */
    void _homeDrive();

    /**
     * Initialize drive parameters.
     */
    void _initDrive();

    /**
     * Test for completion of homing
     */
    void _testForHomingCompletion();

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

    /**
     * Test for completion of drive parameter initialization
     */
    void _testForInitCompletion();

private:
    /// Open our serial connection to the drive.
    void _openTty();

    /// Send a string command to the servo drive for execution. Just one
    /// SimplIQ command should be in the cmd string, and the string should
    /// contain no terminator characters (';').
    /// @param cmd the single Elmo SimpIQ command to execute
    /// @param emptyReplyExpected set to true if an empty reply to the command
    ///		is expected. Default: true
    bool _execElmoCmd(const std::string cmd, bool emptyReplyExpected = true);

    /// Read a reply from the servo drive
    int _getReply();

    void _setBaud(speed_t baudValue);

    /// Turn off echo from the drive, then stop sending commands to the drive
    /// for a while so we can wait for all pending replies to arrive. After
    /// that, we should have command/reply synchronization.
    void _startCommandReplySync();

    /// @brief Set drive's count range and position controller sample time to
    /// bad values.
    void _clearDriveParams();

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

    /// @brief Return a text representation for a speed_t value from termios.h.
    /// E.g., the string "B9600" will be returned for speed_t value B9600.
    /// @param baudValue a speed_t value from termios.h: B9600, B19200, B38400,
    /// B57600, or B115200.
    /// @return a text representation for the given speed_t value.
    static std::string _BaudToText(speed_t baudValue);

    /// Our serial port device name
    std::string _ttyDev;

    /// Drive nickname
    std::string _driveName;

    /// File descriptor for the open serial port
    int _fd;

    /// Notifier to let us know when the servo drive delivers a response
    QSocketNotifier * _readNotifier;

    /// Boolean to tell if the drive is currently responding to commands.
    bool _driveResponding;

    /// Boolean to tell if drive has been initialized
    bool _driveInitialized;

    /// Boolean to tell if drive has been homed yet
    bool _driveHomed;

    /// List of commands not yet acknowledged by the drive
    class CmdQueueEntry {
    public:
    	CmdQueueEntry(const std::string cmd_text, bool empty_reply_expected) :
    		cmdText(cmd_text),
    		emptyReplyExpected(empty_reply_expected) {}
    	std::string cmdText;
    	bool emptyReplyExpected;
    };
    std::queue<CmdQueueEntry> _unackedCmds;

    /// Boolean to mark the period where we wait for a reply to a known
    /// command. After the reply is received, we can synchronize replies with
    /// further commands which are sent.
    bool _waitingForSync;

    /// Timer used to verify that we are getting replies from the servo drive
    /// in a timely fashion.
    QTimer _replyTimer;

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

    /// Have we received at least one reply since starting the synchronization
    /// process?
    bool _syncReplyReceived;

    /// Data read but not yet processed
    static const int _ELMO_REPLY_BUFFER_SIZE = 2048;
    uint8_t _rawReply[_ELMO_REPLY_BUFFER_SIZE];
    uint16_t _rawReplyLen;

    /// drive temperature
    int _driveTemperature;

    /// drive system time, microseconds
    uint32_t _driveSystemTime;

    /// drive status register
    StatusReg _driveStatusRegister;
    struct timeval _lastStatusTime;

    /// minimum position count
    int _positionMinCnt;

    /// maximum position count
    int _positionMaxCnt;

    /// position controller sampling time, s
    float _pcSampleTime;

    /// When did we begin the initialization process?
    struct timeval _xqStartTime;

    /// Has there been an error from an XQ command used for initialization/
    /// homing?
    bool _xqError;
};

#endif /* ELMOSERVODRIVE_H_ */
