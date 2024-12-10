/* send a byte to the parallel port */

#include <sys/io.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
        int c = atoi(argv[1]);
        ioperm(0x378,1,1);
        outb(c,0x378);
        return 0;
}
