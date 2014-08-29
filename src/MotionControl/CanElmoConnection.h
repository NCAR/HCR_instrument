/*
 * CanElmoConnection.h
 *
 *  Created on: Feb 28, 2014
 *      Author: burghart
 */

#ifndef CANELMOCONNECTION_H_
#define CANELMOCONNECTION_H_

#include "ElmoConnection.h"
#include <vector>
#include <stdint.h>
#include <canfestival.h>
#include <QMutex>
#include <QTimer>

/// @brief Class implementing the ElmoConnection interface, providing a
/// connection to an Elmo servo drive via CANopen protocol.
///
/// The class uses the CanFestival-3 framework as its interface to CANopen.
///
/// As currently implemented, at most 4 instances of CanElmoConnection can be
/// instantiated. This limit is driven by the fact that: 1) Elmo servo drives 
/// expect a single master "device" on the bus (represented by the 
/// CanElmoConnection class as a whole), 2) Each CanElmoConnection requires a 
/// dedicated CANopen Receive Process Data Object (RPDO), and 3) Each CANopen 
/// device has exactly 4 RPDOs available.
class CanElmoConnection: public ElmoConnection {
    Q_OBJECT
public:
    /// @brief Instantiate a connection to an Elmo servo drive using the given
    /// node ID. A nickname (e.g., "rotation" or "tilt") is assigned to 
    /// the drive to make log messages more descriptive.
    ///
    /// @param nodeId the CANopen node ID of the drive (can be 0-127)
    /// @param driveName nickname used for the drive in log messages
    CanElmoConnection(uint8_t nodeId, std::string driveName);
    virtual ~CanElmoConnection();
    
    /// @brief Return the nickname associated with the drive.
    /// @return the nickname associated with the drive.
    virtual std::string driveName() const { return(_driveName); }
    
    /// @brief Execute the given SimplIQ command cmd on the servo drive. If 
    /// index is zero, "<cmd>" will be executed, otherwise "<cmd>[<index>]".
    ///
    /// @param cmd the two-letter Elmo SimplIQ command to execute
    /// @param index the command index (set to zero if the SimplIQ command is 
    ///     not indexed).
    /// @return true iff command execution was initiated
    virtual bool execElmoCmd(std::string cmd, uint16_t index);
    
    /// @brief Execute the given SimplIQ assignment for command cmd on the 
    /// servo drive. If the index is zero, "<cmd>=<value>" will be executed,
    /// otherwise "<cmd>[<index>]=<value>".
    ///
    /// @param cmd the two-letter Elmo SimplIQ command to execute
    /// @param index the command index (set to zero if the SimplIQ command is 
    ///     not indexed).
    /// @param value the integer value to be assigned to cmd at index
    /// @return true iff command execution was initiated
    virtual bool execElmoAssignCmd(std::string cmd, uint16_t index, int value);
    
    /// @brief Return true iff the object is ready to execute commands via the
    /// execElmoCmd() method.
    /// @return true iff the object is ready to execute commands via the
    /// execElmoCmd() method.
    virtual bool readyToExec() const { return(_readyToExec); }

    /// @brief Force re-initialization of the connection.
    virtual void reinitialize();

private slots:
    /// @brief Slot to be called when _replyTimer expires
    void _replyTimedOut();
    
private:
    /// Static list of all instantiated CanElmoConnection-s.
    static std::vector<CanElmoConnection*> _AllConnections;
    
    /// Static handle for loaded CanFestival driver
    static LIB_HANDLE _Driver;
    
    /// Static CanFestival data for the shared master node
    static CO_Data * _MasterNodeData;
    
    typedef enum _InitPhase {
        Uninitialized,
        ResetSlaveNode,
        SetHeartbeat,
        OSImmediateEval,
        Complete
    } InitPhase;

    /// @brief Load the needed dynamically loaded CanFestival driver library
    /// and perform other one-time-only initialization.
    static void _ClassInitialize();
    
    /// @brief Return a pointer to the CanElmoConnection object associated with 
    /// the given node ID. A null pointer is returned if no match is found.
    /// @return a pointer to the CanElmoConnection object associated with 
    /// the given node ID. A null pointer is returned if no match is found.
    static CanElmoConnection* _GetConnectionForId(UNS8 nodeId);
    
    /// @brief Return a pointer to the CanElmoConnection object associated with 
    /// the given master node RPDO number (1-4). A null pointer is returned if 
    /// no match is found.
    /// @return a pointer to the CanElmoConnection object associated with 
    /// the given master node RPDO number (1-4). A null pointer is returned if 
    /// no match is found.
    static CanElmoConnection* _GetConnectionForRpdo(UNS8 rpdoNum);
    
