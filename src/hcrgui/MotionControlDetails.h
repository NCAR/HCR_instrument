/*
 *  Created on: Jul 23, 2013
 *      Author: burghart
 */
#ifndef MOTIONCONTROLDETAILS_H_
#define MOTIONCONTROLDETAILS_H_

#include <QDialog>
#include <QPixmap>
#include <DrxStatus.h>
#include <MotionControl.h>

#include "ui_MotionControlDetails.h"
#include <CmigitsSharedMemory.h>


class MotionControlDetails : public QDialog {
    Q_OBJECT
public:
    MotionControlDetails(QWidget *parent);
    virtual ~MotionControlDetails() {}

    // @brief Return true iff there are any MotionControl problems, i.e.,
    // if any red lights have been lit in the details display.
    // @return true iff there are any MotionControl problems, i.e.,
    // if any red lights have been lit in the details display.
    bool problemDetected() const { return(_problemDetected); }

public slots:
    void updateStatus(const MotionControl::Status & mcStatus);
private:
    void _doRotStatus(const MotionControl::Status & mcStatus);

    void _doTiltStatus(const MotionControl::Status & mcStatus);

    Ui::MotionControlDetails _ui;
    QPixmap _redLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;

    // true if we have turned on any red lights
    bool _problemDetected;
};
#endif /*MOTIONCONTROLDETAILS_H_*/
