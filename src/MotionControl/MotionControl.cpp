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
 * MotionControl.cpp
 *
 *  Created on: May 30, 2013
 *      Author: Xuanyong Xu
 */

#include "MotionControl.h"
#include <HcrSharedResources.h>
#include <unistd.h>
#include <iostream>
#include <Archive_xmlrpc_c.h>
#include <logx/Logging.h>

LOGGING("MotionControl")

inline double DegToRad(double deg) { return(M_PI * deg / 180.0); }
inline double RadToDeg(double rad) { return(180.0 * rad / M_PI); }

/// Rotation drive CANopen node ID (used for CAN connection constructor) and
/// TTY device name (used for TTY connection constructor)
static const int ROT_DRIVE_CANOPEN_ID = 126;
//static const std::string ROT_DRIVE_TTYDEV = "/dev/ttydp00";

/// Tilt drive CANopen node ID (used for CAN connection constructor) and
/// TTY device name (used for TTY connection constructor)
static const int TILT_DRIVE_CANOPEN_ID = 125;
//static const std::string TILT_DRIVE_TTYDEV = "/dev/ttydp01";

/////////////////////////////////////////////////////////////////////
MotionControl::MotionControl() :
    _rotDrive(ROT_DRIVE_CANOPEN_ID),
//    _rotDrive(ROT_DRIVE_TTYDEV),
    _tiltDrive(TILT_DRIVE_CANOPEN_ID),
//    _tiltDrive(TILT_DRIVE_TTYDEV),
    _antennaMode(MODE_POINTING),
    _fixedPointingAngle(0.0),
    _scanBeamTilt(0.0),
    _ins1Fmq(INS1_FMQ_URL),
    _ins2Fmq(INS2_FMQ_URL),
    _attitudeCorrectionEnabled(false),
    _fakeAttitude(false),
    _driveStartTime(QTime::currentTime()),
//    _insInUse(1)
    _insInUse(2)
{
    // Start with attitude correction enabled.
    setCorrectionEnabled(true);
    _timeLastDebugPrint = time(NULL);
    ILOG << "Starting out using INS " << _insInUse;
}

/////////////////////////////////////////////////////////////////////
MotionControl::~MotionControl()
{
}

