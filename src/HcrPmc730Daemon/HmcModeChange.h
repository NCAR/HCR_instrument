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
 * HmcModeChange.h
 *
 * Port number and struct used when broadcasting operation mode changes.
 *
 *  Created on: Dec 2, 2014
 *      Author: burghart
 */

#ifndef OPERATIONMODECHANGE_H_
#define OPERATIONMODECHANGE_H_

#include <HcrPmc730.h>

#include <boost/archive/binary_iarchive.hpp>
#include <boost/archive/binary_oarchive.hpp>
#include <QUdpSocket>
#include <QNetworkDatagram>

/// UDP port on which operation mode changes are broadcast.
static const uint16_t OPERATION_MODE_BROADCAST_PORT = 56565;

/// @brief Broadcast a datagram to indicate the new mode and the time of the
/// mode change (double precision seconds since 1970-01-01 00:00:00 UTC)
auto BroadcastModeChange(QUdpSocket& socket, OperationMode& mode)
{
    struct timeval nowTimeval;
    gettimeofday(&nowTimeval, NULL);
    double modeChangeTime =
            nowTimeval.tv_sec + 1.0e-6 * nowTimeval.tv_usec; // seconds since epoch

    std::ostringstream os;
    boost::archive::binary_oarchive oa(os);
    oa << mode;
    oa << modeChangeTime;

    int result = socket.writeDatagram(
            os.str().data(),
            os.str().size(), QHostAddress::Broadcast,
            OPERATION_MODE_BROADCAST_PORT);

    return result;
}

/// @brief Read all datagrams available (there should really always be just one),
/// and note the mode change time from the last one.
auto ListenForModeChange(QUdpSocket& socket)
{

    double modeChangeTime = 0.0;
    OperationMode mode;

    while (socket.hasPendingDatagrams()) {

        auto datagram = socket.receiveDatagram();
        std::istringstream is(datagram.data().toStdString());
        boost::archive::binary_iarchive ia(is);
        ia >> mode;
        ia >> modeChangeTime;
    }
    return std::pair<OperationMode, double>(mode, modeChangeTime);
}

#endif /* OPERATIONMODECHANGE_H_ */
