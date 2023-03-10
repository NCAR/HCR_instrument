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
 * HcrPmc730Status.h
 *
 *  Created on: Aug 12, 2013
 *      Author: burghart
 */

#ifndef HCRPMC730STATUS_H_
#define HCRPMC730STATUS_H_

#include "HcrPmc730.h"

#include <deque>
#include <exception>
#include <string>
#include <numeric>
#include <stdint.h>
#include <xmlrpc-c/base.hpp>
#include <boost/serialization/nvp.hpp>
#include <boost/serialization/version.hpp>

/// @brief Class to hold status of the singleton HcrPmc730 instance
class HcrPmc730Status {
public:
    /// @brief Default constructor using all zero or invalid values
    HcrPmc730Status();

    virtual ~HcrPmc730Status();

    /// @brief Static method which returns current status
    static HcrPmc730Status CurrentStatus();

    /// @brief Return the transmit pulse power from the QuinStar power detector, dBm
    /// @return the transmit pulse power from the QuinStar power detector, dBm
    double detectedRfPower() const { return(_detectedRfPower); }

    /// @brief Return the pressure measured at the fore end of the pressure vessel, hPa
    /// @return the pressure measured at the fore end of the pressure vessel, hPa
    double pvForePressure() const { return(_pvForePressure); }

    /// @brief Return the pressure measured at the aft end of the pressure vessel, hPa
    /// @return the pressure measured at the aft end of the pressure vessel, hPa
    double pvAftPressure() const { return(_pvAftPressure); }

    /// @brief Return the pressure on the low-pressure side of the Active
    /// Pressurization System regulator, hPa
    /// @return the pressure on the low-pressure side of the Active
    /// Pressurization System regulator, hPa
    double apsLowSidePressure() const { return(_apsLowSidePressure); }

    /// @brief Return the pressure on the high-pressure side of the Active
    /// Pressurization System regulator, hPa
    /// @return the pressure on the high-pressure side of the Active
    /// Pressurization System regulator, hPa
    double apsHighSidePressure() const { return(_apsHighSidePressure); }

    /// @brief Return true iff Active Pressurization System valve is currently
    /// open.
    /// @return true iff Active Pressurization System valve is currently open.
    bool apsValveOpen() const { return(_apsValveOpen); }

    /// @brief Return the temperature of the 93 GHz phase-locked oscillator (PLO), deg C
    /// @return the temperature of the 93 GHz phase-locked oscillator (PLO), deg C
    double ploTemp() const { return(_ploTemp); }

    /// @brief Return the temperature of the Extended Interaction Klystron (EIK), deg C
    /// @return the temperature of the Extended Interaction Klystron (EIK), deg C
    double eikTemp() const { return(_eikTemp); }

    /// @brief Return the temperature of the vertical channel LNA, deg C
    /// @return the temperature of the vertical channel LNA, deg C
    double vLnaTemp() const { return(_vLnaTemp); }

    /// @brief Return the temperature of the horizontal channel LNA, deg C
    /// @return the temperature of the horizontal channel LNA, deg C
    double hLnaTemp() const { return(_hLnaTemp); }

    /// @brief Return the temperature of the polarization switch, deg C
    /// @return the temperature of the polarization switch, deg C
    double polarizationSwitchTemp() const { return(_polarizationSwitchTemp); }

    /// @brief Return the temperature of the Mi-Wave 950W RF detector, deg C
    /// @return the temperature of the Mi-Wave 950W RF detector, deg C
    double rfDetectorTemp() const { return(_rfDetectorTemp); }

    /// @brief Return the temperature of the noise source, deg C
    /// @return the temperature of the noise source, deg C
    double noiseSourceTemp() const { return(_noiseSourceTemp); }

    /// @brief Return the temperature of 28V power supply, deg C
    /// @return the temperature of the 28V power supply, deg C
    double ps28VTemp() const { return(_ps28VTemp); }

    /// @brief Return the temperature at the input air duct for the remote data
    /// system (RDS), deg C
    /// @return the temperature at the input air duct for the remote data system
    /// (RDS), deg C
    double rdsInDuctTemp() const { return(_rdsInDuctTemp); }

    /// @brief Return the temperature of the reflector rotation motor, deg C
    /// @return the temperature of the reflector rotation motor, deg C
    double rotationMotorTemp() const { return(_rotationMotorTemp); }

    /// @brief Return the temperature of the reflector tilt motor, deg C
    /// @return the temperature of the reflector tilt motor, deg C
    double tiltMotorTemp() const { return(_tiltMotorTemp); }

