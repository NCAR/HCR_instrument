/*
 * DrxStatus.h
 *
 *  Created on: Sep 6, 2012
 *      Author: burghart
 */

#ifndef DRXSTATUS_H_
#define DRXSTATUS_H_

#include <exception>
#include <string>
#include <numeric>
#include <stdint.h>
#include <XmlRpc.h>
#include <p7142.h>
#include <CmigitsSharedMemory.h>
#include <boost/serialization/nvp.hpp>

using namespace XmlRpc;

/// @brief Class to represent HCR digital receiver/remote data system status.
class DrxStatus {
public:
    /// @brief This is a subclass of std::exception thrown when there is a
    /// problem in DrxStatus construction.
    ///
    /// Use what() to get a description of the thrown exception.
    class ConstructError : public std::exception {
    public:
        ConstructError(std::string msg) throw() : std::exception(), _msg(msg) {}
        virtual ~ConstructError() throw() {}
        /// @brief Returns a null terminated character sequence containing a
        /// generic description of the exception.
        /// @return a null terminated character sequence containing a
        /// description of the exception.
        virtual const char* what() const throw() { return(_msg.c_str()); }
    private:
        std::string _msg;
    };

    /// @brief Default constructor. Boolean fields are set to false, integer
    /// fields are set to 0, and double fields are set to -99.9.
    DrxStatus();

    /// @brief Construct a DrxStatus using data from the given 
    /// Pentek::p7142 device, the singleton HcrPmc730::theHcrPmc730(), and
    /// from CmigitsSharedMemory.
    /// @param pentek the Pentek::p7142 device from which to get status
    DrxStatus(const Pentek::p7142 & pentek);

    /// @brief Construct from an XmlRpcValue dictionary as returned by a call
    /// to the DrxStatus::toXmlRpcValue() method.
    /// @param statusDict an XmlRpcValue dictionary as returned by call to the
    /// DrxStatus::toXmlRpcValue() method.
    /// @throws ContructError if there is a problem unpacking the given
    /// XmlRpcValue into a DrxStatus.
    DrxStatus(XmlRpcValue & statusDict) throw(ConstructError);

    virtual ~DrxStatus();

    /// @brief Return an external representation of the object's state as
    /// an XmlRpcValue dictionary.
    ///
    /// The returned value can be used on the other side of an XML-RPC
    /// connection to create an identical object via the
    /// XmitStatus(const XmlRpcValue &) constructor.
    /// @return an external representation of the object's state as
    /// an XmlRpcValue dictionary.
    XmlRpcValue toXmlRpcValue() const;

    /// @brief Return a std::string representation of this object rendered as
    /// XML via the TaXml class, using the given indentation depth.
    /// @param depth the indentation depth to use in rendering the XML
    /// @return a std::string representation of this object rendered as
    /// XML via the TaXml class, using the given indentation depth.
    std::string toTaXmlString(int depth) const;

