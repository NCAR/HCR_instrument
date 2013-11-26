/*
 * ClientMainWindow.h
 *
 *  Created on: June 3, 2013
 *      Author: avaps
 */

#ifndef CLIENTMAINWINDOW_H_
#define CLIENTMAINWINDOW_H_

#include <QtGui>
#include <QTimer>
#include <MotionControlRpcClient.h>
#include "ui_ClientMainWindow.h"

class ClientMainWindow: public QMainWindow, public Ui::ClientMainWindow
{
	Q_OBJECT
public:
	/// Constructor
	/// @param rpcClient The MotionControlRpcClient
	/// @param parent The window parent.
	ClientMainWindow(MotionControlRpcClient& rpcClient, QWidget* parent = 0);
	/// Destructor
	virtual ~ClientMainWindow();

protected slots:
	/// Set pointing angle line edit when the angle changes
	void lePointingAngle(int);
    /// Get the angle that the drive to be point to
    void getPointingAngle();
    /// Update status
    void updateStatus();

protected:
	/// The MotionControlRpcClient
    MotionControlRpcClient& _rpcClient;

    /// Status timer
    QTimer _statusTimer;

};

#endif /* CLIENTMAINWINDOW_H_ */
