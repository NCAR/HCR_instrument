/*
 * ProductArchiver.cpp
 *
 *  Created on: May 5, 2010
 *      Author: burghart
 */
#include "ProductArchiver.h"
#include "ProductAdapter.h"

#include <svnInfo.h>

#include <sstream>
#include <sys/stat.h>
#include <cerrno>
#include <cstring>

#include <dds/DCPS/Service_Participant.h>    // for TheServiceParticipant
#include <boost/date_time/posix_time/posix_time.hpp>

#include <hcrddsSysHskp.h>

#include <Radx/RadxRcalib.hh>
#include <Radx/RadxTime.hh>

ProductArchiver::ProductArchiver(DDSSubscriber& subscriber, 
        std::string topicName, std::string dataDir, uint raysPerFile,
        RadxFile::file_format_t fileFormat,
        const string &calFilePath) :
            ProductReader(subscriber, topicName),
            _dataDir(dataDir),
            _raysPerFile(raysPerFile),
            _radxFile(),
            _radxVol(),
            _raysRead(0),
            _raysWritten(0),
            _bytesWritten(0),
            _calFilePath(calFilePath) {

    ACE_Guard<ACE_Recursive_Thread_Mutex> guard(_mutex);
    
    // Make sure our destination directory has a trailing slash
    if (_dataDir[_dataDir.length() - 1] != '/')
        _dataDir += "/";

    // read in cal file
    _readCalFile();

    // Write files in the selected format, using the volume start time
    // to names files.
    _radxFile.setFileFormat(fileFormat);
    _radxFile.setWriteUsingEndTime(false);
    
    // Do basic initialization for _radxVol
    _initVolume();

}

ProductArchiver::~ProductArchiver() {
    ACE_Guard<ACE_Recursive_Thread_Mutex> guard(_mutex);
    
    std::string filetype = _radxFile.getFileFormatAsString();
    // Write out any unwritten data
    _writeCurrentVolume();
    // Final tally
    std::cout << _radxFile.getFileFormatAsString() << " archiver exit: " << 
        _raysRead << " rays read, " << 
        _raysWritten << " rays written, " << 
        _bytesWritten << " bytes written." << std::endl;
}

void
ProductArchiver::notify() {
    ACE_Guard<ACE_Recursive_Thread_Mutex> guard(_mutex);
    
    while (RadarDDS::ProductSet* ps = getNextItem()) {
        _raysRead++;

        // Build a new RadxRay from the ProductSet
        RadxRay* radxRay = new RadxRay();
        ProductAdapter::DDSToRadxRay(*ps, *radxRay, _radxVol);
        
        // Add the new ray to our current volume.  RadxVol is now responsible
        // for deleting the RadxRay object.
        _radxVol.addRay(radxRay);
        
        // Write the volume at _raysPerFile rays
        if (uint(_radxVol.getNRays()) == _raysPerFile) {
            _writeCurrentVolume();  
            // Reinitialize our volume
            _initVolume();
        }
        
        // Return the item to the DDSReader
        returnItem(ps);
    }
}

void
ProductArchiver::_writeCurrentVolume() {

    ACE_Guard<ACE_Recursive_Thread_Mutex> guard(_mutex);
    
    // Bail out if there's nothing to write
    if (_radxVol.getNRays() == 0)
        return;
    
    // Write the archiver name and revision to the volume's history
    std::ostringstream history;
    history << boost::posix_time::second_clock::universal_time() <<
        ": written by ProductArchiver rev " << SVNREVISION;
    _radxVol.setHistory(history.str());
    
    // set the volume info from the rays
    
    _radxVol.loadVolumeInfoFromRays();
    
    // set the sweep numbers from the rays
    
    _radxVol.loadSweepInfoFromRays();

    // Set up volume info from the rays we added. Note that this 
    // might remove rays which do not match the 'predominant geometry',
    // so we get a ray count before and after to see if any rays
    // were dropped.
    int raysBefore = _radxVol.getNRays();

    int raysDropped = _radxVol.getNRays() - raysBefore;
    if (raysDropped)
        std::cerr << "Dropped " << raysDropped << 
            " rays which did not match the 'predominant geometry'" << std::endl;


    if (_radxFile.writeToDir(_radxVol, _dataDir, false, false) == 0) {
        // Increment our count of rays written
        _raysWritten += _radxVol.getNRays();
        // Increment our count of bytes written
        struct stat finfo;
        if (stat(_radxFile.getPathInUse().c_str(), &finfo) == 0) {
            _bytesWritten += finfo.st_size;
            std::cerr << "Wrote " << finfo.st_size << " bytes to " <<
                _radxFile.getPathInUse() << std::endl;
        } else {
            std::cerr << "Error getting size of '" << 
                _radxFile.getPathInUse() << "': " << strerror(errno) << std::endl;
        }
    } else {
        std::cerr << "Failed to write '" << _radxFile.getPathInUse() << 
            "': " << _radxFile.getErrStr() << std::endl;
    }
}