    /**
     * @brief Return the transmit pulse power from the QuinStar power detector, dBm
     * @return the transmit pulse power from the QuinStar power detector, dBm
     */
    double detectedRfPower() const { return(_detectedRfPower); }
    /**
     * @brief Return the pressure measured at the fore end of the pressure vessel, hPa
     * @return the pressure measured at the fore end of the pressure vessel, hPa
     */
    double pvForePressure() const { return(_pvForePressure); }
    /**
     * @brief Return the pressure measured at the aft end of the pressure vessel, hPa
     * @return the pressure measured at the aft end of the pressure vessel, hPa
     */
    double pvAftPressure() const { return(_pvAftPressure); }
    /**
     * @brief Return the temperature of the 93 GHz phase-locked oscillator (PLO), deg C
     * @return the temperature of the 93 GHz phase-locked oscillator (PLO), deg C
     */
    double ploTemp() const { return(_ploTemp); }
    /**
     * @brief Return the temperature of the Extended Interaction Klystron (EIK), deg C
     * @return the temperature of the Extended Interaction Klystron (EIK), deg C
     */
    double eikTemp() const { return(_eikTemp); }
    /**
     * @brief Return the temperature of the vertical channel LNA, deg C
     * @return the temperature of the vertical channel LNA, deg C
     */
    double vLnaTemp() const { return(_vLnaTemp); }
    /**
     * @brief Return the temperature of the horizontal channel LNA, deg C
     * @return the temperature of the horizontal channel LNA, deg C
     */
    double hLnaTemp() const { return(_hLnaTemp); }
    /**
     * @brief Return the temperature of the polarization switch, deg C
     * @return the temperature of the polarization switch, deg C
     */
    double polarizationSwitchTemp() const { return(_polarizationSwitchTemp); }
    /**
     * @brief Return the temperature of the Mi-Wave 950W RF detector, deg C
     * @return the temperature of the Mi-Wave 950W RF detector, deg C
     */
    double rfDetectorTemp() const { return(_rfDetectorTemp); }
    /**
     * @brief Return the temperature of the noise source, deg C
     * @return the temperature of the noise source, deg C
     */
    double noiseSourceTemp() const { return(_noiseSourceTemp); }
    /**
     * @brief Return the temperature of 28V power supply, deg C
     * @return the temperature of the 28V power supply, deg C
     */
    double ps28VTemp() const { return(_ps28VTemp); }
    /**
     * @brief Return the temperature at the input air duct for the remote data
     * system (RDS), deg C
     * @return the temperature at the input air duct for the remote data system
     * (RDS), deg C
     */
    double rdsInDuctTemp() const { return(_rdsInDuctTemp); }
    /**
     * @brief Return the temperature of the reflector rotation motor, deg C
     * @return the temperature of the reflector rotation motor, deg C
     */
    double rotationMotorTemp() const { return(_rotationMotorTemp); }
    /**
     * @brief Return the temperature of the reflector tilt motor, deg C
     * @return the temperature of the reflector tilt motor, deg C
     */
    double tiltMotorTemp() const { return(_tiltMotorTemp); }
    /**
     * @brief Return the temperature of the C-MIGITS inertial navigation system, deg C
     * @return the temperature of the C-MIGITS inertial navigation system, deg C
     */
    double cmigitsTemp() const { return(_cmigitsTemp); }
    /**
     * @brief Return the ambient temperature in the tailcone, deg C
     * @return the ambient temperature in the tailcone, deg C
     */
    double tailconeTemp() const { return(_tailconeTemp); }
    /**
     * @brief Return the measured voltage from the 5V power supply.
     * @return the measured voltage from the 5V power supply, V
     */
    double psVoltage() const { return(_psVoltage); }
    /**
     * @brief Return true iff waveguide switch is in the "noise source" position
     * @return true iff waveguide switch is in the "noise source" position
     */
    bool noiseSourceSelected() const { return(_noiseSourceSelected); }
    /**
     * @brief Return true iff waveguide switch is in "termination" position
     * @return true iff waveguide switch is in "termination" position
     */
    bool terminationSelected() const { return(_terminationSelected); }
    /**
     * @brief Return true iff 15.5 GHz PLO is phase locked
     * @return true iff 15.5 GHz PLO is phase locked
     */
    bool locked15_5GHzPLO() const { return(_locked15_5GHzPLO); }
    /**
     * @brief Return true iff 1250 MHz PLO is phase locked
     * @return true iff 1250 MHz PLO is phase locked
     */
    bool locked1250MHzPLO() const { return(_locked1250MHzPLO); }
    /**
     * @brief Return true iff 125 MHz PLO is phase locked
     * @return true iff 125 MHz PLO is phase locked
     */
    bool locked125MHzPLO() const { return(_locked125MHzPLO); }
    /**
     * @brief Return true iff modulation pulses are being stopped at the HMC and not
     * passed through to the transmitter
     * @return true iff modulation pulses are being stopped at the HMC and not
     * passed through to the transmitter
     */
    bool modPulseDisabled() const { return(_modPulseDisabled); }
    /**
     * @brief Return true iff we are currently commanding "filament on" via
     * the RDS filament control line going to the transmitter.
     * @return true iff we are currently commanding "filament on" via
     * the RDS filament control line going to the transmitter.
     */
    bool rdsXmitterFilamentOn() const { return(_rdsXmitterFilamentOn); }
    /**
     * @brief Return true iff we are currently commanding "high voltage on" via
     * the RDS HV control line going to the transmitter.
     * @return true iff we are currently commanding "high voltage on" via
     * the RDS HV control line going to the transmitter.
     */
    bool rdsXmitterHvOn() const { return(_rdsXmitterHvOn); }

