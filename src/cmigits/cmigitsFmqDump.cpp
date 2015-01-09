#include <QCoreApplication>
#include <logx/Logging.h>
#include "FmqDumper.h"

LOGGING("cmigitsFmqDump")

int
main(int argc, char * argv[]) {
    // Let logx get and strip out its arguments
    logx::ParseLogArgs(argc, argv);
    ILOG << "cmigitsFmqDump starting";

    QCoreApplication app(argc, argv);
    FmqDumper dumper;

    app.exec();
    
    return(0);
}
