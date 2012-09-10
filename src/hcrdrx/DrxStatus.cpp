/*
 * DrxStatus.cpp
 *
 *  Created on: Sep 6, 2012
 *      Author: hcr
 */

#include "DrxStatus.h"
#include "HcrPmc730.h"
#include <logx/Logging.h>
#include <iomanip>

LOGGING("DrxStatus")

/*
 * Mi-Wave 950W finline RF power detector calibration measurements from
 * 7/21/2009, 94.4 GHz input power in dBm vs. output volts (into high impedance).
 */
static const double MiWv950W_Cal[][2] = {
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


DrxStatus::TemperatureList DrxStatus::_PloTemps;
DrxStatus::TemperatureList DrxStatus::_EikTemps;
DrxStatus::TemperatureList DrxStatus::_VLnaTemps;
DrxStatus::TemperatureList DrxStatus::_HLnaTemps;
DrxStatus::TemperatureList DrxStatus::_PolarizationSwitchTemps;
DrxStatus::TemperatureList DrxStatus::_RfDetectorTemps;
DrxStatus::TemperatureList DrxStatus::_NoiseSourceTemps;
DrxStatus::TemperatureList DrxStatus::_Ps28VTemps;
DrxStatus::TemperatureList DrxStatus::_RdsInDuctTemps;
DrxStatus::TemperatureList DrxStatus::_RotationMotorTemps;
DrxStatus::TemperatureList DrxStatus::_TiltMotorTemps;
DrxStatus::TemperatureList DrxStatus::_CmigitsTemps;
DrxStatus::TemperatureList DrxStatus::_TailconeTemps;


DrxStatus::DrxStatus() :
    _detectedRfPower(-99.9),
    _pvAftPressure(-99.9),
    _pvForePressure(-99.9),
    _ploTemp(-99.9),
    _eikTemp(-99.9),
    _vLnaTemp(-99.9),
    _hLnaTemp(-99.9),
    _polarizationSwitchTemp(-99.9),
    _rfDetectorTemp(-99.9),
    _noiseSourceTemp(-99.9),
    _ps28VTemp(-99.9),
    _rdsInDuctTemp(-99.9),
    _rotationMotorTemp(-99.9),
    _tiltMotorTemp(-99.9),
    _cmigitsTemp(-99.9),
    _tailconeTemp(-99.9),
    _psVoltage(-99.9),
    _noiseSourceSelected(false),
    _terminationSelected(false),
    _locked15_5GHzPLO(false),
    _locked1250MHzPLO(false),
    _modPulseDisabled(false),
    _rdsXmitterFilamentOn(false),
    _rdsXmitterHvOn(false),
    _hmcStatus(0),
    _pentekFpgaTemp(-99.9),
    _pentekBoardTemp(-99.9) {
}

DrxStatus::DrxStatus(const Pentek::p7142 & pentek) {
    _getMultiIoValues();
    _getPentekValues(pentek);
}

DrxStatus::DrxStatus(XmlRpcValue & statusDict) throw(ConstructError) {
    _detectedRfPower = _StatusDouble(statusDict, "detectedRfPower");
    _pvForePressure = _StatusDouble(statusDict, "pvForePressure");
    _pvAftPressure = _StatusDouble(statusDict, "pvAftPressure");
    _ploTemp = _StatusDouble(statusDict, "ploTemp");
    _eikTemp = _StatusDouble(statusDict, "eikTemp");
    _vLnaTemp = _StatusDouble(statusDict, "vLnaTemp");
    _hLnaTemp = _StatusDouble(statusDict, "hLnaTemp");
    _polarizationSwitchTemp = _StatusDouble(statusDict, "polarizationSwitchTemp");
    _rfDetectorTemp = _StatusDouble(statusDict, "rfDetectorTemp");
    _noiseSourceTemp = _StatusDouble(statusDict, "noiseSourceTemp");
    _ps28VTemp = _StatusDouble(statusDict, "ps28VTemp");
    _rdsInDuctTemp = _StatusDouble(statusDict, "rdsInDuctTemp");
    _rotationMotorTemp = _StatusDouble(statusDict, "rotationMotorTemp");
    _tiltMotorTemp = _StatusDouble(statusDict, "tiltMotorTemp");
    _cmigitsTemp = _StatusDouble(statusDict, "cmigitsTemp");
    _tailconeTemp = _StatusDouble(statusDict, "tailconeTemp");
    _psVoltage = _StatusDouble(statusDict, "psVoltage");
    _pentekFpgaTemp = _StatusDouble(statusDict, "pentekFpgaTemp");
    _pentekBoardTemp = _StatusDouble(statusDict, "pentekBoardTemp");
    _noiseSourceSelected = _StatusBool(statusDict, "noiseSourceSelected");
    _terminationSelected = _StatusBool(statusDict, "terminationSelected");
    _locked15_5GHzPLO = _StatusBool(statusDict, "locked15_5GHzPLO");
    _locked1250MHzPLO = _StatusBool(statusDict, "locked1250MHzPLO");
    _modPulseDisabled = _StatusBool(statusDict, "modPulseDisabled");
    _hmcStatus = _StatusInt(statusDict, "hmcStatus");
    // Get the state of the RDS (Remote Data System) control lines going
    // to the transmitter.
    _rdsXmitterFilamentOn = _StatusBool(statusDict, "rdsXmitterFilamentOn");
    _rdsXmitterHvOn = _StatusBool(statusDict, "rdsXmitterHvOn");
}

DrxStatus::~DrxStatus() {
}

XmlRpcValue
DrxStatus::toXmlRpcValue() const {
    XmlRpcValue statusDict;

    statusDict["detectedRfPower"] = XmlRpcValue(_detectedRfPower);
    statusDict["pvForePressure"] = XmlRpcValue(_pvForePressure);
    statusDict["pvAftPressure"] = XmlRpcValue(_pvAftPressure);
    statusDict["ploTemp"] = XmlRpcValue(_ploTemp);
    statusDict["eikTemp"] = XmlRpcValue(_eikTemp);
    statusDict["vLnaTemp"] = XmlRpcValue(_vLnaTemp);
    statusDict["hLnaTemp"] = XmlRpcValue(_hLnaTemp);
    statusDict["polarizationSwitchTemp"] = XmlRpcValue(_polarizationSwitchTemp);
    statusDict["rfDetectorTemp"] = XmlRpcValue(_rfDetectorTemp);
    statusDict["noiseSourceTemp"] = XmlRpcValue(_noiseSourceTemp);
    statusDict["ps28VTemp"] = XmlRpcValue(_ps28VTemp);
    statusDict["rdsInDuctTemp"] = XmlRpcValue(_rdsInDuctTemp);
    statusDict["rotationMotorTemp"] = XmlRpcValue(_rotationMotorTemp);
    statusDict["tiltMotorTemp"] = XmlRpcValue(_tiltMotorTemp);
    statusDict["cmigitsTemp"] = XmlRpcValue(_cmigitsTemp);
    statusDict["tailconeTemp"] = XmlRpcValue(_tailconeTemp);
    statusDict["psVoltage"] = XmlRpcValue(_psVoltage);
    statusDict["pentekFpgaTemp"] = XmlRpcValue(_pentekFpgaTemp);
    statusDict["pentekBoardTemp"] = XmlRpcValue(_pentekBoardTemp);
    statusDict["noiseSourceSelected"] = XmlRpcValue(_noiseSourceSelected);
    statusDict["terminationSelected"] = XmlRpcValue(_terminationSelected);
    statusDict["locked15_5GHzPLO"] = XmlRpcValue(_locked15_5GHzPLO);
    statusDict["locked1250MHzPLO"] = XmlRpcValue(_locked1250MHzPLO);
    statusDict["modPulseDisabled"] = XmlRpcValue(_modPulseDisabled);
    statusDict["hmcStatus"] = XmlRpcValue(_hmcStatus);
    // Get the state of the RDS (Remote Data System) control lines going
    // to the transmitter.
    statusDict["rdsXmitterFilamentOn"] = XmlRpcValue(_rdsXmitterFilamentOn);
    statusDict["rdsXmitterHvOn"] = XmlRpcValue(_rdsXmitterHvOn);

    return(statusDict);
}

/*
 * Map from Pt1000 resistance to temperature, generated on the first call to
 * _pt1000Temperature()
 */
static std::map<double, double>  Pt1000_OhmsToTempMap;
static double Pt1000MapMinOhms;
static double Pt1000MapMaxOhms;

double
DrxStatus::_Pt1000Temperature(double psVolts, double pulldownVolts) {
    // All of our Pt1000 temperature sensor pulldown resistors are 1000 ohms.
    const double PulldownOhms = 1000;

    // Build the resistance->temperature map the first time we come here.
    // The map is just a table of resistances calculated every 1 degree
    // C from -50 to 200 deg C. The formula is the Callendar-Van Dusen
    // equation, using the standard Pt1000 values for A, B, and C.
    if (Pt1000_OhmsToTempMap.empty()) {
        double R0 = 1000;   // 1000 ohms for Pt1000
        double A = 3.9083e-3;   // deg C^-1
        double B = -5.775e-7;   // deg C^-2
        double C = -4.183e-12;  // deg C^-4
        double TMin = -50.0;
        double TMax = 200.0;
        for (double t = TMin; t <= TMax; t += 1.0) {
            double r = R0 * (1 + (A * t) + (B * t * t));
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
    double rtdOhms = PulldownOhms * (psVolts / pulldownVolts - 1);

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
    std::map<double, double>::iterator itLower =
        Pt1000_OhmsToTempMap.lower_bound(rtdOhms);
    std::map<double, double>::iterator itUpper = itLower++;
    // Interpolate between the two values to get our temperature.
    double r0 = itLower->first;
    double t0 = itLower->second;
    double r1 = itUpper->first;
    double t1 = itUpper->second;
    return(t0 + (rtdOhms - r0) / (r1 - r0) * (t1 - t0));
}

double
DrxStatus::_15PSI_A_4V_Pres(double sensorVolts) {
    // Nominal calibration from device spec: 0.25 V @ zero pressure
    const double zeroPresOffsetVolts = 0.25;
    // Nominal calibration from device spec: 4 V output span over 15 PSI
    // (1034.2 hPa)
    const double hPaPerVolt = 1034.2 / 4.0;
    return(hPaPerVolt * (sensorVolts - zeroPresOffsetVolts));
}

void
DrxStatus::_getMultiIoValues() {
    HcrPmc730 & pmc730 = HcrPmc730::theHcrPmc730();

    // Get data from analog channels 0-16 on the PMC-730 multi-IO card
    std::vector<float> analogData = pmc730.readAnalogChannels(0, 16);

    // Get the power supply voltage from channel 16 now, since we need if to
    // calculate temperatures below.
    _psVoltage = analogData[16];

    // Detected RF power
    _detectedRfPower = _LookupMiWv950WPower(analogData[0]);

    // Pressure sensors are on analog channels 1 and 2
    _pvAftPressure = _15PSI_A_4V_Pres(analogData[1]);
    _pvForePressure = _15PSI_A_4V_Pres(analogData[2]);

    // Channels 3-15 gives us various temperatures. The data are a bit noisy, so
    // we keep up to TemperatureList::_MAX_SIZE samples so we can generate moving
    // averages.
    _PloTemps.addTemperature(_Pt1000Temperature(_psVoltage, analogData[3]));
    _EikTemps.addTemperature(_Pt1000Temperature(_psVoltage, analogData[4]));
    _VLnaTemps.addTemperature(_Pt1000Temperature(_psVoltage, analogData[5]));
    _HLnaTemps.addTemperature(_Pt1000Temperature(_psVoltage, analogData[6]));
    _PolarizationSwitchTemps.addTemperature(_Pt1000Temperature(_psVoltage, analogData[7]));
    _RfDetectorTemps.addTemperature(_Pt1000Temperature(_psVoltage, analogData[8]));
    _NoiseSourceTemps.addTemperature(_Pt1000Temperature(_psVoltage, analogData[9]));
    _Ps28VTemps.addTemperature(_Pt1000Temperature(_psVoltage, analogData[10]));
    _RdsInDuctTemps.addTemperature(_Pt1000Temperature(_psVoltage, analogData[11]));
    _RotationMotorTemps.addTemperature(_Pt1000Temperature(_psVoltage, analogData[12]));
    _TiltMotorTemps.addTemperature(_Pt1000Temperature(_psVoltage, analogData[13]));
    _CmigitsTemps.addTemperature(_Pt1000Temperature(_psVoltage, analogData[14]));
    _TailconeTemps.addTemperature(_Pt1000Temperature(_psVoltage, analogData[15]));

    // Save the current averaged temperatures
    _ploTemp = _PloTemps.mean();
    _eikTemp = _EikTemps.mean();
    _vLnaTemp = _VLnaTemps.mean();
    _hLnaTemp = _HLnaTemps.mean();
    _polarizationSwitchTemp = _PolarizationSwitchTemps.mean();
    _rfDetectorTemp = _RfDetectorTemps.mean();
    _noiseSourceTemp = _NoiseSourceTemps.mean();
    _ps28VTemp = _Ps28VTemps.mean();
    _rdsInDuctTemp = _RdsInDuctTemps.mean();
    _rotationMotorTemp = _RotationMotorTemps.mean();
    _tiltMotorTemp = _TiltMotorTemps.mean();
    _cmigitsTemp = _CmigitsTemps.mean();
    _tailconeTemp = _TailconeTemps.mean();

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

double
DrxStatus::_LookupMiWv950WPower(double voltage) {
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
        double powerLow = MiWv950W_Cal[i][0];
        double vLow = MiWv950W_Cal[i][1];
        double powerHigh = MiWv950W_Cal[i + 1][0];
        double vHigh = MiWv950W_Cal[i + 1][1];
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

void
DrxStatus::_getPentekValues(const Pentek::p7142 & pentek) {
    _pentekFpgaTemp = pentek.fpgaTemp();
    _pentekBoardTemp = pentek.circuitBoardTemp();
}

bool
DrxStatus::_StatusBool(XmlRpc::XmlRpcValue & statusDict,
        std::string key) throw(ConstructError) {
    if (! statusDict.hasMember(key)) {
        ELOG << "Status dictionary does not contain requested key '" << key <<
            "'!";
        abort();
    } else {
        return(bool(statusDict[key]));
    }
}

int
DrxStatus::_StatusInt(XmlRpc::XmlRpcValue & statusDict,
        std::string key) throw(ConstructError) {
    if (! statusDict.hasMember(key)) {
        ELOG << "Status dictionary does not contain requested key '" << key <<
            "'!";
        abort();
    } else {
        return(int(statusDict[key]));
    }
}

double
DrxStatus::_StatusDouble(XmlRpc::XmlRpcValue & statusDict,
        std::string key) throw(ConstructError) {
    if (! statusDict.hasMember(key)) {
        ELOG << "Status dictionary does not contain requested key '" << key <<
            "'!";
        abort();
    } else {
        return(double(statusDict[key]));
    }
}
