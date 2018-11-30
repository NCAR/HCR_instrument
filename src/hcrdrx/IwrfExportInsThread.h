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

#include <QtCore/QThread>
#include <QtCore/QTimer>
#include <Fmq/DsFmq.hh>

class IwrfExport;

/// IwrfExportInsThread creates a new thread, and from that thread polls an INS
/// data FMQ and adds any data received to its associated IwrfExport instance's
/// INS queue.

class IwrfExportInsThread : public QObject {

    Q_OBJECT

public:
    /// @brief Constructor
    /// @param iwrfExport the IwrfExport object to which we will send data
    /// @param insNum the HCR INS number (1 or 2) we'll be watching
    IwrfExportInsThread(IwrfExport & iwrfExport, int insNum);
    
    /// Destructor
    virtual ~IwrfExportInsThread();

private slots:
    /// @brief Initialize and start the work timer which drives calls to
    /// _handleNextFmqEntry()
    void _initWorkTimer();

    /// @brief Get the next entry from the FMQ and pass it to our IwrfExport
    /// instance, waiting briefly if necessary
    void _handleNextFmqEntry();

private:
    /// @brief QThread in which we'll work
    QThread _workThread;

    /// @brief Zero-interval timer that will drive our work
    QTimer * _workTimer;

    /// @brief Parent IwrfExport instance
    IwrfExport & _iwrfExport;

    /// @brief number (1 or 2) of the HCR INS we're watching
    int _insNum;

    /// @brief URL for our INS's FMQ
    std::string _fmqUrl;

    /// @brief FMQ with data from our INS
    DsFmq _insFmq;

    /// @brief Is our INS in NAV mode?
    bool _inNavMode;

    /// @brief Maximum time to wait for FMQ open or for arrival of FMQ data, ms
    static const int FMQ_WAIT_TIMEOUT_MS = 100;

    /// @brief time of the last FMQ warning, in seconds since the Unix epoch
    time_t _lastFmqWarningTime;

    /// @brief Minimum interval between issuing FMQ warnings
    const int FMQ_WARNING_INTERVAL_SECS = 10;
};

#endif /* IWRFEXPORTINS_THREAD_H_ */
