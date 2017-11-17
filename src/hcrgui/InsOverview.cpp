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

#include <QTextStream>

InsOverview::InsOverview(QWidget * parent) :
QDialog(parent),
_ui() {
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
                          bool ins1InUse,
                          const CmigitsStatus & ins1Status,
                          bool ins2DaemonResponding,
                          bool ins2InUse,
                          const CmigitsStatus & ins2Status) {
    // QString and an associated QStringStream for building text strings
    QString text;
    QTextStream textStream(&text); 
    textStream.setRealNumberNotation(QTextStream::FixedNotation);

    // Degree symbol (0xb0 in Latin1 encoding)
    QChar degSym(0xb0);

    // ms^-1 units text label
    QString mPerSec(" ms<sup>-1</sup>");

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

    // Put a box with a slightly lighter background around INS1 values if the
    // INS is in use, otherwise no frame
    QFrame::Shape frameShape =
        ins1InUse ? QFrame::Shape::Panel : QFrame::Shape::NoFrame;
    _ui.ins1Frame->setFrameShape(frameShape);
    _ui.ins1Frame->setStyleSheet(ins1InUse ? "background-color: #E0E0E0" : "");

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

    // Put a box around INS1 values if the INS is in use, otherwise no frame
    frameShape =
        ins2InUse ? QFrame::Shape::StyledPanel : QFrame::Shape::NoFrame;
    _ui.ins2Frame->setFrameShape(frameShape);
    _ui.ins2Frame->setStyleSheet(ins2InUse ? "background-color: #EEEEEE" : "");

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

    if (doDiffs) {
        double diff;

        // pitch diff (to 0.1 degree precision)
        diff = fabs(ins1Status.pitch() - ins2Status.pitch());
        text = "";
        textStream << "<font color='" <<
                DiffTextColor(diff, PITCH_DIFF_BAD, PITCH_DIFF_WARN) <<
                "'>" << qSetRealNumberPrecision(1) << diff <<
                "</font>" << degSym;
        _ui.diffPitchValue->setText(text);

        // roll diff (to 0.1 degree precision)
        diff = fabs(ins1Status.roll() - ins2Status.roll());
        text = "";
        textStream << "<font color='" <<
                DiffTextColor(diff, ROLL_DIFF_BAD, ROLL_DIFF_WARN) <<
                "'>" << qSetRealNumberPrecision(1) << diff <<
                "</font>" << degSym;
        _ui.diffRollValue->setText(text);

        // heading diff (to 1 degree precision)
        diff = fabs(ins1Status.heading() - ins2Status.heading());
        text = "";
        textStream << "<font color='" <<
                DiffTextColor(diff, HEADING_DIFF_BAD, HEADING_DIFF_WARN) <<
                "'>" << qSetRealNumberPrecision(0) << diff <<
                "</font>" << degSym;
        _ui.diffHeadingValue->setText(text);

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
            text = "";
            textStream << "<font color='" <<
                    DiffTextColor(diff, GNDTRACK_DIFF_BAD, GNDTRACK_DIFF_WARN) <<
                    "'>" <<  qSetRealNumberPrecision(0) << diff <<
                    "</font>" << degSym;
            _ui.diffGndTrackValue->setText(text);
        }

        // ground speed diff (to 1 m/s precision)
        text = "";
        textStream << qSetRealNumberPrecision(0) <<
                fabs(ins1GroundSpeed - ins2GroundSpeed) << mPerSec;
        _ui.diffGndSpeedValue->setText(text);

        // vertical speed diff (to 1 m/s precision)
        text = "";
        textStream << qSetRealNumberPrecision(0) <<
                fabs(ins1Status.velUp() - ins2Status.velUp()) << mPerSec;
        _ui.diffVertSpeedValue->setText(text);

        // latitude diff (to 0.001 degree precision)
        text = "";
        textStream << qSetRealNumberPrecision(3) <<
                fabs(ins1Status.latitude() - ins2Status.latitude()) << degSym;
        _ui.diffLatitudeValue->setText(text);

        // longitude diff (to 0.001 degree precision)
        text = "";
        textStream << qSetRealNumberPrecision(3) <<
                fabs(ins1Status.longitude() - ins2Status.longitude()) << degSym;
        _ui.diffLongitudeValue->setText(text);

        // altitude (to 1 m precision)
        text = "";
        textStream << qSetRealNumberPrecision(0) <<
                fabs(ins1Status.altitude() - ins2Status.altitude()) << " m";
        _ui.diffAltitudeValue->setText(text);
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

const QString &
InsOverview::DiffTextColor(double diff, double badThreshold, double warnThreshold) {
    static const QString GoodDiffColor("DarkGreen");
    static const QString WarnDiffColor("DarkYellow");
    static const QString BadDiffColor("DarkRed");
    if (diff >= badThreshold) {
        return(BadDiffColor);
    } else if (diff >= warnThreshold) {
        return(WarnDiffColor);
    }
    return(GoodDiffColor);
}
