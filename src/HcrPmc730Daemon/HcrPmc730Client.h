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
    /// @brief Get latest status values from the HcrPmc730Daemon.
    /// @return latest status values from the HcrPmc730Daemon.
    bool getStatus(HcrPmc730Status & status);
private:
    std::string _daemonHost;
    int _daemonPort;
    std::string _daemonUrl;
    xmlrpc_c::clientSimple _client;
};

#endif /* HCRPMC730CLIENT_H_ */
