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

    /// Move the drive to the given angle (deg)
    /// @param angle the desired drive angle, deg
    void moveTo(float angle);

    /// Optical encoder counts per degree.
    static const double COUNTS_PER_DEGREE = 400000 / 360.0;

private slots:
    /**
     * Slot called when the Elmo sends serial data
     */
    void _readReply();

    /**
     * Slot called if the Elmo takes to long to reply to a command.
     */
    void _replyTimedOut();

private:
    /// Open our serial connection to the drive.
    void _openTty();

    /// Send a string command to the servo drive for execution.
    /// @param cmd the single Elmo SimpIQ command to execute
    /// @param initializeReplySync this parameter should only be set true when
    ///		establishing synchronization between sent commands and received
    ///		replies. When true, this is the last command which will be executed
    ///		until either a reply is received or the wait for a reply times out.
    bool _execElmoCmd(const std::string cmd, bool initializeReplySync = false);

    /// Read a reply from the servo drive
    int _getReply();

    void _setBaud(speed_t baudValue);

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
    std::queue<std::string> _unackedCmds;

    /// Boolean to mark the period where we wait for a reply to a known
    /// command. After the reply is received, we can synchronize replies with
    /// further commands which are sent.
    bool _waitingForSyncReply;

    /// Timer used to verify that we are getting replies from the servo drive
    /// in a timely fashion.
    QTimer _replyTimer;

    /// Data read but not yet processed
    static const int _ELMO_REPLY_BUFFER_SIZE = 2048;
    uint8_t _rawReply[_ELMO_REPLY_BUFFER_SIZE];
    uint16_t _rawReplyLen;

};

#endif /* ELMOSERVODRIVE_H_ */
