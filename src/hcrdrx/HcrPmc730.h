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
    /** 
     * @brief Return a reference to HCR's singleton Pmc730 instance.
     * @return a reference to HCR's singleton Pmc730 instance.
     */
    static HcrPmc730 & theHcrPmc730();
    
    /**
     * @brief Static method to change whether the singleton instance will be created
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
        /// digital in line 0: waveguide switch A position
        _HCR_DIN_WG_SWITCH_A = 0,
        /// digital in line 1: waveguide switch B position
        _HCR_DIN_WG_SWITCH_B = 1,
        /// digital in line 2: 15.5 GHz PLO phase locked
        _HCR_DIN_15_5GHZ_PHASELOCK = 2,
        /// digital in line 3: 1250 MHz PLO phase locked
        _HCR_DIN_1250MHZ_PHASELOCK = 3,
        /// digital in line 4: HMC status bit 0
        _HCR_DIN_HMC_STATUS0 = 4,
        /// digital in line 5: HMC status bit 1
        _HCR_DIN_HMC_STATUS1 = 5,
        /// digital in line 6: HMC modulation pulse disabled
        _HCR_DIN_HMC_MODPULSE_DISABLED = 6,
        /// digital in line 7: unused
        _HCR_DIN_7_UNUSED = 7
    } DinLine_t;
    
    /**
     * Output DIO lines
     */
    typedef enum {
        /// digital out line 8: Turn on noise source
        _HCR_DOUT_NOISE_SRC_ON = 8,
        /// digital out line 9: SCM reset signal
        _HCR_DOUT_HMC_RESET = 9,
        /// digital out line 10: waveguide switch D control
        _HCR_DOUT_WG_SWITCH_D = 10,
        /// digital out line 11: waveguide switch C control
        _HCR_DOUT_WG_SWITCH_C = 11,
        /// digital out line 12: Turn on transmitter Klystron filament
        _HCR_DOUT_TX_FILAMENT_ON = 12,
        /// digital out line 13: HMC operation mode bit 0
        _HCR_DOUT_HMC_OPS_MODE_BIT0 = 13,
        /// digital out line 14: Turn on transmitter Klystron high voltage
        _HCR_DOUT_TX_HV_ON = 14,
        /// digital out line 15: HMC operation mode bit 1
        _HCR_DOUT_HMC_OPS_MODE_BIT1 = 15,
    } DoutLine_t;
    
    /**
     * @brief Set the selected bit in the source byte and return the result.
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
     * @brief Unset the selected bit in the source byte and return the result.
     * @param src the source byte
     * @param bitnum the number of the bit to unset; 0 for least significant bit
     * @return a byte copied from src, but with the selected bit unset
     */
    static uint8_t
    _turnBitOff(uint8_t src, unsigned int bitnum) {
        uint8_t mask = (1 << bitnum);
        return(src & ~mask);
    }
    
    /**
     * @brief The singleton instance of HcrPmc730.
     */
    static HcrPmc730 * _theHcrPmc730;
};

#endif /* HCRPMC730_H_ */
