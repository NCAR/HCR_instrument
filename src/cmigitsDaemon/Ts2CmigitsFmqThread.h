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
 * Ts2CmigitsFmqThread.h
 *
 *  Created on: Jan 9, 2015
 *      Author: burghart
 */

#ifndef TS2CMIGITSFMQTHREAD_H_
#define TS2CMIGITSFMQTHREAD_H_
#include <CmigitsFmq.h>
#include <vector>
#include <radar/IwrfTsReader.hh>
#include <QThread>
#include <QTimer>

/// @brief This object creates its own thread, and within that thread reads 
/// data from a list of IWRF time series files, extracts the attitude and 
/// position metadata, and writes it into the CmigitsSharedMemory segment at 
/// the same rate it was originally generated. Data written into shared memory 
/// is tagged with current time rather than the time from the data.

class Ts2CmigitsFmqThread : public QObject {
    Q_OBJECT
public:
    /// @brief Construct using the given list of IWRF time-series files.
    /// @param fileList a vector containing a list of IWRF time-series files.
    Ts2CmigitsFmqThread(std::vector<std::string> fileList);
    virtual ~Ts2CmigitsFmqThread();

signals:
    /// @ brief Signal emitted when our work is complete.
    void finished();
    
private slots:
    /// @brief Slot called to perform initialization which must must be executed
    /// in the work thread.
    void _onThreadStart();
    
    /// @brief Slot called to read a pulse and handle it at the correct interval
    /// relative to the previous pulse.
    void _doNextPulse();
    
private:
    
    /// @brief Show statistics for reading, writing to shared memory, and
    /// timing.
    void _showStats();

    /// List of time-series files to be played back
    std::vector<std::string> _fileList;
    
    /// Work thread where the heavy lifting will be done
    QThread _workThread;
    
    /// QTimer controlling generation of fake C-MIGITS 3500 messages
    QTimer * _fake3500Timer;
    
    /// Reader for IWRF time-series files
    IwrfTsReaderFile * _reader;

    /// Connection to the C-MIGITS shared memory segment
    CmigitsFmq * _fmq;

    /// The last pulse from the reader
    IwrfTsPulse * _pulse;

    /// Count of pulses processed
    int _pulseCount;

    /// Total time slept waiting to deliver pulse data at the correct interval
    int _sleepSumUsecs;

    /// Count of delayed pulses
    int _delayedPulseCount;

    /// Sum of delay time for all delayed pulses
    int _delaySumUsecs;

    /// Data time from previous pulse processed, seconds since 1970-01-01
    /// 00:00:00 UTC
    double _prevPulseDataTime;

    /// Time at which previous pulse was processed, seconds since 1970-01-01
    /// 00:00:00 UTC
    double _prevPulseProcessTime;
};

#endif /* TS2CMIGITSFMQTHREAD_H_ */
