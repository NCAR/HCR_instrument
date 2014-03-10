/*
 * CanElmoConnection.cpp
 *
 *  Created on: Feb 28, 2014
 *      Author: burghart
 */

#include "CanElmoConnection.h"
#include <cstdlib>
#include <algorithm>
#include <iomanip>
#include <sstream>
#include <logx/Logging.h>

LOGGING("CanElmoConnection")

// Static member pointing to the CanFestival data object for our master CANopen
// node
CO_Data * CanElmoConnection::_MasterNodeData = &ElmoMaster_Data;

// Static member holding a list of pointers to all instantiated 
// CanElmoConnection-s
std::vector<CanElmoConnection*> CanElmoConnection::_AllConnections;

// Static member holding the handle for our loaded CanFestival library
LIB_HANDLE CanElmoConnection::_Driver = 0;

// Make sure that the CANFESTIVAL_LIBDIR macro has been defined. We need it 
// when loading a CanFestival dynamically loadable driver library below.
// You can add -DCANFESTIVAL_LIBDIR='"<path>"' to your compilation options,
// or use the 'canfestival' SCons tool, which will add it for you.
#ifndef CANFESTIVAL_LIBDIR
#  error CANFESTIVAL_LIBDIR is not defined. 
#  error It is defined automatically by the 'canfestival' SCons tool,
#  error or you can add -DCANFESTIVAL_LIBDIR='"<path>"' to the compiler command
#endif

CanElmoConnection::CanElmoConnection(uint8_t nodeId, std::string driveName) :
    _elmoNodeId(nodeId),
    _driveName(driveName),
    _initPhase(Uninitialized),
    _replyTimer(),
    _replyTimerCommand(),
    _readyToExec(false) {
    size_t nConnections = _AllConnections.size();
    // Perform class initialization if this is the first instance
    if (nConnections == 0) {
        _ClassInitialize();
    }
    
    // Make sure we don't instantiate more than four CanElmoConnection-s,
    // as we're limited by the number of RPDOs available in the master node.
    if (nConnections == 4) {
        ELOG << "Attempted to instantiate more than the maximum of 4 " <<
                "CanElmoConnection-s: CANopen ID " << int(_elmoNodeId) << 
                ", drive name '" << _driveName << "'";
        exit(1);
    }
    
    // Make sure another instance has not been created for the given node ID
    if (_GetConnectionForId(_elmoNodeId)) {
        ELOG << "Error creating CanElmoConnection '" << _driveName << 
                " for node " << int(_elmoNodeId) << 
                ": A CanElmoConnection already exists for the node.";
        exit(1);
    }
    
    // Build a list of RPDOs already used by existing CanElmoConnection-s
    std::vector<uint8_t> usedRPDOs;
    for (size_t i = 0; i < nConnections; i++) {
        usedRPDOs.push_back(_AllConnections[i]->_myRpdo);
    }
    
    // Use the lowest available RPDO (1-4) from the master node to get PDO
    // replies from our Elmo drive
    _myRpdo = 0;
    for (uint8_t r = 1; r <= 4; r++) {
        // If this RPDO is not in the list of used ones, we'll take it.
        if (std::find(usedRPDOs.begin(), usedRPDOs.end(), r) == usedRPDOs.end()) {
            // Stash the RPDO number we're taking
            _myRpdo = r;
            DLOG << "CanElmoConnection '" << _driveName << "' will use RPDO" <<
                    int(_myRpdo);
            
            // Write to the master node's object dictionary to set up the RPDO 
            // to receive stuff our drive's TPDO2. Elmo uses TPDO2 to transmit
            // replies to command interpreter requests.
            uint32_t driveTPDO2_COBid = 0x40000280 + _elmoNodeId;   // COB-ID used by drive's TPDO2
            uint32_t size_COBid = 4;    // COB-ID is 4 bytes long
            writeLocalDict(_MasterNodeData, // data object for the master node
                    0x1400 + _myRpdo - 1,   // object dict index for our RPDO
                    1,                      // subindex 1 (COB-ID)
                    &driveTPDO2_COBid,      // COB-ID used by drive's TPDO2
                    &size_COBid,            // size of COB-ID
                    true);                  // check access
            break;
        }
    }

    if (! _myRpdo) {
        ELOG << "BUG: CanElmoConnection could not find an available RPDO";
        exit(1);
    }
    
    // Set up as a heartbeat consumer for the Elmo drive, timing out at
    // 1.2 * the Elmo's heartbeat interval
    uint16_t timeoutMs = uint16_t(1.2 * ELMO_HEARTBEAT_MSECS);
    
    // Consumer heartbeat value is a 4-byte little-endian value, with the 
    // timeout time in ms in bits 0-15, and the producer node ID in bits
    // 16-22.
    uint32_t heartbeatValue = (_elmoNodeId << 16) | timeoutMs;
    
    // Write to the master node's object dictionary to set up the the 
    // timeout in milliseconds before we consider a heartbeat from the Elmo
    // to be late.
    uint32_t dataSize = 4;          // data size, bytes
    writeLocalDict(_MasterNodeData, // data object for the master node
            0x1016,                 // object dict index for consumer heartbeat time
            _myRpdo,                // subindex, we use our RPDO number (1-4)
            &heartbeatValue,        // heartbeat timeout and producer node ID
            &dataSize,              // size of timeoutMs
            true);                  // check access
    
    // Set up a timer to verify that replies from the servo drive arrive within 
    // a specified interval, or _replyTimedOut() will be called.
    _replyTimer.setInterval(REPLY_TIMEOUT_MSECS);
    _replyTimer.setSingleShot(true);
    connect(& _replyTimer, SIGNAL(timeout()), this, SLOT(_replyTimedOut()));

    // Add this instance to the list of CanElmoConnection-s
    _AllConnections.push_back(this);
    
    // Begin the initialization process
    _doNextInitializeStep();
}

