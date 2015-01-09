/*
 *  Created on: Jan 14, 2011
 *      Author: burghart
 */
#ifndef CMIGITSDETAILS_H_
#define CMIGITSDETAILS_H_

#include <QDialog>
#include <QPixmap>
#include <CmigitsStatus.h>

#include "ui_CmigitsDetails.h"

class CmigitsDetails : public QDialog {
    Q_OBJECT
public:
    CmigitsDetails(QWidget *parent);
    virtual ~CmigitsDetails() {}

    void noStatus();
public slots:
    void updateStatus(bool daemonResponding, const CmigitsStatus & status);
private:
    Ui::CmigitsDetails _ui;
    QPixmap _redLED;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;
};
#endif /* CMIGITSDETAILS_H_*/
