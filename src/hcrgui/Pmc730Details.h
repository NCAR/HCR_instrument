/*
 *  Created on: Dec 10, 2013
 *      Author: burghart
 */
#ifndef PMC730DETAILS_H_
#define PMC730DETAILS_H_

#include <QDialog>
#include <QPixmap>
#include <HcrPmc730Status.h>

#include "ui_Pmc730Details.h"

class Pmc730Details : public QDialog {
    Q_OBJECT
public:
    Pmc730Details(QWidget *parent);
    virtual ~Pmc730Details() {}

    /// @brief Return true iff details indicates a warning condition.
    /// @return true iff details indicates a warning condition.
    bool warnState() const { return(_warnState); }
    
    /// @brief Return true iff details indicates an error condition.
    /// @return true iff details indicates an error condition.
    bool errState() const { return(_errState); }
    
public slots:
    /// @brief Slot to call to populate with new status
    /// @param status the new status to be displayed
    void updateStatus(const HcrPmc730Status & status);
    
    /// @brief Slot to be called when daemon responsiveness changes
    /// @param daemonResponsive true iff the daemon is currently responding
    void daemonResponsivenessChange(bool daemonResponsive);
    
private:
    Ui::Pmc730Details _ui;
    QPixmap _redLED;
    QPixmap _amberLED;
    QPixmap _greenLED;
    QPixmap _greenLED_off;
    
    bool _warnState;
    bool _errState;
};
#endif /* PMC730DETAILS_H_*/
