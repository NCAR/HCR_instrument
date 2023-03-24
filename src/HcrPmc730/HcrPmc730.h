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
 * HcrPmc730.h
 *
 *  Copied from KaPmc730: Nov 4, 2011
 *      Author: burghart
 */

#ifndef HCRPMC730_H_
#define HCRPMC730_H_

#include "Pmc730.h"
#include <OperationMode.h>
#include <Archive_xmlrpc_c.h>
#include <exception>

/// Control a singleton instance of Pmc730 for the one PMC730 card on the
/// HCR DRX machine.
class HcrPmc730 : public Pmc730 {
public:
    /// @brief Return a reference to HCR's singleton Pmc730 instance.
    /// @return a reference to HCR's singleton Pmc730 instance.
    static HcrPmc730 & TheHcrPmc730();

    /// Exception thrown for bad TTL voltage.
    class BadTtlVoltage : public std::exception {
    public:
        BadTtlVoltage(std::string desc = "") throw () : _desc(desc) {}
        ~BadTtlVoltage() throw () {}
        const char * what() { return(_desc.c_str()); }
    private:
        std::string _desc;
    };

    /// @brief Static method to change whether the singleton instance will be created
    /// as a simulated PMC-730. This must be called before the singleton is
    /// instantiated.
    /// @param simulate If true, the singleton will be created as a simulated
    /// PMC-730.
    static void DoSimulate(bool simulate);

    /// @brief Read and store voltage values from all 32 analog input channels.
    /// These stored values will be used will be used by accessor methods which
    /// refer to values derived from the analog input channels: detectedRfPower(),
    /// ploTemperature(), locked15_5GHzPLO(), and many others.
    ///
    /// Documentation for accessor methods affected by this method will mention
    /// their dependency on updateAnalogValues().
    static void UpdateAnalogValues() {
        TheHcrPmc730()._updateAnalogValues();
    }

    /// @brief Is the modulation pulse signal blocked at the HMC?
    /// @return true iff the modulation pulse signal is blocked at the HMC
    static bool ModPulseDisabled() {
        return(TheHcrPmc730().getDioLine(_HCR_DIN_HMC_MODPULSE_DISABLED));
    }

    /// @brief Return the detected RF power in dBm at the last call to
    /// updateAnalogValues(), adjusted to reflect power at the antenna port.
    /// @return the detected RF power in dBm at the last call to
    /// updateAnalogValues(), adjusted to reflect power at the antenna port.
    static double DetectedRfPower() {
        // The HCR breakout board provides a factor of 2 gain on the voltage
        // coming from the detector before sending the signal on to the PMC-730.
        // Remove that gain now.
        double detV = 0.5 * TheHcrPmc730()._analogValues[_HCR_AIN_CRYSTAL_DET_RF];

        // Convert to power at the detector
        double detectorPower = _MillitechDET10Power(detV);

        // Coupling losses between antenna port and detector. This is an
        // empirically determined value measured from the components.
        static const double DETECTOR_COUPLING_LOSSES = 66.5; // dB

        // Add the coupling losses into the detected power to obtain power at
        // the antenna port.
        double powerAtFeed = detectorPower + DETECTOR_COUPLING_LOSSES;

        // Limit our reported values to the range 0-100 dBm
        if (powerAtFeed < 0) {
            powerAtFeed = 0;
        } else if (powerAtFeed > 100) {
            powerAtFeed = 100;
        }

        return(powerAtFeed);
    }

    /// @brief Return the pressure vessel aft sensor pressure in hPa at the last
    /// call to updateAnalogValues().
    /// @return the pressure vessel aft sensor pressure in hPa at the last call
    /// to updateAnalogValues().
    static double PvAftPressure() {
        double voltage = TheHcrPmc730()._analogValues[_HCR_AIN_PV_AFT_PRESSURE];
        return(_30PSI_A_4V_Pres(voltage) + TheHcrPmc730()._pvPresCorrection);
    }

    /// @brief Return the pressure vessel fore sensor pressure in hPa at the last
    /// call to updateAnalogValues().
    /// @return the pressure vessel fore sensor pressure in hPa at the last call
    /// to updateAnalogValues().
    static double PvForePressure() {
        double voltage = TheHcrPmc730()._analogValues[_HCR_AIN_PV_FORE_PRESSURE];
        return(_30PSI_A_4V_Pres(voltage) + TheHcrPmc730()._pvPresCorrection);
    }

