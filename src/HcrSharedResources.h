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
const uint16_t INS1_DAEMON_PORT =           53005; ///< INS1 cmigitsDaemon port
const uint16_t INS2_DAEMON_PORT =           53006; ///< INS2 cmigitsDaemon port
const uint16_t HCRDRX_PORT =                8081;  ///< hcrdrx port
const uint16_t MOTIONCONTROLDAEMON_PORT =   8080;  ///< MotionControlDaemon port

/// FMQ URLs for our two INSs
#define INS1_FMQ_URL "/tmp/cmigits_fmq/shmem_22000"
#define INS2_FMQ_URL "/tmp/cmigits_fmq/shmem_22002"

#endif // #ifndef _HCRSHAREDRESOURCES_H_
