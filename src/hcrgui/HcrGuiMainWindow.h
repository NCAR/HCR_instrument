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

#include "XmitdStatusThread.h"
#include "HcrdrxStatusThread.h"

#include "ui_HcrGuiMainWindow.h"
#include "HcrGuiXmitStatusDialog.h"

class HcrGuiMainWindow : public QMainWindow {
    Q_OBJECT
public:
    HcrGuiMainWindow(std::string xmitterHost, int xmitterPort,
            std::string hcrdrxHost, int hcrdrxPort);
    virtual ~HcrGuiMainWindow();
private slots:
    void on_filamentButton_clicked();
    void on_hvButton_clicked();
    void on_xmitterDetailsButton_clicked();
    void on_hmcMode0Button_clicked();
    void on_hmcMode1Button_clicked();
    void on_hmcMode2Button_clicked();
    void on_hmcMode3Button_clicked();
    /// @brief Update GUI state based on _xmitStatus and _drxStatus
    void _update();
    /// @brief Save the last status received from hcrdrx.
    /// @param status the last status received from hcrdrx.
    void _setDrxStatus(DrxStatus status);
    /// @brief Slot to call when hcrdrx server responsiveness changes.
    /// @param responding True iff the server is currently responsive.
    void _drxResponsivenessChange(bool responding);
    /// @brief Save the last status received from hcrdrx.
    /// @param status the last status received from hcrdrx.
    void _setXmitStatus(XmitStatus status);
    /// @brief Slot to call when hcr_xmitd server responsiveness changes.
    /// @param responding True iff the server is currently responsive.
    void _xmitdResponsivenessChange(bool responding);
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

    Ui::HcrGuiMainWindow _ui;
    HcrGuiXmitStatusDialog _xmitStatusDialog;
    XmitdStatusThread _xmitdStatusThread;
    HcrdrxStatusThread _drxStatusThread;
    QPixmap _redLED;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;
    // Last status read from the transmitter
    XmitStatus _xmitStatus;
    // Last status read from hcrdrx
    DrxStatus _drxStatus;
    
    // next log index to get from hcr_xmitd
    unsigned int _nextLogIndex;
};
#endif /*HCRGUIMAINWINDOW_H_*/