CanElmoConnection::~CanElmoConnection() {
    // Write to the master node's object dictionary to remove heartbeat
    // testing for this Elmo
    uint32_t heartbeatValue = 0;    // 0 disables heartbeat timeout
    uint32_t dataSize = 4;          // data size, bytes
    writeLocalDict(_MasterNodeData, // data object for the master node
            0x1016,                 // object dict index for consumer heartbeat time
            _myRpdo,                // subindex, use our RPDO number (1-4)
            &heartbeatValue,        // heartbeat timeout in milliseconds
            &dataSize,              // size of timeoutMs
            true);                  // check access
    if (! _myRpdo) {
        ELOG << "BUG: CanElmoConnection could not find an available RPDO";
        exit(1);
    }
    
    // Stop heartbeat from our associated node
    if (_initPhase != Uninitialized) {
        _sendSetHeartbeatInterval(0);   // turn off heartbeat
    }
    usleep(50000); // Sleep briefly to allow for SDO completion

    // Remove ourself from the list of CanElmoConnection-s
    std::vector<CanElmoConnection*>::iterator it;
    for (it = _AllConnections.begin(); it != _AllConnections.end(); it++) {
        if (*it == this) {
            _AllConnections.erase(it);
            break;
        }
    }

    // If we were the last connection, do the final CanFestival cleanup
    if (_AllConnections.size() == 0) {
        StopTimerLoop(_TimerStopCallback);
        TimerCleanup();

        canClose(&ElmoMaster_Data);
        UnLoadCanDriver(_Driver);        
    }
}

void
CanElmoConnection::_ClassInitialize() {
    const char soFile[] = CANFESTIVAL_LIBDIR "/libcanfestival_can_socket.so";
    _Driver = LoadCanDriver(soFile);
    if (_Driver == NULL) {
        ELOG << __PRETTY_FUNCTION__ << ": Unable to load shared library '" << 
                soFile << "'";
        exit(1);
    }
    ILOG << "Opened CanFestival driver shared library";

    // CAN bus configuration
    s_BOARD board;
    static char busname[] = "0";        // required syntax for CanFestival-3
    static char baudrate[] = "500K";    // required syntax for CanFestival-3
    board.busname = busname;
    board.baudrate = baudrate;

    ILOG << "Opening bus " << busname << " at " << baudrate << " bits/s";
    CAN_PORT canPort = canOpen(&board, &ElmoMaster_Data);
    if (canPort == NULL) {
        ELOG << __PRETTY_FUNCTION__ << ": Failed to open CAN bus " << 
                board.busname << " at " << board.baudrate << " bits/s";
        exit(1);
    }

    // set up callback functions for ElmoMaster_Data
    ElmoMaster_Data.initialisation = _InitialisationCallback;
    ElmoMaster_Data.heartbeatError = _HeartbeatErrorCallback;
    ElmoMaster_Data.preOperational = _PreOperationalCallback;
    ElmoMaster_Data.operational = _OperationalCallback;
    ElmoMaster_Data.stopped = _StoppedCallback;
    ElmoMaster_Data.post_sync = _PostSyncCallback;
    ElmoMaster_Data.post_SlaveBootup = _PostSlaveBootupCallback;
    ElmoMaster_Data.post_TPDO = _PostTPDOCallback;
    ElmoMaster_Data.storeODSubIndex = _StoreODSubindexCallback;
    ElmoMaster_Data.post_emcy = _PostEmcyCallback;

    // Register callbacks for after Elmo PDO replies are written to our 
    // object dictionary (at index 0x2000).
    RegisterSetODentryCallBack(&ElmoMaster_Data, 0x2000, 1, _PDOReplyCallback);
    RegisterSetODentryCallBack(&ElmoMaster_Data, 0x2000, 2, _PDOReplyCallback);
    RegisterSetODentryCallBack(&ElmoMaster_Data, 0x2000, 3, _PDOReplyCallback);
    RegisterSetODentryCallBack(&ElmoMaster_Data, 0x2000, 4, _PDOReplyCallback);
    
    // Start timer thread
    TimerInit();
    StartTimerLoop(_TimerStartCallback);
}

