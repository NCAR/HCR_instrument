#ifndef _HCRPORTNUMBERS_H_
#define _HCRPORTNUMBERS_H_

#include <cstdint>

/// Port numbers for XML-RPC services provided by HCR processes
const uint16_t HCR_XMITD_PORT =             8000;  ///< hcr_xmitd port
const uint16_t FIREFLYD_PORT =              8001;  ///< fireflyd port
const uint16_t CMIGITSDAEMON_PORT =         8002;  ///< cmigitsDaemon port
const uint16_t HCRPMC730DAEMON_PORT =       8003;  ///< HcrPmc730Daemon port
const uint16_t HCRMONITOR_PORT =            8004;  ///< HcrMonitor port
const uint16_t SPECTRACOMDAEMON_PORT =      8005;  ///< SpectracomDaemon port
const uint16_t PRIMARYINSDAEMON_PORT =      53005; ///< primary cmigitsDaemon port
const uint16_t SECONDARYINSDAEMON_PORT =    53006; ///< secondary cmigitsDaemon port
const uint16_t HCRDRX_PORT =                8081;  ///< hcrdrx port
const uint16_t MOTIONCONTROLDAEMON_PORT =   8080;  ///< MotionControlDaemon port

#endif // #ifndef _HCRPORTNUMBERS_H_
