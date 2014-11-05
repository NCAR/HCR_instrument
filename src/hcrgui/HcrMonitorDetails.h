/*
 *  Created on: Nov 5, 2014
 *      Author: burghart
 */
#ifndef HCRMONITORDETAILS_H_
#define HCRMONITORDETAILS_H_

#include <QDialog>
#include <QPixmap>
#include <HcrMonitorStatus.h>
#include <HcrPmc730Status.h>

#include "ui_HcrMonitorDetails.h"


class HcrMonitorDetails : public QDialog {
    Q_OBJECT
public:
    HcrMonitorDetails(QWidget *parent);
    virtual ~HcrMonitorDetails() {}

    void noStatus();
public slots:
    void updateStatus(bool daemonResponding, 
            const HcrMonitorStatus & hcrMonitorStatus,
            const HcrPmc730Status & hcrPmc730Status);
private:
    Ui::HcrMonitorDetails _ui;
    QPixmap _redLED;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;
};
#endif /* HCRMONITORDETAILS_H_*/