    /// @brief Convert pressure in PSI to hPa
    /// @param presPsi the pressure in PSI to be converted
    /// @return equivalent pressure in hPa
    static double PsiToHpa(double presPsi) {
        return(68.9475729 * presPsi);
    }

    /// @brief Return the pressure in hPa on the low-pressure side of the Active
    /// Pressurization System regulator at the last call to updateAnalogValues().
    /// @return the pressure in hPa on the low-pressure side of the Active
    /// Pressurization System regulator at the last call to updateAnalogValues().
    static double ApsLowSidePressure() {
        static const double VoltsPerPsi = 0.097947; // from Kulite calibration dated 2014-05-05
        double presPsi = TheHcrPmc730()._analogValues[_HCR_AIN_APS_LOW_SIDE_PRESSURE] /
                VoltsPerPsi;
        return(PsiToHpa(presPsi));
    }

    /// @brief Return the pressure in hPa on the high-pressure side of the Active
    /// Pressurization System regulator at the last call to updateAnalogValues().
    /// @return the pressure in hPa on the high-pressure side of the Active
    /// Pressurization System regulator at the last call to updateAnalogValues().
    static double ApsHighSidePressure() {
        static const double VoltsPerPsi = 0.002461; // from Kulite calibration dated 2014-05-05
        double presPsi = TheHcrPmc730()._analogValues[_HCR_AIN_APS_HIGH_SIDE_PRESSURE] /
                VoltsPerPsi;
        return(PsiToHpa(presPsi));
    }

    /// @brief Return the measured voltage from the 5V power supply at the last
    /// call to updateAnalogValues().
    /// @return the measured voltage from the 5V power supply at the last
    /// call to updateAnalogValues().
    static double Ps5vVoltage() {
        return TheHcrPmc730()._analogValues[_HCR_AIN_VOLTAGE_PS_5V];
    }

    /// @brief Return the PLO temperature in deg C at the last call to
    /// updateAnalogValues().
    /// @return the PLO temperature in deg C at the last call to
    /// updateAnalogValues().
    static double PloTemperature() {
        float pulldownVolts = TheHcrPmc730()._analogValues[_HCR_AIN_TEMP_PLO];
        return _Pt1000Temperature(Ps5vVoltage(), pulldownVolts);
    }

    /// @brief Return the EIK temperature in deg C at the last call to
    /// updateAnalogValues().
    /// @return the EIK temperature in deg C at the last call to
    /// updateAnalogValues().
    static double EikTemperature() {
        float pulldownVolts = TheHcrPmc730()._analogValues[_HCR_AIN_TEMP_EIK];
        return _Pt1000Temperature(Ps5vVoltage(), pulldownVolts);
    }

    /// @brief Return the V LNA temperature in deg C at the last call to
    /// updateAnalogValues().
    /// @return the V LNA temperature in deg C at the last call to
    /// updateAnalogValues().
    static double VLnaTemperature() {
        float pulldownVolts = TheHcrPmc730()._analogValues[_HCR_AIN_TEMP_VLNA];
        return _Pt1000Temperature(Ps5vVoltage(), pulldownVolts);
    }

    /// @brief Return the H LNA temperature in deg C at the last call to
    /// updateAnalogValues().
    /// @return the H LNA temperature in deg C at the last call to
    /// updateAnalogValues().
    static double HLnaTemperature() {
        float pulldownVolts = TheHcrPmc730()._analogValues[_HCR_AIN_TEMP_HLNA];
        return _Pt1000Temperature(Ps5vVoltage(), pulldownVolts);
    }

    /// @brief Return the polarization switch temperature in deg C at the last
    /// call to updateAnalogValues().
    /// @return the polarization switch temperature in deg C at the last call to
    /// updateAnalogValues().
    static double PolSwitchTemperature() {
        float pulldownVolts = TheHcrPmc730()._analogValues[_HCR_AIN_TEMP_POL_SWITCH];
        return _Pt1000Temperature(Ps5vVoltage(), pulldownVolts);
    }

    /// @brief Return the RF detector temperature in deg C at the last call to
    /// updateAnalogValues().
    /// @return the RF detector temperature in deg C at the last call to
    /// updateAnalogValues().
    static double RfDetectorTemperature() {
        float pulldownVolts = TheHcrPmc730()._analogValues[_HCR_AIN_TEMP_RF_DETECTOR];
        return _Pt1000Temperature(Ps5vVoltage(), pulldownVolts);
    }

