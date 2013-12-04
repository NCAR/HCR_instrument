/*
 *  Created on: Dec 4, 2013
 *      Author: burghart
 */
#ifndef HCRDRXDETAILS_H_
#define HCRDRXDETAILS_H_

#include <QDialog>
#include <QPixmap>
#include <DrxStatus.h>

#include "ui_HcrdrxDetails.h"


class HcrdrxDetails : public QDialog {
    Q_OBJECT
public:
    HcrdrxDetails(QWidget *parent);
    virtual ~HcrdrxDetails() {}

    void noStatus();
public slots:
    void updateStatus(const DrxStatus & status);
private:
    Ui::HcrdrxDetails _ui;
};
#endif /* HCRDRXDETAILS_H_*/
