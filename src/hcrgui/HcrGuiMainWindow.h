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
 *  Created on: Jan 14, 2011
 *      Author: burghart
 */
#ifndef HCRGUIMAINWINDOW_H_
#define HCRGUIMAINWINDOW_H_

#include <string>
#include <map>
#include <deque>
#include <ctime>

#include <QMainWindow>
#include <QPixmap>
#include <QPainter>
#include <QTimer>
#include <QUdpSocket>

#include <CmigitsStatusThread.h>
#include <HcrPmc730StatusWorker.h>
#include <HcrExecutiveStatusThread.h>
#include <MotionControlStatusThread.h>

#include "DataMapperStatusThread.h"
#include "FireflydStatusThread.h"
#include "HcrdrxStatusThread.h"
//#include "SpectracomStatusThread.h"
#include "XmitdStatusThread.h"

#include "ui_HcrGuiMainWindow.h"

#include "HcrGuiLogWindow.h"

#include "CmigitsDetails.h"
#include "FireflydDetails.h"
#include "HcrdrxDetails.h"
#include "HcrExecutiveDetails.h"
#include "InsOverview.h"
#include "MotionControlDetails.h"
#include "Pmc730Details.h"
//#include "SpectracomDetails.h"
#include "XmitDetails.h"

#include "AntennaModeDialog.h"

class HcrGuiMainWindow : public QMainWindow {
    Q_OBJECT

public:
    HcrGuiMainWindow(std::string archivererHost, int xmitterPort,
            int fireflydPort, int spectracomPort, std::string rdsHost,
            int drxPort, int pmcPort, int ins1Port,
            int ins2Port, int motionControlPort,
            int hcrExecutivePort);
    virtual ~HcrGuiMainWindow();

private slots:
    void on_antennaModeButton_clicked();
    void on_attitudeCorrectionButton_clicked();
    void on_driveHomeButton_clicked();
    void on_filamentButton_clicked();
    void on_requestedModeCombo_activated(int index);
    void on_requestHvButton_clicked();
    void on_showLogButton_clicked();

    void on_fireflydDetailsButton_clicked();
    void on_hcrdrxDetailsButton_clicked();
    void on_hcrExecutiveDetailsButton_clicked();
    void on_ins1DetailsButton_clicked();
    void on_ins2DetailsButton_clicked();
    void on_insOverviewButton_clicked();
    void on_mcDetailsButton_clicked();
    void on_pmc730DetailsButton_clicked();
//    void on_spectracomDetailsButton_clicked();
    void on_xmitterDetailsButton_clicked();

    /// @brief Update GUI state based on _xmitStatus and _pmcStatus
    void _update();
    /// @brief read angle(s) available on the broadcast port
    void _readAngles();
    
    /// @brief Slot to call when the INS1 cmigitsDaemon responsiveness changes.
    /// @param responding True iff the server is currently responsive.
    /// @param msg message describing the responsiveness change event
    void _ins1ResponsivenessChange(bool responding, QString msg);
    /// @brief Save the last status received from the INS1 cmigitsDaemon and
    /// update the GUI.
    /// @param status the last status received from the INS1 cmigitsDaemon
    void _setIns1Status(const CmigitsStatus & status);
    /// @brief Slot to call when the INS2 cmigitsDaemon responsiveness changes.
    /// @param responding True iff the server is currently responsive.
    /// @param msg message describing the responsiveness change event
    void _ins2ResponsivenessChange(bool responding, QString msg);
    /// @brief Save the last status received from the INS2 cmigitsDaemon and
    /// update the GUI.
    /// @param status the last status received from the INS2 cmigitsDaemon
    void _setIns2Status(const CmigitsStatus & status);
    /// @brief Slot to call when MotionControlDaemon responsiveness changes.
    /// @param responding True iff the server is currently responsive.
    /// @param msg message describing the responsiveness change event
    void _mcResponsivenessChange(bool responding, QString msg);
    /// @brief Save the last status received from MotionControlDaemon.
    /// @param status the last status received from MotionControlDaemon.
    void _setMotionControlStatus(const MotionControl::Status & status);
    /// @brief Slot to call when HcrPmc730Daemon server responsiveness changes.
    /// @param responding True iff the server is currently responsive.
    /// @param msg Text message describing responsiveness change.
    void _pmcResponsivenessChange(bool responding, QString msg);
    /// @brief Save the last status received from HcrPmc730Daemon.
    /// @param status the last status received from HcrPmc730Daemon.
    void _setPmcStatus(const HcrPmc730Status & status);
    /// @brief Slot to call when hcr_xmitd server responsiveness changes.
    /// @param responding True iff the server is currently responsive.
    void _xmitdResponsivenessChange(bool responding);
    /// @brief Save the last status received from hcr_xmitd.
    /// @param status the last status received from hcr_xmitd.
    void _setXmitStatus(XmitStatus status);
    /// @brief Slot to call when hcrdrx responsiveness changes.
    /// @param responding True iff the server is currently responsive.
    void _drxResponsivenessChange(bool responding);
    /// @brief Save the last status received from hcrdrx
    /// @param status the last status received from hcrdrx
    void _setDrxStatus(DrxStatus status);
    /// @brief Slot to call when HcrExecutive responsiveness changes.
    /// @param responding True iff the server is currently responsive.
    /// @param msg message describing the responsiveness change event
    void _hcrExecutiveResponsivenessChange(bool responding, QString msg);
    /// @brief Save the last status received from HcrExecutive
    /// @param status the last status received from HcrExecutive
    void _setHcrExecutiveStatus(HcrExecutiveStatus status);
    /// @brief Slot to call when DataMapper responsiveness changes.
    /// @param responding True iff the server is currently responsive.
    void _dataMapperResponsivenessChange(bool responding);
    /// @brief Save the last time-series write rate received from DataMapper
    /// @param tsWriteRate the last time-series write rate from DataMapper, MiB/s
    void _setDataMapperStatus(DMAP_info_t dmapperInfo);
    /// @brief Slot to call when fireflyd server responsiveness changes.
    /// @param responding True iff the server is currently responsive.
    void _fireflydResponsivenessChange(bool responding);
    /// @brief Save the last status received from fireflyd.
    /// @param status the last status received from fireflyd.
    void _setFireFlyStatus(FireFlyStatus status);
//    /// @brief Slot to call when SpectracomDaemon responsiveness changes.
//    /// @param responding True iff the server is currently responsive.
//    void _spectracomResponsivenessChange(bool responding);
//    /// @brief Save the last status received from SpectracomDaemon.
//    /// @param status the last status received from SpectracomDaemon.
//    void _setSpectracomStatus(SpectracomStatus status);
    /// @brief Slot to erase the angle display when angles are no longer valid
    void _timeoutAngleDisplay();
    /// @brief Slot called to pop up a dialog reporting forced shutoff of
    /// transmitter high voltage.
    void _reportHvForcedOff(QString details);
    /// @brief Slot called to place a request to MotionControlDaemon to change
    /// its 'INS in use'
    /// @param requestedIns the INS MotionControlDaemon is requested to use
    /// (1 or 2)
    void _setMotionControlInsInUse(int requestedIns);
private:
    // Log a message
    void _logMessage(std::string message);

