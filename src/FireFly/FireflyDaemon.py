#!/usr/bin/env python
import select
import serial
import time

FIREFLY_PROMPT = "scpi >"
FIREFLY_CMD_ERROR = "Command Error"
port = serial.Serial(port="/dev/ttyS2", baudrate=115200, timeout=0)

def readLine():
    rlist, wlist, xlist = select.select([port.fileno()], [], [], 1.0)
    if not rlist:
        raise 'SELECT TIMED OUT'
        
    # Set a short(ish) timeout to wait for a line. They should come pretty
    # quickly. Also, the final line (the prompt) does not have a newline, so
    # we won't get it *until* readline() times out.
    old_timeout = port.timeout
    port.timeout = 0.015
    
    # Get the next line
    line = port.readline()
    
    # reset the old timeout
    port.timeout = old_timeout
    return(line)

def execCmd(cmd):
    port.write(cmd + '\r\n')
    line = readLine().rstrip()
    # First line of response should just be an echo of the command we sent
    if (line != cmd):
        raise Exception('Bad echo "%s" for command "%s"' % (line, cmd))

    reply = []
    while (True):
        line = readLine().rstrip()
#        print 'got line %s' % (line)
        if (line == FIREFLY_CMD_ERROR):
            print 'execCmd("%s") returning on command error' % (cmd)
            return(reply)
        elif (line == FIREFLY_PROMPT):
            break
        else:
            reply.append(line)
            
    return(reply)
        
        
execCmd('')

reply = execCmd('GPS?')
for line in reply:
    print line
    
execCmd('BLAH')
print

reply = execCmd('SYNC?')
for line in reply:
    print line
    
#port.write('\r\n')
#print "newline", readLine(port),
#
##port.write('SYST:COMM:SER:ECHO OFF\r\n')
##print "echo off", readLine(port),
##
##port.write('SYST:COMM:SER:PRO OFF\r\n')
##print "pro off", readLine(port),
#
#port.write('GPS?\r\n')
#for i in range(0, 15):
#    print readLine(port),
#
##port.write('SYST:COMM:SER:PRO ON\r\n')
##print "pro on", readLine(port),
##
##port.write('SYST:COMM:SER:ECHO ON\r\n')
##print "echo on", readLine(port),
port.close()

