/*
 * CmigitsFmq.h
 *
 *  Created on: Jan 2, 2015
 *      Author: burghart
 */

#ifndef CMIGITSFMQ_H_
#define CMIGITSFMQ_H_

#include <stdint.h>
#include <stdexcept>
#include <cstdio>
#include <Fmq/DsFmq.hh>
#include <QObject>
#include <QTimer>

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
/// If no CmigitsFmq shared memory segment exists, it will be created
/// upon instantiation of a CmigitsFmq object. Any other objects
/// created will share the same segment. The segment will be removed when the
/// last attached CmigitsFmq object is destroyed.
///
/// It is not necessary for CmigitsFmq object with write access to be
/// the first CmigitsFmq created. Reader objects can be created at any
/// time, and there is no limit on their number. The only restriction on
/// creation of an object with write access is that there can be only one in
/// existence at any given time.
class CmigitsFmq : public QObject {
    Q_OBJECT
public:
    /// The struct defining the layout/contents of the shared memory segment
    typedef struct _CmigitsShmStruct {
        pid_t writerPid;        // process ID of the current writer
        // Latest C-MIGITS status data from the C-MIGITS 3500 message.
        // For details
        uint64_t time3500;      ///< msecs since 1970-01-01 00:00:00 UTC
        uint16_t currentMode;
        bool insAvailable;
        bool gpsAvailable;
        bool doingCoarseAlignment;
        uint16_t nSats;         ///< number of GPS satellites tracked
        uint16_t positionFOM;   ///< position figure-of-merit value
        uint16_t velocityFOM;   ///< velocity figure-of-merit value
        uint16_t headingFOM;    ///< heading figure-of-merit value
        uint16_t timeFOM;       ///< time figure-of-merit value
        double hPosError;       ///< m
        double vPosError;       ///< m
        double velocityError;   ///< m/s
        // latest 3501 message data
        uint64_t time3501;      ///< msecs since 1970-01-01 00:00:00 UTC
        double latitude;        ///< deg
        double longitude;       ///< deg
        double altitude;        ///< m above MSL
        // latest 3512 message data
        uint64_t time3512;      ///< msecs since 1970-01-01 00:00:00 UTC
        double pitch;           ///< deg
        double roll;            ///< deg
        double heading;         ///< deg clockwise from true north
        double velNorth;        ///< m/s
        double velEast;         ///< m/s
        double velUp;           ///< m/s

        // Default initializer
        _CmigitsShmStruct() :
            writerPid(0),
            time3500(0),
            currentMode(0),
            insAvailable(false),
            gpsAvailable(false),
            doingCoarseAlignment(false),
            nSats(0),
            positionFOM(0),
            velocityFOM(0),
            headingFOM(0),
            timeFOM(0),
            hPosError(0.0),
            vPosError(0.0),
            velocityError(0.0),
            time3501(0),
            latitude(0.0),
            longitude(0.0),
            altitude(0.0),
            time3512(0),
            pitch(0.0),
            roll(0.0),
            heading(0.0),
            velNorth(0.0),
            velEast(0.0),
            velUp(0.0) {}
    } MsgStruct;

    /// @brief Instantiate a connection to the shared memory used to distribute
    /// C-MIGITS information.
    ///
    /// The shared memory segment is created if it does not yet exist. Only one
    /// object is allowed to have write access to the shared memory segment; all
    /// others may only read it.
    /// @param writeAccess true iff write access to shared memory is required
    CmigitsFmq(bool writeAccess = false);
    virtual ~CmigitsFmq();

    /// @brief Get a struct containing the latest message in the FMQ.
    /// @return a struct containing the latest message in the FMQ.
    MsgStruct getLatestMsg();

    /// URL for the CmigitsFmq
    static const std::string FMQ_URL;

    /// @brief Get the process id associated with the current writer for this
    /// shared memory segment. If there is no writer, zero is returned.
    /// @return the process id associated with the current writer for this
    /// shared memory segment. If there is no writer, zero is returned.
    pid_t getWriterPid();

    /// @brief Get the latest 3500 (System Status) data. If the most recent 3500
    /// message is more than 1 second old, the data values will all be zero, and
    /// the dataTime will be zero.
    /// @param[out] time3500 3500 message date/time, msecs since 1970-01-01
    /// 00:00:00 UTC
    /// @param[out] currentMode current operating mode
    /// @param[out] insAvailable true iff INS measurements are available
    /// @param[out] gpsAvailable true iff GPS time is valid and at least 4
    /// satellites are being used
    /// @param[out] doingCoarseAlignment true iff C-MIGITS is in "Coarse
    /// Alignment" submode
    /// @param[out] nSats number of GPS satellites tracked
    /// @param[out] positionFOM position figure-of-merit value
    /// @param[out] velocityFOM velocity figure-of-merit value
    /// @param[out] headingFOM heading figure-of-merit value
    /// @param[out] timeFOM time figure-of-merit value
    /// @param[out] expectedHPosError expected error in horizontal position, m
    /// @param[out] expectedVPosError expected error in vertical position, m
    /// @param[out] expectedVelocityError expected error in velocity, m/s
    void getLatest3500Data(uint64_t & time3500, uint16_t & currentMode,
            bool & insAvailable, bool & gpsAvailable, bool & doingCoarseAlignment,
            uint16_t & nSats, uint16_t &  positionFOM, uint16_t & velocityFOM,
            uint16_t & headingFOM, uint16_t & timeFOM,
            double & expectedHPosError, double & expectedVPosError,
            double & expectedVelocityError);

