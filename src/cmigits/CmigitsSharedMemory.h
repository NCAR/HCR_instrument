/*
 * CmigitsSharedMemory.h
 *
 *  Created on: Dec 19, 2012
 *      Author: burghart
 */

#ifndef CMIGITSSHAREDMEMORY_H_
#define CMIGITSSHAREDMEMORY_H_

#include <stdint.h>
#include <stdexcept>
#include <QSharedMemory>

/// @brief Class which provides access to a shared memory segment intended to
/// hold the most recent data acquired from a C-MIGITS INS/GPS navigation
/// system.
///
/// One instance of the class is allowed write access to the shared memory
/// segment, and this instance should be used to put values from the C-MIGITS
/// into shared memory as soon as they are available. As a rule, the instance
/// with write access belongs to a cmigitsDaemon process which reads data
/// directly from the C-MIGITS and puts it into the shared memory (see the
/// cmigitsDaemon program). Any other instances of this class are only allowed
/// read access to the shared memory.
///
/// If no CmigitsSharedMemory shared memory segment exists, it will be created
/// upon instantiation of a CmigitsSharedMemory object. Any other objects
/// created will share the same segment. The segment will be removed when the
/// last attached CmigitsSharedMemory object is destroyed.
///
/// It is not necessary for CmigitsSharedMemory object with write access to be
/// the first CmigitsSharedMemory created. Reader objects can be created at any
/// time, and there is no limit on their number. The only restriction on
/// creation of an object with write access is that there can be only one in
/// existence at any given time.
class CmigitsSharedMemory: public QObject {
    Q_OBJECT
public:
    /// @brief Exception type for CmigitsSharedMemory.
    class Exception : public std::runtime_error {
    public:
        Exception(const std::string & what) : runtime_error(what) {}
    };

    /// @brief Instantiate a connection to the shared memory used to distribute
    /// C-MIGITS information.
    ///
    /// The shared memory segment is created if it does not yet exist. Only one
    /// object is allowed to have write access to the shared memory segment; all
    /// others may only read it.
    /// @param writeAccess true iff write access to shared memory is required
    /// @throw Exception if creation of or attachment to the shared memory
    /// segment with the requested mode fails.
    CmigitsSharedMemory(bool writeAccess = false) throw(Exception);
    virtual ~CmigitsSharedMemory();

    /// String which serves as a key to identify our shared memory segment
    static const QString CMIGITS_SHM_KEY;

    /// @brief Get the process id associated with the current writer for this
    /// shared memory segment. If there is no writer, zero is returned.
    /// @return the process id associated with the current writer for this
    /// shared memory segment. If there is no writer, zero is returned.
    pid_t getWriterPid() const;

    /// @brief Get the latest 3500 (System Status) data. If no 3500 message
    /// has been received yet, the data values will all be zero, and the
    /// dataTime will be zero.
    /// @param[out] dataTime data date/time, msecs since 1970-01-01 00:00:00 UTC
    /// @param[out] currentMode current operating mode
    /// @param[out] insAvailable true iff INS measurements are available
    /// @param[out] gpsAvailable true iff GPS time is valid and at least 4 satellites
    /// are being used
    /// @param[out] nSats number of GPS satellites tracked
    /// @param[out] positionFOM position figure-of-merit value
    /// @param[out] velocityFOM velocity figure-of-merit value
    /// @param[out] headingFOM heading figure-of-merit value
    /// @param[out] timeFOM time figure-of-merit value
    /// @param[out] expectedHPosError expected error in horizontal position, m
    /// @param[out] expectedVPosError expected error in vertical position, m
    /// @param[out] expectedVelocityError expected error in velocity, m/s
    void getLatest3500Data(uint64_t & dataTime, uint16_t & currentMode,
            bool & insAvailable, bool & gpsAvailable, uint16_t & nSats,
            uint16_t &  positionFOM, uint16_t & velocityFOM,
            uint16_t & headingFOM, uint16_t & timeFOM,
            float & expectedHPosError, float & expectedVPosError,
            float & expectedVelocityError) const;

    /// @brief Get the latest 3501 (Navigation Solution) data available. If no
    /// 3501 message has been received yet, the data values will all be zero
    /// and the dataTime will be zero.
    /// @param[out] dataTime date/time for navigation solution data, msecs since
    /// 1970-01-01 00:00:00 UTC
    /// @param[out] latitude latitude, deg
    /// @param[out] longitude longitude, deg
    /// @param[out] altitude altitude, m above MSL
    /// @param[out] velNorth north component of velocity, m/s
    /// @param[out] velEast east component of velocity, m/s
    /// @param[out] velUp upward component of velocity, m/s
    void getLatest3501Data(uint64_t & dataTime, float & latitude,
            float & longitude, float & altitude, float & velNorth,
            float & velEast, float & velUp) const;