CanElmoConnection*
CanElmoConnection::_GetConnectionForId(UNS8 nodeId) {
    for (unsigned int i = 0; i < _AllConnections.size(); i++) {
        if (_AllConnections[i]->_elmoNodeId == nodeId) {
            return(_AllConnections[i]);
        }
    }

    WLOG << "No CanElmoConnection found for node " << int(nodeId);
    return(0);
}

CanElmoConnection*
CanElmoConnection::_GetConnectionForRpdo(UNS8 rpdoNum) {
    for (unsigned int i = 0; i < _AllConnections.size(); i++) {
        if (_AllConnections[i]->_myRpdo == rpdoNum) {
            return(_AllConnections[i]);
        }
    }

    WLOG << "No CanElmoConnection found for RPDO" << int(rpdoNum);
    return(0);
}

void
CanElmoConnection::_CompleteSDO(CO_Data* d, UNS8 nodeId)
{
    UNS32 abortCode;
    bool success = true;
    if (getWriteResultNetworkDict(d, nodeId, &abortCode) != SDO_FINISHED) {
        WLOG << "SDO to node " << int(nodeId) << " failed, abort code: 0x" << 
                abortCode;
        success = false;
    } else {
        DLOG << "SDO to node " <<  int(nodeId) << " was successful!";
        success = true;
    }
    
    // Regardless of result, we must finalize the SDO transfer with this node
    closeSDOtransfer(d, nodeId, SDO_CLIENT);
    
    // Find the CanElmoConnection associated with this node ID
    CanElmoConnection * conn = _GetConnectionForId(nodeId);
    if (! conn) {
        WLOG << "BUG: Handled SDO completion with node id " << nodeId << 
                ", but no associated CanElmoConnection exists!";
        return;
    }
    
    // Tell the associated CanElmoConnection that the SDO is complete, and
    // pass on the success status.
    conn->_postSDO(success);
}

UNS32
CanElmoConnection::_PDOReplyCallback(CO_Data* d, const indextable *unused, 
        UNS8 subindex) {
    // The subindex indicates the RPDO number (1-4) which got the incoming
    // reply. Translate that to the CanElmoConnection instance which should 
    // handle the reply.
    CanElmoConnection * conn = _GetConnectionForRpdo(subindex);
    if (! conn) {      
        WLOG << "No CanElmoConnection found expecting PDO reply on RPDO" << 
                int(subindex);
        return(1);
    }
    
    // Let the associated instance handle the PDO reply
    return(conn->_handleElmoPDOReply());
}

std::string
CanElmoConnection::_AssembleCommandString(std::string cmd, uint16_t index) {
    if (index == 0) {
        return(cmd);
    } else {
        // for non-zero index, append "[<index>]"
        std::ostringstream os;
        os << cmd << "[" << index << "]";
        return(os.str());
    }
}

std::string
CanElmoConnection::_AssembleAssignString(std::string cmd, uint16_t index, 
        int value) {
    // Build the base command
    std::string cmdString = _AssembleCommandString(cmd, index);
    
    // Append "=<value>"
    std::ostringstream os;
    os << cmdString << "=" << value;
    return(os.str());
}

