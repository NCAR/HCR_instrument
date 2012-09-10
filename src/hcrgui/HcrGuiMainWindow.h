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
#include <QTimer>

#include <XmitdRpcClient.h>
#include <HcrdrxRpcClient.h>

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
    void _update();
private:
    // Disable the UI
    void _disableUi();
    // Enable the UI
    void _enableUi();
    // Append latest messages from hcr_xmitd to our logging area
    void _appendXmitdLogMsgs();
    // Disable the UI when no connection exists to the hcr_xmitd.
    void _noDaemon();
    // Disable the UI if the daemon is not talking to the transmitter
    void _noXmitter();
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
    XmitdRpcClient _xmitClient;
    HcrdrxRpcClient _drxClient;
    QTimer _updateTimer;
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
    bool _noXmitd;
};
#endif /*HCRGUIMAINWINDOW_H_*/