    /// @brief Return the noise source temperature in deg C at the last call to
    /// updateAnalogValues().
    /// @return the noise source temperature in deg C at the last call to
    /// updateAnalogValues().
    static double NoiseSourceTemperature() {
        float pulldownVolts = TheHcrPmc730()._analogValues[_HCR_AIN_TEMP_NOISE_SOURCE];
        return _Pt1000Temperature(Ps5vVoltage(), pulldownVolts);
    }

    /// @brief Return the 28V power supply temperature in deg C at the last call
    /// to updateAnalogValues().
    /// @return the 28V power supply temperature in deg C at the last call to
    /// updateAnalogValues().
    static double Ps28vTemperature() {
        float pulldownVolts = TheHcrPmc730()._analogValues[_HCR_AIN_TEMP_PS_28V];
        return _Pt1000Temperature(Ps5vVoltage(), pulldownVolts);
    }

    /// @brief Return the RDS in duct temperature in deg C at the last call to
    /// updateAnalogValues().
    /// @return the RDS in duct temperature in deg C at the last call to
    /// updateAnalogValues().
    static double RdsInDuctTemperature() {
        float pulldownVolts = TheHcrPmc730()._analogValues[_HCR_AIN_TEMP_RDS_IN_DUCT];
        return _Pt1000Temperature(Ps5vVoltage(), pulldownVolts);
    }

    /// @brief Return the tilt motor temperature in deg C at the last call to
    /// updateAnalogValues().
    /// @return the tilt motor temperature in deg C at the last call to
    /// updateAnalogValues().
    static double TiltMotorTemperature() {
        float pulldownVolts = TheHcrPmc730()._analogValues[_HCR_AIN_TEMP_TILT_MOTOR];
        return _Pt1000Temperature(Ps5vVoltage(), pulldownVolts);
    }

    /// @brief Return the rotation motor temperature in deg C at the last call to
    /// updateAnalogValues().
    /// @return the rotation motor temperature in deg C at the last call to
    /// updateAnalogValues().
    static double RotMotorTemperature() {
        float pulldownVolts = TheHcrPmc730()._analogValues[_HCR_AIN_TEMP_ROT_MOTOR];
        return _Pt1000Temperature(Ps5vVoltage(), pulldownVolts);
    }

    /// @brief Return the tailcone temperature in deg C at the last call to
    /// updateAnalogValues().
    /// @return the tailcone temperature in deg C at the last call to
    /// updateAnalogValues().
    static double TailconeTemperature() {
        float pulldownVolts = TheHcrPmc730()._analogValues[_HCR_AIN_TEMP_TAILCONE];
        return _Pt1000Temperature(Ps5vVoltage(), pulldownVolts);
    }

    /// @brief Return the INS temperature in deg C at the last call to
    /// updateAnalogValues().
    /// @return the INS temperature in deg C at the last call to
    /// updateAnalogValues().
    static double InsTemperature() {
        float pulldownVolts = TheHcrPmc730()._analogValues[_HCR_AIN_TEMP_INS];
        return _Pt1000Temperature(Ps5vVoltage(), pulldownVolts);
    }

    /// @brief Return true iff the 15.5 GHz PLO indicated lock at
    /// the last call to updateAnalogValues().
    /// @return true iff the 15.5 GHz PLO indicated lock at the last
    /// call to updateAnalogValues().
    static bool Locked15_5GHzPLO();

    /// @brief Return true iff the 1250 MHz PLO indicated lock at
    /// the last call to updateAnalogValues().
    /// @return true iff the 1250 MHz PLO indicated lock at the last
    /// call to updateAnalogValues().
    static bool Locked1250MHzPLO();

    /// @brief Return true iff the 125 MHz PLO indicated lock at
    /// the last call to updateAnalogValues().
    /// @return true iff the 125 MHz PLO indicated lock at the last
    /// call to updateAnalogValues().
    static bool Locked125MHzPLO();

    /// @brief Return true iff there was an EMS power error indicated at
    /// the last call to updateAnalogValues().
    /// @return true iff there was an EMS power error indicated at the last
    /// call to updateAnalogValues().
    static bool EmsPowerError();

    /// @brief Return true iff there was an radar power error indicated at
    /// the last call to updateAnalogValues().
    /// @return true iff there was an radar power error indicated at the last
    /// call to updateAnalogValues().
    static bool RadarPowerError();

