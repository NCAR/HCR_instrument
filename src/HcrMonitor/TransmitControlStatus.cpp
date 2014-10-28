/*
 * TransmitControlStatus.cpp
 *
 *  Created on: Oct 28, 2014
 *      Author: burghart
 */

#include "TransmitControlStatus.h"

#include <Archive_xmlrpc_c.h>

TransmitControlStatus::TransmitControlStatus() :
        _hcrPmc730Responsive(false),
        _motionControlResponsive(false),
        _cmigitsResponsive(false),
        _terrainHtServerResponsive(false),
        _aglAltitude(-999.),
        _overWater(false),
        _hvRequested(false),
        _xmitAllowedStatus(TransmitControl::NOXMIT_UNSPECIFIED),
        _attenuationRequired(false) {}

TransmitControlStatus::TransmitControlStatus(const TransmitControl & tc) :
        _hcrPmc730Responsive(tc._hcrPmc730Responsive),
        _motionControlResponsive(tc._motionControlResponsive),
        _cmigitsResponsive(tc._cmigitsResponsive),
        _terrainHtServerResponsive(tc._terrainHtServerResponsive),
        _aglAltitude(tc._aglAltitude),
        _overWater(tc._overWater),
        _hvRequested(tc._hvRequested),
        _xmitAllowedStatus(tc._xmitAllowedStatus),
        _attenuationRequired(tc._attenuationRequired)  {}

TransmitControlStatus::TransmitControlStatus(xmlrpc_c::value_struct & statusDict) :
        _hcrPmc730Responsive(false),
        _motionControlResponsive(false),
        _cmigitsResponsive(false),
        _terrainHtServerResponsive(false),
        _aglAltitude(-999.),
        _overWater(false),
        _hvRequested(false),
        _xmitAllowedStatus(TransmitControl::NOXMIT_UNSPECIFIED),
        _attenuationRequired(false) {
    // Create an input archiver wrapper around the xmlrpc_c::value_struct
    // dictionary, and use serialize() to populate our members from its content.
    Iarchive_xmlrpc_c iar(statusDict);
    iar >> *this;
}

TransmitControlStatus::~TransmitControlStatus() {
}

