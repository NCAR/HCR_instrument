/*
 * FDReader.h
 *
 *  Created on: Jun 29, 2016
 *      Author: Chris Burghart <burghart@ucar.edu>
 */

#ifndef _FDREADER_H_
#define _FDREADER_H_

#include <QByteArray>
#include <QThread>
#include <QTimer>

/// @brief A Qt class which provides data asynchronously as it becomes available
/// on a given file descriptor.
///
/// The class emits signal newData(QByteArray data) when new data have been
/// read from the file descriptor.
class FDReader: public QObject {
    Q_OBJECT
    QThread _workerThread;
public:
    /// @brief Construct FDReader to read from the given file descriptor
    ///
    /// The file descriptor inFd must remain open for as long as the FDReader
    /// exists.
    FDReader(int inFd);

    virtual ~FDReader();

signals:
    void newData(QByteArray data);

};

/// @brief Worker class to do the real work
class FDReaderWorker : public QObject {
    Q_OBJECT
public:
    FDReaderWorker(int fd, QThread * workerThread);

signals:
    void newData(QByteArray data);

private slots:
    /// @brief Try to read new data (waiting briefly if necessary). Emit
    /// finished(QByteArray data) signal if anything was read.
    ///
    /// This slot is first called when the worker thread is started, and on
    /// the first call a zero-length QTimer will be created to call the
    /// slot again whenever the worker thread is not otherwise busy.
    void _tryToRead();

private:
    int _fd;
    QThread * _workerThread;
    QTimer * _runWhenFreeTimer;

    // @brief Read available data and emit a finished() signal with the new
    // data.
    void _readData();
};

#endif /* _FDREADER_H_ */
