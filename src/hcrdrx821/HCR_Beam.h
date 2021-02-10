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
 * HCR_Beam.h
 *
 *  Created on: August 31, 2018
 *      Author: karboski
 */

#ifndef HCR_Beam_H_
#define HCR_Beam_H_

#include <cstdint>
#include <stdexcept>
#include <string>
#include <iomanip>
#include <sstream>
#include <radar/iwrf_data.h>

/// @brief Class to hold TR module beam configuration and status
class HCR_Beam {

public:

    /// @brief Enumerated type of allowed beam polarizations
    typedef enum {
        POL_UNKNOWN = -1,
        POL_VERTICAL,
        POL_HORIZONTAL
    } Polarization;

    // bounding rectangle of the beam table in degrees
    static constexpr double AZ_TABLE_MIN = -45.0;       ///< left bound of beam table
    static constexpr double AZ_TABLE_MAX = 45.0;        ///< right bound of beam table
    static constexpr double AZ_TABLE_INCREMENT = 5.0;   ///< az increment for beam table
    static constexpr double EL_TABLE_MIN = -45.0;       ///< bottom bound of beam table
    static constexpr double EL_TABLE_MAX = 45.0;        ///< top bound beam table
    static constexpr double EL_TABLE_INCREMENT = 5.0;   ///< el increment for beam table

    // bounding rectangle of the scan pattern in degrees
    // Used to exclude certain angles e.g. to not hit the roof.
    static constexpr double AZ_SCAN_MIN = -45.0;        ///< left bound of scan
    static constexpr double AZ_SCAN_MAX = 45.0;         ///< right bound of scan
    static constexpr double AZ_SCAN_INCREMENT = 5.0;    ///< az increment for scan
    static constexpr double EL_SCAN_MIN = 0.0;          ///< bottom bound of scan
    static constexpr double EL_SCAN_MAX = 45.0;         ///< top bound scan
    static constexpr double EL_SCAN_INCREMENT = 5.0;    ///< el increment for scan

    /// @brief Exception thrown when a UART error is detected
    class UART_Error : public std::runtime_error {
    public:
        UART_Error(std::string what) : std::runtime_error(what) {}
        virtual ~UART_Error() {}
    };

    /// @brief HCR_Beam constructor
    HCR_Beam() :
        _txPolarization(POL_UNKNOWN),
        _rxPolarization(POL_UNKNOWN),
        _scanMode(IWRF_SCAN_MODE_NOT_SET),
        _sweepNumber(-1),
        _beamAngleIndex(0),
        _rxErrorFlag(0),
        _rxRunningFlag(0),
        _rxArmedFlag(0) {};

    /// @brief HCR_Beam constructor
    HCR_Beam(Polarization txPolarization,
              Polarization rxPolarization,
              iwrf_scan_mode_t scanMode,
              int sweepNumber,
              uint32_t beamPosition) :
        _txPolarization(txPolarization),
        _rxPolarization(rxPolarization),
        _scanMode(scanMode),
        _sweepNumber(sweepNumber),
        _beamAngleIndex(beamPosition),
        _rxErrorFlag(0),
        _rxRunningFlag(0),
        _rxArmedFlag(0) {};

    /// @brief Construct using a command sent to the TR module and the received
    /// reply.
    /// @param transmittedWord the command word sent to the TR module
    /// @param receivedWord the reply received in response to the command
    /// @param scanMode IWRF scan mode for this beam
    /// @param sweepNumber for this beam
    /// @throw UART_Error if receivedWord does not correctly echo the bits
    /// expected to be unmodified from transmittedWord
    HCR_Beam(uint32_t transmittedWord, uint32_t receivedWord,
              iwrf_scan_mode_t scanMode, int sweepNumber);

    /// @brief Return true iff all members are the same between this instance
    /// and another HCR_Beam.
    bool operator==(const HCR_Beam & other) const {
        bool same = true;
        same &= (_txPolarization == other._txPolarization);
        same &= (_rxPolarization == other._rxPolarization);
        same &= (_beamAngleIndex == other._beamAngleIndex);
        same &= (_rxErrorFlag == other._rxErrorFlag);
        same &= (_rxRunningFlag == other._rxRunningFlag);
        same &= (_rxArmedFlag == other._rxArmedFlag);
        return same;
    }

    /// @brief Return true iff any members differ between this instance
    /// and another HCR_Beam.
    bool operator!=(const HCR_Beam & other) const {
        return (! this->operator==(other));
    }

