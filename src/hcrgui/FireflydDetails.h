/*
 *  Created on: Apr 1, 2014
 *      Author: burghart
 */
#ifndef FIREFLYDDETAILS_H_
#define FIREFLYDDETAILS_H_

#include <QDialog>
#include <QPixmap>
#include <FireFlyStatus.h>

#include "ui_FireflydDetails.h"


class FireflydDetails : public QDialog {
    Q_OBJECT
public:
    FireflydDetails(QWidget *parent);
    virtual ~FireflydDetails() {}

    void noStatus();
public slots:
    void updateStatus(const FireFlyStatus & status);
private:
    Ui::FireflydDetails _ui;
};
#endif /* FIREFLYDDETAILS_H_*/
