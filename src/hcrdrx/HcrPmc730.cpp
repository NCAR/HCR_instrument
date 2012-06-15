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
	// Get the time of day of instantiation (in seconds). This allows us to
    // return a reasonable pulse count if we're simulating.
	struct timeval startTv;
	gettimeofday(&startTv, NULL);
	_startTimeOfDay = startTv.tv_sec + 1.0e-6 * startTv.tv_usec;

    // For HCR, DIO lines 0-7 are used for input, 8-15 for output
    setDioDirection0_7(DIO_INPUT);
    setDioDirection8_15(DIO_OUTPUT);
    // Verify that our defined input DIO lines are all actually set for input
    if (getDioDirection(_HCR_DIN_UNUSED0) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_UNUSED1) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_UNUSED2) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_UNUSED3) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_SCM_STATUS0) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_SCM_STATUS1) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_SCM_STATUS2) != DIO_INPUT ||
            getDioDirection(_HCR_DIN_SCM_STATUS3) != DIO_INPUT) {
        ELOG << __PRETTY_FUNCTION__ << ": Hcr PMC-730 DIO lines " <<
                _HCR_DIN_UNUSED0 << ", " << _HCR_DIN_UNUSED1 << ", " << 
                _HCR_DIN_UNUSED2 << ", " << _HCR_DIN_UNUSED3 << ", " <<
                _HCR_DIN_SCM_STATUS0 << ", " << _HCR_DIN_SCM_STATUS1 << ", " <<
                _HCR_DIN_SCM_STATUS2 << ", and " << _HCR_DIN_SCM_STATUS3 <<
                " are not all set for input!";
        abort();
    }
    // Verify that our defined output DIO lines are all actually set for output
    if (getDioDirection(_HCR_DOUT_NOISE_SRC_ON) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_SCM_RESET) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_WG_SWITCH_D) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_WG_SWITCH_C) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_TX_FILAMENT_ON_P) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_TX_FILAMENT_ON_N) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_TX_HV_ON_P) != DIO_OUTPUT ||
            getDioDirection(_HCR_DOUT_TX_HV_ON_N) != DIO_OUTPUT) {
        ELOG << __PRETTY_FUNCTION__ << ": Hcr PMC-730 DIO lines " <<
                _HCR_DOUT_NOISE_SRC_ON << ", " << _HCR_DOUT_SCM_RESET << ", " <<
                _HCR_DOUT_WG_SWITCH_D << ", " << _HCR_DOUT_WG_SWITCH_C << ", " <<
                _HCR_DOUT_TX_FILAMENT_ON_P << ", " << 
                _HCR_DOUT_TX_FILAMENT_ON_N << ", " <<
                _HCR_DOUT_TX_HV_ON_P << ", and " << _HCR_DOUT_TX_HV_ON_N << 
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

void
HcrPmc730::_sendDifferentialSignal(bool signalHigh, DoutLine_t dioPosLine,
        DoutLine_t dioNegLine) {
    // as written, this only works for DIO lines in the range 8-15!
    assert(dioPosLine >=8 && dioPosLine <= 15 &&
            dioNegLine >= 8 && dioNegLine <= 15);
    // start from the current state of lines 8-15
    uint8_t new8_15 = getDio8_15();
    // change the two lines we care about
    if (signalHigh) {
        new8_15 = _turnBitOn(new8_15, dioPosLine - 8);
        new8_15 = _turnBitOff(new8_15, dioNegLine - 8);
    } else {
        new8_15 = _turnBitOff(new8_15, dioPosLine - 8);
        new8_15 = _turnBitOn(new8_15, dioNegLine - 8);
    }
    // ship out the new state
    setDio8_15(new8_15);
}
