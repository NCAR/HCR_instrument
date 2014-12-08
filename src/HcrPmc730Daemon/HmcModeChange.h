/*
 * HmcModeChange.h
 *
 * Port number and struct used when broadcasting HMC operation mode changes.
 * 
 *  Created on: Dec 2, 2014
 *      Author: burghart
 */

#ifndef HMCMODECHANGE_H_
#define HMCMODECHANGE_H_

#include <HcrPmc730.h>

/// UDP port on which HMC operation mode changes are broadcast. The
/// form of the broadcast datagram is a 4-byte integer with the new mode, 
/// followed by an 8-byte floating point value containing the time of the 
/// mode change in seconds since 1970-01-01 00:00:00.000 UTC, for a total
/// of 12 bytes.
static const uint16_t HMC_MODE_BROADCAST_PORT = 56565;

/// The struct which is broadcast upon HMC operation mode change
typedef struct {
    HcrPmc730::HmcOperationMode mode;   // the new HMC mode
    double modeChangeTime;              // double precision time of the mode change,
                                        // seconds since 1970-01-01 00:00 UTC 
} HmcModeChangeStruct;

#endif /* HMCMODECHANGE_H_ */
