/*
 *  Created on: Jan 14, 2011
 *      Author: burghart
 */
#ifndef CMIGITSDETAILS_H_
#define CMIGITSDETAILS_H_

#include <QDialog>
#include <QPixmap>
#include <DrxStatus.h>

#include "ui_CmigitsDetails.h"
#include <CmigitsSharedMemory.h>


class CmigitsDetails : public QDialog {
    Q_OBJECT
public:
    CmigitsDetails(QWidget *parent);
    virtual ~CmigitsDetails() {}

    void noStatus();
public slots:
    void updateStatus(const DrxStatus & drxStatus);
private:
    Ui::CmigitsDetails _ui;
    CmigitsSharedMemory _cmigitsShm;
    QPixmap _redLED;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;
};
#endif /* CMIGITSDETAILS_H_*/