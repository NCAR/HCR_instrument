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
 * HcrGuiMainWindow.cpp
 *
 *  Created on: Jan 14, 2011
 *      Author: burghart
 */
#include "HcrGuiMainWindow.h"

#include <cerrno>
#include <cmath>
#include <cstring>
#include <fstream>
#include <sstream>
#include <unistd.h>
#include <vector>

#include <QDateTime>
#include <QMessageBox>
#include <QThread>

#include <logx/Logging.h>

// Invalid angle used to erase display of reflector position
static const float INVALID_ANGLE = -999.9;

LOGGING("HcrGuiMainWindow")

static inline double MetersToFeet(double m) {
    return(3.28084 * m);
}

Q_DECLARE_METATYPE(OperationMode)

HcrGuiMainWindow::HcrGuiMainWindow(std::string archiverHost,
    int xmitterPort, int fireflydPort, int spectracomPort,
    std::string rdsHost, int drxPort, int pmcPort, int ins1Port,
    int ins2Port, int motionControlPort, int hcrExecutivePort) :
    QMainWindow(),
    _ui(),
    _updateTimer(this),
    _logWindow(this),
    _ins1Details(this, "INS1 Status"),
    _ins2Details(this, "INS2 Status"),
    _fireflydDetails(this),
    _hcrdrxDetails(this),
    _hcrExecutiveDetails(this, rdsHost, hcrExecutivePort),
    _insOverview(this),
    _motionControlDetails(this),
    _pmc730Details(this),
//    _spectracomDetails(this),
    _xmitDetails(this),
    _antennaModeDialog(this),
    _ins1StatusThread(rdsHost, ins1Port),
    _ins2StatusThread(rdsHost, ins2Port),
    _dataMapperStatusThread(),
    _fireflydStatusThread(archiverHost, fireflydPort),
//    _spectracomStatusThread(archiverHost, spectracomPort),
    _hcrdrxStatusThread(rdsHost, drxPort),
    _hcrExecutiveStatusThread(rdsHost, hcrExecutivePort),
    _mcStatusThread(),
    _mcStatusWorker(rdsHost, motionControlPort, &_mcStatusThread),
    _pmcStatusThread(),
    _pmcStatusWorker(rdsHost, pmcPort, &_pmcStatusThread),
    _xmitdStatusThread(archiverHost, xmitterPort),
    _redLED(":/redLED.png"),
    _amberLED(":/amberLED.png"),
    _greenLED(":/greenLED.png"),
    _greenLED_off(":/greenLED_off.png"),
    _notRespondingLED(":/redLED_Q.png"),
    _xmitStatus(),
    _rdsXmitControl(true),
    _fireflydStatus(),
    _mcStatus(),
    _pmcStatus(),
    _ins1Status(),
    _ins2Status(),
    _drxStatus(),
    _dmapStatus(),
    _dmapWriteRate(0.0),
    _dmapWriteRateTime(0),
    _lastAngleUpdate(QDateTime::currentDateTime()),
    _anglesValidTimer(this) {
    // Set up the UI
    _ui.setupUi(this);

    _logMessage("hcrgui started");
    
    std::ostringstream ss;
    ss << "No response yet from hcr_xmitd at " << archiverHost << ":" <<
            xmitterPort;
    _logMessage(ss.str());

    ss.str("");
    ss << "No response yet from fireflyd at " << archiverHost << ":" <<
            fireflydPort;
    _logMessage(ss.str());

//    ss.str("");
//    ss << "No response yet from SpectracomDaemon at " << archiverHost << ":" <<
//            spectracomPort;
//    _logMessage(ss.str());

    ss.str("");
    ss << "No response yet from HcrPmc730Daemon at " << rdsHost << ":" <<
            pmcPort;
    _logMessage(ss.str());

    ss.str("");
    ss << "No response yet from INS1 cmigitsDaemon at " << rdsHost << ":" <<
            ins1Port;
    _logMessage(ss.str());

    ss.str("");
    ss << "No response yet from INS2 cmigitsDaemon at " << rdsHost <<
            ":" << ins2Port;
    _logMessage(ss.str());

    ss.str("");
    ss << "No response yet from hcrdrx at " << rdsHost << ":" << drxPort;
    _logMessage(ss.str());
    
    _logMessage("No response yet from DataMapper");
    
    // Start with all-zero DataMapper status
    memset(&_dmapStatus, 0, sizeof(_dmapStatus));

    // No status from any daemons yet
    _ui.ins1StatusIcon->setPixmap(_notRespondingLED);
    _ui.ins2StatusIcon->setPixmap(_notRespondingLED);
    _ui.fireflydStatusIcon->setPixmap(_notRespondingLED);
    _ui.hcrdrxStatusIcon->setPixmap(_notRespondingLED);
    _ui.hcrExecutiveStatusIcon->setPixmap(_notRespondingLED);
    _ui.mcStatusIcon->setPixmap(_notRespondingLED);
    _ui.pmc730StatusIcon->setPixmap(_notRespondingLED);
//    _ui.spectracomStatusIcon->setPixmap(_notRespondingLED);
    _ui.xmitterStatusIcon->setPixmap(_notRespondingLED);

    // Disable Spectracom widgets
    _ui.spectracomStatusIcon->setEnabled(false);
    _ui.spectracomStatusLabel->setEnabled(false);
    _ui.spectracomDetailsButton->setEnabled(false);

    // Set up to stop each of our threads when the QApplication quits
    std::vector<QThread*> myThreads {
        &_ins1StatusThread,
        &_ins2StatusThread,
        &_dataMapperStatusThread,
        &_fireflydStatusThread,
//        &_spectracomStatusThread,
        &_hcrdrxStatusThread,
        &_hcrExecutiveStatusThread,
        &_mcStatusThread,
        &_pmcStatusThread
    };

    for (auto thread: myThreads)
    {
        connect(QCoreApplication::instance(), &QCoreApplication::aboutToQuit,
                thread, &QThread::quit);
    }

    // Connect InsOverview's requestNewInsInUse(int) signal to our
    // _setMotionControlInsInUse(int) slot
    connect(&_insOverview, SIGNAL(requestNewInsInUse(int)),
            this, SLOT(_setMotionControlInsInUse(int)));

    // Connect and start the INS1 status gathering thread
    connect(& _ins1StatusThread, SIGNAL(serverResponsive(bool, QString)),
            this, SLOT(_ins1ResponsivenessChange(bool, QString)));
    connect(& _ins1StatusThread, SIGNAL(newStatus(CmigitsStatus)),
            this, SLOT(_setIns1Status(CmigitsStatus)));
    _ins1StatusThread.start();

    // Connect and start the INS2 status gathering thread
    connect(& _ins2StatusThread, SIGNAL(serverResponsive(bool, QString)),
            this, SLOT(_ins2ResponsivenessChange(bool, QString)));
    connect(& _ins2StatusThread, SIGNAL(newStatus(CmigitsStatus)),
            this, SLOT(_setIns2Status(CmigitsStatus)));
    _ins2StatusThread.start();

    // Connect MotionControlStatusWorker's signals and start its QThread
    connect(& _mcStatusWorker, &MotionControlStatusWorker::serverResponsive,
            this, &HcrGuiMainWindow::_mcResponsivenessChange);
    connect(& _mcStatusWorker, &MotionControlStatusWorker::newStatus,
            this, &HcrGuiMainWindow::_setMotionControlStatus);
    _mcStatusThread.start();

    // Connect signals from our HcrdrxStatusThread object and start the thread.
    connect(& _hcrdrxStatusThread, SIGNAL(serverResponsive(bool)),
            this, SLOT(_drxResponsivenessChange(bool)));
    connect(& _hcrdrxStatusThread, SIGNAL(newStatus(DrxStatus)),
            this, SLOT(_setDrxStatus(DrxStatus)));
    _hcrdrxStatusThread.start();

    // Connect signals from our HcrExecutiveStatusThread object and start the thread.
    connect(& _hcrExecutiveStatusThread, SIGNAL(serverResponsive(bool, QString)),
            this, SLOT(_hcrExecutiveResponsivenessChange(bool, QString)));
    connect(& _hcrExecutiveStatusThread, SIGNAL(newStatus(HcrExecutiveStatus)),
            this, SLOT(_setHcrExecutiveStatus(HcrExecutiveStatus)));
    connect(& _hcrExecutiveStatusThread, SIGNAL(hvForcedOffForHighMaxPower(QString)),
            this, SLOT(_reportHvForcedOff(QString)));
    _hcrExecutiveStatusThread.start();

    // Connect signals from our HcrPmc730StatusWorker and its QThread and start the thread.
    connect(QCoreApplication::instance(), &QApplication::aboutToQuit,
            &_pmcStatusThread, &QThread::quit);
    connect(&_pmcStatusWorker, &HcrPmc730StatusWorker::serverResponsive,
            this, &HcrGuiMainWindow::_pmcResponsivenessChange);
    connect(&_pmcStatusWorker, &HcrPmc730StatusWorker::newStatus,
            this, &HcrGuiMainWindow::_setPmcStatus);
    _pmcStatusThread.start();

    // Connect signals from our XmitdStatusThread object and start the thread.
    connect(& _xmitdStatusThread, SIGNAL(serverResponsive(bool)),
            this, SLOT(_xmitdResponsivenessChange(bool)));
    connect(& _xmitdStatusThread, SIGNAL(newStatus(XmitStatus)),
            this, SLOT(_setXmitStatus(XmitStatus)));
    _xmitdStatusThread.start();

    // Connect signals from our DataMapperStatusThread object and start the thread.
    connect(& _dataMapperStatusThread, SIGNAL(serverResponsive(bool)),
            this, SLOT(_dataMapperResponsivenessChange(bool)));
    connect(& _dataMapperStatusThread, SIGNAL(newStatus(DMAP_info_t)),
            this, SLOT(_setDataMapperStatus(DMAP_info_t)));
    _dataMapperStatusThread.start();

    // Connect signals from our FireflydStatusThread object and start the thread.
    connect(& _fireflydStatusThread, SIGNAL(serverResponsive(bool)),
            this, SLOT(_fireflydResponsivenessChange(bool)));
    connect(& _fireflydStatusThread, SIGNAL(newStatus(FireFlyStatus)),
            this, SLOT(_setFireFlyStatus(FireFlyStatus)));
    _fireflydStatusThread.start();

//    // Connect signals from our SpectracomStatusThread object and start the thread.
//    connect(& _spectracomStatusThread, SIGNAL(serverResponsive(bool)),
//            this, SLOT(_spectracomResponsivenessChange(bool)));
//    connect(& _spectracomStatusThread, SIGNAL(newStatus(SpectracomStatus)),
//            this, SLOT(_setSpectracomStatus(SpectracomStatus)));
//    _spectracomStatusThread.start();

    // QUdpSocket listening for broadcast of angles
    _angleSocket.bind(45454, QUdpSocket::ShareAddress);
    connect(&_angleSocket, SIGNAL(readyRead()), this, SLOT(_readAngles()));

    // Time out angle display if new angles stop arriving
    _anglesValidTimer.setInterval(500);    // 1/2 second validity
    _anglesValidTimer.setSingleShot(true);
    connect(& _anglesValidTimer, SIGNAL(timeout()), this, SLOT(_timeoutAngleDisplay()));

    // Update GUI every second
    connect(& _updateTimer, SIGNAL(timeout()), this, SLOT(_update()));
    _updateTimer.start(1000);

    // Start with angle display cleared
    _clearAngleDisplay();
}

