/*
 *  Created on: Nov 5, 2014
 *      Author: burghart
 */
#ifndef HCRMONITORDETAILS_H_
#define HCRMONITORDETAILS_H_

#include <QDialog>
#include <QPixmap>
#include <HcrMonitorStatus.h>
#include <HcrMonitorRpcClient.h>
#include <HcrPmc730Status.h>

#include "ui_HcrMonitorDetails.h"


class HcrMonitorDetails : public QDialog {
    Q_OBJECT
public:
    HcrMonitorDetails(QWidget *parent, std::string hcrMonitorHost, 
            int hcrMonitorPort);
    virtual ~HcrMonitorDetails() {}

    void noStatus();
public slots:
    void updateStatus(bool daemonResponding, 
            const HcrMonitorStatus & hcrMonitorStatus,
            const HcrPmc730Status & hcrPmc730Status);
    
    void on_apsValveControlCombo_activated(int index);
private:
    Ui::HcrMonitorDetails _ui;
    
    /// @brief client to be used for sending XML-RPC commands to HcrMonitor
    HcrMonitorRpcClient _rpcClient;
    
    QPixmap _redLED;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;
};
#endif /* HCRMONITORDETAILS_H_*/