    /**
     * @brief Return true iff radar power error is being reported.
     * @return true iff iff radar power error is being reported.
     */
    bool radarPowerError() const { return(_radarPowerError); }

    /**
     * @brief Return the count of EMC error events.
     * @return the count of EMC error events.
     */
    uint32_t emsErrorCount() const { return(_emsErrorCount); }
    
    /**
     * @brief Return true iff there is one or more EMS error of type 1 in
     * the current error count.
     * @return true iff there is one or more EMS error of type 1 in
     * the current error count.
     */
    bool emsError1() const { return(_emsError1); }

    /**
     * @brief Return true iff there is one or more EMS error of type 2 in
     * the current error count.
     * @return true iff there is one or more EMS error of type 2 in
     * the current error count.
     */
    bool emsError2() const { return(_emsError2); }

    /**
     * @brief Return true iff there is one or more EMS error of type 3 in
     * the current error count.
     * @return true iff there is one or more EMS error of type 3 in
     * the current error count.
     */
    bool emsError3() const { return(_emsError3); }

    /**
     * @brief Return true iff there is one or more EMS error of type 4 or 5 in
     * the current error count.
     * @return true iff there is one or more EMS error of type 4 or 5 in
     * the current error count.
     */
    bool emsError4Or5() const { return(_emsError4Or5); }

    /**
     * @brief Return true iff there is one or more EMS error of type 6 or 7 in
     * the current error count.
     * @return true iff there is one or more EMS error of type 6 or 7 in
     * the current error count.
     */
    bool emsError6Or7() const { return(_emsError6Or7); }

    /**
     * @brief Return true iff EMS power error is being reported.
     * @return true iff iff EMS power error is being reported.
     */
    bool emsPowerError() const { return(_emsPowerError); }

    /**
     * @brief Return true iff the HMC is reporting polarization switching error
     * @return true iff the HMC is reporting polarization switching error
     */
    bool waveguideSwitchError() const { return(_waveguideSwitchError); }

    /**
     * @brief Return the signal processing FPGA temperature from the Pentek
     * card, deg C
     * @return the signal processing FPGA temperature from the Pentek
     * card, deg C
     */
    double pentekFpgaTemp() const { return(_pentekFpgaTemp); }
    
    /**
     * @brief Return the PCB temperature from the Pentek card, deg C
     * @return the PCB temperature from the Pentek card, deg C
     */
    double pentekBoardTemp() const { return(_pentekBoardTemp); }
    
    /**
     * @brief Return the HMC operating mode number: 0-3
     * 0 - normal operation, 1 - noise source cal, 2 - corner reflector cal,
     * 3 - integration and testing
     * @return the HMC operating mode number: 0-3
     */
    int hmcMode() const { return(_hmcMode); }
    
