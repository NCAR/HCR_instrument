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

#include "CmigitsStatusThread.h"
#include "HcrdrxStatusThread.h"
#include "MotionControlClientThread.h"
#include "Pmc730StatusThread.h"
#include "XmitdStatusThread.h"

#include "ui_HcrGuiMainWindow.h"

#include "CmigitsDetails.h"
#include "AntennaModeDialog.h"
#include "MotionControlDetails.h"
#include "XmitDetails.h"

class HcrGuiMainWindow : public QMainWindow {
    Q_OBJECT

public:
    HcrGuiMainWindow(std::string xmitterHost, int xmitterPort,
            std::string rdsHost, int drxPort, int pmcPort, int cmigitsPort,
            int motionControlPort);
    virtual ~HcrGuiMainWindow();

private slots:
    void on_cmigitsDetailsButton_clicked();
    void on_cmigitsInitButton_clicked();
    void on_filamentButton_clicked();
    void on_hvButton_clicked();
    void on_xmitterDetailsButton_clicked();
    void on_hmcModeCombo_activated(int index);
    void on_antennaModeButton_clicked();
    void on_driveHomeButton_clicked();
    void on_mcDetailsButton_clicked();
    void on_attitudeCorrectionButton_clicked();

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
    void _mcResponsivenessChange(bool responding);
    /// @brief Save the last status received from MotionControlDaemon.
    /// @param status the last status received from MotionControlDaemon.
    void _setMotionControlStatus(const MotionControl::Status & status);
    /// @brief Slot to call when HcrPmc730Daemon server responsiveness changes.
    /// @param responding True iff the server is currently responsive.
    void _pmcResponsivenessChange(bool responding);
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
    /// @brief Slot to erase the angle display when angles are no longer valid
    void _timeoutAngleDisplay();

private:
    // Append latest messages from hcr_xmitd to our logging area
    void _appendXmitdLogMsgs();
    // Log a message
    void _logMessage(std::string message);

    /**
     *  @brief Return true iff our latest status indicates that the transmitter
     *  filament is on.
     *  @return true iff our latest status indicates that the transmitter
     *  filament is on.
     */
    bool _xmitterFilamentOn() const;
    /**
     *  @brief Return true iff our latest status indicates that the transmitter
     *  high voltage is on.
     *  @return true iff our latest status indicates that the transmitter
     *  high voltage is on.
     */
    bool _xmitterHvOn() const;
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
    CmigitsDetails _cmigitsDetails;
    XmitDetails _xmitDetails;
    AntennaModeDialog _antennaModeDialog;
    MotionControlDetails _motionControlDetails;
    
    // Threads to collect status from various daemons
    CmigitsStatusThread _cmigitsStatusThread;
    HcrdrxStatusThread _hcrdrxStatusThread;
    MotionControlClientThread _mcClientThread;
    Pmc730StatusThread _pmcStatusThread;
    XmitdStatusThread _xmitdStatusThread;
    
    QPixmap _redLED;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;
    // Last status read from the transmitter
    XmitStatus _xmitStatus;
    // Last status from the MotionControlDaemon
    MotionControl::Status _mcStatus;
    // Last status read from HcrPmc730Daemon
    HcrPmc730Status _pmcStatus;
    // Last status read from cmigitsDaemon
    CmigitsStatus _cmigitsStatus;
    // Last status from hcrdrx
    DrxStatus _drxStatus;
    
    // next log index to get from hcr_xmitd
    unsigned int _nextLogIndex;

    // socket listening to angle broadcast
    QUdpSocket _angleSocket;

    // time of last GUI update with new angles
    QDateTime _lastAngleUpdate;

    // timer to erase angle display if time since new angles is too long
    QTimer _anglesValidTimer;

    // Have we disabled transmitter HV due to low pod pressure?
    bool _hvDisabledForPressure;
    // Time of the first good pressure in a period of continuous good pressures
    // If zero, then the last pressure seen was bad.
    time_t _goodPresStartTime;
};
#endif /*HCRGUIMAINWINDOW_H_*/