void
ProductArchiver::_initVolume() {

    // Clean up, getting rid of any existing rays and calibrations.
    _radxVol.clear();

    _radxVol.setTitle("Hiaper Cloud Radar");
    _radxVol.setInstitution("NCAR/EOL");
    _radxVol.setReferences("");
    _radxVol.setSource("hcrdrx");
    _radxVol.setHistory("");
    _radxVol.setComment("");

    _radxVol.setSiteName("unknown");
    _radxVol.setScanName("VERT");
    
    // Load up the calibration
    RadxRcalib *radxCal = new RadxRcalib();
    _loadRadxRcalib(radxCal);
    _radxVol.addCalib(radxCal);

    // Fixed platform only at this point!
    _radxVol.setPlatformType(Radx::PLATFORM_TYPE_FIXED);

}

void
ProductArchiver::_readCalFile() {

  std::string errStr;
  if (_dsCalib.readFromXmlFile(_calFilePath, errStr)) {

    std::cerr << "WARNING: error reading cal file: " << _calFilePath << endl;
    std::cerr << errStr << endl;
    std::cerr << "Will use default calibration parameters" << endl;

    _dsCalib.setRadarName("HCR");
    _dsCalib.setCalibTime(time(NULL));
    _dsCalib.setWavelengthCm(0.31758);
    _dsCalib.setBeamWidthDegH(0.75);
    _dsCalib.setBeamWidthDegV(0.68);
    _dsCalib.setAntGainDbH(46.2);
    _dsCalib.setPulseWidthUs(0.512);
    _dsCalib.setXmitPowerDbmH(58.78);
    _dsCalib.setTwoWayWaveguideLossDbH(0.0);
    _dsCalib.setTwoWayRadomeLossDbH(0.0);
    _dsCalib.setReceiverMismatchLossDb(1.1);
    _dsCalib.setRadarConstH(70.0948);
    _dsCalib.setNoiseDbmHc(-64.0);
    _dsCalib.setI0DbmHc(-103.5);
    _dsCalib.setReceiverGainDbHc(39.5);
    _dsCalib.setReceiverSlopeDbHc(1.0);
    _dsCalib.setBaseDbz1kmHc(-35.6);
    _dsCalib.setDynamicRangeDbHc(70.0);
    
  }

}

////////////////////////////////////////////////////////////////////
// load up calib for Radx object, from the dsCalib object
// this is more general than it needs to be, since this is 
// not (yet) a dual-pol radar

void ProductArchiver::_loadRadxRcalib(RadxRcalib *radxCal)
  
