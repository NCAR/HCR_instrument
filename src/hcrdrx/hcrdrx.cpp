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
#include "HCR_Pentek.h"
#include "HcrDrxConfig.h"
#include <HcrSharedResources.h>
#include "StatusGrabber.h"

#include <csignal>
#include <cstdio>
#include <fstream>
#include <QFunctionWrapper.h>
#include <QtCore/QCoreApplication>
#include <QtCore/QDateTime>
#include <QtCore/QTimer>
#include <QtNetwork/QUdpSocket>
#include <logx/Logging.h>
#include <toolsa/pmu.h>
#include <xmlrpc-c/registry.hpp>
#include <QXmlRpcServerAbyss.h>

LOGGING("hcrdrx")

/// Signal handler which closes our Qt app cleanly
void
quitHandler(int signum) {
    ILOG << "Exiting on " << strsignal(signum) << " signal";
    QCoreApplication::instance()->quit();
}

/// xmlrpc_c::method to get status from the hcrdrx process.
class GetStatusMethod : public xmlrpc_c::method {
public:
    GetStatusMethod(HCR_Pentek& hcrPentek)
        : _hcrPentek(hcrPentek) {
        this->_signature = "S:";
        this->_help = "This method returns the latest status from hcrdrx.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        DLOG << "Received 'getStatus' command";
        // Get the latest status from shared memory, and convert it to
        // an xmlrpc_c::value_struct dictionary.
        *retvalP = _hcrPentek.status().toXmlRpcValue();
    }
private:
    HCR_Pentek& _hcrPentek;
};

/// xmlrpc_c::method to zero the Pentek's position counts for the two reflector motors.
class ZeroPentekMotorCountsMethod : public xmlrpc_c::method {
public:
    ZeroPentekMotorCountsMethod(HCR_Pentek& hcrPentek)
        : _hcrPentek(hcrPentek) {
        this->_signature = "n:";
        this->_help = "This method causes the Pentek to zero its counts for the reflector drives.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        ILOG << "Received 'zeroPentekMotorCounts' command";
        _hcrPentek.zeroMotorCounts();
    }
private:
    HCR_Pentek& _hcrPentek;
};

/// xmlrpc_c::method to set the Pentek's controller schedule start and stop indices
class SetControllerScheduleMethod : public xmlrpc_c::method {
public:
    SetControllerScheduleMethod(HCR_Pentek& hcrPentek)
        : _hcrPentek(hcrPentek) {
        this->_signature = "n:";
        this->_help = "This method sets the Pentek controller schedule start and stop indices.";
    }
    void
    execute(const xmlrpc_c::paramList & paramList, xmlrpc_c::value* retvalP) {
        XmlrpcSerializable<OperationMode> opMode(paramList[0]);
        paramList.verifyEnd(1);
        ILOG << "XML-RPC call to setControllerSchedule(" << opMode.hmcMode() << ", "
             << opMode.scheduleStartIndex() << ", " << opMode.scheduleStopIndex()
             << ", '" << opMode.name() << "')";
        _hcrPentek.changeControllerSchedule(opMode.scheduleStartIndex(),
                                            opMode.scheduleStopIndex());
        *retvalP = xmlrpc_c::value_nil();
    }
private:
    HCR_Pentek& _hcrPentek;
};

int
main(int argc, char * argv[]) {

    // Let logx get and strip out its arguments first
    logx::ParseLogArgs(argc, argv);

    // Get the configuration
    HcrDrxConfig config(argc, argv);

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
      exit(0);
    }

    ILOG << "hcrdrx started at " <<
            QDateTime::currentDateTimeUtc().toString(Qt::ISODate).toStdString();

    // Close stdin; we don't expect any input on stdin anyway.
    //
    // Closing it is important because this keeps (some Qt-based component?)
    // from setting up a read poll on stdin, then spinning the main thread at
    // 100% CPU because stdin constantly triggers with zero bytes to read,
    // indicating it's at EOF.
    WLOG << "Closing stdin to avoid 'spinning stdin poll() when backgrounded' issue...";
    fclose(stdin);

    // Initiate exit on receiving INT or TERM signals. INT is the signal
    // sent when ^C is typed at the keyboard, and TERM is the default signal
    // sent by the "kill <pid>" command.
    signal(SIGINT, quitHandler);
    signal(SIGTERM, quitHandler);

    QCoreApplication app(argc, argv);

    // Log the config in use
    ILOG << "==== HCR DRX config in use:";
    std::istringstream is(config.configString());
    std::string line;
    while (std::getline(is, line))
    {
        ILOG << "    " << line;
    }
    ILOG << "==== end of config";

    // set up registration with procmap if instance is specified
    if (config.instance().size() > 0) {
      PMU_auto_init("hcrdrx", config.instance().c_str(), PROCMAP_REGISTER_INTERVAL);
      ILOG << "will register with procmap, instance: " << config.instance();
    }

    try {

        // Open the Pentek
        HCR_Pentek hcrPentek(config, 0);
        ILOG << "\n" << hcrPentek.boardInfoString();

        // Initialize our RPC server using port HCRDRX_PORT
        xmlrpc_c::registry myRegistry;
        myRegistry.addMethod("getStatus", new GetStatusMethod(hcrPentek));
        myRegistry.addMethod("zeroPentekMotorCounts", new ZeroPentekMotorCountsMethod(hcrPentek));
        myRegistry.addMethod("setControllerSchedule", new SetControllerScheduleMethod(hcrPentek));
        QXmlRpcServerAbyss rpcServer(&myRegistry, HCRDRX_PORT);

        std::string xmitdHost("archiver");
        std::string pmc730dHost("localhost");
        std::string motionControlHost("localhost");
        std::string executiveHost("localhost");

        // Create and start the status grabber
        StatusGrabber statusGrabber(hcrPentek,
            pmc730dHost, HCRPMC730DAEMON_PORT,
            xmitdHost, HCR_XMITD_PORT,
            motionControlHost, MOTIONCONTROLDAEMON_PORT,
            executiveHost, HCREXECUTIVE_PORT);
        statusGrabber.start();
        QObject::connect(&app, SIGNAL(aboutToQuit()), &hcrPentek, SLOT(quit()));
        QObject::connect(&app, SIGNAL(aboutToQuit()), &statusGrabber, SLOT(quit()));

        // Create and start the IwrfExport
        IwrfExport exporter(config, statusGrabber);
        hcrPentek.setExporter(&exporter);
        exporter.start();

        // Create a timer which will call hcrPentek.startRadar() from our
        // QApplication's event loop immediately when it's executed.
        QTimer::singleShot(0, &hcrPentek, &HCR_Pentek::startRadar);

        // Start the QCoreApplication
        app.exec();

    } catch (std::runtime_error & e) {
        ELOG << "Exiting on runtime error: " << e.what();
    }

    PMU_auto_unregister();

    ILOG << "hcrdrx finished at " <<
            QDateTime::currentDateTimeUtc().toString(Qt::ISODate).toStdString();
}