    /// @brief Return true iff there was a waveguide switch error indicated at
    /// the last call to updateAnalogValues().
    /// @return true iff there was a waveguide switch error indicated at the last
    /// call to updateAnalogValues().
    static bool WaveguideSwitchError();

    /// @brief Return true iff EMS error 1 was indicated at the last call to
    /// updateAnalogValues().
    /// @return true iff EMS error 1 was indicated at the last call to
    /// updateAnalogValues().
    static bool EmsError1();

    /// @brief Return true iff EMS error 2 was indicated at the last call to
    /// updateAnalogValues().
    /// @return true iff EMS error 2 was indicated at the last call to
    /// updateAnalogValues().
    static bool EmsError2();

    /// @brief Return true iff EMS error 3 was indicated at the last call to
    /// updateAnalogValues().
    /// @return true iff EMS error 3 was indicated at the last call to
    /// updateAnalogValues().
    static bool EmsError3();

    /// @brief Return true iff EMS error 4 or 5 was indicated at the last call to
    /// updateAnalogValues().
    /// @return true iff EMS error 4 or 5 was indicated at the last call to
    /// updateAnalogValues().
    static bool EmsError4Or5();

    /// @brief Return true iff EMS error 6 or 7 was indicated at the last call to
    /// updateAnalogValues().
    /// @return true iff EMS error 6 or 7 was indicated at the last call to
    /// updateAnalogValues().
    static bool EmsError6Or7();

    /// @brief Return true iff the Active Pressurization System valve is open
    /// to add pressure to the pod.
    /// @return true iff the Active Pressurization System valve is open
    /// to add pressure to the pod.
    static bool ApsValveOpen() {
        return(TheHcrPmc730().getDioLine(_HCR_DOUT_APS_PRES_ENABLE));
    }

    /// @brief Return true iff we are currently commanding "filament on" via
    /// the RDS filament control line going to the transmitter.
    /// @return true iff we are currently commanding "filament on" via
    /// the RDS filament control line going to the transmitter.
    static bool XmitterFilamentOn() {
        // Invert the sense of the outgoing line, since it is set high to
        // turn the filament off.
        return(! TheHcrPmc730().getDioLine(_HCR_DOUT_TX_FILAMENT_OFF));
    }

    /// @brief Return true iff we are currently commanding "high voltage on" via
    /// the RDS HV control line going to the transmitter.
    /// @return true iff we are currently commanding "high voltage on" via
    /// the RDS HV control line going to the transmitter.
    static bool XmitterHvOn() {
        // Invert the sense of the outgoing line, since it is set high to
        // turn HV off.
        return(! TheHcrPmc730().getDioLine(_HCR_DOUT_TX_HV_OFF));
    }

    /// @brief Return the current 3-bit HMC mode
    /// @return the current HMC operating mode as a value from the
    /// OperationMode enum.
    static HmcMode GetHmcMode() {
        int iMode = TheHcrPmc730().getDioLine(_HCR_DOUT_HMC_OPS_MODE_BIT2) << 2 |
                    TheHcrPmc730().getDioLine(_HCR_DOUT_HMC_OPS_MODE_BIT1) << 1 |
                    TheHcrPmc730().getDioLine(_HCR_DOUT_HMC_OPS_MODE_BIT0) << 0;

        return static_cast<HmcMode>(iMode);
    }

    /// @brief Set the state Active Pressurization System valve.
    /// @param state If true, the valve will be opened, otherwise closed.
    static void SetApsValveOpen(bool state) {
        TheHcrPmc730().setDioLine(_HCR_DOUT_APS_PRES_ENABLE, state ? 1 : 0);
    }

    /// @brief Set the state of the transmitter klystron filament.
    /// @param state If true, the klystron filament will be turned on, otherwise
    /// off.
    static void SetXmitterFilamentOn(bool state) {
        // NOTE: setting _HCR_DOUT_TX_FILAMENT_OFF line high turns OFF the filament!
        TheHcrPmc730().setDioLine(_HCR_DOUT_TX_FILAMENT_OFF, state ? 0 : 1);
    }