    /// @brief Static method for callback from CanFestival when timer loop 
    /// associated with a given node ID is started.
    /// @param d pointer to the CanFestival node data (undefined use for this 
    ///     callback, but probably NULL)
    /// @param id the timer alarm id generating the callback (undefined 
    ///     use for this callback, but probably 0)
    static void _TimerStartCallback(CO_Data* d, UNS32 id);

    /// @brief Static method for callback from CanFestival when timer loop 
    /// associated with a given node ID is stopped.
    /// @param d pointer to the CanFestival node data (undefined use for this 
    ///     callback, but probably NULL)
    /// @param id the timer alarm id generating the callback (undefined 
    ///     use for this callback, but probably 0)
    static void _TimerStopCallback(CO_Data* d, UNS32 id);
    
    /// @brief Static method for callback from CanFestival when a heartbeat
    /// error is detected.
    /// @param d pointer to the CanFestival node data
    /// @param nodeId the node ID for the device with failed heartbeat
    static void _HeartbeatErrorCallback(CO_Data* d, UNS8 nodeId);

    /// @brief Static method for callback from CanFestival for initialization
    /// of this node.
    /// @param d pointer to the CanFestival node data
    static void _InitialisationCallback(CO_Data * d);
    
    /// @brief Static method for callback from CanFestival when the master
    /// node reaches CANopen pre-operational state.
    /// @param d pointer to the CanFestival node data
    static void _PreOperationalCallback(CO_Data* d);

    /// @brief Static method for callback from CanFestival when this node 
    /// reaches CANopen operational state.
    /// @param d pointer to the CanFestival node data
    static void _OperationalCallback(CO_Data* d);

    /// @brief Static method for callback from CanFestival when this node is
    /// stopped.
    /// @param d pointer to the CanFestival node data
    static void _StoppedCallback(CO_Data* d);
    
    /// @brief Static method for callback from CanFestival when a SYNC message
    /// is seen by this node.
    /// @param d pointer to the CanFestival node data
    static void _PostSyncCallback(CO_Data* d);

    /// @brief Static method for callback from CanFestival after a TPDO is
    /// sent by this node.
    /// @param d pointer to the CanFestival node data
    static void _PostTPDOCallback(CO_Data* d);

    /// @brief Static method for callback from CanFestival after a slave bootup
    /// message is seen.
    /// @param d pointer to the CanFestival node data
    /// @param nodeId the node ID of the just-booted slave
    static void _PostSlaveBootupCallback(CO_Data* d, UNS8 nodeId);

    /// @brief Static method for callback from CanFestival when a request is 
    ///     made to store to this node's object dictionary (OD) at the given 
    ///     index and subindex
    /// @param d pointer to the CanFestival node data
    /// @param index the index to be written in the OD
    /// @param subindex the subindex to be written in the OD
    static void _StoreODSubindexCallback(CO_Data* d, UNS16 index, 
            UNS8 subindex);

    /// @brief Static method for callback from CanFestival when a CANopen
    /// EMCY (emergency) message is seen.
    /// @param d pointer to the CanFestival node data
    /// @param nodeId node ID which generated the emergency message
    /// @param errCode the error code
    /// @param errReg the error register
    static void _PostEmcyCallback(CO_Data* d, UNS8 nodeId, UNS16 errCode, 
            UNS8 errReg);
    
    /// @brief Static method for callback from CanFestival to complete an SDO 
    /// transfer. After completing the SDO, the _postSDO() method of the
    /// associated CanElmoConnection object is called.
    /// @param d pointer to the CanFestival node data
    /// @param nodeId the CANopen node ID for the server (i.e., Elmo drive)
    ///     responding to our SDO request
    static void _CompleteSDO(CO_Data* d, UNS8 nodeId);
    
    /// @brief Static callback used for callbacks from CanFestival when 
    /// PDO replies arrive. Returns zero unless there is an error.
    /// @param d pointer to the associated CanFestival node data
    /// @param unused pointer to the associated indextable (unused by this 
    ///     method)
    /// @param nodeId the CANopen node id of the Elmo drive which sent the 
    ///     reply
    /// @return zero unless there is an error 
    static UNS32 _PDOReplyCallback(CO_Data* d, const indextable* unused, 
            UNS8 nodeId);
    
    /// @brief Return true iff the given string starts with "XQ##"
    /// @param cmd the command string to be verified
    /// @return true iff the given string starts with "XQ##"
    static bool _CmdIsXqRequest(std::string cmd);
    
