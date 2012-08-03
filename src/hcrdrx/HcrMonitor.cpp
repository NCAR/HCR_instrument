/*
 * HcrMonitor.cpp
 *
 *  Created on: Oct 29, 2010
 *      Author: burghart
 */

#include "HcrMonitor.h"
#include "HcrPmc730.h"

#include <QDateTime>
#include <QTimer>
#include <QMutexLocker>

#include <iostream>
#include <iomanip>
#include <cmath>
#include <string>
#include <vector>
#include <deque>

#include <logx/Logging.h>

LOGGING("HcrMonitor")


HcrMonitor::HcrMonitor(const HcrDrxConfig &config, std::string xmitdHost,
        int xmitdPort) :
    QThread(),
    _config(config),
    _mutex(QMutex::Recursive),
    _xmitClient(xmitdHost, xmitdPort)  {
}

HcrMonitor::~HcrMonitor() {
    terminate();
    if (! wait(5000)) {
        ELOG << "HcrMonitor thread failed to stop in 5 seconds. Exiting anyway.";
    }
}

/*
 * Map from Pt1000 resistance to temperature, generated on the first call to 
 * _pt1000Temperature()
 */
static std::map<float, float>  Pt1000_OhmsToTempMap;
static float Pt1000MapMinOhms;
static float Pt1000MapMaxOhms;

float
HcrMonitor::_pt1000Temperature(float psVolts, float pulldownVolts) {
    // All of our Pt1000 temperature sensor pulldown resistors are 1000 ohms.
    const float PulldownOhms = 1000;

    // Build the resistance->temperature map the first time we come here.
    // The map is just a table of resistances calculated every 1 degree
    // C from -50 to 200 deg C. The formula is the Callendar-Van Dusen 
    // equation, using the standard Pt1000 values for A, B, and C.
    if (Pt1000_OhmsToTempMap.empty()) {
        float R0 = 1000;   // 1000 ohms for Pt1000
        float A = 3.9083e-3;   // deg C^-1
        float B = -5.775e-7;   // deg C^-2
        float C = -4.183e-12;  // deg C^-4
        float TMin = -50.0;
        float TMax = 200.0;
        for (float t = TMin; t <= TMax; t += 1.0) {
            float r = R0 * (1 + (A * t) + (B * t * t));
            if (t < 0) {
                r += R0 * (C * t * t * t * (t - 100));
            }
            if (t == TMin) {
                Pt1000MapMinOhms = r;
            }
            Pt1000MapMaxOhms = r;
            Pt1000_OhmsToTempMap[r] = t;
        }
    }
    // Resistance of the RTD, calculated from psVolts drop across our 
    // voltage divider with the RTD and the pulldown resistor in series.
    float rtdOhms = PulldownOhms * (psVolts / pulldownVolts - 1);

    // If rtdOhms is less than the lowest resistance in our map, 
    // return -999.9
    if (rtdOhms < Pt1000MapMinOhms) {
        return(-999.9);
    }
    // If rtdOhms is greater than the highest resistance in our map,
    // return 999.9
    if (rtdOhms > Pt1000MapMaxOhms) {
        return(999.9);
    }
    // Find the iterators for entries which bound our RTD resistance
    std::map<float, float>::iterator itLower =
        Pt1000_OhmsToTempMap.lower_bound(rtdOhms);
    std::map<float, float>::iterator itUpper = itLower++;
    // Interpolate between the two values to get our temperature.
    float r0 = itLower->first;
    float t0 = itLower->second;
    float r1 = itUpper->first;
    float t1 = itUpper->second;
    return(t0 + (rtdOhms - r0) / (r1 - r0) * (t1 - t0));
}

float
HcrMonitor::_15PSI_A_4V_Pres(float sensorVolts) {
    // Nominal calibration from device spec: 0.25 V @ zero pressure
    const float zeroPresOffsetVolts = 0.25;
    // Nominal calibration from device spec: 4 V output span over 15 PSI
    // (1034.2 hPa)
    const float hPaPerVolt = 1034.2 / 4.0;
    return(hPaPerVolt * (sensorVolts - zeroPresOffsetVolts));
}


float
HcrMonitor::ploTemp() const {
    QMutexLocker locker(&_mutex);
    return _dequeAverage(_ploTemps);
}

float
HcrMonitor::eikTemp() const {
    QMutexLocker locker(&_mutex);
    return _dequeAverage(_eikTemps);
}

XmitClient::XmitStatus
HcrMonitor::transmitterStatus() const {
    QMutexLocker locker(&_mutex);
    return _xmitStatus;
}

void
HcrMonitor::run() {
    QDateTime lastUpdateTime(QDateTime::fromTime_t(0).toUTC());
    
    // Since we have no event loop, allow thread termination via the terminate()
    // method.
    setTerminationEnabled(true);

    while (true) {
        // Sleep if necessary to get ~1 second between updates
        QDateTime now = QDateTime::currentDateTime().toUTC();
        uint64_t msecsSinceUpdate = uint64_t(lastUpdateTime.daysTo(now)) * 1000 * 86400 + 
            lastUpdateTime.time().msecsTo(now.time());
        if (msecsSinceUpdate < 1000) {
            usleep((1000 - msecsSinceUpdate) * 1000);
        }
        
        // Get new values from the multi-IO card and from hcr_xmitd
        _getMultiIoValues();
        
        // Get transmitter status.
        _getXmitStatus();

        lastUpdateTime = QDateTime::currentDateTime().toUTC();
    }
}

void
HcrMonitor::_getMultiIoValues() {

    if (_config.simulate_pmc730()) {
        return;
    }

    QMutexLocker locker(&_mutex);

    HcrPmc730 & pmc730 = HcrPmc730::theHcrPmc730();
    // Get data from analog channels 0-16 on the PMC-730 multi-IO card
    std::vector<float> analogData = pmc730.readAnalogChannels(0, 16);

    // Get the power supply voltage from channel 16 now, since we need if to
    // calculate temperatures below.
    _psVoltage = analogData[16];
    // Channels 3-15 gives us various temperatures. The data are a bit noisy, so
    // we keep up to TEMP_AVERAGING_LEN samples so we can generate moving 
    // averages.
    _ploTemps.push_front(_pt1000Temperature(_psVoltage, analogData[3]));
    _eikTemps.push_front(_pt1000Temperature(_psVoltage, analogData[4]));
    if (_ploTemps.size() > TEMP_AVERAGING_LEN) {
        _ploTemps.resize(TEMP_AVERAGING_LEN);
        _eikTemps.resize(TEMP_AVERAGING_LEN);
    }
}

void
HcrMonitor::_getXmitStatus() {
    // Get the status first, then get the mutex and set our member variable.
    // This way, we don't have the mutex locked very long at all....
    XmitClient::XmitStatus xmitStatus;
    _xmitClient.getStatus(xmitStatus);

    QMutexLocker locker(&_mutex);
    _xmitStatus = xmitStatus;
}

float
HcrMonitor::_dequeAverage(const std::deque<float> & list) {
    unsigned int nPoints = list.size();
    if (nPoints == 0)
        return(-99.9);
        
    float sum = 0.0;
    for (unsigned int i = 0; i < nPoints; i++)
        sum += list.at(i);
    return(sum / nPoints); 
}