    /// @brief Enable or disable transmitter high voltage.
    /// @param state If true, transmitter high voltage will be enabled, otherwise
    /// it will be disabled.
    static void SetXmitterHvOn(bool state) {
        // NOTE: setting _HCR_DOUT_TX_HV_OFF line high turns OFF the high voltage!
        TheHcrPmc730().setDioLine(_HCR_DOUT_TX_HV_OFF, state ? 0 : 1);
    }

    /// @brief Raise the HMC's 'status_ack' line momentarily to reset the state
    /// of its sense-and-hold values.
    static void AckHmcStatus() {
        TheHcrPmc730()._ackHmcStatus();
    }

    /// @brief Set the HMC mode
    static void SetHmcMode(const HmcMode& mode);

    /// @brief Update and return the current count of EMS errors.
    static uint32_t EmsErrorCount() {
        return TheHcrPmc730()._emsErrorCount();
    }

    /// @brief Set correction for pressure vessel pressures. Correct absolute
    /// pressure is the calculated pressure from the A/D voltage + the
    /// correction value.
    /// @param pvPresCorrectionPsi correction value in PSI
    ///
    /// We need this because for unknown reasons, the pressure transducers
    /// appear to be damaged and consistently read lower than actual pressure.
    static void SetPvPresCorrectionPsi(double pvPresCorrectionPsi) {
        TheHcrPmc730()._setPvPresCorrectionPsi(pvPresCorrectionPsi);
    }

private:
    HcrPmc730();
    virtual ~HcrPmc730();

    /// If _doSimulate is true when the singleton is instantiated, it will be
    /// created as a simulated PMC-730.
    static bool _DoSimulate;

    /// Input DIO lines
    typedef enum {
        /// digital in line 0: unused
        _HCR_DIN_UNUSED_0 = 0,
        /// digital in line 1: unused
        _HCR_DIN_UNUSED_1 = 1,
        /// digital in line 2/counter input: EMS error event. Pulses on this
        /// line will be counted using the PMC730's built-in counter.
        _HCR_DIN_EMS_ERROR_EVENT = 2,
        /// digital in line 3: unused
        _HCR_DIN_UNUSED_3 = 3,
        /// digital in line 4: unused
        _HCR_DIN_UNUSED_4 = 4,
        /// digital in line 5: Spare input line from Pentek
        _HCR_DIN_SPARE_PENTEK_1 = 5,
        /// digital in line 6: Spare input line from Pentek
        _HCR_DIN_SPARE_PENTEK_0 = 6,
        /// digital in line 7: HMC signal for mod pulse disabled
        _HCR_DIN_HMC_MODPULSE_DISABLED = 7
    } DinLine_t;

    /// Output DIO lines
    typedef enum {
        /// digital out line 9: open Active Pressurization System valve
        _HCR_DOUT_APS_PRES_ENABLE = 9,
        /// digital out line 10: HMC status acknowledgment signal
        _HCR_DOUT_HMC_STATUS_ACK = 10,
        /// digital out line 11: HMC operation mode bit 2
        _HCR_DOUT_HMC_OPS_MODE_BIT2 = 11,
        /// digital out line 12: Turn off transmitter Klystron filament
        _HCR_DOUT_TX_FILAMENT_OFF = 12,
        /// digital out line 13: HMC operation mode bit 0
        _HCR_DOUT_HMC_OPS_MODE_BIT0 = 13,
        /// digital out line 14: Turn off transmitter Klystron high voltage
        _HCR_DOUT_TX_HV_OFF = 14,
        /// digital out line 15: HMC operation mode bit 1
        _HCR_DOUT_HMC_OPS_MODE_BIT1 = 15,
    } DoutLine_t;

