/*
 *  Created on: Jul 23, 2013
 *      Author: burghart
 */
#ifndef MOTIONCONTROLDETAILS_H_
#define MOTIONCONTROLDETAILS_H_

#include <QDialog>
#include <QPixmap>
#include <MotionControl.h>

#include "ui_MotionControlDetails.h"


class MotionControlDetails : public QDialog {
    Q_OBJECT
public:
    MotionControlDetails(QWidget *parent);
    virtual ~MotionControlDetails() {}

    /// @brief Return true iff there are any MotionControl problems, i.e.,
    /// if any red lights have been lit in the details display.
    /// @return true iff there are any MotionControl problems, i.e.,
    /// if any red lights have been lit in the details display.
    bool errorDetected() const { return(_errorDetected); }

    /// @brief Return true iff there are any MotionControl warnings, i.e.,
    /// if any amber lights have beein lit in the details display.
    /// @return true iff there are any MotionControl problems, i.e.,
    /// if any amber lights have been lit in the details display.
    bool warningDetected() const { return(_warningDetected); }

public slots:
    void updateStatus(bool daemonResponding, const MotionControl::Status & mcStatus);
private:
    void _doRotStatus(const MotionControl::Status & mcStatus);

    void _doTiltStatus(const MotionControl::Status & mcStatus);

    Ui::MotionControlDetails _ui;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;
    QPixmap _redLED;

    // true if we have turned on any amber lights
    bool _warningDetected;

    // true if we have turned on any red lights
    bool _errorDetected;
};
#endif /*MOTIONCONTROLDETAILS_H_*/
