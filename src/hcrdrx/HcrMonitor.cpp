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

/*
 * Mi-Wave 950W finline RF power detector calibration measurements from
 * 7/21/2009, 94.4 GHz input power in dBm vs. output volts (into high impedance).
 */

static const float MiWv950W_Cal[][2] = {
 {-26.60, 3.20e-3},
 {-23.65, 3.93e-3},
 {-22.74, 5.01e-3},
 {-21.86, 6.36e-3},
 {-20.50, 7.83e-3},
 {-19.85, 9.69e-3},
 {-18.90, 11.9e-3},
 {-17.96, 14.8e-3},
 {-16.94, 18.0e-3},
 {-15.99, 21.9e-3},
 {-15.00, 26.6e-3},
 {-14.01, 31.8e-3},
 {-13.02, 38.3e-3},
 {-12.04, 46.3e-3},
 {-11.05, 55.0e-3},
 {-10.05, 65.1e-3},
 {-9.05, 76.7e-3},
 {-8.04, 89.8e-3},
 {-7.05, 105.e-3},
 {-6.05, 123.e-3},
 {-5.03, 142.e-3},
 {-4.07, 165.e-3},
 {-3.07, 191.e-3},
 {-2.07, 219.e-3},
 {-1.08, 252.e-3},
 {-0.08, 288.e-3},
 {0.92, 330.e-3},
 {1.91, 383.e-3},
 {2.89, 432.e-3},
 {3.89, 495.e-3},
 {4.88, 560.e-3},
 {5.85, 632.e-3}
};
static const int MiWv950W_CalLen = (sizeof(MiWv950W_Cal) / (sizeof(*MiWv950W_Cal)));


