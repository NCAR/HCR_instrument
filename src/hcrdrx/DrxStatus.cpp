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
 * DrxStatus.cpp
 *
 *  Created on: Sep 6, 2012
 *      Author: hcr
 */

#include "DrxStatus.h"
#include "HCR_Pentek.h"
#include <Archive_xmlrpc_c.h>
#include <logx/Logging.h>
#include <iomanip>

LOGGING("DrxStatus")

DrxStatus::DrxStatus() :
    _pentekFpgaTemp(-99),
    _pentekBoardTemp(-99),
    _xmitPulseWidth(0.0),
    _prt(0.0),
    _nGates(0),
    _gateSpacing(0.0),
    _motorZeroPositionSet(false),
    _supportedOpsModes() {
}

DrxStatus::DrxStatus(xmlrpc_c::value_struct & statusDict) :
    _pentekFpgaTemp(-99),
    _pentekBoardTemp(-99),
    _xmitPulseWidth(0.0),
    _prt(0.0),
    _nGates(0),
    _gateSpacing(0.0),
    _motorZeroPositionSet(false),
    _supportedOpsModes() {
    // Create an input archiver wrapper around the xmlrpc_c::value_struct
    // dictionary, and use serialize() to populate our members from its content.
    Iarchive_xmlrpc_c iar(statusDict);
    iar >> *this;
}

DrxStatus::~DrxStatus() {
}

xmlrpc_c::value_struct
DrxStatus::toXmlRpcValue() const {
    std::map<std::string, xmlrpc_c::value> statusDict;
    // Clone ourself to a non-const instance
    DrxStatus clone(*this);
    // Stuff our content into the statusDict, i.e., _serialize() to an 
    // output archiver wrapped around the statusDict.
    Oarchive_xmlrpc_c oar(statusDict);
    oar << clone;
    // Finally, return the statusDict
    return(xmlrpc_c::value_struct(statusDict));
}
