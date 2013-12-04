/*
 * HcrGuiLogWindow.cpp
 *
 *  Created on: Dec 4, 2013
 *      Author: burghart
 */
#include "HcrGuiLogWindow.h"
#include <QDateTime>

HcrGuiLogWindow::HcrGuiLogWindow(QWidget *parent) :
    QDialog(parent),
    _ui() {
    // Set up the UI and get the current status
    _ui.setupUi(this);
    // Limit the log area to 1000 messages
    _ui.logArea->setMaximumBlockCount(1000);
}

void
HcrGuiLogWindow::appendPlainText(const QString & text) {
    _ui.logArea->appendPlainText(text);
}