    /**
     * @brief Return the latest status information from the C-MIGITS
     * (information from the C-MIGITS 3500 message).
     * @param[out] dataTime time of the status data, seconds since 1970-01-01
     * 00:00:00 UTC
     * @param[out] currentMode current C-MIGITS mode
     * @param[out] insAvailable true iff INS data are available
     * @param[out] gpsAvailable true iff GPS time is good and 4 or more 
     * satellites are seen
     * @param[out] doingCoarseAlignment true iff C-MIGITS is in "Coarse
     * Alignment" submode
     * @param[out] nSats number of GPS satellites tracked
     * @param[out] positionFOM position figure-of-merit, values 1-9
     * @parma[out] velocityFOM velocity figure-of-merit, values 1-9
     * @param[out] headingFOM heading figure-of-merit, values 1-9
     * @param[out] timeFOM time figure-of-merit, values 1-9
     * @param[out] expectedHPosError expected horizontal position error, m
     * @param[out] expectedVPosError expected vertical position error, m
     * @param[out] expectedVelocityError expected velocity error, m/s
     */
    void cmigitsStatus(double & dataTime, uint16_t & currentMode,
              bool & insAvailable, bool & gpsAvailable, 
              bool & doingCoarseAlignment, uint16_t & nSats,
              uint16_t & positionFOM, uint16_t & velocityFOM,
              uint16_t & headingFOM, uint16_t & timeFOM,
              float & expectedHPosError, float & expectedVPosError,
              float & expectedVelocityError) const {
        dataTime = _cmigitsStatusTime;
        currentMode = _cmigitsCurrentMode;
        insAvailable = _cmigitsInsAvailable;
        gpsAvailable = _cmigitsGpsAvailable;
        doingCoarseAlignment = _cmigitsDoingCoarseAlignment;
        nSats = _cmigitsNSats;
        positionFOM = _cmigitsPositionFOM;
        velocityFOM = _cmigitsVelocityFOM;
        headingFOM = _cmigitsHeadingFOM;
        timeFOM = _cmigitsTimeFOM;
        expectedHPosError = _cmigitsHPosError;
        expectedVPosError = _cmigitsVPosError;
        expectedVelocityError = _cmigitsVelocityError;
    }
    
    /**
     * @brief Return the latest attitude data from the C-MIGITS (information
     * from the C-MIGITS 3512 message)
     * @param[out] dataTime time of the attitude data, seconds since 
     * 1970-01-01 00:00:00 UTC
     * @param[out] pitch pitch, deg
     * @param[out] roll roll, deg
     * @param[out] heading heading, deg clockwise from true north
     */
    void cmigitsAttitude(double & dataTime,
            float & pitch, float & roll, float & heading) const {
        dataTime = _cmigitsAttitudeTime;
        pitch = _cmigitsPitch;
        roll = _cmigitsRoll;
        heading = _cmigitsHeading;
    }
    
    /**
     * @brief Return the latest navigation solution data from the C-MIGITS
     * (information from the C-MIGITS 3501 message).
     * @param[out] dataTime time of the navigation solution data, seconds since 
     * 1970-01-01 00:00:00 UTC
     * @param[out] latitude latitude, deg
     * @param[out] longitude longitude, deg
     * @param[out] altitude altitude, m above MSL
     * @param[out] velNorth, north component of velocity, m/s
     * @param[out] velEast, east component of velocity, m/s
     * @param[out] velUp, upward component of velocity, m/s
     */
    void cmigitsNavSolution(double & dataTime,
            float & latitude, float & longitude, float & altitude,
            float & velNorth, float & velEast, float & velUp) const {
        dataTime = _cmigitsNavSolutionTime;
        latitude = _cmigitsLatitude;
        longitude = _cmigitsLongitude;
        altitude = _cmigitsAltitude;
        velNorth = _cmigitsVelNorth;
        velEast = _cmigitsVelEast;
        velUp = _cmigitsVelUp;
    }
private:
    /**
     * @brief Simple class implementing a list of temperatures with a maximum
     * size. When a temperature is added which causes the maximum size to be
     * exceeded, the oldest item in the list will be removed to bring the size
     * back to the maximum.
     */
    class TemperatureList {
    public:
        /**
         * @brief Constructor.
         */
        TemperatureList() : _items() {}
        /**
         * @brief Add a temperature to the list.
         * @param val the temperature to add to the list
         */
        void addTemperature(double val) {
            _items.push_front(val);
            if (_items.size() > _MAX_SIZE) {
                _items.pop_back();
            }
        }
        /**
         * @brief Return the mean of the values in the list, or -99.9 if
         * the list is empty.
         * @return the mean of the values in the list, or -99.9 if
         * the list is empty.
         */
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

