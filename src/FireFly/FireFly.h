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
 * FireFly.h
 *
 *  Created on: Mar 26, 2014
 *      Author: burghart
 */

#ifndef FIREFLY_H_
#define FIREFLY_H_

#include <queue>
#include <string>
#include <vector>
#include <stdint.h>
#include <QMutex>
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
        return(_status);
    }
    
private Q_SLOTS:
    /// @brief Slot called when a reply has not arrived in the expected time.
    void _replyTimedOut();

    /// @brief Queue a status query
    void _queueStatusQuery();

    /// @brief Wait briefly for input to be available on our file descriptor
    /// and call _doRead if something comes along before we time out.
    void _tryRead();

    /// @brief Handle a reply from the FireFly
    /// @param cmdError true iff a command error was indicated
    /// @param reply The null-terminated reply string
    void _handleReply(bool cmdError, std::string reply);

    /// @brief Slot called when the device is not responding.
    void _deviceNotResponding();

    /// @brief Set our latest status as undefined/bad.
    void _setBadStatus() { _status = FireFlyStatus(); }

private:
    /// @brief Open and configure our tty connection to the FireFly
    void _openTty();
    
    /// @brief Our QThread run() method.
    void run();

    /// @brief Read and process input from the FireFly.
    void _doRead();

    /// @brief Queue a command to be sent to the FireFly, and send the command
    /// at the head of the queue if we can.
    /// @param cmd the FireFly command to queue
    void _queueCommand(const std::string & cmd);
    
    /// @brief Send the next queued command to the FireFly.
    void _sendNextCommand();


    /// @brief Parse the reply to a "SYNC?" command
    void _parseSyncInfoReply(const std::vector<std::string> & replyLines);

    /// @brief The prompt string which is sent by the FireFly. We use it to
    /// delineate the end of a command response.
    static const std::string _FIREFLY_PROMPT;

    /// @brief Reply returned by the FireFly on command error.
    static const std::string _FIREFLY_CMD_ERR_REPLY;

    /// @brief Text string for the sync info command
    static const std::string _SYNC_INFO_CMD;

    /// @brief Our serial port device name (may be SIM_DEVICE)
    std::string _ttyDev;
    
    /// @brief File descriptor for the open serial port
    int _fd;

    /// @brief Is the device responding to us?
    bool _deviceResponding;

    /// @brief Last command sent to the FireFly
    std::string _lastCommandSent;

    /// @brief Are we waiting for a reply to the last command sent?
    bool _awaitingReply;

    /// @brief Queue of commands waiting to be sent to the FireFly
    std::queue<std::string> _commandQueue;

    /// @brief Single shot timer started when we send a command to assure that
    /// we get a reply in a reasonably short time.
    QTimer * _replyTimeoutTimer;

    /// @brief Timer used to mark the device as unresponsive after a period with no
    /// responses.
    QTimer * _deviceRespondingTimer;

    /// @brief Mutex for thread-safe access to _status. We make it
    /// mutable so that we can acquire the mutex in const methods.
    mutable QMutex _mutex;

    /// @brief Latest status
    FireFlyStatus _status;

    /// @brief Reply buffer. We need it big enough to hold the largest expected
    /// output (which is generally a bunch of bytes spewed at power-up).
    static const int _REPLY_BUFFER_SIZE = 1024;
    char _rawReply[_REPLY_BUFFER_SIZE];

    /// @brief How many bytes are currently contained in _replyBuffer
    uint16_t _rawReplyLen;
};

#endif /* FIREFLY_H_ */
