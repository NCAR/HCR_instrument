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
 * CanElmoConnection.cpp
 *
 *  Created on: Feb 28, 2014
 *      Author: burghart
 */

#include "CanElmoConnection.h"
#include "ElmoMasterNode.h"  // CanFestival CANopen node ElmoMasterNode
#include <cerrno>
#include <cstdlib>
#include <cstring>
#include <unistd.h>
#include <algorithm>
#include <iomanip>
#include <sstream>
#include <logx/Logging.h>
#include <QMutexLocker>
#include <QThread>

const uint16_t CanElmoConnection::REPLY_TIMEOUT_MSECS = 1000;
const uint16_t CanElmoConnection::ELMO_HEARTBEAT_MSECS = 250;

LOGGING("CanElmoConnection")

// Static member pointing to the CanFestival data object for our master CANopen
// node
CO_Data * CanElmoConnection::_MasterNodeData = &ElmoMasterNode_Data;

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
    _mutex(QMutex::Recursive),
    _elmoNodeId(nodeId),
    _driveName(driveName),
    _initPhase(Uninitialized),
    _replyTimer(TIMER_NONE),
    _replyTimerCommand(),
    _readyToExec(false) {
    QMutexLocker lock(&_mutex);
    
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
        ELOG << _driveName << 
                ": BUG: CanElmoConnection could not find an available RPDO";
        exit(1);
    }
    
    // Set up as a heartbeat consumer for the Elmo drive, timing out at
    // 4.0 * the Elmo's heartbeat interval
    uint16_t timeoutMs = uint16_t(4.0 * ELMO_HEARTBEAT_MSECS);
    
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
    
    // Stop heartbeat from our associated node
    if (_initPhase != Uninitialized) {
        _sendSetHeartbeatInterval(0);   // turn off heartbeat
    }
    usleep(50000); // Sleep briefly to allow for SDO completion

    // Remove ourself from the static list of CanElmoConnection-s
    std::vector<CanElmoConnection*>::iterator it;
    for (it = _AllConnections.begin(); it != _AllConnections.end(); it++) {
        if (*it == this) {
            _AllConnections.erase(it);
            break;
        }
    }

    // If we were the last connection, do the final CanFestival cleanup
    if (_AllConnections.size() == 0) {
        DLOG << _driveName << ": Performing CanFestival cleanup";
        StopTimerLoop(_TimerStopCallback);
        TimerCleanup();

        canClose(_MasterNodeData);
        UnLoadCanDriver(_Driver);        
    }
}

void
CanElmoConnection::_ClassInitialize() {
    // Much of the implementation for this class assumes local byte ordering is
    // little-endian. Verify this.
    uint16_t word = 0x0102;
    char * c = reinterpret_cast<char*>(&word);
    if (c[0] != 0x02) {
        ELOG << "BUG: Implementation of class CanElmoConnection only works " <<
                "on little-endian machines, and this machine isn't!";
        abort();
    }

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
    CAN_PORT canPort = canOpen(&board, _MasterNodeData);
    if (canPort == NULL) {
        ELOG << __PRETTY_FUNCTION__ << ": Failed to open CAN bus " << 
                board.busname << " at " << board.baudrate << " bits/s";
        exit(1);
    }

    // set up callback functions for ElmoMaster_Data
    _MasterNodeData->initialisation = _InitialisationCallback;
    _MasterNodeData->heartbeatError = _HeartbeatErrorCallback;
    _MasterNodeData->preOperational = _PreOperationalCallback;
    _MasterNodeData->operational = _OperationalCallback;
    _MasterNodeData->stopped = _StoppedCallback;
    _MasterNodeData->post_sync = _PostSyncCallback;
    _MasterNodeData->post_SlaveBootup = _PostSlaveBootupCallback;
    _MasterNodeData->post_TPDO = _PostTPDOCallback;
    _MasterNodeData->storeODSubIndex = _StoreODSubindexCallback;
    _MasterNodeData->post_emcy = _PostEmcyCallback;

    // Register callbacks for after Elmo PDO replies are written to our 
    // object dictionary (at index 0x2000).
    RegisterSetODentryCallBack(_MasterNodeData, 0x2000, 1, _PDOReplyCallback);
    RegisterSetODentryCallBack(_MasterNodeData, 0x2000, 2, _PDOReplyCallback);
    RegisterSetODentryCallBack(_MasterNodeData, 0x2000, 3, _PDOReplyCallback);
    RegisterSetODentryCallBack(_MasterNodeData, 0x2000, 4, _PDOReplyCallback);
    
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
    QMutexLocker lock(&_mutex);
    
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
    
    DLOG << _driveName << ": PDO reply for commmand " << fullCommand << ", " <<
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
    std::ostringstream os;
    os << "Heartbeat error for " << conn->_driveName << " drive (node " << 
            int(nodeId) << ")";
//    throw std::runtime_error(os.str());
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
    // Find the associated CanElmoConnection instance and call its 
    // _onElmoBootup() method.
    CanElmoConnection * conn = _GetConnectionForId(nodeId);
    if (conn) {
        conn->_onElmoBootup();
    } else {
        WLOG << "NMT boot-up message received from unknown CANopen node " << 
                int(nodeId);
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
    ILOG << "Received CANbus EMCY message. Node: " << int(nodeId) <<
    		std::hex << 
            ", Error code 0x" << errCode <<
            ", Error register 0x" << int(errReg);
}

void
CanElmoConnection::_ReplyTimeoutCallback(CO_Data* d, UNS32 id) {
    // The timer id should be the node id of the associated CanElmoConnection
    // instance.
    UNS8 nodeId = static_cast<UNS8>(id);
    CanElmoConnection * conn = _GetConnectionForId(nodeId);
    if (conn) {
        conn->_replyTimedOut();
    } else {
        ELOG << "BUG: Reply timeout for unknown CANopen node " << id;
    }
}

std::string
CanElmoConnection::_PdoToString(const Message & pdo) {
    std::ostringstream oss;
    
    // The first two data bytes are the two-character Elmo command
    oss << char(pdo.data[0]) << char(pdo.data[1]);
    
    // The command index (if any) and flags are in bytes 2 and 3.
    uint16_t indexAndFlags;
    memcpy(&indexAndFlags, pdo.data + 2, 2);
    
    // Index is the lower 14 bits
    uint16_t index = indexAndFlags & 0x3fff;    // index is bits 0-13
    bool isQuery = indexAndFlags & 0x4000;      // is-a-query is bit 14
    bool isFloat = indexAndFlags & 0x8000;      // is-float is bit 15 (only valid for assignments)
    
    
    // If index is non-zero, add it to the text string
    if (index) {
        oss << "[" << index << "]";
    }
    
    // For assignments we have to add "=<value>" to the string
    if (! isQuery) {
        // This is an assignment command
        oss << "=";
        
        // Handle float values and int values separately
        if (isFloat) {
            float fVal;
            memcpy(&fVal, pdo.data + 4, 4);
            oss << fVal;
        } else {
            int32_t iVal;
            memcpy(&iVal, pdo.data + 4, 4);
            oss << iVal;
        }
    }
    
    // Done. Return the string.
    return oss.str();
}

bool
CanElmoConnection::_sendSetHeartbeatInterval(UNS32 intervalMs) {
    QMutexLocker lock(&_mutex);
    
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
        ELOG << _driveName << ": Error " << int(res) << " sending " <<
                "'set producer heartbeat interval' to node " << int(_elmoNodeId);
        return(false);
    }
    
    _startReplyTimer("<set producer heartbeat interval>");
    return(true);
}

