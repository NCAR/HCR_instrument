/*
 *  Created on: Jan 14, 2011
 *      Author: burghart
 */
#ifndef XMITDETAILS_H_
#define XMITDETAILS_H_

#include <QDialog>
#include <QPixmap>

#include "ui_XmitDetails.h"
#include <XmitdRpcClient.h>


class XmitDetails : public QDialog {
    Q_OBJECT
public:
    XmitDetails(QWidget *parent);
    virtual ~XmitDetails() {}

    void updateStatus(const XmitStatus & xmitStatus);
    void noStatus();

protected:
    /**
     *  @brief Return "-" if the count is zero, otherwise a text representation of
     *  the count.
     *  @param count the count to be represented
     *  @return "-" if the count is zero, otherwise a text representation of
     *      the count.
     */
    static QString _countLabel(int count);

    /**
     *  Return an empty string if the time is -1, otherwise a brief text
     *  representation of the time.
     *  @param time the time_t time to be represented
     *  @return an empty string if the time is -1, otherwise a brief text
     *  representation of the time.
     */
    static QString _faultTimeLabel(time_t time);

private:
    Ui::XmitDetails _ui;
    QPixmap _redLED;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;
};
#endif /* XMITDETAILS_H_*/