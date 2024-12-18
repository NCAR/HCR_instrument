// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
// ** Copyright UCAR (c) 1990 - 2016
// ** University Corporation for Atmospheric Research (UCAR)
// ** National Center for Atmospheric Research (NCAR)
// ** Boulder, Colorado, USA
// ** BSD licence applies - redistribution and use in source and binary
// ** forms, with or without modification, are permitted provided that
// ** the following conditions are met:
// ** 1) If the software is modified to produce derivative works,
// ** such modified software should be clearly marked, so as not
// ** to confuse it with the version available from UCAR.
// ** 2) Redistributions of source code must retain the above copyright
// ** notice, this list of conditions and the following disclaimer.
// ** 3) Redistributions in binary form must reproduce the above copyright
// ** notice, this list of conditions and the following disclaimer in the
// ** documentation and/or other materials provided with the distribution.
// ** 4) Neither the name of UCAR nor the names of its contributors,
// ** if any, may be used to endorse or promote products derived from
// ** this software without specific prior written permission.
// ** DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS
// ** OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
// ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
/*
 * MaxPowerFmqClient.cpp
 *
 *  Created on: Mar 22, 2019
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#include "MaxPowerFmqClient.h"
#include <exception>
#include <logx/Logging.h>
#include <QtCore/QDateTime>
#include <QtXml/QDomDocument>
#include <QtCore/QMetaType>
#include <QtNetwork/QTcpSocket>

LOGGING("MaxPowerFmqClient")

const QByteArray MaxPowerFmqClient::ELEMENT_START_TEXT("<TsPrintMaxPower>");
const QByteArray MaxPowerFmqClient::ELEMENT_END_TEXT("</TsPrintMaxPower>");

MaxPowerFmqClient::MaxPowerFmqClient(std::string fmqUrl) :
        _fmq(),
        _fmqUrl(fmqUrl),
        _fmqPollTimer(),
        _reportIntervalSecs(),
        _reportTimeoutTimer(),
        _serverResponsive(false) {
    // We don't want our FMQ to generate PMU registration calls
    _fmq.setHeartbeat(NULL);

    // Create and start a timer to poll the FMQ. We start with a (long) timer
    // interval of FMQ_INIT_RETRY_MS until the FMQ is successfully
    // initialized in _doFmqRead().
    static const int FMQ_OPEN_RETRY_MS = 2000;
    _fmqPollTimer.setInterval(FMQ_OPEN_RETRY_MS);
    connect(&_fmqPollTimer, SIGNAL(timeout()), this, SLOT(_doFmqRead()));
    _fmqPollTimer.start();

    // Call _onReportTimeout() when the report timeout timer expires
    connect(&_reportTimeoutTimer, SIGNAL(timeout()),
            this, SLOT(_onReportTimeout()));

    // Start with an immediate call to _doFmqRead. Subsequent calls to it
    // will be triggered by _fmqPollTimer.
    _doFmqRead();
}

MaxPowerFmqClient::~MaxPowerFmqClient() {
    // stop our timers
    _fmqPollTimer.stop();
    _reportTimeoutTimer.stop();
}

void
MaxPowerFmqClient::_onReportTimeout() {
    // It's been too long since the last report from the server. Mark it as
    // unresponsive.
    _serverResponsive = false;
    _reportTimeoutTimer.stop();
    std::ostringstream os;
    os << "No max power value for " <<
          TIMEOUT_REPORT_MULTIPLE * _reportIntervalSecs <<
          " s. Previous report interval was " << _reportIntervalSecs << " s";
    WLOG << os.str();
    emit serverResponsive(_serverResponsive, QString(os.str().c_str()));
}

void
MaxPowerFmqClient::_doFmqRead() {
    // Open the FMQ if we haven't yet
    if (! _fmq.isOpen()) {
        // Try to initialize our FMQ for reading
        int err = _fmq.initReadOnly(_fmqUrl.c_str(), "MaxPowerFmqClient");
        if (err) {
            WLOG << "Failed to initialize FMQ '" << _fmqUrl << " for reading";
            return;
        } else {
            // With the FMQ open, we now poll faster to read the data
            static const int FMQ_POLL_INTERVAL_MS = 50; // 50 ms -> 20 Hz
            _fmqPollTimer.setInterval(FMQ_POLL_INTERVAL_MS);
            ILOG << "FMQ '" << _fmqUrl << "' is now ready for reading";
        }
    }

    // Read all messages which have been added to the FMQ. If
    int nread = 0;
    while (true) {
        bool gotOne;
        _fmq.readMsg(&gotOne);
        if (gotOne) {
            nread++;
        } else if (nread == 0) {
            // Return now if we got no new messages
            return;
        } else {
            // Break out when we're at the end of the FMQ
            break;
        }
    }

    // Copy the last message, trimming the trailing newline, and pass it on
    // for handling
    QByteArray msg(reinterpret_cast<const char*>(_fmq.getMsg()),
                   _fmq.getMsgLen() - 1);
    _handleMaxPowerElement(msg);
}

QString
MaxPowerFmqClient::_DocElementText(const QDomDocument & doc, QString elementName) {
    QDomElement element = doc.documentElement().lastChildElement(elementName);
    if (element.isNull()) {
        std::ostringstream oss;
        oss << "Expected element '" << elementName.toStdString() <<
                "' not found";
        throw std::runtime_error(oss.str());
    }
    return(element.text());
}

void
MaxPowerFmqClient::_handleMaxPowerElement(const QByteArray & text) {
    QDomDocument doc;
    QString errorMsg;
    int errorLine;
    if (! doc.setContent(text, false, &errorMsg, &errorLine)) {
        ELOG << errorMsg.toStdString() << " at line " << errorLine <<
                " of:\n" << text.data();
        return;
    }

    // Values to be filled from the max power element
    double secondsSinceEpoch;    // time at the midpoint of the dwell
    double meanMaxDbm;    // mean of the maximum values during the dwell period
    double peakMaxDbm;    // absolute maximum during the dwell period
    double rangeToMax;    // range to the absolute maximum during the dwell period
    double dwellSecs;     // dwell period for calculating max power

    try {
        // Initialize dataTime from the "time" child element (ISO time to the
        // second). This is the center time of the period over which the max
        // power was measured.
        QString timeText = _DocElementText(doc, "time");
        QDateTime dataTime = QDateTime::fromString(timeText, Qt::ISODate);

        // Unpack the parsed "msecs" element, which is the milliseconds portion
        // of the data time, and add it to dataTime.
        QString msecsText = _DocElementText(doc, "msecs");
        int msecs = msecsText.toInt();
        dataTime = dataTime.addMSecs(msecs);

        // Unpack the parsed "dwellSecs" element, which is the period of time
        // over which the max power was measured.
        QString dwellSecsText = _DocElementText(doc, "dwellSecs");
        dwellSecs = dwellSecsText.toDouble();

        // Unpack the parsed "reportIntervalSecs" element, which is the period of time
        // between max power reports.
        QString reportIntervalText = _DocElementText(doc, "reportIntervalSecs");
        _reportIntervalSecs = reportIntervalText.toDouble();

        // Get H channel mean max power over the max power server's dwell time
        // from "meanMaxDbm0" element
        QString meanMaxDbm0Text = _DocElementText(doc, "meanMaxDbm0");
        double meanMaxDbmH = meanMaxDbm0Text.toDouble();

        // Get V channel mean max power over the max power server's dwell time
        // from "meanMaxDbm1" element
        QString meanMaxDbm1Text = _DocElementText(doc, "meanMaxDbm1");
        double meanMaxDbmV = meanMaxDbm1Text.toDouble();

        // Get H channel peak max power over the max power server's dwell time
        // from "peakMaxDbm0" element
        QString peakMaxDbm0Text = _DocElementText(doc, "peakMaxDbm0");
        double peakMaxDbmH = peakMaxDbm0Text.toDouble();

        // Get V channel peak max power from "peakMaxDbm1" element
        QString peakMaxDbm1Text = _DocElementText(doc, "peakMaxDbm1");
        double peakMaxDbmV = peakMaxDbm1Text.toDouble();

        // Get range to H channel max power from "rangeToMax0" element
        QString rangeToMax0Text = _DocElementText(doc, "rangeToMax0");
        double rangeToPeakH = rangeToMax0Text.toDouble();

        // Get range to V channel max power from "rangeToMax1" element
        QString rangeToMax1Text = _DocElementText(doc, "rangeToMax1");
        double rangeToPeakV = rangeToMax1Text.toDouble();

        // Figure out which channel's max is *really* max
        meanMaxDbm = (meanMaxDbmH > meanMaxDbmV) ? meanMaxDbmH : meanMaxDbmV;
        peakMaxDbm = (peakMaxDbmH > peakMaxDbmV) ? peakMaxDbmH : peakMaxDbmV;
        rangeToMax = (peakMaxDbmH > peakMaxDbmV) ? rangeToPeakH : rangeToPeakV;

        // We successfully parsed everything we need
        DLOG << "New max power at " <<
                dataTime.toString("yyyy/MM/dd hh:mm:ss.zzz").toStdString() <<
                ": peak " << peakMaxDbm << " dBm (" << rangeToMax <<
                " m range), mean " << meanMaxDbm << " dBm";
        secondsSinceEpoch = dataTime.toTime_t() + 0.001 * dataTime.time().msec();
    } catch (std::runtime_error & e) {
        ELOG << "Error in <TsPrintMaxPower>: " << e.what();
        ELOG << "Text of offending <TsPrintMaxPower>: \n" << text.data();
        return;
    }

    // Mark the server as responsive if it had been unresponsive
    if (! _serverResponsive) {
        _serverResponsive = true;
        std::string msg("Max power server is delivering data");
        ILOG << msg;
        emit serverResponsive(_serverResponsive, QString(msg.c_str()));
    }

    // Start (or restart) the dwell timeout timer to fire if the next max power
    // report does not arrive within TIMEOUT_REPORT_MULTIPLE * this report's
    // dwell time.
    _reportTimeoutTimer.start(int(1000 * TIMEOUT_REPORT_MULTIPLE * _reportIntervalSecs));

    // Emit the new newMaxPower signal
    emit(newMaxPower(secondsSinceEpoch, dwellSecs, peakMaxDbm, rangeToMax, meanMaxDbm));
}
