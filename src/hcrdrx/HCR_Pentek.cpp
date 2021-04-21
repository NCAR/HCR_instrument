// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
// ** Copyright UCAR (c) 2018-2021
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

// HCR_Pentek.cpp
//
//  Created on: Apr 3, 2018
//      Author: Chris Burghart <burghart@ucar.edu>

#include <cstdio>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <memory>
#include <regex>
#include <sstream>
#include <string>
#include <unistd.h>
#include <boost/algorithm/string.hpp>   // for boost::trim()
#include <sys/syscall.h>

#include <QtCore/QDateTime>
#include <QtCore/QMetaType>

#include <logx/Logging.h>

#include "HCR_Pentek.h"
#include "ChannelPulseData.h"

#include <toolsa/pmu.h> // procmap registration

LOGGING("HCR_Pentek")

// 32-bit all-ones bitmask
static const uint32_t ALL_32_BITS = 0xffffffffUL;

// Create referenceable instances for our constexpr values
constexpr double HCR_Pentek::BASE_FREQUENCY;
constexpr double HCR_Pentek::REF_FREQUENCY;

HCR_Pentek::HCR_Pentek(const HCR_Config & config,
                         uint boardNum,
                         IwrfPublisher * longPublisher,
                         IwrfPublisher * shortPublisher) :
    QObject(),
    Pentek_xx821(boardNum),
    _controller(*this, CONTROLLER_BASE),
    _config(config),
    _radarStartSecond(0),
    _dmaPacketsDropped(_adcCount),
    _ddcEnable(true),
    _longPublisher(longPublisher),
    _shortPublisher(shortPublisher),
    _prevDmaPacketNum(_adcCount, -1),
    _nDroppedBeforeStartSig(_adcCount, 0),
    _unprocessedDma(_adcCount, 0),
    _maxUnprocessedDma(_adcCount, 0),    
    _consoleNotifier(STDIN_FILENO, QSocketNotifier::Read)    
{
    // Register needed types
    qRegisterMetaType<int32_t>("int32_t");
    qRegisterMetaType<QSharedPointer<uint8_t> >("QSharedPointer<uint8_t>");
    qRegisterMetaType<QSharedPointer<NAV_DMA_ADC_META_DATA> >("QSharedPointer<NAV_DMA_ADC_META_DATA>");

    PMU_auto_register("HCR_Pentek constructor");

    // Connect our newAdcData() signal to our _acceptAdcData() slot. This
    // may seem strange, but it's how we move data from the top-half interrupt
    // handling in AdcDmaCallbackHandler (which runs in a Navigator DMA thread)
    // to bottom-half handling (which occurs in this object's home thread).
    connect(this,
            SIGNAL(newAdcData(int32_t, int32_t, QSharedPointer<uint8_t> const,
                   QSharedPointer<NAV_DMA_ADC_META_DATA> const)),
            this,
            SLOT(_acceptAdcData(int32_t, int32_t, QSharedPointer<uint8_t> const,
                 QSharedPointer<NAV_DMA_ADC_META_DATA> const)));

    // Connect our adcDmaOverrun() signal to our _dmaOverrunHandler() slot.
    // Similar to above, this means that the handler will run in *our* thread
    // rather than in the Navigator DMA thread. This is important because we
    // cannot call NAV_DmaStop() or NAV_DmaStart() from within a Navigator DMA
    // thread.
    connect(this, SIGNAL(adcDmaOverrun(int32_t)),
            this, SLOT(_dmaOverrunHandler(int32_t)));

    // Connect our adcDmaTimeout() signal to our _dmaTimeoutHandler() slot.
    // Similar to above, this means that the handler will run in *our* thread
    // rather than in the Navigator DMA thread. This is important because we
    // cannot call NAV_DmaStop() or NAV_DmaStart() from within a Navigator DMA
    // thread.
    connect(this, SIGNAL(adcDmaTimeout(int32_t)),
            this, SLOT(_dmaTimeoutHandler(int32_t)));

    // The _consoleNotifier emits its activated() signal each time a
    // newline is seen on stdin. If we're firing a single element, we use that
    // signal to increment the number of the element to fire
    //connect(&_consoleNotifier, SIGNAL(activated(int)),
    //        this, SLOT(_incFiringElement()));

    // Verify that we're running HCR firmware. The Board Info "User Word"
    // register in HCR firmware should contain "HCRX" in ASCII characters.
    int32_t status;
    uint32_t userWord;
    status = NAVip_BrdInfoRegs_UserWordStat_GetUserWord(_boardInfoRegBase(),
                                                        &userWord);
    if (status != NAV_STAT_OK) {
        std::ostringstream os;
        os << "HCR_Pentek GetUserWord error: " << NavApiStatus[status];
        _AbortConstruction(os.str());
    }

    char aparChars[] = "HCRX";
    uint32_t aparCharsIntVal =
        *(reinterpret_cast<uint32_t*>(aparChars));
    if (aparCharsIntVal != userWord) {
        std::ostringstream os;
        os << "Expected 'HCRX' (0x" << std::hex << aparCharsIntVal <<
              ") in the board's user word, but found 0x" << userWord;
        _AbortConstruction(os.str());
    }

    // Low-level Navigator board setup (bus, clock, sync, gate, PPS source)
    _setupBoard();

    // ADCs
    _setupAdc();

    // DDCs
    _setupDdc();

    // Transmit chain: DAC, DUC, and waveforms
    _setupTx();
    
    // Radar controller
    _setupController();

    // Start the radar
    _startRadar();
}