    /**
     * @brief Get new values for all of our sensor data supplied via the PMC730
     * multi-IO card.
     */
    void _getMultiIoValues();

    /**
     * @brief Get new sensor data from the Pentek P7142 card.
     */
    void _getPentekValues(const Pentek::p7142 & pentek);
    
    /**
     * @brief Get latest available data from the C-MIGITS
     */
    void _getCmigitsValues();
    
    /**
     * @brief Serialize our members to a boost save (output) archive or populate
     * our members from a boost load (input) archive.
     */
    template<class Archive>
    void _serialize(Archive & ar) {
        // Map named entries to our member variables using serialization's
        // name/value pairs (nvp).
        ar & boost::serialization::make_nvp("cmigitsAltitude", _cmigitsAltitude);
        ar & boost::serialization::make_nvp("cmigitsAttitudeTime", _cmigitsAttitudeTime);
        ar & boost::serialization::make_nvp("cmigitsCurrentMode", _cmigitsCurrentMode);
        ar & boost::serialization::make_nvp("cmigitsDoingCoarseAlignment", _cmigitsDoingCoarseAlignment);
        ar & boost::serialization::make_nvp("cmigitsGpsAvailable", _cmigitsGpsAvailable);
        ar & boost::serialization::make_nvp("cmigitsHeadingFOM", _cmigitsHeadingFOM);
        ar & boost::serialization::make_nvp("cmigitsHeading", _cmigitsHeading);
        ar & boost::serialization::make_nvp("cmigitsHPosError", _cmigitsHPosError);
        ar & boost::serialization::make_nvp("cmigitsInsAvailable", _cmigitsInsAvailable);
        ar & boost::serialization::make_nvp("cmigitsLatitude", _cmigitsLatitude);
        ar & boost::serialization::make_nvp("cmigitsLongitude", _cmigitsLongitude);
        ar & boost::serialization::make_nvp("cmigitsNavSolutionTime", _cmigitsNavSolutionTime);
        ar & boost::serialization::make_nvp("cmigitsNSats", _cmigitsNSats);
        ar & boost::serialization::make_nvp("cmigitsPitch", _cmigitsPitch);
        ar & boost::serialization::make_nvp("cmigitsPositionFOM", _cmigitsPositionFOM);
        ar & boost::serialization::make_nvp("cmigitsRoll", _cmigitsRoll);
        ar & boost::serialization::make_nvp("cmigitsStatusTime", _cmigitsStatusTime);
        ar & boost::serialization::make_nvp("cmigitsTemp", _cmigitsTemp);
        ar & boost::serialization::make_nvp("cmigitsTimeFOM", _cmigitsTimeFOM);
        ar & boost::serialization::make_nvp("cmigitsVelEast", _cmigitsVelEast);
        ar & boost::serialization::make_nvp("cmigitsVelNorth", _cmigitsVelNorth);
        ar & boost::serialization::make_nvp("cmigitsVelocityError", _cmigitsVelocityError);
        ar & boost::serialization::make_nvp("cmigitsVelocityFOM", _cmigitsVelocityFOM);
        ar & boost::serialization::make_nvp("cmigitsVelUp", _cmigitsVelUp);
        ar & boost::serialization::make_nvp("cmigitsVPosError", _cmigitsVPosError);
        ar & boost::serialization::make_nvp("detectedRfPower", _detectedRfPower);
        ar & boost::serialization::make_nvp("eikTemp", _eikTemp);
        ar & boost::serialization::make_nvp("emsError1", _emsError1);
        ar & boost::serialization::make_nvp("emsError2", _emsError2);
        ar & boost::serialization::make_nvp("emsError3", _emsError3);
        ar & boost::serialization::make_nvp("emsError4Or5", _emsError4Or5);
        ar & boost::serialization::make_nvp("emsError6Or7", _emsError6Or7);
        ar & boost::serialization::make_nvp("emsPowerError", _emsPowerError);
        ar & boost::serialization::make_nvp("hLnaTemp", _hLnaTemp);
        ar & boost::serialization::make_nvp("hmcMode", _hmcMode);
        ar & boost::serialization::make_nvp("locked1250MHzPLO", _locked1250MHzPLO);
        ar & boost::serialization::make_nvp("locked125MHzPLO", _locked125MHzPLO);
        ar & boost::serialization::make_nvp("locked15_5GHzPLO", _locked15_5GHzPLO);
        ar & boost::serialization::make_nvp("modPulseDisabled", _modPulseDisabled);
        ar & boost::serialization::make_nvp("noiseSourceSelected", _noiseSourceSelected);
        ar & boost::serialization::make_nvp("noiseSourceTemp", _noiseSourceTemp);
        ar & boost::serialization::make_nvp("pentekBoardTemp", _pentekBoardTemp);
        ar & boost::serialization::make_nvp("pentekFpgaTemp", _pentekFpgaTemp);
        ar & boost::serialization::make_nvp("ploTemp", _ploTemp);
        ar & boost::serialization::make_nvp("polarizationSwitchTemp", _polarizationSwitchTemp);
        ar & boost::serialization::make_nvp("ps28VTemp", _ps28VTemp);
        ar & boost::serialization::make_nvp("psVoltage", _psVoltage);
        ar & boost::serialization::make_nvp("pvAftPressure", _pvAftPressure);
        ar & boost::serialization::make_nvp("pvForePressure", _pvForePressure);
        ar & boost::serialization::make_nvp("radarPowerError", _radarPowerError);
        ar & boost::serialization::make_nvp("rdsInDuctTemp", _rdsInDuctTemp);
        ar & boost::serialization::make_nvp("rdsXmitterFilamentOn", _rdsXmitterFilamentOn);
        ar & boost::serialization::make_nvp("rdsXmitterHvOn", _rdsXmitterHvOn);
        ar & boost::serialization::make_nvp("rfDetectorTemp", _rfDetectorTemp);
        ar & boost::serialization::make_nvp("rotationMotorTemp", _rotationMotorTemp);
        ar & boost::serialization::make_nvp("tailconeTemp", _tailconeTemp);
        ar & boost::serialization::make_nvp("terminationSelected", _terminationSelected);
        ar & boost::serialization::make_nvp("tiltMotorTemp", _tiltMotorTemp);
        ar & boost::serialization::make_nvp("vLnaTemp", _vLnaTemp);
        ar & boost::serialization::make_nvp("waveguideSwitchError", _waveguideSwitchError);
    }