    /**
     * @brief Return true iff the transmitter is actually transmitting.
     * @return true iff the transmitter is actually transmitting.
     */
    bool _xmitting() const;

    /**
     * @brief Return true iff we consider MotionControl to be OK, based on
     * responsiveness and returned status.
     * @param mcStatus status from the MotionControl daemon
     * @return true iff we consider MotionControl to be OK, based on
     * responsiveness and returned status.
     */
    bool _motionControlOk(const MotionControl::Status & mcStatus);

    /// @brief Show rotation angle
    void _showRotAngle(float rotAngle);

    /// @brief Show tilt angle
    void _showTiltAngle(float tiltAngle);

    /// @brief Clear the angle displays
    void _clearAngleDisplay();

    /// @brief Update the INS overview dialog based on current responsiveness
    /// and last status received from the two INSs.
    void _updateInsOverview();

    Ui::HcrGuiMainWindow _ui;
    QTimer _updateTimer;
    
    HcrGuiLogWindow _logWindow;
    
    // Details windows and dialogs
    CmigitsDetails _ins1Details;            // INS1 status
    CmigitsDetails _ins2Details;            // INS2 status
    FireflydDetails _fireflydDetails;
    HcrdrxDetails _hcrdrxDetails;
    HcrExecutiveDetails _hcrExecutiveDetails;
    InsOverview _insOverview;
    MotionControlDetails _motionControlDetails;
    Pmc730Details _pmc730Details;
//    SpectracomDetails _spectracomDetails;
    XmitDetails _xmitDetails;
    
    AntennaModeDialog _antennaModeDialog;
    
    // Threads to collect status from various daemons
    CmigitsStatusThread _ins1StatusThread;
    CmigitsStatusThread _ins2StatusThread;
    DataMapperStatusThread _dataMapperStatusThread;
    FireflydStatusThread _fireflydStatusThread;
//    SpectracomStatusThread _spectracomStatusThread;
    HcrdrxStatusThread _hcrdrxStatusThread;
    HcrExecutiveStatusThread _hcrExecutiveStatusThread;
    MotionControlStatusThread _mcStatusThread;
    QThread _pmcStatusThread;
    HcrPmc730StatusWorker _pmcStatusWorker;
    XmitdStatusThread _xmitdStatusThread;
    
    // LED pixmaps
    QPixmap _redLED;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;
    QPixmap _notRespondingLED;
    
    /// Last status read from the transmitter
    XmitStatus _xmitStatus;
    /// Is the transmitter under RDS control?
    bool _rdsXmitControl;
    /// Last status obtained from fireflyd
    FireFlyStatus _fireflydStatus;
//    /// Last status obtained from SpectracomDaemon
//    SpectracomStatus _spectracomStatus;
    /// Last status from the MotionControlDaemon
    MotionControl::Status _mcStatus;
    /// Last status read from HcrPmc730Daemon
    HcrPmc730Status _pmcStatus;
    /// Last status read from INS1 cmigitsDaemon
    CmigitsStatus _ins1Status;
    /// Last status read from INS2 cmigitsDaemon
    CmigitsStatus _ins2Status;
    /// Last status from hcrdrx
    DrxStatus _drxStatus;
    /// Last status from DataMapper
    DMAP_info_t _dmapStatus;
    /// Last status from HcrExecutive
    HcrExecutiveStatus _hcrExecutiveStatus;
    /// Data write rate calculated from DataMapper information
    double _dmapWriteRate;
    /// Time at which last write rate was computed
    time_t _dmapWriteRateTime;
    
    /// socket listening to angle broadcast
    QUdpSocket _angleSocket;

    /// time of last GUI update with new angles
    QDateTime _lastAngleUpdate;

    /// timer to erase angle display if time since new angles is too long
    QTimer _anglesValidTimer;

};
#endif /*HCRGUIMAINWINDOW_H_*/
