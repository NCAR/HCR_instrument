/*
 * KaMonitor.h
 *
 *  Created on: Dec 13, 2010
 *      Author: burghart
 */

#ifndef HCR_MONITOR_H_
#define HCR_MONITOR_H_

#include <deque>
#include <numeric>
#include <string>
#include <stdint.h>

#include <QThread>
#include <QMutex>

#include <XmitdRpcClient.h>

#include "HcrDrxConfig.h"

class HcrMonitorPriv;

/// @brief QThread object which handles HCR monitoring, regularly sampling all
/// status available via the multi-IO card as well as transmitter status
/// information obtained from the hcr_xmitd process.
class HcrMonitor : public QThread {
public:
    /**
     * @brief Construct a HcrMonitor which will read data on a regular basis from
     * the PMC-730 card, and get transmitter status from ka_xmitd
     * running on host xmitdHost/port xmitdPort.
     * @param config the HcrDrxConfig defining run-time configuration
     * @param xmitdHost the name of the host on which hcr_xmitd is running
     * @param xmitdPort the port number hcr_xmitd is using for XmlRpc calls
     */
    HcrMonitor(const HcrDrxConfig &config, std::string xmitdHost, int xmitdPort);
    
    virtual ~HcrMonitor();
    
    void run();

    /**
     * @brief Return the transmit pulse power from the QuinStar power detector, dBm
     * @return the transmit pulse power from the QuinStar power detector, dBm
     */
    float detectedRfPower() const;
    /**
     * @brief Return the pressure measured at the fore end of the pressure vessel, hPa
     * @return the pressure measured at the fore end of the pressure vessel, hPa
     */
    float pvForePressure() const;
    /**
     * @brief Return the pressure measured at the aft end of the pressure vessel, hPa
     * @return the pressure measured at the aft end of the pressure vessel, hPa
     */
    float pvAftPressure() const;
    /**
     * @brief Return the temperature of the 93 GHz phase-locked oscillator (PLO), deg C
     * @return the temperature of the 93 GHz phase-locked oscillator (PLO), deg C
     */
    float ploTemp() const;
    /**
     * @brief Return the temperature of the Extended Interaction Klystron (EIK), deg C
     * @return the temperature of the Extended Interaction Klystron (EIK), deg C
     */
    float eikTemp() const;
    /**
     * @brief Return the temperature of the vertical channel LNA, deg C
     * @return the temperature of the vertical channel LNA, deg C
     */
    float vLnaTemp() const;
    /**
     * @brief Return the temperature of the horizontal channel LNA, deg C
     * @return the temperature of the horizontal channel LNA, deg C
     */
    float hLnaTemp() const;
    /**
     * @brief Return the temperature of the polarization switch, deg C
     * @return the temperature of the polarization switch, deg C
     */
    float polarizationSwitchTemp() const;
    /**
     * @brief Return the temperature of the Mi-Wave 950W RF detector, deg C
     * @return the temperature of the Mi-Wave 950W RF detector, deg C
     */
    float rfDetectorTemp() const;
    /**
     * @brief Return the temperature of the noise source, deg C
     * @return the temperature of the noise source, deg C
     */
    float noiseSourceTemp() const;
    /**
     * @brief Return the temperature of 28V power supply, deg C
     * @return the temperature of the 28V power supply, deg C
     */
    float ps28VTemp() const;
    /**
     * @brief Return the temperature at the input air duct for the remote data 
     * system (RDS), deg C
     * @return the temperature at the input air duct for the remote data system
     * (RDS), deg C
     */
    float rdsInDuctTemp() const;
    /**
     * @brief Return the temperature of the reflector rotation motor, deg C
     * @return the temperature of the reflector rotation motor, deg C
     */
    float rotationMotorTemp() const;
    /**
     * @brief Return the temperature of the reflector tilt motor, deg C
     * @return the temperature of the reflector tilt motor, deg C
     */
    float tiltMotorTemp() const;
    /**
     * @brief Return the temperature of the C-MIGITS inertial navigation system, deg C
     * @return the temperature of the C-MIGITS inertial navigation system, deg C
     */
    float cmigitsTemp() const;
    /**
     * @brief Return the ambient temperature in the tailcone, deg C
     * @return the ambient temperature in the tailcone, deg C
     */
    float tailconeTemp() const;
    /**
     * @brief Return the measured voltage from the 5V power supply.
     * @return the measured voltage from the 5V power supply, V
     */
    float psVoltage() const;
    /**
     * @brief Return true iff waveguide switch is in the "noise source" position
     * @return true iff waveguide switch is in the "noise source" position
     */
    bool noiseSourceSelected() const;
    /**
     * @brief Return true iff waveguide switch is in "termination" position
     * @return true iff waveguide switch is in "termination" position
     */
    bool terminationSelected() const;
    /**
     * @brief Return true iff 15.5 GHz PLO is phase locked
     * @return true iff 15.5 GHz PLO is phase locked
     */
    bool locked15_5GHzPLO() const;
    /**
     * @brief Return true iff 1250 MHz PLO is phase locked
     * @return true iff 1250 MHz PLO is phase locked
     */
    bool locked1250MHzPLO() const;
    /**
     * @brief Return true iff modulation pulses are being stopped at the SCM and not
     * passed through to the transmitter
     * @return true iff modulation pulses are being stopped at the SCM and not
     * passed through to the transmitter
     */
    bool modPulseDisabled() const;
    /**
     * @brief Return true iff we are currently commanding "filament on" via
     * the RDS filament control line going to the transmitter.
     * @Return true iff we are currently commanding "filament on" via
     * the RDS filament control line going to the transmitter.
     */
    bool rdsXmitterFilamentOn() const;
    /**
     * @brief Return true iff we are currently commanding "high voltage on" via
     * the RDS HV control line going to the transmitter.
     * @Return true iff we are currently commanding "high voltage on" via
     * the RDS HV control line going to the transmitter.
     */
    bool rdsXmitterHvOn() const;