    // We can keep one static object to give all instances access to the
    // shared memory segment with C-MIGITS data.
    static CmigitsSharedMemory * _CmigitsShm;

    // Keep static lists of temperatures sampled from the multi-IO card so that
    // we can time-average to reduce noise in the sampling. Values are added to
    // the lists on each call to the constructor which samples new values, i.e.,
    // DrxStatus(const Pentek::p7142 &).

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
    /// C-MIGITS temperature list
    static TemperatureList _CmigitsTemps;
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

    /// C-MIGITS time-averaged temperature
    double _cmigitsTemp;

    /// tailcone time-averaged temperature
    double _tailconeTemp;

    /// detected RF power
    double _detectedRfPower;

    /// pressure vessel aft pressure
    double _pvAftPressure;

    /// pressure vessel fore pressure
    double _pvForePressure;

    /// measured voltage from 5V power supply
    double _psVoltage;

    /// Is waveguide switch A set to the noise source?
    bool _noiseSourceSelected;

    /// Is waveguide switch B set to termination?
    bool _terminationSelected;

    /// 15.5 GHz oscillator phase locked?
    bool _locked15_5GHzPLO;

    /// 1250 MHz oscillator phase locked?
    bool _locked1250MHzPLO;

    /// 125 MHz oscillator phase locked?
    bool _locked125MHzPLO;

