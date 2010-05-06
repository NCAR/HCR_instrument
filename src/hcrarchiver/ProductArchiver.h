/*
 * ProductArchiver.h
 *
 *  Created on: May 5, 2010
 *      Author: burghart
 */

#ifndef PRODUCTARCHIVER_H_
#define PRODUCTARCHIVER_H_

#include <ProductReader.h>

// Singleton ProductArchiver class
class ProductArchiver : public ProductReader {
public:
    // Get the singleton instance, creating it if necessary.
    static ProductArchiver* TheArchiver(DDSSubscriber& subscriber,
            std::string topicName, std::string dataDir) {
        if (! _theArchiver)
            _theArchiver = new ProductArchiver(subscriber, topicName, dataDir);
        return _theArchiver;
    }
    // Get the singleton instance or NULL
    static ProductArchiver* TheArchiver() { return _theArchiver; }

    /// Implement DDSReader::notify(), which will be called
    /// whenever new samples are added to the DDSReader available
    /// queue. Process the samples here.
    virtual void notify();

    /// Return the number of bytes written by this archiver.
    /// @return the number of bytes written by this archiver.
    int bytesWritten() const { return _bytesWritten; }

protected:
    ProductArchiver(DDSSubscriber& subscriber, std::string topicName,
            std::string dataDir);
    virtual ~ProductArchiver();
    
private:
    // Pointer to the singleton archiver instance
    static ProductArchiver* _theArchiver;

    // How many bytes have we written?
    int _bytesWritten;
};

#endif /* PRODUCTARCHIVER_H_ */
