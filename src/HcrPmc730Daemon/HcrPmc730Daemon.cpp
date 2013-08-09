/*
 * HcrPmc730Daemon.cpp
 *
 *  Created on: Aug 9, 2013
 *      Author: hcr
 */
#include <csignal>
#include <toolsa/pmu.h>
#include <logx/Logging.h>
#include <HcrPmc730.h>

LOGGING("HcrPmc730Daemon")

std::string _instance = "ops";   ///< application instance name

int
main(int argc, char * argv[]) {
    // Make sure our HcrPmc730 is created in simulation mode if requested
//    HcrPmc730::doSimulate(hcrConfig.simulate_pmc730());
    HcrPmc730::doSimulate(false);

    // Just refer to theHcrPmc730() to instantiate the singleton.
    HcrPmc730::theHcrPmc730();

    // Initialize output lines.
    HcrPmc730::setXmitterFilamentOn(false);
    HcrPmc730::setXmitterHvOn(false);
    HcrPmc730::setHmcOperationMode(HcrPmc730::HMC_CORNER_REFLECTOR_CAL);

    // set to ignore SIGPIPE errors which occur when sockets
    // are broken between client and server
    signal(SIGPIPE, SIG_IGN);

    // set up registration with procmap if instance is specified
    if (_instance.size() > 0) {
      PMU_auto_init("HcrPmc730Daemon", _instance.c_str(), PROCMAP_REGISTER_INTERVAL);
      ILOG << "Will register with procmap as instance: " << _instance;
    }
}
