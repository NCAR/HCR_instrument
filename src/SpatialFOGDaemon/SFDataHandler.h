/*
 * SFDataHandler.h
 *
 *  Created on: Jul 1, 2016
 *      Author: burghart
 */

#ifndef _SFDATAHANDLER_H_
#define _SFDATAHANDLER_H_

#include <QtCore/qobject.h>

class SFDataHandler: public QObject {
public:
    SFDataHandler();
    virtual ~SFDataHandler();
public slots:
    void handleData(QByteArray data);
};

#endif /* _SFDATAHANDLER_H_ */