HcrGuiMainWindow::~HcrGuiMainWindow() {
}

void
HcrGuiMainWindow::_updateInsOverview() {
    _insOverview.updateStatus(_ins1StatusThread.serverIsResponding(),
                              _ins1Status,
                              _ins2StatusThread.serverIsResponding(),
                              _ins2Status,
                              _mcStatus.insInUse);
}

void
HcrGuiMainWindow::_ins1ResponsivenessChange(bool responding, QString msg) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "INS1 cmigitsDaemon @ " <<
          _ins1StatusThread.rpcClient().getDaemonHost() << ":" <<
          _ins1StatusThread.rpcClient().getDaemonPort() <<
          (responding ? " is " : " is not ") <<
          "responding: " << msg.toStdString();
    _logMessage(ss.str().c_str());

    if (! responding) {
        // Create a default (bad) CmigitsStatus, and set it as the last status
        // received.
        _setIns1Status(CmigitsStatus());
    }
}

void
HcrGuiMainWindow::_setIns1Status(const CmigitsStatus & status) {
    _ins1Status = status;
    // Update the INS overview and INS1 status details dialogs.
    _updateInsOverview();
    _ins1Details.updateStatus(_ins1StatusThread.serverIsResponding(),
                              _ins1Status);
    // Update the main GUI
    _update();
}

void
HcrGuiMainWindow::_ins2ResponsivenessChange(bool responding, QString msg) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "INS2 cmigitsDaemon @ " <<
          _ins2StatusThread.rpcClient().getDaemonHost() << ":" <<
          _ins2StatusThread.rpcClient().getDaemonPort() <<
          (responding ? " is " : " is not ") <<
          "responding: " << msg.toStdString();
    _logMessage(ss.str().c_str());

    if (! responding) {
        // Create a default (bad) CmigitsStatus, and set it as the last status
        // received.
        _setIns2Status(CmigitsStatus());
    }
}

