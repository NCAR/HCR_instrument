/*
 * FireFlyStatus.h
 *
 *  Created on: Aug 31, 2012
 *      Author: burghart
 */

#ifndef FIREFLYSTATUS_H_
#define FIREFLYSTATUS_H_

#include <ctime>
#include <exception>
#include <string>
#include <stdint.h>
#include <xmlrpc-c/base.hpp>
#include <boost/serialization/nvp.hpp>
#include <boost/serialization/version.hpp>

/// @brief Class to represent HCR FireFly-IIA status.
class FireFlyStatus {
public:
    /// @brief Default constructor. Status time is set to current time,
    /// the device is marked as not responding. Other values are set to
    /// generally indicate badness.
    FireFlyStatus();

    /// @brief Construct from given status values, assigning current time
    /// as the status time.
    /// @param deviceResponding true iff the FireFly-IIA device is responding
    /// @param pllLocked true iff the PLL is locked
    /// @param lastHoldoverDuration last holdover duration, in seconds
    /// @param inHoldover true iff the FireFly-IIA is in holdover
    /// @param freqErrorEstimate frequency error estimate
    /// @param timeDiff1PPS time difference between FireFly-IIA output 1 PPS and
    /// GPS 1 PPS.
    /// @param healthStatus health status value
    /// @param configError true iff the FireFly class has detected a problem
    /// in the device's configuration
    FireFlyStatus(bool deviceResponding, bool pllLocked,
            int lastHoldoverDuration, bool inHoldover, float freqErrorEstimate,
            float timeDiff1PPS, uint16_t healthStatus, bool configError);

    /// @brief Construct from an xmlrpc_c::value_struct dictionary as returned
    /// by a call to the FireFlyStatus::toXmlRpcValue() method.
    /// @param statusDict an xmlrpc_c::value_struct dictionary as returned by
    /// call to the FireFlyStatus::toXmlRpcValue() method.
    FireFlyStatus(xmlrpc_c::value_struct & statusDict);

    /// @brief destructor
    virtual ~FireFlyStatus();

    /// @brief Severity indication values
    typedef enum {
        OK = 0,
        WARNING = 1,
        ERROR = 2
    } Severity;

    /// @brief Return an external representation of the object's state as
    /// an xmlrpc_c::value_struct dictionary.
    ///
    /// The returned value can be used on the other side of an XML-RPC
    /// connection to create an identical object via the
    /// FireFlyStatus(const xmlrpc_c::value_struct &) constructor.
    /// @return an external representation of the object's state as
    /// an xmlrpc_c::value_struct dictionary.
    xmlrpc_c::value_struct toXmlRpcValue() const;
    
    /// @brief Return an evaluation of the overall status as one of the
    /// Severity states defined by the class.
    /// @return an evaluation of the overall status as one of the
    /// Severity states defined by the class.
    Severity overallStatus();

    /// @brief Return the status time, seconds since 1970-01-01 00:00:00 UTC.
    /// @return the status time, seconds since 1970-01-01 00:00:00 UTC.
    time_t statusTime() const { return(_statusTime); }

    /// @brief Return true iff replies are being received from the  FireFly-IIA.
    /// @return true iff replies are being received from the  FireFly-IIA.
    bool deviceResponding() const { return(_deviceResponding); }
    
    /// @brief Return true iff the FireFly-IIA's 1 PPS output is currently
    /// locked to 1 PPS from GPS.
    /// @return true iff the FireFly-IIA's 1 PPS output is currently
    /// locked to 1 PPS from GPS.
    bool pllLocked() const { return(_pllLocked); }

    /// @brief Return true iff the device is in holdover
    /// @return true iff the device is in holdover
    bool inHoldover() const { return(_inHoldover); }

    /// @brief Return the last holdover duration in seconds. Note that this is
    /// also the *current* holdover duration when the unit is in holdover.
    /// @return the last holdover duration in seconds. Note that this is also
    /// the *current* holdover duration when the unit is in holdover.
    int lastHoldoverDuration() const { return(_lastHoldoverDuration); }

    /// @brief Return the frequency error estimate
    /// @return the frequency error estimate
    float freqErrorEstimate() const { return(_freqErrorEstimate); }

    /// @brief Return the time difference between FireFly-IIA 1 PPS and
    /// GPS 1PPS.
    /// @return the time difference between FireFly-IIA 1 PPS and GPS 1PPS.
    float timeDiff1PPS() const { return(_timeDiff1PPS); }

