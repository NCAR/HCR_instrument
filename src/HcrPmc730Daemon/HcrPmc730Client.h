/*
 * HcrPmc730Client.h
 *
 *  Created on: Aug 9, 2013
 *      Author: hcr
 */

#ifndef HCRPMC730CLIENT_H_
#define HCRPMC730CLIENT_H_

#include <string>
#include <HcrPmc730Status.h>
#include <xmlrpc-c/client_simple.hpp>

class HcrPmc730Client {
public:
    HcrPmc730Client(std::string daemonHost, int daemonPort);
    virtual ~HcrPmc730Client();
    /// @brief Return the daemon host name
    /// @return the daemon host name
    std::string getDaemonHost() const { return(_daemonHost); }

    /// @brief Return the daemon port number
    /// @return the daemon port number
    int getDaemonPort() const { return(_daemonPort); }

    /// @brief Send a "getStatus" command, filling a HcrPmc730Status
    /// object if we get status from the HcrPmc730Daemon.
    /// @param status the HcrPmc730Status object to be filled
    /// @return true and fill the status object if status is obtained from
    /// HcrPmc730Daemon, otherwise return false and leave the status object
    /// unmodified.
    bool getStatus(HcrPmc730Status & status);

    /// @brief Send an "xmitFilamentOn" command to HcrPmc730Daemon
    /// @return true if the call is successful, false otherwise
    bool xmitFilamentOn();

    /// @brief Send a "xmitFilamentOff" command to HcrPmc730Daemon
    /// @return true if the call is successful, false otherwise
    bool xmitFilamentOff();

    /// @brief Send an "xmitHvOn" command to HcrPmc730Daemon
    /// @return true if the call is successful, false otherwise
    bool xmitHvOn();

    /// @brief Send a "xmitHvOff" command to HcrPmc730Daemon
    /// @return true if the call is successful, false otherwise
    bool xmitHvOff();

    /// @brief Send "setHmcMode" command to HcrPmc730Daemon
    /// @param mode integer mode number for the HMC, 0-7
    /// @return true if the call is successful, false otherwise
    bool setHmcMode(int mode);

private:
    std::string _daemonHost;
    int _daemonPort;
    std::string _daemonUrl;
    xmlrpc_c::clientSimple _client;
};

#endif /* HCRPMC730CLIENT_H_ */