/////////////////////////////////////////////////////////////////////
void MotionControl::correctForAttitude()
{
    // Ignore if attitude correction is disabled
    if (! _attitudeCorrectionEnabled) {
        DLOG << "Attitude correction is currently disabled";
        return;
    }
    /*
     * The pitch, roll, and heading come from CmigitsSharedMemory
     * class. Drift is derived using heading and true ground speed (also
     * available via CmigitsSharedMemory class).
     */
    // Get aircraft attitude
    uint64_t dataTime;
    double pitch = 0.0;
    double roll = 0.0;
    double heading = 0.0;
    double velNorth = 0.0;
    double velEast = 0.0;
    double velUp = 0.0;
    double drift = 0.0;

    CmigitsFmq & insFmq = (_insInUse == 1 ? _ins1Fmq : _ins2Fmq);
    if (insFmq.getWriterPid()) {
        // Get pitch, roll, and heading
        insFmq.getLatest3512Data(
                dataTime, pitch, roll, heading, velNorth, velEast, velUp
        );

        // Get drift
        drift = insFmq.getEstimatedDriftAngle();
    }

    // Substitute fake attitude if requested
    if (_fakeAttitude) {
        // How many seconds since we started the drive?
        double secsRunning = 0.001 * _driveStartTime.msecsTo(QTime::currentTime());
        if (secsRunning < 0)
            secsRunning += 86400;	// secs per day

        // Pitch the aircraft through +/- 10 deg every 3 seconds.
        pitch = 10.0 * sin(2.0 * M_PI * fmod(secsRunning / 3.0, 1.0));
        // Roll the aircraft through +/- 45 deg every 11 seconds.
        roll = 45 * sin(2.0 * M_PI * fmod(secsRunning / 11.0, 1.0));
        // Just leave drift at zero.
        drift = 0.0;
    }

    switch (_antennaMode) {
    case MODE_POINTING:
        _adjustPointingForAttitude(pitch, roll, heading, drift);
        break;
    case MODE_SCANNING:
        _adjustScanningForAttitude(pitch, roll, heading, drift);
        break;
    case MODE_UNDEFINED:
    default:
        break;
    }
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::homeDrive(int rotHomeCounts, int tiltHomeCounts)
{
    ILOG << "homeDrive";
    // Change mode to fixed pointing at 0 degrees.
    point(0.0);
    
    // Set both drives to find home position. Note that these methods return
    // before homing is complete.
    _rotDrive.homeDrive(rotHomeCounts);
    _tiltDrive.homeDrive(tiltHomeCounts);
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::point(double angle)
{
    ILOG << "Point to " << angle << " deg";
    
    // Set up for fixed antenna pointing
    _fixedPointingAngle = angle;
    _scanBeamTilt = 0.0;
    _antennaMode = MODE_POINTING;
    _rotDrive.moveTo(angle);
    _tiltDrive.moveTo(_scanBeamTilt);
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::scan(double ccwLimit, double cwLimit, double scanRate, 
        double beamTilt)
{
    _scanCcwLimit = ccwLimit;
    _scanCwLimit = cwLimit;
    _scanRate = scanRate;
    _scanBeamTilt = beamTilt;
    ILOG << "Scan from " << ccwLimit << " CCW to " << cwLimit << " CW at " <<
            scanRate << " deg/s, with beam tilt " << beamTilt << " deg";
    
    _rotDrive.initScan(ccwLimit, cwLimit, scanRate);
    
    // Tilt drive angle (This uses for the mean rotation angle only, so is
    // only good for small scan widths!)
    double tiltDriveAngle = 0.0;
    double meanRot = (cwLimit + ccwLimit) / 2;
    double sinTda = -sin(DegToRad(beamTilt / 2)) / cos(DegToRad(meanRot));
    if (sinTda >= -1.0 && sinTda <= 1.0) {
        tiltDriveAngle = RadToDeg(asin(sinTda));
    } else {
        // Catch degenerate can't-get-there-from-here cases
        if (sinTda > 0.0) {
            tiltDriveAngle = 90.0;
        } else {
            tiltDriveAngle = -90.0;
        }
    }
    _tiltDrive.moveTo(tiltDriveAngle);

    // Set up for antenna scanning
    _antennaMode = MODE_SCANNING;
    _rotDrive.scan();
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::setCorrectionEnabled(bool enabled) {
    // Are we going from attitude correction enabled to disabled?
    bool turningOff = _attitudeCorrectionEnabled && ! enabled;

    ILOG << "Attitude correction has been " << (enabled ? "enabled" : "disabled");
    _attitudeCorrectionEnabled = enabled;

    // If we were correcting and correction was just turned off, make one last
    // correction back to straight level attitude.
    if (turningOff) {
        switch (_antennaMode) {
        case MODE_POINTING:
          _adjustPointingForAttitude(0.0, 0.0, 0.0, 0.0);
            break;
        case MODE_SCANNING:
            // @TODO: Figure out how to handle this once corrected scanning
            // is implemented...
            WLOG << "***Need to implement scan cleanup when attitude correction "
                "is disabled***";
            break;
        case MODE_UNDEFINED:
        default:
            // do nothing
            break;
        }
    }
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::setInsInUse(int newInsInUse) {
    if (newInsInUse == 1 || newInsInUse == 2) {
        if (newInsInUse != _insInUse) {
            // We're changing the INS in use, so do an immediate attitude
            // correction with the new INS.
	    ILOG << "Switching from INS " << _insInUse << " to INS " << newInsInUse;
            _insInUse = newInsInUse;
            correctForAttitude();
        }
    } else {
        ELOG << "BAD new insInUse: " << newInsInUse <<
                ", keeping current insInUse: " << _insInUse;
    }
}

/////////////////////////////////////////////////////////////////////
void
MotionControl::_adjustForAttitude(double & rot, double & tilt, double pitch,
        double roll, double drift)
{
    double desiredRot = rot;
    double desiredTilt = tilt;

    double sinPitch = sin(DegToRad(pitch));
    double cosPitch = cos(DegToRad(pitch));

    double sinRoll = sin(DegToRad(roll));
    double cosRoll = cos(DegToRad(roll));

    double sinDrift = sin(DegToRad(drift));
    double cosDrift = cos(DegToRad(drift));

    // Track relative coordinates - desired beam position
    double sinPoint = sin(DegToRad(desiredRot));
    double cosPoint = cos(DegToRad(desiredRot));

    double sinTilt = sin(DegToRad(desiredTilt));
    double cosTilt = cos(DegToRad(desiredTilt));

    // Convert to track relative Cartesian coordinates
    double x_t = cosTilt * sinPoint;
    double y_t = sinTilt;
    double z_t = cosTilt * cosPoint;

    // Convert to pod relative Cartesian coordinates - adjusted beam position
    double x_a =
            x_t * (cosDrift * cosRoll - sinDrift * sinPitch * sinRoll) +
            y_t * (sinDrift + cosDrift * sinPitch * sinRoll) +
            -z_t * cosPitch * sinRoll;
    double y_a =
            -x_t * sinDrift * cosPitch +
            y_t * cosDrift * cosPitch +
            z_t * sinPitch;
    double z_a =
            x_t * (cosDrift * sinRoll + sinDrift * sinPitch * sinRoll) +
            y_t * (sinDrift * sinRoll - cosDrift * sinPitch * cosRoll) +
            z_t * cosPitch * cosRoll;

    // Convert from pod relative Cartesian coordinates to polar coordinates
    // and save the adjusted rotation and tilt angles.

    // tilt needs to be divided by 2!
    tilt = RadToDeg(asin(y_a)) / 2;

    // KLUGE: The algorithm above isn't really right. As compensation for now,
    // just change the sign of the corrected tilt if the desired rotation angle
    // points downward, i.e., if its cosine is less than zero.
    if (cosPoint < 0.0) {
        tilt *= -1;
    }

    // rotation needs to be in the range of 0-360
    rot  = RadToDeg(atan2(x_a, z_a));
    if (rot < 0) rot += 360.0;
}

#define DEBUG_POINTING

/////////////////////////////////////////////////////////////////////
void
MotionControl::_adjustPointingForAttitude(double pitch, double roll,
                                          double heading, double drift)
{

#ifdef DEBUG_POINTING

    // ORIGINAL CODE
    // Start with the desired track-relative rotation and tilt angles
    double rot0 = _fixedPointingAngle;
    double tilt0 = _scanBeamTilt;
    // Adjust to pod-relative rotation and tilt angles
    _adjustForAttitude(rot0, tilt0, pitch, roll, drift);
    // NEW - computing tiltDriveAngle, using cos(rot)
    double tiltDriveAngle0 = -tilt0 / fabs(cos(DegToRad(rot0)));
    // Move the drives to their new angles
    // NEW - don't actually use these
    // _rotDrive.moveTo(rot0);
    // _tiltDrive.moveTo(tiltDriveAngle0);

#endif

    // updated pointing code

    // specify az and el

    double el = 90.0 - _fixedPointingAngle;
    double az = heading + 90.0;
    if (az >= 360.0) {
      az -= 360.0;
    }
    
    // compute rotation and tilt
    
    double rotAngle, tiltAngle;
    _computeRotTiltYPrime(pitch, roll, heading, 
                          el, az, rotAngle, tiltAngle);
    if (rotAngle < 0) {
      rotAngle += 360.0;
    }
    
    // compute drive angles
    
    double rotDriveAngle = rotAngle;
    double tiltDriveAngle =
      -tiltAngle / (2.0 * cos(DegToRad(rotAngle)));
    // tiltDriveAngle *= 1.01; // Correct for slight under-control
    tiltDriveAngle *= 1.000; // Correct for slight under-control
    _rotDrive.moveTo(rotDriveAngle);
    _tiltDrive.moveTo(tiltDriveAngle);
    // _rotDrive.moveTo(rotDriveAngle - 0.020);
    // _tiltDrive.moveTo(tiltDriveAngle - 0.008);

#ifdef DEBUG_POINTING

    time_t now = time(NULL);
    if (now > _timeLastDebugPrint) {
      std::cerr << "==================================================" << endl;
      std::cerr << "=====>> el, az: " << el << ", " << az << endl;
      std::cerr << "=====>> rot0, rotDriveAngle: "
                << rot0 << ", " << rotDriveAngle << endl;
      std::cerr << "=====>> tilt0*2, tiltAngle: "
                << tilt0 * 2.0 << ", " << tiltAngle << endl;
      std::cerr << "=====>> tiltDriveAngle0, tiltDriveAngle: "
                << tiltDriveAngle0 << ", " << tiltDriveAngle << std::endl;
      std::cerr << "==================================================" << endl;
      _timeLastDebugPrint = now;
    }

#endif

}

/////////////////////////////////////////////////////////////////////
void
MotionControl::_adjustScanningForAttitude(double pitch, double roll, 
                                          double heading, double drift)
{
    DLOG << "_adjustScanningForAttitude not implemented";
}

/////////////////////////////////////////////////////////////////////
MotionControl::Status::Status() :
    rotDriveResponding(false),
    rotDriveInhibitActive(false),
    rotDriveInitialized(false),
    rotDriveHomed(false),
    rotDriveStatusReg(0),
    rotDriveTemp(0),
    rotDriveAngle(0.0),
    rotDriveSystemTime(0),
    tiltDriveResponding(false),
    tiltDriveInhibitActive(false),
    tiltDriveInitialized(false),
    tiltDriveHomed(false),
    tiltDriveStatusReg(0),
    tiltDriveTemp(0),
    tiltDriveAngle(0.0),
    tiltDriveSystemTime(0),
    antennaMode(MODE_POINTING),
    fixedPointingAngle(0.0),
    scanCcwLimit(0.0),
    scanCwLimit(0.0),
    scanRate(0.0),
    scanBeamTilt(0.0),
    attitudeCorrectionEnabled(false),
    insInUse(1) {}

/////////////////////////////////////////////////////////////////////
MotionControl::Status::Status(const MotionControl & mc) :
    rotDriveResponding(mc.rotationDrive().driveResponding()),
    rotDriveInhibitActive(mc.rotationDrive().inhibitActive()),
    rotDriveInitialized(mc.rotationDrive().driveInitialized()),
    rotDriveHomed(mc.rotationDrive().driveHomed()),
    rotDriveStatusReg(mc.rotationDrive().driveStatusRegister()),
    rotDriveTemp(mc.rotationDrive().driveTemperature()),
    rotDriveAngle(mc.rotationDrive().angle()),
    rotDriveSystemTime(mc.rotationDrive().driveSystemTime()),
    tiltDriveResponding(mc.tiltDrive().driveResponding()),
    tiltDriveInhibitActive(mc.tiltDrive().inhibitActive()),
    tiltDriveInitialized(mc.tiltDrive().driveInitialized()),
    tiltDriveHomed(mc.tiltDrive().driveHomed()),
    tiltDriveStatusReg(mc.tiltDrive().driveStatusRegister()),
    tiltDriveTemp(mc.tiltDrive().driveTemperature()),
    tiltDriveAngle(mc.tiltDrive().angle()),
    tiltDriveSystemTime(mc.tiltDrive().driveSystemTime()),
    antennaMode(mc.antennaMode()),
    fixedPointingAngle(mc.fixedPointingAngle()),
    attitudeCorrectionEnabled(mc.attitudeCorrectionEnabled()),
    insInUse(mc.insInUse()) {
    // Use the MotionControl::getScanParams() method to get all three scan
    // parameters
    mc.getScanParams(scanCcwLimit, scanCwLimit, scanRate, scanBeamTilt);
}

/////////////////////////////////////////////////////////////////////
MotionControl::Status::Status(xmlrpc_c::value_struct & statusDict) :
    rotDriveResponding(false),
    rotDriveInhibitActive(false),
    rotDriveInitialized(false),
    rotDriveHomed(false),
    rotDriveStatusReg(0),
    rotDriveTemp(0),
    rotDriveAngle(0.0),
    rotDriveSystemTime(0),
    tiltDriveResponding(false),
    tiltDriveInhibitActive(false),
    tiltDriveInitialized(false),
    tiltDriveHomed(false),
    tiltDriveStatusReg(0),
    tiltDriveTemp(0),
    tiltDriveAngle(0.0),
    tiltDriveSystemTime(0),
    antennaMode(MODE_POINTING),
    fixedPointingAngle(0.0),
    scanCcwLimit(0.0),
    scanCwLimit(0.0),
    scanRate(0.0),
    scanBeamTilt(0.0),
    attitudeCorrectionEnabled(false),
    insInUse(1) {
    // Create an input archiver wrapper around the xmlrpc_c::value_struct
    // dictionary, and use serialize() to populate our members from its content.
    Iarchive_xmlrpc_c iar(statusDict);
    iar >> *this;
}

/////////////////////////////////////////////////////////////////////
MotionControl::Status::~Status() {
}

/////////////////////////////////////////////////////////////////////
xmlrpc_c::value
MotionControl::Status::toXmlRpcValue() const {
    std::map<std::string, xmlrpc_c::value> statusDict;
    // Clone ourself to a non-const instance
    MotionControl::Status clone(*this);
    // Stuff our content into the statusDict, i.e., _serialize() to an
    // output archiver wrapped around the statusDict.
    Oarchive_xmlrpc_c oar(statusDict);
    oar << clone;
    // Finally, return the statusDict
    return(xmlrpc_c::value_struct(statusDict));
}

///////////////////////////////////////////////////////////////////
// compute (elevation, azimuth) from attitude, rotation, tilt
// For a Y-prime radar e.g. HCR
// angles are passed in/out in degrees

void MotionControl::_computeAzElYPrime(double pitch, double roll, double hdg, 
                                       double rot, double tilt,
                                       double &el, double &az)
{

  // precompute sin/cos
  
  double sinPitch = sin(DegToRad(pitch));
  double cosPitch = cos(DegToRad(pitch));
    
  double sinRoll = sin(DegToRad(roll));
  double cosRoll = cos(DegToRad(roll));
    
  double sinHdg = sin(DegToRad(hdg));
  double cosHdg = cos(DegToRad(hdg));

  double sinRot = sin(DegToRad(rot));
  double cosRot = cos(DegToRad(rot));
    
  double sinTilt = sin(DegToRad(tilt));
  double cosTilt = cos(DegToRad(tilt));

  // compute unit vector relative to aircraft
  
  double x_a = sinRot * cosTilt;
  double y_a = sinTilt;
  double z_a = cosRot * cosTilt;

  // compute matrix elements after multiplication
  // for 3 axis transformation
  
  double mf11 = cosHdg * cosRoll + sinHdg * sinPitch * sinRoll;
  double mf12 = sinHdg * cosPitch;
  double mf13 = cosHdg * sinRoll - sinHdg * sinPitch * cosRoll;

  double mf21 = -sinHdg * cosRoll + cosHdg * sinPitch * sinRoll;
  double mf22 = cosHdg * cosPitch;
  double mf23 = -sinHdg * sinRoll - cosHdg * sinPitch * cosRoll;

  double mf31 = -cosPitch * sinRoll;
  double mf32 = sinPitch;
  double mf33 = cosPitch * cosRoll;

  // Compute unit vector in earth coords
  
  double xx = mf11 * x_a + mf12 * y_a + mf13 * z_a;
  double yy = mf21 * x_a + mf22 * y_a + mf23 * z_a;
  double zz = mf31 * x_a + mf32 * y_a + mf33 * z_a;

  // compute az and el

  el = RadToDeg(asin(zz));
  az = RadToDeg(atan2(xx, yy));

  // if el is NAN then it is either +90 or -90

  if (std::isnan(el)) {
    if (zz > 0) {
      el = 90.0;
      az = 0.0;
    } else if (zz < 0) {
      el = -90.0;
      az = 0.0;
    }
  }

}

///////////////////////////////////////////////////////////////////
// compute (rotation, tilt) from attitude, elevation, azimuth
// For a Y-prime radar e.g. HCR
// angles are passed in/out in degrees

void MotionControl::_computeRotTiltYPrime(double pitch, double roll, double hdg, 
                                          double el, double az,
                                          double &rot, double &tilt)
{

  // precompute sin/cos
  
  double sinPitch = sin(DegToRad(pitch));
  double cosPitch = cos(DegToRad(pitch));
    
  double sinRoll = sin(DegToRad(roll));
  double cosRoll = cos(DegToRad(roll));

  double sinHdg = sin(DegToRad(hdg));
  double cosHdg = cos(DegToRad(hdg));

  double sinEl = sin(DegToRad(el));
  double cosEl = cos(DegToRad(el));
    
  double sinAz = sin(DegToRad(az));
  double cosAz = cos(DegToRad(az));

  // compute unit vector relative to aircraft

  double xx = sinAz * cosEl;
  double yy = cosAz * cosEl;
  double zz = sinEl;

  // compute matrix elements after multiplication
  // for 3 axis transformation
  
  double mr11 = cosRoll * cosHdg + sinRoll * sinPitch * sinHdg;
  double mr12 = -cosRoll * sinHdg + sinRoll * sinPitch * cosHdg;
  double mr13 = -sinRoll * cosPitch;

  double mr21 = cosPitch * sinHdg;
  double mr22 = cosPitch * cosHdg;
  double mr23 = sinPitch;

  double mr31 = sinRoll * cosHdg - cosRoll * sinPitch * sinHdg;
  double mr32 = -sinRoll * sinHdg - cosRoll * sinPitch * cosHdg;
  double mr33 = cosRoll * cosPitch;

  // Compute unit vector in earth coords

  double x_a = mr11 * xx + mr12 * yy + mr13 * zz;
  double y_a = mr21 * xx + mr22 * yy + mr23 * zz;
  double z_a = mr31 * xx + mr32 * yy + mr33 * zz;

  // compute rot and tilt

  tilt = RadToDeg(asin(y_a));
  rot =  RadToDeg(atan2(x_a, z_a));

  if (std::isnan(tilt)) {
    if (y_a > 0) {
      tilt = 90.0;
      rot = 0.0;
    } else if (y_a < 0) {
      tilt = -90.0;
      rot = 0.0;
    }
  }

}

