/*
 * OperationMode.h
 *
 *  Created on: Mar 21, 2023
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#ifndef OPERATIONMODE_H_
#define OPERATIONMODE_H_

#include <string>
#include <boost/archive/binary_iarchive.hpp>
#include <boost/archive/binary_oarchive.hpp>
#include <boost/serialization/nvp.hpp>

/// @brief Enumerated type for the Health Monitor Card (HMC) 3-bit operation mode
typedef enum {
    RESET = 0,               ///< reset the HMC
    SPARE_1 = 1,             ///< unused (1)
    SPARE_2 = 2,             ///< unused (2)
    TRANSMIT = 3,            ///< tx according to drx scheduler, rx H and V
    TRANSMIT_ATTENUATED = 4, ///< tx according to drx scheduler, rx H and V (attenuated)
    NOISE_SOURCE_CAL = 5,    ///< noise source calibration
    BENCH_TEST = 6,          ///< bench test
    V_HV_ISOL_NOISE = 7,     ///< tx V, rx H and V, enable noise source
    HMC_NMODES = 8,          ///< mode count
    INVALID = HMC_NMODES     ///< explicit invalid mode
} HmcMode;

/// @brief Function which returns a string representation of an HmcMode
const std::string toString(HmcMode mode);

/// @brief output stream operator which renders HmcMode using toString(HmcMode m)
inline std::ostream &operator<<(std::ostream &os, const HmcMode mode)
{
	os << toString(mode);
	return os;
}


/// @brief Class which encapsulates an operation mode for hcrdrx.
///
/// An operation mode for hcrdrx is defined by a valid HMC operating mode
/// from the HmcMode enumerated type, and by start and stop indices
/// in hcrdrx's table of pulse schedules.
class OperationMode {
public:

	// Public constructors use the default schedule (schedule 0).
	// Modes containing any other schedule must be created by apardrx.
    // Public constructors use the default schedule.
    // Modes containing any other schedule must be created by apardrx.

    OperationMode() {
        OperationMode(HmcMode::RESET, 0, 0, "");
    }

    static const OperationMode DefaultReset() {
        return OperationMode(HmcMode::RESET, 0, 0, "");
    }

    static const OperationMode DefaultBenchTest() {
        return OperationMode(HmcMode::BENCH_TEST, 0, 0, "");
    }

    static const std::vector<OperationMode> DefaultModeList() {
        return { DefaultReset(), DefaultBenchTest() };
    }

	bool operator==(const OperationMode& rhs) const;

	bool operator!=(const OperationMode& rhs) const;

	bool isAttenuated() const;

	bool isValid() const;

	/// @brief Method which returns an OperationMode identical to this object,
	/// except with additional receive attenuation enabled.
	OperationMode equivalentAttenuatedMode() const;

	HmcMode hmcMode() const { return _hmcMode; };

	uint scheduleStartIndex() const { return _scheduleStartIndex; };

	uint scheduleStopIndex() const { return _scheduleStopIndex; };

	const std::string name() const { return _name; };

	template<class Archive>
	void serialize(Archive & ar, const unsigned int version) {
		using boost::serialization::make_nvp;
		ar & BOOST_SERIALIZATION_NVP(_hmcMode);
		ar & BOOST_SERIALIZATION_NVP(_scheduleStartIndex);
		ar & BOOST_SERIALIZATION_NVP(_scheduleStopIndex);
		ar & BOOST_SERIALIZATION_NVP(_name);
	}

private:

	OperationMode(const HmcMode &mode,
				  uint startIndex = 0,
				  uint stopIndex = 0,
				  const std::string& name = "");

HmcMode _hmcMode;
uint _scheduleStartIndex;
uint _scheduleStopIndex;
std::string _name;

friend class HCR_Pentek;
friend class TransmitControl;

};

#endif /* OPERATIONMODE_H_ */
