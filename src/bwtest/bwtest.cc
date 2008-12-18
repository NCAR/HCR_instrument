#include <iomanip>
#include <iostream>
#include <string>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <stdio.h>
#include <math.h>
#include "ptkdrv.h"
#include "ptkddr.h"
#include <sched.h>
#include <sys/timeb.h>

#define BASICSIZE   1024

using namespace std;

///////////////////////////////////////////////////////////
int
createOutputFile(int curFd, std::string name)
{

  if (curFd > -1)
    close(curFd);

  int fd = open(name.c_str(), O_WRONLY | O_CREAT | O_TRUNC, 0666);

  if (fd < 0) {
    std::cerr << "cannot access " << name << "\n";
    perror("");
    exit(1);
  }

  return fd;
}

///////////////////////////////////////////////////////////
int overUnderCount(int deviceFd, std::string& device) {

  int count = ioctl(deviceFd, FIOGETOVRCNT);
  if (count == -1)
  {
    std::cout << "unable to get ovr/under for "
  	<< device << std::endl;
    perror("");
  }

  // clear the overrun counter
  if (ioctl(deviceFd, FIOCLROVRCNT) == -1)
  {
    std::cout << "unable to clear ovr/under for "
  	<< device << std::endl;
    perror("");
  }

  return count;
}

///////////////////////////////////////////////////////////
void
configurePentek(int deviceFd,
		std::string device)
{

  // set the clock source
  int clockSource;

  //  clockSource = CLK_SRC_FRTPAN;
  clockSource = CLK_SRC_INTERN;

  if (ioctl(deviceFd, FIOCLKSRCSET, clockSource) == -1)
    {
      std::cout << "unable to set the clock source for "
		<< device << std::endl;
      perror("");
      exit(1);
    }

  // set the clock sample rate
  double doublearg = 100.0e6;
  if (ioctl(deviceFd, FIOSAMPRATESET, &doublearg) == -1) {
    std::cout << "unable to set the clock rate for "
	      << device << std::endl;
    perror("");
    exit(1);
  }

  // flush the device read buffers
  if (ioctl(deviceFd, FIOFLUSH, 0) == -1)
    {
      std::cout << "unable to flush for "
		<< device << std::endl;
      perror("");
      exit(1);
    }

  // clear the overrun counter
  overUnderCount(deviceFd, device);

}

///////////////////////////////////////////////////////////
void
makeRealTime()
{


  uid_t id = getuid();

  // don't even try if we are not root.
  if (id != 0) {
    std::cerr << "Not root, unable to change scheduling priority" << std::endl;
    return;
  }

  sched_param sparam;
  sparam.sched_priority = 50;

  if (sched_setscheduler(0, SCHED_RR, &sparam)) {
    std::cerr << "warning, unable to set scheduler parameters: ";
    perror("");
    std::cerr << "\n";
  }
}

///////////////////////////////////////////////////////////
double nowTime()
{
  struct timeb timeB;

  ftime(&timeB);

  return timeB.time + timeB.millitm/1000.0;

}

///////////////////////////////////////////////////////////
int
main(int argc, char** argv)
{

  std::string device;
  std::string outFile;
  int deviceFd;
  int outFd = -1;
  double startTime;
  int bufferSize;
  char* buf;

  if (argc < 4) {
    std::cout << "usage: " << argv[0]
	      << " <channel device> <buffer factor> <output file>\n";
    exit (1);
  }

  device = argv[1];
  bufferSize = BASICSIZE*atoi(argv[2]);
  outFile = argv[3];

  std::cout << "read buffer size is " << bufferSize << std::endl;

  buf = new char[bufferSize];

  outFd = createOutputFile(outFd, outFile);

  makeRealTime();

  deviceFd = open(device.c_str(), O_RDWR, 0);

  if (deviceFd < 0) {
    std::cerr << "cannot access " << device << "\n";
    perror("");
    exit(1);
  }

  // configure the downconversion channel
  configurePentek(deviceFd, device);

  int loopCount = 0;
  double total = 0;

  startTime = nowTime();

  int lastMb = 0;

  while (1) {
    int n = read(deviceFd, buf, bufferSize);
    if (n <= 0) {
      std::cerr << "read returned " << n << " ";
      if (n < 0)
	perror("");
      std::cerr << "\n";
    } else {
      write(outFd, buf, n);
      total += n;
      loopCount++;
      int mb = (int)(total/1.0e6);
      if ((mb % 100) == 0 && mb > lastMb) {
	lastMb = mb;
	double elapsed = nowTime() - startTime;
	double bw = (total/elapsed)/1.0e6;

	int overruns = overUnderCount(deviceFd, device);

	std::cout << "total " << std::setw(5) << mb << " MB,  BW "
		  << std::setprecision(4) << std::setw(5) << bw
		  << " MB/s, overruns: "
		  << overruns << "\n";
      }


    }
    if (total > 2.0e9)
      break;
  }
}

