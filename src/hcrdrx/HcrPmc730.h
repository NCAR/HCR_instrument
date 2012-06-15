/*
 * HcrPmc730.h
 *
 *  Copied from KaPmc730: Nov 4, 2011
 *      Author: burghart
 */

#ifndef HCRPMC730_H_
#define HCRPMC730_H_

#include "Pmc730.h"

/// Control a singleton instance of Pmc730 for the one PMC730 card on the
/// HCR DRX machine. 
class HcrPmc730 : public Pmc730 {
public:
    /// Return a reference to HCR's singleton Pmc730 instance.
    static HcrPmc730 & theHcrPmc730();
    
    /**
     * Static method to change whether the singleton instance will be created
     * as a simulated PMC-730. This must be called before the singleton is
     * instantiated.
     * @param simulate If true, the singleton will be created as a simulated
     * PMC-730.
     */
    static void doSimulate(bool simulate);

private:
    HcrPmc730();
    virtual ~HcrPmc730();

    /**
     * If _doSimulate is true when the singleton is instantiated, it will be
     * created as a simulated PMC-730.
     */
    static bool _DoSimulate;

    /**
     * Input DIO lines
     */
    typedef enum {
        /// DIO line 0 unused
        _HCR_DIN_UNUSED0 = 0,
        /// DIO line 1 unused
        _HCR_DIN_UNUSED1 = 1,
        /// DIO line 2 unused
        _HCR_DIN_UNUSED2 = 2,
        /// DIO line 3 unused
        _HCR_DIN_UNUSED3 = 3,
        /// SCM status bit 0
        _HCR_DIN_SCM_STATUS0 = 4,
        /// SCM status bit 1
        _HCR_DIN_SCM_STATUS1 = 5,
        /// SCM status bit 2
        _HCR_DIN_SCM_STATUS2 = 6,
        /// SCM status bit 3
        _HCR_DIN_SCM_STATUS3 = 7
    } DinLine_t;
    
    /**
     * Output DIO lines
     */
    typedef enum {
        /// Turn on noise source
        _HCR_DOUT_NOISE_SRC_ON = 8,
        /// SCM reset signal
        _HCR_DOUT_SCM_RESET = 9,
        /// waveguide switch 'D' control
        _HCR_DOUT_WG_SWITCH_D = 10,
        /// waveguide switch 'C' control
        _HCR_DOUT_WG_SWITCH_C = 11,
        /// Turn on transmitter Klystron filament (differential +)
        _HCR_DOUT_TX_FILAMENT_ON_P = 12,
        /// Turn on transmitter Klystron filament (differential -)
        _HCR_DOUT_TX_FILAMENT_ON_N = 13,
        /// Turn on transmitter Klystron high voltage (differential +)
        _HCR_DOUT_TX_HV_ON_P = 14,
        /// Turn on transmitter Klystron high voltage (differential -)
        _HCR_DOUT_TX_HV_ON_N = 15,
    } DoutLine_t;
    
    /**
     * Send a differential signal over two selected PMC730 DIO lines.
     * Line dioPosLine will get the positive signal, and line dioNegLine will
     * get the inverted signal.
     * @param signalHigh if true, a high signal will be sent, otherwise low
     * @param dioPosLine the output line for the positive signal
     * @param dioNegLine the output line for the inverted signal
     */
    void _sendDifferentialSignal(bool signalHigh, DoutLine_t dioPosLine,
            DoutLine_t dioNegLine);
    
    /**
     * Set the selected bit in the source byte and return the result.
     * @param src the source byte
     * @param bitnum the number of the bit to set; 0 for least significant bit
     * @return a byte copied from src, but with the selected bit set
     */
    static uint8_t 
    _turnBitOn(uint8_t src, unsigned int bitnum) {
        uint8_t mask = (1 << bitnum);
        return(src | mask);
    }

    /**
     * Unset the selected bit in the source byte and return the result.
     * @param src the source byte
     * @param bitnum the number of the bit to unset; 0 for least significant bit
     * @return a byte copied from src, but with the selected bit unset
     */
    static uint8_t
    _turnBitOff(uint8_t src, unsigned int bitnum) {
        uint8_t mask = (1 << bitnum);
        return(src & ~mask);
    }
    
    static HcrPmc730 * _theHcrPmc730;

    // Keep the time of day of instantiation (in seconds). This allows us to
    // return a reasonable pulse count if we're simulating.
    double _startTimeOfDay;
};

#endif /* HCRPMC730_H_ */
