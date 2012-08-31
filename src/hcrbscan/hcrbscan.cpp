#include <iostream>
#include <vector>

#include <boost/program_options.hpp>
#include <QtConfig.h>

#include <QApplication>
#include <QMainWindow>
#include <QPrintDialog>
#include <QPrinter>

#include <BscanMainWindow.h>
#include <radar/IwrfMomReader.hh>
#include "RadxBscanRaySource.h"
#include "ReaderThread.h"

namespace po = boost::program_options;

//////////////////////////////////////////////////////////////////////
//
/// Parse the command line options, and also set some options
/// that are not specified on the command line.
/// @return The runtime options that can be passed to the
/// threads that interact with the RR314.
void parseOptions(int argc,
        char** argv)
{

    // get the options
    po::options_description descripts("Options");
    descripts.add_options()
        ("help", "describe options");

    po::variables_map vm;
    po::store(po::parse_command_line(argc, argv, descripts), vm);
    po::notify(vm);

    if (vm.count("help")) {
        std::cout << descripts << std::endl;
        exit(1);
    }
}



int main(int argc, char *argv[]) {

    // get the configuration parameters from the configuration file
    QtConfig config("Bscan", "hcrbscan");

    // parse the command line options, overriding the values of some global
    // parameters
    parseOptions(argc, argv);

    QApplication* app = new QApplication(argc, argv);
    
    // Any other args are file names
    std::vector<std::string> productFiles;
    for (int i = 1; i < argc; i++) {
        productFiles.push_back(argv[i]);
    }

    // If we got any file names, set up a file reader, otherwise try for
    // real-time data from the moments FMQ
    IwrfMomReader *momReader;
    if (! productFiles.empty()) {
        momReader = new IwrfMomReaderFile(productFiles);
    } else {
        // Set up a reader getting its data from the Radx moments FMQ
        momReader = new IwrfMomReaderFmq("fmq/moments/wband/shmem_20000");
    }
    RadxBscanRaySource bscanRaySource;
    ReaderThread readerThread(*momReader, bscanRaySource);
    readerThread.start();
    
    QMainWindow* mainWindow = new BscanMainWindow(config);
    mainWindow->setWindowTitle("HCR bscan");
    QObject::connect(&bscanRaySource, SIGNAL(newBscanRay(const BscanRay &)),
            mainWindow, SLOT(addRay(const BscanRay &)));
    mainWindow->show();
    
    return app->exec();
}
