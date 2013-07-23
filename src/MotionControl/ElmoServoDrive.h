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
#include <cstring>
#include <stdint.h>
#include <termios.h>
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

    /// Return the drive responding state. The state is true as long as replies
    /// to commands are being received from the drive.
    /// @return the drive responding state
    bool driveResponding() const { return _driveResponding; }

    /// Get latest sampled drive status register value
    StatusReg driveStatusRegister() const { return _driveStatusRegister; }

    /// Get latest sampled drive system time, in microseconds
    uint32_t driveSystemTime() const { return _driveSystemTime; }

    /// Get latest sampled drive temperature, C
    int driveTemperature() const { return _driveTemperature; }

    /// Optical encoder counts per full circle.
    static const uint32_t COUNTS_PER_CIRCLE = 400000;
    static const float COUNTS_PER_DEGREE = COUNTS_PER_CIRCLE / 360.0;

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

    /// @brief Return unit mode from status register.
    /// @return unit mode from status register.
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

    /// Timer used to collect status information on a regular basis
    QTimer _statusTimer;

    /// Timer used to wait long enough to assure that replies to all sent
    /// commands have been received, so we can establish command/reply
    /// synchronization.
    QTimer _syncWaitTimer;

    /// Have we received at least one reply since starting the synchronization
    /// process?
    bool _syncReplyReceived;

    /// Data read but not yet processed
    static const int _ELMO_REPLY_BUFFER_SIZE = 2048;
    uint8_t _rawReply[_ELMO_REPLY_BUFFER_SIZE];
    uint16_t _rawReplyLen;

    /// drive temperature, sampled at 5 Hz
    int _driveTemperature;

    /// drive system time, microseconds, sampled at 5 Hz
    uint32_t _driveSystemTime;

    /// drive status register, sampled at 5 Hz
    StatusReg _driveStatusRegister;
};

#endif /* ELMOSERVODRIVE_H_ */