void
HcrGuiMainWindow::_setIns2Status(const CmigitsStatus & status) {
    _ins2Status = status;
    // Update the INS overview and INS2 status details dialogs.
    _updateInsOverview();
    _ins2Details.updateStatus(_ins2StatusThread.serverIsResponding(),
            status);
    // Update the main GUI
    _update();
}

void
HcrGuiMainWindow::_mcResponsivenessChange(bool responding, QString msg) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "MotionControlDaemon " <<
            _mcStatusWorker.daemonUrl() <<
            (responding ? " is " : " is not ") <<
            "responding (" << msg.toStdString() << ")";
    _logMessage(ss.str().c_str());

    if (! responding) {
        // Create a default (bad) MotionControl::Status, and set it as the
        // last status received.
        _setMotionControlStatus(MotionControl::Status());
    }
}

void
HcrGuiMainWindow::_setMotionControlStatus(const MotionControl::Status & status) {
    _mcStatus = status;
    // Update the details dialog
    _motionControlDetails.updateStatus(_mcStatusWorker.daemonResponding(), _mcStatus);
    // Update the main GUI
    _update();
}

void
HcrGuiMainWindow::_pmcResponsivenessChange(bool responding, QString msg) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "HcrPmc730Daemon @ " <<
            _pmcStatusWorker.rpcClient().getDaemonHost() << ":" <<
            _pmcStatusWorker.rpcClient().getDaemonPort() <<
            (responding ? " is " : " is not ") <<
            "responding (" << msg.toStdString() << ")";
    _logMessage(ss.str().c_str());

    if (! responding) {
        // Create a default (bad) Pmc730Status, and set it as the last status
        // received.
        _setPmcStatus(HcrPmc730Status());
    }
}

void
HcrGuiMainWindow::_setPmcStatus(const HcrPmc730Status & status) {
    _pmcStatus = status;
    // Update the details dialog
    _pmc730Details.updateStatus(_pmcStatusWorker.serverIsResponding(),
            _pmcStatus);
    // Update the main GUI
    _update();
}

void
HcrGuiMainWindow::_xmitdResponsivenessChange(bool responding) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "hcr_xmitd @ " <<
            _xmitdStatusThread.rpcClient().getXmitdHost() << ":" <<
            _xmitdStatusThread.rpcClient().getXmitdPort() <<
            (responding ? " is " : " is not ") <<
            "responding";
    _logMessage(ss.str().c_str());

    if (! responding) {
        // Create a default (bad) XmitStatus, and set it as the last status
        // received.
        _setXmitStatus(XmitStatus());
    } else {
        // For a newly responding hcr_xmitd, assume RDS is under control until
        // we get a new status
        _rdsXmitControl = true;
    }
}

void
HcrGuiMainWindow::_setXmitStatus(XmitStatus status) {  
    _xmitStatus = status;
    
    // If the CMU switch for control source is set to anything other than
    // "RDS", let the user know immediately.
    switch (_xmitStatus.controlSource()) {
    case XmitStatus::RDSControl:
        if (! _rdsXmitControl) {
            _rdsXmitControl = true;
            QMessageBox box(QMessageBox::Information,
                    "Transmitter Under RDS Control",
                    "The transmitter CMU control switch is now set to 'RDS'.",
                    QMessageBox::Ok, this);
            box.setInformativeText(
                    "GUI control of the transmitter should now function normally.");
            box.exec();
        }
        break;
    case XmitStatus::RS232Control:
    case XmitStatus::FrontPanelControl:
        if (_rdsXmitControl) {
            _rdsXmitControl = false;
            QMessageBox box(QMessageBox::Warning,
                    "Bad Transmitter Control Source",
                    "The transmitter CMU control switch is not set to 'RDS'.",
                    QMessageBox::Ok, this);
            box.setInformativeText(
                    "GUI control of the transmitter will generate unexpected results!");
            box.exec();
        }
        break;
    case XmitStatus::UnknownControl:
    default:
        // Do nothing if the controller for the transmitter is unknown. This
        // is the case when the transmitter CMU is not replying to status 
        // requests on its RS-232 interface.
        break;
    }
    
    // Update the transmitter status details dialog
    _xmitDetails.updateStatus(_xmitdStatusThread.serverIsResponding(),
            _xmitStatus);
    
    // Update the main GUI
    _update();
}

void
HcrGuiMainWindow::_fireflydResponsivenessChange(bool responding) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "fireflyd @ " <<
            _fireflydStatusThread.rpcClient().getFireflydHost() << ":" <<
            _fireflydStatusThread.rpcClient().getFireflydPort() <<
            (responding ? " is " : " is not ") <<
            "responding";
    _logMessage(ss.str().c_str());

    if (! responding) {
        // Create a default (bad) FireFlyStatus, and set it as the last status
        // received.
        _setFireFlyStatus(FireFlyStatus());
    }
}

void
HcrGuiMainWindow::_setFireFlyStatus(FireFlyStatus status) {
    _fireflydStatus = status;
    // Update the fireflyd status details dialog
    _fireflydDetails.updateStatus(_fireflydStatusThread.serverIsResponding(),
            _fireflydStatus);
    // Update the main GUI
    _update();
}

//void
//HcrGuiMainWindow::_spectracomResponsivenessChange(bool responding) {
//    // log the responsiveness change
//    std::ostringstream ss;
//    ss << "SpectracomDaemon @ " <<
//            _spectracomStatusThread.rpcClient().getDaemonHost() << ":" <<
//            _spectracomStatusThread.rpcClient().getDaemonPort() <<
//            (responding ? " is " : " is not ") <<
//            "responding";
//    _logMessage(ss.str().c_str());
//
//    if (! responding) {
//        // Create a default (bad) SpectracomStatus, and set it as the last
//        // status received.
//        _setSpectracomStatus(SpectracomStatus());
//    }
//}
//
//void
//HcrGuiMainWindow::_setSpectracomStatus(SpectracomStatus status) {
//    _spectracomStatus = status;
//    // Update the Spectracom status details dialog
//    _spectracomDetails.updateStatus(_spectracomStatusThread.serverIsResponding(),
//            _spectracomStatus);
//    // Update the main GUI
//    _update();
//}

void
HcrGuiMainWindow::_hcrExecutiveResponsivenessChange(bool responding, QString msg) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "HcrExecutive @ " <<
            _hcrExecutiveStatusThread.daemonHost() << ":" <<
            _hcrExecutiveStatusThread.daemonPort() <<
            (responding ? " is " : " is not ") <<
            "responding (" << msg.toStdString() << ")";
    _logMessage(ss.str().c_str());

    if (! responding) {
        // Create a default (bad) HcrExecutiveStatus, and set it as the last 
        // status received.
        _setHcrExecutiveStatus(HcrExecutiveStatus());
    }
}

