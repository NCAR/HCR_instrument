/*
 * Cmigits.h
 *
 *  Created on: Jan 7, 2011
 *      Author: burghart
 */

#ifndef CMIGITS_H_
#define CMIGITS_H_

#include <string>
#include <stdint.h>
#include <QMutex>
#include <QObject>
#include <QThread>


class Cmigits : public QObject {
    Q_OBJECT
public:
    /**
     * @brief Construct a Cmigits providing access to the C-MIGITS III on 
     * the given serial port.
     * 
     * If special serial port name Cmigits::SIM_DEVICE
     * is used, existence of the C-MIGITS will be simulated.
     * @param ttyDev the name of the serial port connected to the C-MIGITS.
     */
    Cmigits(std::string ttyDev);
    virtual ~Cmigits();
    
    /**
     * Device name to use when creating a simulation Cmigits.
     */
    static const std::string SIM_DEVICE;
    
signals:
    /// Signal emitted when GPS validity changes
    /// @param newValue boolean telling the new state of GPS validity
    void gpsValidChanged(bool newValue);
    /// Signal emitted when INS validity changes
    /// @param newValue boolean telling the new state of INS validity
    void insValidChanged(bool newValue);
    /// Signal emitted when _doRead() is finished. This signal is intended
    /// for internal use by the class.
    void _readDone();
private slots:
    /**
     * Read from the serial line until we get a complete message or we time out.
     * Emit a _readDone() signal when finished.
     */
    void _doRead();
private:
    /**
     * C-MIGITS III message sync word
     */
    static const uint16_t _MESSAGE_SYNC_WORD = 0x81ff;

    /// @brief Open and configure our tty connection to the C-MIGITS
    void _openTty();
    
    /// @brief Process data in the _rawData array
    void _processRawData();
    
    /// @brief Process a C-MIGITS message. The message header checksum and
    /// data checksum should already be verified.
    /// @param msgWords pointer to the words of the message
    /// @param nMsgWords number of 16-bit words in msgWords
    void _processCmigitsMessage(const uint16_t * msgWords, 
            uint16_t nMsgWords);
    /// @brief Process a C-MIGITS header-only message (Message Acknowledgment/
    /// Acceptance).
    /// @param msgWords pointer to the words of the header-only message.
    /// The msgWords parameter must point to at least 5 words of valid data.
    void _processHeaderOnlyMessage(const uint16_t * msgWords);
    
    /// @brief Process a C-MIGITS 3500 message (System Status).
    /// @param msgWords pointer to the words of the 3500 message
    /// @param nMsgWords the number of words in the 3500 message
    void _process3500Message(const uint16_t * msgWords, uint16_t nMsgWords);
    
    /// @brief Process a C-MIGITS 3501 message (Navigation Solution).
    /// @param msgWords pointer to the words of the 3501 message
    /// @param nMsgWords the number of words in the 3501 message
    void _process3501Message(const uint16_t * msgWords, uint16_t nMsgWords);
    
    /// @brief Process a C-MIGITS 3623 message (Jupiter GPS Timemark).
    /// @param msgWords pointer to the words of the 3623 message
    /// @param nMsgWords the number of words in the 3623 message
    void _process3623Message(const uint16_t * msgWords, uint16_t nMsgWords);
    
    /**
     * @brief Start automatic mode sequencing. This causes the CMIGITS-III
     * to "find itself", sequencing through alignment into navigation mode.
     */
    void _initialize();

    /// Calculate the C-MIGITS checksum for a given series of words
    /// @param words pointer to the array of words to be checksummed
    /// @param nwords number of words to include in the checksum
    static uint16_t _CmigitsChecksum(uint16_t * words, int nwords);
    
    /// @brief Unpack a C-MIGITS 32-bit floating point value.
    ///
    /// The packed value is 32 bits, stored in little-endian byte order, with
    /// sign in the most significant bit, and the remaining bits are a 
    /// scaled value representing 31 bits to the right of a decimal point.
    /// The final value is calculated by multiplying this scaled value by
    /// 2^binaryScaling.
    /// @param words pointer to the 32-bit data
    /// @param binaryScaling the binary scaling to be used in unpacking
    static float _UnpackFloat32(const uint16_t * words, uint16_t binaryScaling);

    /// @brief Pack a floating point value into C-MIGITS 32-bit floating point
    /// representation
    /// at the given destination using the given binary scaling factor.
    /// @param dest pointer to the destination for the packed value. This must
    /// point to 4 writable bytes.
    /// @param value the floating point value to be packed
    /// @param binaryScaling the binary scaling factor to be used in packing
    static void _PackFloat32(void * dest, float value, uint16_t binaryScaling);
    /// Are we simulating?
    bool _simulate;
    
    /// Our serial port device name (may be SIM_DEVICE)
    std::string _ttyDev;
    
    /// File descriptor for the open serial port
    int _fd;
    
    /// Have we sent an initialization message to the C-MIGITS yet?
    bool _initialized;

    /// C-MIGITS header is 5 words long
    static const uint16_t _CMIGITS_HDR_LEN_WORDS = 5;
    static const uint16_t _CMIGITS_HDR_LEN_BYTES = 2 * _CMIGITS_HDR_LEN_WORDS;
    
    /// Maximum C-MIGITS message length: 10-word header + maximum 128 data
    /// words + 1-word data checksum = 139 words = 278 bytes.
    static const uint16_t _CMIGITS_MAX_MSG_LEN_BYTES = 278;
    
    /// Data read but not yet processed
    uint8_t _rawData[_CMIGITS_MAX_MSG_LEN_BYTES];
    uint16_t _nRawBytes;
    
    /// How many bytes have we skipped so far looking for _MESSAGE_SYNC_WORD?
    uint32_t _nSkippedForSync;
    
    /// Size of current incoming message
    uint16_t _curMsgLenBytes;
    
    /// Message ID for current incoming message
    uint16_t _curMsgId;
    
    /// Number of 16-bit data words in the current incoming message
    uint16_t _curMsgDataLenWords;
    
    /// Thread where we'll do all the real work
    QThread _myThread;
    
    /// Mutex for thread safety when reading/writing members
    QMutex _mutex;
    
    /// Current operating mode.
    /// 1 = Test
    /// 2 = Initialization
    /// 3 = (Unused)
    /// 4 = Fine Alignment
    /// 5 = Air Alignment
    /// 6 = Transfer Alignment
    /// 7 = Air Navigation
    /// 8 = Land Navigation
    /// 9 = GPS Only
    uint16_t _currentMode;

    /// Does the C-MIGITS have GPS time and at least 4 satellites tracked?
    bool _gpsValid;
    
    /// Is the C-MIGITS getting INS sensor data?
    bool _insValid;
    
    /// Number of GPS satellites currently tracked
    uint16_t _nSatsTracked;
    
    /// Expected horizontal position error, m
    float _hPosError;
    
    /// Expected vertical position error, m
    float _vPosError;
    
    /// Expected velocity error, m/s
    float _velocityError;
};

#endif /* CMIGITS_H_ */