void
HCR_Pentek::_startRadar() {
    int32_t status;

    PMU_auto_register("HCR_Pentek::_startRadar()");

    // Get the current system time
    // TODO: check that an NTP client is running, and query it to verify that
    // our system clock offset is small (must be < 0.5 s)
    struct timespec nowTimespec;
    clock_gettime(CLOCK_REALTIME, &nowTimespec);

    // Calculate sleep time until the next mid-second mark. Radar "start second"
    // will be the second in which we awaken and zero the Pentek's PPS counter.
    uint32_t nowUsecs = nowTimespec.tv_nsec / 1000;
    int32_t sleepUsecs;
    if (nowUsecs <= 500000) {
        _radarStartSecond = nowTimespec.tv_sec;
        sleepUsecs = 500000 - nowUsecs;
    } else {
        _radarStartSecond = nowTimespec.tv_sec + 1;
        sleepUsecs = 1500000 - nowUsecs;
    }

    // Sleep until the next mid-second mark
    DLOG << "Sleeping " << sleepUsecs << " us before zeroing the Pentek PPS count";
    usleep(sleepUsecs);

    // Zero the Pentek's PPS counter
    status = NAV_TimestampGenSetup(_boardHandle, 0);
    _AbortCtorOnNavStatusError(status, "NAV_TimestampGenSetup");

    // Open the global gates to start ADC and DAC data flow
    status = NAV_GlobalGateOpen(_boardHandle, NAV_CHANNEL_TYPE_ADC);
    _AbortCtorOnNavStatusError(status, "ADC NAV_GlobalGateOpen");

    status = NAV_GlobalGateOpen(_boardHandle, NAV_CHANNEL_TYPE_DAC);
    _AbortCtorOnNavStatusError(status, "DAC NAV_GlobalGateOpen");

    // Start the radar controller
    _controller.run(0,                              // sequenceStartIndex,
                    _pulseDefinitions.size(),       // sequenceLength,
                    DDC_DECIMATION,                 // decimation,
                    10,                             // numPulsesPerXfer,
                    0x7,                            // enabledChannelVector,
                    Controller::INFINITE_PULSES );  // numPulsesToExecute

    // Uncomment for testing without external PPS source
    //usleep(1000);
    //writeLiteRegister_(BLOCK2_GPR_BASE+4, 1, "Fake PPS");
    //writeLiteRegister_(BLOCK2_GPR_BASE+4, 0, "Fake PPS");

    ILOG << "Pentek start time: " << QDateTime::fromTime_t(_radarStartSecond)
                       .toString("yyyy-MM-dd hh:mm:ss").toStdString();

}

HCR_Pentek::~HCR_Pentek() {

    // Shut down Navigator
    int32_t status;

    // Close the global gates
    status = NAV_GlobalGateClose(_boardHandle, NAV_CHANNEL_TYPE_ADC);
    _LogNavigatorError(status, "ADC NAV_GlobalGateClose");

    status = NAV_GlobalGateClose(_boardHandle, NAV_CHANNEL_TYPE_DAC);
    _LogNavigatorError(status, "DAC NAV_GlobalGateClose");

    // For each ADC: disarm and clear trigger, stop the DMA thread, and
    // free DMA resources
    for (int32_t adcChan = 0; adcChan < _adcCount; adcChan++) {
        std::string adcPrefix = std::string("ADC chan ") + std::to_string(adcChan) + " ";

        status = NAV_TrigDisarm(_boardHandle, NAV_CHANNEL_TYPE_ADC, adcChan);
        _LogNavigatorError(status, adcPrefix + "NAV_TrigDisarm");

        status = NAV_TrigClear(_boardHandle, NAV_CHANNEL_TYPE_ADC, adcChan);
        _LogNavigatorError(status, adcPrefix + "NAV_TrigClear");

        // Sleep briefly in hopes of reading any remaining ADC data
        usleep(10000);  // 0.01 s

        // Clean up DMA stuff
        status = NAV_DmaStop(_boardHandle, NAV_CHANNEL_TYPE_ADC, adcChan);
        _LogNavigatorError(status, adcPrefix + "NAV_DmaStop");

        status = NAV_DmaCleanup(_boardHandle, NAV_CHANNEL_TYPE_ADC, adcChan);
        _LogNavigatorError(status, adcPrefix + "NAV_DmaCleanup");
    }

    // For the one DAC chip: disarm and clear trigger
    int dacChip = 0;
    std::string dacPrefix = std::string("DAC chip ") + std::to_string(dacChip) + " ";

    status = NAV_TrigDisarm(_boardHandle, NAV_CHANNEL_TYPE_DAC, dacChip);
    _LogNavigatorError(status, dacPrefix + "NAV_TrigDisarm");

    status = NAV_TrigClear(_boardHandle, NAV_CHANNEL_TYPE_DAC, dacChip);
    _LogNavigatorError(status, dacPrefix + "NAV_TrigClear");

    // Disable interrupts  for clock loss events
    status = NAV_InterruptDisable(_boardHandle, NAV_INTR_DATA_IO_CLOCK_A, 0);
    status = NAV_InterruptDisable(_boardHandle, NAV_INTR_DATA_IO_CLOCK_B, 0);
}

void
HCR_Pentek::ReadFilterCoefsFromFile(std::string filename,
                                     std::vector<double> & coefs) {

    PMU_auto_register("HCR_Pentek::ReadFilterCoefsFromFile()");

    // Load the filter coefficients. Each line in the coefficients file should
    // have one integer coefficient value.
    //
    // Blank lines are ignored and '#' and any trailing characters on a line
    // are treated as comments.
    std::ifstream ifs(filename);
    if (ifs.fail()) {
        std::ostringstream os;
        os << "Failed to open filter file '" << filename << "'";
        throw(std::runtime_error(os.str()));
    }

    std::string line;
    int lineNum = 0;
    while (std::getline(ifs, line)) {
        lineNum++;

        // Remove comments: strip anything from the line including and
        // after the first '#'
        std::string content = line.substr(0, line.find_first_of('#'));

        // Trim leading and trailing whitespace from the remaining content
        boost::trim(content);

        // If nothing is left, move to the next line
        if (content.size() == 0) {
            continue;
        }

        // Parse the coefficient from the content.
        double coef;
        char remainder[2];
        int nread = sscanf(content.c_str(), "%lf%1s", &coef, remainder);
        if (nread == 1) {
            // Success! We get here only if we parsed one integer value and no
            // extra character after that.
            coefs.push_back(coef);
        } else {
            // We get here if we did not parse two integers or if content
            // continued beyond the parsed integers.
            std::ostringstream os;
            os << "Filter file " << filename << ": bad line " <<
                  lineNum << ": '" << line << "'";
            throw(std::runtime_error(os.str()));
        }

        if (ifs.eof()) {
            ILOG << "filter file EOF";
            break;
        }
    }
}

