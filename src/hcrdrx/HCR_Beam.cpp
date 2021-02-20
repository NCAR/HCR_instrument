// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
// ** Copyright UCAR (c) 2018-2021
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
 * HCR_Beam.cpp
 *
 *  Created on: August 31, 2018
 *      Author: karboski
 */

#include "HCR_Beam.h"
#include <logx/Logging.h>

LOGGING("HCR_Beam")

HCR_Beam::HCR_Beam(uint32_t transmittedWord, uint32_t receivedWord,
                     iwrf_scan_mode_t scanMode, int sweepNumber) :
    _txPolarization(_UnpackTxPol(receivedWord)),
    _rxPolarization(_UnpackRxPol(receivedWord)),
    _scanMode(scanMode),
    _sweepNumber(sweepNumber),
    _beamAngleIndex(_UnpackBeamAngleIndex(receivedWord)),
    _rxErrorFlag(_UnpackErrorFlag(receivedWord)),
    _rxRunningFlag(_UnpackRunningFlag(receivedWord)),
    _rxArmedFlag(_UnpackArmedFlag(receivedWord))
{

    // If bits that should be echoed unmodified are different, set the
    // _rxBitErrorFlag
    uint32_t unmodifiedBitMask = ~( (1<<ERROR_BIT) | (1<<RUNNING_BIT) );
    if ( (transmittedWord & unmodifiedBitMask) != (receivedWord & unmodifiedBitMask) ) {
        std::ostringstream os;
        os << std::hex << std::setw(8) << std::setfill('0') <<
              "Received word 0x" << receivedWord <<
              " is a bad reply to transmittedWord 0x" << transmittedWord;
        throw(UART_Error(os.str()));
    }

}

uint32_t HCR_Beam::makeBeamCommand(uint32_t trAddress, bool arm, bool broadcast)
{
    uint32_t result;

    // Compile the flags/values into a 32-bit TR module command
    result = BEAM_WRITE_CMD << COMMAND_BIT;
    result |= (_beamAngleIndex & BEAM_POSITION_MASK) << BEAM_BIT;
    result |= (_rxPolarization & 1) << RX_POL_BIT;
    result |= (_txPolarization & 1) << TX_POL_BIT;
    result |= (trAddress & TR_ADDRESS_MASK) << TR_ADDRESS_BIT;
    result |= broadcast ? (1 << BROADCAST_BIT) : 0;
    result |= arm ? (1 << ARMED_BIT) : 0;

    return result;
}

uint32_t HCR_Beam::MakeTemperatureCommand(uint32_t trAddress)
{
    uint32_t result;

    // Compile the flags/values into a 32-bit TR module command
    result = TEMP_READ_CMD << COMMAND_BIT;
    result |= (trAddress & TR_ADDRESS_MASK) << TR_ADDRESS_BIT;

    return result;
}

uint32_t HCR_Beam::MakeDisarmCommand(uint32_t trAddress)
{
    uint32_t result;

    // Make command message without the 'Armed' bit set
    result = BEAM_WRITE_CMD << COMMAND_BIT;
    result |= (trAddress & TR_ADDRESS_MASK) << TR_ADDRESS_BIT;
    result |= (1 << BROADCAST_BIT);

    return result;
}

float HCR_Beam::ParseTemperatureResponse(uint32_t transmittedWord, uint32_t receivedWord)
{
    // Check the bits that should be echoed unmodified
    uint32_t unmodifiedBitMask = ~PAYLOAD_MASK;
    if ( (transmittedWord & unmodifiedBitMask) != (receivedWord & unmodifiedBitMask) ) {
        std::ostringstream os;
        os << std::hex << std::setw(8) << std::setfill('0') <<
              "Received word 0x" << receivedWord <<
              " is a bad reply to transmittedWord 0x" << transmittedWord;
        throw(UART_Error(os.str()));
    }

    //Parse the temperature
    uint32_t temperatureRaw = (receivedWord & 0xFFF8);
    return (float)temperatureRaw / 128.0;

}
