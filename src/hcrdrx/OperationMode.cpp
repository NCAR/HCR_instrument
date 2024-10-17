// OperationMode.cpp
//
//  Created on: Mar 21, 2023
//      Author: Chris Burghart <burghart@ucar.edu>

#include <sstream>
#include <logx/Logging.h>
#include "OperationMode.h"

LOGGING("OperationMode")

const std::string toString(HmcMode mode)
{
    static const std::string names[] = {
        "Reset HMC",
        "Spare (1)",
        "Spare (2)",
        "Transmit",
        "Transmit (Attenuated)",
        "Noise Source Cal",
        "Idle (Bench Test)",
        "TX V with noise source",
        "Invalid"
    };

    if (mode < HmcMode::INVALID) {
        return names[static_cast<uint>(mode)];
    } else {
        std::ostringstream os;
        os << "BUG: HmcMode " << static_cast<int>(mode) << " out of bounds";
        return os.str();
    }
}

OperationMode::OperationMode(
    const HmcMode &mode,
    uint startIndex,
    uint stopIndex,
    const std::string& name)
      : _hmcMode(mode),
        _scheduleStartIndex(startIndex),
        _scheduleStopIndex(stopIndex),
        _name(name)
{
    if (!name.size()) {
        if ( startIndex ==  0 && stopIndex == 0) {
            // If the schedule is the default 0:0 then just name it after the HmcMode
        	std::ostringstream os;
        	os << _hmcMode;
            _name = os.str();
        }
        else {
            // This shouldn't happen so give it a weird name
            _name = "?BUG? " + std::to_string(_scheduleStartIndex)
                + ":" + std::to_string(_scheduleStopIndex);
                + " " + toString(_hmcMode);
        }
    }
};

bool OperationMode::operator==(const OperationMode& rhs) const {
    return _hmcMode == rhs._hmcMode
    && _scheduleStartIndex == rhs._scheduleStartIndex
    && _scheduleStopIndex == rhs._scheduleStopIndex;
}

bool OperationMode::operator!=(const OperationMode& rhs) const {
    return ! (*this == rhs);
}

bool OperationMode::isAttenuated() const {
    return _hmcMode == HmcMode::TRANSMIT_ATTENUATED;
}

bool OperationMode::isValid() const {
    return _hmcMode != HmcMode::INVALID;
}

OperationMode OperationMode::equivalentAttenuatedMode() const {
    auto m = *this;
    switch (_hmcMode) {
        case HmcMode::TRANSMIT:
            m._hmcMode = HmcMode::TRANSMIT_ATTENUATED;
            m._name += ", atten";
            break;
        case HmcMode::TRANSMIT_ATTENUATED:
            m._hmcMode = HmcMode::TRANSMIT_ATTENUATED;
            break;
        case HmcMode::BENCH_TEST:
            m._hmcMode = HmcMode::BENCH_TEST;
            break;
        case HmcMode::NOISE_SOURCE_CAL:
            m._hmcMode = HmcMode::NOISE_SOURCE_CAL;
            break;
        default:
            m._hmcMode = HmcMode::INVALID;
    }
    return m;
}
