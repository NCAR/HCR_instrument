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
                    int nGates,
                    const int16_t *iq)

{
  
  _pulseSeqNum = pulseSeqNum;
  _timeSecs = timeSecs;
  _nanoSecs = nanoSecs;

  _channelId = channelId;

  _rotMotorAngle = rotMotorAngle;
  _tiltMotorAngle = tiltMotorAngle;

  _nGates = nGates;

  _xmitPolarization = xmitPol;
  
  _allocIq();
  memcpy(_iq, iq, _nGates * 2 * sizeof(int16_t));

}

/////////////////////////////////////////////////////////////////////////////
// combine every second gate in the IQ data
// to reduce the number of gates to half

void PulseData::combineEverySecondGate()

{

  int nGatesHalf = _nGates / 2;

  int16_t *iq = _iq;
  int16_t *iqHalf = _iq;

  for (int ii = 0; ii < nGatesHalf; ii++) {

    memcpy(iqHalf, iq, 2 * sizeof(int16_t));
    iq += 4;
    iqHalf += 2;

  }

  _nGates = nGatesHalf;

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

  _iq = new int16_t[_nGates * 2];

}