HcrMonitor::HcrMonitor(const HcrDrxConfig &config, const Pentek::p7142 & pentek,
        std::string xmitdHost, int xmitdPort) :
    QThread(),
    _config(config),
    _pentek(pentek),
    _xmitClient(xmitdHost, xmitdPort),
    _mutex(QMutex::Recursive),
    _detectedRfPower(-99.9),
    _pvAftPressure(0.0),
    _pvForePressure(0.0),
    _psVoltage(0.0),
    _noiseSourceSelected(false),
    _terminationSelected(false),
    _locked15_5GHzPLO(false),
    _locked1250MHzPLO(false),
    _modPulseDisabled(false),
    _hmcStatus(0) {
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
HcrMonitor::pvForePressure() const {
    QMutexLocker locker(&_mutex);
    return(_pvForePressure);
}

float
HcrMonitor::pvAftPressure() const {
    QMutexLocker locker(&_mutex);
    return(_pvAftPressure);
}

float
HcrMonitor::ploTemp() const {
    QMutexLocker locker(&_mutex);
    return(_ploTemps.mean());
}

float
HcrMonitor::eikTemp() const {
    QMutexLocker locker(&_mutex);
    return(_eikTemps.mean());
}

float
HcrMonitor::vLnaTemp() const {
    QMutexLocker locker(&_mutex);
    return(_vLnaTemps.mean());
}

float
HcrMonitor::hLnaTemp() const {
    QMutexLocker locker(&_mutex);
    return(_hLnaTemps.mean());
}

float
HcrMonitor::polarizationSwitchTemp() const {
    QMutexLocker locker(&_mutex);
    return(_polarizationSwitchTemps.mean());
}

float
HcrMonitor::rfDetectorTemp() const {
    QMutexLocker locker(&_mutex);
    return(_rfDetectorTemps.mean());
}

float
HcrMonitor::noiseSourceTemp() const {
    QMutexLocker locker(&_mutex);
    return(_noiseSourceTemps.mean());
}

float
HcrMonitor::ps28VTemp() const {
    QMutexLocker locker(&_mutex);
    return(_ps28VTemps.mean());
}

float
HcrMonitor::rdsInDuctTemp() const {
    QMutexLocker locker(&_mutex);
    return(_rdsInDuctTemps.mean());
}

float
HcrMonitor::rotationMotorTemp() const {
    QMutexLocker locker(&_mutex);
    return(_rotationMotorTemps.mean());
}

float
HcrMonitor::tiltMotorTemp() const {
    QMutexLocker locker(&_mutex);
    return(_tiltMotorTemps.mean());
}

float
HcrMonitor::cmigitsTemp() const {
    QMutexLocker locker(&_mutex);
    return(_cmigitsTemps.mean());
}

float
HcrMonitor::tailconeTemp() const {
    QMutexLocker locker(&_mutex);
    return(_tailconeTemps.mean());
}

float
HcrMonitor::psVoltage() const {
    QMutexLocker locker(&_mutex);
    return(_psVoltage);
}

bool
HcrMonitor::noiseSourceSelected() const {
    QMutexLocker locker(&_mutex);
    return(_noiseSourceSelected);
}

bool
HcrMonitor::terminationSelected() const {
    QMutexLocker locker(&_mutex);
    return(_terminationSelected);
}

bool
HcrMonitor::locked15_5GHzPLO() const {
    QMutexLocker locker(&_mutex);
    return(_locked15_5GHzPLO);
}

bool
HcrMonitor::locked1250MHzPLO() const {
    QMutexLocker locker(&_mutex);
    return(_locked1250MHzPLO);
}

bool
HcrMonitor::modPulseDisabled() const {
    QMutexLocker locker(&_mutex);
    return(_modPulseDisabled);
}

bool
HcrMonitor::rdsXmitterFilamentOn() const {
    QMutexLocker locker(&_mutex);
    return(_rdsXmitterFilamentOn);
}

bool
HcrMonitor::rdsXmitterHvOn() const {
    QMutexLocker locker(&_mutex);
    return(_rdsXmitterHvOn);
}

float
HcrMonitor::detectedRfPower() const {
    QMutexLocker locker(&_mutex);
    return(_detectedRfPower);
}

int
HcrMonitor::hmcStatus() const {
    QMutexLocker locker(&_mutex);
    return(_hmcStatus);
}

float
HcrMonitor::pentekFpgaTemp() const {
    QMutexLocker locker(&_mutex);
    return(_pentekFpgaTemp);
}

float
HcrMonitor::pentekBoardTemp() const {
    QMutexLocker locker(&_mutex);
    return(_pentekBoardTemp);
}

XmitdRpcClient::XmitStatus
HcrMonitor::transmitterStatus() const {
    QMutexLocker locker(&_mutex);
    return(_xmitStatus);
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

        // Get the Pentek temperatures
        _pentekFpgaTemp = _pentek.fpgaTemp();
        _pentekBoardTemp = _pentek.circuitBoardTemp();
        std::cout << "Pentek FPGA temperature: " << _pentekFpgaTemp << " C" << std::endl;

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
    
    // Detected RF power
    _detectedRfPower = _lookupMiWv950WPower(analogData[0]);

    // Pressure sensors are on analog channels 1 and 2
    _pvAftPressure = _15PSI_A_4V_Pres(analogData[1]);
    _pvForePressure = _15PSI_A_4V_Pres(analogData[2]);
    
    // Channels 3-15 gives us various temperatures. The data are a bit noisy, so
    // we keep up to TemperatureList::_MAX_SIZE samples so we can generate moving 
    // averages.
    _ploTemps.addTemperature(_pt1000Temperature(_psVoltage, analogData[3]));
    _eikTemps.addTemperature(_pt1000Temperature(_psVoltage, analogData[4]));
    _vLnaTemps.addTemperature(_pt1000Temperature(_psVoltage, analogData[5]));
    _hLnaTemps.addTemperature(_pt1000Temperature(_psVoltage, analogData[6]));
    _polarizationSwitchTemps.addTemperature(_pt1000Temperature(_psVoltage, analogData[7]));
    _rfDetectorTemps.addTemperature(_pt1000Temperature(_psVoltage, analogData[8]));
    _noiseSourceTemps.addTemperature(_pt1000Temperature(_psVoltage, analogData[9]));
    _ps28VTemps.addTemperature(_pt1000Temperature(_psVoltage, analogData[10]));
    _rdsInDuctTemps.addTemperature(_pt1000Temperature(_psVoltage, analogData[11]));
    _rotationMotorTemps.addTemperature(_pt1000Temperature(_psVoltage, analogData[12]));
    _tiltMotorTemps.addTemperature(_pt1000Temperature(_psVoltage, analogData[13]));
    _cmigitsTemps.addTemperature(_pt1000Temperature(_psVoltage, analogData[14]));
    _tailconeTemps.addTemperature(_pt1000Temperature(_psVoltage, analogData[15]));
    
    // Get values from our digital input lines
    _noiseSourceSelected = pmc730.noiseSourceSelected();
    _terminationSelected = pmc730.terminationSelected();
    _locked15_5GHzPLO = pmc730.locked15_5GHzPLO();
    _locked1250MHzPLO = pmc730.locked1250MHzPLO();
    _modPulseDisabled = pmc730.modPulseDisabled();
    _hmcStatus = pmc730.hmcStatus();

    // Get values of two digital output lines
    _rdsXmitterFilamentOn = pmc730.xmitterFilamentOn();
    _rdsXmitterHvOn = pmc730.xmitterHvOn();

    DLOG << "PS voltage: " << std::setprecision(3) << psVoltage() << " V";
}

void
HcrMonitor::_getXmitStatus() {
    // Get the status first, then get the mutex and set our member variable.
    // This way, we don't have the mutex locked very long at all....
    XmitdRpcClient::XmitStatus xmitStatus;
    _xmitClient.getStatus(xmitStatus);

    QMutexLocker locker(&_mutex);
    _xmitStatus = xmitStatus;
}

double
HcrMonitor::_lookupMiWv950WPower(double voltage) {
    // If we're below the lowest voltage in the cal table, just return a
    // really low power
    if (voltage < MiWv950W_Cal[0][1]) {
        return(-99.9);
    }
    // If we're above the highest voltage in the cal table, just return the
    // highest power in the cal table.
    if (voltage > MiWv950W_Cal[MiWv950W_CalLen - 1][1]) {
        return(MiWv950W_Cal[MiWv950W_CalLen - 1][0]);
    }
    // OK, our voltage is somewhere in the table. Move up through the table,
    // and interpolate between the two enclosing points.
    for (int i = 0; i < MiWv950W_CalLen - 1; i++) {
        float powerLow = MiWv950W_Cal[i][0];
        float vLow = MiWv950W_Cal[i][1];
        float powerHigh = MiWv950W_Cal[i + 1][0];
        float vHigh = MiWv950W_Cal[i + 1][1];
        if (vHigh < voltage)
            continue;
        // Convert powers to linear space, then interpolate to our input voltage
        double powerLowLinear = pow(10.0, powerLow / 10.0);
        double powerHighLinear = pow(10.0, powerHigh / 10.0);
        double fraction = (voltage - vLow) / (vHigh - vLow);
        double powerLinear = powerLowLinear +
            (powerHighLinear - powerLowLinear) * fraction;
        // Convert interpolated power back to dBm and return it.
        return(10.0 * log10(powerLinear));
    }
    // Oops if we get here...
    ELOG << __PRETTY_FUNCTION__ << ": Bad lookup for " << voltage << " V!";
    abort();
}
