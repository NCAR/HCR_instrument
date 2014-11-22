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
#include <HcrPmc730StatusThread.h>
#include <HcrMonitorStatusThread.h>
#include <MotionControlStatusThread.h>

#include "DataMapperStatusThread.h"
#include "FireflydStatusThread.h"
#include "HcrdrxStatusThread.h"
#include "XmitdStatusThread.h"

#include "ui_HcrGuiMainWindow.h"

#include "HcrGuiLogWindow.h"

#include "CmigitsDetails.h"
#include "FireflydDetails.h"
#include "HcrdrxDetails.h"
#include "HcrMonitorDetails.h"
#include "MotionControlDetails.h"
#include "Pmc730Details.h"
#include "XmitDetails.h"
#include "AntennaModeDialog.h"

class HcrGuiMainWindow : public QMainWindow {
    Q_OBJECT

public:
    HcrGuiMainWindow(std::string archivererHost, int xmitterPort,
            int fireflydPort, std::string rdsHost, int drxPort, int pmcPort,
            int cmigitsPort, int motionControlPort, int hcrMonitorPort);
    virtual ~HcrGuiMainWindow();

private slots:
    void on_antennaModeButton_clicked();
    void on_attitudeCorrectionButton_clicked();
    void on_cmigitsDetailsButton_clicked();
    void on_driveHomeButton_clicked();
    void on_filamentButton_clicked();
    void on_hcrdrxDetailsButton_clicked();
    void on_requestedModeCombo_activated(int index);
    void on_requestHvButton_clicked();
    void on_mcDetailsButton_clicked();
    void on_pmc730DetailsButton_clicked();
    void on_showLogButton_clicked();
    void on_xmitterDetailsButton_clicked();
    void on_fireflydDetailsButton_clicked();
    void on_hcrMonitorDetailsButton_clicked();

    /// @brief Update GUI state based on _xmitStatus and _pmcStatus
    void _update();
    /// @brief read angle(s) available on the broadcast port
    void _readAngles();
    
    /// @brief Slot to call when cmigitsDaemon server responsiveness changes.
    /// @param responding True iff the server is currently responsive.
    /// @param msg message describing the responsiveness change event
    void _cmigitsResponsivenessChange(bool responding, QString msg);
    /// @brief Save the last status received from cmigitsDaemon.
    /// @param status the last status received from cmigitsDaemon.
    void _setCmigitsStatus(const CmigitsStatus & status);
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
    /// @brief Slot to call when HcrMonitor responsiveness changes.
    /// @param responding True iff the server is currently responsive.
    /// @param msg message describing the responsiveness change event
    void _hcrMonitorResponsivenessChange(bool responding, QString msg);
    /// @brief Save the last status received from HcrMonitor
    /// @param status the last status received from HcrMonitor
    void _setHcrMonitorStatus(HcrMonitorStatus status);
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
    /// @brief Slot to erase the angle display when angles are no longer valid
    void _timeoutAngleDisplay();
    /// @brief Slot called to pop up a dialog reporting forced shutoff of
    /// transmitter high voltage.
    void _reportHvForcedOff(QString details);
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
    
    Ui::HcrGuiMainWindow _ui;
    QTimer _updateTimer;
    
    HcrGuiLogWindow _logWindow;
    
    // Details windows and dialogs
    CmigitsDetails _cmigitsDetails;
    FireflydDetails _fireflydDetails;
    HcrdrxDetails _hcrdrxDetails;
    HcrMonitorDetails _hcrMonitorDetails;
    MotionControlDetails _motionControlDetails;
    Pmc730Details _pmc730Details;
    XmitDetails _xmitDetails;
    
    AntennaModeDialog _antennaModeDialog;
    
    // Threads to collect status from various daemons
    CmigitsStatusThread _cmigitsStatusThread;
    DataMapperStatusThread _dataMapperStatusThread;
    FireflydStatusThread _fireflydStatusThread;
    HcrdrxStatusThread _hcrdrxStatusThread;
    HcrMonitorStatusThread _hcrMonitorStatusThread;
    MotionControlStatusThread _mcStatusThread;
    HcrPmc730StatusThread _pmcStatusThread;
    XmitdStatusThread _xmitdStatusThread;
    
    // LED pixmaps
    QPixmap _redLED;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;
    
    /// Last status read from the transmitter
    XmitStatus _xmitStatus;
    /// Is the transmitter under RDS control?
    bool _rdsXmitControl;
    /// Last status obtained from fireflyd
    FireFlyStatus _fireflydStatus;
    /// Last status from the MotionControlDaemon
    MotionControl::Status _mcStatus;
    /// Last status read from HcrPmc730Daemon
    HcrPmc730Status _pmcStatus;
    /// Last status read from cmigitsDaemon
    CmigitsStatus _cmigitsStatus;
    /// Last status from hcrdrx
    DrxStatus _drxStatus;
    /// Last status from DataMapper
    DMAP_info_t _dmapStatus;
    /// Last status from HcrMonitor
    HcrMonitorStatus _hcrMonitorStatus;
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