void
HCR_Pentek::_setupBoard() const {
    int32_t status;

    // Set up the bus
    status = NAV_BusSetup(_boardHandle,
                          NAV_BUS_MSTR_STAND_ALONE,     // bus A (ADC/DDC) mode
                          NAV_BUS_MSTR_STAND_ALONE);    // bus B (DAC/DUC) mode
    _AbortCtorOnNavStatusError(status, "NAV_BusSetup");

    // Set up the board, ADC, and DAC clocks
    // Log clock settings which will be changed
    _logClockConfigDiffs();
    status = NAV_ClockSetup(_boardHandle,                        // void    *boardHandle,
                            _config.use_internal_clock() ?       // int32_t  boardClockSource,
                               NAV_CLOCK_INT : NAV_CLOCK_EXT,    
                            boardClockFrequency(),               // double   boardClockFreq,
                            REF_FREQUENCY,                       // double   extRefClockFreq,
                            adcFrequency(),                      // double   clockAFreq,
                            dacFrequency(),                      // double   clockBFreq,
                            1.0e6,                               // double   adcTestSigFreq,
                            1.0e6,                               // double   dacTestSigFreq,
                            NAV_OPTIONS_NONE);                   // uint64_t options
    _AbortCtorOnNavStatusError(status, "NAV_ClockSetup");

    // Set up the sync buses
    status = NAV_SyncSetup(_boardHandle,
                           NAV_SYNC_SRC_REG,            // syncASource (ADC/DDC)
                           NAV_SYNC_POL_NORMAL,         // syncAPolarity (ADC/DDC)
                           NAV_SYNC_SRC_REG,            // syncBSource (DAC/DUC)
                           NAV_SYNC_POL_NORMAL,         // syncBPolarity (DAC/DUC)
                           NAV_OPTIONS_NONE);           // options
    _AbortCtorOnNavStatusError(status, "NAV_SyncSetup");

    status = NAV_GateSetup(_boardHandle,
                           NAV_GATE_SRC_REG,            // gateASource (ADC)
                           NAV_GATE_POL_NORMAL,         // gateAPolarity (ADC)
                           NAV_GATE_SRC_REG,            // gateBSource (DAC)
                           NAV_GATE_POL_NORMAL,         // gateBPolarity (DAC)
                           NAV_OPTIONS_NONE);           // options
    _AbortCtorOnNavStatusError(status, "NAV_GateSetup");

    //Note: PPS source SYNC_SBUS_TTL has been rerouted to P14 (GPIO) in the firmware
    status = NAV_PpsRcvSourceSetup(_boardHandle,
                                   NAV_PPS_SRC_SYNC_SBUS_TTL,      // busA PPS source
                                   NAV_PPS_POL_NORMAL,             // busA PPS polarity
                                   NAV_PPS_SRC_SYNC_SBUS_TTL,      // busB PPS source
                                   NAV_PPS_POL_NORMAL);            // busB PPS polarity
    _AbortCtorOnNavStatusError(status, "NAV_PpsRcvSourceSetup");

//    // TODO - handle "clock lost" interrupt
//    status = NAV_InterruptEnable(boardHandle,
//                                 NAV_INTR_DATA_IO_CLOCK_A, 0,
//                                 NAV_IP_CDC_CLK_INTRFC_INTR_CLK_NOT_OK,
//                                 &clockLostIntrHandler, NULL);

    //Toggle the (negative-polarity) reset for user block 2
    writeLiteRegister_(BLOCK2_GPR_BASE, 0, "Resetting user block 2");
    writeLiteRegister_(BLOCK2_GPR_BASE, 1, "Resetting user block 2");

}

