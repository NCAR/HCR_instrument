#!/usr/bin/env python

'''@package SpectracomDaemon
A daemon program which periodically collects status information from a 
Spectracom SecureSync time and frequency server and supports an XML-RPC 
interface to provide access to the status information.
'''


import logging
logging.basicConfig(level=logging.INFO, 
                    format='%(asctime)-15s %(levelname)s:%(name)s:%(message)s')

import sys
import os
logger = logging.getLogger(os.path.basename(sys.argv[0]))

XMLRPC_PORT = 8005

def getStatus():
    '''Handle XML-RPC 'getStatus' requests, returning current Spectracom status.
    '''
    logger.info('In XML-RPC getStatus() method')
    # XML-RPC needs a simple dictionary, so reinterpret
    # collector.getLatestStatus() as a plain dict
    return dict(collector.getLatestStatus())

# Create our XML-RPC server
from SimpleXMLRPCServer import SimpleXMLRPCServer

SimpleXMLRPCServer.allow_reuse_address = True
serverXMLRPC = SimpleXMLRPCServer(('0.0.0.0', XMLRPC_PORT))
serverXMLRPC.register_introspection_functions()
serverXMLRPC.register_function(getStatus)
       
def onStatusCollectorFailure():
    '''Callback which handles StatusCollector failure
    '''
    logger.error("StatusCollector has died. Exiting program.")
    # Stop the XML-RPC server to exit our main loop
    serverXMLRPC.shutdown()

# Create our StatusCollector which talks to the Spectracom
from StatusCollector import StatusCollector
collector = StatusCollector('timeserver', '/home/burghart/spectracom_log',
                            onStatusCollectorFailure)


if __name__ == '__main__':
    import sys
    import time
    logger.info('Started ' + time.asctime())
    
    try:
        # The main thread is devoted to just running the XML-RPC server
        serverXMLRPC.serve_forever()
    except KeyboardInterrupt:
        print
        print 'exiting on SIGINT'
        
    # Perform a clean shutdown of the XML-RPC server
    serverXMLRPC.shutdown()
    
    logger.info('Finished ' + time.asctime())

