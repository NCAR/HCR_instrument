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
 * HcrPmc730.cpp
 *
 *  Created on: Dec 17, 2010
 *      Author: burghart
 */

#include "HcrPmc730.h"
#include <sys/time.h>
/*
 * We need direct access to some of the PMC-730 functions provided by
 * Acromag's API.
 */
extern "C" {
#  include "Acromag/pmccommon/pmcmulticommon.h"
#  include "Acromag/pmc730/pmc730.h"
}


#include <logx/Logging.h>

LOGGING("HcrPmc730");

// Static to tell whether the singleton is created as a simulated PMC-730
bool HcrPmc730::_DoSimulate = false;

// Our singleton instance
HcrPmc730 * HcrPmc730::_TheHcrPmc730 = 0;

HcrPmc730::HcrPmc730() :
        Pmc730(_DoSimulate ? -1 : 0),
        _analogValues(),
        _pvPresCorrection(0.0) {
    // For HCR, DIO lines 0-7 are used for input, 8-15 for output
    setDioDirection0_7(DIO_INPUT);
    setDioDirection8_15(DIO_OUTPUT);
    // Verify that our defined input DIO lines are all actually set for input
    if (getDioDirection(_HCR_DIN_UNUSED_0) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_UNUSED_1) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_EMS_ERROR_EVENT) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_UNUSED_3) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_UNUSED_4) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_SPARE_PENTEK_1) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_SPARE_PENTEK_0) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_HMC_MODPULSE_DISABLED) != DIO_INPUT) {
        ELOG << __PRETTY_FUNCTION__ << ": Hcr PMC-730 DIO lines " <<
                _HCR_DIN_UNUSED_0 << ", " <<
                _HCR_DIN_UNUSED_1 << ", " <<
                _HCR_DIN_EMS_ERROR_EVENT << ", " <<
                _HCR_DIN_UNUSED_3 << ", " <<
                _HCR_DIN_UNUSED_4 << ", " <<
                _HCR_DIN_SPARE_PENTEK_1 << ", " <<
                _HCR_DIN_SPARE_PENTEK_0 << ", and " <<
                _HCR_DIN_HMC_MODPULSE_DISABLED <<
                " are not all set for input!";
        abort();
    }
    // Verify that our defined output DIO lines are all actually set for output
    if (getDioDirection(_HCR_DOUT_APS_PRES_ENABLE) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_HMC_STATUS_ACK) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_HMC_OPS_MODE_BIT2) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_TX_FILAMENT_OFF) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_HMC_OPS_MODE_BIT0) != DIO_OUTPUT ||
            getDioDirection( _HCR_DOUT_TX_HV_OFF) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_HMC_OPS_MODE_BIT1) != DIO_OUTPUT) {
        ELOG << __PRETTY_FUNCTION__ << ": Hcr PMC-730 DIO lines " <<
                _HCR_DOUT_APS_PRES_ENABLE << ", " <<
                _HCR_DOUT_HMC_STATUS_ACK << ", " <<
                _HCR_DOUT_HMC_OPS_MODE_BIT2 << ", " <<
                _HCR_DOUT_TX_FILAMENT_OFF << ", " <<
                _HCR_DOUT_HMC_OPS_MODE_BIT0 << ", " <<
                _HCR_DOUT_TX_HV_OFF << ", and " <<
                _HCR_DOUT_HMC_OPS_MODE_BIT1 << " are not all set for output!";
        abort();
    }
    // Initialize the PMC730's event counter (DIO channel 2), which is used to
    // count pulses with EMS errors.
    _initEventCounter();
}

HcrPmc730::~HcrPmc730() {
}

void
HcrPmc730::DoSimulate(bool simulate) {
    if (_TheHcrPmc730) {
        ELOG << __PRETTY_FUNCTION__ <<
            " has no effect after the HcrPmc730 has been created!";
        return;
    }
    DLOG << "Singleton HcrPmc730 will be created with simulate set to " <<
        (simulate ? "TRUE" : "FALSE");
    _DoSimulate = simulate;
}

