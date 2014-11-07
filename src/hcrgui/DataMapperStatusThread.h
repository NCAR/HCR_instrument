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
