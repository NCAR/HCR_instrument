// Boost archive classes to serialize to/from XmlRpcValue dictionaries.
#include <XmlRpc.h>
#include <boost/archive/detail/common_iarchive.hpp>
#include <boost/archive/detail/common_oarchive.hpp>

using namespace XmlRpc;

/// @brief Boost output archive class to populate an XmlRpcValue dictionary
/// 
/// Here's a simple class with a templated serialize() method:
///
/// class foo {
/// public:
///   foo() { _a = -1; _b = -1.0; _c = true }
///   foo(const XmlRpcValue & dict
///   template<class Archive>
///   void serialize(Archive & ar, const int version) {
///      ar & BOOST_SERIALIZATION_NVP(_a);
///      ar & BOOST_SERIALIZATION_NVP(_b);
///      ar & BOOST_SERIALIZATION_NVP(_c);
///   }
/// private:
///   int _a;
///   double _b;
///   bool _c;
/// };
///    
class XmlRpcValueOarchive : 
    public boost::archive::detail::common_oarchive<XmlRpcValueOarchive> {
public:
    XmlRpcValueOarchive(XmlRpcValue & archive) : _archive(archive) {}
    
    // default processing - kick back to our superclass
    template<class T>
    void save_override(const T & t, BOOST_PFTO int) {
        boost::archive::detail::common_oarchive<XmlRpcValueOarchive>::save_override(t, 0);
    }
    
    // Add special key "class_version" in the dictionary to hold the version
    // number of the class we're archiving.
    void save_override(const boost::archive::version_type & t, BOOST_PFTO int) {
        _archive["class_version"] = XmlRpcValue(static_cast<const int>(t));
    }
    
    // Don't bother archiving tracking_type, class_id_optional_type Boost special values
    void save_override(const boost::archive::tracking_type & t, BOOST_PFTO int) {
//        std::cerr << "XmlRpcValueOarchive dropping tracking_type" << std::endl;
    }
    void save_override(const boost::archive::class_id_optional_type & t, BOOST_PFTO int) {
//        std::cerr << "XmlRpcValueOarchive dropping class_id_optional_type" << std::endl;
    }
    
    // Archive name-value pairs (nvp) as key/value entries in our XmlRpcValue 
    // dictionary.
    template<class T>
    void save_override(const boost::serialization::nvp<T> & pair, BOOST_PFTO int) {
        _archive[pair.name()] = XmlRpcValue(pair.value());
    }
    
    // Not sure why we need this, but things won't compile without it...
    template<class T>
    void save(T & t) {
        std::cerr <<
            "XmlRpcValueOarchive only deals with name-value pairs, " <<
            "failed to save from (mangled) type: " << typeid(T).name() <<
            std::endl;
        std::cerr << "(Try 'c++filt -t <type>' to demangle the type name.)" <<
            std::endl;
        abort();
    }
private:
    friend class boost::archive::detail::common_oarchive<XmlRpcValueOarchive>;
    XmlRpcValue & _archive;
};

/// @brief Boost input archive class to unpack from XmlRpcValue dictionary
class XmlRpcValueIarchive : 
    public boost::archive::detail::common_iarchive<XmlRpcValueIarchive> {
public:
    XmlRpcValueIarchive(const XmlRpcValue & archive) : _archive(archive) {}
    
    // default processing - kick back to our superclass
    template<class T>
    void load_override(T & t, BOOST_PFTO int) {
        boost::archive::detail::common_iarchive<XmlRpcValueIarchive>::load_override(t, 0);
    }
    
    // Get class version number from special key "class_version" in the 
    // XmlRpcValue dictionary.
    void load_override(boost::archive::version_type & t, BOOST_PFTO int) {
        const std::string key("class_version");
        if (! _archive.hasMember(key)) {
            std::cerr << "XmlRpcValue dictionary does not contain requested key '" <<
                    key << "'!" << std::endl;
            abort();  
        }
        t = boost::archive::version_type(int(const_cast<XmlRpcValue&>(_archive)[key]));
    }
    
    // Don't bother loading tracking_type and class_id_optional_type Boost 
    // special values
    void load_override(boost::archive::tracking_type & t, BOOST_PFTO int) {
//        std::cerr << "XmlRpcValueIarchive not loading tracking_type" << std::endl;
    }
    void load_override(boost::archive::class_id_optional_type & t, BOOST_PFTO int) {
//        std::cerr << "XmlRpcValueIarchive not loading class_id_optional_type" << std::endl;
    }
    
    // Extract name-value pairs (nvp) using key/value entries in our XmlRpcValue 
    // dictionary.
    template<class T>
    void load_override(
#ifndef BOOST_NO_FUNCTION_TEMPLATE_ORDERING
            const
#endif
            boost::serialization::nvp<T> & pair,
            BOOST_PFTO int)
    {
        // Verify that the desired key is in our dictionary.
        const char * key = pair.name();
        if (! _archive.hasMember(key)) {
            std::cerr << "XmlRpcValue dictionary does not contain requested key '" <<
                    key << "'!" << std::endl;
            abort();
        }
        // Since the key exists, we can let the type-specific loaders below
        // do their jobs.
        pair.value() = T(const_cast<XmlRpcValue&>(_archive)[key]);
    }

    // We need an explicit loader for name-value pair with float value, because
    // there's no XmlRpcValue::operator float&() method.
    void load_override(const boost::serialization::nvp<float> & pair, BOOST_PFTO int) {
        const char * key = pair.name();
        if (! _archive.hasMember(key)) {
            std::cerr << "XmlRpcValue dictionary does not contain requested key '" <<
                    key << "'!" << std::endl;
            abort();
        }
        pair.value() = double(const_cast<XmlRpcValue&>(_archive)[key]);
    }
    
    // We need an explicit loader for name-value pair with uint16_t value, because
    // there's no XmlRpcValue::operator uint16_t&() method.
    void load_override(const boost::serialization::nvp<uint16_t> & pair, BOOST_PFTO int) {
        const char * key = pair.name();
        if (! _archive.hasMember(key)) {
            std::cerr << "XmlRpcValue dictionary does not contain requested key '" <<
                    key << "'!" << std::endl;
            abort();
        }
        pair.value() = int(const_cast<XmlRpcValue&>(_archive)[key]);
    }

    // Not sure why we need this, but things won't compile without it...
    template<class T>
    void load(T & t) {
        std::cerr <<
            "XmlRpcValueIarchive only deals with name-value pairs, " <<
            "failed to load to (mangled) type: " << typeid(T).name() <<
            std::endl;
        std::cerr << "(Try 'c++filt -t <type>' to demangle the type name.)" <<
            std::endl;
        abort();
    }

private:
    // For boost::serialization, we must make our superclass our friend!
    friend class boost::archive::detail::common_iarchive<XmlRpcValueIarchive>;
    const XmlRpcValue & _archive;
};