    /// @brief Return the health status flag bits
    /// @return the health status flag bits
    uint16_t healthStatus() const { return(_healthStatus); }

    /// @brief Return true iff the device has been determined to have an
    /// error in its configuration.
    /// @return true iff the device has been determined to have an
    /// error in its configuration.
    bool configError() const { return(_configError); }

    /// @brief Return true iff the "OCXO coarse-DAC is at max" bit of health
    /// status is set. If severity pointer is non-null, return the relative
    /// severity associated with the bit(s).
    /// @param severity if non-null, the severity associated with this bit will
    /// be returned here.
    /// @return true iff the "OCXO coarse-DAC is at max" bit of health
    /// status is set.
    bool coarseDacIsAtMax(Severity * severity = NULL) const {
        return(_checkHealthBits(0x001, severity));
    }

    /// @brief Return true iff the "OCXO coarse-DAC is at min" bit of health
    /// status is set. If severity pointer is non-null, return the relative
    /// severity associated with the bit(s).
    /// @param severity if non-null, the severity associated with this bit will
    /// be returned here.
    /// @return true iff the "OCXO coarse-DAC is at min" bit of health
    /// status is set.
    bool coarseDacIsAtMin(Severity * severity = NULL) const {
        return(_checkHealthBits(0x002, severity));
    }

    /// @brief Return true iff the "phase offset > 250 ns" bit of health
    /// status is set. If severity pointer is non-null, return the relative
    /// severity associated with the bit(s).
    /// @param severity if non-null, the severity associated with this bit will
    /// be returned here.
    /// @return true iff the "phase offset > 250 ns" bit of health
    /// status is set.
    bool phaseOffsetLarge(Severity * severity = NULL) const {
        return(_checkHealthBits(0x004, severity));
    }

    /// @brief Return true iff the "run time < 300 s" bit of health
    /// status is set. If severity pointer is non-null, return the relative
    /// severity associated with the bit(s).
    /// @param severity if non-null, the severity associated with this bit will
    /// be returned here.
    /// @return true iff the "run time < 300 s" bit of health
    /// status is set.
    bool runTimeUnder300Sec(Severity * severity = NULL) const {
        return(_checkHealthBits(0x008, severity));
    }

    /// @brief Return true iff the "holdover > 60 s" bit of health
    /// status is set. If severity pointer is non-null, return the relative
    /// severity associated with the bit(s).
    /// @param severity if non-null, the severity associated with this bit will
    /// be returned here.
    /// @return true iff the "holdover > 60 s" bit of health
    /// status is set.
    bool longHoldover(Severity * severity = NULL) const {
        return(_checkHealthBits(0x010, severity));
    }

    /// @brief Return true iff the "frequency error estimate out-of-bounds" bit
    /// of health status is set. If severity pointer is non-null, return the
    /// relative severity associated with the bit(s).
    /// @param severity if non-null, the severity associated with this bit will
    /// be returned here.
    /// @return true iff the "frequency error estimate out-of-bounds" bit
    /// of health status is set.
    bool freqErrEstOutOfBounds(Severity * severity = NULL) const {
        return(_checkHealthBits(0x020, severity));
    }

    /// @brief Return true iff the "OCXO voltage too high" bit of health status
    /// is set. If severity pointer is non-null, return the relative
    /// severity associated with the bit(s).
    /// @param severity if non-null, the severity associated with this bit will
    /// be returned here.
    /// @return true iff the "OCXO voltage too high" bit of health status
    /// is set.
    bool oscVoltageTooHigh(Severity * severity = NULL) const {
        return(_checkHealthBits(0x040, severity));
    }

    /// @brief Return true iff the "OCXO voltage too low" bit of health status
    /// is set. If severity pointer is non-null, return the relative
    /// severity associated with the bit(s).
    /// @param severity if non-null, the severity associated with this bit will
    /// be returned here.
    /// @return true iff the "OCXO voltage too low" bit of health status
    /// is set.
    bool oscVoltageTooLow(Severity * severity = NULL) const {
        return(_checkHealthBits(0x080, severity));
    }

    /// @brief Return true iff the "short-term drive > 100 ns" bit of health
    /// status is set. If severity pointer is non-null, return the relative
    /// severity associated with the bit(s).
    /// @param severity if non-null, the severity associated with this bit will
    /// be returned here.
    /// @return true iff the "short-term drive > 100 ns" bit of health
    /// status is set.
    bool shortTermDriftLarge(Severity * severity = NULL) const {
        return(_checkHealthBits(0x100, severity));
    }