UNS32
CanElmoConnection::_handleElmoPDOReply() {
    // A reply came in, so stop the reply timer.
    _stopReplyTimer();
    
    // The 8-byte Elmo PDO reply was mapped to variable ElmoMaster_PDOReplies 
    // at index (_myRpdo - 1).
    uint8_t replyIndex = _myRpdo - 1;  // PDO num [1-4] -> array index [0-3]
    uint8_t *reply = reinterpret_cast<uint8_t*>(&ElmoMaster_PDOReplies[replyIndex]);

    // Elmo PDO reply bytes 0-1 are the 2-character command
    char cmd[] = "--";
    memcpy(cmd, reply, 2);
    
    // Elmo PDO reply bytes 2-3 contain the 14-bit command array index, the 
    // error flag, and the int/float data type flag
    uint16_t bytes2And3 = *reinterpret_cast<uint16_t*>(reply + 2);
    uint16_t cmdIndex = bytes2And3 & 0x3fff;
    uint8_t isError = (bytes2And3 >> 14) & 0x1;
    uint8_t isFloat = (bytes2And3 >> 15) & 0x1;    // 0 = int, 1 = float
    
    // Elmo reply PDO bytes 4-7 contain the data value, which may be 
    // 4-byte little-endian int or float. We assume here we're working on a
    // little-endian machine!
    float fVal;
    memcpy(&fVal, reply + 4, 4);
    
    int32_t iVal;
    memcpy(&iVal, reply + 4, 4);

    std::string fullCommand = _AssembleCommandString(cmd, cmdIndex);
    
    std::ostringstream valStream;
    if (isFloat) {
        valStream << fVal;
    } else {
        valStream << "0x" << std::hex << std::setw(8) << std::setfill('0') << 
                iVal;
    }
    
    DLOG << "PDO reply for commmand " << fullCommand << ", " <<
            "type " << (isFloat ? "float" : "int") << ", " << 
            (isError ? "ERR" : "no err") << ", " <<
            "value " << valStream.str();
    
    // Emit the appropriate replyFromExec() signal
    if (isError) {
        emit(replyFromExec(fullCommand, ErrorReply, iVal, 0.0));
    } else if (isFloat) {
        emit(replyFromExec(fullCommand, FloatReply, 0, fVal));
    } else {
        emit(replyFromExec(fullCommand, IntReply, iVal, 0.0));
    }
    // Report no error in interpreting the reply
    return(0);
}

void
CanElmoConnection::_TimerStartCallback(CO_Data* d, UNS32 id) {
    DLOG << "CanElmoConnection::_TimerStartCallback for node " << id;
    // Move to pre-operational state once the timer is started
    setState(_MasterNodeData, Pre_operational);
}

void
CanElmoConnection::_TimerStopCallback(CO_Data* d, UNS32 id) {
    DLOG << "CanElmoConnection::_TimerStopCallback for node " << id;
}

void
CanElmoConnection::_HeartbeatErrorCallback(CO_Data* d, UNS8 nodeId) {
    WLOG << "CANopen heartbeat error for node " << int(nodeId);
    CanElmoConnection * conn = _GetConnectionForId(nodeId);
    if (conn) {
        WLOG << "Reinitializing node's connection";
        // If we have a connection for this node, reinitialize it
        conn->reinitialize();
    }
}

void
CanElmoConnection::_InitialisationCallback(CO_Data * d) {
    DLOG << "CanElmoConnection::_InitialisationCallback";
    // Set our node ID to 1, which is the master node ID expected by Elmo
    // drives
    setNodeId(d, 1);
}

void
CanElmoConnection::_PreOperationalCallback(CO_Data* d) {
    DLOG << "CanElmoConnection::_PreOperationalCallback";
    // Just move on to Operational state
    setState(d, Operational);
}

void
CanElmoConnection::_OperationalCallback(CO_Data* d) {
    DLOG << "CanElmoConnection master node is now operational";
}

void
CanElmoConnection::_StoppedCallback(CO_Data* d) {
    ILOG << "CanElmoConnection::_StoppedCallback";
}

void
CanElmoConnection::_PostSyncCallback(CO_Data* d) {
    ILOG << "CanElmoConnection::_PostSyncCallback";
}

void
CanElmoConnection::_PostTPDOCallback(CO_Data* d) {
    ILOG << "CanElmoConnection::_PostTPDOCallback";
}