    /// @brief Return an assignment string of the form "<cmd>" for zero index, 
    /// or "<cmd>[<index>]" if index is non-zero.
    /// given the command, index, and value.
    /// @param cmd the SimplIQ command
    /// @param index the index
    /// @return an assignment string of the form "<cmd>" for zero index, 
    /// or "<cmd>[<index>]" if index is non-zero.
    static std::string _AssembleCommandString(std::string cmd, uint16_t index);
    
    /// @brief Return an assignment string of the form "<cmd>=<value>" for 
    /// zero index, or "<cmd>[<index>]=<value>" if index is non-zero.
    /// given the command, index, and value.
    /// @param cmd the SimplIQ command
    /// @param index the index
    /// @param value the value
    /// @return an assignment string of the form "<cmd>=<value>" for 
    /// zero index, or "<cmd>[<index>]=<value>" if index is non-zero.
    static std::string _AssembleAssignString(std::string cmd, uint16_t index,
            int value);
    
    /// @brief Return true iff the given string is either exactly two upper-case 
    /// letters, or starts with "XQ##".
    /// @param cmd the command string to be verified
    /// @return true iff the given string is either exactly two upper-case 
    /// letters, or starts with "XQ##".
    bool _cmdIsValid(std::string cmd);
    
    /// @brief Set the CANopen heartbeat interval of our Elmo drive to the 
    /// the heartbeat. Return true iff the SDO is initiated successfully.
    /// @param intervalMs the desired heartbeat interval in ms. Setting to zero
    ///     will disable heartbeat.
    /// @return true iff the SDO is initiated successfully.
    bool _sendSetHeartbeatInterval(UNS32 intervalMs);
    
    /// @brief Send SDO request our Elmo drive to set up immediate evaluation 
    /// of incoming commands. Return true iff the SDO is initiated successfully.
    /// @return true iff the SDO is initiated successfully.
    bool _sendSetImmediateEvaluation();
    
    /// @brief Send a CANopen message. Return 0 on success, or 1 on failure.
    /// @param msg The CanFestival message object to send
    /// @return true on success or false on failure
    bool _sendCanOpenMessage(Message & msg);
    
    /// @brief Handle a PDO reply from our Elmo drive.
    UNS32 _handleElmoPDOReply();
    
    /// @brief Method called from _CompleteSDO() after an SDO from this 
    /// connection is completed.
    /// @param success true iff the SDO was completed successfully
    void _postSDO(bool success);
    
    /// @brief Method called from _PostSlaveBootupCallback() when a boot
    /// message is received from our Elmo drive.
    void _onElmoBootup();
    
    /// @brief Start the reply timer, waiting for reponse to the given command.
    /// If the timer is already in use, this command just returns immediately.
    /// @param cmd the command for which a response is expected
    void _startReplyTimer(std::string cmd);
    
    /// @brief Stop the reply timer. This command has no effect if the timer
    /// is not currently in use.
    void _stopReplyTimer();
    
    /// @brief Proceed with the next initialization step for this connection.
    void _doNextInitializeStep();
    
    /// @brief Initiate the given "XQ##" SimplIQ command, and return true iff
    /// the command is initiated successfully.
    /// @param cmd the command to be executed, which must begin with "XQ##"
    /// @return true iff the command is initiated successfully.
    bool _initiateXq(std::string cmd);
    
    /// Set the Elmo drive to generate a CANopen heartbeat at this interval.
    /// Heartbeat is disabled if the interval is zero.
    static const uint16_t ELMO_HEARTBEAT_MSECS = 250;
    
    /// Mutex for thread-safe access to members
    QMutex _mutex;
    
    /// Our Elmo's CANopen node ID
    uint8_t _elmoNodeId;
    
    /// Nickname for the drive
    std::string _driveName;
    
    /// Master node RPDO number (1-4) which we will use to get PDO replies from
    /// our Elmo drive.
    uint8_t _myRpdo;
    
    /// Current initialization phase
    InitPhase _initPhase;
    
    /// Timer to assure that replies arrive in a reasonable time
    QTimer _replyTimer;
    
    /// Reply timeout in milliseconds
    static const uint16_t REPLY_TIMEOUT_MSECS = 1000;
    
    /// Command for which the reply timer was started
    std::string _replyTimerCommand;
    
    /// Are we ready to accept execElmoCommand() calls?
    bool _readyToExec;
};

#endif /* CANELMOCONNECTION_H_ */