HcrPmc730 &
HcrPmc730::TheHcrPmc730() {
    if (! _TheHcrPmc730) {
        _TheHcrPmc730 = new HcrPmc730();
    }
    return(*_TheHcrPmc730);
}

// static
void
HcrPmc730::SetHmcMode(const HmcMode& mode) {
    // Set the HMC mode bits on our digital out lines. This method works
    // atomically, setting all three bits at once rather than changing one
    // at a time.

    // As written, this only works if the output lines we're setting are in
    // the range 8-15!
    assert(_HCR_DOUT_HMC_OPS_MODE_BIT0 >=8 && _HCR_DOUT_HMC_OPS_MODE_BIT0 <= 15 &&
            _HCR_DOUT_HMC_OPS_MODE_BIT1 >= 8 && _HCR_DOUT_HMC_OPS_MODE_BIT1 <= 15 &&
            _HCR_DOUT_HMC_OPS_MODE_BIT2 >= 8 && _HCR_DOUT_HMC_OPS_MODE_BIT2 <= 15);

    // start from the current state of lines 8-15
    uint8_t new8_15 = TheHcrPmc730().getDio8_15();

    // set the bits for the three lines which set the mode
    uint8_t modeBit0 = (mode >> 0) & 0x01;
    new8_15 = modeBit0 ?
            _TurnBitOn(new8_15, _HCR_DOUT_HMC_OPS_MODE_BIT0 - 8) :
            _TurnBitOff(new8_15, _HCR_DOUT_HMC_OPS_MODE_BIT0 - 8);

    uint8_t modeBit1 = (mode >> 1) & 0x01;
    new8_15 = modeBit1 ?
            _TurnBitOn(new8_15, _HCR_DOUT_HMC_OPS_MODE_BIT1 - 8) :
            _TurnBitOff(new8_15, _HCR_DOUT_HMC_OPS_MODE_BIT1 - 8);

    uint8_t modeBit2 = (mode >> 2) & 0x01;
    new8_15 = modeBit2 ?
            _TurnBitOn(new8_15, _HCR_DOUT_HMC_OPS_MODE_BIT2 - 8) :
            _TurnBitOff(new8_15, _HCR_DOUT_HMC_OPS_MODE_BIT2 - 8);

    // ship out the new state
    TheHcrPmc730().setDio8_15(new8_15);
}

bool
HcrPmc730::Locked15_5GHzPLO() {
    try {
        return(TheHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_15_5_GHZ_LOCKED));
    } catch (BadTtlVoltage & e) {
        ELOG << e.what();
        return false;
    }
}

bool
HcrPmc730::Locked1250MHzPLO() {
    try {
        return(TheHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_1250_MHZ_LOCKED));
    } catch (BadTtlVoltage & e) {
        ELOG << e.what();
        return false;
    }
}

bool
HcrPmc730::Locked125MHzPLO() {
    try {
        return(TheHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_125_MHZ_LOCKED));
    } catch (BadTtlVoltage & e) {
        ELOG << e.what();
        return false;
    }
}

bool
HcrPmc730::EmsPowerError() {
    try {
        return(TheHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_EMS_PWR_ERROR));
    } catch (BadTtlVoltage & e) {
        ELOG << e.what();
        return true;
    }
}

bool
HcrPmc730::RadarPowerError() {
    try {
        return(TheHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_RADAR_PWR_ERROR));
    } catch (BadTtlVoltage & e) {
        ELOG << e.what();
        return true;
    }
}

bool
HcrPmc730::WaveguideSwitchError() {
    try {
        return(TheHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_WG_SWITCH_ERROR));
    } catch (BadTtlVoltage & e) {
        ELOG << e.what();
        return true;
    }
}

bool
HcrPmc730::EmsError1() {
    try {
        return(TheHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_EMS_ERROR_1));
    } catch (BadTtlVoltage & e) {
        ELOG << e.what();
        return true;
    }
}