void
HCR_Pentek::_setupAdc() {
    int32_t status;

    PMU_auto_register("HCR_Pentek::_setupAdc()");

    // Set up the ADC channels
    for (int32_t adcChan = 0; adcChan < _adcCount; adcChan++) {
        // Build a prefix string of the form "ADC chan <chanNum> "
        std::string adcPrefix =
                std::string("ADC chan ") + std::to_string(adcChan) + " ";

        // ADC channel setup
        int32_t adcDataFormat;
        if (_ddcEnable) {
            adcDataFormat = NAV_ADC_FORMAT_16BIT_IQ_PACKED;
        }
        else {
            adcDataFormat = NAV_ADC_FORMAT_16BIT_REAL_PACKED;
        }

        status = NAV_AdcSetup(_boardHandle,
                              adcChan,
                              NAV_CHAN_OWN_ADC,
                              adcDataFormat,
                              NAV_OPTIONS_NONE);
        _AbortCtorOnNavStatusError(status, "NAV_AdcSetup");

        status = NAV_GateTrigModeSetup(_boardHandle,
                                       NAV_CHANNEL_TYPE_ADC,
                                       adcChan,
                                       NAV_GATE_TRIG_MODE_GLOBAL_GATE,
                                       NAV_GATE_TRIG_MODE_CTRL_STAY_ARM_ACTIVE);
        _AbortCtorOnNavStatusError(status, adcPrefix + "NAV_GateTrigModeSetup");

        // Create a DMA reader thread for the ADC which will call the static
        // AdcDmaCallbackHandler method to deliver DMA data. We pass a pointer
        // to this HCR_Pentek instance as the user data for each callback.
        status = NAV_DmaSetup(_boardHandle,
                              NAV_CHANNEL_TYPE_ADC,     // channel type
                              adcChan,                  // channel number
                              1024,                     // number of xfer buffers to allocate
                              32768,                    // buffer size in bytes
                              NAV_DMA_METADATA_ENABLE,  // enable metadata
                              NAV_DMA_RUN_MODE_CONTINUOUS_LOOP, // continuous sampling
                              NAV_SYS_WAIT_STATE_MILSEC(1000),  // DMA timeout, ms
                              AdcDmaCallbackHandler,
                              this,
                              NAV_OPTIONS_NONE);
        _AbortCtorOnNavStatusError(status, adcPrefix + "NAV_DmaSetup");

        // Start the DMA thread for the ADC channel
        status = NAV_DmaStart(_boardHandle, NAV_CHANNEL_TYPE_ADC, adcChan);
        _AbortCtorOnNavStatusError(status, adcPrefix + "NAV_DmaStart");

        // After the first call to NAV_DmaStart, we can set the CPU affinity
        // of the newly created DMA IRQ. We bind to a single dedicated
        // processor, since that allows WinDriver to support higher interrupt
        // rates without suffering from DMA overruns.
        //
        // The setWinDriverIrqAffinity program must be owned by root, and
        // must have the setuid permission bit set.
        if (adcChan == 0) {
            ILOG << "Setting CPU affinity the new DMA IRQ";

            // Set up the setWinDriverIrqAffinity command
            std::ostringstream oss;
            int irqCpu = 29;    // Fixed affinity at CPU 29 (for now)
            oss << "./setWinDriverIrqAffinity " << std::to_string(irqCpu) <<
                   " 2>&1";
            ILOG << "Command: " << oss.str();

            // Open a pipe executing the command
            FILE * pipe = popen(oss.str().c_str(), "r");
            if (pipe) {
                // Read and log the output
                ILOG << "Output: ";
                char line[128];
                while (fgets(line, sizeof(line), pipe)) {
                    // Trim trailing newline
                    line[strlen(line) - 1] = '\0';
                    ILOG << "    " << line;
                }
                // Get command status from pclose, and warn if the command
                // failed
                int cmdStatus = pclose(pipe);
                if (cmdStatus == 0) {
                    ILOG << "IRQ affinity is set";
                } else {
                    WLOG << "XXXXXXXXXXXXXXXXXXXXXXXXX";
                    WLOG << "";
                    WLOG << "Failed to set WinDriver IRQ CPU affinity";
                    WLOG << "DMA overruns are likely!";
                    WLOG << "";
                    WLOG << "XXXXXXXXXXXXXXXXXXXXXXXXX";
                }
            }
        }

        // Arm the dataflow control core
        //
        // This must be done after starting up the DMA core but before a
        // gate/trigger event occurs.
        status = NAV_TrigArm(_boardHandle, NAV_CHANNEL_TYPE_ADC, adcChan);
        _AbortCtorOnNavStatusError(status, adcPrefix + "NAV_TrigArm");

        _dmaPacketsDropped[adcChan] = 0;
    }

}

void
HCR_Pentek::_setupDdc() {
    int32_t status;

    PMU_auto_register("HCR_Pentek::_setupDdc()");

    // Set up our DDCs
    if (_ddcEnable) {
        for (int32_t ddcNum = 0; ddcNum < _ddcCount; ddcNum++) {
            // Build a prefix string of the form "DDC chan <chanNum> "
            std::string ddcPrefix =
                    std::string("DDC chan ") + std::to_string(ddcNum) + " ";

            // Initialize the DDC associated with this ADC
            status = NAV_DdcSetup(_boardHandle,
                                  ddcNum,
                                  DDC_DECIMATION,
                                  _config.rx_frequency(),
                                  NAV_DDC_PACKMODE_PACKED,
                                  NAV_DDC_SPECTRUM_INVERT_DISABLE,
                                  NAV_DDC_SPECTRUM_OFFSET_DISABLE,
                                  NAV_OPTIONS_NONE);
            if (status == NAV_STAT_DDC_INVALID_FILTER_FILE) {
                ELOG << "*** DDC filter files not found ***";
                ELOG << "***";
                ELOG << "*** Navigator v2.4 requires that environment variable";
                ELOG << "*** NAVBSP is set in order to find them. Make sure";
                ELOG << "*** it's set and refers to a valid Navigator BSP";
                ELOG << "*** directory.";
            }
            _AbortCtorOnNavStatusError(status, ddcPrefix + "NAV_DdcSetup");

            // Set the DDC to wait for a sync
            status = NAV_SetDdcSyncState(_boardHandle,
                    ddcNum,
                    NAV_DDC_SYNC_STATE_ENABLE);
            _AbortCtorOnNavStatusError(status, ddcPrefix + "NAV_SetDdcSyncState");

        }
    }
}

