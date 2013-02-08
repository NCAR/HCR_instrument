/*
 *  Created on: Jan 14, 2011
 *      Author: burghart
 */
#ifndef HCRGUICMIGITSSTATUSDIALOG_H_
#define HCRGUICMIGITSSTATUSDIALOG_H_

#include <QDialog>
#include <QPixmap>
#include <DrxStatus.h>

#include "ui_HcrGuiCmigitsStatusDialog.h"
#include <CmigitsSharedMemory.h>


class HcrGuiCmigitsStatusDialog : public QDialog {
    Q_OBJECT
public:
    HcrGuiCmigitsStatusDialog(QWidget *parent);
    virtual ~HcrGuiCmigitsStatusDialog() {}

    void noStatus();
public slots:
    void updateStatus(const DrxStatus & drxStatus);
private:
    Ui::HcrGuiCmigitsStatusDialog _ui;
    CmigitsSharedMemory _cmigitsShm;
    QPixmap _redLED;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;
};
#endif /*HCRGUICMIGITSSTATUSDIALOG_H_*/
