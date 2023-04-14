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
#include "PulseData.h"
#include <cstdio>
#include <cstring>

///////////////////////////////////////////////////////////////////////////

PulseData::PulseData() :
    _pulseSeqNum(-9999),
    _timeSecs(0),
    _nanoSecs(0),
    _channelId(-9999),
    _nGates(0),
    _nGatesAlloc(0),
    _rotMotorAngle(0.0),
    _tiltMotorAngle(0.0),
    _xmitPolarization(XMIT_POL_HORIZONTAL),
    _prt1(0.0),
    _prt2(0.0),
    _currentPrt(0.0),
    _txPulseWidth(0.0),
    _sampleWidth(0.0),
    _offset(0.0),
    _scale(1.0),
    _encoding(IWRF_IQ_ENCODING_NOT_SET),
    _iq(NULL)
{}

/////////////////////////////////////////////////////////////////////////////
PulseData::~PulseData()

{

  if (_iq) {
    delete[] _iq;
  }

}

/////////////////////////////////////////////////////////////////////////////
// set the data

void PulseData::set(int64_t pulseSeqNum,
                    time_t timeSecs,
                    int nanoSecs,
                    int channelId,
                    float rotMotorAngle,
                    float tiltMotorAngle,
                    XmitPolarization_t xmitPol,
                    double prt1,
                    double prt2,
                    double currentPrt,
                    double txPulseWidth,
                    double sampleWidth,
                    double sampleOffset,
                    double sampleScale,
                    iwrf_iq_encoding_t encoding,
                    int nGates,
                    const IQData *iq)
{

  _pulseSeqNum = pulseSeqNum;
  _timeSecs = timeSecs;
  _nanoSecs = nanoSecs;
  _channelId = channelId;
  _rotMotorAngle = rotMotorAngle;
  _tiltMotorAngle = tiltMotorAngle;
  _nGates = nGates;
  _xmitPolarization = xmitPol;
  _prt1 = prt1;
  _prt2 = prt2;
  _currentPrt = currentPrt;
  _txPulseWidth = txPulseWidth;
  _sampleWidth = sampleWidth;
  _offset = sampleOffset;
  _scale = sampleScale;
  _encoding = encoding;

  _allocIq();
  memcpy(_iq, iq, _nGates * sizeof(IQData));

}

/////////////////////////////////////////////////////////////////////////////
// alloc or realloc space for the iq data

void PulseData::_allocIq()

{

  if (_nGatesAlloc >= _nGates) {
    return;
  }

  if (_iq) {
    delete[] _iq;
  }

  _iq = new IQData[_nGates];

}

