#ifndef _HCRPORTNUMBERS_H_
#define _HCRPORTNUMBERS_H_

#include <cstdint>

/// Port numbers for XML-RPC services provided by HCR processes
const uint16_t HCR_XMITD_PORT =             53000;  ///< hcr_xmitd port
const uint16_t FIREFLYD_PORT =              53001;  ///< fireflyd port
const uint16_t CMIGITSDAEMON_PORT =         53002;  ///< cmigitsDaemon port
const uint16_t HCRPMC730DAEMON_PORT =       53003;  ///< HcrPmc730Daemon port
const uint16_t HCRMONITOR_PORT =            53004;  ///< HcrMonitor port
const uint16_t SPATIALFOGDAEMON_PORT =      53005;  ///< SpatialFogDaemon port
const uint16_t HCRDRX_PORT =                53006;  ///< hcrdrx port
const uint16_t MOTIONCONTROLDAEMON_PORT =   53007;  ///< MotionControlDaemon port

#endif // #ifndef _HCRPORTNUMBERS_H_