void
HcrGuiMainWindow::_setHcrExecutiveStatus(HcrExecutiveStatus status) {
    _hcrExecutiveStatus = status;
    // Update the details dialog
    _hcrExecutiveDetails.updateStatus(_hcrExecutiveStatusThread.serverIsResponding(),
            _hcrExecutiveStatus, _pmcStatus);
    // Update the main GUI
    _update();
}

void
HcrGuiMainWindow::_drxResponsivenessChange(bool responding) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "hcrdrx @ " <<
            _hcrdrxStatusThread.rpcClient().getHcrdrxHost() << ":" <<
            _hcrdrxStatusThread.rpcClient().getHcrdrxPort() <<
            (responding ? " is " : " is not ") <<
            "responding";
    _logMessage(ss.str().c_str());

    // Enable the dataBox widget iff hcrdrx is responsive
    _ui.dataBox->setEnabled(responding);

    // If hcrdrx is not responding, create a default (bad) DrxStatus, and set it
    // as the last status received.
    if (! responding) {
        _setDrxStatus(DrxStatus());
    }
}

void
HcrGuiMainWindow::_setDrxStatus(DrxStatus status) {
    _drxStatus = status;
    // Update the details dialog
    _hcrdrxDetails.updateStatus(_hcrdrxStatusThread.serverIsResponding(),
            _drxStatus);
    // Update the main GUI
    _update();
}

void
HcrGuiMainWindow::_dataMapperResponsivenessChange(bool responding) {
    // log the responsiveness change
    std::ostringstream ss;
    ss << "DataMapper" << (responding ? " is " : " is not ") <<
            "responding";
    _logMessage(ss.str().c_str());

    if (! responding) {
        // Set current status to all zero values
        DMAP_info_t emptyDmapStatus;
        memset(&emptyDmapStatus, 0, sizeof(emptyDmapStatus));
        _setDataMapperStatus(emptyDmapStatus);
    }
}

void
HcrGuiMainWindow::_setDataMapperStatus(DMAP_info_t newStatus) {
    time_t now = time(0);
    
    // If the status time has changed, calculate write rate using incoming and
    // previous status.
    ti32 deltaTime = newStatus.end_time - _dmapStatus.end_time;
    if (deltaTime > 0) {
        double mbWritten = (newStatus.total_bytes - _dmapStatus.total_bytes) /
                1.0e6;
        _dmapWriteRate = mbWritten / deltaTime; // MB/s
        _dmapWriteRateTime = now;
        DLOG << mbWritten << " bytes written in " << deltaTime << "s";
        DLOG << "New write rate for " << newStatus.end_time << " (@ " <<
                now << "): " << _dmapWriteRate;
    } else {
        // Time out the old write rate after TIMEOUT_SECS
        const int TIMEOUT_SECS = 60;
        if ((now - _dmapWriteRateTime) > TIMEOUT_SECS) {
            WLOG << _dmapWriteRateTime << " write rate has timed out";
            _dmapWriteRate = 0.0;
            _dmapWriteRateTime = now;
        }
    }
    // Store incoming status
    _dmapStatus = newStatus;
//    // Update the details dialog
//    _dmapDetails.updateStatus(_dmapStatus);
    // Update the main GUI
    _update();
}

bool
HcrGuiMainWindow::_xmitting() const {
    bool xmitting;
    // If RDS is in control, we have to use the state of the RDS control lines
    // from the PMC-730. The status reported directly by the transmitter will 
    // *not* reflect the correct state when RDS is in control.
    //
    // If the control source is unknown (this is true when hcr_xmitd is not
    // responding), we assume RDS control since that's effectively always true
    // for HCR.
    if (_rdsXmitControl) {
        // We're transmitting if the filament is on, HV is on, modulation
        // pulses are being allowed through, and we have no HV disabling fault.
        bool hvDisableFault = _xmitStatus.bodyCurrentFault() ||
                _xmitStatus.cathodeLorFault() ||
                _xmitStatus.collectorCurrentFault() ||
                _xmitStatus.eikInterlockFault() ||
                _xmitStatus.externalInterlockFault() ||
                _xmitStatus.filamentLorFault() ||
                _xmitStatus.modulatorFault() ||
                _xmitStatus.focusElectrodeLorFault() ||
                _xmitStatus.inverterOverloadFault() ||
                _xmitStatus.summaryFault() ||
                _xmitStatus.waveguideArcFault() ||
                _xmitStatus.xmitterTempFault();
        xmitting = _pmcStatus.rdsXmitterFilamentOn() && _pmcStatus.rdsXmitterHvOn() &&
                ! _pmcStatus.modPulseDisabled() && ! hvDisableFault;
    } else {
        // If transmitter is not under RDS control, we can just use the
        // "RF on" status bit to tell us we're transmitting.
        xmitting = _xmitStatus.rfOn();
    }
    return(xmitting);
}

/// Pop up the antenna mode editing dialog
void
HcrGuiMainWindow::on_antennaModeButton_clicked() {
    // Pop up the antenna mode dialog, and apply the new mode if the dialog
    // is accepted.
    if (_antennaModeDialog.exec() == QDialog::Accepted) {
        if (_antennaModeDialog.getMode() == AntennaModeDialog::POINTING) {
            float angle;
            _antennaModeDialog.getPointingAngle(angle);
            // Point the antenna to the angle
            _mcStatusWorker.point(angle);
        }
        else if (_antennaModeDialog.getMode() == AntennaModeDialog::SCANNING) {
            float ccwLimit, cwLimit, scanRate, beamTilt;
            _antennaModeDialog.getScanningParam(ccwLimit, cwLimit, scanRate,
                    beamTilt);
            // If beam tilt angle is not zero, confirm that it's intentional.
            if (beamTilt != 0.0) {
                QMessageBox confirmBox(QMessageBox::Question,
                        "Confirm Non-Zero Tilt",
                        "A non-zero tilt angle was given for the scan.\n"
                        "Are you sure you want to continue?",
                        QMessageBox::Ok | QMessageBox::Cancel, this);
                confirmBox.setInformativeText(
                        "Non-zero tilt is only useful for special scanning cases");
                if (confirmBox.exec() == QMessageBox::Cancel) {
                    return;
                }
            }
            // Start scanning
            _mcStatusWorker.scan(ccwLimit, cwLimit, scanRate, beamTilt);
        }
    }
}

/// Toggle motion control attitude correction
void
HcrGuiMainWindow::on_attitudeCorrectionButton_clicked() {
    // Toggle the current state of attitude correction
    bool correction = _mcStatus.attitudeCorrectionEnabled;
    ILOG << "Correction is currently " << (correction ? "enabled": "disabled");
    _mcStatusWorker.setCorrectionEnabled(! correction);
}

void
HcrGuiMainWindow::on_ins1DetailsButton_clicked() {
    _ins1Details.show();
}

void
HcrGuiMainWindow::on_ins2DetailsButton_clicked() {
    _ins2Details.show();
}

