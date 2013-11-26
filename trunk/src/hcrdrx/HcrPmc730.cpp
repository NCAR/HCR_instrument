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
#  include "pmccommon/pmcmulticommon.h"
#  include "pmc730/pmc730.h"
}


#include <logx/Logging.h>

LOGGING("HcrPmc730");

// Static to tell whether the singleton is created as a simulated PMC-730
bool HcrPmc730::_DoSimulate = false;

// Our singleton instance
HcrPmc730 * HcrPmc730::_theHcrPmc730 = 0;

HcrPmc730::HcrPmc730() : Pmc730(_DoSimulate ? -1 : 0) {
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
    if (getDioDirection(_HCR_DOUT_PENTEK_ZERO_TILT) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_PENTEK_ZERO_ROT) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_HMC_STATUS_ACK) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_HMC_OPS_MODE_BIT2) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_TX_FILAMENT_OFF) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_HMC_OPS_MODE_BIT0) != DIO_OUTPUT ||
            getDioDirection( _HCR_DOUT_TX_HV_OFF) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_HMC_OPS_MODE_BIT1) != DIO_OUTPUT) {
        ELOG << __PRETTY_FUNCTION__ << ": Hcr PMC-730 DIO lines " <<
                _HCR_DOUT_PENTEK_ZERO_TILT << ", " <<
                _HCR_DOUT_PENTEK_ZERO_ROT << ", " <<
                _HCR_DOUT_HMC_STATUS_ACK << ", " <<
                _HCR_DOUT_HMC_OPS_MODE_BIT2 << ", " <<
                _HCR_DOUT_TX_FILAMENT_OFF << ", " <<
                _HCR_DOUT_HMC_OPS_MODE_BIT0 << ", " <<
                _HCR_DOUT_TX_HV_OFF << ", and " << 
                _HCR_DOUT_HMC_OPS_MODE_BIT1 << " are not all set for output!";
        abort();
    }
    // Initialize the PMC730's event counter, which uses DIO channel 2
    _initEventCounter();
}

HcrPmc730::~HcrPmc730() {
}

void
HcrPmc730::doSimulate(bool simulate) {
	if (_theHcrPmc730) {
		ELOG << __PRETTY_FUNCTION__ <<
			" has no effect after the HcrPmc730 has been created!";
		return;
	}
	DLOG << "Singleton HcrPmc730 will be created with simulate set to " <<
		(simulate ? "TRUE" : "FALSE");
	_DoSimulate = simulate;
}

HcrPmc730 &
HcrPmc730::theHcrPmc730() {
    if (! _theHcrPmc730) {
        _theHcrPmc730 = new HcrPmc730();
    }
    return(*_theHcrPmc730);
}

// static
void
HcrPmc730::setHmcOperationMode(HmcOperationMode mode) {
    // Set the HMC mode bits on our digital out lines. This method works
    // atomically, setting both bits at once rather than changing one at a time.

    // As written, this only works if the output lines we're setting are in
    // the range 8-15!
    assert(_HCR_DOUT_HMC_OPS_MODE_BIT0 >=8 && _HCR_DOUT_HMC_OPS_MODE_BIT0 <= 15 &&
            _HCR_DOUT_HMC_OPS_MODE_BIT1 >= 8 && _HCR_DOUT_HMC_OPS_MODE_BIT1 <= 15 &&
            _HCR_DOUT_HMC_OPS_MODE_BIT2 >= 8 && _HCR_DOUT_HMC_OPS_MODE_BIT2 <= 15);

    // start from the current state of lines 8-15
    uint8_t new8_15 = theHcrPmc730().getDio8_15();

    // set the bits for the three lines which set the mode
    uint8_t modeBit0 = (mode >> 0) & 0x01;
    new8_15 = modeBit0 ?
            _turnBitOn(new8_15, _HCR_DOUT_HMC_OPS_MODE_BIT0 - 8) :
            _turnBitOff(new8_15, _HCR_DOUT_HMC_OPS_MODE_BIT0 - 8);

    uint8_t modeBit1 = (mode >> 1) & 0x01;
    new8_15 = modeBit1 ?
            _turnBitOn(new8_15, _HCR_DOUT_HMC_OPS_MODE_BIT1 - 8) :
            _turnBitOff(new8_15, _HCR_DOUT_HMC_OPS_MODE_BIT1 - 8);

    uint8_t modeBit2 = (mode >> 2) & 0x01;
    new8_15 = modeBit2 ?
            _turnBitOn(new8_15, _HCR_DOUT_HMC_OPS_MODE_BIT2 - 8) :
            _turnBitOff(new8_15, _HCR_DOUT_HMC_OPS_MODE_BIT2 - 8);

    // ship out the new state
    theHcrPmc730().setDio8_15(new8_15);
}

