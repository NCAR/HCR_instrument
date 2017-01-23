#ifndef _HCRSHAREDRESOURCES_H_
#define _HCRSHAREDRESOURCES_H_

#include <cstdint>
#include <string>

/// Port numbers for XML-RPC services provided by HCR processes
const uint16_t HCR_XMITD_PORT =             8000;  ///< hcr_xmitd port
const uint16_t FIREFLYD_PORT =              8001;  ///< fireflyd port
const uint16_t HCRPMC730DAEMON_PORT =       8003;  ///< HcrPmc730Daemon port
const uint16_t HCRMONITOR_PORT =            8004;  ///< HcrMonitor port
const uint16_t SPECTRACOMDAEMON_PORT =      8005;  ///< SpectracomDaemon port
const uint16_t PRIMARYINSDAEMON_PORT =      53005; ///< primary cmigitsDaemon port
const uint16_t SECONDARYINSDAEMON_PORT =    53006; ///< secondary cmigitsDaemon port
const uint16_t HCRDRX_PORT =                8081;  ///< hcrdrx port
const uint16_t MOTIONCONTROLDAEMON_PORT =   8080;  ///< MotionControlDaemon port

/// FMQ URLs

// URL for the primary C-MIGITS FMQ
// This is defined as a function to guarantee construction-on-first-use
static const std::string &
PrimaryCmigitsFmqUrl() {
    static std::string url("/tmp/cmigits_fmq/shmem_primary");
    return(url);
}

// URL for the secondary C-MIGITS FMQ
// This is defined as a function to guarantee construction-on-first-use
static const std::string &
SecondaryCmigitsFmqUrl() {
    static std::string url("/tmp/cmigits_fmq/shmem_secondary");
    return(url);
}

#endif // #ifndef _HCRSHAREDRESOURCES_H_
