/*
 * FireFly.h
 *
 *  Created on: Mar 26, 2014
 *      Author: burghart
 */

#ifndef FIREFLY_H_
#define FIREFLY_H_

#include <queue>
#include <string>
#include <stdint.h>
#include <QMutex>
#include <QSocketNotifier>
#include <QThread>
#include <QTimer>
#include "FireFlyStatus.h"

/// @brief Class providing serial port access to a Jackson Labs FireFly-IIA
/// 10 MHz GPS-disciplined oscillator.
class FireFly : public QThread {
    Q_OBJECT
public:
    /// @brief Construct a FireFly providing serial port access to a Jackson Labs
    /// FireFly-IIA 10 MHz GPS-disciplined oscillator.
    FireFly(std::string ttyDev);
    virtual ~FireFly();
    
    /**
     * @brief Get current status values from the FireFly.
     */
    FireFlyStatus getStatus() const {
        QMutexLocker locker(& _mutex);
        return(_latestStatus);
    }
    
private slots:
    /// @brief Read data which have arrived on the serial port
    void _doRead();

    /// @brief Slot called when a reply has not arrived in the expected time.
    void _replyTimedOut();

    /// @brief Queue a status query
    void _queueStatusQuery();

private:
    void run();

    /// @brief Open and configure our tty connection to the FireFly
    void _openTty();
    
    /// @brief Queue a command to be sent to the FireFly, and send the command
    /// at the head of the queue if we can.
    /// @param cmd the FireFly command to queue
    void _queueCommand(const std::string & cmd);
    
    /// @brief Send the next queued command to the FireFly.
    void _sendNextCommand();


    /// @brief Parse the reply to a "SYNC?" command
    void _parseSyncInfoReply(std::string reply);

    /// @brief Set the _latestStatus member.
    /// @param status the status to assign to _latestStatus
    void _setLatestStatus(const FireFlyStatus & status);

    /// @brief Handle a reply from the FireFly
    /// @param reply The null-terminated reply string
    void _handleReply(std::string reply);

    /// @brief The prompt string which is sent by the FireFly.
    static const char * _FIREFLY_PROMPT;

    /// @brief Reply returned by the FireFly on command error
    static const char * _FIREFLY_CMD_ERR_REPLY;

    /// @brief Text string for the sync info command
    static const char * _SYNC_INFO_CMD;

    /// Our serial port device name (may be SIM_DEVICE)
    std::string _ttyDev;
    
    /// File descriptor for the open serial port
    int _fd;

    /// Is the device responding to us?
    bool _deviceResponding;

    /// Last command sent to the FireFly
    std::string _lastCommandSent;

    /// Queue of commands waiting to be sent to the FireFly
    std::queue<std::string> _commandQueue;

    /// QSocketNotifier to let us know when bytes are ready to be read from _fd.
    QSocketNotifier * _readReadyNotifier;

    /// Timer started when we send a command to assure that we don't wait
    /// forever for a reply.
    QTimer * _replyTimeoutTimer;

    /// Mutex for thread-safe access to _latestStatus. We make it mutable so
    /// that we can acquire the mutex in const methods.
    mutable QMutex _mutex;

    /// Reply buffer, big enough to hold the largest reply we expect from a
    /// command.
    static const int _REPLY_BUFFER_SIZE = 1024;
    char _rawReply[_REPLY_BUFFER_SIZE];

    /// How many bytes are currently contained in _replyBuffer
    uint16_t _rawReplyLen;

    /// Latest status
    FireFlyStatus _latestStatus;
};

#endif /* FIREFLY_H_ */
