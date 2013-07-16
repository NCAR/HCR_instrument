/*
 * DriveStatus.cpp
 *
 *  Created on: July 10, 2013
 *      Author: burghart
 */

#include "DriveStatus.h"
#include <logx/Logging.h>

LOGGING("DriveStatus")

DriveStatus::DriveStatus(const ElmoServoDrive & rotDrive,
		const ElmoServoDrive & tiltDrive) :
	_rotDriveResponding(rotDrive.driveResponding()),
	_rotDriveTemp(rotDrive.driveTemperature()),
	_tiltDriveResponding(tiltDrive.driveResponding()),
	_tiltDriveTemp(tiltDrive.driveTemperature()) {
	DLOG << "_rotDriveResponding: " << _rotDriveResponding;
	DLOG << "_rotDriveTemp: " << _rotDriveTemp;
	DLOG << "_tiltDriveResponding: " << _tiltDriveResponding;
	DLOG << "_tiltDriveTemp: " << _tiltDriveTemp;
}

DriveStatus::DriveStatus(xmlrpc_c::value_struct & statusDict) {
	// Cast the given xmlrpc_c::value_struct into a map from string to
	// xmlrpc_c::value.
	std::map<std::string, xmlrpc_c::value> statusMap =
			static_cast<std::map<std::string, xmlrpc_c::value> >(statusDict);
    // Create an input archive from the map, and populate from that.
    Iarchive_xmlrpc_c iar(statusMap);
    iar >> *this;
}

DriveStatus::~DriveStatus() {
}

xmlrpc_c::value_struct
DriveStatus::to_value_struct() const {
    // Stuff our content into a dictionary mapping string to
	// xmlrpc_c::value.
	std::map<std::string, xmlrpc_c::value> dict;
    Oarchive_xmlrpc_c oar(dict);
    oar << *this;
    // Construct an xmlrpc_c::value_struct from the map and return it.
    return(xmlrpc_c::value_struct(dict));
}