    /**
     * @brief Return the status value from the Health Monitoring and Control
     * (HMC) card.
     * @return the 3-bit status value from the HMC. The meanings of the
     * status values are:
     * 0 = no errors,
     * 1 = EMS power below threshold,
     * 2 = receiver protector switching error,
     * 3 = polarization switching error
     * 4-7 are currently unused.
     */
    int hmcStatus() const;

    /**
     * @brief Return the transmitter status.
     * @return the transmitter status.
     */
    XmitdRpcClient::XmitStatus transmitterStatus() const;

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
        void addTemperature(float val) {
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
        float mean() const {
            if (_items.empty())
                return(-99.9);
            float sum = std::accumulate(_items.begin(), _items.end(), 0.0);
            return(sum / _items.size());
        }
        
    private:
        /// Maximum number of values kept in the temperature list.
        static const unsigned int _MAX_SIZE = 10;
        std::deque<float> _items;
    };

    /** 
     * @brief Calculate temperature of a Pt1000 RTD temperature sensor connected
     * in series with a 1 kOhm pulldown resistor across a known voltage.
     * @param psVolts the voltage of the power supply feeding the divider, V
     * @param pulldownVolts the voltage across the pulldown resistor, V
     * @return the temperature of the RTD, deg C
     */
    static float _pt1000Temperature(float psVolts, float pulldownVolts);
    
    /** 
     * @brief Calculate the pressure based on the voltage from an
     * All Sensors 15PSI-A-4V-MIL sensor.
     * @param sensorVolts the potential across the sensor, V
     * @return the pressure at the 15PSI-A-4V-MIL sensor
     */
    static float _15PSI_A_4V_Pres(float sensorVolts);

    /**
     * @brief Convert the given voltage to measured RF power from
     * Mi-Wave 950W RF detector.
     * @param voltage the voltage measured at the Mi-Wave 950W detector
     * @return the RF power measured at the Mi-Wave 950W detector, dBm
     */
    static double _lookupMiWv950WPower(double voltage);
    /**
     * @brief Get new values for all of our sensor data supplied via the PMC730
     * multi-IO card.
     */
    void _getMultiIoValues();

    /**
     * @brief Get transmitter status information from the hcr_xmitd process.
     */
    void _getXmitStatus();

    /// run-time configuration
    const HcrDrxConfig &_config;

    /// XML-RPC access to hcr_xmitd for its status
    XmitdRpcClient _xmitClient;

    /// Last transmitter status we obtained
    XmitdRpcClient::XmitStatus _xmitStatus;

    /**
     * Thread access mutex (mutable so we can lock the mutex even in const
     * methods)
     */
    mutable QMutex _mutex;
    
    /// detected RF power
    float _detectedRfPower;

    /// pressure vessel aft pressure
    float _pvAftPressure;
    
    /// pressure vessel fore pressure
    float _pvForePressure;
    
    // Keep lists of temperatures are kept so that we can time-average to reduce
    // noise in the sampling.

    /// 93 GHz PLO temperature list
    TemperatureList _ploTemps;
    /// Transmitter EIK temperature list
    TemperatureList _eikTemps;
    /// vertical channel LNA temperature list
    TemperatureList _vLnaTemps;
    /// horizontal channel LNA temperature list
    TemperatureList _hLnaTemps;
    /// polarization switch temperature list
    TemperatureList _polarizationSwitchTemps;
    /// Mi-Wave 950W RF detector temperature list
    TemperatureList _rfDetectorTemps;
    /// noise source temperature list
    TemperatureList _noiseSourceTemps;
    /// 28V power supply temperature list
    TemperatureList _ps28VTemps;
    /// remote data system (RDS) intake duct temperature list
    TemperatureList _rdsInDuctTemps;
    /// rotation motor temperature list
    TemperatureList _rotationMotorTemps;
    /// tilt motor temperature list
    TemperatureList _tiltMotorTemps;
    /// C-MIGITS temperature list
    TemperatureList _cmigitsTemps;
    /// tailcone temperature list
    TemperatureList _tailconeTemps;

    /// measured voltage from 5V power supply
    float _psVoltage;

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

    /**
     * HMC status
     * 0 = no errors,
     * 1 = EMS power below threshold,
     * 2 = receiver protector switching error,
     * 3 = polarization switching error
     */
    uint16_t _hmcStatus;
};


#endif /* HCR_MONITOR_H_ */
