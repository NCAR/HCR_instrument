/*
 *  Created on: Jan 14, 2011
 *      Author: burghart
 */
#ifndef HCRGUIANTENNAMODEDIALOG_H_
#define HCRGUIANTENNAMODEDIALOG_H_

#include <QDialog>
#include <DrxStatus.h>

#include "ui_HcrGuiAntennaModeDialog.h"


class HcrGuiAntennaModeDialog : public QDialog {
    Q_OBJECT

public:
	/// Antenna motion mode: pointing or scanning
	typedef enum {
		POINTING,
		SCANNING
	} AntennaMode;

    HcrGuiAntennaModeDialog(QWidget *parent);
    virtual ~HcrGuiAntennaModeDialog() {}

    // Get selected antenna mode
    AntennaMode getMode();
    // Get antenna pointing angle
    void getPointingAngle(float& angle);
    // Get antenna scanning parameters
    void getScanningParam(float& ccwLimit, float& cwLimit, float& scanRate);

private slots:
    void on_buttonBox_clicked();

private:
    Ui::HcrGuiAntennaModeDialog _ui;
};

#endif /*HCRGUIANTENNAMODEDIALOG_H_*/
