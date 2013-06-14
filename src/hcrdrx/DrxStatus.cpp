/*
 * DrxStatus.cpp
 *
 *  Created on: Sep 6, 2012
 *      Author: hcr
 */

#include "DrxStatus.h"
#include "HcrPmc730.h"
#include "XmlRpcValueArchive.h"
#include <logx/Logging.h>
#include <iomanip>

LOGGING("DrxStatus")

// Static instance for access to shared memory containing C-MIGITS data
CmigitsSharedMemory * DrxStatus::_CmigitsShm = 0;

// Static temperature lists
DrxStatus::TemperatureList DrxStatus::_PloTemps;
DrxStatus::TemperatureList DrxStatus::_EikTemps;
DrxStatus::TemperatureList DrxStatus::_VLnaTemps;
DrxStatus::TemperatureList DrxStatus::_HLnaTemps;
DrxStatus::TemperatureList DrxStatus::_PolarizationSwitchTemps;
DrxStatus::TemperatureList DrxStatus::_RfDetectorTemps;
DrxStatus::TemperatureList DrxStatus::_NoiseSourceTemps;
DrxStatus::TemperatureList DrxStatus::_Ps28VTemps;
DrxStatus::TemperatureList DrxStatus::_RdsInDuctTemps;
DrxStatus::TemperatureList DrxStatus::_RotationMotorTemps;
DrxStatus::TemperatureList DrxStatus::_TiltMotorTemps;
DrxStatus::TemperatureList DrxStatus::_CmigitsTemps;
DrxStatus::TemperatureList DrxStatus::_TailconeTemps;


DrxStatus::DrxStatus() :
    _ploTemp(-99.9),
    _eikTemp(-99.9),
    _vLnaTemp(-99.9),
    _hLnaTemp(-99.9),
    _polarizationSwitchTemp(-99.9),
    _rfDetectorTemp(-99.9),
    _noiseSourceTemp(-99.9),
    _ps28VTemp(-99.9),
    _rdsInDuctTemp(-99.9),
    _rotationMotorTemp(-99.9),
    _tiltMotorTemp(-99.9),
    _cmigitsTemp(-99.9),
    _tailconeTemp(-99.9),
    _detectedRfPower(-99.9),
    _pvAftPressure(-99.9),
    _pvForePressure(-99.9),
    _psVoltage(-99.9),
    _noiseSourceSelected(false),
    _terminationSelected(false),
    _locked15_5GHzPLO(false),
    _locked1250MHzPLO(false),
    _locked125MHzPLO(false),
    _modPulseDisabled(false),
    _rdsXmitterFilamentOn(false),
    _rdsXmitterHvOn(false),
    _radarPowerError(false),
    _emsPowerError(false),
    _waveguideSwitchError(false),
    _emsErrorCount(0),
    _emsError1(false),
    _emsError2(false),
    _emsError3(false),
    _emsError4Or5(false),
    _emsError6Or7(false),
    _pentekFpgaTemp(-99.9),
    _pentekBoardTemp(-99.9),
    _hmcMode(0),
    _cmigitsStatusTime(0.0),
    _cmigitsCurrentMode(0),
    _cmigitsNSats(0),
    _cmigitsInsAvailable(false),
    _cmigitsGpsAvailable(false),
    _cmigitsDoingCoarseAlignment(false),
    _cmigitsPositionFOM(0),
    _cmigitsVelocityFOM(0),
    _cmigitsHeadingFOM(0),
    _cmigitsTimeFOM(0),
    _cmigitsHPosError(0.0),
    _cmigitsVPosError(0.0),
    _cmigitsVelocityError(0.0),
    _cmigitsNavSolutionTime(0.0),
    _cmigitsLatitude(0.0),
    _cmigitsLongitude(0.0),
    _cmigitsAltitude(0.0),
    _cmigitsVelNorth(0.0),
    _cmigitsVelEast(0.0),
    _cmigitsVelUp(0.0),
    _cmigitsAttitudeTime(0.0),
    _cmigitsPitch(0.0),
    _cmigitsRoll(0.0),
    _cmigitsHeading(0.0) {
}

DrxStatus::DrxStatus(const Pentek::p7142 & pentek) {
    _getMultiIoValues();
    _getPentekValues(pentek);
    _getCmigitsValues();
}

DrxStatus::DrxStatus(XmlRpcValue & statusDict) {
    // Create an input archiver wrapper around the XmlRpcValue dictionary,
    // and use serialize() to populate our members from its content.
    XmlRpcValueIarchive iar(statusDict);
    iar >> *this;
}

DrxStatus::~DrxStatus() {
}

XmlRpcValue
DrxStatus::toXmlRpcValue() const {
    XmlRpcValue statusDict;
    // Clone ourself to a non-const instance
    DrxStatus clone(*this);
    // Stuff our content into the statusDict, i.e., _serialize() to an 
    // output archiver wrapped around the statusDict.
    XmlRpcValueOarchive oar(statusDict);
    oar << clone;
    // Finally, return the statusDict
    return(statusDict);
}

