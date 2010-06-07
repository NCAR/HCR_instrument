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

static const double SPEED_OF_LIGHT = 2.99792458e8; // m s-1


ProductArchiver::ProductArchiver(DDSSubscriber& subscriber, 
        std::string topicName, std::string dataDir, uint raysPerFile,
        RadxFile::file_format_t fileFormat) :
            ProductReader(subscriber, topicName),
            _dataDir(dataDir),
            _raysPerFile(raysPerFile),
            _volNum(0),
            _radxFile(),
            _radxVol(),
            _raysRead(0),
            _raysWritten(0),
            _bytesWritten(0) {
    ACE_Guard<ACE_Recursive_Thread_Mutex> guard(_mutex);
    
    // Make sure our destination directory has a trailing slash
    if (_dataDir[_dataDir.length() - 1] != '/')
        _dataDir += "/";
    // Write files in the selected format, using the volume start time
    // to names files.
    _radxFile.setFileFormat(fileFormat);
    _radxFile.setWriteUsingEndTime(false);
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
        ProductAdapter::DDSToRadxRay(*ps, *radxRay, _volNum);
        
        // Add the new ray to our current volume.  RadxVol is now responsible
        // for deleting the RadxRay object.
        _radxVol.addRay(radxRay);
        
        // If we started a new volume, set per-RadxVol parameters
        if (_radxVol.getNRays() == 1) {
            // Use the xmit frequency from the first product of the ray to set 
            // xmit wavelength of our RadxVol.
            _radxVol.setWavelengthMeters(SPEED_OF_LIGHT / 
                    ps->products[0].hskp.tx_cntr_freq);
            _radxVol.setInstrumentName("HCR");
            _radxVol.setPlatformType(Radx::PLATFORM_TYPE_FIXED);
        }
        
        // Write the volume at _raysPerFile rays
        if (uint(_radxVol.getNRays()) == _raysPerFile)
            _writeCurrentVolume();
        
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
    
    // Set up volume info from the rays we added. Note that this 
    // might remove rays which do not match the 'predominant geometry',
    // so we get a ray count before and after to see if any rays
    // were dropped.
    int raysBefore = _radxVol.getNRays();

    _radxVol.loadVolFieldsFromRays(false);

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
    
    // Clear out our RadxVol
    _radxVol.clear();
    // Increment to the next volume number
    _volNum++;
}
