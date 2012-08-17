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
    if (getDioDirection(_HCR_DIN_WG_SWITCH_A) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_WG_SWITCH_B) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_15_5GHZ_PHASELOCK) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_1250MHZ_PHASELOCK) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_HMC_STATUS0) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_HMC_STATUS1) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_HMC_MODPULSE_DISABLED) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_HMC_STATUS2) != DIO_INPUT) {
        ELOG << __PRETTY_FUNCTION__ << ": Hcr PMC-730 DIO lines " <<
            _HCR_DIN_WG_SWITCH_A << ", " << _HCR_DIN_WG_SWITCH_B << ", " << 
            _HCR_DIN_15_5GHZ_PHASELOCK << ", " << 
            _HCR_DIN_1250MHZ_PHASELOCK << ", " <<
            _HCR_DIN_HMC_STATUS0 << ", " << _HCR_DIN_HMC_STATUS1 << ", " <<
            _HCR_DIN_HMC_MODPULSE_DISABLED << ", and " << _HCR_DIN_HMC_STATUS2 <<
            " are not all set for input!";
        abort();
    }
    // Verify that our defined output DIO lines are all actually set for output
    if (getDioDirection(_HCR_DOUT_NOISE_SRC_ON) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_WG_SWITCH_D) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_HMC_RESET) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_WG_SWITCH_C) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_TX_FILAMENT_OFF) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_HMC_OPS_MODE_BIT0) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_TX_HV_OFF) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_HMC_OPS_MODE_BIT1) != DIO_OUTPUT) {
        ELOG << __PRETTY_FUNCTION__ << ": Hcr PMC-730 DIO lines " <<
            _HCR_DOUT_NOISE_SRC_ON << ", " << _HCR_DOUT_HMC_RESET << ", " <<
            _HCR_DOUT_WG_SWITCH_D << ", " << _HCR_DOUT_WG_SWITCH_C << ", " <<
            _HCR_DOUT_TX_FILAMENT_OFF << ", " <<
            _HCR_DOUT_HMC_OPS_MODE_BIT0 << ", " <<
            _HCR_DOUT_TX_HV_OFF << ", and " << _HCR_DOUT_HMC_OPS_MODE_BIT1 <<
            " are not all set for output!";
        abort();
    }
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
            _HCR_DOUT_HMC_OPS_MODE_BIT1 >= 8 && _HCR_DOUT_HMC_OPS_MODE_BIT1 <= 15);

    // start from the current state of lines 8-15
    uint8_t new8_15 = theHcrPmc730().getDio8_15();

    // set the bits for the two lines we care about
    uint8_t modeBit0 = (mode >> 0) & 0x01;
    new8_15 = modeBit0 ?
            _turnBitOn(new8_15, _HCR_DOUT_HMC_OPS_MODE_BIT0 - 8) :
            _turnBitOff(new8_15, _HCR_DOUT_HMC_OPS_MODE_BIT0 - 8);

    uint8_t modeBit1 = (mode >> 1) & 0x01;
    new8_15 = modeBit1 ?
            _turnBitOn(new8_15, _HCR_DOUT_HMC_OPS_MODE_BIT1 - 8) :
            _turnBitOff(new8_15, _HCR_DOUT_HMC_OPS_MODE_BIT1 - 8);

    // ship out the new state
    theHcrPmc730().setDio8_15(new8_15);
}