    /// @brief Return the temperature of the inertial navigation system, deg C
    /// @return the temperature of the inertial navigation system, deg C
    double insTemp() const { return(_insTemp); }

    /// @brief Return the ambient temperature in the tailcone, deg C
    /// @return the ambient temperature in the tailcone, deg C
    double tailconeTemp() const { return(_tailconeTemp); }

    /// @brief Return the measured voltage from the 5V power supply.
    /// @return the measured voltage from the 5V power supply, V
    double psVoltage() const { return(_psVoltage); }

    /// @brief Return true iff 15.5 GHz PLO is phase locked
    /// @return true iff 15.5 GHz PLO is phase locked
    bool locked15_5GHzPLO() const { return(_locked15_5GHzPLO); }

    /// @brief Return true iff 1250 MHz PLO is phase locked
    /// @return true iff 1250 MHz PLO is phase locked
    bool locked1250MHzPLO() const { return(_locked1250MHzPLO); }

    /// @brief Return true iff 125 MHz PLO is phase locked
    /// @return true iff 125 MHz PLO is phase locked
    bool locked125MHzPLO() const { return(_locked125MHzPLO); }

    /// @brief Return true iff modulation pulses are being stopped at the HMC and not
    /// passed through to the transmitter
    /// @return true iff modulation pulses are being stopped at the HMC and not
    /// passed through to the transmitter
    bool modPulseDisabled() const { return(_modPulseDisabled); }

    /// @brief Return true iff we are currently commanding "filament on" via
    /// the RDS filament control line going to the transmitter.
    /// @return true iff we are currently commanding "filament on" via
    /// the RDS filament control line going to the transmitter.
    bool rdsXmitterFilamentOn() const { return(_rdsXmitterFilamentOn); }

    /// @brief Return true iff we are currently commanding "high voltage on" via
    /// the RDS HV control line going to the transmitter.
    /// @return true iff we are currently commanding "high voltage on" via
    /// the RDS HV control line going to the transmitter.
    bool rdsXmitterHvOn() const { return(_rdsXmitterHvOn); }

    /// @brief Return true iff radar power error is being reported.
    /// @return true iff iff radar power error is being reported.
    bool radarPowerError() const { return(_radarPowerError); }

    /// @brief Return the count of pulses with EMS error events.
    /// @return the count of pulses with EMS error events.
    uint32_t emsErrorCount() const { return(_emsErrorCount); }

    /// @brief Return true iff there is one or more EMS error of type 1 in
    /// the current error count.
    /// @return true iff there is one or more EMS error of type 1 in
    /// the current error count.
    bool emsError1() const { return(_emsError1); }

    /// @brief Return true iff there is one or more EMS error of type 2 in
    /// the current error count.
    /// @return true iff there is one or more EMS error of type 2 in
    /// the current error count.
    bool emsError2() const { return(_emsError2); }

    /// @brief Return true iff there is one or more EMS error of type 3 in
    /// the current error count.
    /// @return true iff there is one or more EMS error of type 3 in
    /// the current error count.
    bool emsError3() const { return(_emsError3); }

    /// @brief Return true iff there is one or more EMS error of type 4 or 5 in
    /// the current error count.
    /// @return true iff there is one or more EMS error of type 4 or 5 in
    /// the current error count.
    bool emsError4Or5() const { return(_emsError4Or5); }

    /// @brief Return true iff there is one or more EMS error of type 6 or 7 in
    /// the current error count.
    /// @return true iff there is one or more EMS error of type 6 or 7 in
    /// the current error count.
    bool emsError6Or7() const { return(_emsError6Or7); }

    /// @brief Return true iff EMS power error is being reported.
    /// @return true iff iff EMS power error is being reported.
    bool emsPowerError() const { return(_emsPowerError); }

    /// @brief Return true iff the HMC is reporting polarization switching error
    /// @return true iff the HMC is reporting polarization switching error
    bool waveguideSwitchError() const { return(_waveguideSwitchError); }

    /// @brief Return the HMC operating mode.
    /// @see OperationMode for a description of the values.
    OperationMode operationMode() const { return(_operationMode); }

    /// @brief cast to xmlrpc_c::value
    operator xmlrpc_c::value() const;

private:
    /// @brief Simple class implementing a list of temperatures with a maximum
    /// size. When a temperature is added which causes the maximum size to be
    /// exceeded, the oldest item in the list will be removed to bring the size
    /// back to the maximum.
    class TemperatureList {
    public:
        /// @brief Constructor.
        TemperatureList() : _items() {}

