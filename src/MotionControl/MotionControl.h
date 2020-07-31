// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
// ** Copyright UCAR (c) 1990 - 2016                                         
// ** University Corporation for Atmospheric Research (UCAR)                 
// ** National Center for Atmospheric Research (NCAR)                        
// ** Boulder, Colorado, USA                                                 
// ** BSD licence applies - redistribution and use in source and binary      
// ** forms, with or without modification, are permitted provided that       
// ** the following conditions are met:                                      
// ** 1) If the software is modified to produce derivative works,            
// ** such modified software should be clearly marked, so as not             
// ** to confuse it with the version available from UCAR.                    
// ** 2) Redistributions of source code must retain the above copyright      
// ** notice, this list of conditions and the following disclaimer.          
// ** 3) Redistributions in binary form must reproduce the above copyright   
// ** notice, this list of conditions and the following disclaimer in the    
// ** documentation and/or other materials provided with the distribution.   
// ** 4) Neither the name of UCAR nor the names of its contributors,         
// ** if any, may be used to endorse or promote products derived from        
// ** this software without specific prior written permission.               
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS  
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED      
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.    
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* 
/*
 * MotionControl.h
 *
 *  Created on: May 30, 2013
 *      Author: Xuanyong Xu
 */

#ifndef MOTIONCONTROL_H_
#define MOTIONCONTROL_H_

#include <QtCore>
#include <QtNetwork>
#include <xmlrpc-c/base.hpp>
#include <boost/serialization/nvp.hpp>
//#include <boost/serialization/version.hpp>

#include "CmigitsFmq.h"
#include "RotServoDrive.h"
#include "TiltServoDrive.h"

class MotionControl : public QObject
{
    Q_OBJECT

public:
    /// @brief Constructor
    MotionControl();
    /// @brief Destructor
    virtual ~MotionControl();

    /// @brief Find the home index position for each drive, setting the given
    /// count values at the home locations. Home index is defined as the first
    /// motor index mark in a positive direction from the home sensor of the
    /// motor.
    ///
    /// Mode is set to point to 0 degrees when this method completes, so any
    /// previously set scanning/pointing mode is overridden. The method will
    /// generally return before homing is actually completed.
    /// @param rotHomeCounts the count value to assign at rotation drive's home
    /// index
    /// @param tiltHomeCounts the count value to assign at tilt drive's home
    /// index
    void homeDrive(int rotHomeCounts, int tiltHomeCounts);

    /// @brief Point the antenna to a specific angle
    /// @param angle The angle that the antenna points to
    void point(double angle);

    /// @brief Scan the antenna between the given counterclockwise and clockwise
    /// limits, at the given scan rate.
    /// @param ccwLimit the counterclockwise limit of the scan, deg
    /// @param cwLimit the clockwise limit of the scan, deg
    /// @param scanRate the scan rate, deg/s
    /// @param beamTilt beam tilt angle, deg
    void scan(double ccwLimit, double cwLimit, double scanRate, double beamTilt);

    /// @brief Return a reference to the rotation drive.
    /// @return a reference to the rotation drive.
    const ElmoServoDrive & rotationDrive() const { return(_rotDrive); }

    /// @brief Return a reference to the tilt drive.
    /// @return a reference to the tilt drive.
    const ElmoServoDrive & tiltDrive() const { return(_tiltDrive); }

    /// Antenna motion mode: pointing or scanning
    typedef enum {
        MODE_POINTING,
        MODE_SCANNING,
        MODE_UNDEFINED
    } AntennaMode;

    /// @brief Return the current antenna mode.
    /// @return the current antenna mode.
    AntennaMode antennaMode() const { return(_antennaMode); }

    /// @brief Return the fixed pointing angle, deg.
    /// @return the fixed pointing angle, deg.
    double fixedPointingAngle() const { return(_fixedPointingAngle); }

    /// @brief Return the antenna scanning parameters
    /// @param[out] ccwLimit counterclockwise scan limit, deg
    /// @param[out] cwLimit clockwise scan limit, deg
    /// @param[out] scanRate scan rate, deg/s
    /// @param[out] beamTilt beam tilt angle, deg
    /// @return the antenna scanning parameters.
    void getScanParams(double & ccwLimit, double & cwLimit, double & scanRate,
            double & beamTilt) const {
        ccwLimit = _scanCcwLimit;
        cwLimit = _scanCwLimit;
        scanRate = _scanRate;
        beamTilt = _scanBeamTilt;
    }

    /// @brief Set the state of attitude correction.
    /// @param enabled true to enable attitude correction, false to disable
    void setCorrectionEnabled(bool enabled);

    /// @brief Return true iff attitude correction is enabled.
    /// @return true iff attitude correction is enabled.
    bool attitudeCorrectionEnabled() const { return(_attitudeCorrectionEnabled); }