    /// @brief Get the latest 3501 (Navigation Solution) data available. If the 
    /// most recent 3501 message is more than 1 second old, the data values will
    /// all be zero, and the dataTime will be zero.
    /// @param[out] time3501 date/time for 3501 message data, msecs since
    /// 1970-01-01 00:00:00 UTC
    /// @param[out] latitude latitude, deg
    /// @param[out] longitude longitude, deg
    /// @param[out] altitude altitude, m above MSL
    void getLatest3501Data(uint64_t & time3501, double & latitude,
            double & longitude, double & altitude);

    /// @brief Get the latest 3512 (Flight Control) attitude data available.
    /// If the most recent 3512 message is more than 1 second old, the data 
    /// values will all be zero, and the dataTime will be zero.
    /// @param[out] time3512 date/time for 3512 message, msecs since
    /// 1970-01-01 00:00:00 UTC
    /// @param[out] pitch pitch, deg
    /// @param[out] roll roll, deg
    /// @param[out] heading heading, deg clockwise from true north
    /// @param[out] velNorth north component of velocity, m/s
    /// @param[out] velEast east component of velocity, m/s
    /// @param[out] velUp upward component of velocity, m/s
    void getLatest3512Data(uint64_t & time3512, double & pitch, double & roll,
            double & heading, double & velNorth, double & velEast,
            double & velUp);

    /// @brief Get the time of the latest 3500 (System Status) data, in
    /// milliseconds since 1970-01-01 00:00:00 UTC.
    ///
    /// This method is inlined, since it may be called very frequently.
    /// @return the time of the latest 3500 (System Status) data, in
    /// milliseconds since 1970-01-01 00:00:00 UTC.
    uint64_t getLatest3500Time() { return(getLatestMsg().time3500); }

    /// @brief Get the time of the latest 3501 (Navigation Solution) data, in
    /// milliseconds since 1970-01-01 00:00:00 UTC.
    ///
    /// This method is inlined, since it may be called very frequently.
    /// @return the time of the latest 3501 (Navigation Solution) data, in
    /// milliseconds since 1970-01-01 00:00:00 UTC.
    uint64_t getLatest3501Time() { return(getLatestMsg().time3501); }

    /// @brief Get the time of the latest 3512 (Flight Control) data, in
    /// milliseconds since 1970-01-01 00:00:00 UTC.
    ///
    /// This method is inlined, since it may be called very frequently.
    /// @return the time of the latest 3512 (Flight Control) data, in
    /// milliseconds since 1970-01-01 00:00:00 UTC.
    uint64_t getLatest3512Time() { return(getLatestMsg().time3512); }

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
    /// @brief Store the latest 3500 (System Status) data.
    /// @param time3500 date/time for 3500 message, msecs since 1970-01-01
    /// 00:00:00 UTC
    /// @param currentMode current operating mode
    /// @param insAvailable true iff INS measurements are available
    /// @param gpsAvailable true iff GPS time is valid and at least 4 satellites
    /// are being used
    /// @param doingCoarseAlignment true iff the C-MIGITS is in "Coarse 
    /// Alignment" submode
    /// @param nSats number of GPS satellites tracked
    /// @param positionFOM position figure-of-merit value
    /// @param velocityFOM velocity figure-of-merit value
    /// @param headingFOM heading figure-of-merit value
    /// @param timeFOM time figure-of-merit value
    /// @param expectedHPosError expected error in horizontal position, m
    /// @param expectedVPosError expected error in vertical position, m
    /// @param expectedVelocityError expected error in velocity, m/s
    void storeLatest3500Data(uint64_t time3500, uint16_t currentMode,
            bool insAvailable, bool gpsAvailable, bool doingCoarseAlignment,
            uint16_t nSats, uint16_t positionFOM, uint16_t velocityFOM,
            uint16_t headingFOM, uint16_t timeFOM,
            double expectedHPosError, double expectedVPosError,
            double expectedVelocityError);

    /// @brief Store the latest 3501 (Navigation Solution) data.
    /// @param time3501 date/time for 3501 message, msecs since
    /// 1970-01-01 00:00:00 UTC
    /// @param latitude latitude, deg
    /// @param longitude longitude, deg
    /// @param altitude altitude, m above MSL
    void storeLatest3501Data(uint64_t time3501, double latitude,
            double longitude, double altitude);

    /// @brief Store the latest 3512 (Flight Control) data.
    /// @param time3512 date/time for 3512 message, msecs since
    /// 1970-01-01 00:00:00 UTC
    /// @param pitch pitch, deg
    /// @param roll roll, deg
    /// @param heading heading, deg clockwise from true north
    /// @param velNorth north component of velocity, m/s
    /// @param velEast east component of velocity, m/s
    /// @param velUp upward component of velocity, m/s
    void storeLatest3512Data(uint64_t time3512, double pitch, double roll,
            double heading, double velNorth, double velEast,
            double velUp);
    
private slots:
    /// @brief Write a new message to the FMQ with 3500 data zeroed.
    void _zero3500Data();
    
    /// @brief Write a new message to the FMQ with 3501 data zeroed.
    void _zero3501Data();
    
    /// @brief Write a new message to the FMQ with 3512 data zeroed.
    void _zero3512Data();

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
    
    /// Timeout timer for 3500 data, used only by the writer instance
    QTimer _3500TimeoutTimer;
    /// Timeout timer for 3501 data, used only by the writer instance
    QTimer _3501TimeoutTimer;
    /// Timeout timer for 3512 data, used only by the writer instance
    QTimer _3512TimeoutTimer;
    /// MsgStruct which contains the latest data from the C-MIGITS, used only 
    /// by the writer instance
    MsgStruct _currentMsg;
};

#endif /* CMIGITSFMQ_H_ */