void
HCR_Pentek::_setupTx() {
    int32_t status;

    PMU_auto_register("HCR_Pentek::_setupTx()");

    // APAR DAC set up. The Pentek 78821 board has one DAC5688 dual-channel
    // chip. We configure the DAC chip via NAV_DacSetup(), which in its
    // documentation uses the term "channel" to refer to the DAC *chip* index,
    // which for this board can only be 0. However, we can then "channel-pack"
    // the two output waveforms sent to the chip to get two separate
    // transmit waveforms.
    int dacChip = 0;
    std::string dacPrefix =
            std::string("DAC chip ") + std::to_string(dacChip) + " ";
    status = NAV_DacSetup(_boardHandle,
                          dacChip,
                          NAV_BRD_RAM,
                          NAV_DAC_FORMAT_16BIT_COMPLEX_IQ_PACKED,
                          NAV_DAC_OPTION_NONE);
    _AbortCtorOnNavStatusError(status, dacPrefix + "NAV_DacSetup");

    status = NAV_GateTrigModeSetup(_boardHandle,
                                   NAV_CHANNEL_TYPE_BRD_RAM,
                                   dacChip,
                                   NAV_GATE_TRIG_MODE_GLOBAL_GATE,
                                   NAV_GATE_TRIG_MODE_CTRL_STAY_ARM_ACTIVE);
    _AbortCtorOnNavStatusError(status, dacPrefix + "NAV_GateTrigModeSetup");

    status = NAV_TrigArm(_boardHandle, NAV_CHANNEL_TYPE_BRD_RAM, dacChip);
    _AbortCtorOnNavStatusError(status, dacPrefix + "NAV_TrigArm");

    // Set up the DUC
    uint32_t ducInterpolation = _config.duc_interpolation();
    if (ducInterpolation != 1 && ducInterpolation != 2 && ducInterpolation != 4)
    {
        _AbortConstruction("Invalid DUC interpolation. Valid values 1, 2, 4");
    }

    if (ducInterpolation > 1) {
        status = NAV_DucSetup(_boardHandle,
                              dacChip,                  // channel
                              ducInterpolation,         // interpolation
                              _config.tx_frequency(),   // center frequency
                              NAV_DUC_PACKMODE_PACKED,  // packing mode
                              NAV_DUC_SPECTRUM_INVERT_DISABLE,  // invert spectrum?
                              NAV_DUC_OPTION_NONE);
        _AbortCtorOnNavStatusError(status, dacPrefix + "NAV_DucSetup");
    }

    // Set the DUC to wait for a sync
    status = NAV_SetDucSyncState(_boardHandle,
                                 dacChip,
                                 NAV_DUC_SYNC_STATE_ENABLE);

//    // Write the packed transmit waveforms to the RAM memory used by the
//    // descriptor created above.
//    status = NAV_RamWrite(_boardHandle, NAV_RAM_ACCESS_MODE_DMA, 0,
//                          waveTableLen, packedTxData);
//    _AbortCtorOnNavStatusError(status, dacPrefix + "waveform NAV_RamWrite");
//
//
//    // Construct a single waveform generator descriptor which loops back to itself.
//    status = NAV_DacWaveGenSetDescriptor(_boardHandle,
//                                         dacChip,       // channel
//                                         0,             // descriptorIndex
//                                         0,             // trigDelay
//                                         1024,          // trigLength (in words)
//                                         0,             // ramStartAddr (in bytes)
//                                         4 * 1024,      // ramEndAddr (in bytes)
//                                         0,             // nextDescriptorIndex
//                                         NAV_DISABLE,   // enableLinkStartIntr
//                                         NAV_ENABLE,    // enableLinkEndIntr
//                                         NAV_DISABLE);  // enableDisarmMode
//    _AbortCtorOnNavStatusError(status, dacPrefix + "NAV_DacWaveGenSetDescriptor");
//
//    status = NAV_DacWaveGenActivateDescriptor(_boardHandle, dacChip, 0);
//    _AbortCtorOnNavStatusError(status, dacPrefix + "NAV_DacWaveGenActivateDescriptor");

}

std::string
HCR_Pentek::boardInfoString() const {
    std::ostringstream os;

    // Start with the base class info
    os << Pentek_xx821::boardInfoString();

    // Add HCR_Pentek header
    os << "    HCR_Pentek" << std::endl;

    // The rev date register holds the APAR firmware revision date in the form
    // 0xYYMMDD (21st century is assumed)
    uint32_t revDate;
    uint32_t revHour;
    NAVip_BrdInfoRegs_FpgaRevDateStat_GetRevDate(_boardInfoRegBase(),
                                                 &revDate);

    // The rev num register holds the revision hour in the form 0xHH
    NAVip_BrdInfoRegs_FpgaRevStat_GetRevNum(_boardInfoRegBase(),
                                            &revHour);

    // Log the firmware rev date and hour
    os << "        APAR firmware rev date/time: 20" << std::hex << revDate <<
          " " << revHour << ":00" << std::endl;
    return(os.str());
}

void
HCR_Pentek::_logClockConfigDiffs() const {
    NAV_CLOCK_SELECT currClockConfig =
            _boardResource()->boardParams.clockSelect;

    int32_t aparClockSource = _config.use_internal_clock() ? NAV_CLOCK_INT : NAV_CLOCK_EXT;
    if (currClockConfig.boardClockSource != aparClockSource) {
        ILOG << "Changing board clock source from " <<
                currClockConfig.boardClockSource << " to " << aparClockSource;
    }

    if (currClockConfig.boardClockFreq != boardClockFrequency()) {
        ILOG << "Changing board clock frequency from " <<
                currClockConfig.boardClockFreq * 1.0e-6 << " MHz to " <<
                boardClockFrequency() * 1.0e-6 << " MHz";
    }

    if (currClockConfig.extRefClockFreq != REF_FREQUENCY) {
        ILOG << "Changing reference frequency from " <<
                currClockConfig.extRefClockFreq * 1.0e-6 << " MHz to " <<
                REF_FREQUENCY * 1.0e-6 << " MHz";
    }

    if (currClockConfig.options != NAV_OPTIONS_NONE) {
        ILOG << "Changing clock options from " <<
                currClockConfig.options << " to " << NAV_OPTIONS_NONE;
    }
}

void
HCR_Pentek::_acceptAdcData(int32_t chan,
                            int32_t dmaStatus,
                            QSharedPointer<uint8_t> const dataPtr,
                            QSharedPointer<NAV_DMA_ADC_META_DATA> const metadataPtr)

