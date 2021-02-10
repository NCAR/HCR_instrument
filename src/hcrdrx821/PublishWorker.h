// PublishWorker.h
//
//  Created on: Oct 11, 2018
//      Author: Chris Burghart <burghart@ucar.edu>
#ifndef PUBLISHWORKER_H_
#define PUBLISHWORKER_H_

#include <QtCore/QObject>

class IwrfPublisher;

class PublishWorker : public QObject {
    Q_OBJECT
public:
    PublishWorker(IwrfPublisher & publisher);

    virtual ~PublishWorker();

public slots:
    /// @brief Slot called to publish any of _publisher's ready pulses,
    /// running within our worker thread.
    void publish();

private:
    IwrfPublisher & _publisher;
};

#endif /* PUBLISHWORKER_H_ */
