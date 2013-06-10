/*
 * ClientMain.cpp
 *
 *  Created on: Jun 2, 2013
 *      Author: avaps
 */

#include <QtGui>
#include "ClientMainWindow.h"
#include "MotionControlRpcClient.h"

int
main(int argc, char** argv)
{
	// Create the Qt application
	QApplication app(argc, argv);

	MotionControlRpcClient rpcClient("localhost", 8080);

	// Create the RPC client user interface.
	ClientMainWindow clientMainWindow(rpcClient);
	QString title("Drive Command XML-RPC Client");
	clientMainWindow.setWindowTitle(title);

	// Show the user interface
	clientMainWindow.show();

	// Hop on the merry-go-round.
	return app.exec();
}
