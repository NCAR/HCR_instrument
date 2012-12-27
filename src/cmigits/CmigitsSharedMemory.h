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

class CmigitsSharedMemory: public QSharedMemory {
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
    /// @param mode desired access mode, either ReadOnly or ReadWrite
    /// @throw Exception if creation of or attachment to the shared memory
    /// segment with the requested mode fails.
    CmigitsSharedMemory(AccessMode mode = ReadOnly) throw(Exception);
    virtual ~CmigitsSharedMemory();

    /// String which serves as a key to identify our shared memory segment
    static const QString CMIGITS_SHM_KEY;

    /// @brief Get the process id associated with the current writer for this
    /// shared memory segment. If there is no writer, zero is returned.
    /// @return the process id associated with the current writer for this
    /// shared memory segment. If there is no writer, zero is returned.
    pid_t getWriterPid();

    /// @brief Get the latest status data. If no status data have been
    /// collected yet, the data values will all be zero, and the dataTime will
    /// be zero.
    /// @param[out] dataTime data date/time, msecs since 1970-01-01 00:00:00 UTC
    /// @param[out] currentMode current operating mode
    /// @param[out] insAvailable true iff INS measurements are available
    /// @param[out] gpsAvailable true iff GPS time is valid and at least 4 satellites
    /// are being used
    /// @param[out] positionFOM position figure-of-merit value
    /// @param[out] velocityFOM velocity figure-of-merit value
    /// @param[out] headingFOM heading figure-of-merit value
    /// @param[out] timeFOM time figure-of-merit value
    /// @param[out] expectedHPosError expected error in horizontal position, m
    /// @param[out] expectedVPosError expected error in vertical position, m
    /// @param[out] expectedVelocityError expected error in velocity, m/s
    void getLatestStatus(int64_t & dataTime, uint16_t & currentMode,
            bool & insAvailable, bool & gpsAvailable, uint16_t&  positionFOM,
            uint16_t & velocityFOM, uint16_t & headingFOM, uint16_t & timeFOM,
            float & expectedHPosError, float & expectedVPosError,
            float & expectedVelocityError);

    /// @brief Get the latest navigation solution data available. If no
    /// navigation solution data have been collected yet, the data values will
    /// all be zero and the dataTime will be zero.
    /// @param[out] dataTime date/time for navigation solution data, msecs since
    /// 1970-01-01 00:00:00 UTC
    /// @param[out] latitude the latitude, deg
    /// @param[out] longitude the longitude, deg
    /// @param[out] altitude the altitude, m above MSL
    /// @param[out] velNorth north component of velocity, m/s
    /// @param[out] velEast east component of velocity, m/s
    /// @param[out] velUp upward component of velocity, m/s
    void getLatestNavSolution(int64_t & dataTime, float & latitude,
            float & longitude, float & altitude, float & velNorth,
            float & velEast, float & velUp);

    /// @brief Get the latest attitude data available. If no attitude data have
    /// been collected yet, the data values will all be zero and the dataTime
    /// will be zero.
    /// @param[out] dataTime date/time for attitude data, msecs since
    /// 1970-01-01 00:00:00 UTC
    /// @param[out] pitch the pitch, deg
    /// @param[out] roll the roll, deg
    /// @param[out] heading the heading, deg clockwise from true north
    void getLatestAttitude(int64_t & dataTime, float & pitch, float & roll,
            float & heading);

public slots:
    /// @brief Set the latest status data.
    /// @param dataTime data date/time, msecs since 1970-01-01 00:00:00 UTC
    /// @param currentMode current operating mode
    /// @param insAvailable true iff INS measurements are available
    /// @param gpsAvailable true iff GPS time is valid and at least 4 satellites
    /// are being used
    /// @param positionFOM position figure-of-merit value
    /// @param velocityFOM velocity figure-of-merit value
    /// @param headingFOM heading figure-of-merit value
    /// @param timeFOM time figure-of-merit value
    /// @param expectedHPosError expected error in horizontal position, m
    /// @param expectedVPosError expected error in vertical position, m
    /// @param expectedVelocityError expected error in velocity, m/s
    /// @throws CmigitsSharedMemory::Exception if this object has ReadOnly
    /// access to the shared memory
    void setLatestStatus(int64_t dataTime, uint16_t currentMode,
            bool insAvailable, bool gpsAvailable, uint16_t positionFOM,
            uint16_t velocityFOM, uint16_t headingFOM, uint16_t timeFOM,
            float expectedHPosError, float expectedVPosError,
            float expectedVelocityError) throw(Exception);

    /// @brief Set the latest navigation solution data.
    /// @param dataTime date/time for position data, msecs since
    /// 1970-01-01 00:00:00 UTC
    /// @param latitude the latitude, deg
    /// @param longitude the longitude, deg
    /// @param altitude the altitude, m above MSL
    /// @param velNorth north component of velocity, m/s
    /// @param velEast east component of velocity, m/s
    /// @param velUp upward component of velocity, m/s
    /// @throws CmigitsSharedMemory::Exception if this object has ReadOnly
    /// access to the shared memory
    void setLatestNavSolution(int64_t dataTime, float latitude, float longitude,
            float altitude, float velNorth, float velEast, float velUp) throw(Exception);

    /// @brief Set the latest attitude data.
    /// @param dataTime date/time for attitude data, msecs since
    /// 1970-01-01 00:00:00 UTC
    /// @param pitch the pitch, deg
    /// @param roll the roll, deg
    /// @param heading the heading, deg clockwise from true north
    /// @throws CmigitsSharedMemory::Exception if this object has ReadOnly
    /// access to the shared memory
    void setLatestAttitude(int64_t dataTime, float pitch, float roll,
            float heading) throw(Exception);

private:
    /// our access mode, either QSharedMemory::ReadOnly or QSharedMemory::ReadWrite
    AccessMode _mode;
    /// The contents of the shared memory segment
    struct _ShmContents {
        pid_t writerPid;        // process ID of the current writer
        // Latest C-MIGITS status data from the C-MIGITS 3500 message.
        // For details
        int64_t statusTime;
        uint16_t currentMode;
        bool insAvailable;
        bool gpsAvailable;
        uint16_t positionFOM;   // position figure-of-merit value
        uint16_t velocityFOM;   // velocity figure-of-merit value
        uint16_t headingFOM;    // heading figure-of-merit value
        uint16_t timeFOM;       // time figure-of-merit value
        float hPosError;        // m
        float vPosError;        // m
        float velocityError;    // m/s
        // latest navigation solution data
        int64_t navSolutionTime;  // msecs since 1970-01-01 00:00:00 UTC
        float latitude;         // deg
        float longitude;        // deg
        float altitude;         // m above MSL
        float velNorth;         // m/s
        float velEast;          // m/s
        float velUp;            // m/s
        // latest attitude data
        int64_t attitudeTime;  // msecs since 1970-01-01 00:00:00 UTC
        float pitch;            // deg
        float roll;             // deg
        float heading;          // deg clockwise from true north
    } * _shmContents;
};

#endif /* CMIGITSSHAREDMEMORY_H_ */
