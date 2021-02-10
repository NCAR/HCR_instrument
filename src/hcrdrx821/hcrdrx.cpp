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

    // Let logx get and strip out its arguments first
    logx::ParseLogArgs(argc, argv);
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