void
HcrGuiMainWindow::on_insOverviewButton_clicked() {
    _insOverview.show();
}

/// Set drives to home position
void
HcrGuiMainWindow::on_driveHomeButton_clicked() {
    // Confirm that it's OK to set drives to home position
    QMessageBox confirmBox(QMessageBox::Question, "Confirm Home Drives",
            "Continue to home the drives?",
            QMessageBox::Ok | QMessageBox::Cancel, this);
    confirmBox.setInformativeText(
            "Radar transmitter must be turned off before homing drives!\n");
    if (confirmBox.exec() == QMessageBox::Cancel) {
        return;
    }

    // Save the current state of attitude correction, then disable correction
    // until we exit. At exit, the current correction state will be restored.
    // We disable correction because we need the motors to remain at their
    // zero-count positions after homing long enough for us to also zero the
    // motor counts on the Pentek.
    bool savedState = _mcStatus.attitudeCorrectionEnabled;
    _mcStatusWorker.setCorrectionEnabled(false);

    // Start the drive homing program.
    _mcStatusWorker.homeDrive();

    // Poll until homing is complete
    ILOG << "Waiting for servo drives to complete homing";
    while (true) {
        if (! _mcStatusWorker.homingInProgress()) {
            break;
        }
        // Let other things run for up to 200 ms
        QCoreApplication::processEvents(QEventLoop::AllEvents, 200);
    }
    
    // Update motion control status and verify drives actually got homed. Pop up
    // a warning box if homing failed.
    _mcStatus = _mcStatusWorker.status();
    if (! _mcStatus.rotDriveHomed || ! _mcStatus.tiltDriveHomed) {
        WLOG << "Homing failed";
        // Let the user know that homing failed
        QMessageBox failureBox(QMessageBox::Warning, "Homing Failed",
                "Drive homing failed!\nYou will need to try again.",
                QMessageBox::Ok, this);
        failureBox.exec();
        goto done;
    }

    // With the motors both at their zero positions, tell the Pentek to zero
    // its position counts for both motors.
    // We sleep briefly to give hcrdrx long enough to handle the XML-RPC call
    // to zero motor counts on the Pentek card, then restore the previous state
    // for attitude correction.
    ILOG << "Elmo homing complete. Zeroing Pentek's motor counts.";
    _hcrdrxStatusThread.rpcClient().zeroPentekMotorCounts();
    usleep(100000);

done:
    _mcStatusWorker.setCorrectionEnabled(savedState);
}

/// Toggle the current on/off state of the transmitter klystron filament
void
HcrGuiMainWindow::on_filamentButton_clicked() {
    // Send the command to toggle filament state to both hcr_xmitd and 
    // HcrPmc730Daemon. If the transmitter is under RDS control (generally 
    // true), the filament line is handled by HcrPmc730Daemon. If RS-232 
    // control, the filament line is handled by hcr_xmitd. We need to cover 
    // both cases.
    if (_pmcStatus.rdsXmitterFilamentOn()) {
        try {
            _pmcStatusWorker.rpcClient().xmitFilamentOff();
        } catch (std::exception & e) {
            WLOG << "Could not tell HcrPmc730Daemon to turn off filament";
        }
    } else {
        try {
            _pmcStatusWorker.rpcClient().xmitFilamentOn();
        } catch (std::exception & e) {
            WLOG << "Could not tell HcrPmc730Daemon to turn on filament";
        }
    }
}

void
HcrGuiMainWindow::on_hcrdrxDetailsButton_clicked() {
    _hcrdrxDetails.show();
}

/// Set Operation mode via HcrExecutive
void
HcrGuiMainWindow::on_requestedModeCombo_activated(int index) {
    
    auto mode = _ui.requestedModeCombo->itemData(index).value<OperationMode>();

    // Set a new requested Operation mode on HcrExecutive
    try {
        ILOG << "Requesting Operation mode " << mode.name();
        _hcrExecutiveStatusThread.rpcClient().setRequestedOperationMode(mode);
    } catch (std::exception & e) {
        WLOG << "Could not tell HcrExecutive to request Operation mode " << mode.name();
    }
}

/// Toggle the requested transmitter high voltage state
void
HcrGuiMainWindow::on_requestHvButton_clicked() {
    // Send the command to request toggle of HV state to HcrExecutive.
    if (_hcrExecutiveStatus.hvRequested()) {
        try {
            ILOG << "Requesting HV off";
        	_hcrExecutiveStatusThread.rpcClient().setHvRequested(false);
        } catch (std::exception & e) {
            WLOG << "Could not tell HcrExecutive to turn off HV";
        }
    } else {
        try {
            ILOG << "Requesting HV on";
        	_hcrExecutiveStatusThread.rpcClient().setHvRequested(true);
        } catch (std::exception & e) {
            WLOG << "Could not tell HcrExecutive to turn on HV";
        }
    }
}

void
HcrGuiMainWindow::on_mcDetailsButton_clicked() {
    _motionControlDetails.show();
}

void
HcrGuiMainWindow::on_pmc730DetailsButton_clicked() {
    _pmc730Details.show();
}

void
HcrGuiMainWindow::on_showLogButton_clicked() {
    _logWindow.show();
}

void
HcrGuiMainWindow::on_xmitterDetailsButton_clicked() {
    _xmitDetails.show();
}

void
HcrGuiMainWindow::on_fireflydDetailsButton_clicked() {
    _fireflydDetails.show();
}

//void
//HcrGuiMainWindow::on_spectracomDetailsButton_clicked() {
//    _spectracomDetails.show();
//}

void
HcrGuiMainWindow::on_hcrExecutiveDetailsButton_clicked() {
    _hcrExecutiveDetails.show();
}