bool
HcrPmc730::locked15_5GHzPLO() {
	try {
    	return(theHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_15_5_GHZ_LOCKED));
	} catch (BadTtlVoltage & e) {
		ELOG << e.what();
		return false;
	}
}

bool
HcrPmc730::locked1250MHzPLO() {
	try {
    	return(theHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_1250_MHZ_LOCKED));
	} catch (BadTtlVoltage & e) {
		ELOG << e.what();
		return false;
	}
}

bool
HcrPmc730::locked125MHzPLO() {
	try {
    	return(theHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_125_MHZ_LOCKED));
	} catch (BadTtlVoltage & e) {
		ELOG << e.what();
		return false;
	}
}

bool
HcrPmc730::emsPowerError() {
	try {
    	return(theHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_EMS_PWR_ERROR));
	} catch (BadTtlVoltage & e) {
		ELOG << e.what();
		return true;
	}
}

bool
HcrPmc730::radarPowerError() {
	try {
    	return(theHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_RADAR_PWR_ERROR));
	} catch (BadTtlVoltage & e) {
		ELOG << e.what();
		return true;
	}
}

bool
HcrPmc730::waveguideSwitchError() {
	try {
    	return(theHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_WG_SWITCH_ERROR));
	} catch (BadTtlVoltage & e) {
		ELOG << e.what();
		return true;
	}
}

bool
HcrPmc730::emsError1() {
	try {
    	return(theHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_EMS_ERROR_1));
	} catch (BadTtlVoltage & e) {
		ELOG << e.what();
		return true;
	}
}

bool
HcrPmc730::emsError2() {
	try {
    	return(theHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_EMS_ERROR_2));
	} catch (BadTtlVoltage & e) {
		ELOG << e.what();
		return true;
	}
}

bool
HcrPmc730::emsError3() {
	try {
    	return(theHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_EMS_ERROR_3));
	} catch (BadTtlVoltage & e) {
		ELOG << e.what();
		return true;
	}
}

bool
HcrPmc730::emsError4Or5() {
	try {
    	return(theHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_EMS_ERROR_4OR5));
	} catch (BadTtlVoltage & e) {
		ELOG << e.what();
		return true;
	}
}


bool
HcrPmc730::emsError6Or7() {
	try {
    	return(theHcrPmc730()._ttlBinaryForChannel(_HCR_AIN_TTL_EMS_ERROR_6OR7));
	} catch (BadTtlVoltage & e) {
		ELOG << e.what();
		return true;
	}
}

int
HcrPmc730::_ttlBinaryForChannel(int channel) throw (BadTtlVoltage) {
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
    // Now enable this configuration and then start the counter.
    ConfigureCounterTimer(&_card);
    // Send the software trigger to start the counter.
    StartCounter(&_card);    
}

uint32_t
HcrPmc730::_emsErrorCount() const {
    // If simulating, just return the current second modulo 100, for a rolling
    // count from 0 to 99.
    if (_simulate) {
        return(uint32_t(time(0) % 100));
    }
    // Read the current count value from the counter readback register.
    int32_t signedCount = input_long(_card.nHandle, 
        (long*)&_card.brd_ptr->CounterReadBack);
    // We get a signed 32-bit value from input_long, but the counter readback
    // register is actually unsigned. Reinterpret the result to get the full
    // (unsigned) resolution.
    uint32_t* countPtr = reinterpret_cast<uint32_t*>(&signedCount);
    return(*countPtr);
}

void
HcrPmc730::_resetEmsErrorCount() {
    // Stop and restart the counter to reset the count.
    StopCounter(&_card);
    StartCounter(&_card);    
}
