/*
 * Copyright (c) 1990-2016, University Corporation for Atmospheric Research
 * All rights reserved.
 *
 * SpatialFogFmq.h
 *
 *  Created on: Jul 21, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#ifndef SPATIALFOGFMQ_H_
#define SPATIALFOGFMQ_H_

#include <stdint.h>
#include <stdexcept>
#include <cstdio>
#include <Fmq/DsFmq.hh>
#include <QObject>
#include <QTimer>

/// @brief Class which provides access to a file message queue intended to
/// hold the most recent data acquired from an Advanced Navigation Spatial FOG
/// INS.
///
/// One instance of the class is allowed write access to the FMQ, and this
/// instance should be used to put values from the Spatial into the FMQ as soon
/// as they are available. As a rule, the instance with write access belongs to
/// a SpatialFogDaemon process which reads data directly from the Spatial and
/// puts it into the FMQ (see the SpatialFogDaemon program). Any other instances
/// of this class are only allowed read access to the shared memory.
///
/// If no SpatialFogFmq shared memory segment exists, it will be created
/// upon instantiation of a SpatialFogFmq object. Any other objects
/// created will share the same segment. The segment will be removed when the
/// last attached SpatialFogFmq object is destroyed.
///
/// It is not necessary for SpatialFogFmq object with write access to be
/// the first SpatialFogFmq created. Reader objects can be created at any
/// time, and there is no limit on their number. The only restriction on
/// creation of an object with write access is that there can be only one in
/// existence at any given time.
class SpatialFogFmq : public QObject {
    Q_OBJECT
public:
    /// The struct defining the layout/contents of a message in the Spatial FMQ
    typedef struct _MsgStruct {
        pid_t writerPid;        ///< process ID of the current writer
        // Latest status data
        uint64_t statusTime;    ///< msecs since 1970-01-01 00:00:00 UTC
        uint16_t statusBits;
        uint16_t filterBits;
        // latest position data
        uint64_t positionTime;  ///< msecs since 1970-01-01 00:00:00 UTC
        double latitude;        ///< deg
        double longitude;       ///< deg
        double altitude;        ///< m above MSL
        // latest attitude (Euler angles) data
        uint64_t attitudeTime;      ///< msecs since 1970-01-01 00:00:00 UTC
        double pitch;           ///< deg
        double roll;            ///< deg
        double heading;         ///< deg clockwise from true north
        // latest velocity data
        uint64_t velTime;
        double velNorth;        ///< m/s
        double velEast;         ///< m/s
        double velUp;           ///< m/s

        // Default initializer
        _MsgStruct() :
            writerPid(0),
            statusTime(0),
            statusBits(0),
            filterBits(0),
            positionTime(0),
            latitude(0.0),
            longitude(0.0),
            altitude(0.0),
            attitudeTime(0),
            pitch(0.0),
            roll(0.0),
            heading(0.0),
            velTime(0),
            velNorth(0.0),
            velEast(0.0),
            velUp(0.0) {}
    } MsgStruct;

    /// @brief Instantiate a connection to the shared memory used to distribute
    /// Spatial information.
    ///
    /// The shared memory segment is created if it does not yet exist. Only one
    /// object is allowed to have write access to the shared memory segment; all
    /// others may only read it.
    /// @param writeAccess true iff write access to shared memory is required
    SpatialFogFmq(bool writeAccess = false);
    virtual ~SpatialFogFmq();

    /// @brief Get a struct containing the latest message in the FMQ.
    /// @return a struct containing the latest message in the FMQ.
    MsgStruct getLatestMsg();

    /// URL for the SpatialFogFmq
    static const std::string FMQ_URL;

    /// @brief Get the process id associated with the current writer for this
    /// shared memory segment. If there is no writer, zero is returned.
    /// @return the process id associated with the current writer for this
    /// shared memory segment. If there is no writer, zero is returned.
    pid_t getWriterPid();

    /// @brief Get the latest status data. If the most recent data is more than
    /// 1 second old, the data values will all be zero, and the dataTime will
    /// be zero.
    /// @param[out] dataTime date/time for data, msecs since 1970-01-01 00:00:00 UTC
    /// @param[out] statusBits system status bits, see Advanced Navigation
    /// Packet Protocol documentation for details
    /// @param[out] filterBits filter status bits, see Advanced Navigation
    /// Packet Protocol documentation for details
    void getLatestStatusData(uint64_t & dataTime, uint16_t & statusBits,
            uint16_t & filterBits);

    /// @brief Get the latest position data available. If the
    /// most recent data is more than 1 second old, the data values will
    /// all be zero, and the dataTime will be zero.
    /// @param[out] dataTime date/time for data, msecs since 1970-01-01 00:00:00 UTC
    /// @param[out] latitude latitude, deg
    /// @param[out] longitude longitude, deg
    /// @param[out] altitude altitude, m above MSL
    void getLatestPositionData(uint64_t & dataTime, double & latitude,
            double & longitude, double & altitude);

    /// @brief Get the latest attitude (Euler angles) data available.
    /// If the most recent attitude message is more than 1 second old, the data
    /// values will all be zero, and the dataTime will be zero.
    /// @param[out] dataTime date/time for data, msecs since 1970-01-01 00:00:00 UTC
    /// @param[out] pitch pitch, deg
    /// @param[out] roll roll, deg
    /// @param[out] heading heading, deg clockwise from true north
    void getLatestAttitudeData(uint64_t & dataTime, double & pitch,
            double & roll, double & heading);

    /// @brief Get the latest north/east/up velocity data available.
    /// If the most recent velocity message is more than 1 second old, the data
    /// values will all be zero, and the dataTime will be zero.
    /// @param[out] dataTime date/time for data, msecs since 1970-01-01 00:00:00 UTC
    /// @param[out] velNorth north component of velocity, m/s
    /// @param[out] velEast east component of velocity, m/s
    /// @param[out] velUp upward component of velocity, m/s
    void getLatestVelocityData(uint64_t & dataTime, double & velNorth,
            double & velEast, double & velUp);

    /// @brief Get the time of the latest system status data, in
    /// milliseconds since 1970-01-01 00:00:00 UTC.
    ///
    /// This method is inlined, since it may be called very frequently.
    /// @return the time of the latest system status data, in
    /// milliseconds since 1970-01-01 00:00:00 UTC.
    uint64_t getLatestStatusTime() { return(getLatestMsg().statusTime); }

    /// @brief Get the time of the latest position data, in
    /// milliseconds since 1970-01-01 00:00:00 UTC.
    ///
    /// This method is inlined, since it may be called very frequently.
    /// @return the time of the latest position data, in
    /// milliseconds since 1970-01-01 00:00:00 UTC.
    uint64_t getLatestPositionTime() { return(getLatestMsg().positionTime); }

    /// @brief Get the time of the latest attitude (Euler angles) data, in
    /// milliseconds since 1970-01-01 00:00:00 UTC.
    ///
    /// This method is inlined, since it may be called very frequently.
    /// @return the time of the latest attitude (Euler angles) data, in
    /// milliseconds since 1970-01-01 00:00:00 UTC.
    uint64_t getLatestAttitudeTime() { return(getLatestMsg().attitudeTime); }

    /// @brief Calculate and return estimated drift angle in degrees, based on
    /// latest heading and ground velocity values in current shared memory
    /// contents. The range returned is [-180.0,180.0].
    ///
    /// If ground speed is less than 10 m/s, drift will be reported as zero.
    /// @return estimated drift angle in degrees, in range [-180.0,180.0].
    double getEstimatedDriftAngle();

    /// @brief Calculate and return estimated drift angle in degrees, based on
    /// heading and ground velocity values in shmContents. The range
    /// returned is [-180.0,180.0].
    ///
    /// If ground speed is less than 10 m/s, drift will be reported as zero.
    /// @param msg the MsgStruct containing data from which to calculate drift
    /// @return estimated drift angle in degrees, in range [-180.0,180.0].
    static double GetEstimatedDriftAngle(const MsgStruct msg);

public slots:
    /// @brief Store the latest system status data.
    /// @param dataTime date/time for data, msecs since 1970-01-01 00:00:00 UTC
    /// @param statusBits system status bits, see Advanced Navigation
    /// Packet Protocol documentation for details
    /// @param filterBits filter status bits, see Advanced Navigation
    /// Packet Protocol documentation for details
    void storeLatestStatusData(uint64_t dataTime, uint16_t statusBits,
            uint16_t filterBits);

    /// @brief Store the latest position data.
    /// @param dataTime date/time for data, msecs since 1970-01-01 00:00:00 UTC
    /// @param latitude latitude, deg
    /// @param longitude longitude, deg
    /// @param altitude altitude, m above MSL
    void storeLatestPositionData(uint64_t time3501, double latitude,
            double longitude, double altitude);

    /// @brief Store the latest attitude (Euler angles) data.
    /// @param dataTime date/time for data, msecs since 1970-01-01 00:00:00 UTC
    /// @param pitch pitch, deg
    /// @param roll roll, deg
    /// @param heading heading, deg clockwise from true north
    void storeLatestAttitudeData(uint64_t dataTime, double pitch, double roll,
            double heading);

    /// @brief Store the latest north/east/up velocity data.
    /// @param dataTime date/time for data, msecs since 1970-01-01 00:00:00 UTC
    /// @param velNorth north component of velocity, m/s
    /// @param velEast east component of velocity, m/s
    /// @param velUp upward component of velocity, m/s
    void storeLatestVelocityData(uint64_t dataTime, double velNorth,
            double velEast, double velUp);
    
private slots:
    /// @brief Write a new message to the FMQ with status data zeroed.
    void _zeroStatusData();
    
    /// @brief Write a new message to the FMQ with position data zeroed.
    void _zeroPositionData();
    
    /// @brief Write a new message to the FMQ with attitude data zeroed.
    void _zeroAttitudeData();

    /// @brief Write a new message to the FMQ with velocity data zeroed.
    void _zeroVelocityData();

private:
    /// @brief Try to initialize the FMQ for reading if necessary, and return 
    /// true iff the FMQ is initialized.
    bool _fmqInitializeForRead();
    
    /// @brief Set the writer PID for the shared memory segment.
    void _setWriterPid(pid_t pid);
    
    /// @brief Write the latest message to the FMQ
    void _writeCurrentMsg();
    
    /// Our shared memory FMQ.
    DsFmq _fmq;
    
    /// Do we have write access to the shared memory?
    bool _writeAccess;
    
    /// Timeout timer for status data, used only by the writer instance
    QTimer _statusTimeoutTimer;
    /// Timeout timer for position data, used only by the writer instance
    QTimer _positionTimeoutTimer;
    /// Timeout timer for attitude data, used only by the writer instance
    QTimer _attitudeTimeoutTimer;
    /// Timeout timer for velocity data, used only by the writer instance
    QTimer _velocityTimeoutTimer;
    /// MsgStruct which caches the latest data from the Spatial
    MsgStruct _currentMsg;
};

#endif /* SPATIALFOGFMQ_H_ */