bool
HcrPmc730::EmsError2() {
    try {
        return(TheHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_EMS_ERROR_2));
    } catch (BadTtlVoltage & e) {
        ELOG << e.what();
        return true;
    }
}

bool
HcrPmc730::EmsError3() {
    try {
        return(TheHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_EMS_ERROR_3));
    } catch (BadTtlVoltage & e) {
        ELOG << e.what();
        return true;
    }
}

bool
HcrPmc730::EmsError4Or5() {
    try {
        return(TheHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_EMS_ERROR_4OR5));
    } catch (BadTtlVoltage & e) {
        ELOG << e.what();
        return true;
    }
}


bool
HcrPmc730::EmsError6Or7() {
    try {
        return(TheHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_EMS_ERROR_6OR7));
    } catch (BadTtlVoltage & e) {
        ELOG << e.what();
        return true;
    }
}

int
HcrPmc730::_ttlBinaryForChannel(int channel) {
    float voltage = _analogValues[channel];
    if (voltage < 0.8) {
        return 0;
    } else if (voltage > 2.0) {
        return 1;
    } else {
        std::ostringstream ss;
        ss << "Bad TTL digital logic voltage " << voltage << " V on channel " <<
                channel;
        throw BadTtlVoltage(ss.str());
    }
}

double
HcrPmc730::_MiWv950WPower(double voltage) {
    // The HCR breakout board provides a factor of 2 gain on the voltage
    // coming from the detector before sending the signal on to the PMC-730.
    // Remove that gain now.
    double detectorVoltage = 0.5 * voltage;

    // Apply the calibration formula supplied by Pei 8/23/2013
    return(10.0 * log10(detectorVoltage + 0.007));
}

double
HcrPmc730::_MillitechDET10Power(double voltage) {
    // Detector calibration lookup table (measured 20140813)
    // Note that this table must be sorted from lowest voltage to highest.
    typedef struct {
        double volts;
        double dBm;
    } TablePoint;
    static const TablePoint CalTable[] = {
            //    V,   dBm
            { 0.195, -4.25 },
            { 0.241, -3.25 },
            { 0.290, -2.25 },
            { 0.344, -1.25 },
            { 0.401, -0.25 },
            { 0.461,  0.75 },
            { 0.531,  1.75 },
            { 0.601,  2.75 },
            { 0.684,  3.75 },
            { 0.764,  4.75 }
    };
    static const int CalTableLen = sizeof(CalTable) / sizeof(*CalTable);

    // Figure out the table indices bounding the incoming voltage. If the
    // voltage is outside the calibrated range, we set indices to extrapolate
    // using the closest two points.
    int indexLow = 0;
    while ((indexLow < CalTableLen - 1) &&
            (voltage > CalTable[indexLow + 1].volts)) {
        indexLow++;
    }

    // Interpolate (or extrapolate) using closest two points from the table.
    double x0 = CalTable[indexLow].volts;
    double y0 = CalTable[indexLow].dBm;
    double x1 = CalTable[indexLow + 1].volts;
    double y1 = CalTable[indexLow + 1].dBm;
    double slope = (y1 - y0) / (x1 - x0);
    double intercept = y0 - x0 * slope;

    return((slope * voltage) + intercept);
}

/*
 * Map from Pt1000 resistance to temperature, generated on the first call to
 * _Pt1000Temperature()
 */
static std::map<double, double>  Pt1000_OhmsToTempMap;
static double Pt1000MapMinOhms;
static double Pt1000MapMaxOhms;