    /// @brief Make a TR command word corresponding to the object's position and polarization
    /// @param trAddress the target TR module
    /// @param arm if true set the 'arm' bit, otherwise dry run
    /// @param broadcast if true then command all modules
    uint32_t makeBeamCommand(uint32_t trAddress, bool arm, bool broadcast);

    /// @brief Make a disarm command word
    static uint32_t MakeDisarmCommand(uint32_t trAddress);

    /// @brief Make a TR command word to read the TR element temperature
    /// @param trAddress the target TR module
    static uint32_t MakeTemperatureCommand(uint32_t trAddress);

    /// @brief Parse the response to the temperature command.
    /// @return the temperature in Celsius
    /// @throw UART_Error if receivedWord does not correctly echo the bits
    /// expected to be unmodified from transmittedWord
    static float ParseTemperatureResponse(uint32_t transmittedWord,
                                          uint32_t receivedWord);

    /// @brief Set by parseBeamResponse to indicate the TR module set its error condition flag
    inline bool rxErrorFlag()    { return _rxErrorFlag; };

    /// @brief Set by parseBeamResponse to indicate the TR module is executing a beam on the current TQS
    inline bool rxRunningFlag()  { return _rxRunningFlag; };

    /// @brief Set by parseBeamResponse to indicate the TR module is ready to execute a beam on the next TQS
    inline bool rxArmedFlag()    { return _rxArmedFlag; };

    /// @brief Return the TX polarization
    inline Polarization txPolarization()    { return _txPolarization; };

    /// @brief Return the RX polarization
    inline Polarization rxPolarization()    { return _rxPolarization; };

    /// @brief Return the scan mode in effect for this beam
    /// @return the scan mode in effect for this beam
    inline iwrf_scan_mode_t scanMode() { return _scanMode; };

    /// @brief Return the sweep number for this beam
    /// @return the sweep number for this beam
    inline int sweepNumber() { return _sweepNumber; };

    /// @brief Return the beam's index in the beam pointing lookup table
    inline uint32_t beamAngleIndex()      { return _beamAngleIndex; };

    /// @brief Return the beam pointing azimuth w.r.t. the antenna face, in
    /// degrees
    /// @return the beam pointing azimuth w.r.t. the antenna face, in
    /// degrees
    inline double beamAzimuth() {
        return(AzimuthOfBeamAngleIndex(_beamAngleIndex));
    }

    /// @brief Return the beam pointing elevation w.r.t. the antenna face, in
    /// degrees
    /// @return the beam pointing elevation w.r.t. the antenna face, in
    /// degrees
    inline double beamElevation() {
        return(ElevationOfBeamAngleIndex(_beamAngleIndex));
    }

    /// @brief Return the beam pointing azimuth w.r.t. the antenna face for the
    /// given index in the beam angle array, in degrees
    /// @param index the index in the beam angle array
    /// @return the beam pointing azimuth w.r.t. the antenna face for the given
    /// index in the beam angle array, in degrees
    static inline double AzimuthOfBeamAngleIndex(uint32_t index) {
        // Azimuth is the inner dimension of the index, with origin at AZ_TABLE_MIN degrees
        int azDim = ((AZ_TABLE_MAX - AZ_TABLE_MIN) / AZ_TABLE_INCREMENT) + 1;
        int elDim = ((EL_TABLE_MAX - EL_TABLE_MIN) / EL_TABLE_INCREMENT) + 1;
        // Discard the table number
        int tableIndex = index % (azDim * elDim);
        // Get the array index
        int azInt = tableIndex % azDim;
        return -(AZ_TABLE_MIN + (azInt * AZ_TABLE_INCREMENT));
    }

    /// @brief Return the beam pointing elevation w.r.t. the antenna face for
    /// the given index in the beam angle array, in degrees
    /// @param index the index in the beam angle array
    /// @return the beam pointing elevation w.r.t. the antenna face for
    /// the given index in the beam angle array, in degrees
    static inline double ElevationOfBeamAngleIndex(uint32_t index) {
        // Azimuth is the second dimension of the index, with origin at EL_TABLE_MIN degrees
        int azDim = ((AZ_TABLE_MAX - AZ_TABLE_MIN) / AZ_TABLE_INCREMENT) + 1;
        int elDim = ((EL_TABLE_MAX - EL_TABLE_MIN) / EL_TABLE_INCREMENT) + 1;
        // Discard the table number
        int tableIndex = index % (azDim * elDim);
        // Get the array index
        int elInt = tableIndex / azDim;
        return -(EL_TABLE_MIN + (elInt * EL_TABLE_INCREMENT));
    }

