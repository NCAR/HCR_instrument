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

    /**
     * @brief Is the waveguide switch selecting the noise source?
     * @return true iff the waveguide switch is selecting the noise source
     */
    static bool noiseSourceSelected() {
        return(theHcrPmc730().getDioLine(_HCR_DIN_NOISE_SOURCE_SELECTED));
    }

    /**
     * @brief Is the waveguide switch selecting termination?
     * @return true iff the waveguide switch is selecting termination
     */
    static bool terminationSelected() {
        return(theHcrPmc730().getDioLine(_HCR_DIN_TERMINATION_SELECTED));
    }

    /**
     * @brief Is the 15.5 GHz PLO locked?
     * @return true iff the 15.5 GHz PLO is locked
     */
    static bool locked15_5GHzPLO() {
        return(theHcrPmc730().getDioLine(_HCR_DIN_15_5GHZ_PHASELOCK));
    }

    /**
     * @brief Is the 1250 MHz PLO locked?
     * @return true iff the 1250 MHz PLO is locked
     */
    static bool locked1250MHzPLO() {
        return(theHcrPmc730().getDioLine(_HCR_DIN_1250MHZ_PHASELOCK));
    }

    /**
     * @brief Is the modulation pulse signal blocked at the HMC?
     * @return true iff the modulation pulse signal is blocked at the HMC
     */
    static bool modPulseDisabled() {
        return(theHcrPmc730().getDioLine(_HCR_DIN_HMC_MODPULSE_DISABLED));
    }

    /**
     * @brief Return the 3-bit status value from the HMC. Valid status values
     * are 0 = no errors, 1 = EMS power below threshold,
     * 2 = receiver protector switching error, 3 = polarization switching error,
     * 4-7 are currently unused.
     * @return the 3-bit status value from the HMC
     */
    static uint8_t hmcStatus() {
        uint8_t status;
        status = theHcrPmc730().getDioLine(_HCR_DIN_HMC_STATUS0) << 0 |
                theHcrPmc730().getDioLine(_HCR_DIN_HMC_STATUS1) << 1 |
                theHcrPmc730().getDioLine(_HCR_DIN_HMC_STATUS2) << 2;
        return(status);
    }

    /**
     * @brief Return true iff we are currently commanding "filament on" via
     * the RDS filament control line going to the transmitter.
     * @return true iff we are currently commanding "filament on" via
     * the RDS filament control line going to the transmitter.
     */
    static bool xmitterFilamentOn() {
        // Invert the sense of the outgoing line, since it is set high to
        // turn the filament off.
        return(! theHcrPmc730().getDioLine(_HCR_DOUT_TX_FILAMENT_OFF));
    }

    /**
     * @brief Return true iff we are currently commanding "high voltage on" via
     * the RDS HV control line going to the transmitter.
     * @return true iff we are currently commanding "high voltage on" via
     * the RDS HV control line going to the transmitter.
     */
    static bool xmitterHvOn() {
        // Invert the sense of the outgoing line, since it is set high to
        // turn HV off.
        return(! theHcrPmc730().getDioLine(_HCR_DOUT_TX_HV_OFF));
    }

    /**
     * @brief Return the HMC operating mode: 0-3.
     * Operating modes are: 0 = normal operation, 1 = noise source cal,
     * 2 = corner reflector cal, 3 = test and integration
     * @return the HMC operating mode
     */
    static int hmcMode() {
        int mode;
        mode = theHcrPmc730().getDioLine(_HCR_DOUT_HMC_OPS_MODE_BIT0) << 0 |
                theHcrPmc730().getDioLine(_HCR_DOUT_HMC_OPS_MODE_BIT1) << 1;
        return(mode);
    }

    /**
     * @brief Set the state of the noise source.
     * @param state If true, the noise source will be turned on, otherwise off.
     */
    static void setNoiseSourceOn(bool state) {
        theHcrPmc730().setDioLine(_HCR_DOUT_NOISE_SRC_ON, state ? 1 : 0);
    }

    /**
     * @brief Set the state of the transmitter klystron filament.
     * @param state If true, the klystron filament will be turned on, otherwise
     * off.
     */
    static void setXmitterFilamentOn(bool state) {
        // NOTE: setting _HCR_DOUT_TX_FILAMENT_OFF line high turns OFF the filament!
        theHcrPmc730().setDioLine(_HCR_DOUT_TX_FILAMENT_OFF, state ? 0 : 1);
    }

    /**
     * @brief Enable or disable transmitter high voltage.
     * @param state If true, transmitter high voltage will be enabled, otherwise
     * it will be disabled.
     */
    static void setXmitterHvOn(bool state) {
        // NOTE: setting _HCR_DOUT_TX_HV_OFF line high turns OFF the high voltage!
        theHcrPmc730().setDioLine(_HCR_DOUT_TX_HV_OFF, state ? 0 : 1);
    }

    /**
     * @brief Set the state of waveguide switch C.
     * @param state the desired switch position: 0 if state is false, 1 if
     * state is true.
     */
    static void setWaveguideSwitchC(bool state) {
        theHcrPmc730().setDioLine(_HCR_DOUT_WG_SWITCH_C, state ? 1 : 0);
    }

    /**
     * @brief Set the state of waveguide switch D.
     * @param state the desired switch position: 0 if state is false, 1 if
     * state is true.
     */
    static void setWaveguideSwitchD(bool state) {
        theHcrPmc730().setDioLine(_HCR_DOUT_WG_SWITCH_D, state ? 1 : 0);
    }

    /**
     * @brief Set the state of the HMC reset line.
     * @param state If true, the reset line will be set high, otherwise it will
     * be set low.
     */
    static void setHmcResetOn(bool state) {
        theHcrPmc730().setDioLine(_HCR_DOUT_HMC_RESET, state ? 1 : 0);
    }

    /**
     * @brief Set the HMC operation mode
     */
    typedef enum _HmcOperationMode {
        HMC_NORMAL_OPERATION = 0,
        HMC_NOISE_SOURCE_CAL = 1,
        HMC_CORNER_REFLECTOR_CAL = 2,
        HMC_MODE_3 = 3
    } HmcOperationMode;

    static void setHmcOperationMode(HmcOperationMode mode);

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
        _HCR_DIN_NOISE_SOURCE_SELECTED = 0,
        /// digital in line 1: waveguide switch B position
        _HCR_DIN_TERMINATION_SELECTED = 1,
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
        /// digital in line 7: HMC status bit 2
        _HCR_DIN_HMC_STATUS2 = 7
    } DinLine_t;
    
    /**
     * Output DIO lines
     */
    typedef enum {
        /// digital out line 8: Turn on noise source
        _HCR_DOUT_NOISE_SRC_ON = 8,
        /// digital out line 9: waveguide switch D control
        _HCR_DOUT_WG_SWITCH_D = 9,
        /// digital out line 10: HMC reset signal
        _HCR_DOUT_HMC_RESET = 10,
        /// digital out line 11: waveguide switch C control
        _HCR_DOUT_WG_SWITCH_C = 11,
        /// digital out line 12: Turn off transmitter Klystron filament
        _HCR_DOUT_TX_FILAMENT_OFF = 12,
        /// digital out line 13: HMC operation mode bit 0
        _HCR_DOUT_HMC_OPS_MODE_BIT0 = 13,
        /// digital out line 14: Turn off transmitter Klystron high voltage
        _HCR_DOUT_TX_HV_OFF = 14,
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