{
    const uint8_t* dataBuf(dataPtr.data());
    const NAV_DMA_ADC_META_DATA * metadata(metadataPtr.data());
    size_t clockOffsetCount = 0;
    size_t dataBufOffsetBytes = 0;
    bool lastPulseInXfer = false;
    using IQData = std::complex<int16_t>;

    if (! _checkDmaMetadata(chan, metadata)) {
        return;
    }

    //Process all the pulses in the data.
    for(size_t numPulsesProcessed=0; !lastPulseInXfer; ++numPulsesProcessed)
    {

        // Check the size of the buffer
        if(dataBufOffsetBytes+sizeof(Controller::PulseHeader) > metadata->validBytes) {
            ELOG << "Truncated pulse block chan " << std::dec << chan 
                 << " after pulse " << numPulsesProcessed;
            return;
        }

        // Extract the pulse header
        const Controller::PulseHeader& pulseHeader = *reinterpret_cast<const Controller::PulseHeader*>(dataBuf+dataBufOffsetBytes);
        dataBufOffsetBytes += sizeof(Controller::PulseHeader);
        
        if(pulseHeader.magic != Controller::HEADER_MAGIC) {
            ELOG << "Bad header magic 0x" << std::hex << pulseHeader.magic
                 << "(want ba5eba11) at location 0x" << dataBufOffsetBytes
                 << std::dec << " chan " << chan << " pulse " << numPulsesProcessed;
            return;
        }
        
        if(pulseHeader.pulseDefinitionNumber >= _pulseDefinitions.size()) {
            ELOG << "Bad pulse definition " << pulseHeader.pulseDefinitionNumber
                 << " chan " << chan << " pulse " << numPulsesProcessed;            
            return;
        }
        
        // Lookup the pulse definition
        const Controller::PulseDefinition& pulseDef = _pulseDefinitions[pulseHeader.pulseDefinitionNumber];
        
        // Number of data values
        uint32_t nGates = pulseHeader.numSamples;
        //if(!chan) { 
        //    ILOG << "k " << pulseHeader.pulseDefinitionNumber << " gates " << nGates << " nexg " << (metadata->validBytes-sizeof(Controller::PulseHeader))/4 << " prt " << pulseHeader.prt
        //    << " extra " << 0.25*(metadata->validBytes - (dataBufOffsetBytes + nGates*sizeof(IQData)));
        //}

        // Calculate the timestamp
        time_t dataSec = _radarStartSecond + metadata->timestampPpsCount;    
        uint32_t dataNanosec = (metadata->timestampClockCount + clockOffsetCount) * (1e9/BASE_FREQUENCY);

        // Add the PRT to get the offset for the next pulse
        clockOffsetCount += pulseHeader.prt;
        
        // Add the post-time if applicable
        if(pulseHeader.statusFlags.lastPulseInBlock) {
            clockOffsetCount += pulseDef.blockPostTime;
        }

        // Check if done
        lastPulseInXfer = pulseHeader.statusFlags.lastPulseInXfer;

        // Check the size of the buffer
        if(dataBufOffsetBytes + nGates*sizeof(IQData) > metadata->validBytes) {
            ELOG << "Truncated pulse data chan " << std::dec << chan 
                 << " after pulse " << numPulsesProcessed;
            return;
        }

        // Extract the IQ data
        const IQData* data(reinterpret_cast<const IQData*>(dataBuf+dataBufOffsetBytes));
        dataBufOffsetBytes += nGates*sizeof(IQData);

#warning publish the data
//    // If we have a publisher, send it the new data for collating and publishing.
//    if (_longPublisher) {
//        // Copy the data into a new ChannelPulseData object and get a (smart)
//        // shared_ptr to it. The new object will be automatically deleted when
//        // the last reference to it falls out of scope (i.e., when both
//        // _longPublisher and _shortPublisher are done with it).
//        HCR_Beam beamConfig;
//        std::shared_ptr<ChannelPulseData> chanData =
//                std::make_shared<ChannelPulseData>(chan,
//                                                   0xF00,
//                                                   dataSec,
//                                                   dataNanosec,
//                                                   0xF00,
//                                                   beamConfig,
//                                                   nGates,
//                                                   reinterpret_cast<const int32_t*>(data));
//        switch (chan) {
//        case 0:
//            // Channel 0: long pulse data
//            if (_longPublisher) {
//                _longPublisher->addData(chanData);
//            }
//            break;
//        case 1:
//            // Channel 1: short pulse data
//            if (_shortPublisher) {
//                _shortPublisher->addData(chanData);
//            }
//            break;
//        case 2:
//            // Channel 2: multiplexed burst transmit sample with both long
//            // and short pulse
//            if (_longPublisher) {
//                _longPublisher->addXmitSampleData(chanData);
//            }
//            if (_shortPublisher) {
//                _shortPublisher->addXmitSampleData(chanData);
//            }
//            break;
//        default:
//            ELOG << "Skipping data from unknown channel " << chan;
//        }
//    }
    }
}

