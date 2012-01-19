/*
 * HcrMonitor.cpp
 *
 *  Created on: Oct 29, 2010
 *      Author: burghart
 */

#include "HcrMonitor.h"
#include "HcrPmc730.h"

#include <QDateTime>
#include <QTimer>
#include <QMutexLocker>

#include <iostream>
#include <iomanip>
#include <cmath>
#include <string>
#include <vector>
#include <deque>

#include <logx/Logging.h>

LOGGING("HcrMonitor")


HcrMonitor::HcrMonitor(const HcrDrxConfig &config) :
    QThread(),
    _config(config),
    _mutex(QMutex::Recursive) {
}

HcrMonitor::~HcrMonitor() {
    terminate();
    if (! wait(5000)) {
        ELOG << "HcrMonitor thread failed to stop in 5 seconds. Exiting anyway.";
    }
}

float
HcrMonitor::procDrxTemp() const {
    QMutexLocker locker(&_mutex);
    return _dequeAverage(_procDrxTemps);
}

void
HcrMonitor::run() {
    QDateTime lastUpdateTime(QDateTime::fromTime_t(0).toUTC());
    
    // Since we have no event loop, allow thread termination via the terminate()
    // method.
    setTerminationEnabled(true);
  
    while (true) {
        // Sleep if necessary to get ~1 second between updates
        QDateTime now = QDateTime::currentDateTime().toUTC();
        uint64_t msecsSinceUpdate = uint64_t(lastUpdateTime.daysTo(now)) * 1000 * 86400 + 
            lastUpdateTime.time().msecsTo(now.time());
        if (msecsSinceUpdate < 1000) {
            usleep((1000 - msecsSinceUpdate) * 1000);
        }
        
        // Get new values from the multi-IO card and from hcr_xmitd
        _getMultiIoValues();
        
        lastUpdateTime = QDateTime::currentDateTime().toUTC();
    }
}

void
HcrMonitor::_getMultiIoValues() {

  if (_config.simulate_pmc730()) {
    return;
  }


    QMutexLocker locker(&_mutex);

    HcrPmc730 & pmc730 = HcrPmc730::theHcrPmc730();
    // Get data from analog channels 0-9 on the PMC-730 multi-IO card
    std::vector<float> analogData = pmc730.readAnalogChannels(0, 9);
//    // Channels 0-2 give us RF power measurements
//    _testTargetPowerVideo = _lookupQEAPower(analogData[0]);
//    _vTxPowerVideo = _lookupQEAPower(analogData[1]);
//    _hTxPowerVideo = _lookupQEAPower(analogData[2]);
    // Channel 3 gives us temperature near the DRX. The data are a bit noisy, so
    // we keep up to TEMP_AVERAGING_LEN samples so we can generate moving 
    // averages.
    _procDrxTemps.push_back(_voltsToTemp(analogData[7]));
    while (_procDrxTemps.size() > TEMP_AVERAGING_LEN) {
        _procDrxTemps.pop_front();
    }

    DLOG << std::fixed << std::setprecision(1) << 
        "drx: " << procDrxTemp() << " C";
}

float
HcrMonitor::_dequeAverage(const std::deque<float> & list) {
    unsigned int nPoints = list.size();
    if (nPoints == 0)
        return(-99.9);
        
    float sum = 0.0;
    for (unsigned int i = 0; i < nPoints; i++)
        sum += list.at(i);
    return(sum / nPoints); 
}
