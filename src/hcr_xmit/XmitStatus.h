/*
 * XmitStatus.h
 *
 *  Created on: Aug 31, 2012
 *      Author: burghart
 */

#ifndef XMITSTATUS_H_
#define XMITSTATUS_H_

/// @brief Class to represent HCR transmitter status.
///
///
class XmitStatus {
public:
    /// @brief Construct a valid XmitStatus full of bad values.
    XmitStatus();
    /// @brief
    virtual ~XmitStatus();

    /// @brief Return true iff the XmitStatus is valid, i.e., were the
    /// parameters provided at construction time valid.
    bool isValid();
private:
};

#endif /* XMITSTATUS_H_ */