void
CanElmoConnection::_PostSlaveBootupCallback(CO_Data* d, UNS8 nodeId) {
    ILOG << "CANopen node " << std::hex << int(nodeId) << " has reset";
    // Find the associated CanElmoConnection instance and start its 
    // initialization process.
    CanElmoConnection * conn = _GetConnectionForId(nodeId);
    if (conn) {
        conn->_onElmoBootup();
    }
}

void
CanElmoConnection::_StoreODSubindexCallback(CO_Data* d, UNS16 index, 
        UNS8 subindex) {
    ILOG << "CanElmoConnection::_StoreODSubindexCallback: 0x" << 
            std::hex <<
            index << "[0x" << subindex << "]";
}

void
CanElmoConnection::_PostEmcyCallback(CO_Data* d, UNS8 nodeId, UNS16 errCode, 
        UNS8 errReg) {
    ILOG << "CanElmoConnection received EMCY message. Node: " << int(nodeId) <<
            std::hex <<
            ", Error code 0x" << errCode <<
            ", Error register 0x" << errReg;
}

bool
CanElmoConnection::_sendSetHeartbeatInterval(UNS32 intervalMs) {
    UNS8 res;
    char SDOdata[8];

    if (intervalMs) {
        ILOG << _driveName << ": Setting node " << int(_elmoNodeId) << 
                " to generate " << intervalMs << " ms heartbeat";
    } else {
        ILOG << _driveName << ": Stopping heartbeat from node " << 
                int(_elmoNodeId);
    }
    // Send an SDO to the Elmo to change its heartbeat interval
    SDOdata[0] = 0;
    memcpy(SDOdata, static_cast<void*>(&intervalMs), 4);
    res = writeNetworkDictCallBack(_MasterNodeData, 
            _elmoNodeId,     // CANopen node ID
            0x1017,         // object dictionary index
            0x0,            // object dictionary subindex
            4,              // data length, bytes
            0,              // data type
            SDOdata,        // void * data
            _CompleteSDO,   // SDOCallback_t
            false);         // block mode?
    if (res != 0) {
        ELOG << _driveName << ": Error " << res << " sending " <<
                "'set producer heartbeat interval' to node " << int(_elmoNodeId);
        return(false);
    }
    
    _startReplyTimer("<set producer heartbeat interval>");
    return(true);
}

void
CanElmoConnection::reinitialize() {
    // Stop accepting execElmo*() calls until we're initialized
    if (_readyToExec) {
        _readyToExec = false;
        emit(readyToExecChanged(_readyToExec));
    }
    // Start the initialization
    _initPhase = Uninitialized;
    _doNextInitializeStep();
}

void
CanElmoConnection::_doNextInitializeStep() {
    // Proceed to the next initialization phase
    _initPhase = static_cast<InitPhase>(int(_initPhase) + 1);

    switch (_initPhase) {
    case Uninitialized:
        std::cerr << "BUG: shouldn't be 'Uninitialized' at this point!" << std::endl;
        exit(1);
    case ResetSlaveNode:
        // Send a reset message to our Elmo's node ID. That will generate a
        // boot-up message, caught by _onElmoBootup(), which will cause the 
        // rest of our initialization to proceed.
        ILOG << _driveName << ": initiating reset of Elmo drive node " << 
            int(_elmoNodeId);
        masterSendNMTstateChange(_MasterNodeData, _elmoNodeId, NMT_Reset_Node);
        _startReplyTimer("<CANopen reset node>");
        break;
    case SetHeartbeat:
        if (! _sendSetHeartbeatInterval(ELMO_HEARTBEAT_MSECS)) {
            // On failure, we have no SDO proceeding which will continue our
            // initialization via _CompleteSDO(). Just bail out completely...
            exit(1);
        }
        break;
    case OSImmediateEval:
        // Set our Elmo to immediately evaluate received commands. 
        if (! _sendSetImmediateEvaluation()) {
            // On failure, we have no SDO proceeding which will continue our
            // initialization via _CompleteSDO(). Just bail out completely...
            exit(1);
        }
        break;
    case Complete:
        // Make the Elmo node operational
        masterSendNMTstateChange(_MasterNodeData, _elmoNodeId, NMT_Start_Node);
        // Start accepting execElmo*() calls
        _readyToExec = true;
        emit(readyToExecChanged(_readyToExec));
        ILOG << "CanElmoConnection for node " << int(_elmoNodeId) << 
                " initialization is complete";
    }
}