void
HcrGuiMainWindow::_update() {
    // convenience variable
    QPixmap light;

    // Update the current time string
    char timestring[32];
    time_t now = time(0);
    strftime(timestring, sizeof(timestring) - 1, "%F %T", gmtime(&now));
    _ui.clockLabel->setText(timestring);
    
    // Update transmitter control
    _ui.powerValidIcon->setPixmap(_xmitStatus.psmPowerOn() ? _greenLED : _greenLED_off);
    _ui.filamentIcon->setPixmap(_pmcStatus.rdsXmitterFilamentOn() ? _greenLED : _greenLED_off);
    if (! _pmcStatus.rdsXmitterFilamentOn()) {
        // Turn off warmup LED if the filament is not on
        _ui.filamentWarmupIcon->setPixmap(_greenLED_off);
        _ui.filamentWarmupLabel->setText("Filament warmup");
    } else {
        // Amber during filament warmup, then green when warm
        _ui.filamentWarmupIcon->setPixmap(_xmitStatus.filamentDelayActive() ? _amberLED : _greenLED);
        _ui.filamentWarmupLabel->setText(_xmitStatus.filamentDelayActive() ?
                "Waiting for warmup" : "Filament is warm");
    }
    // Show the results of TransmitControl tests. Change background color of
    // the box if transmit is not allowed or if attenuation is required.
    _ui.hcrExecutiveResultText->
        setText(_hcrExecutiveStatus.xmitAllowedStatusText().c_str());

    std::string styleSheet = "";
    if (! _hcrExecutiveStatus.transmitAllowed()) {
        // Transmit not allowed; make the background light pink
        styleSheet = "background-color: #FFD0D0";
    } else if (_hcrExecutiveStatus.attenuationRequired()) {
        // Attenuation required; make the background light yellow
        styleSheet = "background-color: #FFFFD0";
    }
    _ui.hcrExecutiveResultText->setStyleSheet(styleSheet.c_str());
    // HV requested?
    _ui.requestHvIcon->setPixmap(_hcrExecutiveStatus.hvRequested() ?
            _greenLED : _greenLED_off);
    _ui.hvOnIcon->setPixmap(_pmcStatus.rdsXmitterHvOn() ? _greenLED : _greenLED_off);
    // Enable the request HV button as soon as HcrExecutive is responding
    _ui.requestHvButton->setEnabled(_hcrExecutiveStatusThread.serverIsResponding());
    // Regardless of other conditions, force the request HV button to be enabled
    // if HV is on, so that it can be turned off.
    if (_pmcStatus.rdsXmitterHvOn()) {
        _ui.requestHvButton->setEnabled(true);
    }
    _ui.xmittingIcon->setPixmap(_xmitting() ? _greenLED : _greenLED_off);

    // Which control source is enabled?
    switch (_xmitStatus.controlSource()) {
    case XmitStatus::FrontPanelControl:
        _ui.controlSourceLabel->setText("Control via <b>Front Panel</b>");
        break;
    case XmitStatus::RS232Control:
        _ui.controlSourceLabel->setText("Control via <b>RS-232</b>");
        break;
    case XmitStatus::RDSControl:
        _ui.controlSourceLabel->setText("Control via <b>RDS</b>");
        break;
    default:
        // Unknown control source. Show "Unknown" in dark red text.
        _ui.controlSourceLabel->setText("Control via <b><font color=#880000>Unknown</font></b>");
        break;
    }

    // Status summary: "OK" or "<n> Faults".
    int faultCount = 0;
    faultCount += _xmitStatus.modulatorFault() ? 1 : 0;
    faultCount += _xmitStatus.syncFault() ? 1 : 0;
    faultCount += _xmitStatus.xmitterTempFault() ? 1 : 0;
    faultCount += _xmitStatus.waveguideArcFault() ? 1 : 0;
    faultCount += _xmitStatus.collectorCurrentFault() ? 1 : 0;
    faultCount += _xmitStatus.bodyCurrentFault() ? 1 : 0;
    faultCount += _xmitStatus.filamentLorFault() ? 1 : 0;
    faultCount += _xmitStatus.focusElectrodeLorFault() ? 1 : 0;
    faultCount += _xmitStatus.cathodeLorFault() ? 1 : 0;
    faultCount += _xmitStatus.inverterOverloadFault() ? 1 : 0;
    faultCount += _xmitStatus.externalInterlockFault() ? 1 : 0;
    faultCount += _xmitStatus.eikInterlockFault() ? 1 : 0;

    // Set the overall transmitter status LED
    if (!_xmitdStatusThread.serverIsResponding()) {
        _ui.xmitterStatusIcon->setPixmap(_notRespondingLED);
    }
    else if (! _xmitStatus.serialConnected() || (faultCount > 0)) {
        _ui.xmitterStatusIcon->setPixmap(_redLED);
    } else {
        _ui.xmitterStatusIcon->setPixmap(_greenLED);
    }

    // Operation mode
    if (_hcrdrxStatusThread.serverIsResponding()) {
        if(! _ui.requestedModeCombo->count()) {
            for(auto&& mode: _drxStatus.supportedOpsModes()) {
                _ui.requestedModeCombo->addItem(mode.name().c_str(), QVariant::fromValue(mode));
            }
        }
        _ui.requestedModeCombo->setPlaceholderText("");
        _ui.requestedModeCombo->setCurrentIndex(-1);
        auto reqMode = _hcrExecutiveStatus.requestedOperationMode();
        for(auto i = 0; i < _ui.requestedModeCombo->count(); ++i) {
            auto itemMode = _ui.requestedModeCombo->itemData(i).value<OperationMode>();
            if(reqMode == itemMode) {
                _ui.requestedModeCombo->setCurrentIndex(i);
            }
        }
    }
    else {
        _ui.requestedModeCombo->clear();        
        _ui.requestedModeCombo->setPlaceholderText("[No DRX]");
    }

    std::string modeText = _drxStatus.currentOpsMode().name();
    _ui.opsModeValue->setText(QString::fromStdString(modeText));

    // INS1 status light:
    // Green light if mode is "Air Navigation" or "Land Navigation" and we have
    // more than 5 satellites in the current solution.
    // Amber light if we have both INS and GPS
    // Red light otherwise
    if (! _ins1StatusThread.serverIsResponding()) {
        light = _notRespondingLED;
    } else {
        uint16_t mode = _ins1Status.currentMode();
        if ((mode == 7 || mode == 8) && _ins1Status.nSats() > 5) {
            light = _greenLED;
        } else if (_ins1Status.insAvailable() &&
                   _ins1Status.gpsAvailable()) {
            light = _amberLED;
        } else {
            light = _redLED;
        }
    }
    _ui.ins1StatusIcon->setPixmap(light);

    // Enable INS1 label if it's the INS in use by MotionControlDaemon
    _ui.ins1StatusLabel->setEnabled(_mcStatus.insInUse == 1);

    // INS2 status light:
    // Green light if mode is "Air Navigation" or "Land Navigation" and we have
    // more than 5 satellites in the current solution.
    // Amber light if we have both INS and GPS
    // Red light otherwise
    if (! _ins2StatusThread.serverIsResponding()) {
        light = _notRespondingLED;
    } else {
        uint16_t mode = _ins2Status.currentMode();
        if ((mode == 7 || mode == 8) && _ins2Status.nSats() > 5) {
            light = _greenLED;
        } else if (_ins2Status.insAvailable() &&
                   _ins2Status.gpsAvailable()) {
            light = _amberLED;
        } else {
            light = _redLED;
        }
    }
    _ui.ins2StatusIcon->setPixmap(light);

    // Enable INS1 label if it's the INS in use by MotionControlDaemon
    _ui.ins2StatusLabel->setEnabled(_mcStatus.insInUse == 2);

    // MotionControl status LED
    if (! _mcStatusWorker.daemonResponding()) {
        _ui.mcStatusIcon->setPixmap(_notRespondingLED);
    } else if (_motionControlDetails.errorDetected()) {
        _ui.mcStatusIcon->setPixmap(_redLED);
    } else if (_motionControlDetails.warningDetected()) {
        _ui.mcStatusIcon->setPixmap(_amberLED);
    } else {
        _ui.mcStatusIcon->setPixmap(_greenLED);
    }

    if (_mcStatusWorker.daemonResponding()) {
        // Reflector mode
        std::ostringstream ss;
        switch (_mcStatus.antennaMode) {
        case MotionControl::MODE_POINTING:
            ss << "Fixed pointing at " << _mcStatus.fixedPointingAngle << " deg";
            break;
        case MotionControl::MODE_SCANNING:
            ss << "Scanning:\n" <<
                "    from " << _mcStatus.scanCcwLimit << " deg CCW to " <<
                _mcStatus.scanCwLimit << " deg CW\n" <<
                "    at " << _mcStatus.scanRate << " deg/s";
            break;
        default:
            ss << "Unknown antenna mode " << _mcStatus.antennaMode;
            break;
        }
        _ui.antennaModeLabel->setText(ss.str().c_str());

        // Attitude correction
        _ui.attitudeCorrectionWidget->setEnabled(true);
        _ui.attitudeCorrectionIcon->setPixmap(
                _mcStatus.attitudeCorrectionEnabled ?
                _greenLED : _greenLED_off);

        // Drive homing
        if (_mcStatus.rotDriveHomed && _mcStatus.tiltDriveHomed) {
            _ui.driveHomeButton->setText("Rehome the Drives");
            _ui.driveHomeButton->setEnabled(true);
        	_ui.antennaModeButton->setEnabled(true);
        } else {
            _ui.driveHomeButton->setText("Home the Drives");
            _ui.driveHomeButton->setEnabled(true);
            _ui.antennaModeButton->setEnabled(false);
        }
    } else {
        _mcStatus = MotionControl::Status();    // go to an empty status
        _ui.antennaModeLabel->setText("<font color='DarkRed'>MotionControlDaemon not responding</font>");
        _ui.attitudeCorrectionWidget->setEnabled(false);
        _ui.driveHomeButton->setEnabled(false);
        _ui.antennaModeButton->setEnabled(false);
    }
    
    // hcrdrx status LED
    light = _greenLED;
    if (! _hcrdrxStatusThread.serverIsResponding()) {
        // Red light if hcrdrx is not responding
        light = _notRespondingLED;
    } else if (! _drxStatus.motorZeroPositionSet()) {
        // Amber light if motor zero position has not been set
        light = _amberLED;
    }
    _ui.hcrdrxStatusIcon->setPixmap(light);

    // HcrPmc730Daemon status LED
    light = _greenLED;
    if (! _pmcStatusWorker.serverIsResponding()) {
        light = _notRespondingLED;
    } else if (_pmc730Details.errState()) {
        light = _redLED;
    } else if (_pmc730Details.warnState()) {
        light = _amberLED;
    }
    _ui.pmc730StatusIcon->setPixmap(light);
    
    // fireflyd status LED
    if (! _fireflydStatusThread.serverIsResponding()) {
        light = _notRespondingLED;
    } else {
        // If we have a good status, use its overallStatus() value
        switch (_fireflydStatus.overallStatus()) {
        case FireFlyStatus::OK:
            light = _greenLED;
            break;
        case FireFlyStatus::WARNING:
            light = _amberLED;
            break;
        case FireFlyStatus::ERROR:
            light = _redLED;
            break;
        default:
            ELOG << "Unknown FireFlyStatus severity " <<
                _fireflydStatus.overallStatus() << " treated as an error";
            light = _redLED;
            break;
        }
    }
    _ui.fireflydStatusIcon->setPixmap(light);

//    // Spectracom status LED
//    switch (_spectracomStatus.simpleStatus()) {
//    case 0:     // good status
//        light = _greenLED;
//        break;
//    case 1:     // minor issue(s)
//        light = _amberLED;
//        break;
//    case 2:     // major issue(s)
//        light = _redLED;
//        break;
//    default:    // shouldn't get here...
//        light = _greenLED_off;
//    }
//    _ui.spectracomStatusIcon->setPixmap(light);

    // HcrExecutive status LED
    if (! _hcrExecutiveStatusThread.serverIsResponding()) {
        light = _notRespondingLED;
    } else {
        // If normal transmit is allowed use green light, otherwise amber
        light = (_hcrExecutiveStatus.xmitAllowedStatus() == TransmitControl::XMIT_ALLOWED) ?
                _greenLED : _amberLED;
    }
    _ui.hcrExecutiveStatusIcon->setPixmap(light);

    // DataMapper status LED and current write rate
    _ui.dmStatusIcon->setPixmap(_dataMapperStatusThread.serverIsResponding() ?
            _greenLED : _notRespondingLED);
    _ui.dataRateIcon->setPixmap(_dmapWriteRate > 0 ? _greenLED : _amberLED);
    _ui.writeRateValue->setText(QString::number(_dmapWriteRate, 'f', 0));

    // Location info from the INS in use
    const CmigitsStatus insInUseStatus = ((_mcStatus.insInUse == 1) ? _ins1Status : _ins2Status);
    _ui.latitudeValue->setText(QString::number(insInUseStatus.latitude(), 'f', 4));
    _ui.longitudeValue->setText(QString::number(insInUseStatus.longitude(), 'f', 4));

    int iAltFt = int(MetersToFeet(insInUseStatus.altitude()));
    _ui.altitudeMslValue->setText(QString::number(iAltFt));

    iAltFt = int(MetersToFeet(_hcrExecutiveStatus.aglAltitude()));
    _ui.altitudeAglValue->setText(QString::number(iAltFt));

    _ui.surfaceValue->setText(_hcrExecutiveStatus.overWater() ? "Water" : "Land");
}

