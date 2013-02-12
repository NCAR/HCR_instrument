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
     * @brief Return true iff the HMC is reporting EMS power error
     * @return true iff the HMC is reporting EMS power error
     */
    bool hmcEmsPowerError() const { return(_hmcEmsPowerError); }

    /**
     * @brief Return true iff the HMC is reporting receiver protection switching
     * error
     * @return true iff the HMC is reporting receiver protection switching
     * error
     */
    bool hmcRxProtectSwitchError() const { return(_hmcRxProtectSwitchError); }

    /**
     * @brief Return true iff the HMC is reporting polarization switching error
     * @return true iff the HMC is reporting polarization switching error
     */
    bool hmcPolSwitchError() const { return(_hmcPolSwitchError); }

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

    /// @brief Return the boolean value associated with statusDict[key]
    /// @param statusDict the XmlRpcValue status dictionary
    /// @param key the key for the desired value
    /// @return the boolean value associated with statusDict[key]
    /// @throws ConstructError if the key does not exist in the dictionary or
    /// there is another problem with the XmlRpcValue
    static bool _StatusBool(XmlRpcValue & statusDict,
            std::string key) throw(ConstructError);

    /// @brief Return the int value associated with statusDict[key]
    /// @param statusDict the XmlRpcValue status dictionary
    /// @param key the key for the desired value
    /// @return the int value associated with statusDict[key]
    /// @throws ConstructError if the key does not exist in the dictionary or
    /// there is another problem with the XmlRpcValue
    static int _StatusInt(XmlRpcValue & statusDict,
            std::string key) throw(ConstructError);

    /// @brief Return the double value associated with statusDict[key]
    /// @param statusDict the XmlRpcValue status dictionary
    /// @param key the key for the desired value
    /// @return the double value associated with statusDict[key]
    /// @throws ConstructError if the key does not exist in the dictionary or
    /// there is another problem with the XmlRpcValue
    static double _StatusDouble(XmlRpcValue & statusDict,
            std::string key) throw(ConstructError);

    /**
     * @brief Calculate temperature of a Pt1000 RTD temperature sensor connected
     * in series with a 1 kOhm pulldown resistor across a known voltage.
     * @param psVolts the voltage of the power supply feeding the divider, V
     * @param pulldownVolts the voltage across the pulldown resistor, V
     * @return the temperature of the RTD, deg C
     */
    static double _Pt1000Temperature(double psVolts, double pulldownVolts);

    /**
     * @brief Calculate the pressure based on the voltage from an
     * All Sensors 15PSI-A-4V-MIL sensor.
     * @param sensorVolts the potential across the sensor, V
     * @return the pressure at the 15PSI-A-4V-MIL sensor
     */
    static double _15PSI_A_4V_Pres(double sensorVolts);

    /**
     * @brief Convert the given voltage to measured RF power from
     * Mi-Wave 950W RF detector.
     * @param voltage the voltage measured at the Mi-Wave 950W detector
     * @return the RF power measured at the Mi-Wave 950W detector, dBm
     */
    static double _LookupMiWv950WPower(double voltage);
    
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

    /// detected RF power
    double _detectedRfPower;

    /// pressure vessel aft pressure
    double _pvAftPressure;

    /// pressure vessel fore pressure
    double _pvForePressure;


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

    /// Is modulator pulse passthrough disabled at the HMC?
    bool _modPulseDisabled;

    /// Is "filament on" being commanded via the RDS control line to the transmitter?
    bool _rdsXmitterFilamentOn;

    /// Is "high voltage on" being commanded via the RDS control line to the transmitter?
    bool _rdsXmitterHvOn;

    /// Is HMC reporting EMS power error?
    bool _hmcEmsPowerError;

    /// Is HMC reporting receiver protection switching error?
    bool _hmcRxProtectSwitchError;

    /// Is HMC reporting polarization switching error?
    bool _hmcPolSwitchError;

    /// Pentek FPGA temperature
    double _pentekFpgaTemp;

    /// Pentek board temperature;
    double _pentekBoardTemp;

    /// HMC operating mode
    int _hmcMode;
    
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
