/*
 * TimeSeriesAdapter.cpp
 *
 *  Created on: May 20, 2010
 *      Author: burghart
 */

#include <iostream>

#include "TimeSeriesAdapter.h"

static const double SPEED_OF_LIGHT = 2.99792458e8; // m s-1

void
TimeSeriesAdapter::DDSToIwrf(const ProfilerDDS::TimeSeries& ddsPulse,
        IwrfTsPulse& iwrfPulse, si64 packetSequenceNum) {
    // Populate our IwrfTsPulse object
    const ProfilerDDS::TSHousekeeping& hskp = ddsPulse.hskp;
    int sec = hskp.timetag / 1000000; // secs since 1970-01-01 00:00:00 UTC
    int nanosec = (hskp.timetag % 1000000) * 1000; // usecs -> nanosecs

    iwrfPulse.setTime(sec, nanosec);
    iwrfPulse.set_pulse_seq_num(packetSequenceNum);
    iwrfPulse.set_scan_mode(IWRF_SCAN_MODE_POINTING);
    iwrfPulse.set_follow_mode(IWRF_FOLLOW_MODE_NOT_SET);
    iwrfPulse.set_volume_num(1);
    iwrfPulse.set_sweep_num(1);    // @TODO
    iwrfPulse.set_fixed_el(0.0);
    iwrfPulse.set_fixed_az(0.0);
    iwrfPulse.set_elevation(0.0);
    iwrfPulse.set_azimuth(0.0);    // @TODO this should probably be radar rotation angle
    double prt = ddsPulse.hskp.prt1;
    iwrfPulse.set_prt(prt);
    iwrfPulse.set_prt_next(prt);
    // Note that pulse_width_us and gate_spacing are redundant! If you change 
    // one, make sure you make the appropriate change to the other!
    iwrfPulse.set_pulse_width_us(hskp.rcvr_pulse_width * 1.0e6);
    iwrfPulse.set_gate_spacing_m(0.5 * SPEED_OF_LIGHT * hskp.rcvr_pulse_width);
    iwrfPulse.set_start_range_m(0.5 * SPEED_OF_LIGHT * hskp.rcvr_gate0_delay);
    iwrfPulse.set_n_gates(ddsPulse.hskp.gates);
    iwrfPulse.set_n_channels(1);   // @TODO need real channel count
    
    // Make certain that ddsPulse.data.get_buffer() contains 2-byte values, 
    // since we count on it when passing it to setIqPacked() below...
    assert(sizeof(ddsPulse.data[0]) == sizeof(si16));
    
    // Our IQ data are already scaled 16-bit signed ints, and in the same
    // order that IwrfTsPulse wants. So we stuff them directly into iwrfPulse.
    
    // The scale factor used by ProfilerDDS::TimeSeries is:
    //     I      = I       * iqScale + iqOffset
    //      volts    counts
    // Same formula for Q.
    float iqScale = 1.0 / (32768 * sqrt(2.0));
    float iqOffset = 0.0;
    iwrfPulse.setIqPacked(ddsPulse.hskp.gates, 1, IWRF_IQ_ENCODING_SCALED_SI16,
            ddsPulse.data.get_buffer(), iqScale, iqOffset);

}

void
TimeSeriesAdapter::IwrfToDDS(const IwrfTsPulse& iwrfPulse,
        ProfilerDDS::TimeSeries& ddsPulse) {
    // We may need to make a copy of iwrfPulse for non-const operations
    IwrfTsPulse *iwrfPulseCopy = 0;
    // Copy metadata from iwrfPulse to ddsPulse
    ddsPulse.hskp.chanId = 0;   // we only do channel 0!
    ddsPulse.hskp.timetag = 1000000LL * iwrfPulse.getTime() + 
        iwrfPulse.getNanoSecs() / 1000;
    ddsPulse.hskp.prt1 = iwrfPulse.getPrt();
    int nGates = iwrfPulse.getNGates();
    ddsPulse.hskp.gates = nGates;
    ddsPulse.hskp.rcvr_pulse_width = 1.0e-6 * iwrfPulse.get_pulse_width_us();
    ddsPulse.hskp.rcvr_gate0_delay = 2.0 * 
        iwrfPulse.get_start_range_m() / SPEED_OF_LIGHT;

    // Get a pointer to the iwrfPulse data, which must be floating point.
    const fl32 *iwrfIq = iwrfPulse.getIq0();
    if (iwrfPulse.get_iq_encoding() != IWRF_IQ_ENCODING_FL32) {
        // Since convertToFL32() is a non-const method for IwrfTsPulse,
        // we need to copy iwrfPulse, then convert the data to fl32, then
        // get a pointer to the data. Keep around the copy until we're done
        // with its data.
        iwrfPulseCopy = new IwrfTsPulse(iwrfPulse);
        iwrfPulseCopy->convertToFL32();
        iwrfIq = iwrfPulseCopy->getIq0();
    }
    
    // set data space in ddsPulse for the right number of gates
    ddsPulse.data.length(2 * nGates);
    
    // The scale factor used by ProfilerDDS::TimeSeries is:
    //     I       = (I      - ddsOffset) / ddsScale
    //      counts     volts
    // Similar formula for Q.
    float ddsScale = 1.0 / (32768 * sqrt(2.0));
    float ddsOffset = 0.0;
    
    for (int g = 0; g < ddsPulse.hskp.gates; g++) {
        // I
        ddsPulse.data[2 * g] = (iwrfIq[2 * g] - ddsOffset) / ddsScale;
        // Q
        ddsPulse.data[2 * g + 1] = (iwrfIq[2 * g + 1] - ddsOffset) / ddsScale;
    }
    // We're done with the data, so now we can delete our copy of iwrfPulse
    // (if we needed to make one)
    if (iwrfPulseCopy)
        delete(iwrfPulseCopy);
}
