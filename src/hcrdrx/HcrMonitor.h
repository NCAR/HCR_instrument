/*
 * KaMonitor.h
 *
 *  Created on: Dec 13, 2010
 *      Author: burghart
 */

#ifndef HCR_MONITOR_H_
#define HCR_MONITOR_H_

#include <deque>

#include <QThread>
#include <QMutex>

#include "HcrDrxConfig.h"

// #include <XmitClient.h>

class HcrMonitorPriv;

/// QThread object which handles Hcr monitoring, regularly sampling all status 
/// available via the multi-IO card as well as transmitter status information 
/// obtained from the hcr_xmitd process.
class HcrMonitor : public QThread {
public:
    /**
     * Construct a HcrMonitor which will get transmitter status from hcr_xmitd
     * running on host xmitdHost/port xmitdPort.
     */
  HcrMonitor(const HcrDrxConfig &config,
             std::string xmitdHost, int xmitdPort);
    
    ~HcrMonitor();
    
    void run();

    /**
     * Return processor enclosure temperature, C.
     * @return processor enclosure temperature, C
     */
    float procEnclosureTemp() const;
    /**
     * Return temperature near the DRX computer, C.
     * @return temperature near the DRX computer, C
     */
    float procDrxTemp() const;
    /**
     * Return the transmitter enclosure temperature, C.
     * @return the transmitter enclosure temperature, C
     */
    float txEnclosureTemp() const;
    /**
     * Return the temperature at the top of the receiver enclosure, C.
     * @return the temperature at the top of the receiver enclosure, C
     */
    float rxTopTemp() const;
    /**
     * Return the temperature at the back of the receiver enclosure, C.
     * @return the temperature at the back of the receiver enclosure, C
     */
    float rxBackTemp() const;
    /**
     * Return the temperature at the front of the receiver enclosure, C.
     * @return the temperature at the front of the receiver enclosure, C
     */
    float rxFrontTemp() const;
    /**
     * Transmit power @ H channel, dBm
     * @return transmit power @ H channel, dBm
     */
    float hTxPowerVideo() const;
    /**
     * Transmit power @ V channel, dBm
     * @return transmit power @ V channel, dBm
     */
    float vTxPowerVideo() const;
    /**
     * Test target power, dBm
     * @return test target power, dBm
     */
    float testTargetPowerVideo() const;
    /**
     * Measured voltage @ 5V power supply, V
     * @return measured voltage @ 5V power supply, V
     */
    float psVoltage() const;
    /**
     * Is waveguide pressure outside of the transmitter good?
     * @return true iff waveguide pressure outside the transmitter is good.
     */
    bool wgPressureGood() const;
    /**
     * Is the 100 MHz oscillator locked?
     * @return true iff the 100 MHz oscillator is locked.
     */
    bool locked100MHz() const;
    /**
     * Is the GPS NTP time server locked and running properly?
     * @return true iff the GPS NTP time server is locked and running properly.
     */
    bool gpsTimeServerGood() const;
    /**
     * Get the transmitter status.
     * @return the transmitter status.
     */
  // XmitClient::XmitStatus transmitterStatus() const;
private:

    // run-time configuration
    const HcrDrxConfig &_config;

    /**
     * Convert QEA crystal detector voltage to input power (in dBm), based
     * on a fixed table of calibration measurements.
     * @param voltage QEA crystal detector output, in V
     * @return power measured by the QEA crystal detector, in dBm
     */
    static double _lookupQEAPower(double voltage);
    /**
     * Return the temperature, in C, based on temperature sensor voltage.
     * @param voltage voltage from temperature sensor
     * @return the temperature, in C
     */
    static double _voltsToTemp(double voltage) {
        // Temperature sensor voltage = 0.01 * T(Kelvin)
        // Convert volts to Kelvin, then to Celsius
        return((100 * voltage) - 273.15);
    }
    /**
     * Get new values for all of our sensor data supplied via the PMC730
     * multi-IO card.
     */
    void _getMultiIoValues();
    /**
     * Get status from the transmitter and put it in our local _xmitStatus
     * member.
     */
    void _getXmitStatus();
    /**
     * Return the average of values in a deque<float>, or -99.9 if the deque
     * is empty.
     * @return the average of values in a deque<float>, or -99.9 if the deque
     *      is empty.
     */
    static float _dequeAverage(const std::deque<float> & list);
    
    /// Thread access mutex (mutable so we can lock the mutex even in const
    /// methods)
    mutable QMutex _mutex;
    
    /// window size for moving temperature averages
    static const unsigned int TEMP_AVERAGING_LEN = 20;
    
    /// Deques to hold temperature lists. Lists of temperatures are kept so
    /// that we can time-average to reduce noise in the sampling.
    std::deque<float> _procEnclosureTemps;
    std::deque<float> _procDrxTemps;
    std::deque<float> _txEnclosureTemps;
    std::deque<float> _rxTopTemps;
    std::deque<float> _rxBackTemps;
    std::deque<float> _rxFrontTemps;
    
    /// Video power monitors
    float _hTxPowerVideo;           // H tx pulse power, dBm
    float _vTxPowerVideo;           // V tx pulse power, dBm
    float _testTargetPowerVideo;    // test target power, dBm
    
    /// 5V power supply
    float _psVoltage;
    
    /// Valid pressure in waveguide outside the transmitter?
    bool _wgPressureGood;

    /// 100 MHz oscillator OK?
    bool _locked100MHz;

    /// GPS time server alarm state
    bool _gpsTimeServerGood;
    
    /// XML-RPC access to hcr_xmitd for its status
//     XmitClient _xmitClient;
//     XmitClient::XmitStatus _xmitStatus;
};


#endif /* HCR_MONITOR_H_ */