        /// @brief Add a temperature to the list.
        /// @param val the temperature to add to the list
        void addTemperature(double val) {
            _items.push_front(val);
            if (_items.size() > _MAX_SIZE) {
                _items.pop_back();
            }
        }

        /// @brief Return the mean of the values in the list, or -99.9 if
        /// the list is empty.
        /// @return the mean of the values in the list, or -99.9 if
        /// the list is empty.
        double mean() const {
            if (_items.empty())
                return(-99.9);
            double sum = std::accumulate(_items.begin(), _items.end(), 0.0);
            return(sum / _items.size());
        }

    private:
        /// Maximum number of values kept in the temperature list.
        static const unsigned int _MAX_SIZE = 10;
        std::deque<double> _items;
    };

    /// @brief Populate with current values for all of our sensor data supplied
    /// via the PMC730 multi-IO card.
    void _getMultiIoValues();

    friend class boost::serialization::access;

    /// @brief Serialize our members to a boost save (output) archive or
    /// populate our members from a boost load (input) archive.
    /// @param ar the archive to load from or save to.
    /// @param version the version
    template<class Archive>
    void serialize(Archive & ar, const unsigned int version) {
        using boost::serialization::make_nvp;
        // Version 0 (see BOOST_CLASS_VERSION macro below for latest version)
        if (version >= 0) {
            // Map named entries to our member variables using serialization's
            // name/value pairs (nvp).
            ar & BOOST_SERIALIZATION_NVP(_apsLowSidePressure);
            ar & BOOST_SERIALIZATION_NVP(_apsHighSidePressure);
            ar & BOOST_SERIALIZATION_NVP(_apsValveOpen);
            ar & BOOST_SERIALIZATION_NVP(_detectedRfPower);
            ar & BOOST_SERIALIZATION_NVP(_eikTemp);
            ar & BOOST_SERIALIZATION_NVP(_emsError1);
            ar & BOOST_SERIALIZATION_NVP(_emsError2);
            ar & BOOST_SERIALIZATION_NVP(_emsError3);
            ar & BOOST_SERIALIZATION_NVP(_emsError4Or5);
            ar & BOOST_SERIALIZATION_NVP(_emsError6Or7);
            ar & BOOST_SERIALIZATION_NVP(_emsErrorCount);
            ar & BOOST_SERIALIZATION_NVP(_emsPowerError);
            ar & BOOST_SERIALIZATION_NVP(_hLnaTemp);
            ar & BOOST_SERIALIZATION_NVP(_operationMode);
            ar & BOOST_SERIALIZATION_NVP(_insTemp);
            ar & BOOST_SERIALIZATION_NVP(_locked1250MHzPLO);
            ar & BOOST_SERIALIZATION_NVP(_locked125MHzPLO);
            ar & BOOST_SERIALIZATION_NVP(_locked15_5GHzPLO);
            ar & BOOST_SERIALIZATION_NVP(_modPulseDisabled);
            ar & BOOST_SERIALIZATION_NVP(_noiseSourceTemp);
            ar & BOOST_SERIALIZATION_NVP(_ploTemp);
            ar & BOOST_SERIALIZATION_NVP(_polarizationSwitchTemp);
            ar & BOOST_SERIALIZATION_NVP(_ps28VTemp);
            ar & BOOST_SERIALIZATION_NVP(_psVoltage);
            ar & BOOST_SERIALIZATION_NVP(_pvAftPressure);
            ar & BOOST_SERIALIZATION_NVP(_pvForePressure);
            ar & BOOST_SERIALIZATION_NVP(_radarPowerError);
            ar & BOOST_SERIALIZATION_NVP(_rdsInDuctTemp);
            ar & BOOST_SERIALIZATION_NVP(_rdsXmitterFilamentOn);
            ar & BOOST_SERIALIZATION_NVP(_rdsXmitterHvOn);
            ar & BOOST_SERIALIZATION_NVP(_rfDetectorTemp);
            ar & BOOST_SERIALIZATION_NVP(_rotationMotorTemp);
            ar & BOOST_SERIALIZATION_NVP(_tailconeTemp);
            ar & BOOST_SERIALIZATION_NVP(_tiltMotorTemp);
            ar & BOOST_SERIALIZATION_NVP(_vLnaTemp);
            ar & BOOST_SERIALIZATION_NVP(_waveguideSwitchError);
        }
        if (version >= 1) {
            // Version 1 stuff will go here...
        }
    }