    /// Is modulator pulse passthrough disabled at the HMC?
    bool _modPulseDisabled;

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

    /// Pentek FPGA temperature
    double _pentekFpgaTemp;

    /// Pentek board temperature;
    double _pentekBoardTemp;

    /// HMC operating mode
    uint16_t _hmcMode;
    
    /// C-MIGITS time of last status information, seconds since 
    /// 1970-01-01 00:00:00 UTC. This time applies to current mode, 
    /// INS available, GPS available, position FOM, velocity FOM, 
    /// heading FOM, time FOM, H position error, V position error, and
    /// velocity error
    double _cmigitsStatusTime;
    /// C-MIGITS current mode (see documentation for the C-MIGITS 3500 message)
    uint16_t _cmigitsCurrentMode;
    /// C-MIGITS number of satellites tracked
    uint16_t _cmigitsNSats;
    /// C-MIGITS INS available
    bool _cmigitsInsAvailable;
    /// C-MIGITS GPS available
    bool _cmigitsGpsAvailable;
    /// Is C-MIGITS currently in "Coarse Alignment" submode?
    bool _cmigitsDoingCoarseAlignment;
    /// C-MIGITS position figure of merit (see documentation for the C-MIGITS
    /// 3500 message)
    uint16_t _cmigitsPositionFOM;
    /// C-MIGITS velocity figure of merit (see documentation for the C-MIGITS
    /// 3500 message)
    uint16_t _cmigitsVelocityFOM;
    /// C-MIGITS heading figure of merit (see documentation for the C-MIGITS
    /// 3500 message)
    uint16_t _cmigitsHeadingFOM;
    /// C-MIGITS time figure of merit (see documentation for the C-MIGITS
    /// 3500 message)
    uint16_t _cmigitsTimeFOM;
    /// C-MIGITS expected horizontal position error, m
    float _cmigitsHPosError;
    /// C-MIGITS expected vertical position error, m
    float _cmigitsVPosError;
    /// C-MIGITS expected velocity error, m/s
    float _cmigitsVelocityError;
    
    /// C-MIGITS time of last navigation solution, seconds since 
    /// 1970-01-01 00:00:00 UTC. This time applies to latitude, longitude,
    /// altitude, north velocity component, east velocity component, and 
    /// upward velocity component
    double _cmigitsNavSolutionTime;
    /// C-MIGITS latitude, deg
    float _cmigitsLatitude;
    /// C-MIGITS longitude, deg
    float _cmigitsLongitude;
    /// C-MIGITS altitude, m above MSL
    float _cmigitsAltitude;
    /// C-MIGITS north component of velocity, m/s
    float _cmigitsVelNorth;
    /// C-MIGITS east component of velocity, m/s
    float _cmigitsVelEast;
    /// C-MIGITS upward component of velocity, m/s
    float _cmigitsVelUp;
    
    /// C-MIGITS time of latest attitude information, seconds since 
    /// 1970-01-01 00:00:00 UTC. This time applies to pitch, roll, and
    /// heading.
    double _cmigitsAttitudeTime;
    /// C-MIGITS latest pitch, deg
    float _cmigitsPitch;
    /// C-MIGITS latest roll, deg
    float _cmigitsRoll;
    /// C-MIGITS latest heading, deg clockwise from true north
    float _cmigitsHeading;
};

#endif /* DRXSTATUS_H_ */
