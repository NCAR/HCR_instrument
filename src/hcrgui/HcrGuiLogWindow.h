/*
 *  Created on: Dec 4, 2013
 *      Author: burghart
 */
#ifndef HCRGUILOGWINDOW_H_
#define HCRGUILOGWINDOW_H_

#include <QDialog>
#include <QPixmap>
#include <DrxStatus.h>

#include "ui_HcrGuiLogWindow.h"


class HcrGuiLogWindow : public QDialog {
    Q_OBJECT
public:
    HcrGuiLogWindow(QWidget *parent);
    virtual ~HcrGuiLogWindow() {}
    
public slots:
    // Append the given text to _ui.logArea
    void appendPlainText(const QString & text);

private:
    Ui::HcrGuiLogWindow _ui;
};
#endif /* HCRGUILOGWINDOW_H_*/
