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
#ifndef IWRFEXPORTINS_THREAD_H_
#define IWRFEXPORTINS_THREAD_H_

#include <CmigitsFmq.h>
#include <QThread>
#include <Fmq/DsFmq.hh>

class IwrfExport;

/// IwrfExportInsThread watches CmigitsFmq and emits newData() when new
/// data are found.

class IwrfExportInsThread : public QThread {

    Q_OBJECT

public:
    /// @brief Constructor
    /// @param iwrfExport the IwrfExport object to which we will send data
    /// @param insNum the HCR INS number (1 or 2) we'll be watching
    IwrfExportInsThread(IwrfExport & iwrfExport, int insNum);
    
    /// Destructor
    virtual ~IwrfExportInsThread();

protected:
    void run();

private:
    IwrfExport & _iwrfExport;
    int _insNum;    ///< number (1 or 2) of the HCR INS we're watching
    DsFmq _insFmq;
};

#endif /* IWRFEXPORTINS_THREAD_H_ */