bool
CanElmoConnection::_sendCanOpenPdo(Message & pdo) {
    // We occasionally see "No buffer space available" errors when sending 
    // messages quickly, so try up to MAX_ATTEMPTS times to send the 
    // message, with brief waits inserted before each attempt after the first.
    const int MAX_ATTEMPTS = 4;
    for (int i = 0; i < MAX_ATTEMPTS; i++) {
        UNS8 result = canSend(_MasterNodeData->canHandle, &pdo);
        if (result == 0) {
            if (i > 0) {
                ILOG << _driveName << ": Sent message '" << _PdoToString(pdo) <<
                        "' after " << i << " failed attempts";
            }
            return(true);
        } else {
            // Although canSend() does not return error details, errno should 
            // still hold the error from canSend()'s failed call to the system 
            // send() function. If the error from the device was ENOBUFS, we 
            // sleep briefly and try again. Otherwise we report the error 
            // and fail immediately.
            if (errno == ENOBUFS) {
                // The sleep time of 25 ms has been determined empirically,
                // occasionally yielding up to 2 failed attempts before success.
                usleep(25000);
            } else {
                ELOG << _driveName << ": " << __PRETTY_FUNCTION__ << 
                        ": error sending command '" << _PdoToString(pdo) <<
                        "': " << strerror(errno);
                return(false);
            }
        }
    }
    ELOG << _driveName << ": failed to send command '" << _PdoToString(pdo) << 
            "' after " << MAX_ATTEMPTS << " attempts";
    return(false);
}

void
CanElmoConnection::reinitialize() {
    QMutexLocker lock(&_mutex);
    
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
    QMutexLocker lock(&_mutex);
    
    // Increment the initialization phase
    _initPhase = static_cast<InitPhase>(int(_initPhase) + 1);

    switch (_initPhase) {
    case Uninitialized:
        ELOG << _driveName << 
            ": BUG: shouldn't be 'Uninitialized' at this point!";
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
        ILOG << _driveName << ": CanElmoConnection for node " << 
                int(_elmoNodeId) << " initialization is complete";
        break;
    }
}