double
HcrPmc730::_Pt1000Temperature(double psVolts, double pulldownVolts) {
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
HcrPmc730::_15PSI_A_4V_Pres(double sensorVolts) {
    // Nominal calibration from device spec: 0.25 V @ zero pressure
    const double zeroPresOffsetVolts = 0.25;
    // Nominal calibration from device spec: 4 V output span over 15 PSI
    // (1034.2 hPa)
    const double hPaPerVolt = 1034.2 / 4.0;
    return(hPaPerVolt * (sensorVolts - zeroPresOffsetVolts));
}

double
HcrPmc730::_30PSI_A_4V_Pres(double sensorVolts) {
    // Nominal calibration from device spec: 0.25 V @ zero pressure
    const double zeroPresOffsetVolts = 0.25;
    // Nominal calibration from device spec: 4 V output span over 30 PSI
    // (2068.4 hPa)
    const double hPaPerVolt = 2068.4 / 4.0;
    return(hPaPerVolt * (sensorVolts - zeroPresOffsetVolts));
}

double
HcrPmc730::_Honeywell_030PA_Pres(double sensorVolts) {
    // Actual sensor supply voltage
    const double v_in = Ps5vVoltage();

    // Nominal from device spec: 0.1 * V_in @ zero pressure
    const double zeroPresOffsetVolts = 0.1 * v_in;

    // Nominal from device spec: 0.8 * V_in output span over 30 PSI
    const double psiPerVolt = 30 / (0.8 * v_in);
    return(PsiToHpa(psiPerVolt * (sensorVolts - zeroPresOffsetVolts)));
}

/**
 * @brief Briefly raise the HMC's 'status_ack' line to reset its sense-and-hold
 * values.
 */
void
HcrPmc730::_ackHmcStatus() {
    if (_simulate)
        return;

    setDioLine(_HCR_DOUT_HMC_STATUS_ACK, 1);
    usleep(1);
    setDioLine(_HCR_DOUT_HMC_STATUS_ACK, 0);
}

void
HcrPmc730::_initEventCounter() {
    if (_simulate)
        return;

    // Initialize the PMC730 counter/timer for:
    // - pulse counting
    // - input polarity high
    // - software trigger to start counting
    // - disable counter interrupts

    // set up as an event (pulse) counter
    if (SetMode(&_card, InEvent) != Success) {
        ELOG << __PRETTY_FUNCTION__ << ": setting PMC730 to count pulses";
        abort();
    }
    // set input polarity to high
    if (SetInputPolarity(&_card, InPolHi) != Success) {
        ELOG << __PRETTY_FUNCTION__ << ": setting PMC730 input pulse polarity";
        abort();
    }
    // Use internal (software) trigger to start the timer
    if (SetTriggerSource(&_card, InTrig) != Success) {
        ELOG << __PRETTY_FUNCTION__ << ": setting trigger source";
        abort();
    }
    // disable counter/timer interrupts
    if (SetInterruptEnable(&_card, IntDisable) != Success) {
        ELOG << __PRETTY_FUNCTION__ << ": disabling PMC730 counter/timer interrupts";
        abort();
    }
    // Set counter constant 0 (maximum count value) to 2^32-1, so we can count
    // up to the full 32 bits. This must be non-zero, or you'll never see any
    // pulses counted!
    if (SetCounterConstant(&_card, 0, 0xFFFFFFFFul) != Success) {
        ELOG << __PRETTY_FUNCTION__ << ": setting counter constant 0";
        abort();
    }
    // Now enable this configuration.
    ConfigureCounterTimer(&_card);

    // Send the software trigger to start the counter.
    StartCounter(&_card);
}

uint32_t
HcrPmc730::_emsErrorCount() const {
    // If simulating, just return the second of the hour as the error count
    if (_simulate) {
        return(uint32_t(time(0) % 3600));
    }

    // Get the current event count from the counter readback register.
    int32_t signedCount = input_long(_card.nHandle,
        (long*)&_card.brd_ptr->CounterReadBack);

    // We got a *signed* 32-bit value from input_long, but the real value is
    // actually *unsigned*. Reinterpret the result to get the full
    // (unsigned) resolution.
    uint32_t emsErrorCount = *(reinterpret_cast<uint32_t*>(&signedCount));
    return(emsErrorCount);
}

void
HcrPmc730::_setPvPresCorrectionPsi(double pvPresCorrectionPsi) {
    _pvPresCorrection = PsiToHpa(pvPresCorrectionPsi);
    ILOG << "Pressure vessel pressure correction of " << pvPresCorrectionPsi <<
            " PSI (" << _pvPresCorrection << " hPa) will be applied";
}
