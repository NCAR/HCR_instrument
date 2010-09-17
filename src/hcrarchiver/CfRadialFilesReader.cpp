/*
 * CfRadialFilesReader.cpp
 *
 *  Created on: Apr 22, 2010
 *      Author: burghart
 */

#include <cstdlib>
#include <cmath>
#include "CfRadialFilesReader.h"

CfRadialFilesReader::CfRadialFilesReader(const QStringList& fileNames, 
        bool verbose) :
    _fileNames(fileNames),
    _currentFileNdx(-1),
    _radxFile(),
    _radxVol(),
    _nextRayNum(0),
    _verbose(verbose) {
}

CfRadialFilesReader::~CfRadialFilesReader() {
}

bool
CfRadialFilesReader::getNextRay(const RadxRay* & radxRay, 
        const RadxVol* & radxVol) {
    // Open the next file if necessary
    if (_nextRayNum == _radxVol.getNRays() && ! _openNextFile())
            return false;
    
    radxRay = _radxVol.getRays()[_nextRayNum];
    radxVol = &_radxVol;
    _nextRayNum++;
    return true;
}

bool
CfRadialFilesReader::_openNextFile() {
    if (++_currentFileNdx == _fileNames.size())
        return false;
    if (! QFile::exists(_currentFileName())) {
        std::cerr << "No such file: '" << _currentFileName().toStdString() << 
            "'" << std::endl;
        return _openNextFile();
    }
    if (_radxFile.readFromPath(_currentFileName().toStdString(), _radxVol) < 0) {
        std::cerr << "Error opening: '" << _currentFileName().toStdString() << 
            "'" << std::endl;
        return _openNextFile();
    }
    if (_radxVol.getNRays() <= 0) {
        std::cerr << "File '" << _currentFileName().toStdString() << 
            "' contains no rays!" << std::endl;
        return _openNextFile();
    }
    
    // Start at the first ray of the new file
    _nextRayNum = 0;
    
    if (_verbose)
        std::cout << "Opened " << _currentFileName().toStdString() << std::endl;
    return true;
}
