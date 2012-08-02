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

// #include <XmitClient.h>

class HcrMonitorPriv;

/// QThread object which handles Hcr monitoring, regularly sampling all status 
/// available via the multi-IO card as well as transmitter status information 
/// obtained from the hcr_xmitd process.
class HcrMonitor : public QThread {
public:
    /**
     * Construct a HcrMonitor which will read data on a regular basis from 
     * the PMC-730 card, and get transmitter status from ka_xmitd
     * running on host xmitdHost/port xmitdPort.
     * @param config the HcrDrxConfig defining run-time configuration for hcrdrx
     * @param xmitdHost the name of the host on which hcr_xmitd is running
     * @param xmitdPort the port number hcr_xmitd is using for XmlRpc calls
     */
    HcrMonitor(const HcrDrxConfig &config, std::string xmitdHost, int xmitdPort);
    
    virtual ~HcrMonitor();
    
    void run();

    /**
     * Return temperature near the DRX computer, C.
     * @return temperature near the DRX computer, C
     */
    float procDrxTemp() const;

    /**
     * Get the transmitter status.
     * @return the transmitter status.
     */
    XmitClient::XmitStatus transmitterStatus() const;

private:

    // run-time configuration
    const HcrDrxConfig &_config;

    /** 
     * Calculate temperature of a Pt1000 RTD temperature sensor connected in
     * series with a pulldown resistor across a known voltage.
     * @param psVolts the voltage of the power supply feeding the divider, V
     * @param pulldownVolts the voltage across the pulldown resistor, V
     * @param pulldownOhms the resistance of the pulldown resistor, ohms
     * @return the temperature of the RTD, deg C
     */
    static double _pt1000Temperature(double psVolts, double pulldownVolts,
    		double pulldownOhms);
    
    /** 
     * Calculate the pressure based on the voltage from an
     * All Sensors 15PSI-A-4V-MIL sensor.
     * @param sensorVoltage the potential across the sensor, V
     */
    static double _15PSI_A_4V_Pres(double sensorVolts);

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
     * Get transmitter status information from the hcr_xmitd process.
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
    std::deque<float> _procDrxTemps;

    /// XML-RPC access to hcr_xmitd for its status
    XmitClient _xmitClient;
    XmitClient::XmitStatus _xmitStatus;
};


#endif /* HCR_MONITOR_H_ */
