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
 * DataMapperStatusThread.h
 *
 *  Created on: Sep 24, 2013
 *      Author: burghart
 */
#ifndef DATAMAPPERSTATUSTHREAD_H_
#define DATAMAPPERSTATUSTHREAD_H_

#include <QThread>
#include <dsserver/DmapAccess.hh>

/// @brief Class providing a thread which queries the DataMapper on a regular
/// basis to see how much data is being written.
///
/// This class uses the DmapAccess API to get information from the DataMapper,
/// querying at a 1 Hz rate. When new information is obtained, a 
/// newStatus(DMAP_info_t) signal is emitted. The class also 
/// provides a useful way to test the DataMapper is alive, via 
/// serverResponsive(bool) signals emitted when connection/disconnection is 
/// detected.
class DataMapperStatusThread : public QThread {
    Q_OBJECT

public:
    /// @brief Instantiate, talking to the DataMapper running on host dmapHost.
    DataMapperStatusThread(std::string dmapHost = "localhost");
    virtual ~DataMapperStatusThread();

    void run();

    /// @brief Return true iff the server responded to the last XML-RPC command.
    /// @return true iff the server responded to the last XML-RPC command.
    bool serverIsResponding() const { return(_responsive); }

    /// @brief Return a DMAP_info_t with bad status, i.e., indicating no data
    /// have ever been written.
    /// @return a DMAP_info_t with bad status, i.e., indicating no data
    /// have ever been written.
    DMAP_info_t badStatus() const;
    
signals:
    /// @brief Signal emitted when the XML-RPC client connection to the server
    /// becomes responsive or unresponsive.
    /// @param responsive true if the server has become responsive or false
    /// if the server has become unresponsive
    void serverResponsive(bool responsive);

    /// @brief signal emitted when a new status is received from DataMapper
    /// @param dmStatus the new DataMapper information struct.
    void newStatus(DMAP_info_t dmStatus);

private slots:
    /// @brief Try to get latest status from DataMapper, and emit a 
    /// newStatus() signal if successful.
    void _getStatus();
private:
    /// The host on which DataMapper is running.
    std::string _dmapHost;
    
    /// Our DataMapper access connection.
    DmapAccess _dmapAccess;
    
    /// True iff the client had a successful connection with the DataMapper
    /// on the last call.
    bool _responsive;
    
    /// The last info we got from DataMapper
    DMAP_info_t _dmInfo;
};

#endif /* DATAMAPPERSTATUSTHREAD_H_ */