bool
CanElmoConnection::_sendSetImmediateEvaluation() {
    UNS8 res;
    char SDOdata[8];

    ILOG << "Setting node " << int(_elmoNodeId) << " to evaluate cmds immediately";
    SDOdata[0] = 0;
    res = writeNetworkDictCallBack(&ElmoMaster_Data, 
            _elmoNodeId,        // CANopen node ID
            0x1024,             // object dictionary index
            0x0,                // object dictionary subindex
            1,                  // data size, bytes
            0,                  // data type
            SDOdata,            // void * data
            _CompleteSDO,       // SDOCallback_t
            false);             // block mode?
    if (res != 0) {
        ELOG << _driveName << ": Error " << res << " sending " <<
                "'set immediate evaluation' to node " << int(_elmoNodeId);
        return(false);
    }
    
    _startReplyTimer("<set Evaluate Immediately>");
    return(true);
}

bool
CanElmoConnection::_CmdIsValid(std::string cmd) {
    // Verify that the command is either two characters long or that
    // it begins with "XQ##".
    bool ok = (cmd.length() >= 2);
    ok = ok && isupper(cmd[0]) && isupper(cmd[1]);
    // If command is more than two characters long, it must start with
    // "XQ##" to be valid.
    if (cmd.length() > 2)
        ok = ok && _CmdIsXqRequest(cmd);
    
    if (! ok) {
        ELOG << "execElmo*() command must be exactly two upper case " <<
                "letters or start with XQ##. " <<
                "Bad command: '" << cmd << "'";
    }
    return(ok);
}

bool
CanElmoConnection::_CmdIsXqRequest(std::string cmd) {
    return(cmd.compare(0, 4, "XQ##") == 0);
}

bool
CanElmoConnection::execElmoCmd(std::string cmd, uint16_t index) {
    if (! _readyToExec) {
        WLOG << "Not yet ready to exec. Rejecting '" << 
                _AssembleCommandString(cmd, index) << "'";
        return(false);
    }
    
    // Make sure the command is valid
    if (! _CmdIsValid(cmd)) {
        return(false);
    }
  
    // Start the reply timer
    _startReplyTimer(_AssembleCommandString(cmd, index));
    
    // XQ## commands must be sent via SDO, and require special handling
    if (_CmdIsXqRequest(cmd)) {
        return(_initiateXq(cmd));
    }
    
    // Build a PDO for the command
    Message pdo;
    memset(&pdo, 0, sizeof(pdo));       // start with an all-zero message
    // Set the COB-ID to that used by the Elmo's RPDO2
    pdo.cob_id = 0x300 + _elmoNodeId;
    // Elmos do not respond to a CANopen PDO "remote transmitting request"
    pdo.rtr = NOT_A_REQUEST;
    // First two data bytes are the two-letter command
    memcpy(pdo.data, cmd.c_str(), 2);
    // Next two data bytes are the 14-bit command index (zero for non-indexed 
    // commands), and flags for "is-a-query" and "is-float" in the upper two 
    // bits. (The "is-float" flag is only meaningful for assignments, not for 
    // queries)
    uint16_t indexAndFlags = index;
    indexAndFlags |= 1 << 14;   // set the is-a-query bit
    memcpy(pdo.data + 2, &indexAndFlags, 2);
    // total data length is 4 bytes
    pdo.len = 4;
    
    // Send the PDO
    UNS8 result = canSend(_MasterNodeData->canHandle, &pdo);
    if (result != 0) {
        ELOG << __PRETTY_FUNCTION__ << ": canSend() error " << result;
    }
    return(result);
}

