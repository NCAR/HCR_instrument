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

#include <toolsa/pmu.h> // procmap registration

LOGGING("HCR_Pentek")

// 32-bit all-ones bitmask
static const uint32_t ALL_32_BITS = 0xffffffffUL;

HCR_Pentek::HCR_Pentek(const HcrDrxConfig & config,
                         uint boardNum) :
    QObject(),
    Pentek_xx821(boardNum),
    _controller(*this, CONTROLLER_BASE),
    _config(config),
    _radarStartSecond(0),
    _dmaPacketsDropped(_adcCount),
    _ddcEnable(true),
    _exporter(NULL),
    _prevDmaPacketNum(_adcCount, -1),
    _nDroppedBeforeStartSig(_adcCount, 0),
    _unprocessedDma(_adcCount, 0),
    _maxUnprocessedDma(_adcCount, 0),
    _processedPulses(_adcCount, 0),
    _consoleNotifier(STDIN_FILENO, QSocketNotifier::Read),
    _prevPulseSeq(_adcCount, -1ULL),
    _digitizerSampleWidth(ddcDecimation() * _config.final_decimation() / adcFrequency()),
    _done(false)
{
    // Register needed types
    qRegisterMetaType<int32_t>("int32_t");
    qRegisterMetaType<QSharedPointer<uint8_t> >("QSharedPointer<uint8_t>");
    qRegisterMetaType<QSharedPointer<NAV_DMA_ADC_META_DATA> >("QSharedPointer<NAV_DMA_ADC_META_DATA>");

    PMU_auto_register("HCR_Pentek constructor");

    // Initialize exporter data structures
    for (int chan = 0; chan < _adcCount; chan++) {
        _pulseData.push_back(new PulseData);
    }
    _chanType.push_back(IwrfExport::DataChannelType::H_CHANNEL);
    _chanType.push_back(IwrfExport::DataChannelType::V_CHANNEL);
    _chanType.push_back(IwrfExport::DataChannelType::UNUSED_CHANNEL);

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

    char expectChars[] = "HCRX";
    uint32_t expectCharsIntVal =
        *(reinterpret_cast<uint32_t*>(expectChars));
    if (expectCharsIntVal != userWord) {
        std::ostringstream os;
        os << "Expected 'HCRX' (0x" << std::hex << expectCharsIntVal <<
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

    // Start the radar controller and run the default schedule
    uint32_t enabledChannelVector = 0;
    for(int chan=0; chan<_adcCount; chan++)
        enabledChannelVector |= ( (_config.enable_rx(chan)?1:0)<<chan );

    _controller.run(0,                              // sequenceStartIndex,
                    0,                              // sequenceStopIndex,
                    ddcDecimation(),                // ddcDcimation,
                    _config.final_decimation(),     // postDecimation,
                    _config.pulses_per_xfer(),      // numPulsesPerXfer,
                    enabledChannelVector,           // enabledChannelVector,
                    _config.pulses_to_run() );      // numPulsesToExecute

    // Generate a fake PPS if desired
    if ( !_config.start_on_1pps() ) {
        usleep(1000);
        writeLiteRegister_(BLOCK2_GPR_BASE+4, 1, "Override PPS to 1");
        writeLiteRegister_(BLOCK2_GPR_BASE+4, 0, "Clear override PPS");
    }

    ILOG << "Pentek start time: " << QDateTime::fromTime_t(_radarStartSecond)
                       .toString("yyyy-MM-dd hh:mm:ss").toStdString();

}

HCR_Pentek::~HCR_Pentek() {
    if (!_done) quit();
}

void HCR_Pentek::quit(){
    // Shut down Navigator
    int32_t status;

    // Stop the scheduler
    _controller.halt();

    // Close the global gates
    status = NAV_GlobalGateClose(_boardHandle, NAV_CHANNEL_TYPE_ADC);
    _LogNavigatorError(status, "ADC NAV_GlobalGateClose");

    status = NAV_GlobalGateClose(_boardHandle, NAV_CHANNEL_TYPE_DAC);
    _LogNavigatorError(status, "DAC NAV_GlobalGateClose");

    // For each ADC: disarm and clear trigger, stop the DMA thread, and
    // free DMA resources
    for (int32_t adcChan = 0; adcChan < _adcCount; adcChan++) {

        if(!_config.enable_rx(adcChan)) continue;

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

    _done = true;
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
                            _config.refclk_frequency(),          // double   extRefClockFreq,
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


    // Set up the HMC clock. It is always 64ns (same as the DDC output)
    writeLiteRegister_(BLOCK2_GPR_BASE+12, ddcDecimation(), "Setting HMC clock divider");

    //Clear the debug PPS
    writeLiteRegister_(BLOCK2_GPR_BASE+4, 0, "Clear override PPS");

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

        if(!_config.enable_rx(adcChan)) continue;

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
                              128,                      // number of xfer buffers to allocate
                              262144,                   // buffer size in bytes
                              NAV_DMA_METADATA_ENABLE,  // enable metadata
                              NAV_DMA_RUN_MODE_CONTINUOUS_LOOP, // continuous sampling
                              NAV_SYS_WAIT_STATE_MILSEC(2000),  // DMA timeout, ms
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

            int irqCpu = 3;    // Fixed affinity

            //Check for isolcpus. If you isolate more than once CPU,
            //this check may need to be more clever.
            std::ifstream kernelCmdFile("/proc/cmdline");
            std::string kernelCmd;
            std::getline(kernelCmdFile, kernelCmd);
            std::string strToFind = "isolcpus=" + std::to_string(irqCpu);
            std::size_t found = kernelCmd.find(strToFind);

            if (found == std::string::npos) {
                    WLOG << "XXXXXXXXXXXXXXXXXXXXXXXXX";
                    WLOG << "";
                    WLOG << "Couldn't find '" << strToFind << "' in /proc/cmdline";
                    WLOG << "DMA overruns are likely!";
                    WLOG << "";
                    WLOG << "XXXXXXXXXXXXXXXXXXXXXXXXX";
            }

            // Set up the setWinDriverIrqAffinity command
            std::ostringstream oss;
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

//    double truncPoint = adcFrequency() / ((1ULL<<32) / ducInterpolation());
//    double adjustedFreq = std::floor(_config.rx_frequency() / truncPoint) * truncPoint;

    // Set up our DDCs
    if (_ddcEnable) {
        for (int32_t ddcNum = 0; ddcNum < _ddcCount; ddcNum++) {
            // Build a prefix string of the form "DDC chan <chanNum> "
            std::string ddcPrefix =
                    std::string("DDC chan ") + std::to_string(ddcNum) + " ";

            // Initialize the DDC associated with this ADC
            status = NAV_DdcSetup(_boardHandle,
                                  ddcNum,
                                  ddcDecimation(),
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

            // Tweak the default Pentek DDC gain
            auto firBase = static_cast<NAV_BOARD_RESRC*>(_boardHandle)->ipBaseAddr.ddc[ddcNum].ddcSt3Filter;
            uint32_t stageGain;
            status = NAVip_FDecFir32_Gain_GetGain(firBase, &stageGain);
            _AbortCtorOnNavStatusError(status, ddcPrefix + "NAVip_FDecFir32_Gain_GetGain");
            status = NAVip_FDecFir32_Gain_SetGain(firBase, std::round(stageGain * _config.extra_ddc_gain()));
            _AbortCtorOnNavStatusError(status, ddcPrefix + "NAVip_FDecFir32_Gain_SetGain");

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

    // DAC set up. The Pentek 78821 board has one DAC5688 dual-channel
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

    //// I would like to do this but it doesn't seem to work.
    //// Instead edit nav820_dac.c : NAV820_DacSetDefaultParams
    //// to add 'deviceParams->clkDivSyncEna  = DAC5688_CONFIG5_CLK_SYNC_DIV_ENABLE;'
    //NAV_IP_ADDR_TABLE *ipBaseAddr = &((NAV_BOARD_RESRC*)_boardHandle)->ipBaseAddr;
    //status = NAVdev_DAC5688SetDacClkDivSyncEn(ipBaseAddr->dac[dacChip].dacIntrfcCtrl, DAC5688_CONFIG5_CLK_SYNC_DIV_ENABLE);
    //_AbortCtorOnNavStatusError(status, dacPrefix + "NAVdev_DAC5688SetDacClkDivSyncEn");

    status = NAV_GateTrigModeSetup(_boardHandle,
                                   NAV_CHANNEL_TYPE_BRD_RAM,
                                   dacChip,
                                   NAV_GATE_TRIG_MODE_GLOBAL_GATE,
                                   NAV_GATE_TRIG_MODE_CTRL_STAY_ARM_ACTIVE);
    _AbortCtorOnNavStatusError(status, dacPrefix + "NAV_GateTrigModeSetup");

    status = NAV_TrigArm(_boardHandle, NAV_CHANNEL_TYPE_BRD_RAM, dacChip);
    _AbortCtorOnNavStatusError(status, dacPrefix + "NAV_TrigArm");

    // Set up the DUC
    if (ducInterpolation() > 1) {
        status = NAV_DucSetup(_boardHandle,
                              dacChip,                  // channel
                              ducInterpolation(),       // interpolation
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
    _AbortCtorOnNavStatusError(status, dacPrefix + "NAV_SetDucSyncState");

    // Send an ADC sync. Due to some firmware hacks this will sync the DAC to the ADC clock.
    usleep(1e4);
    status = NAV_GlobalSyncPulse(_boardHandle, NAV_CHANNEL_TYPE_ADC);
    _AbortCtorOnNavStatusError(status, dacPrefix + "NAV_GlobalSyncPulse");
    usleep(1e4);
    status = NAV_GlobalSyncPulse(_boardHandle, NAV_CHANNEL_TYPE_ADC);
    _AbortCtorOnNavStatusError(status, dacPrefix + "NAV_GlobalSyncPulse");
    usleep(1e4);
}

std::string
HCR_Pentek::boardInfoString() const {
    std::ostringstream os;

    // Start with the base class info
    os << Pentek_xx821::boardInfoString();

    // Add HCR_Pentek header
    os << "    HCR_Pentek" << std::endl;

    // The rev date register holds the firmware revision date in the form
    // 0xYYMMDD (21st century is assumed)
    uint32_t revDate;
    uint32_t revHour;
    NAVip_BrdInfoRegs_FpgaRevDateStat_GetRevDate(_boardInfoRegBase(),
                                                 &revDate);

    // The rev num register holds the revision hour in the form 0xHH
    NAVip_BrdInfoRegs_FpgaRevStat_GetRevNum(_boardInfoRegBase(),
                                            &revHour);

    // Log the firmware rev date and hour
    os << "        DRX firmware rev date/time: 20" << std::hex << revDate <<
          " " << revHour << ":00" << std::endl;
    return(os.str());
}

void
HCR_Pentek::_logClockConfigDiffs() const {
    NAV_CLOCK_SELECT currClockConfig =
            _boardResource()->boardParams.clockSelect;

    int32_t newClockSource = _config.use_internal_clock() ? NAV_CLOCK_INT : NAV_CLOCK_EXT;
    if (currClockConfig.boardClockSource != newClockSource) {
        ILOG << "Changing board clock source from " <<
                currClockConfig.boardClockSource << " to " << newClockSource;
    }

    if (currClockConfig.boardClockFreq != boardClockFrequency()) {
        ILOG << "Changing board clock frequency from " <<
                currClockConfig.boardClockFreq * 1.0e-6 << " MHz to " <<
                boardClockFrequency() * 1.0e-6 << " MHz";
    }

    if (currClockConfig.extRefClockFreq != _config.refclk_frequency()) {
        ILOG << "Changing reference frequency from " <<
                currClockConfig.extRefClockFreq * 1.0e-6 << " MHz to " <<
                _config.refclk_frequency() * 1.0e-6 << " MHz";
    }

    if (currClockConfig.options != NAV_OPTIONS_NONE) {
        ILOG << "Changing clock options from " <<
                currClockConfig.options << " to " << NAV_OPTIONS_NONE;
    }

    ILOG << "Clock config: Source: " << (_config.use_internal_clock() ? "INT" : "EXT")
         << ", Board: " << (boardClockFrequency()*1e-6) << " MHz"
         << ", Ref: " << (_config.refclk_frequency()*1e-6) << " MHz";
    ILOG << "     ADC: " << (adcFrequency()*1e-6) << " MHz (x" << ddcDecimation() << ")"
         << ", DAC: " << (dacFrequency()*1e-6) << " MHz (x" << ducInterpolation() << ")";
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

    // ILOG << "_acceptAdcData " << chan << "\n";

    // Periodically refresh the watchdog timer. Without this,
    // the controller will time out after a few thousand pulses and halt.
    _controller.bumpWatchdog();

    if (! _checkDmaMetadata(chan, metadata)) {
        return;
    }

    //Process all the pulses in the data.
    for(size_t numPulsesProcessed=0; !lastPulseInXfer; ++numPulsesProcessed, ++_processedPulses[chan])
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

        if(pulseHeader.pulseBlockDefinitionNumber >= _pulseBlockDefinitions.size()) {
            ELOG << "Bad pulse definition " << pulseHeader.pulseBlockDefinitionNumber
                 << " chan " << chan << " pulse " << numPulsesProcessed;
            return;
        }

        if (_prevPulseSeq[chan] + 1 != pulseHeader.pulseSequenceNumber) {
            ELOG << "Channel " << chan << " pulse sequence jump " << _prevPulseSeq[chan] << " -> " << pulseHeader.pulseSequenceNumber;
        }
        _prevPulseSeq[chan] = pulseHeader.pulseSequenceNumber;

        // Lookup the pulse definition
        const Controller::PulseBlockDefinition& blockDef = _pulseBlockDefinitions[pulseHeader.pulseBlockDefinitionNumber];

        // Number of data values
        uint32_t nGates = pulseHeader.numSamples;
        //if(!chan) {
        //    ILOG << "k " << pulseHeader.pulseBlockDefinitionNumber << " gates " << nGates << " nexg " << (metadata->validBytes-sizeof(Controller::PulseHeader))/4 << " prt " << pulseHeader.prt
        //    << " extra " << 0.25*(metadata->validBytes - (dataBufOffsetBytes + nGates*sizeof(IQData)));
        //}

        // Calculate the timestamp
        time_t dataSec = _radarStartSecond + metadata->timestampPpsCount;
        uint32_t dataNanosec = (metadata->timestampClockCount + clockOffsetCount) * (1e9/adcFrequency());

        // Add the PRT to get the offset for the next pulse
        clockOffsetCount += pulseHeader.prt;

        // Add the post-time if applicable
        if(pulseHeader.statusFlags.lastPulseInBlock) {
            clockOffsetCount += blockDef.blockPostTime;
        }

        // Check if done
        lastPulseInXfer = pulseHeader.statusFlags.lastPulseInXfer;

        // Grab the polarization
        PulseData::XmitPolarization_t xmitPol =
            pulseHeader.statusFlags.HV ? PulseData::XMIT_POL_HORIZONTAL : PulseData::XMIT_POL_VERTICAL;

        // Grab the angles
        float rotMotorAngle = (360. / 400000) * pulseHeader.posEnc0;
        float tiltMotorAngle = (360. / 480000) * pulseHeader.posEnc1;
        // Move angle2 into range [-180,180]
        if (tiltMotorAngle > 180.0) {
            tiltMotorAngle -= 360.0;
        }

        // Check the size of the buffer
        if(dataBufOffsetBytes + nGates*sizeof(IQData) > metadata->validBytes) {
            ELOG << "Truncated pulse data chan " << std::dec << chan
                 << " after pulse " << numPulsesProcessed;
            return;
        }

        // Extract the IQ data
        const IQData* iqData(reinterpret_cast<const IQData*>(dataBuf+dataBufOffsetBytes));
        dataBufOffsetBytes += nGates * sizeof(IQData);

        // If we have a exporter, send it the new data for collating and publishing.
        if (_exporter) {

            // set data in pulse object
            _pulseData[chan]->set(
                pulseHeader.pulseSequenceNumber, // int64_t pulseSeqNum,
                dataSec,            // time_t timeSecs,
                dataNanosec,        // int nanoSecs,
                chan,               // int channelId,
                rotMotorAngle,      // float rotMotorAngle,
                tiltMotorAngle,     // float tiltMotorAngle,
                xmitPol,            // XmitPolarization_t xmitPol,
                _fromCounts(blockDef.prt[0]), // double prt1,
                _fromCounts(blockDef.prt[1]), // double prt2,
                _fromCounts(pulseHeader.prt), // double currentPrt,
                _fromCounts(blockDef.timers[Controller::Timers::TX_PULSE].width), // double txPulseWidth,
                _digitizerSampleWidth, // double sampleWidth,
                nGates,             // int nGates,
                iqData );           // const std::complex<int16_t> *iq)

            // Write our current object into the merge queue, and get back another to use
            switch (_chanType[chan]) {
                case IwrfExport::DataChannelType::H_CHANNEL:
                    _pulseData[chan] = _exporter->writePulseH(_pulseData[chan]);
                    break;
                case IwrfExport::DataChannelType::V_CHANNEL:
                    _pulseData[chan] = _exporter->writePulseV(_pulseData[chan]);
                    break;
                default:
                    ELOG << "Dropping pulse for channel type " << _chanType[chan];
            }
        }
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

        // ELOG << "ADC DMA timeout on board " << instance->_boardNum << " chan " << chan;

        // Have the associated HCR_Pentek instance emit signal
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

    if(_config.pulses_to_run() != Controller::INFINITE_PULSES
       && _processedPulses[chan] >= _config.pulses_to_run()) {

        ILOG << "Channel " << chan << " successfully processed " << _processedPulses[chan] << " pulses.";
        raise(SIGINT);  // Trigger the program's ^C handler
    }
    else {

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
}

HCR_Pentek::Controller::PulseBlockDefinition
HCR_Pentek::_definePulseBlock(
        double  txPulseWidth,
        uint    numRxGates,
        uint    numPulses,
        double  prt1,
        double  prt2,
        double  blockPostTime,
        uint    filterSelect,
        Controller::PolarizationModes polMode
    )
{

    Controller::PulseBlockDefinition block =
    {
        .prt              = {_counts(prt1), _counts(prt2)},
        .numPulses        = numPulses,
        .blockPostTime    = _counts(blockPostTime),
        .controlFlags     = 0x0,
        .polarizationMode = polMode,
        .filterSelectCh0  = filterSelect,
        .filterSelectCh1  = filterSelect,
        .filterSelectCh2  = filterSelect,
        .timers           = {}
    };

    // Master sync is 200 ns long so the PMC730 can't miss it
    block.timers[Controller::Timers::MASTER_SYNC] = { 0, _counts(200.e-9) };

    // The receive delay cancels out the pipeline delays and brings the burst to the beginning of the data.
    // Add half the pulse width so that the center of the burst is always in the same gate.
    block.timers[Controller::Timers::RX_0] =        { _counts(_config.rx_delay() + txPulseWidth/2), _counts(numRxGates * _digitizerSampleWidth) };
    block.timers[Controller::Timers::RX_1] =        block.timers[Controller::Timers::RX_0];
    block.timers[Controller::Timers::RX_2] =        block.timers[Controller::Timers::RX_0];

    // Transmit pulse
    block.timers[Controller::Timers::TX_PULSE] =    { _counts(_config.tx_delay()), _counts(txPulseWidth) };

    // The width of the modulation pulse is 272 ns + transmit pulse width,
    // where the 272 ns is the empirically measured rise time until full amplification is achieved.
    block.timers[Controller::Timers::MOD_PULSE] =   { _counts(_config.tx_mod_pulse_delay()), _counts(272.e-9 + txPulseWidth) };

    // EMS switch timing. Use 800 ns + transmit pulse width + transmit delay
    block.timers[Controller::Timers::EMS_TRIG] =    { 0, _counts(800.e-9 + txPulseWidth + _config.tx_delay()) };

    // Spare
    block.timers[Controller::Timers::TIMER_7] =     { 0, 0 };

    return block;
}

void
HCR_Pentek::_setupController()
{
    // Write the coefficients that the controller will use to populate the pulse filters
    for(int chan=0; chan<_adcCount; chan++)
    {
        if(!_config.enable_rx(chan)) continue;

        std::vector<double> coefs;
        ReadFilterCoefsFromFile(_config.pulse_filter_file(chan), coefs);
        _controller.writeFilterCoefs(coefs, chan);
    }

    // The first three pulse blocks are defined by _config and define the basic transmit modes.
    // Block zero is also used for the calibration ops modes.
    auto txPulseWidth   = _config.default_tx_pulse_width();
    auto numRxGates     = _config.default_rx_gates();
    auto numPulses      = _config.default_pulses();
    auto prt1           = _config.default_prt1();
    auto prt2           = _config.default_prt2();
    auto blockPostTime  = _config.default_post_time();
    auto filterSelect   = _config.default_filter();

    // The gaussian filters in the default file are:
    //   Passthrough, 256ns, 384ns, 512ns, 640ns, 768ns, 896ns, 1024ns.

    // Define the 'legacy mode' blocks and add them to the pulse definitions
    _pulseBlockDefinitions.push_back(
        _definePulseBlock(
            txPulseWidth, numRxGates, numPulses, prt1, prt2, blockPostTime, filterSelect,
            Controller::PolarizationModes::POL_MODE_H
        ));

    _pulseBlockDefinitions.push_back(
        _definePulseBlock(
            txPulseWidth, numRxGates, numPulses, prt1, prt2, blockPostTime, filterSelect,
            Controller::PolarizationModes::POL_MODE_V
        ));

    _pulseBlockDefinitions.push_back(
        _definePulseBlock(
            txPulseWidth, numRxGates, numPulses, prt1, prt2, blockPostTime, filterSelect,
            Controller::PolarizationModes::POL_MODE_HHVV
        ));

    // Define additional blocks for demonstration purposes
    _pulseBlockDefinitions.push_back(
        _definePulseBlock(
            256e-9, numRxGates, numPulses, prt1, prt2, blockPostTime, 1,
            Controller::PolarizationModes::POL_MODE_H
        ));

    _pulseBlockDefinitions.push_back(
        _definePulseBlock(
            512e-9, numRxGates, numPulses, prt1*2, prt2, blockPostTime, 3,
            Controller::PolarizationModes::POL_MODE_HHVV
        ));

    _pulseBlockDefinitions.push_back(
        _definePulseBlock(
            1024e-9, numRxGates, numPulses, prt1*2, prt2, blockPostTime, 7,
            Controller::PolarizationModes::POL_MODE_HHVV
        ));

    // Write the pulse definitions
    _controller.writePulseBlockDefinitions(_pulseBlockDefinitions);

}

void HCR_Pentek::changeControllerSchedule(uint32_t scheduleStartIndex, uint32_t scheduleStopIndex)
{
    _controller.changeSchedule(scheduleStartIndex, scheduleStopIndex);
}

void HCR_Pentek::zeroMotorCounts()
{
    ILOG << "Zeroing the motor counts.";

    uint32_t originalVal = readLiteRegister_(BLOCK2_GPR_BASE+8, "Read GPR2");
    uint32_t mask = 0x2;
    writeLiteRegister_(BLOCK2_GPR_BASE+8, originalVal | mask, "Zero motor count");
    writeLiteRegister_(BLOCK2_GPR_BASE+8, originalVal & (~mask), "Clear zero motor count");
}

