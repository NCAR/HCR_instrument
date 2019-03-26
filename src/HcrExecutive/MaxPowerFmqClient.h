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
 * MaxPowerFmqClient.h
 *
 *  Created on: Mar 22, 2019
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#ifndef MAXPOWERFMQCLIENT_H_
#define MAXPOWERFMQCLIENT_H_

#include <string>
#include <Fmq/Fmq.hh>

#include <QByteArray>
#include <QTimer>

class QDomDocument;

/// @brief Class which polls a given FMQ for radar max power elements, emitting
/// newMaxPower signals when new elements are seen.
class MaxPowerFmqClient : public QObject {
    Q_OBJECT
public:
    MaxPowerFmqClient(std::string fmqUrl);
    virtual ~MaxPowerFmqClient();

    void run();
signals:
    /// @brief Signal emitted when the max power server becomes responsive or
	/// unresponsive.
    /// @param responsive true if the server has become responsive or false
	/// if the server has become unresponsive
    /// @param msg a message describing the associated event
    void serverResponsive(bool responsive, QString msg);

    /// @brief Signal emitted when a new maximum power is received from
    /// the TsPrint max power server.
    /// @param time the center time for of the max power dwell, seconds since
    ///    1970-01-01 00:00:00 UTC
    /// @param dwellTime the length of time over which max power was sampled, s
    /// @param peakMaxPower the maximum power measured, dBm
    /// @param rangeToPeakMax the range from the radar to the peak maximum power
    ///    return, m
    /// @param meanMaxPower mean maximum power, averaged over the max power
    ///    server's dwell time, dBm
    void newMaxPower(double time, double dwellTime, double peakMaxPower,
                     double rangeToPeakMax, double meanMaxPower);

private slots:

    /// @brief Slot which reads any max power packets currently in the FMQ
    /// and emits a newMaxPower() signal for the last one, if any, found.
    ///
    /// As a rule, this will execute often enough that only 0 or 1 packet is
    /// found.
    void _doFmqRead();

    /// @brief Slot to be called when the last received max power value is
    /// considered too old
    void _onReportTimeout();

private:
    /// @brief Text marking the start of a TsPrintMaxPower element
    static const QByteArray ELEMENT_START_TEXT;

    /// @brief Text marking the end of a TsPrintMaxPower element
    static const QByteArray ELEMENT_END_TEXT;

    /// @brief Deal with a max power XML element, which should be of the
    /// form:
    ///      <TsPrintMaxPower>
    ///        <time>2014-11-20T18:03:51</time>
    ///        <msecs>679</msecs>
    ///        <dwellSecs>0.0101</dwellSecs>
    ///        <reportIntervalSecs>0.1010</reportIntervalSecs>
    ///        <prf>9864.27</prf>
    ///        <nSamples>5000</nSamples>
    ///        <startGate>30</startGate>
    ///        <nGates>740</nGates>
    ///        <el>87.9828</el>
    ///        <az>228.685</az>
    ///        <maxDbm0>-96.5835</maxDbm0>
    ///        <maxDbm1>-95.2945</maxDbm1>
    ///        <rangeToMax0>7374.89</rangeToMax0>
    ///        <rangeToMax1>7183.03</rangeToMax1>
    ///      </TsPrintMaxPower>
    /// Emit a newMaxPower() signal if the element parses correctly.
    /// @param text the text of the max power XML element
    void _handleMaxPowerElement(const QByteArray & text);

    /// @brief Return the text of the requested element from the given DOM
    /// document as a QString
    /// @param doc the QDomDocument from which to extract the desired element
    /// @param elementName the name of the element to be extracted from the
    /// document
    /// @return the text of the requested DOM document element as a QString
    static QString _DocElementText(const QDomDocument & doc, QString elementName);

    /// @brief FMQ providing max power data
    Fmq _fmq;

    /// @brief The URL for our FMQ
    std::string _fmqUrl;

    /// @brief Timer to drive periodic polling of the FMQ
    QTimer _fmqPollTimer;

    /// @brief Report period as of the last received max power element
    double _reportIntervalSecs;

    /// @brief maximum number of power element report times which can elapse
    /// before the server is considered to be unresponsive
    static constexpr float TIMEOUT_REPORT_MULTIPLE = 1.5;

    /// @brief timer started on receipt of a new max power element and expires
    /// after TIMEOUT_REPORT_MUTIPLE * the max power element's report interval
    QTimer _reportTimeoutTimer;

    /// @brief True iff the server is responding
    bool _serverResponsive;

    /// @brief Data read from the socket but not yet parsed
    QByteArray _unparsedData;
};

#endif /* MAXPOWERSERVERCLIENT_H_ */