    /// Analog input lines (note that many of these lines are actually used
    /// for TTL level digital input).
    typedef enum {
        /// analog input 0: RF power crystal detector
        _HCR_AIN_CRYSTAL_DET_RF = 0,
        /// analog input 1: aft pressure sensor
        _HCR_AIN_PV_AFT_PRESSURE = 1,
        /// analog input 2: fore pressure sensor
        _HCR_AIN_PV_FORE_PRESSURE = 2,
        /// analog input 3: PLO temperature sensor
        _HCR_AIN_TEMP_PLO = 3,
        /// analog input 4: EIK temperature sensor
        _HCR_AIN_TEMP_EIK = 4,
        /// analog input 5: H LNA temperature sensor
        _HCR_AIN_TEMP_HLNA = 5,
        /// analog input 6: V LNA temperature sensor
        _HCR_AIN_TEMP_VLNA = 6,
        /// analog input 7: polarization switch temperature sensor
        _HCR_AIN_TEMP_POL_SWITCH = 7,
        /// analog input 8: RF detector temperature sensor
        _HCR_AIN_TEMP_RF_DETECTOR = 8,
        /// analog input 9: noise source temperature sensor
        _HCR_AIN_TEMP_NOISE_SOURCE = 9,
        /// analog input 10: 28 V power supply temperature sensor
        _HCR_AIN_TEMP_PS_28V = 10,
        /// analog input 11: RDS in duct temperature sensor
        _HCR_AIN_TEMP_RDS_IN_DUCT = 11,
        /// analog input 12: INS temperature sensor
        _HCR_AIN_TEMP_INS = 12,
        /// analog input 13: tilt motor temperature sensor
        _HCR_AIN_TEMP_TILT_MOTOR = 13,
        /// analog input 14: rotation motor temperature sensor
        _HCR_AIN_TEMP_ROT_MOTOR = 14,
        /// analog input 15: tailcone temperature sensor
        _HCR_AIN_TEMP_TAILCONE = 15,
        /// analog input 16: 5V power supply voltage
        _HCR_AIN_VOLTAGE_PS_5V = 16,
        /// analog input 17: TBD temperature sensor
        _HCR_AIN_TEMP_TBD = 17,
        /// analog input 18: EMS error 1 (TTL-level digital value)
        _HCR_AIN_TTL_EMS_ERROR_1 = 18,
        /// analog input 19: EMS error 2 (TTL-level digital value)
        _HCR_AIN_TTL_EMS_ERROR_2 = 19,
        /// analog input 20: EMS error 3 (TTL-level digital value)
        _HCR_AIN_TTL_EMS_ERROR_3 = 20,
        /// analog input 21: EMS error 4 or 5 (TTL-level digital value)
        _HCR_AIN_TTL_EMS_ERROR_4OR5 = 21,
        /// analog input 22: EMS error 6 or 7 (TTL-level digital value)
        _HCR_AIN_TTL_EMS_ERROR_6OR7 = 22,
        /// analog input 23: EMS power error (TTL-level digital value)
        _HCR_AIN_TTL_EMS_PWR_ERROR = 23,
        /// analog input 24: radar power error (TTL-level digital value)
        _HCR_AIN_TTL_RADAR_PWR_ERROR = 24,
        /// analog input 25: 125 MHz oscillator locked (TTL-level digital value)
        _HCR_AIN_TTL_125_MHZ_LOCKED = 25,
        /// analog input 26: 1250 MHz oscillator locked (TTL-level digital value)
        _HCR_AIN_TTL_1250_MHZ_LOCKED = 26,
        /// analog input 27: 15.5 GHz oscillator locked (TTL-level digital value)
        _HCR_AIN_TTL_15_5_GHZ_LOCKED = 27,
        /// analog input 28: waveguide switch error (TTL-level digital value)
        _HCR_AIN_TTL_WG_SWITCH_ERROR = 28,
        /// analog input 29: spare connected to HMC FPGA
        _HCR_AIN_HMC_SPARE_0 = 29,
        /// analog input 30: Active Pressurization System high side pressure (2000 PSI transducer)
        _HCR_AIN_APS_HIGH_SIDE_PRESSURE = 30,
        /// analog input 31: Active Pressurization System low side pressure (50 PSI transducer)
        _HCR_AIN_APS_LOW_SIDE_PRESSURE = 31
    } AinLine_t;

    /// @brief Set the selected bit in the source byte and return the result.
    /// @param src the source byte
    /// @param bitnum the number of the bit to set; 0 for least significant bit
    /// @return a byte copied from src, but with the selected bit set
    static uint8_t
    _TurnBitOn(uint8_t src, unsigned int bitnum) {
        uint8_t mask = (1 << bitnum);
        return(src | mask);
    }

    /// @brief Unset the selected bit in the source byte and return the result.
    /// @param src the source byte
    /// @param bitnum the number of the bit to unset; 0 for least significant bit
    /// @return a byte copied from src, but with the selected bit unset
    static uint8_t
    _TurnBitOff(uint8_t src, unsigned int bitnum) {
        uint8_t mask = (1 << bitnum);
        return(src & ~mask);
    }

