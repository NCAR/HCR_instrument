/*
 * HcrPmc730StatusThread.cpp
 *
 *  Created on: Sep 10, 2012
 *      Author: burghart
 */

#include "HcrPmc730StatusThread.h"
#include "HmcModeChange.h"
#include <QDateTime>
#include <QMetaType>
#include <QTimer>
#include <QUdpSocket>
#include <logx/Logging.h>

LOGGING("HcrPmc730StatusThread")

HcrPmc730StatusThread::HcrPmc730StatusThread(std::string daemonHost, 
        int daemonPort) :
    _responsive(false),
    _daemonHost(daemonHost),
    _daemonPort(daemonPort),
    _client(0),
    _hmcModeChangeSocket(NULL) {
    // We need to register HcrPmc730Status and HmcOperationMode as metatypes, 
    // since we'll be passing them as arguments in signals.
    qRegisterMetaType<HcrPmc730Status>("HcrPmc730Status");
    qRegisterMetaType<HcrPmc730::HmcOperationMode>("HcrPmc730::HmcOperationMode");
    
    // Set thread affinity to self, so that signals connected to our slot(s)
    // will execute the slots in this thread, and not our parent's.
    moveToThread(this);
}

HcrPmc730StatusThread::~HcrPmc730StatusThread() {
    // Stop the thread, and wait up to 1 second for the thread to finish.
    quit();
    wait(1000);
    delete(_hmcModeChangeSocket);
}

void
HcrPmc730StatusThread::run() {
    // Instantiate the HcrPmc730Client
    _client = new HcrPmc730Client(_daemonHost, _daemonPort);
    
    // Set up a 1 s timer to call _getStatus()
    QTimer timer;
    connect(&timer, SIGNAL(timeout()), this, SLOT(_getStatus()));
    timer.start(1000);
    
    // Open the UDP socket to receive HMC mode change broadcasts, and 
    // connect it to our reader slot.
    _hmcModeChangeSocket = new QUdpSocket();
    _hmcModeChangeSocket->bind(HMC_MODE_BROADCAST_PORT, QUdpSocket::ShareAddress);
    connect(_hmcModeChangeSocket, SIGNAL(readyRead()), 
            this, SLOT(_readHmcModeChangeSocket()));
    
    // Start the event loop
    exec();
    return;
}

void
HcrPmc730StatusThread::_getStatus() {
    try {
        HcrPmc730Status status = _client->getStatus();
        // We got a response, so emit serverResponsive(true) if the server was
        // not previously responding.
        if (! _responsive) {
            _responsive = true;
            emit serverResponsive(true, QString("HcrPmc730Daemon is responding"));
        }
        // Emit the new status.
        emit newStatus(status);
    } catch (std::exception & e) {
        // As a rule, exceptions just mean the server is not responding. Emit
        // serverResponsive(false) if the server had previously been responding.
        if (_responsive) {
            std::ostringstream oss;
            oss << "HcrPmc730Daemon failed to respond to getStatus(): " << e.what();
            _responsive = false;
            emit serverResponsive(false, QString(oss.str().c_str()));
        }
    }
}

void
HcrPmc730StatusThread::_readHmcModeChangeSocket() {
    while (_hmcModeChangeSocket->bytesAvailable()) {
        int datagramSize = _hmcModeChangeSocket->pendingDatagramSize();

        // If incoming datagram is not the expected size, just read it and 
        // discard it.
        if (datagramSize != sizeof(HmcModeChangeStruct)) {
            ELOG << "HMC mode change datagram is " << datagramSize << 
                    " bytes when expecting " << sizeof(HmcModeChangeStruct) <<
                    ", discarding it";
            char trash[datagramSize];
            _hmcModeChangeSocket->readDatagram(trash, sizeof(trash));
        }
        
        // Read the datagram into an HmcModeChangeStruct
        HmcModeChangeStruct mcStruct;
        _hmcModeChangeSocket->readDatagram(reinterpret_cast<char *>(&mcStruct), 
                sizeof(mcStruct));

        // Emit our hmcModeChange() signal
        DLOG << "HMC mode changed to '" << 
                HcrPmc730::HmcModeNames[mcStruct.mode] << "' at " <<
                QDateTime::fromTime_t(time_t(mcStruct.modeChangeTime))
                    .addMSecs(int(fmod(mcStruct.modeChangeTime, 1.0) * 1000))
                    .toString("yyyyMMdd hh:mm:ss.zzz").toStdString();
        emit hmcModeChange(mcStruct.mode, mcStruct.modeChangeTime);
    }
}
