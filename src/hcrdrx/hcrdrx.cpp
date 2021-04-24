// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
// ** Copyright UCAR (c) 1990 - 2021
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
#include <csignal>
#include <cstring>
#include <fstream>
#include <HCR_Pentek.h>
#include <HCR_Config.h>
#include <QFunctionWrapper.h>
#include <QtCore/QCoreApplication>
#include <QtCore/QDateTime>
#include <QtNetwork/QUdpSocket>
#include <logx/Logging.h>
#include <toolsa/pmu.h>

LOGGING("hcrdrx")

/// Signal handler which closes our Qt app cleanly
void
quitHandler(int signum) {
    ILOG << "Exiting on " << strsignal(signum) << " signal";
    QCoreApplication::instance()->quit();
}

int
main(int argc, char * argv[]) {

    // Let logx get and strip out its arguments first
    logx::ParseLogArgs(argc, argv);

    // Get the configuration
    HCR_Config config;
    config.parse(argc, argv);

    // check for usage
    bool printUsage = false;
    for (int ii = 0; ii < argc; ii++) {
      if ((strstr(argv[ii], "--help") != NULL) ||
          (strstr(argv[ii], "--h") != NULL) ||
          (strstr(argv[ii], "-h") != NULL)) {
        printUsage = true;
        break;
      }
    } // ii

    if (printUsage) {
      std::cout << "Usage: hcrdrx [options]" << std::endl;
      std::cout << "  [-h, --h, --help]: print this usage message" << std::endl;
      std::cout << "  [--config_file ?]: specify config file" << std::endl;
      config.printUsage(std::cout);
      exit(0);
    }

    ILOG << "hcrdrx started at " <<
            QDateTime::currentDateTimeUtc().toString(Qt::ISODate).toStdString();

    // Initiate exit on receiving INT or TERM signals. INT is the signal
    // sent when ^C is typed at the keyboard, and TERM is the default signal
    // sent by the "kill <pid>" command.
    signal(SIGINT, quitHandler);
    signal(SIGTERM, quitHandler);

    QCoreApplication app(argc, argv);

    // set up registration with procmap if instance is specified
    if (config.instance().size() > 0) {
      PMU_auto_init("hcrdrx", config.instance().c_str(), PROCMAP_REGISTER_INTERVAL);
      ILOG << "will register with procmap, instance: " << config.instance();
    }

    // If requested, create IwrfPublisher-s to publish IWRF time series for
    // both long- and short-pulse data
    IwrfPublisher * longPulsePublisher = NULL;
    IwrfPublisher * shortPulsePublisher = NULL;
    if (config.publish_iwrf()) {
        longPulsePublisher = new IwrfPublisher(IwrfPublisher::PULSE_LONG, config);
        shortPulsePublisher = new IwrfPublisher(IwrfPublisher::PULSE_SHORT, config);
    }

    // Instantiate our HCR_Pentek instance and start our QCoreApplication
    HCR_Pentek * hcrPentek = NULL;
    try {
        uint boardNum = 0;
        hcrPentek = new HCR_Pentek(config, boardNum,
                                     longPulsePublisher, shortPulsePublisher);
        ILOG << "\n" << hcrPentek->boardInfoString();

        // Start the QCoreApplication
        app.exec();
    } catch (std::runtime_error & e) {
        ELOG << "Exiting on runtime error: " << e.what();
    }

    PMU_auto_unregister();
    delete(hcrPentek);
    delete(longPulsePublisher);
    delete(shortPulsePublisher);
    ILOG << "hcrdrx finished at " <<
            QDateTime::currentDateTimeUtc().toString(Qt::ISODate).toStdString();
}
