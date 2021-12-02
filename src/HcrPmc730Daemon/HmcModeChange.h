// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2016                                         
// ** University Corporation for Atmospheric Research (UCAR)                 
// ** National Center for Atmospheric Research (NCAR)                        
// ** Boulder, Colorado, USA                                                 
// ** BSD licence applies - redistribution and use in source and binary      
// ** forms, with or without modification, are permitted provided that       
// ** the following conditions are met:                                      
// ** 1) If the software is modified to produce derivative works,            
// ** such modified software should be clearly marked, so as not             
// ** to confuse it with the version available from UCAR.                    
// ** 2) Redistributions of source code must retain the above copyright      
// ** notice, this list of conditions and the following disclaimer.          
// ** 3) Redistributions in binary form must reproduce the above copyright   
// ** notice, this list of conditions and the following disclaimer in the    
// ** documentation and/or other materials provided with the distribution.   
// ** 4) Neither the name of UCAR nor the names of its contributors,         
// ** if any, may be used to endorse or promote products derived from        
// ** this software without specific prior written permission.               
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS  
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED      
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.    
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
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
    HcrPmc730::OperationMode mode;      // the new HMC mode
    double modeChangeTime;              // double precision time of the mode change,
                                        // seconds since 1970-01-01 00:00 UTC 
} HmcModeChangeStruct;

#endif /* HMCMODECHANGE_H_ */
