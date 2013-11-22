/*
 * XmlRpcValueArchive.cpp
 *
 *  Created on: Jun 27, 2013
 *      Author: burghart
 */

#define BOOST_ARCHIVE_SOURCE

#include <boost/version.hpp>
#include "XmlRpcValueArchive.h"

// Special instantiation required for Boost 1.41
#if (BOOST_VERSION/100 == 1041)
   // we must explicitly instantiate some implementation for this type of stream
   template class boost::archive::detail::common_oarchive<XmlRpcValueOarchive>;
   template class boost::archive::detail::common_iarchive<XmlRpcValueIarchive>;
#  include <boost/archive/impl/archive_serializer_map.ipp>
   template class boost::archive::detail::archive_serializer_map<XmlRpcValueIarchive>;
#endif