    /// @brief Read and store voltage values from all 32 analog input channels.
    /// These stored values will be used will be used by accessor methods which
    /// refer to values derived from the analog input channels: detectedRfPower(),
    /// ploTemperature(), locked15_5GHzPLO(), and many others.
    ///
    /// Documentation for accessor methods affected by this method will mention
    /// their dependency on updateAnalogValues().
    void _updateAnalogValues() {
        _analogValues = readAnalogChannels(0, 31);
    }

    /// @brief Convert the voltage from the selected Analog In channel to a
    /// digital value of 0 or 1, using TTL signal levels: voltage less than
    /// 0.8 V => 0 and voltage greater than 2.0 V => 1. The channel's voltage
    /// stored at the last call to updateAnalogValues() is used.
    /// A BadTtlVoltage exception is thrown for voltages outside the legal
    /// TTL signal levels.
    /// @param channel The Analog In channel to interpret as a TTL binary
    /// signal. Legal values are 0-31.
    /// @return 0 if the channel's voltage is less than 0.8 V and 1 if the
    /// channel's voltage is greter than 2.0 V.
    /// @throws BadTtlVoltage if the incoming voltage is in range (0.8, 2.0).
    int _ttlBinaryForChannel(int channel);

    /// @brief Calculate temperature of a Pt1000 RTD temperature sensor connected
    /// in series with a 1 kOhm pulldown resistor across a known voltage.
    /// @param psVolts the voltage of the power supply feeding the divider, V
    /// @param pulldownVolts the voltage across the pulldown resistor, V
    /// @return the temperature of the RTD, deg C
    static double _Pt1000Temperature(double psVolts, double pulldownVolts);

    /// @brief Calculate the pressure based on the voltage from an
    /// All Sensors 15PSI-A-4V-MIL sensor.
    /// @param sensorVolts the potential across the sensor, V
    /// @return the pressure at the 15PSI-A-4V-MIL sensor
    static double _15PSI_A_4V_Pres(double sensorVolts);

    /// @brief Calculate the pressure based on the voltage from an
    /// All Sensors 30PSI-A-4V-MIL sensor.
    /// @param sensorVolts the potential across the sensor, V
    /// @return the pressure at the 30PSI-A-4V-MIL sensor
    static double _30PSI_A_4V_Pres(double sensorVolts);

    /// @brief Convert the given voltage to measured RF power from
    /// Mi-Wave 950W RF detector.
    /// @param voltage the voltage measured at the Mi-Wave 950W detector
    /// @return the RF power measured at the Mi-Wave 950W detector, dBm
    static double _MiWv950WPower(double voltage);

    /// @brief Convert the given voltage to measured RF power from
    /// Millitech DET-10 RF detector.
    /// @param voltage the voltage measured at the Millitech DET-10 detector
    /// @return the RF power measured at the Millitech DET-10 detector, dBm
    static double _MillitechDET10Power(double voltage);

    /// @brief Initialize the PMC730 for event counting using DIO channel 2.
    void _initEventCounter();

    /// @brief Read the event counter register from the PMC730, which is a count
    /// of radar pulses for which one or more EMS errors was recorded.
    /// @return the count of pulses with EMS errors.
    uint32_t _emsErrorCount() const;

    /// @brief Raise the HMC's 'status_ack' line momentarily to reset the state of
    /// its sense-and-hold values.
    void _ackHmcStatus();

    /// @brief Set correction for pressure vessel pressures. Correct absolute
    /// pressure is the calculated pressure from the A/D voltage + the
    /// correction value.
    /// @param correctionPsi correction value in PSI
    ///
    /// We need this because for unknown reasons, the pressure transducers
    /// appear to be damaged and consistently read lower than actual pressure.
    void _setPvPresCorrectionPsi(double pvPresCorrectionPsi);

    /// @brief Analog voltage values from all 32 Analog In channels, as of the
    /// last call to updateAnalogValues().
    std::vector<float> _analogValues;

    /// @brief Correction applied for fore and aft pressure vessel pressures,
    /// in hPa
    ///
    /// The PvForePressure() and PvAftPressure methods will return the
    /// calculated pressure from the associated A/D voltage + the
    /// correction value.
    ///
    /// We need this because for unknown reasons, the pressure transducers
    /// appear to be damaged and consistently read lower than actual pressure.
    double _pvPresCorrection;

    /// @brief The singleton instance of HcrPmc730.
    static HcrPmc730 * _TheHcrPmc730;
};

#endif /* HCRPMC730_H_ */
