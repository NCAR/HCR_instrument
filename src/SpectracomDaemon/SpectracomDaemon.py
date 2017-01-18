#!/usr/bin/env python

'''@package SpectracomDaemon
A daemon program which periodically collects status information from a 
Spectracom SecureSync time and frequency server and supports an XML-RPC 
interface to provide access to the status information.
'''

import os
import re
import signal
import socket
import sys
import time

import logging
logging.basicConfig(level=logging.INFO, 
                    format='%(asctime)s %(levelname)s:%(name)s:%(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S')
_logger = logging.getLogger(os.path.basename(sys.argv[0]))

# Return the string contents of the given file, stripped of C++ comments
def removeCplusplusComments(filename):
    # regex for C++ comments
    pattern = re.compile(
        r'//.*?$|/\*.*?\*/|\'(?:\\.|[^\\\'])*\'|"(?:\\.|[^\\"])*"',
        re.DOTALL | re.MULTILINE
    )

    def replacer(match):
        s = match.group(0)
        if s.startswith('/'):
            return " " # note: a space and not an empty string
        else:
            return s

    f = open(filename, "r")
    return re.sub(pattern, replacer, f.read())

# Read ../HcrPortNumbers.h and parse out the port number we should use for
# our XML-RPC service
def getDaemonXmlRpcPort():
    '''Parse and return the SPECTRACOMDAEMON_PORT value from 
       <scriptDir>/../HcrPortNumbers.h.
    '''
    # Read the contents of "<SpectracomDaemonDir>/../HcrPortNumbers.h"
    headerDir = os.path.abspath(os.path.join(os.path.dirname(sys.argv[0]), '..'))
    portNumbersHeader = os.path.join(headerDir, 'HcrPortNumbers.h')
    try:
        text = open(portNumbersHeader, "r").read()
    except IOError as e:
        _logger.error("Failed to open or read %s, which provides our port number"
                     % (portNumbersHeader))
        sys.exit(2)


    # Remove C++ comments from the text
    commentRegex = re.compile(
        r'//.*?$|/\*.*?\*/|\'(?:\\.|[^\\\'])*\'|"(?:\\.|[^\\"])*"',
        re.DOTALL | re.MULTILINE
    )

    def commentReplacer(match):
        s = match.group(0)
        if s.startswith('/'):
            return " " # note: a space and not an empty string
        else:
            return s

    text = re.sub(commentRegex, commentReplacer, text)


    # Replace newlines in the text with spaces
    text = text.replace("\n", " ")

    # Find "SPECTRACOMDAEMON_PORT = <portnum>" in the text, and return our
    # port number
    match = re.match(".*SPECTRACOMDAEMON_PORT\s*=\s*([0-9]+)", text)
    portNum = int(match.group(1))
    _logger.info("Parsed SPECTRACOMDAEMON_PORT=%d" % (portNum))
    _logger.info("from header %s" % (portNumbersHeader))
    return int(match.group(1))

import subprocess

# Identifiers and start time for procmap registration
_procname = 'SpectracomDaemon'
_procInstance = 'ops'
_procStartTime = int(time.time())
_procmapTimer = None

def procmapRegister():
    '''Initiate a 30-second loop to regularly register with procmap
       @param procname the process name to use when registering
       @param instance the instance name to use when registering
    '''
    cmd = ['procmap_register', '-name', _procname, '-instance', _procInstance,
           '-start', str(_procStartTime)]
    try:
        subprocess.check_call(cmd)
    except subprocess.CalledProcessError as e:
        _logger.error('Error calling procmap_register: %s' % (e))
        
    # call back here again in 30 seconds
    global _procmapTimer
    _procmapTimer = threading.Timer(30, procmapRegister)
    _procmapTimer.start()

def procmapUnregister():
    global _procmapTimer
    if _procmapTimer:
        _procmapTimer.cancel()

    cmd = ['procmap_unregister', '-name', _procname, '-instance', _procInstance]
    try:
        subprocess.check_call(cmd)
    except subprocess.CalledProcessError as e:
        _logger.error('Error calling procmap_register: %s' % (e))




if __name__ == '__main__':
    import signal
    import threading
    from SimpleXMLRPCServer import *
    from StatusCollector import StatusCollector

    _logger.info('================================')
    _logger.info('Started %s' % (_procStartTime))

    stopping = False

    # Set up signal handling to stop our XML-RPC server on receipt of
    # SIGINT (^C) or SIGTERM (from a 'kill' command).
    def sigHandler(signum, frame):
        _logger.info('Received signal %d. Halting XML-RPC service.' % (signum))
        global stopping
        stopping = True
        serverXMLRPC.server_close()
        
    signal.signal(signal.SIGINT, sigHandler)
    signal.signal(signal.SIGTERM, sigHandler)

    # getStatus() XML-RPC method
    def getStatus():
        '''Handle XML-RPC 'getStatus' requests, returning current Spectracom status.
        '''
        # XML-RPC needs a simple dictionary, so reinterpret
        # collector.getLatestStatus() as a plain dict
        return dict(collector.getLatestStatus())

    # Create our XML-RPC server
    try:
        serverXMLRPC = SimpleXMLRPCServer(('0.0.0.0', getDaemonXmlRpcPort()),
                                          SimpleXMLRPCRequestHandler,
                                          logRequests = False)
    except socket.error as e:
        _logger.error('Exiting on error creating XML-RPC server: %s' % (e))
        sys.exit(1)

    serverXMLRPC.register_introspection_functions()
    serverXMLRPC.register_function(getStatus)

    # Initiate regular registration with procmap
    procmapRegister()

    # Method to handle failure of our StatusCollector
    def onStatusCollectorFailure():
        '''Callback which handles StatusCollector failure
        '''
        _logger.error('StatusCollector has died. Exiting program.')
        # Stop the XML-RPC server to exit serve_forever
        global stopping
        stopping = True
        serverXMLRPC.server_close()

    # Instantiate the StatusCollector and start the XML-RPC server
    try:
        # Create our StatusCollector which talks to the Spectracom
        collector = StatusCollector('timeserver', '/data/hcr/spectracom_log',
                                    onStatusCollectorFailure)
        # The main thread is devoted to just running the XML-RPC server. This
        # will finish when a SIGINT is received (i.e., via ^C) or a SIGTERM
        # is received (e.g., via a 'kill' command).
        serverXMLRPC.serve_forever()
    except socket.error as e:
        # Ignore socket.error if we're stopping the server, otherwise
        # complain and exit
        if (not stopping):
            _logger.error('Exiting on XML-RPC server socket error: %s' % (e))
            serverXMLRPC.server_close()

    # Perform a clean shutdown of the XML-RPC server
    serverXMLRPC.shutdown()
    
    # Unregister with procmap
    procmapUnregister()

    _logger.info('Finished ' + time.asctime())