    /// @brief Return true iff the "phase-reset or coarsedac change in last
    /// 7 minutes" bit of health status is set. If severity pointer is non-null, return the relative
    /// severity associated with the bit(s).
    /// @param severity if non-null, the severity associated with this bit will
    /// be returned here.
    /// @return true iff the "phase-reset or coarsedac change in last
    /// 7 minutes" bit of health status is set.
    bool recentPhaseResetOrCoarseDacChange(Severity * severity = NULL) const {
        return(_checkHealthBits(0x200, severity));
    }

    /// @brief Return true iff the "strong GPS jamming" bit of health
    /// status is set. If severity pointer is non-null, return the relative
    /// severity associated with the bit(s).
    /// @param severity if non-null, the severity associated with this bit will
    /// be returned here.
    /// @return true iff the "strong GPS jamming" bit of health
    /// status is set.
    bool strongGpsJamming(Severity * severity = NULL) const {
        return(_checkHealthBits(0x800, severity));
    }

private:
    friend class boost::serialization::access;

    /// @brief Mask of health status bits we consider to be errors
    static const int16_t _ErrorBits = 0x1f3;

    /// @brief Mask of health status bits we treat as warnings
    static const uint16_t _WarningBits = 0x80c;

    /// @brief Return true iff the given flag bit(s) are set in the health
    /// status. If severity pointer is non-null, return the relative
    /// severity associated with the bit(s).
    /// @param bits the flag bit(s) to be tested
    /// @param severity if non-null, the severity associated with the flag
    /// bits will be returned here.
    /// @return true iff the given flag bit(s) are set in the health status
    bool _checkHealthBits(uint16_t bits, Severity * severity) const {
        if (severity) {
            if (bits & _ErrorBits) {
                *severity = ERROR;
            } else if (bits & _WarningBits) {
                *severity = WARNING;
            } else {
                *severity = OK;
            }
        }
        return(_healthStatus & bits);
    }

    /// @brief Serialize our members to a boost save/output archive or
    /// populate our members from a boost load/input archive.
    /// @param ar the archive to load from or save to.
    /// @param version the version
    template<class Archive>
    void serialize(Archive & ar, const unsigned int version) {
        using boost::serialization::make_nvp;
        // Version 0 (see BOOST_CLASS_VERSION macro below for latest version)
        if (version >= 0) {
            // Map named entries to our member variables using serialization's
            // name/value pairs (nvp).
            ar & BOOST_SERIALIZATION_NVP(_statusTime);
            ar & BOOST_SERIALIZATION_NVP(_deviceResponding);
            ar & BOOST_SERIALIZATION_NVP(_pllLocked);
            ar & BOOST_SERIALIZATION_NVP(_lastHoldoverDuration);
            ar & BOOST_SERIALIZATION_NVP(_inHoldover);
            ar & BOOST_SERIALIZATION_NVP(_freqErrorEstimate);
            ar & BOOST_SERIALIZATION_NVP(_timeDiff1PPS);
            ar & BOOST_SERIALIZATION_NVP(_healthStatus);
            ar & BOOST_SERIALIZATION_NVP(_configError);
        }
        if (version >= 1) {
            // Version 1 stuff will go here...
        }
    }

    /// Status time, seconds since 1970-01-01 00:00:00 UTC
    time_t _statusTime;

    /// Is the FireFly-IIA responding on the serial port?
    bool _deviceResponding;
    
    /// Is the PLL locked?
    bool _pllLocked;

    /// Duration of the last holdover, s. (Note that this is the duration of
    /// the current holdover when the device is in holdover).
    int _lastHoldoverDuration;

    /// Is the FireFly-IIA currently in holdover?
    bool _inHoldover;

    /// Frequency error estimate
    float _freqErrorEstimate;

    /// Time difference between FireFly-IIA output 1 PPS and GPS 1 PPS, in
    /// seconds.
    float _timeDiff1PPS;

    /// Health status value from the FireFly-IIA
    uint16_t _healthStatus;

    /// Has an error in the FireFly-IIA's configuration been detected?
    bool _configError;
};

// Increment this class version number when member variables are changed.
BOOST_CLASS_VERSION(FireFlyStatus, 0)

#endif /* FIREFLYSTATUS_H_ */