    /// @brief Return true iff homing is in progress for either drive.
    /// @return true iff homing is in progress for either drive.
    bool homingInProgress() const {
        return(_rotDrive.homingInProgress() || _tiltDrive.homingInProgress());
    }

    /// @brief Return the current insInUse value, either 1 or 2
    /// @return the current insInUse value, either 1 or 2
    int insInUse() const {
        return(_insInUse);
    }

    /// @brief Set the INS in use for attitude correction: 1 or 2
    /// @param insInUse integer selecting the INS in use for attitude
    /// correction, either 1 or 2
    /// @return the new insInUse value
    void setInsInUse(int insInUse);

    /// @brief Simple class to encapsulate status of a MotionControl object.
    class Status {
    public:
        /// @brief Default constructor.
        Status();

        /// @brief Construct status using current values from the given
        /// MotionControl.
        Status(const MotionControl & mc);

        /// @brief Construct from an xmlrpc_c::value_struct dictionary as returned
        /// by a call to the Status::to_value_struct() method.
        /// @param statusDict an xmlrpc_c::value_struct dictionary as returned by a
        /// call to the Status::to_value_struct() method.
        Status(xmlrpc_c::value_struct & statusDict);

        /// @brief destructor
        virtual ~Status();

        /// @brief Return an external representation of the object's state as
        /// an xmlrpc_c::value_struct dictionary.
        ///
        /// The returned value can be used on the other side of an XML-RPC
        /// connection to create an identical object via the
        /// Status(const xmlrpc_c::value_struct &) constructor.
        /// @return an external representation of the object's state as
        /// an xmlrpc_c::value_struct dictionary.
        xmlrpc_c::value toXmlRpcValue() const;

        /// @brief Return antenna scanning parameters.
        /// @param[out] ccwLimit the counterclockwise scan limit, deg
        /// @param[out] cwLimit the clockwise scan limit, deg
        /// @param[out] rate the scan rate, deg/s
        /// @param[out] beamTilt the beam tilt angle, deg
        void scanParameters(double & ccwLimit, double & cwLimit, double & rate,
                double & beamTilt) {
            ccwLimit = scanCcwLimit;
            cwLimit = scanCwLimit;
            rate = scanRate;
            beamTilt = scanBeamTilt;
        }

        /// @brief Serialize our members to a boost save (output) archive or
        /// populate our members from a boost load (input) archive.
        /// @param ar the archive to load from or save to.
        /// @param version the version
        template<class Archive>
        void serialize(Archive & ar, const unsigned int version) {
            ar & BOOST_SERIALIZATION_NVP(rotDriveResponding);
            ar & BOOST_SERIALIZATION_NVP(rotDriveInhibitActive);
            ar & BOOST_SERIALIZATION_NVP(rotDriveInitialized);
            ar & BOOST_SERIALIZATION_NVP(rotDriveHomed);
            ar & BOOST_SERIALIZATION_NVP(rotDriveStatusReg);
            ar & BOOST_SERIALIZATION_NVP(rotDriveTemp);
            ar & BOOST_SERIALIZATION_NVP(rotDriveAngle);
            ar & BOOST_SERIALIZATION_NVP(rotDriveSystemTime);
            ar & BOOST_SERIALIZATION_NVP(tiltDriveResponding);
            ar & BOOST_SERIALIZATION_NVP(tiltDriveInhibitActive);
            ar & BOOST_SERIALIZATION_NVP(tiltDriveInitialized);
            ar & BOOST_SERIALIZATION_NVP(tiltDriveHomed);
            ar & BOOST_SERIALIZATION_NVP(tiltDriveStatusReg);
            ar & BOOST_SERIALIZATION_NVP(tiltDriveTemp);
            ar & BOOST_SERIALIZATION_NVP(tiltDriveAngle);
            ar & BOOST_SERIALIZATION_NVP(tiltDriveSystemTime);
            ar & BOOST_SERIALIZATION_NVP(antennaMode);
            ar & BOOST_SERIALIZATION_NVP(fixedPointingAngle);
            ar & BOOST_SERIALIZATION_NVP(scanCcwLimit);
            ar & BOOST_SERIALIZATION_NVP(scanCwLimit);
            ar & BOOST_SERIALIZATION_NVP(scanRate);
            ar & BOOST_SERIALIZATION_NVP(scanBeamTilt);
            ar & BOOST_SERIALIZATION_NVP(attitudeCorrectionEnabled);
            ar & BOOST_SERIALIZATION_NVP(insInUse);
        }
        /// Is the rotation drive responding?
        bool rotDriveResponding;
        /// Is external inhibit active for the rotation drive?
        bool rotDriveInhibitActive;
        /// Is the rotation drive initialized?
        bool rotDriveInitialized;
        /// Is the rotation drive homed?
        bool rotDriveHomed;
        /// Rotation drive status register
        ElmoServoDrive::StatusReg rotDriveStatusReg;
        /// Rotation drive temperature, deg C
        int rotDriveTemp;
        /// Rotation angle, deg
        double rotDriveAngle;
        /// Rotation drive system time (at last status collection)
        uint32_t rotDriveSystemTime;
        /// Is the tilt drive responding?
        bool tiltDriveResponding;
        /// Is external inhibit active for the tilt drive?
        bool tiltDriveInhibitActive;
        /// Is the tilt drive initialized?
        bool tiltDriveInitialized;
        /// Is the tilt drive homed?
        bool tiltDriveHomed;
        /// Tilt drive status register
        ElmoServoDrive::StatusReg tiltDriveStatusReg;
        /// Tilt drive temperature, deg C
        int tiltDriveTemp;
        /// Tilt angle, deg
        double tiltDriveAngle;
        /// Rotation drive system time (at last status collection)
        uint32_t tiltDriveSystemTime;
        /// Antenna motion mode
        AntennaMode antennaMode;
        // Pointing angle for POINTING mode
        double fixedPointingAngle;
        // Scanning counterclockwise limit, deg
        double scanCcwLimit;
        // Scanning clockwise limit, deg
        double scanCwLimit;
        // Scan rate, deg/s
        double scanRate;
        // Beam tilt, deg
        double scanBeamTilt;
        // Attitude correction enabled?
        bool attitudeCorrectionEnabled;
        // INS in use if attitude correction is enabled: either 1 or 2
        int insInUse;
    };