void
HcrGuiMainWindow::_logMessage(std::string message) {
    _logWindow.appendPlainText(
            QDateTime::currentDateTime().toUTC().toString("yyyy-MM-dd hh:mm:ss ") + 
            message.c_str());
    ILOG << message;
}

void
HcrGuiMainWindow::_readAngles()
{
    // Note that these two *must* be 32-bit floats, since the data we memcpy
    // into these variables from the UDP stream is 32-bit floats.
    float rotation = 0.0;
    float tilt = 0.0;

    while (_angleSocket.hasPendingDatagrams()) {
        QByteArray datagram;
        datagram.resize(_angleSocket.pendingDatagramSize());
        QHostAddress sender;
        quint16 senderPort;
        _angleSocket.readDatagram(datagram.data(), datagram.size(),
                                &sender, &senderPort);

        memcpy(reinterpret_cast<char*>(&rotation), datagram.data(), 4);
        memcpy(reinterpret_cast<char*>(&tilt), datagram.data() + 4, 4);

        // Start/restart the timer which will clear the angle display if
        // angles stop arriving.
        _anglesValidTimer.start();
    }
    // Only update the GUI if the time since last update is greater than 50 ms.
    // The test is klugy for now, since older QDateTime implementations do not
    // have the msecsTo(QDateTime) method... Mostly the test below works, but
    // we'll wait up to a second for an update at a day boundary.
    QDateTime now = QDateTime::currentDateTime();
    if (_lastAngleUpdate.secsTo(now) > 0 ||
            _lastAngleUpdate.time().msecsTo(now.time()) > 50) {
        _ui.rotationValue->setText(QString::number(rotation, 'f', 2));
        _showRotAngle(rotation);
        _ui.tiltValue->setText(QString::number(tilt, 'f', 2));
        _showTiltAngle(tilt);

        _lastAngleUpdate = now;
    }
}

