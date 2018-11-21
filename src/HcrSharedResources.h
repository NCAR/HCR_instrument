#ifndef _HCRSHAREDRESOURCES_H_
#define _HCRSHAREDRESOURCES_H_

#include <cstdint>
#include <string>

/// Port numbers for XML-RPC services provided by HCR processes
static const uint16_t HCR_XMITD_PORT =             8000;  ///< hcr_xmitd port
static const uint16_t FIREFLYD_PORT =              8001;  ///< fireflyd port
static const uint16_t HCRPMC730DAEMON_PORT =       8003;  ///< HcrPmc730Daemon port
static const uint16_t HCREXECUTIVE_PORT =          8004;  ///< HcrExecutive port
static const uint16_t SPECTRACOMDAEMON_PORT =      8005;  ///< SpectracomDaemon port
static const uint16_t INS1_DAEMON_PORT =           53005; ///< INS1 cmigitsDaemon port
static const uint16_t INS2_DAEMON_PORT =           53006; ///< INS2 cmigitsDaemon port
static const uint16_t HCRDRX_PORT =                8081;  ///< hcrdrx port
static const uint16_t MOTIONCONTROLDAEMON_PORT =   8080;  ///< MotionControlDaemon port

/// FMQ URLs for our two INSs
#define INS1_FMQ_URL "/tmp/cmigits_fmq/shmem_22000"
#define INS2_FMQ_URL "/tmp/cmigits_fmq/shmem_22002"

/// Pitch INS difference which generates an error
static const double PITCH_DIFF_BAD =    0.5;    // deg
/// Pitch INS difference which generates a warning
static const double PITCH_DIFF_WARN =   0.25;   // deg

/// Roll INS difference which generates an error
static const double ROLL_DIFF_BAD =     0.5;    // deg
/// Roll INS difference which generates a warning
static const double ROLL_DIFF_WARN =    0.25;   // deg

/// Heading INS difference which generates an error
static const double HEADING_DIFF_BAD =  5.0;    // deg
/// Heading INS difference which generates a warning
static const double HEADING_DIFF_WARN = 2.5;    // deg

/// Ground speed INS difference which generates an error
static const double GNDSPEED_DIFF_BAD = 10.0;   // m/s
/// Ground speed INS difference which generates a warning
static const double GNDSPEED_DIFF_WARN = 5.0;   // m/s

// Minimum ground speed for which we expect a meaningful ground track
static const double GNDTRACK_TEST_MIN_SPEED = 10.0;  // m/s

/// Ground track INS difference which generates an error
static const double GNDTRACK_DIFF_BAD = 1.0;    // deg
/// Ground track INS difference which generates a warning
static const double GNDTRACK_DIFF_WARN = 0.5;   // deg

/// Vertical speed INS difference which generates an error
static const double VERTSPEED_DIFF_BAD = 5.0;   // m/s
/// Vertical speed INS difference which generates a warning
static const double VERTSPEED_DIFF_WARN = 2.5;  // m/s

/// Latitude INS difference which generates an error
static const double LATITUDE_DIFF_BAD = 0.01;   // deg
/// Latitude INS difference which generates a warning
static const double LATITUDE_DIFF_WARN = 0.001; // deg

/// Longitude INS difference which generates an error
static const double LONGITUDE_DIFF_BAD = 0.01;  // deg
/// Longitude INS difference which generates a warning
static const double LONGITUDE_DIFF_WARN = 0.001;// deg

/// Altitude INS difference which generates an error
static const double ALTITUDE_DIFF_BAD = 50;     // m
/// Altitude INS difference which generates a warning
static const double ALTITUDE_DIFF_WARN = 20;    // m

#endif // #ifndef _HCRSHAREDRESOURCES_H_
