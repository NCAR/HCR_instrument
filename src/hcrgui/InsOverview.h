/*
 * InsOverview.h
 *
 *  Created on: Oct 19, 2017
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#ifndef SRC_HCRGUI_INSOVERVIEW_H_
#define SRC_HCRGUI_INSOVERVIEW_H_

#include <QDialog>
#include <CmigitsStatus.h>

#include "ui_InsOverview.h"

class InsOverview: public QDialog {
    Q_OBJECT
public:
    InsOverview(QWidget * parent);
    virtual ~InsOverview() {}

    void noStatus();
signals:
    /// @brief Signal emitted to request a change in MotionControlDaemon's
    /// 'INS in use'.
    /// @param requestedIns the INS desired as MotionControlDaemon's INS in use,
    /// either 1 or 2
    void requestNewInsInUse(int requestedIns);

public slots:
    /// @brief Update the widget with current status values for the two
    /// INSs
    /// @param ins1DaemonResponding true iff the daemon for INS1 is responsive
    /// @param ins1Status the current status details for INS2
    /// @param ins2DaemonResponding true iff the daemon for INS2 is responsive
    /// @param ins2Status the current status details for INS2
    /// @param insInUse the INS in use by MotionControlDaemon, either 1 or 2
    void updateStatus(bool ins1DaemonResponding,
                      const CmigitsStatus & ins1Status,
                      bool ins2DaemonResponding,
                      const CmigitsStatus & ins2Status,
                      int insInUse);
private slots:
    // Auto-connected slots
    void on_useIns1Button_clicked();
    void on_useIns2Button_clicked();
private:
    /// @brief Set the text and coloring for the given label in the
    /// "Diff" column.
    ///
    /// @param label pointer to the label in the difference column
    /// @param diff the difference to be reported
    /// @param units a units string for the difference
    /// @param precision the number of digits to display after the decimal
    /// point when printing the difference
    /// @param badThreshold a difference >= this threshold will be tagged with
    /// an error color
    /// @param warnThreshold a difference >= this threshold will be tagged
    /// with a warning color
    void _setDiffValueLabel(QLabel * label,
                            const double diff,
                            const QString & units,
                            const int precision,
                            const double badThreshold,
                            const double warnThreshold);

    /// @brief Return a color name to be used for color-coding the background
    /// for the given difference value.
    ///
    /// If diff is >= badThreshold, tint the default background color a bit red.
    /// Else if diff >= warnThreshold, tint the default background color a bit
    /// yellow. Otherwise, just return the default background color.
    /// @param defBgColor the default background color to be tinted
    /// @param diff the difference to be tested (should be absolute value)
    /// @param badThreshold the threshold for the 'bad diff' color
    /// @param warnThreshold the threshold for the 'warn diff' color
    /// @return a color name to be used for color-coding the given
    /// difference value.
    static const QString _DiffBgColorName(const QColor & defBgColor,
                                          double diff,
                                          double badThreshold,
                                          double warnThreshold);

    /// @brief Initiate a request for a new 'INS in use'
    ///
    /// A confirmation dialog will be presented, and upon confirmation a
    /// requestNewInsInUse signal will be emitted.
    /// @param requestedIns the number for the requested new 'INS in use'
    /// (1 or 2)
    void _requestInsInUse(int requestedIns);

    Ui::InsOverview _ui;
    int _currentInsInUse;

    // LED pixmaps
    QPixmap _redLED;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;

};

#endif /* SRC_HCRGUI_INSOVERVIEW_H_ */