void HcrGuiMainWindow::_showRotAngle(float rotAngle)
{
	QPixmap *rotDisplay = new QPixmap(90, 90);
	QPainter painter(rotDisplay);
	painter.setRenderHint(QPainter::Antialiasing);
	// Background
	painter.setPen(Qt::NoPen);
	painter.setBrush(QColor(0, 100, 0));
	painter.drawRect(0, 0, 90, 90);
	// Scan range
	double ccwLimit = _mcStatus.scanCcwLimit;
	double cwLimit = _mcStatus.scanCwLimit;
	double scanRange = cwLimit - ccwLimit;
	if (scanRange < 0)
		scanRange += 360;
	if (_mcStatus.antennaMode == MotionControl::MODE_SCANNING) {
	   	painter.setBrush(QColor(0, 200, 80));
	   	painter.drawPie(13, 13, 64, 64, (90-ccwLimit)*16, -scanRange*16);
	}
	// Circles
	QPen pen("lightgreen");
	painter.setPen(pen);
	painter.setBrush(Qt::NoBrush);
	painter.drawEllipse(13, 13, 64, 64);
	// Angle text
	painter.translate(46, 45);
	painter.setFont(QFont("arial", 5, QFont::Bold));
	for (int r = 0; r < 360; r += 30) {
		double theta = (r-90)*M_PI/180.0;
		double dx = 0, dy = 0;
		if (r == 0)   dx = -2;
		if (r == 180) dx = -5;
		if (r > 180)  dx = -13;
		if (r > 90 && r < 270) dy = 5*sin(theta);
		painter.drawText(QPointF(34*cos(theta)+dx, 34*sin(theta)+dy), QString::number(r));
	}
	// Radius lines
	for (int r = 0; r < 360; r += 10) {
		if (r % 30 == 0)
			painter.drawLine(0, 0, 32, 0);
		else
			painter.drawLine(30, 0, 32, 0);
		painter.rotate(10);
	}
	// If we're scanning, indicate scanning limits
	if (_mcStatus.antennaMode == MotionControl::MODE_SCANNING) {
	    pen.setColor("yellow");
	    pen.setWidth(1);
	    painter.setPen(pen);
	    painter.rotate(ccwLimit-90);
	    painter.drawLine(0, 0, 32, 0);
	    painter.rotate(scanRange);
	    painter.drawLine(0, 0, 32, 0);
	    painter.rotate(90-cwLimit);
	}

    // Draw the current position if the angle is valid
    if (rotAngle != INVALID_ANGLE) {
        pen.setColor("white");
        pen.setWidth(2);
        painter.setPen(pen);
        painter.rotate(rotAngle-90);
        painter.drawLine(0, 0, 32, 0);
    }

	painter.end();
	_ui.rotAngleDisplay->setPixmap(*rotDisplay);
	delete(rotDisplay);
}

void HcrGuiMainWindow::_showTiltAngle(float tiltAngle)
{
	QPixmap *tiltDisplay = new QPixmap(90, 90);
	QPainter painter(tiltDisplay);
	painter.setRenderHint(QPainter::Antialiasing);
	// Background
	painter.setPen(Qt::NoPen);
	painter.setBrush(QColor(0, 100, 0));
	painter.drawRect(0, 0, 90, 90);
	// Pie
	QPen pen("lightgreen");
	painter.setPen(pen);
	painter.setBrush(Qt::NoBrush);
	painter.drawPie(-19, 13, 128, 128, (90+36)*16, -72*16);
	// Angle text
	painter.translate(45, 77);
	painter.setFont(QFont("arial", 6, QFont::Bold));
	for (int r = -36; r <= 36; r += 6) {
		if (r/6 % 2 != 0) continue;
		double theta = (r-90)*M_PI/180.0;
		double dx = 0;
		if (r < 0) dx = -5;
		if (r == 0) dx = -2;
		painter.drawText(QPointF(68*cos(theta)+dx, 68*sin(theta)), QString::number(r/6));
	}
	painter.drawText(QPoint(-39, 8), "Angle Magnified by 6");
	// Radius lines
	painter.rotate(-54);
	int rc = 0;
	for (int r = -36; r <= 36; r += 6) {
		if (r/6 % 2 == 0)
			painter.drawLine(0, 0, 64, 0);
		else
			painter.drawLine(62, 0, 64, 0);
		painter.rotate(-6);
		rc++;
	}
	painter.rotate(54+6*rc);

	// Display current tilt angle, if the angle is valid
	if (tiltAngle != INVALID_ANGLE) {
		pen.setColor("white");
		pen.setWidth(2);
		painter.setPen(pen);
		painter.rotate(tiltAngle*6-90);
		painter.drawLine(0, 0, 64, 0);
	}

	painter.end();
	_ui.tiltAngleDisplay->setPixmap(*tiltDisplay);
	delete(tiltDisplay);
}

void
HcrGuiMainWindow::_timeoutAngleDisplay() {
    _logMessage("Angles from hcrdrx have stopped arriving");
    _clearAngleDisplay();
}

void
HcrGuiMainWindow::_clearAngleDisplay() {
    _ui.rotationValue->setText("---");
    _showRotAngle(INVALID_ANGLE);
    _ui.tiltValue->setText("---");
    _showTiltAngle(INVALID_ANGLE);
}

void
HcrGuiMainWindow::_reportHvForcedOff(QString details) {
    WLOG << "High Voltage forced off by HcrExecutive: " << details.toStdString();
    details += "\nTo transmit, operator must request high voltage again.";
    QMessageBox box(QMessageBox::Warning, "High Voltage Disabled", details,
            QMessageBox::Ok, this);
    box.exec();
}

void
HcrGuiMainWindow::_setMotionControlInsInUse(int requestedIns) {
    // Set MotionControlDaemon's 'INS in use'
    ILOG << "Requesting MotionControlDaemon to change INS in use from " <<
            _mcStatus.insInUse << " to " << requestedIns;
    _mcStatusWorker.setInsInUse(requestedIns);
}