{

  RadxTime calTime(_dsCalib.getCalibTime());
  
  radxCal->setCalibTime(calTime.getYear(),
                        calTime.getMonth(),
                        calTime.getDay(),
                        calTime.getHour(),
                        calTime.getMin(),
                        calTime.getSec());

  radxCal->setPulseWidthUsec(_dsCalib.getPulseWidthUs());
  radxCal->setXmitPowerDbmH(_dsCalib.getXmitPowerDbmH());
  radxCal->setXmitPowerDbmV(_dsCalib.getXmitPowerDbmV());
  
  radxCal->setTwoWayWaveguideLossDbH(_dsCalib.getTwoWayWaveguideLossDbH());
  radxCal->setTwoWayWaveguideLossDbV(_dsCalib.getTwoWayWaveguideLossDbV());
  radxCal->setTwoWayRadomeLossDbH(_dsCalib.getTwoWayRadomeLossDbH());
  radxCal->setTwoWayRadomeLossDbV(_dsCalib.getTwoWayRadomeLossDbV());
  radxCal->setReceiverMismatchLossDb(_dsCalib.getReceiverMismatchLossDb());
  
  radxCal->setRadarConstantH(_dsCalib.getRadarConstH());
  radxCal->setRadarConstantV(_dsCalib.getRadarConstV());
  
  radxCal->setNoiseDbmHc(_dsCalib.getNoiseDbmHc());
  radxCal->setNoiseDbmHx(_dsCalib.getNoiseDbmHx());
  radxCal->setNoiseDbmVc(_dsCalib.getNoiseDbmVc());
  radxCal->setNoiseDbmVx(_dsCalib.getNoiseDbmVx());
  
  radxCal->setReceiverGainDbHc(_dsCalib.getReceiverGainDbHc());
  radxCal->setReceiverGainDbHx(_dsCalib.getReceiverGainDbHx());
  radxCal->setReceiverGainDbVc(_dsCalib.getReceiverGainDbVc());
  radxCal->setReceiverGainDbVx(_dsCalib.getReceiverGainDbVx());
  
  radxCal->setReceiverSlopeDbHc(_dsCalib.getReceiverSlopeDbHc());
  radxCal->setReceiverSlopeDbHx(_dsCalib.getReceiverSlopeDbHx());
  radxCal->setReceiverSlopeDbVc(_dsCalib.getReceiverSlopeDbVc());
  radxCal->setReceiverSlopeDbVx(_dsCalib.getReceiverSlopeDbVx());
  
  radxCal->setBaseDbz1kmHc(_dsCalib.getBaseDbz1kmHc());
  radxCal->setBaseDbz1kmHx(_dsCalib.getBaseDbz1kmHx());
  radxCal->setBaseDbz1kmVc(_dsCalib.getBaseDbz1kmVc());
  radxCal->setBaseDbz1kmVx(_dsCalib.getBaseDbz1kmVx());
  
  radxCal->setSunPowerDbmHc(_dsCalib.getSunPowerDbmHc());
  radxCal->setSunPowerDbmHx(_dsCalib.getSunPowerDbmHx());
  radxCal->setSunPowerDbmVc(_dsCalib.getSunPowerDbmVc());
  radxCal->setSunPowerDbmVx(_dsCalib.getSunPowerDbmVx());
  
  radxCal->setNoiseSourcePowerDbmH(_dsCalib.getNoiseSourcePowerDbmH());
  radxCal->setNoiseSourcePowerDbmV(_dsCalib.getNoiseSourcePowerDbmV());
  
  radxCal->setPowerMeasLossDbH(_dsCalib.getPowerMeasLossDbH());
  radxCal->setPowerMeasLossDbV(_dsCalib.getPowerMeasLossDbV());
  
  radxCal->setCouplerForwardLossDbH(_dsCalib.getCouplerForwardLossDbH());
  radxCal->setCouplerForwardLossDbV(_dsCalib.getCouplerForwardLossDbV());
  
  radxCal->setZdrCorrectionDb(_dsCalib.getZdrCorrectionDb());
  radxCal->setLdrCorrectionDbH(_dsCalib.getLdrCorrectionDbH());
  radxCal->setLdrCorrectionDbV(_dsCalib.getLdrCorrectionDbV());
  radxCal->setSystemPhidpDeg(_dsCalib.getSystemPhidpDeg());
  
  radxCal->setTestPowerDbmH(_dsCalib.getTestPowerDbmH());
  radxCal->setTestPowerDbmV(_dsCalib.getTestPowerDbmV());
  
}