bool
HCR_Pentek::_checkDmaMetadata(int chan, const NAV_DMA_ADC_META_DATA * metadata)
{
    // Use the metadata DMA packet counter to check for DMA continuity
    static const int PKTCOUNT_ROLLOVER = 4096;  // 12 bits, rolls @ 4096
    uint32_t pktCount = metadata->packetCounter;

    int nDmaDropped = pktCount - (_prevDmaPacketNum[chan] + 1) % PKTCOUNT_ROLLOVER;
    if (nDmaDropped < 0) {
        nDmaDropped += PKTCOUNT_ROLLOVER;
    }
    _dmaPacketsDropped[chan] += nDmaDropped;
    uint32_t packetNum = _prevDmaPacketNum[chan] + 1 + nDmaDropped;
    if (nDmaDropped != 0) {
        ELOG << "On channel " << chan << ", lost " << nDmaDropped <<
                " DMA packets between " << _prevDmaPacketNum[chan] <<
                " and " << packetNum;
    }

    _prevDmaPacketNum[chan] = packetNum;

    // Drop packets delivered via multiple interrupts, since we don't have
    // an implementation which will assemble them. At this point, we handle
    // interrupts which carry complete packets (i.e., both startOfPacket and
    // endOfPacket will be true in the metadata).
    if (! (metadata->startOfPacket && metadata->endOfPacket)) {
        ELOG << "Chan " << chan << " DMA packet " << packetNum <<
                " is incomplete and implementation will not do multi-packet assembly.";
        std::ostringstream os;
        os << "   (packet contains ";
        if (metadata->startOfPacket) {
            os << "START";
        } else if (metadata->endOfPacket) {
            os << "END";
        } else {
            os << "MID";
        }
        os << " only)";
        ELOG << os.str();

        // We will not use the given metadata
        return(false);
    }
    
    // For publishing, we only handle 16-bit complex (i.e., IQ) data, with I in the first sample.
    //
    // Navigator definitions used on the FPGA side do not agree with the
    // NAV_IP_DMA_PPKT2PCIE_METADATA_* macros on the our side.
    //
    // Here's what we'll actually see:
    //      metaData->dataFormat: 0 = 8-bit, 1 = 16-bit, 2 = 24-bit(?), 3 = 32-bit
    //              ->dataType: 0 = real, 1 = complex (IQ)
    //              ->firstSamplePhase: 0 = I first, 1 = Q first
    if (!(metadata->dataFormat == 1 && metadata->dataType == 1 && metadata->firstSamplePhase == 0)) {
        ELOG << "Chan " << chan <<
                ": data unpublishable w/format: " << metadata->dataFormat <<
                ", type: " << metadata->dataType <<
                ", first sample phase: " << metadata->firstSamplePhase;
        return(false);
    }    

    return(true);
}

void
HCR_Pentek::AdcDmaCallbackHandler(int32_t chan, int32_t dmaStatus,
                                   void *dataBufPtr, void *metaDataBufPtr,
                                   void *userData) {
    // The user data carries a pointer to the associated HCR_Pentek instance
    // for this DMA transfer.
    HCR_Pentek * instance = static_cast<HCR_Pentek *>(userData);

    DLOG << "In AdcDmaCallbackHandler()";
    DLOG << "DMA for board " << instance->_boardNum << " ADC channel " <<
            chan << ", status: 0x" << std::hex << dmaStatus;

    // Note and handle various DMA errors. If any of these errors is true, the
    // metadata and data are invalid, so we return quickly.
    bool dmaError = false;

    if (dmaStatus & NAV_STAT_DMA_OVERRUN) {
        ELOG << "ADC DMA overrun on board " << instance->_boardNum <<
                " chan " << chan;
        if (instance->_unprocessedDma[chan] >= 0) {
            ELOG << "(Last unprocessed DMA count for chan " << chan << ": " <<
                    instance->_unprocessedDma[chan] << ", max seen was: " <<
                    instance->_maxUnprocessedDma[chan] << ")";
            instance->_unprocessedDma[chan] = -1;
        }

        // Now have the associated HCR_Pentek instance emit signal
        // adcDmaOverrun(). This will queue execution of _dmaOverrunHandler in
        // the instance's thread.
        emit(instance->adcDmaOverrun(chan));
        dmaError = true;
    }
    if (dmaStatus & NAV_STAT_DMA_FIFO_CAPPED) {
        ELOG << "ADC DMA FIFO capped on board " << instance->_boardNum <<
                " chan " << chan;
        dmaError = true;
    }
    if (dmaStatus & NAV_STAT_DMA_IPC_ERR) {
        ELOG << "ADC DMA IPC error on board " << instance->_boardNum <<
                " chan " << chan;
        dmaError = true;
    }
    if (dmaStatus & NAV_STAT_DMA_TIMEOUT) {
        std::string adcPrefix = std::string("ADC chan ") +
                std::to_string(chan) + ": ";

        ELOG << "ADC DMA timeout on board " << instance->_boardNum <<
                " chan " << chan;

        // Now have the associated HCR_Pentek instance emit signal
        // adcDmaTimeout(). This will queue execution of _dmaTimeoutHandler in
        // the instance's thread.
        emit(instance->adcDmaTimeout(chan));
        dmaError = true;
    }

    // If any of the errors tested above was true, the metadata and data are
    // invalid, so we can return now.
    if (dmaError) {
        return;
    }

    // Track unprocessed DMA counts
    NAV_DMA_CHAN_PARAMS * dmaChanStats(NULL);
    int32_t status = NAV_DmaGetChannelParams(instance->_boardHandle, chan,
                                             &dmaChanStats);
    if (status == NAV_STAT_OK) {
        int32_t prevUnprocessed = instance->_unprocessedDma[chan];
        int32_t unprocessed = dmaChanStats->unprocessedDmaCaptures;
        instance->_unprocessedDma[chan] = unprocessed;
        if (unprocessed > instance->_maxUnprocessedDma[chan]) {
            instance->_maxUnprocessedDma[chan] = unprocessed;
        }

        // Warn when unprocessed DMA count goes above warnPercent of our
        // buffer count
        int warnPercent = 25;
        int warnCount = (dmaChanStats->numBuffers * warnPercent) / 100;
        if (unprocessed > warnCount && prevUnprocessed <= warnCount) {
            WLOG << "Chan " << chan << " unprocessed DMAs have exceeded " <<
                    warnPercent << "% of buffer count";
        }

        // Log when unprocessed DMA count drops below warnPercent of our
        // buffer count
        if (unprocessed < warnCount && prevUnprocessed >= warnCount) {
            ILOG << "Chan " << chan << " unprocessed DMAs are now below " <<
                    warnPercent << "% of buffer count";
        }

        // (debug) Log increases in unprocessed DMAs
        if (unprocessed > prevUnprocessed) {
            DLOG << "Chan " << chan << " unprocessed DMAs increased: " <<
                    prevUnprocessed << " to " << unprocessed;
        }

        // (debug) Log when unprocessed DMA count returns to zero
        if (unprocessed == 0 && (prevUnprocessed > 0)) {
            DLOG << "Chan " << chan << " unprocessed DMAs now 0";
        }
    } else {
        WLOG << "NAV_DmaGetChannelParams for ADC " << chan << " error: " <<
                NavApiStatus[status];
    }

    // Pointers to the incoming data buffer and metadata struct cast to their
    // native types.
    NAV_DMA_ADC_META_DATA * metaDataPtr =
            static_cast<NAV_DMA_ADC_META_DATA *>(metaDataBufPtr);
    uint8_t * dataPtr = static_cast<uint8_t*>(dataBufPtr);

    // QSharedPointers to newly allocated buffers with copies of the data and
    // metadata, (or NULL pointers if there was a DMA error).
    QSharedPointer<NAV_DMA_ADC_META_DATA> metaDataCopy(NULL);
    QSharedPointer<uint8_t> dataCopy(NULL);

    if (metaDataPtr != NULL && dataPtr != NULL) {
        metaDataCopy = QSharedPointer<NAV_DMA_ADC_META_DATA>(new NAV_DMA_ADC_META_DATA);
        memcpy(metaDataCopy.data(), metaDataPtr, sizeof(NAV_DMA_ADC_META_DATA));

        int nwords = metaDataPtr->validBytes / sizeof(uint8_t);
        dataCopy = QSharedPointer<uint8_t>(new uint8_t[nwords]);
        memcpy(dataCopy.data(), dataBufPtr, metaDataPtr->validBytes);
    }

    // Now emit newAdcData() signal from  the appropriate HCR_Pentek instance.
    // This will queue execution of _acceptAdcData in the instance's thread.
    emit(instance->newAdcData(chan, dmaStatus, dataCopy, metaDataCopy));

    return;
}

