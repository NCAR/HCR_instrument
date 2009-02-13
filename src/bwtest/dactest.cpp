#include <iomanip>
#include <iostream>
#include <string>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <stdio.h>
#include <math.h>
#include <sched.h>
#include <sys/timeb.h>

#include "p7142hcr.h"

#define BASICSIZE   1024

using namespace std;

///////////////////////////////////////////////////////////
int main(int argc, char** argv) {

	if (argc < 5) {
		std::cout << "usage: " << argv[0]
				<< " <device root> <up converter name (e.g. 0C)> <sample rate Mhz> <nco frequency Mhz>\n";
		exit(1);
	}

	std::string devRoot = argv[1];
	std::string upName = argv[2];
	double sampleRate = atof(argv[3])*1.0e6;
	double ncoFreq = atof(argv[4])*1.0e6;
	// create the upconvertor
	Pentek::p7142up upConverter(devRoot, upName, sampleRate, ncoFreq);

	if (!upConverter.ok()) {
		std::cerr << "cannot access " << devRoot << ", " << upName << "\n";
		exit(1);
	}

	// create the signal
	short IQ[1000];
	for (unsigned int i = 0; i < sizeof(IQ); i += 2) {
		IQ[i] = 1000;
		IQ[i+1] = 0;
	}
	
	// load mem2
	upConverter.write(IQ, sizeof(IQ));
	
	// start the upconverter
	upConverter.startDAC();
	
	while (1) {
		std::cout << ".";
		std::cout << std::cout.flush();
		sleep(1);
	}
	
}

