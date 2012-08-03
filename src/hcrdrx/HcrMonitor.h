/*
 * KaMonitor.h
 *
 *  Created on: Dec 13, 2010
 *      Author: burghart
 */

#ifndef HCR_MONITOR_H_
#define HCR_MONITOR_H_

#include <deque>
#include <string>

#include <QThread>
#include <QMutex>

#include <XmitClient.h>

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
     * @brief Return the temperature of the crystal RF detector, deg C
     * @return the temperature of the crystal RF detector, deg C
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
     * @brief Return the temperature at the input air duct for the remote data system
     * (RDS), deg C
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
     * @brief Return true iff waveguide switch A is in the "noise source" position
     * @return true iff waveguide switch A is in the "noise source" position
     */
    bool noiseSourceSelected() const;
    /**
     * @brief Return true iff waveguide switch B is in "termination" position
     * @return true iff waveguide switch B is in "termination" position
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
     * @brief Return the status value from the Health Monitoring and Control
     * (HMC) card.
     * Return the two-bit status value from the HMC. The meanings of the
     * status values are:
     * 0 = no errors,
     * 1 = EMS power below threshold,
     * 2 = receiver protector switching error,
     * 3 = polarization switching error
     * @return true iff 1250 MHz PLO is phase locked
     */
    int hmcStatus() const;

    /**
     * @brief Return the transmitter status.
     * @return the transmitter status.
     */
    XmitClient::XmitStatus transmitterStatus() const;

private:

    /// run-time configuration
    const HcrDrxConfig &_config;

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
     */
    static float _15PSI_A_4V_Pres(float sensorVolts);

    /**
     * @brief Get new values for all of our sensor data supplied via the PMC730
     * multi-IO card.
     */
    void _getMultiIoValues();

    /**
     * @brief Get transmitter status information from the hcr_xmitd process.
     */
    void _getXmitStatus();

    /**
     * @brief Return the average of values in a deque<float>, or -99.9 if the deque
     * is empty.
     * @return the average of values in a deque<float>, or -99.9 if the deque
     *      is empty.
     */
    static float _dequeAverage(const std::deque<float> & list);
    
    /**
     * Thread access mutex (mutable so we can lock the mutex even in const
     * methods)
     */
    mutable QMutex _mutex;
    
    /// window size for moving temperature averages
    static const unsigned int TEMP_AVERAGING_LEN = 20;
    
    // Deques to hold temperature lists. Lists of temperatures are kept so
    // that we can time-average to reduce noise in the sampling.

    /// 93 GHz PLO temperature deque
    std::deque<float> _ploTemps;
    /// Transmitter EIK temperature deque
    std::deque<float> _eikTemps;

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

    /// XML-RPC access to hcr_xmitd for its status
    XmitClient _xmitClient;

    /// Last transmitter status we obtained
    XmitClient::XmitStatus _xmitStatus;
};


#endif /* HCR_MONITOR_H_ */
