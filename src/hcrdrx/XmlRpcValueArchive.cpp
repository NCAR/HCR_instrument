/*
 * XmlRpcValueArchive.cpp
 *
 *  Created on: Jun 27, 2013
 *      Author: burghart
 */

#define BOOST_ARCHIVE_SOURCE

#include "XmlRpcValueArchive.h"

// Special instantiation required for Boost 1.41
#if (BOOST_VERSION/100 == 10041)
   // we must explicitly instantiate some implementation for this type of stream
#  include <boost/archive/impl/archive_serializer_map.ipp>
   template class boost::archive::detail::archive_serializer_map<XmlRpcValueIarchive>;
#endif
