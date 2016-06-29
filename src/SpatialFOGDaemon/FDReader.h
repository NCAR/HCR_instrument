/*
 * FDReader.h
 *
 *  Created on: Jun 29, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#ifndef _FDREADER_H_
#define _FDREADER_H_

#include <QtCore/QByteArray>
#include <QtCore/QThread>

/// @brief A Qt class which provides data asynchronously as it becomes available
/// on a given file descriptor.
///
/// The class emits signal newData(QByteArray data) when new data have been
/// read from the file descriptor.
class FDReader: public QThread {
    Q_OBJECT
public:
    /// @brief Construct FDReader to read from the given file descriptor
    ///
    /// The file descriptor inFd must remain open for as long as the FDReader
    /// exists.
    FDReader(int inFd);

    virtual ~FDReader();

    void run();

signals:
    void newData(QByteArray data);

private:
    int _fd;

    // @brief Read available data and emit a newData() signal.
    void _readData();
};

#endif /* _FDREADER_H_ */
