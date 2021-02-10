// PublishWorker.cpp
//
//  Created on: Oct 11, 2018
//      Author: Chris Burghart <burghart@ucar.edu>

#include "PublishWorker.h"
#include "IwrfPublisher.h"
#include <logx/Logging.h>

LOGGING("PublishWorker")

PublishWorker::PublishWorker(IwrfPublisher & publisher) :
    QObject(),
    _publisher(publisher) {
    // Our whole purpose is to have affinity in the publisher's worker thread,
    // so that any of our slots will execute in that thread.
    moveToThread(&_publisher._pubThread);
}

PublishWorker::~PublishWorker() {}

void
PublishWorker::publish() {
    // Just run our IwrfPublisher's _publishCompletedPulses method. This will
    // execute within our worker thread.
    _publisher._publishCompletedPulses();
}
