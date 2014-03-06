/*
 * TtyElmoConnection.h
 *
 *  Created on: Feb 26, 2014
 *      Author: burghart
 */

#ifndef TTYELMOCONNECTION_H_
#define TTYELMOCONNECTION_H_

#include "ElmoConnection.h"
#include <termios.h>
#include <inttypes.h>
#include <queue>
#include <QSocketNotifier>
#include <QTimer>

/// Class implementing the ElmoConnection interface, providing an RS-232 serial
/// connection to an Elmo servo drive.
class TtyElmoConnection: public ElmoConnection {
    Q_OBJECT
public:
    /**
     * @brief Instantiate a connection to an Elmo servo drive on the named 
     * serial device. A nickname (e.g., "rotation" or "tilt") is assigned to 
     * the drive to make log messages more descriptive.
     * @param ttyDev the name serial port device connected to the Elmo drive
     * @param driveName nickname used for the drive in log messages
     */
    TtyElmoConnection(std::string ttyDev, std::string driveName);
    virtual ~TtyElmoConnection();
    
    /// @brief Return the nickname associated with the drive.
    /// @return the nickname associated with the drive.
    virtual std::string driveName() const { return(_driveName); }
    
    /// @brief Execute the given SimplIQ command cmd on the servo drive. If 
    /// index is zero, "<cmd>" will be executed, otherwise "<cmd>[<index>]".
    ///
    /// @param cmd the two-letter Elmo SimplIQ command to execute
    /// @param index the command index (set to zero if the SimplIQ command is 
    ///     not indexed).
    /// @return true iff command execution was initiated
    virtual bool execElmoCmd(std::string cmd, int index);
    
    /// @brief Execute the given SimplIQ assignment for command cmd on the 
    /// servo drive. If the index is zero, "<cmd>=<value>" will be executed,
    /// otherwise "<cmd>[<index>]=<value>".
    ///
    /// @param cmd the two-letter Elmo SimplIQ command to execute
    /// @param index the command index (set to zero if the SimplIQ command is 
    ///     not indexed).
    /// @param value the integer value to be assigned to "<cmd>" (or 
    ///     "<cmd>[<index>]")
    /// @return true iff command execution was initiated
    virtual bool execElmoAssignCmd(std::string cmd, int index, int value);
    
    /// @brief Return true iff the object is ready to execute commands via the
    /// execElmoCmd() method.
    /// @return true iff the object is ready to execute commands via the
    /// execElmoCmd() method.
    virtual bool readyToExec() const { return(_driveResponding && ! _waitingForSync); }

    /// @brief Force reinitialization of the connection.
    virtual void reinitialize();
    
private slots:
    /// @brief Slot called when the Elmo sends serial data.
    void _readReply();

    /// @brief Slot called if the Elmo takes to long to reply to a command.
    void _replyTimedOut();

    /// @brief Slot called when our sync wait timer expires.
    void _syncWaitExpired();

private:
    /// @brief Open our serial connection to the drive.
    void _openTty();
    
    /// @brief Read a reply from the servo drive
    int _getReply();

    /// @brief Set the tty connection speed.
    void _setBaud(speed_t baudValue);

    /// @brief Return a text representation for a speed_t value from termios.h.
    /// E.g., the string "B9600" will be returned for speed_t value B9600.
    /// @param baudValue a speed_t value from termios.h: B9600, B19200, B38400,
    /// B57600, or B115200.
    /// @return a text representation for the given speed_t value.
    static std::string _BaudToText(speed_t baudValue);

    /// @brief Turn off echo from the drive, then stop sending commands to the 
    /// drive for a while so we can wait for all pending replies to arrive. 
    /// After that, we should have command/reply synchronization.
    void _startCommandReplySync();
    
    /// @brief Method which sends the given string command to the servo drive
    /// for execution. Just one SimplIQ command should be in the cmd string, and 
    /// the string should contain no terminator characters (';').
    ///
    /// Note that calls to execElmoCmd() while pre-initialization is in
    /// progress will be ignored.
    ///
    /// @param cmd the single Elmo SimplIQ command to execute
    /// @param replyExpected set to true if a non-empty reply to the command
    ///     is expected. Default: true
    bool _execElmoCmd(std::string cmd, bool replyExpected = true);
    
    /// @brief Return true iff the given command is exactly two characters long
    /// or is a legal SimplIQ "XQ##" command, otherwise return false and log a 
    /// message.
    /// @return true iff the given command is exactly two characters long,
    /// otherwise return false and log a message.
    bool _cmdIsValid(std::string cmd);
    
    /// Our serial port device name
    std::string _ttyDev;

    /// Nickname for the servo drive
    std::string _driveName;
    
    /// File descriptor for the open serial port
    int _fd;

    /// Notifier to let us know when the servo drive delivers a response
    QSocketNotifier * _readNotifier;

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

    /// Boolean to tell if the drive is currently responding to commands.
    bool _driveResponding;

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

};

#endif /* TTYELMOCONNECTION_H_ */
