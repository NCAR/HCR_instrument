/*
 * ProductGenerator.h
 *
 *  Created on: Oct 14, 2009
 *      Author: burghart
 */

#ifndef PRODUCTGENERATOR_H_
#define PRODUCTGENERATOR_H_

#include <QThread>
#include <QtTSReader.h>

class ProductGenerator : public QThread {
    
    Q_OBJECT
    
public:
    ProductGenerator(QtTSReader *source);
    virtual ~ProductGenerator();
    void run();
    
protected slots:
    virtual void handleItem(ProfilerDDS::TimeSeries*);
    
signals:
    void returnItem(ProfilerDDS::TimeSeries*);
    
private:
    QtTSReader *_source;
    int _count;
};

#endif /* PRODUCTGENERATOR_H_ */
