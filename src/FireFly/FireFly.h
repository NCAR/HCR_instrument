/*
 * FireFly.h
 *
 *  Created on: Mar 26, 2014
 *      Author: burghart
 */

#ifndef FIREFLY_H_
#define FIREFLY_H_

#include <string>
#include <stdint.h>
#include <QMutex>
#include <QThread>
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
     * @brief Get current status values from the transmitter.
     */
    FireFlyStatus getStatus() const {
        QMutexLocker locker(& _mutex);
        return(_latestStatus);
    }
    
private slots:
    /// @brief Slot called to query current status from the transmitter
    void _queryForStatus();

private:
    void run();

    /// @brief Open and configure our tty connection to the transmitter
    void _openTty();
    
    /// @brief Send a command to the transmitter.
    void _sendCommand(uint8_t desiredState);
    
    /// @brief Wait for input on our file descriptor, with a timeout specified
    /// in milliseconds.
    /// @return 0 when input is ready, -1 if the select timed out, -2 on
    /// select error
    int _readSelect(unsigned int timeoutMsecs);
    
    /// @brief Set the _latestStatus member.
    /// @param status the status to assign to _latestStatus
    void _setLatestStatus(const FireFlyStatus & status);

    /// Our serial port device name (may be SIM_DEVICE)
    std::string _ttyDev;
    
    /// File descriptor for the open serial port
    int _fd;

    /// Mutex for thread-safe access to _latestStatus. We make it mutable so
    /// that we can acquire the mutex in const methods.
    mutable QMutex _mutex;

    /// Latest status
    FireFlyStatus _latestStatus;
};

#endif /* FIREFLY_H_ */