    /// @brief Return the beam angle array index, given azimuth, elevation, and table number
    /// @param az the azimuth angle, in degrees
    /// @param el the elevation angle, in degrees
    /// @param tableNumber the number of the table (increments the index by tableNumber*tableSize)
    /// @return the beam table index
    static inline uint32_t BeamAngleIndexOfAzEl(double az, double el, int tableNumber) {
        int azIndex = (-az - AZ_TABLE_MIN) / AZ_TABLE_INCREMENT;
        int elIndex = (-el - EL_TABLE_MIN) / EL_TABLE_INCREMENT;
        int azDim = ((AZ_TABLE_MAX - AZ_TABLE_MIN) / AZ_TABLE_INCREMENT) + 1;
        int elDim = ((EL_TABLE_MAX - EL_TABLE_MIN) / EL_TABLE_INCREMENT) + 1;
        int index = (tableNumber * azDim * elDim) + (elIndex * azDim) + azIndex;

        if (az < AZ_TABLE_MIN || az > AZ_TABLE_MAX || el < EL_TABLE_MIN || el > EL_TABLE_MAX || index < 0 || index > 1023) {
            std::ostringstream os;
            os << "Requested beam (" << az << ", " << el << ") in table " << tableNumber << " is outside the beam table.";
            throw std::runtime_error(os.str());
        }
        return index;
    }

private:
    /// @brief Unpack TX polarization from a 32-bit TR command word or
    /// response
    inline static Polarization _UnpackTxPol(uint32_t trWord) {
        return Polarization((trWord >> TX_POL_BIT) & 1);
    }

    /// @brief Unpack RX polarization from a 32-bit TR command word or
    /// response
    inline static Polarization _UnpackRxPol(uint32_t trWord) {
        return Polarization((trWord >> RX_POL_BIT) & 1);
    }

    /// @brief Unpack beam angle index from a 32-bit TR command word or
    /// response
    inline static uint32_t _UnpackBeamAngleIndex(uint32_t trWord) {
        return ((trWord >> BEAM_BIT) & BEAM_POSITION_MASK);
    }

    /// @brief Unpack the error flag from a 32-bit TR command word or
    /// response
    inline static bool _UnpackErrorFlag(uint32_t trWord) {
        return ((trWord >> ERROR_BIT) & 1);
    }

    /// @brief Unpack the running flag from a 32-bit TR command word or
    /// response
    inline static bool _UnpackRunningFlag(uint32_t trWord) {
        return ((trWord >> RUNNING_BIT) & 1);
    }

    /// @brief Unpack the armed flag from a 32-bit TR command word or
    /// response
    inline static bool _UnpackArmedFlag(uint32_t trWord) {
        return ((trWord >> ARMED_BIT) & 1);
    }


    /// @brief The transmit polarization for this beam
    Polarization _txPolarization;

    /// @brief The receive polarization for this beam
    Polarization _rxPolarization;

    /// @brief The scan mode in effect for this beam
    iwrf_scan_mode_t _scanMode;

    /// @brief The sweep number for this beam
    int _sweepNumber;

    /// @brief The beam's index in the beam pointing lookup table
    uint32_t _beamAngleIndex;

    /// @brief True iff the TR module response had the error condition flag set
    bool _rxErrorFlag;

    /// @brief True iff the TR module responded it is executing a beam on the
    /// current TQS
    bool _rxRunningFlag;

    /// @brief True iff the TR module responded it is ready to execute a beam
    /// on the next TQS
    bool _rxArmedFlag;

    /// @brief TR module opcode for activating beams
    static constexpr uint32_t BEAM_WRITE_CMD = 0xC6;
    static constexpr uint32_t TEMP_READ_CMD = 0x10;

    // bit positions and masks within the beam command
    static constexpr uint32_t BROADCAST_BIT = 31;
    static constexpr uint32_t TR_ADDRESS_BIT = 24;
    static constexpr uint32_t COMMAND_BIT = 16;
    static constexpr uint32_t ARMED_BIT = 15;
    static constexpr uint32_t RUNNING_BIT = 14;
    static constexpr uint32_t TX_POL_BIT = 13;
    static constexpr uint32_t RX_POL_BIT = 12;
    static constexpr uint32_t ERROR_BIT = 11;
    static constexpr uint32_t BEAM_BIT = 0;

    static constexpr uint32_t BEAM_POSITION_MASK = 0x3FF;
    static constexpr uint32_t TR_ADDRESS_MASK = 0xFF;
    static constexpr uint32_t COMMAND_MASK = 0xFF;
    static constexpr uint32_t PAYLOAD_MASK = 0xFFFF;

};


#endif /* HCR_Beam_H_ */