void
DrxStatus::_getMultiIoValues() {
    // Load current analog values from the PMC-730
    HcrPmc730::updateAnalogValues();
    
    // Get various temperatures from sensors connected to the PMC-730. The data 
    // are a bit noisy, so we keep up to TemperatureList::_MAX_SIZE samples so 
    // we can generate moving averages.
    _PloTemps.addTemperature(HcrPmc730::ploTemperature());
    _EikTemps.addTemperature(HcrPmc730::eikTemperature());
    _VLnaTemps.addTemperature(HcrPmc730::vLnaTemperature());
    _HLnaTemps.addTemperature(HcrPmc730::hLnaTemperature());
    _PolarizationSwitchTemps.addTemperature(HcrPmc730::polSwitchTemperature());
    _RfDetectorTemps.addTemperature(HcrPmc730::rfDetectorTemperature());
    _NoiseSourceTemps.addTemperature(HcrPmc730::noiseSourceTemperature());
    _Ps28VTemps.addTemperature(HcrPmc730::ps28vTemperature());
    _RdsInDuctTemps.addTemperature(HcrPmc730::rdsInDuctTemperature());
    _CmigitsTemps.addTemperature(HcrPmc730::cmigitsTemperature());
    _TiltMotorTemps.addTemperature(HcrPmc730::tiltMotorTemperature());
    _RotationMotorTemps.addTemperature(HcrPmc730::rotMotorTemperature());
    _TailconeTemps.addTemperature(HcrPmc730::tailconeTemperature());

    // Save the current averaged temperatures
    _ploTemp = _PloTemps.mean();
    _eikTemp = _EikTemps.mean();
    _vLnaTemp = _VLnaTemps.mean();
    _hLnaTemp = _HLnaTemps.mean();
    _polarizationSwitchTemp = _PolarizationSwitchTemps.mean();
    _rfDetectorTemp = _RfDetectorTemps.mean();
    _noiseSourceTemp = _NoiseSourceTemps.mean();
    _ps28VTemp = _Ps28VTemps.mean();
    _rdsInDuctTemp = _RdsInDuctTemps.mean();
    _cmigitsTemp = _CmigitsTemps.mean();
    _tiltMotorTemp = _TiltMotorTemps.mean();
    _rotationMotorTemp = _RotationMotorTemps.mean();
    _tailconeTemp = _TailconeTemps.mean();
    
    // Other status from the PMC-730
    _detectedRfPower = HcrPmc730::detectedRfPower();
    _pvAftPressure = HcrPmc730::pvAftPressure();
    _pvForePressure = HcrPmc730::pvForePressure();
    _psVoltage = HcrPmc730::ps5vVoltage();
    _locked15_5GHzPLO = HcrPmc730::locked15_5GHzPLO();
    _locked1250MHzPLO = HcrPmc730::locked1250MHzPLO();
    _locked125MHzPLO = HcrPmc730::locked125MHzPLO();
    _modPulseDisabled = HcrPmc730::modPulseDisabled();
    _emsErrorCount = HcrPmc730::getEmsErrorCount();
    _emsError1 = HcrPmc730::emsError1();
    _emsError2 = HcrPmc730::emsError2();
    _emsError3 = HcrPmc730::emsError3();
    _emsError4Or5 = HcrPmc730::emsError4Or5();
    _emsError6Or7 = HcrPmc730::emsError6Or7();
    _emsPowerError = HcrPmc730::emsPowerError();
    _radarPowerError = HcrPmc730::radarPowerError();
    _waveguideSwitchError = HcrPmc730::waveguideSwitchError();
    _rdsXmitterFilamentOn = HcrPmc730::xmitterFilamentOn();
    _rdsXmitterHvOn = HcrPmc730::xmitterHvOn();
    _hmcMode = HcrPmc730::hmcMode();
    
    // Raise the 'status_ack' line on the HMC briefly so that it will reset
    // status values for which it does sense-and-hold.
    HcrPmc730::ackHmcStatus();

    // Reset the EMS error counter
    HcrPmc730::resetEmsErrorCount();
}

void
DrxStatus::_getPentekValues(const Pentek::p7142 & pentek) {
    _pentekFpgaTemp = pentek.fpgaTemp();
    _pentekBoardTemp = pentek.circuitBoardTemp();
}

void
DrxStatus::_getCmigitsValues() {
    // Instantiate the static instance of read-only CmigitsSharedMemory if it
    // hasn't happened yet.
    if (! _CmigitsShm) {
        _CmigitsShm = new CmigitsSharedMemory(false);
    }
    
    // Times from the C-MIGITS shared memory are 64-bit unsigned milliseconds
    // since 1970-01-01 00:00:00 UTC
    uint64_t dataTime;
    
    // Get status data
    _CmigitsShm->getLatest3500Data(dataTime, _cmigitsCurrentMode,
            _cmigitsInsAvailable, _cmigitsGpsAvailable, 
            _cmigitsDoingCoarseAlignment,_cmigitsNSats,
            _cmigitsPositionFOM, _cmigitsVelocityFOM, _cmigitsHeadingFOM, _cmigitsTimeFOM,
            _cmigitsHPosError, _cmigitsVPosError, _cmigitsVelocityError);
    _cmigitsStatusTime = dataTime * 0.001;      // ms -> s
    
    // Get navigation solution data
    _CmigitsShm->getLatest3501Data(dataTime, _cmigitsLatitude, _cmigitsLongitude,
            _cmigitsAltitude, _cmigitsVelNorth, _cmigitsVelEast, _cmigitsVelUp);
    _cmigitsNavSolutionTime = dataTime * 0.001; // ms -> s

    // Get attitude data
    _CmigitsShm->getLatest3512Data(dataTime, _cmigitsPitch, _cmigitsRoll,
            _cmigitsHeading);
    _cmigitsAttitudeTime = dataTime * 0.001;    // ms -> s
}