bool
CanElmoConnection::execElmoAssignCmd(std::string cmd, uint16_t index, 
        int value) {
    if (! _readyToExec) {
        WLOG << "Not yet ready to exec. Rejecting '" << 
                _AssembleAssignString(cmd, index, value) << "'";
        return(false);
    }
    
    // Make sure the command is valid
    if (! _CmdIsValid(cmd)) {
        return(false);
    }
    
    // Start the reply timer
    _startReplyTimer(_AssembleAssignString(cmd, index, value));
    
    // XQ## commands must be sent via SDO, and require special handling
    if (_CmdIsXqRequest(cmd)) {
        ELOG << "XQ## command makes no sense in execElmoAssignCmd()!";
        return(1);
    }
    
    // Build a PDO for the command
    Message pdo;
    memset(&pdo, 0, sizeof(pdo));       // start with an all-zero message
    // Set the COB-ID to that used by the Elmo's RPDO2
    pdo.cob_id = 0x300 + _elmoNodeId;
    // Elmos do not respond to a CANopen PDO "remote transmitting request"
    pdo.rtr = NOT_A_REQUEST;
    // First two data bytes are the two-letter command
    memcpy(pdo.data, cmd.c_str(), 2);
    // Next two data bytes are the 14-bit command index (zero for non-indexed 
    // commands), and flags for "is-a-query" and "is-float" in the upper two 
    // bits. (The "is-float" flag is only meaningful for assignments, not for 
    // queries)
    uint16_t indexAndFlags = index;
    memcpy(pdo.data + 2, &indexAndFlags, 2);
    // Data bytes 4-7 hold the integer value
    memcpy(pdo.data + 4, static_cast<void*>(&value), 4);
    // Total data length is 8 bytes
    pdo.len = 8;
    
    // Send the PDO
    UNS8 result = canSend(_MasterNodeData->canHandle, &pdo);
    if (result != 0) {
        ELOG << __PRETTY_FUNCTION__ << ": canSend() error " << result;
    }
    return(result);
}

void
CanElmoConnection::_postSDO(bool success) {
    // A reply came in, so stop the reply timer.
    _stopReplyTimer();
    
    // If we're in the middle of initialization, continue the initialization,
    // or start over if the SDO failed.
    if (_initPhase != Complete) {
        // If the SDO failed, restart the initialization from the beginning.
        if (! success) {
            WLOG << _driveName << ": Restarting initialization for node id " <<
                    int(_elmoNodeId) << " after SDO failure";
            _initPhase = Uninitialized;
        }
        // Proceed to the next initialization step
        _doNextInitializeStep();
    }
}

bool
CanElmoConnection::_initiateXq(std::string cmd) {
    if (! _CmdIsXqRequest(cmd)) {
        return false;
    }
    
    // Send an SDO containing the 'XQ##' command to the command interpreter.
    // Note that we can only send 'XQ##' commands via SDO (see Elmo's CANopen 
    // Implementation Guide).
    ILOG << _driveName << ": Sending '" << cmd << "'";
    UNS32 cmdlen = cmd.length();
    char * cmdData = const_cast<char*>(cmd.c_str());
    UNS8 res = writeNetworkDictCallBack(&ElmoMaster_Data, 
            _elmoNodeId,        // CANopen node ID
            0x1023,             // object dictionary index for command interpreter
            0x1,                // subindex where command is written
            cmdlen,             // data size, bytes
            0,                  // data type
            cmdData,            // void * data
            _CompleteSDO,       // SDOCallback_t
            false);             // block mode?
    if (res != 0) {
        ELOG << _driveName << ": Error " << res << " sending " <<
                "'" << cmd << "' to node " << int(_elmoNodeId);
        return(false);
    }
    
    
    return true;
}

void
CanElmoConnection::_onElmoBootup() {
    // We consider a bootup message to be a reply, so stop the reply timer.
    _stopReplyTimer();
    
    // If we're not in the ResetSlaveNode part of our initialization when
    // the boot message comes, then something weird happened on our Elmo...
    if (_initPhase != ResetSlaveNode) {
        WLOG << _driveName << ": Unexpected bootup message from node " << 
                int(_elmoNodeId) << ". Reinitializing the drive.";
        _initPhase = ResetSlaveNode;
    } else {
        ILOG << _driveName << ": CANopen bootup message received for node " <<
                int(_elmoNodeId);
    }
    // Move on in our initialization
    _doNextInitializeStep();
}

void
CanElmoConnection::_startReplyTimer(std::string cmd) {
    // If reply timer is currently in use, just return
    if (_replyTimer.isActive()) {
        DLOG << _driveName << ": Not timing reply to '" << cmd << 
                "'; reply timer is already in use.";
        return;
    }
    _replyTimerCommand = cmd;
    _replyTimer.start();
}

void
CanElmoConnection::_stopReplyTimer() {
    _replyTimer.stop();
    _replyTimerCommand = "";
}
void
CanElmoConnection::_replyTimedOut() {
    ELOG << _driveName << ": No response to '" << _replyTimerCommand <<
            " in " << REPLY_TIMEOUT_MSECS << " ms. Re-initializing the drive.";

    // Re-initialize
    reinitialize();
}