    /// @brief Return a MotionControl::Status object containing current
    /// status.
    /// @return a MotionControl::Status object containing current status.
    Status status() const { return(Status(*this)); }

public slots:
    /// @brief Get current aircraft attitude and adjust drive position.
    /// This method does nothing when attitude correction is disabled.
    void correctForAttitude();

private:
    // Given desired rotation and tilt angles, adjust to pod-relative angles
    // using the given pod attitude information.
    // @param[in,out] rot the desired rotation angle (in), and the needed
    //	 pod-relative rotation angle (out), deg
    // @param[in,out] tilt the desired tilt angle (in), and the needed
    //   pod-relative tilt angle (out), deg
    // @param pitch the pod pitch, deg
    // @param roll the pod roll angle, deg
    // @param drift the pod drift angle, deg
    void _adjustForAttitude(double & rot, double & tilt, double pitch, double roll,
            double drift);

    /// Adjust pointing position according to aircraft attitude
    /// @param pitch The aircraft pitch angle
    /// @param roll The aircraft roll angle
    /// @param drift The aircraft drift angle
  void _adjustPointingForAttitude(double pitch, double roll, double hdg, double drift);

    /// Adjust scanning table according to aircraft attitude
    /// @param pitch The aircraft pitch angle
    /// @param roll The aircraft roll angle
    /// @param drift The aircraft drift angle
  void _adjustScanningForAttitude(double pitch, double roll, double hdg, double drift);
    
    // compute (elevation, azimuth) from attitude, rotation, tilt
    // For a Y-prime radar e.g. HCR
    // angles are passed in/out in degrees
    void _computeAzElYPrime(double pitch, double roll, double hdg, 
                            double rot, double tilt,
                            double &el, double &az);

    // compute (rotation, tilt) from attitude, elevation, azimuth
    // For a Y-prime radar e.g. HCR
    // angles are passed in/out in degrees
    void _computeRotTiltYPrime(double pitch, double roll, double hdg, 
                               double el, double az,
                               double &rot, double &tilt);

    /// Rotation drive
    RotServoDrive _rotDrive;
    /// Tilt drive
    TiltServoDrive _tiltDrive;

    /// Current antenna mode
    AntennaMode _antennaMode;

    /// Current angle for fixed pointing
    double _fixedPointingAngle;

    /// Scanning counterclockwise limit, deg
    double _scanCcwLimit;

    /// Scanning clockwise limit, deg
    double _scanCwLimit;

    /// Scan rate, deg/s
    double _scanRate;
    
    /// Beam tilt angle, deg
    double _scanBeamTilt;
    
    /// FMQ for data from INS1
    CmigitsFmq _ins1Fmq;

    /// FMQ for data from INS2
    CmigitsFmq _ins2Fmq;

    /// Is attitude correction enabled?
    bool _attitudeCorrectionEnabled;

    /// Are we generating fake attitude values?
    bool _fakeAttitude;

    /// Drive "start" time (object instantiation time), used when generating
    /// fake attitude.
    QTime _driveStartTime;

    /// INS in use for attitude correction: 1 if using INS1, or 2 if using INS2.
    int _insInUse;

    /// controlling debug print
    time_t _timeLastDebugPrint;

};

#endif /* MOTIONCONTROL_H_ */