    // Keep static lists of temperatures sampled from the multi-IO card so that
    // we can time-average to reduce noise in the sampling. Values are added to
    // the lists on each call to the constructor which samples new values, i.e.,
    // HcrPmc730Status(false).

    /// 93 GHz PLO temperature list
    static TemperatureList _PloTemps;
    /// Transmitter EIK temperature list
    static TemperatureList _EikTemps;
    /// vertical channel LNA temperature list
    static TemperatureList _VLnaTemps;
    /// horizontal channel LNA temperature list
    static TemperatureList _HLnaTemps;
    /// polarization switch temperature list
    static TemperatureList _PolarizationSwitchTemps;
    /// Mi-Wave 950W RF detector temperature list
    static TemperatureList _RfDetectorTemps;
    /// noise source temperature list
    static TemperatureList _NoiseSourceTemps;
    /// 28V power supply temperature list
    static TemperatureList _Ps28VTemps;
    /// remote data system (RDS) intake duct temperature list
    static TemperatureList _RdsInDuctTemps;
    /// rotation motor temperature list
    static TemperatureList _RotationMotorTemps;
    /// tilt motor temperature list
    static TemperatureList _TiltMotorTemps;
    /// INS temperature list
    static TemperatureList _InsTemps;
    /// tailcone temperature list
    static TemperatureList _TailconeTemps;

    /// 93 GHz PLO time-averaged temperature
    double _ploTemp;

    /// Transmitter EIK time-averaged temperature
    double _eikTemp;

    /// vertical channel LNA time-averaged temperature
    double _vLnaTemp;

    /// horizontal channel LNA time-averaged temperature
    double _hLnaTemp;

    /// polarization switch time-averaged temperature
    double _polarizationSwitchTemp;

    /// Mi-Wave 950W RF detector time-averaged temperature
    double _rfDetectorTemp;

    /// noise source time-averaged temperature
    double _noiseSourceTemp;

    /// 28V power supply time-averaged temperature
    double _ps28VTemp;

    /// remote data system (RDS) intake duct time-averaged temperature
    double _rdsInDuctTemp;

    /// rotation motor time-averaged temperature
    double _rotationMotorTemp;

    /// tilt motor time-averaged temperature
    double _tiltMotorTemp;

    /// INS time-averaged temperature
    double _insTemp;

    /// tailcone time-averaged temperature
    double _tailconeTemp;

    /// detected RF power
    double _detectedRfPower;

    /// pressure vessel aft pressure
    double _pvAftPressure;

    /// pressure vessel fore pressure
    double _pvForePressure;

    /// Active Pressurization System regulator low side pressure, PSI
    double _apsLowSidePressure;

    /// Active Pressurization System regulator high side pressure, PSI
    double _apsHighSidePressure;

    /// measured voltage from 5V power supply
    double _psVoltage;

    /// 15.5 GHz oscillator phase locked?
    bool _locked15_5GHzPLO;

    /// 1250 MHz oscillator phase locked?
    bool _locked1250MHzPLO;

    /// 125 MHz oscillator phase locked?
    bool _locked125MHzPLO;

    /// Is modulator pulse passthrough disabled at the HMC?
    bool _modPulseDisabled;

    /// Is the Active Pressurization System valve open?
    bool _apsValveOpen;

    /// Is "filament on" being commanded via the RDS control line to the transmitter?
    bool _rdsXmitterFilamentOn;

    /// Is "high voltage on" being commanded via the RDS control line to the transmitter?
    bool _rdsXmitterHvOn;

    /// Is radar power error being reported?
    bool _radarPowerError;

    /// Is EMS power error being reported?
    bool _emsPowerError;

    /// Is waveguide switch error being reported?
    bool _waveguideSwitchError;

    /// EMS error count
    uint32_t _emsErrorCount;

    /// Is there one or more EMS errors of type 1 in the error count?
    bool _emsError1;

    /// Is there one or more EMS errors of type 2 in the error count?
    bool _emsError2;

    /// Is there one or more EMS errors of type 3 in the error count?
    bool _emsError3;

    /// Is there one or more EMS errors of type 4 or 5 in the error count?
    bool _emsError4Or5;

    /// Is there one or more EMS errors of type 6 or 7 in the error count?
    bool _emsError6Or7;

    /// HMC operating mode
    OperationMode _operationMode;
};

// Increment this class version number when member variables are changed.
BOOST_CLASS_VERSION(HcrPmc730Status, 0)

#endif /* HCRPMC730STATUS_H_ */
