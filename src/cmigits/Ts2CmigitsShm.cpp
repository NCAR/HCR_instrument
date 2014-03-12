/*
 * Ts2CmigitsShm.cpp
 *
 *  Created on: Mar 12, 2014
 *      Author: burghart
 *
 *  This program reads a list of IWRF time series files, extracts the
 *  attitude and position metadata, and writes it into the CmigitsSharedMemory
 *  segment at the same rate it was originally generated. This effectively
 *  simulates a running cmigitsDaemon using existing data, except the shared
 *  memory time tags are current time rather than the time from the data
 *  being read.
 */
#include <csignal>
#include <ctime>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>
#include <radar/IwrfTsReader.hh>
#include <CmigitsSharedMemory.h>
#include <QCoreApplication>

bool Terminate = false;

void
sigHandler(int signum) {
    std::cout << "Stopping on signal!" << std::endl;
    Terminate = true;
}

int
main(int argc, char * argv[]) {
    QCoreApplication app(argc, argv);

    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <ts_file> [...]" << std::endl;
        return(1);
    }

    // Assemble a vector with the input file names
    std::vector<std::string> fileList;
    for (int i = 1; i < argc; i++) {
        fileList.push_back(argv[i]);
    }

    // Create the reader for the list of time series files
    IwrfTsReaderFile reader(fileList, IWRF_DEBUG_OFF);

    // Create the CmigitsSharedMemory segment with this process as the writer
    CmigitsSharedMemory cmigitsShm(true);

    // Bail out gracefully on TERM or INT signals
    signal(SIGINT, sigHandler);
    signal(SIGTERM, sigHandler);

    // Now loop through pulses from our reader
    IwrfTsPulse * pulse = 0;
    int pulseCount = 0;
    int shmWrites = 0;
    int delayedPulses = 0;
    int sleepSumUsecs = 0;
    int delaySumUsecs = 0;

    double lastPulseTime = 0.0;
    double lastSendTime = 0.0;
    float lastPitch = 0.0;
    float lastRoll = 0.0;
    float lastHeading = 0.0;
    float lastVelNorth = 0.0;
    float lastVelEast = 0.0;
    float lastVelUp = 0.0;

    while ((pulse = reader.getNextPulse()) != NULL  && ! Terminate) {
        app.processEvents();

        // If georef updates are not active, there's nothing we can write
        // to CmigitsSharedMemory, so just bail out now.
        if (! pulse->getGeorefActive()) {
            std::cerr << "No active georef at pulse " << pulseCount <<
                    ", so there's nothing to write to CmigitsSharedMemory!" <<
                    std::endl;
            break;
        }

        pulseCount++;
        double pulseTime = pulse->getFTime();

        struct timespec nowTimeSpec;
        clock_gettime(CLOCK_REALTIME, &nowTimeSpec);
        double nowTime = nowTimeSpec.tv_sec + 1.0e-9 * nowTimeSpec.tv_nsec;

        if (! lastSendTime) {
            lastSendTime = nowTime;
            lastPulseTime = pulseTime;
        }

        // Sleep long enough to get the inter-pulse period right.
        int sleepTimeUsecs = 0;
        double sendTime = lastSendTime + (pulseTime - lastPulseTime);
        sleepTimeUsecs = 1000000 * (sendTime - nowTime);

        if (sleepTimeUsecs > 0) {
            // Sleep until it's time to deliver this pulse
            sleepSumUsecs += sleepTimeUsecs;
            usleep(sleepTimeUsecs);
        } else if (sleepTimeUsecs < 0) {
            // Negative sleep implies we've fallen behind. Keep track of
            // delayed pulses and total delay time.
            delayedPulses++;
            delaySumUsecs += -sleepTimeUsecs;
        }

        // Keep our last send and pulse time
        lastSendTime = sendTime;
        lastPulseTime = pulseTime;

        // If any georef data changes, put the data from the pulse into 
        // CmigitsSharedMemory
        const iwrf_platform_georef_t & georef = pulse->getPlatformGeoref();

        bool doWrite = (georef.pitch_deg != lastPitch)
                || (georef.roll_deg != lastRoll)
                || (georef.heading_deg != lastHeading)
                || (georef.ns_velocity_mps != lastVelNorth)
                || (georef.ew_velocity_mps != lastVelEast)
                || (georef.vert_velocity_mps != lastVelUp);

        if (doWrite) {
            // Tag the data going to CmigitsSharedMemory with current time
            // rather than the time from the data.
            uint64_t tagMsecsSinceEpoch(1000 * sendTime);

            cmigitsShm.storeLatest3501Data(tagMsecsSinceEpoch,
                    georef.latitude, georef.longitude,
                    1000.0 * georef.altitude_msl_km);
            cmigitsShm.storeLatest3512Data(tagMsecsSinceEpoch,
                    georef.pitch_deg, georef.roll_deg, georef.heading_deg,
                    georef.ns_velocity_mps, georef.ew_velocity_mps,
                    georef.vert_velocity_mps);

            shmWrites++;

            lastPitch = georef.pitch_deg;
            lastRoll = georef.roll_deg;
            lastHeading = georef.heading_deg;
            lastVelNorth = georef.ns_velocity_mps;
            lastVelEast = georef.ew_velocity_mps;
            lastVelUp = georef.vert_velocity_mps;
        }

        // Delete the pulse
        delete(pulse);
    }

    std::cout << "Processed " << pulseCount << " pulses, with " <<
            shmWrites << " CmigitsSharedMemory writes" << std::endl;
    std::cout << "Average sleep per pulse " <<
            float(sleepSumUsecs) / pulseCount << " us" << std::endl;
    std::cout << delayedPulses << " pulses (" <<
            std::fixed << std::setprecision(2) <<
            100 * (float(delayedPulses) / pulseCount) <<
            "%) were delayed, with average delay of " <<
            std::setprecision(1) <<
            float(delaySumUsecs) / delayedPulses << " us" << std::endl;
    return(0);
}
