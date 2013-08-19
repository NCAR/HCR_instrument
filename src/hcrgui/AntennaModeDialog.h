/*
 *  Created on: Jan 14, 2011
 *      Author: burghart
 */
#ifndef ANTENNAMODEDIALOG_H_
#define ANTENNAMODEDIALOG_H_

#include <QDialog>
#include <DrxStatus.h>

#include "ui_AntennaModeDialog.h"


class AntennaModeDialog : public QDialog {
    Q_OBJECT

public:
	/// Antenna motion mode: pointing or scanning
	typedef enum {
		POINTING,
		SCANNING
	} AntennaMode;

    AntennaModeDialog(QWidget *parent);
    virtual ~AntennaModeDialog() {}

    // Get selected antenna mode
    AntennaMode getMode();
    // Get antenna pointing angle
    void getPointingAngle(float& angle);
    // Get antenna scanning parameters
    void getScanningParam(float& ccwLimit, float& cwLimit, float& scanRate);

private slots:
    void on_buttonBox_clicked();

private:
    Ui::AntennaModeDialog _ui;
};

#endif /* ANTENNAMODEDIALOG_H_*/
