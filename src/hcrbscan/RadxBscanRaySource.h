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
 * RadxBscanRaySource.h
 *
 *  Created on: May 2, 2012
 *      Author: burghart
 */

#ifndef RADXBSCANRAYSOURCE_H_
#define RADXBSCANRAYSOURCE_H_

#include <QObject>

class BscanRay;
class RadxRay;

/**
 * @brief Class to accept incoming RadxRay objects, convert them to BscanRay-s,
 * and deliver the BscanRay-s via a newBscanRay() Qt signal.
 */
class RadxBscanRaySource : public QObject {
    Q_OBJECT
public:
    RadxBscanRaySource();
    virtual ~RadxBscanRaySource();
signals:
    /**
     * @brief The newBscanRay signal is emitted when a new BscanRay has been
     * generated.
     * @param ray the newly generated BscanRay
     */
    void newBscanRay(const BscanRay & ray) const;
public slots:
    /**
     * Make a BscanRay from an incoming RadxRay and emit a newBscanRay() signal 
     * for the new ray.
     * @param radxRay the RadxRay to be converted to a BscanRay
     */
    void makeBscanRay(RadxRay & radxRay) const;
};

#endif /* RADXBSCANRAYSOURCE_H_ */