bool
CanElmoConnection::_sendSetImmediateEvaluation() {
    QMutexLocker lock(&_mutex);
    
    UNS8 res;
    char SDOdata[8];

    ILOG << _driveName << ": Setting node " << int(_elmoNodeId) << 
            " to evaluate commands immediately";
    SDOdata[0] = 0;
    res = writeNetworkDictCallBack(_MasterNodeData, 
            _elmoNodeId,        // CANopen node ID
            0x1024,             // object dictionary index
            0x0,                // object dictionary subindex
            1,                  // data size, bytes
            0,                  // data type
            SDOdata,            // void * data
            _CompleteSDO,       // SDOCallback_t
            false);             // block mode?
    if (res != 0) {
        ELOG << _driveName << ": Error " << int(res) << " sending " <<
                "'set immediate evaluation' to node " << int(_elmoNodeId);
        return(false);
    }
    
    _startReplyTimer("<set Evaluate Immediately>");
    return(true);
}

bool
CanElmoConnection::_cmdIsValid(std::string cmd) {
    // Verify that the command is either two characters long or that
    // it begins with "XQ##".
    bool ok = (cmd.length() >= 2);
    ok = ok && isupper(cmd[0]) && isupper(cmd[1]);
    // If command is more than two characters long, it must start with
    // "XQ##" to be valid.
    if (cmd.length() > 2)
        ok = ok && _CmdIsXqRequest(cmd);
    
    if (! ok) {
        ELOG << _driveName << ": execElmo*() command must be exactly two " <<
                "upper case letters or start with XQ##. " <<
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
    QMutexLocker lock(&_mutex);
    
    if (! _readyToExec) {
        WLOG << _driveName << ": Not yet ready to exec. Rejecting '" << 
                _AssembleCommandString(cmd, index) << "'";
        return(false);
    }
    
    // Make sure the command is valid
    if (! _cmdIsValid(cmd)) {
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
    return(_sendCanOpenPdo(pdo));
}

bool
CanElmoConnection::execElmoAssignCmd(std::string cmd, uint16_t index, 
        int value) {
    QMutexLocker lock(&_mutex);
    
    if (! _readyToExec) {
        WLOG << _driveName << ": Not yet ready to exec. Rejecting '" << 
                _AssembleAssignString(cmd, index, value) << "'";
        return(false);
    }
    
    // Make sure the command is valid
    if (! _cmdIsValid(cmd)) {
        return(false);
    }
    
    // Start the reply timer
    _startReplyTimer(_AssembleAssignString(cmd, index, value));
    
    // XQ## commands must be sent via SDO, and require special handling
    if (_CmdIsXqRequest(cmd)) {
        ELOG << _driveName << 
                ": XQ## command makes no sense in execElmoAssignCmd()!";
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
    return(_sendCanOpenPdo(pdo));
}

void
CanElmoConnection::_postSDO(bool success) {
    QMutexLocker lock(&_mutex);
    
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
    QMutexLocker lock(&_mutex);
    
    if (! _CmdIsXqRequest(cmd)) {
        return false;
    }
    
    // Send an SDO containing the 'XQ##' command to the command interpreter.
    // Note that we can only send 'XQ##' commands via SDO (see Elmo's CANopen 
    // Implementation Guide).
    ILOG << _driveName << ": Sending '" << cmd << "'";
    UNS32 cmdlen = cmd.length();
    char * cmdData = const_cast<char*>(cmd.c_str());
    UNS8 res = writeNetworkDictCallBack(_MasterNodeData, 
            _elmoNodeId,        // CANopen node ID
            0x1023,             // object dictionary index for command interpreter
            0x1,                // subindex where command is written
            cmdlen,             // data size, bytes
            0,                  // data type
            cmdData,            // void * data
            _CompleteSDO,       // SDOCallback_t
            false);             // block mode?
    if (res != 0) {
        ELOG << _driveName << ": Error " << int(res) << " sending " <<
                "'" << cmd << "' to node " << int(_elmoNodeId);
        return(false);
    }
    
    
    return true;
}

void
CanElmoConnection::_onElmoBootup() {
    QMutexLocker lock(&_mutex);
    
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
    QMutexLocker lock(&_mutex);
    
    // If a reply timer is already in place, just return
    if (_replyTimer != TIMER_NONE) {
        DLOG << _driveName << ": Not timing reply to '" << cmd << 
                "'; reply timer is already in use.";
        return;
    }
    _replyTimerCommand = cmd;
    
    // We use a CanFestival timer rather than a QTimer because reply timer start
    // and stop may occur in different threads, and QTimer requires that start/
    // stop must occur from the same thread.
    _replyTimer = SetAlarm(_MasterNodeData, _elmoNodeId, _ReplyTimeoutCallback, 
            MS_TO_TIMEVAL(REPLY_TIMEOUT_MSECS), MS_TO_TIMEVAL(REPLY_TIMEOUT_MSECS));
}

void
CanElmoConnection::_stopReplyTimer() {
    QMutexLocker lock(&_mutex);
    
    // Stop the reply timer
    DelAlarm(_replyTimer);
    _replyTimer = TIMER_NONE;
}

void
CanElmoConnection::_replyTimedOut() {
    QMutexLocker lock(&_mutex);
    
    ELOG << _driveName << ": No response to '" << _replyTimerCommand <<
            " in " << REPLY_TIMEOUT_MSECS << " ms. Re-initializing the drive.";
    
    // Stop the reply timer, since it's periodic (not a one-shot)
    _stopReplyTimer();

    // Re-initialize
    reinitialize();
}
