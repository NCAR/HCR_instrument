/*
 * InsOverview.cpp
 *
 *  Created on: Oct 19, 2017
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#include "InsOverview.h"
#include <HcrSharedResources.h>
#include <cmath>
#include <iomanip>
#include <sstream>

#include <QMessageBox>
#include <QTextStream>

InsOverview::InsOverview(QWidget * parent) :
QDialog(parent),
_ui(),
_currentInsInUse(0),
_redLED(":/redLED.png"),
_amberLED(":/amberLED.png"),
_greenLED(":/greenLED.png"),
_greenLED_off(":/greenLED_off.png")
{
    // Set up the UI
    _ui.setupUi(this);
}

// Radians to degrees
static
double
RadToDeg(double rad) {
    return(180 * (rad / M_PI));
}

// Return the ground track calculated from velNorth and velEast, in degrees
// clockwise from true north.
// The track is normalized to the interval [0.0, 360.0).
static inline
double
GroundTrack(double velNorth, double velEast) {
    // Return track of zero if both arguments are zero.
    if (velNorth == 0.0 && velEast == 0.0) {
        return(0.0);
    }
    // Calculate the track in degrees clockwise from true north
    double groundTrack = RadToDeg(atan2(velNorth, velEast));
    if (groundTrack < 0.0) {
        groundTrack += 360.0;
    }
    return(groundTrack);
}

// Return the horizontal ground speed calculated from velNorth and velEast.
static inline
double
GroundSpeed(double velNorth, double velEast) {
    return(hypot(velNorth, velEast));
}

void
InsOverview::updateStatus(bool ins1DaemonResponding,
                          const CmigitsStatus & ins1Status,
                          bool ins2DaemonResponding,
                          const CmigitsStatus & ins2Status,
                          int insInUse) {
    _currentInsInUse = insInUse;

    // QString and an associated QStringStream for building text strings
    QString text;
    QTextStream textStream(&text); 
    textStream.setRealNumberNotation(QTextStream::FixedNotation);

    // Degree symbol (0xb0 in Latin1 encoding)
    QChar degSym(0xb0);

    // fancy ms^-1 units text label
    QString mPerSec(" ms<sup>-1</sup>");

    // Get the default background color from the top-level widget (parent of
    // gridLayout), which should have its original palette.
    QColor defaultBgColor =
            _ui.gridLayout->parentWidget()->palette().color(QWidget::backgroundRole());

    // Write to the label which notes if either or both daemons are not
    // responding.
    text = "";
    if (! ins1DaemonResponding && ! ins2DaemonResponding) {
        textStream << "<font color='DarkRed'>" <<
                "INS1 and INS2 daemons not responding</font>";
    } else if (! ins1DaemonResponding) {
        textStream << "<font color='DarkRed'>INS1 daemon not responding</font>";
    } else if (! ins2DaemonResponding) {
        textStream << "<font color='DarkRed'>INS2 daemon not responding</font>";
    }
    _ui.daemonRespondingLabel->setText(text);

    //
    // INS1 values
    //

    // Gray out values for INS1 if its daemon is not responding
    _ui.ins1Frame->setEnabled(ins1DaemonResponding);

    // Checked/unchecked state for the "use INS" button
    _ui.useIns1Button->setChecked(insInUse == 1);
    _ui.useIns1Button->setText((insInUse == 1) ? "*" : "");

    // Put a box around the INS1 frame if this is INS is in use
    QFrame::Shape frameShape =
        (insInUse == 1) ? QFrame::Shape::Panel : QFrame::Shape::NoFrame;
    _ui.ins1Frame->setFrameShape(frameShape);

    // Make background color for the frame 5% lighter if this is the INS in use.
    QColor bgColor = (insInUse == 1) ? defaultBgColor.lighter(105) : defaultBgColor;
    _ui.ins1Frame->setStyleSheet(QString("background-color:") + bgColor.name());

    // INS1 status light:
    // Green light if mode is "Air Navigation" or "Land Navigation"
    // Amber light if we have both INS and GPS
    // Red light otherwise
    uint16_t insMode = ins1Status.currentMode();
    QPixmap & light = _greenLED_off;
    if (insMode == 7 || insMode == 8) {
        light = _greenLED;
    } else if (ins1Status.insAvailable() &&
               ins1Status.gpsAvailable()) {
        light = _amberLED;
    } else {
        light = _redLED;
    }
    _ui.ins1StatusLed->setPixmap(light);

    // pitch (to 0.1 degree precision)
    text = "";
    textStream << qSetRealNumberPrecision(1) << ins1Status.pitch() << degSym;
    _ui.ins1PitchValue->setText(text);

    // roll (to 0.1 degree precision)
    text = "";
    textStream << qSetRealNumberPrecision(1) << ins1Status.roll() << degSym;
    _ui.ins1RollValue->setText(text);

    // heading (to 1 degree precision)
    text = "";
    textStream << qSetRealNumberPrecision(0) << ins1Status.heading() << degSym;
    _ui.ins1HeadingValue->setText(text);

    // ground track (to 1 degree precision), normalized to interval [0.0, 360.0)
    text = "";
    double ins1GroundTrack =
            GroundTrack(ins1Status.velNorth(), ins1Status.velEast());
    textStream << qSetRealNumberPrecision(0) << ins1GroundTrack << degSym;
    _ui.ins1GndTrackValue->setText(text);

    // ground speed (to 1 m/s precision)
    text = "";
    double ins1GroundSpeed =
            GroundSpeed(ins1Status.velNorth(), ins1Status.velEast());
    textStream << qSetRealNumberPrecision(0) << ins1GroundSpeed << mPerSec;
    _ui.ins1GndSpeedValue->setText(text);

    // vertical speed (to 1 m/s precision)
    text = "";
    textStream << qSetRealNumberPrecision(0) << ins1Status.velUp() << mPerSec;
    _ui.ins1VertSpeedValue->setText(text);

    // latitude (to 0.001 degree precision)
    text = "";
    textStream << qSetRealNumberPrecision(3) << ins1Status.latitude() << degSym;
    _ui.ins1LatitudeValue->setText(text);

    // longitude (to 0.001 degree precision)
    text = "";
    textStream << qSetRealNumberPrecision(3) << ins1Status.longitude() << degSym;
    _ui.ins1LongitudeValue->setText(text);

    // altitude (to 1 m precision)
    text = "";
    textStream << qSetRealNumberPrecision(0) << ins1Status.altitude() << " m";
    _ui.ins1AltitudeValue->setText(text);

    //
    // INS2 values
    //

    // Gray out values for INS2 if its daemon is not responding
    _ui.ins2Frame->setEnabled(ins2DaemonResponding);

    // Checked/unchecked state for the "use INS" button
    _ui.useIns2Button->setChecked(insInUse == 2);
    _ui.useIns2Button->setText((insInUse == 2) ? "*" : "");

    // Put a box around the INS2 frame if this is INS is in use
    frameShape = (insInUse == 2) ? QFrame::Shape::Panel : QFrame::Shape::NoFrame;
    _ui.ins2Frame->setFrameShape(frameShape);

    // Make background color for the frame 5% lighter if this is the INS in use.
    bgColor = (insInUse == 2) ? defaultBgColor.lighter(105) : defaultBgColor;
    _ui.ins2Frame->setStyleSheet(QString("background-color:") + bgColor.name());

    // INS2 status light:
    // Green light if mode is "Air Navigation" or "Land Navigation"
    // Amber light if we have both INS and GPS
    // Red light otherwise
    insMode = ins2Status.currentMode();
    if (insMode == 7 || insMode == 8) {
        light = _greenLED;
    } else if (ins2Status.insAvailable() &&
               ins2Status.gpsAvailable()) {
        light = _amberLED;
    } else {
        light = _redLED;
    }
    _ui.ins2StatusLed->setPixmap(light);

    // pitch (to 0.1 degree precision)
    text = "";
    textStream << qSetRealNumberPrecision(1) << ins2Status.pitch() << degSym;
    _ui.ins2PitchValue->setText(text);

    // roll (to 0.1 degree precision)
    text = "";
    textStream << qSetRealNumberPrecision(1) << ins2Status.roll() << degSym;
    _ui.ins2RollValue->setText(text);

    // heading (to 1 degree precision)
    text = "";
    textStream << qSetRealNumberPrecision(0) << ins2Status.heading() << degSym;
    _ui.ins2HeadingValue->setText(text);

    // ground track (to 1 degree precision), normalized to interval [0.0, 360.0)
    text = "";
    double ins2GroundTrack =
            GroundTrack(ins2Status.velNorth(), ins2Status.velEast());
    textStream << qSetRealNumberPrecision(0) << ins2GroundTrack << degSym;
    _ui.ins2GndTrackValue->setText(text);

    // ground speed (to 1 m/s precision)
    text = "";
    double ins2GroundSpeed =
            GroundSpeed(ins2Status.velNorth(), ins2Status.velEast());
    textStream << qSetRealNumberPrecision(0) << ins2GroundSpeed << mPerSec;
    _ui.ins2GndSpeedValue->setText(text);

    // vertical speed (to 1 m/s precision)
    text = "";
    textStream << qSetRealNumberPrecision(0) << ins2Status.velUp() << mPerSec;
    _ui.ins2VertSpeedValue->setText(text);

    // latitude (to 0.001 degree precision)
    text = "";
    textStream << qSetRealNumberPrecision(3) << ins2Status.latitude() << degSym;
    _ui.ins2LatitudeValue->setText(text);

    // longitude (to 0.001 degree precision)
    text = "";
    textStream << qSetRealNumberPrecision(3) << ins2Status.longitude() << degSym;
    _ui.ins2LongitudeValue->setText(text);

    // altitude (to 1 m precision)
    text = "";
    textStream << qSetRealNumberPrecision(0) << ins2Status.altitude() << " m";
    _ui.ins2AltitudeValue->setText(text);

    //
    // Diffs
    //

    // Gray out diffs if either INS is not responding.
    bool doDiffs = ins1DaemonResponding && ins2DaemonResponding;
    _ui.diffFrame->setEnabled(doDiffs);

    // Get the diffFrame default background color. We may tint it to indicate
    // warnings or errors.
    if (doDiffs) {
        double diff;

        // pitch diff (to 0.1 degree precision)
        diff = fabs(ins1Status.pitch() - ins2Status.pitch());
        _setDiffValueLabel(_ui.diffPitchValue, diff, degSym, 1,
                           PITCH_DIFF_BAD, PITCH_DIFF_WARN);

        // roll diff (to 0.1 degree precision)
        diff = fabs(ins1Status.roll() - ins2Status.roll());
        _setDiffValueLabel(_ui.diffRollValue, diff, degSym, 1,
                           ROLL_DIFF_BAD, ROLL_DIFF_WARN);

        // heading diff (to 1 degree precision)
        diff = fabs(ins1Status.heading() - ins2Status.heading());
        _setDiffValueLabel(_ui.diffHeadingValue, diff, degSym, 0,
                           HEADING_DIFF_BAD, HEADING_DIFF_WARN);

        // ground track diff (to 1 degree precision)
        //
        // Since ground track is almost meaningless until we're moving, we
        // don't calculate a real difference until the ground speed exceeds
        // GNDTRACK_TEST_MIN_SPEED.
        if (ins1GroundSpeed < GNDTRACK_TEST_MIN_SPEED ||
            ins2GroundSpeed < GNDTRACK_TEST_MIN_SPEED) {
            _ui.diffGndTrackValue->setText("--");
        } else {
            diff = fabs(ins1GroundTrack - ins2GroundTrack);
            _setDiffValueLabel(_ui.diffGndTrackValue, diff, degSym, 0,
                               GNDTRACK_DIFF_BAD, GNDTRACK_DIFF_WARN);
        }

        // ground speed diff (to 1 m/s precision)
        diff = fabs(ins1GroundSpeed - ins2GroundSpeed);
        _setDiffValueLabel(_ui.diffGndSpeedValue, diff, mPerSec, 0,
                           GNDSPEED_DIFF_BAD, GNDSPEED_DIFF_WARN);

        // vertical speed diff (to 1 m/s precision)
        diff = fabs(ins1Status.velUp() - ins2Status.velUp());
        _setDiffValueLabel(_ui.diffVertSpeedValue, diff, mPerSec, 0,
                           VERTSPEED_DIFF_BAD, VERTSPEED_DIFF_WARN);

        // latitude diff (to 0.001 degree precision)
        diff = fabs(ins1Status.latitude() - ins2Status.latitude());
        _setDiffValueLabel(_ui.diffLatitudeValue, diff, degSym, 3,
                           LATITUDE_DIFF_BAD, LATITUDE_DIFF_WARN);

        // longitude diff (to 0.001 degree precision)
        diff = fabs(ins1Status.longitude() - ins2Status.longitude());
        _setDiffValueLabel(_ui.diffLongitudeValue, diff, degSym, 3,
                           LONGITUDE_DIFF_BAD, LONGITUDE_DIFF_WARN);

        // altitude (to 1 m precision)
        diff = fabs(ins1Status.altitude() - ins2Status.altitude());
        _setDiffValueLabel(_ui.diffAltitudeValue, diff, " m", 0,
                           ALTITUDE_DIFF_BAD, ALTITUDE_DIFF_WARN);
    } else {
        QString noDiffStr("--");
        _ui.diffPitchValue->setText(noDiffStr);
        _ui.diffRollValue->setText(noDiffStr);
        _ui.diffHeadingValue->setText(noDiffStr);
        _ui.diffGndTrackValue->setText(noDiffStr);
        _ui.diffGndSpeedValue->setText(noDiffStr);
        _ui.diffVertSpeedValue->setText(noDiffStr);
        _ui.diffLatitudeValue->setText(noDiffStr);
        _ui.diffLongitudeValue->setText(noDiffStr);
        _ui.diffAltitudeValue->setText(noDiffStr);
    }
}

void
InsOverview::_setDiffValueLabel(QLabel * label, const double diff,
                                const QString & units, const int precision,
                                const double badThreshold,
                                const double warnThreshold) {
    // Background color. Start from the default background color and tint a
    // bit yellow to signal warning or red to signal error.
    QColor defBgColor = _ui.diffFrame->palette().color(QWidget::backgroundRole());
    QString bgColorName = _DiffBgColorName(defBgColor, diff, badThreshold, warnThreshold);
    label->setStyleSheet(QString("background-color:") +
            _DiffBgColorName(defBgColor, diff, badThreshold, warnThreshold));

    QString text;
    QTextStream textStream(&text);
    textStream.setRealNumberNotation(QTextStream::FixedNotation);
    textStream << qSetRealNumberPrecision(precision) << diff << units;
    label->setText(text);
}

const QString
InsOverview::_DiffBgColorName(const QColor & defBgColor, double diff,
                         double badThreshold, double warnThreshold) {
    static const QColor warnColor("Yellow");
    static const QColor badColor("Red");
    QColor tint;
    if (diff >= badThreshold) {
        tint = badColor;
    } else if (diff >= warnThreshold) {
        tint = warnColor;
    } else {
        // Don't change the default background color
        return(defBgColor.name());
    }
    // Return a blend of 80% default background color and 20% our selected tint.
    return(QColor(0.8 * defBgColor.red() + 0.2 * tint.red(),
                  0.8 * defBgColor.green() + 0.2 * tint.green(),
                  0.8 * defBgColor.blue() + 0.2 * tint.blue()).name());
}

void
InsOverview::_requestInsInUse(int requestedIns) {
    // Pop up a dialog to confirm the request
    QMessageBox::StandardButton reply;
    QString questionText;
    QTextStream os(&questionText);
    os << "Change motion control 'INS in use' to INS" << requestedIns << "?";
    reply = QMessageBox::question(this,
                                  "Confirm 'INS in use' Request",
                                  questionText,
                                  QMessageBox::Yes|QMessageBox::No);
    if (reply == QMessageBox::Yes) {
        emit requestNewInsInUse(requestedIns);
    }
}

void
InsOverview::on_useIns1Button_clicked() {
    if (_currentInsInUse != 1) {
        _requestInsInUse(1);
    }
}

void
InsOverview::on_useIns2Button_clicked() {
    if (_currentInsInUse != 2) {
        _requestInsInUse(2);
    }
}
