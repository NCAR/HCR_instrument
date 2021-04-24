// *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
// ** Copyright UCAR (c) 2018
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

// setWinDriverIrqAffinity.cpp
//
//  Created on: Dec 31, 2018
//      Author: Adam Karboski <karboski@ucar.edu>

// Program to find any IRQs owned by WinDriver and set their CPU affinity
// to the CPU (or list of CPUs) given in the command line argument. The
// syntax for the argument is that required for /proc/irq/<num>/smp_affinity_list.
//
// Binding the IRQ affinity to a dedicated CPU allows WinDriver to handle
// higher interrupt rates, as required by apardrx.
//
// To be run by a non-root user, the program must be owned by root and have the
// setuid permission bit set, since only root can write to
// /proc/irq/<num>/smp_affinity_list.

#include <unistd.h>
#include <iostream>
#include <fstream>
#include <string>
#include <boost/algorithm/string/trim.hpp>

int
main(int argc, char * argv[])
{
    if (argc != 2) {
        std::cout << "Usage: " << argv[0] << " <smp_affinity_list_string>" <<
                     std::endl;
        exit(1);
    }
    std::string cpu_list = argv[1];

    // Only root can write to /proc/irq/<num>/smp_affinity_list, so make
    // sure our effective UID is zero (i.e., root).
    if (geteuid() != 0) {
        std::cerr << argv[0] << " must execute as root!" << std::endl;
        std::cerr << "To be run by non-root users, the program" << std::endl;
        std::cerr << "must be owned by root and have the setuid" << std::endl;
        std::cerr << "permission bit set.";
        exit(1);
    }

    // Loop through all interrupts listed in /proc/interrupts
    std::ifstream ifs("/proc/interrupts");
    if (ifs.fail()) {
        std::cerr << "Failed to open /proc/interrupts" << std::endl;
        exit(1);
    }

    while (! ifs.eof()) {

        // Read the next line and act if it contains 'windriver'
        std::string line;
        std::getline(ifs, line);
        if (line.find("windriver") != std::string::npos) {

            // Extract the IRQ number and use it to build the needed
            // '/proc/irq/<num>/smp_affinity_list' path
            std::string irqNum = line.substr(0, line.find(":"));
            boost::trim(irqNum);
            std::string irq_file = "/proc/irq/" + irqNum + "/smp_affinity_list";

            // Get current smp_affinity_list for the IRQ
            std::ifstream ifs2(irq_file.c_str());
            if (ifs2.fail()) {
                std::cout << "Failed to open " << irq_file << std::endl;
                exit(1);
            }
            std::getline(ifs2, line);
            ifs2.close();

            // If the affinity is different from what we want, change it now
            if (line != cpu_list)
            {
                std::cout << "Moving IRQ " << irqNum << " from cpu_list '" <<
                             line << "' to cpu_list '" << cpu_list << "'" <<
                             std::endl;

                std::ofstream ofs(irq_file.c_str());
                if (ofs.fail()) {
                    std::cout << "Failed to open " << irq_file << " for write. Are you root?\n";
                    exit(1);
                }

                // Write the new smp_affinity_list
                ofs << cpu_list << std::endl;
                ofs.close();
            }
        }
    }

    ifs.close();
    exit(0);
}
