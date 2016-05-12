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
 * hcrgui.cpp
 *
 *  Created on: Jan 6, 2011
 *      Author: burghart
 */
 
#include <cstdlib>
#include <cstdio>
#include <QApplication>

#include <logx/Logging.h>

#include "HcrGuiMainWindow.h"

LOGGING("hcrgui")

void
usage(const char* appName) {
    ELOG << "Usage: " << appName;
    exit(1);
}

int
main(int argc, char *argv[]) {
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);
    ILOG << "hcrgui started";
    
    QApplication* app = new QApplication(argc, argv);
    
    if (argc != 1) {
        usage(argv[0]);
    }

    // Hosts and ports for the daemons we'll be talking to
    char archiverHost[] = "archiver";
    int xmitdPort = 8000;
    int fireflydPort = 8001;

    char rdsHost[] = "rds";
    int cmigitsPort = 8002;
    int pmc730Port = 8003;
    int motionControlPort = 8080;
    int hcrdrxPort = 8081;
    int hcrMonitorPort = 8004;

    QMainWindow* mainWindow = new HcrGuiMainWindow(archiverHost, xmitdPort,
            fireflydPort, rdsHost, hcrdrxPort, pmc730Port, cmigitsPort,
            motionControlPort, hcrMonitorPort);
    mainWindow->show();
    
    int retval = app->exec();
    ILOG << "hcrgui stopped";
    return(retval);
}