    /// @brief Get the latest 3512 (Flight Control) attitude data available.
    /// If no 3512 message has been received yet, the data values will all be
    /// zero and the dataTime will be zero.
    /// @param[out] dataTime date/time for attitude data, msecs since
    /// 1970-01-01 00:00:00 UTC
    /// @param[out] pitch pitch, deg
    /// @param[out] roll roll, deg
    /// @param[out] heading heading, deg clockwise from true north
    void getLatest3512Data(uint64_t & dataTime, float & pitch, float & roll,
            float & heading) const;

public slots:
    /// @brief Store the latest 3500 (System Status) data.
    /// @param dataTime data date/time, msecs since 1970-01-01 00:00:00 UTC
    /// @param currentMode current operating mode
    /// @param insAvailable true iff INS measurements are available
    /// @param gpsAvailable true iff GPS time is valid and at least 4 satellites
    /// are being used
    /// @param nSats number of GPS satellites tracked
    /// @param positionFOM position figure-of-merit value
    /// @param velocityFOM velocity figure-of-merit value
    /// @param headingFOM heading figure-of-merit value
    /// @param timeFOM time figure-of-merit value
    /// @param expectedHPosError expected error in horizontal position, m
    /// @param expectedVPosError expected error in vertical position, m
    /// @param expectedVelocityError expected error in velocity, m/s
    /// @throws CmigitsSharedMemory::Exception if this object has ReadOnly
    /// access to the shared memory
    void storeLatest3500Data(uint64_t dataTime, uint16_t currentMode,
            bool insAvailable, bool gpsAvailable, uint16_t nSats,
            uint16_t positionFOM, uint16_t velocityFOM,
            uint16_t headingFOM, uint16_t timeFOM,
            float expectedHPosError, float expectedVPosError,
            float expectedVelocityError) throw(Exception);

    /// @brief Store the latest 3501 (Navigation Solution) data.
    /// @param dataTime date/time for position data, msecs since
    /// 1970-01-01 00:00:00 UTC
    /// @param latitude latitude, deg
    /// @param longitude longitude, deg
    /// @param altitude altitude, m above MSL
    /// @param velNorth north component of velocity, m/s
    /// @param velEast east component of velocity, m/s
    /// @param velUp upward component of velocity, m/s
    /// @throws CmigitsSharedMemory::Exception if this object has ReadOnly
    /// access to the shared memory
    void storeLatest3501Data(uint64_t dataTime, float latitude, float longitude,
            float altitude, float velNorth, float velEast, float velUp) throw(Exception);

    /// @brief Store the latest 3512 (Flight Control) data.
    /// @param dataTime date/time for attitude data, msecs since
    /// 1970-01-01 00:00:00 UTC
    /// @param pitch pitch, deg
    /// @param roll roll, deg
    /// @param heading heading, deg clockwise from true north
    /// @throws CmigitsSharedMemory::Exception if this object has ReadOnly
    /// access to the shared memory
    void storeLatest3512Data(uint64_t dataTime, float pitch, float roll,
            float heading) throw(Exception);

private:
    /// Our QSharedMemory object. This is mutable because we need to be able to
    /// lock and unlock the shared memory, even in our const methods.
    mutable QSharedMemory _qShm;
    /// Do we have write access to the shared memory?
    bool _writeAccess;
    /// The contents of the shared memory segment
    struct _ShmContents {
        pid_t writerPid;        // process ID of the current writer
        // Latest C-MIGITS status data from the C-MIGITS 3500 message.
        // For details
        uint64_t statusTime;
        uint16_t currentMode;
        bool insAvailable;
        bool gpsAvailable;
        uint16_t nSats;         // number of GPS satellites tracked
        uint16_t positionFOM;   // position figure-of-merit value
        uint16_t velocityFOM;   // velocity figure-of-merit value
        uint16_t headingFOM;    // heading figure-of-merit value
        uint16_t timeFOM;       // time figure-of-merit value
        float hPosError;        // m
        float vPosError;        // m
        float velocityError;    // m/s
        // latest navigation solution data
        uint64_t navSolutionTime;  // msecs since 1970-01-01 00:00:00 UTC
        float latitude;         // deg
        float longitude;        // deg
        float altitude;         // m above MSL
        float velNorth;         // m/s
        float velEast;          // m/s
        float velUp;            // m/s
        // latest attitude data
        uint64_t attitudeTime;  // msecs since 1970-01-01 00:00:00 UTC
        float pitch;            // deg
        float roll;             // deg
        float heading;          // deg clockwise from true north
    } * _shmContents;
};

#endif /* CMIGITSSHAREDMEMORY_H_ */