void
HCR_Pentek::_dmaOverrunHandler(int32_t chan) {
    ELOG << "DMA overrun handler needs work! Initiating exit.";
    raise(SIGINT);  // Trigger the program's ^C handler
}

void
HCR_Pentek::_dmaTimeoutHandler(int32_t chan) {
    ELOG << "DMA timeout handler needs work! Initiating exit.";
    raise(SIGINT);  // Trigger the program's ^C handler

//        // On DMA timeout, we report the error and restart DMA transfers
//        ELOG << "ADC DMA timeout on board " << _boardNum << " chan " << chan <<
//                ", attempting DMA restart";
//
//        // Stop/restart the DMA for the channel
//        int32_t status;
//
//        status = NAV_DmaStop(_boardHandle, NAV_CHANNEL_TYPE_ADC, chan);
//        _LogNavigatorError(status, adcPrefix + "NAV_DmaStop");
//
//        status = NAV_GlobalGateClose(_boardHandle, NAV_CHANNEL_TYPE_ADC);
//        _LogNavigatorError(status, "ADC NAV_GlobalGateClose");
//
//        status = NAV_TrigDisarm(_boardHandle, NAV_CHANNEL_TYPE_ADC, chan);
//        _LogNavigatorError(status, adcPrefix + "NAV_TrigDisarm");
//
//        status = NAV_TrigClear(_boardHandle, NAV_CHANNEL_TYPE_ADC, chan);
//        _LogNavigatorError(status, adcPrefix + "NAV_TrigClear");
//
//        status = NAV_DmaStart(_boardHandle, NAV_CHANNEL_TYPE_ADC, chan);
//        if (status != NAV_STAT_OK) {
//            ELOG << "DMA restart failed: " << NavApiStatus[status];
//        }
//
//        status = NAV_DmaAdvance(_boardHandle, NAV_CHANNEL_TYPE_ADC, chan);
//        _LogNavigatorError(status, adcPrefix + "NAV_DmaAdvance");
//
//        // Arm the dataflow control core
//        //
//        // This must be done after starting up the DMA core but before a
//        // gate/trigger event occurs.
//        status = NAV_TrigArm(_boardHandle, NAV_CHANNEL_TYPE_ADC, chan);
//        _LogNavigatorError(status, adcPrefix + "NAV_TrigArm");
//
//        // Finally, reopen the global gate for ADC data flow
//        status = NAV_GlobalGateOpen(_boardHandle, NAV_CHANNEL_TYPE_ADC);
//        _LogNavigatorError(status, "ADC NAV_GlobalGateOpen");
}

void
HCR_Pentek::_setupController()
{

    #warning todo configurable
    for(uint32_t k=0;k<16;k++)
    {
        Controller::PulseDefinition pulse = 
        {
            .prt = {6000,0},  
            .numPulses = 3,
            .blockPostTime = 10, 
            .controlFlags = 0xBEAF,
            .filterSelectCh0 = 0,   
            .filterSelectCh1 = 0,   
            .filterSelectCh2 = 0,   
            .timers = { {8,k+3990}, {8,k+3990}, {8,k+3990}, {8,k+3990}, {8,k+3990}, {8,k+3990}, {8,k+3990}, {8,k+3990} }
        };    
        _pulseDefinitions.push_back(pulse);
    }
    
    // Write the pulse definitions
    _controller.writePulseDefinitions(_pulseDefinitions);
    
    // Write the coefficients that the controller will use to populate the pulse filters
    for(int chan=0; chan<_adcCount; chan++)
    {
        std::vector<double> coefs;
        ReadFilterCoefsFromFile(_config.pulse_filter_file(chan), coefs);
        _controller.writeFilterCoefs(coefs, chan);
    }
}

