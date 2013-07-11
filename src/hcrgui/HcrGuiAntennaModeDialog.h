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
    HcrGuiAntennaModeDialog(QWidget *parent);
    virtual ~HcrGuiAntennaModeDialog() {}

public slots:
    void updateStatus();
private:
    Ui::HcrGuiAntennaModeDialog _ui;
};
#endif /*HCRGUIANTENNAMODEDIALOG_H_*/
