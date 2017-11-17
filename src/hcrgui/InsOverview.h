/*
 * InsOverview.h
 *
 *  Created on: Oct 19, 2017
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#ifndef SRC_HCRGUI_INSOVERVIEW_H_
#define SRC_HCRGUI_INSOVERVIEW_H_

#include <QtGui/qdialog.h>
#include <CmigitsStatus.h>

#include "ui_InsOverview.h"

class InsOverview: public QDialog {
    Q_OBJECT
public:
    InsOverview(QWidget * parent);
    virtual ~InsOverview() {}

    void noStatus();
public slots:
    /// @brief Update the widget with current status values for the two
    /// INSs
    /// @param ins1DaemonResponding true iff the daemon for INS1 is responsive
    /// @param ins1InUse true iff INS1 data are currently being used (e.g.,
    /// for beam pointing adjustments)
    /// @param ins1Status the current status details for INS2
    /// @param ins2DaemonResponding true iff the daemon for INS2 is responsive
    /// @param ins2InUse true iff INS2 data are currently being used (e.g.,
    /// for beam pointing adjustments)
    /// @param ins2Status the current status details for INS2

    void updateStatus(bool ins1DaemonResponding,
                      bool ins1InUse,
                      const CmigitsStatus & ins1Status,
                      bool ins2DaemonResponding,
                      bool ins2InUse,
                      const CmigitsStatus & ins2Status);
private:
    /// @brief Return a color name to be used for color-coding the given
    /// difference value.
    ///
    /// If diff is >= badThreshold, a color for a 'bad diff' will be
    /// returned. Else if diff >= warnThreshold, a color for 'warn diff' will
    /// be returned. Otherwise, a color for 'good diff' will be returned.
    /// @param diff the difference to be tested (should be absolute value)
    /// @param badThreshold the threshold for the 'bad diff' color
    /// @param warnThreshold the thresold for the 'warn diff' color
    /// @return a color name to be used for color-coding the given
    /// difference value.
    static const QString & DiffTextColor(double diff,
                                         double badThreshold,
                                         double warnThreshold);
    Ui::InsOverview _ui;
};

#endif /* SRC_HCRGUI_INSOVERVIEW_H_ */
